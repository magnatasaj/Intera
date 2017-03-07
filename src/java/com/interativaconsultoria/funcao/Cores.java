/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.funcao;

import java.awt.Color;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 *
 * @author Lamara
 */
public  class Cores {

    
   private Color gerarCorAleatoriamente(){
		Random randColor = new Random();  
		int r = randColor.nextInt(256);
		int g = randColor.nextInt(256);
		int b = randColor.nextInt(256);
		return new Color(r, g, b);
	}

	/**
	 * MÃ©todo que exporta a cor para o formato hexadecimal. 
	 * @param color Representa a cor.
	 * @return Retorna a cor no formato hexadecimal.
	 */
	private String gerarCorHexadecimal(Color color){
		return '#'+
			this.tratarHexString(Integer.toHexString(color.getRed()))+
			this.tratarHexString(Integer.toHexString(color.getGreen()))+
			this.tratarHexString(Integer.toHexString(color.getBlue()));
	}

	/**
	 * MÃ©todo responsÃ¡vel por tratar a string hexadecimal. Caso a string possua tamanho 1, o mÃ©todo adiciona o nÃºmero 0 na frente da string.
	 * @param hexString A string hexadecimal
	 * @return A string hexadecimal
	 */
	private String tratarHexString(String hexString){
		String hex = null;
		if(hexString.length() == 1){
			hex = '0'+hexString;
		}else{
			hex = hexString;
		}
		return hex;
	}

	/**
	 * MÃ©todo que trata o brilho de uma cor. 
	 * Para que uma cor seja escolhida para o grÃ¡fico seu nÃ­vel de brilho deve estar acima ou igual de 0.5 e abaixo ou igual de 0.9.
	 * @param brightness Representa o brilho.
	 * @return Retorna true caso a cor esteja de acordo com o ponto necessÃ¡rio (brilho), false caso contrÃ¡rio.
	 */
	private boolean isBrilhoCorreto(float brightness){
		if (brightness >= 0.5 && brightness <= 0.9) {
			return true;
		}
		return false;
	}
	
	/**
	 * MÃ©todo que trata a saturaÃ§Ã£o de uma cor. 
	 * Para que uma cor seja escolhida para o grÃ¡fico seu nÃ­vel de saturaÃ§Ã£o deve estar acima ou igual de 0.7.
	 * @param saturation Representa a saturaÃ§Ã£o
	 * @return Retorna true caso a cor esteja de acordo com o ponto necessÃ¡rio (saturaÃ§Ã£o), false caso contrÃ¡rio.
	 */
	private boolean isSaturacaoCorreta(float saturation){
		if (saturation >= 0.7){
			return true;
		}
		return false;
	}

	/**
	 * MÃ©todo que realiza a carga inicial de cores proibidas.
	 * @param coresProibidas Representa a lista de cores proibidas.
	 */
	private void carregarCoresProibidasDefault(List<Color> coresProibidas){
		coresProibidas.add(new Color(0,0,0)); //preto
		coresProibidas.add(new Color(255,255,255)); //branco
	}

	/**
	 * MÃ©todo que calcula a distÃ¢ncia entre cores.
	 * @param cor1 Representa uma cor.
	 * @param cor2 Representa uma cor.
	 * @return Retorna a distÃ¢ncia.
	 */
	private double calcularDistanciaDeCores(Color cor1, Color cor2){
		long meanRed = (cor1.getRed() + cor2.getRed())/2;
		long deltaRed = cor1.getRed() - cor2.getRed();
		long deltaGreen = cor1.getGreen() - cor2.getGreen();
		long deltaBlue = cor1.getBlue() - cor2.getBlue();
		return Math.sqrt((2+meanRed/256)*Math.pow(deltaRed, 2)+4*Math.pow(deltaGreen, 2)+(2+(255-meanRed)/256)*Math.pow(deltaBlue, 2));
	}
	
	/**
	 * MÃ©todo que avalia se a distÃ¢ncia entre duas Ã© aceitÃ¡vel. Uma distÃ¢ncia Ã© dita aceita se Ã© menor que 200. 
	 * @param cor1 Representa uma cor.
	 * @param cor2 Representa uma cor. 
	 * @return boolean Retorna true caso a distÃ¢ncia seja menor que 200, false caso contrÃ¡rio.
	 */
	private boolean isDistanciaAceitavel(Color cor1, Color cor2){
		if (this.calcularDistanciaDeCores(cor1, cor2) < 200) {
			return false;
		}
		return true;
	}
	
	/**
	 * MÃ©todo que valida se uma cor gerada aleatoriamente possui uma distÃ¢ncia aceitÃ¡vel com as cores previamente permitidas. 
	 * @param coresPermitidas Representa as cores permitidas.
	 * @param corAleatoria Representa a cor gerada aleatoriamente.
	 * @return Retorna true caso a cor seja parecida, retorna false caso contrÃ¡rio.
	 */
	private boolean isCorParecidaComCorPermitida(List<Color> coresPermitidas, Color corAleatoria){
		boolean isCorParecida = false;
		for (Color corPermitida : coresPermitidas) {
			if(!this.isDistanciaAceitavel(corPermitida, corAleatoria)){
				isCorParecida = true;
				break;
			}
		}
		return isCorParecida;
	}

	/**
	 * MÃ©todo responsÃ¡vel por gerar cores aleatoriamente no formato RGB seguindo os padrÃµes de qualidade especificados.
	 * @param qtdDeCores Representa a quantidade de cores que deseja-se gerar.
	 * @return List<Color> Representa a lista de cores permitidas em formato RGB.
	 */
	public List<Color> gerarCores(int qtdDeCores){
		List<Color> coresPermitidas = new ArrayList<Color>();		
		List<Color> coresProibidas = new ArrayList<Color>();
		this.carregarCoresProibidasDefault(coresProibidas);
		
		Color corAleatoria = null;
		boolean isCorProibida = false;
		for(int i=0; i<qtdDeCores; i++){
			while(true){
				corAleatoria = this.gerarCorAleatoriamente();
				float[] hsb = Color.RGBtoHSB(corAleatoria.getRed(), corAleatoria.getGreen(), corAleatoria.getBlue(), null);
				float saturation = hsb[1];
				float brightness = hsb[2];
				for(Color corProibida : coresProibidas){
					isCorProibida = corProibida.equals(corAleatoria) 
									|| !this.isBrilhoCorreto(brightness) 
									|| !this.isSaturacaoCorreta(saturation)
									|| !this.isDistanciaAceitavel(corAleatoria, corProibida) 
									|| this.isCorParecidaComCorPermitida(coresPermitidas, corAleatoria);
					if(isCorProibida){
						coresProibidas.add(corProibida);
						break;
					}
				}
				if(isCorProibida){
					isCorProibida = false;
					continue;
				}
				break;
			}
			coresProibidas.clear();
			coresPermitidas.add(corAleatoria);
		}
				
		return coresPermitidas;
	}

	/**
	 * MÃ©todo responsÃ¡vel por gerar cores aleatoriamente no formato hexadecimal seguindo os padrÃµes de qualidade especificados.
	 * @param qtdDeCores Representa a quantidade de cores que deseja-se gerar.
	 * @return List<String> Representa a lista de cores permitidas em formato hexadecimal.
	 */
	public List<String> gerarCoresHexadecimal(int qtdDeCores){		
		List<Color> coresPermitidas = this.gerarCores(qtdDeCores);		
		return this.gerarCoresHexadecimal(coresPermitidas);
	}

	/**
	 * MÃ©todo responsÃ¡vel por gerar cores aleatoriamente no formato hexadecimal seguindo os padrÃµes de qualidade especificados.
	 * @param coresPermitidas Representa cores aleatorias jÃ¡ selecionadas previamente.
	 * @return List<String> Representa a lista de cores permitidas em formato hexadecimal.
	 */
	public List<String> gerarCoresHexadecimal(List<Color> coresPermitidas){
		List<String> coresPermitidasHexadecimal = new ArrayList<String>();		
		for(Color corPermitida : coresPermitidas){
			coresPermitidasHexadecimal.add(this.gerarCorHexadecimal(corPermitida));
		}		
		return coresPermitidasHexadecimal;
	}

}
