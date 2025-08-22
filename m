Return-Path: <linux-btrfs+bounces-16273-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAACB31557
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 12:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E026E60405F
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 10:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAEE2E92CF;
	Fri, 22 Aug 2025 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sq76S57t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D2D2C11CA;
	Fri, 22 Aug 2025 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858251; cv=none; b=WSF09vzNmrLwCrhCUU74kuwffOneIlaTKwc3YovMBntKMmFskRh3vXCl2n9y5eWJQ4U84TJhQxO/2iqOPytZUalwO3FQ8QS3meCOrzcO6xjT17iLQtm42fCJj0NbguFrpKLHqPCUZ/xGR9IH6VxlgMlqll/0cZk+ux/GhL2qLj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858251; c=relaxed/simple;
	bh=gvaoPdasCduMEfLHA0ocYPNoC9nsFsRZKFTfPs/e4GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XeltgQy8VB1vViwU9HUo32/1rIGwo+X+LQrLj1NbeShPt6Z5qHSfm8jWmjginAoqVvkLsZ5RZEwZVKz7ogtZA+3Rbw2SIUYxSHVzKhNMMfcV5VbBkL580bQ41mDmPZT2S2fyMUFBHwmpOttINkqcjcp5wHRMdWarUT2zuAzz67Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sq76S57t; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1755858245; x=1756463045; i=quwenruo.btrfs@gmx.com;
	bh=2of9iBWA4Ok9oXBHt0I9OhI5N9I87fMvrb+C3Z/jkUA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sq76S57tQ93t2QUkBtZ8/Cnqop/RTEVlK/dW5sbA1RHYieRLVEAtf3W9dAag58ww
	 tzBEaIbbC0JwrlgyyHuhpYOGJvShKniUDzfgCrwMDOBXmWF+qhA1ysY0M7hVSbNbz
	 nE7bwrMm2E0rct06xtMQ5RhWeZ9B+spo9Hz/Jq9Sm8ehg0I+M7RjkW3dEhBKkNeUj
	 B9i1mmthVZ4EgnsP5Z0TSWxtGSvr1WptJVRKIOKDm7pMT+xSHXnR1a+8PNuZtBvhT
	 OKsodJ3RRkWPwZEZQrj6QLt3lLN8dLswtqzReXv6LdpVU8ZnEqzLijvpC14uO4WLB
	 vaBbNZ8EsE9gm0b5yA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFKGP-1uj8UX2yM5-00486C; Fri, 22
 Aug 2025 12:24:05 +0200
Message-ID: <810d2b19-47ed-4902-bd8d-eb69bacbf0c6@gmx.com>
Date: Fri, 22 Aug 2025 19:53:59 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
To: Sun YangKai <sunk67188@gmail.com>, calvin@wbinvd.org
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, neelx@suse.com
References: <2022221.PYKUYFuaPT@saltykitkat>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <2022221.PYKUYFuaPT@saltykitkat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LnM52Icgqn/9Mmxf4D9hPC+sAj6XBgcEPINbLMFFi3fuuyg2pYS
 m0zlG0lwyO+1tsCy5MrP9k6zW+8l/mrk38JvPnen7D58sZG2aPv3jf/caQZ/GtWaPEf8qEw
 vvsuyzvQAtwpKNokzVCV3nylUMBXwKs+ZJ9JBeyMQVHsiiGFeoL0xtE5nea/sH4WdfgLIDO
 ezoB6Ph3CqE3eL8Q90m9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:t+XSAiCyx/w=;cXGV4k8p8d7uB6NRFa0pXL4BZZe
 ypo6okNVSWdDldTshU4WrtEx0bMgee7DgnZe6CL1HJsNZpzvd17cGjCisxcRAsncPJJ2/n8Mn
 54ySPapbIwzTuAQreT44+v+HRrqj2bbyN+f83T3N5VaKim4lF/McNqW7DoIVwp7hBiZ8yJeXD
 bjzkLXBCayb0oYSTPxmv915LWv2lnWdBr+MaB/F/mVBxYdD0wRaL1i2DU3PALMY1E2dOgRezF
 yO3sNWMKJBfzpCEi9EMrnMUiajGQ7fe02L7k8Dem1jt5srTM3YW9MHhHZfbGDkj2rE8fDV1ai
 FYdmbs9ZBIYLx3VY1xFL8ORSX7yRI/r8H1C3HHFQb2yR3eap3VvXQtNSL9gpgQMNW1tpw7aLk
 cqI3oxNjECRywYuRw4lSVLUlFwESS8GcLP9h1DWPcya+WxbByOLqgEicV7M8oSbq3U7dktq8m
 I8iI6OixQ3P5O8feGDRgSbv/mx9P/ZKGe+1LR/hz5O/DEBIu7MeokssM5S3oL2ot/Ln6pX+W/
 f/WVb/8FB3X+3r7Ttc6mZ+dVAOMQQo6evk+7xUCY6V3raaMmHN7D6V/0weTE0UfDH8jB4bDdY
 TZnYmv++HJ/BTrhgHo8l/VzlLhpLP/sLFM7tVPtX8Dp+YyXmArS+SZPeKItjFBd6CSg13zBN9
 7LqbDcWiq/i1MH59UU199xA9+WVsrKMhExL0rN3jnqFEzflt+jHnWPExtRB9e54b7nrCE4zEY
 NFamCPotuGyZtN67x2jWCq5zLi631txgcBUeKV1EseiTzusA4QnUJ4HAnmxqXKyuow0Suwstw
 kJ11p3wboIUwoTzZvvK5eHpR+PeXbirNucPhW1mPRCJ61+49iAWvtfC+JXcdRwH8+Qq8ubjUx
 HA+5eu0v45a8aM05KMRbHWOEUQ8haJH4/MlLnV0nuwOZ8uH4Ezt6WyiuUQg1Q2hhNGNjZehpC
 FmW41tl/rXpzUdXQXWA361XRcmJ6cNUM1hKc5yWlctpQV8a2adFc/klku8qhOalHPPxKvg6WL
 qwqxpSeGqYqvMpQ429kfyRyP6Uk1GOdT60xcZoqHdYxmU9IcoYWBCnBpSCSkjuvTuHxxjqxSw
 zlutmS2TNmCytl5UDud16aaGtjvx8apHgBdObgACyuKIVrGgoefwEFyVQaxd8XZ+9s5xPFq/s
 L3AgYM3+o//S4l3HbJgujPh7BOPZeaDo5dfpZrcVDroLVztJOuc1qbp3KsntZPpbQkvSwdHgh
 BvGehBAmWHEgSGICWOv5+73Z6rnBTo5fL8tupGp2LFjmdWs9fv6ymz5h4i1Df0magMEwuc5tX
 Q74E/Kd0zIOp6c/DbtEqL8eDE9PM04qg5HHb152FokFKiUw66nab0rOfGrSHHgV4GYCJ6wNhz
 Me6tQJbQFtG4J/ZhUSSJXT9/I5dJFdAg5slk/unGiki8g4GUQyHqFho29+52ndDKVjvrinUGy
 bhNZx8+afAWPDw06g8NRZOg6wcHriyijzTuGVjRmE+jvYYONiB8L6DB0z6Z1mfd+/QnT6ocPx
 QcfIT+0lnX/NNNBEhyTmPx/U9tEG8wKZ6HdjDlO20Zpo29lsW2/fY8smmguiDRRK2yHjUfk49
 YN61AOeKQFhWaozcIuGY6oG5P+8GBv3SyFFzaFuwH4yn8xXwlZ0JhiZgdBwl6FbalmxfO51nN
 DXtgaeoGhbKk+jaK1rj5imIcpm5DJRSwPlWBGsaDAsT6n2TYEkdxXqyyKbt5LBlLuVwyqJj2p
 jcXyad8ysghts63s+2CecAgN5CUYc/jnXzG6xo8h7SDfSiSKKwtd21pHYGyaxrZ8JdFBWwAcm
 1tJqULVlry6cAJkPOKOywq+m0n8UdrAd+MQ403uSlGsbXLjxRdlt8YWGDFdwvMXDdFEWhXkiq
 BbN6NZzOu9NYf/Xya8Fytpg+J3KknXte0eGaVO5AB9dsJkIricLaLYaq0szoJR6I5xwoQiW79
 ipwf6GON1URQVKSdqYqKgBXiVUGiirSBGKOGatqx1+7BG3yUsaQCwvBQz746eAM5fi6V4a56X
 EpWwsZkqKPamnDP0rYsK17GU/KQyiAlUQXzmZykzpCEUPyHJw3auQRlgdNK43VaMGiiF9i1wC
 1kmTACvYXIQu0/JM13wRRPGcwfAyyMWIj0PmBaLH+Z8FVsH4ca0etPQJpOfVjBhNNKGCF2AvG
 BO+TRE20zIPRrBINRN+5dS7MXTzVUxv5A6HFBCsTIKduBZCGEVFDSk1J6AxggO0zm20RD89dk
 YqhWS/QACbbWrUzA+FWXGv57jM7ge5P/TkC+gm8X60koUKKiw3Uew57t0/j3izxfyet8CJ4E9
 5cb6j7EVFr6CP4Lg3ND4GUOa30y/eXrg18B12mGv2IqoqHZvH2aThPFM93J+DvlsR1m6pocHs
 jKTj6rNlzOgDy8RBkMVCL9XMcMKCmrBJnZ7RqDXrbAcLPVemmZbw87IkBJxih9muyu8WctnzL
 AZ2rTbdCeVDAYKm3cwpvMbDr47smixx9VLW6p+Xhx4uop0AUF3Zk+KhbImXSkc9bPhZNMM6Ya
 mR7oeZajG+b+AhwsDtT2Bfxq+QlYMRqYXeZM4lcLcgrbakxsKJRiaJ9Ps9o84bY35zXEO7DSB
 extjLWLCcSasgE/CaVi2AREpciGucaP2eJ+i61Qd5n3EQnCZOWDrlujsSheoSZs27U21GDo7n
 sSes3eicQ6WuT6DwJoKnLarerHH5vsUBFHv/0Ar7pp2vGS6pIt2t1c6TeAMq8zazAU4UEvK28
 TIeENeK3Gp9uKsKT9S0JeCnYJVL0KofpdAVLSOjs/3FnZu7YP1LXwyrKGbxQFDLKLByIVEJ/4
 BI8WG1Xp7jim+5ocXwhEvu1g+lc5WIH8ONkPuQLmXhfB3a8bz+mvGxvw+CTs4GOIVa27VGgBy
 UiFxHqvCqfO5k6n+NObjGpTr8Zrg1bYyvv45kbjSp4WDmd+ynWABfkovP9PCf53iasH3/qxTG
 iVSbKcQES8G0Ghq3mNC6dDPXw0UqkOXcU8g8r8gSdrkG+BF+9EKqURXbV6x9V6Ft2ohuxDbIS
 8y4TSguLE3P0I/RCisE2uWqZJdjwLJ7/1+7Z65RwZiR/9Cnt4eKCtM/oxxBctPao4+Auk/2u/
 SWsJp2P00JHGVclpGxvl9KO+Fk/6dlcj6Q+2nQCaYkIRITjiWcTEIqAdq5VVnJJWhW6o/0jrY
 OTCaEyCRI5U/yAvpDOqubGBr00/iDsjlc5L58aDyKT4OZL4U+1w7OXuOQIj2F4tyo0HxO6eOR
 hA7VNuxfv20nEO6plTQd9VKlL8us7BlpFYfYTlHXIzoDwbwo1mTNtwgm0LPUFaZ3Buz5e8538
 WlJX+F9cyDS64F5yaZOED8gB38LY48v8PKMbpdF3Z7ecKxJe0xTnKAPBtu96tcrRImYGzYPeL
 QoUzMUcfQ/IQCrOTWvczDKL2XLn8iZ6AaJOeNWm28wm/xQQRkOAZRPmmddXJ1tyZJdj6R9Eux
 g9nLHEYdOffokoV4HFuJdJp3HDncaJWo7RritXIV5krlEbh13L1jykrdVrEtfmF1Puo4XZ5A0
 7Z0ivSUkV5adBxZVBmMwHijR5WXKksQJ1mxG9onTZGkt936tKHmHB1cMaIEqtA4WdHJvrV2T7
 dbT6zCV3Tm84COVZdrbBU9ogtuSyJuVt0hubHIEmijNMwpUAh/B0hWwXw6UBGTum2s5zUCKs+
 w+Zo4+JPGg9X4+ND1OMYrNSiVay499Bw+zm7iVSu/+5X6+SWKacaAZ+dgn7/bry1H9Jvug5xi
 JEzLPFwazdf4z7JPMi2DiUBENBhTCyl+iDnm5L4oFxAo9hvQc5xVtQmLICTwn0IH5R42h+c5R
 B5RCr+EmuSaXQd+g2ZWktu/KNLa0lZFp0W8rPYSlPm4hcBXdt9enmT3ET+oyzpgK61fFz0XDA
 b/DsWHJS8Ii+iqKCeQLFhrPHT7Y79cMJMSVzEXYbuYNyV8rtkNCDMOY0r1cORyLFaTeJAdny5
 GGYgLkgEpco9RW3zvwpPX0+zuSU248DY9Um4qVP5IcsWqtedGiz9jZPlJwTGs7y0OYiYwiSZr
 g5orMYzRbc0IiIJskqvhn6Z21kJf7B/rdo0dd6LyoMS9ywignpgPnNZOg3e3LE2jRiZ5Nh4qu
 zEAO5ppxJoVCq2GhuiQts6GrKFtxYloDtRKmAgCMYTbXGM22BfhG/ntgnd5hlUnNzy9J73SJW
 mS60rpLg4i5KVYzcc0XrnUhAbhEXP3g+6mI9KspCcmMLT/kJTDyQrtdEVcYPIq8jJ0GomGcqQ
 Mi96fpP95CnX/GlnCc7hgDHKveaaQ2ffqYbtGTu3pgKJV6SSkYp+leyetOqPkFP/ZY77EHEbJ
 yWb+fHmI5KHGT0LunGhFeNF/CHjhBVfZWpZj9tFpOXvggi7vQm122XnXibb33fMxD1cRTntbq
 bbxb3gBUj2JCyEGnOOIyX+HJ9TBrZF28olYzs51NQUGnpllHKaegIIvjQBgjU0ZRz1VOtcWDf
 qiTGilCbOqyc0ckVaCdisxbi4hCwrJgeYk3gfd8ybedm1ElNXwWxLtG5F0MLIjcMz4/VlOLJZ
 Dwl/Q8vidtR2x51kV3RHeqss3lx4NWz9dBlfVspUYiWevp51cLAC7+GdKV1sOrmghKif1EiYy
 Ovui7etEzyjeC6GEa36HpsOrF33dxmnNVcKN4U36P7+Dvu3r2LVFYNvScfWATTIZMkVa0LJ6m
 HCnN66gZICuiIUJkZn1yYTU+epLRtZRyFDxle0u67TNhUGVlpw==



=E5=9C=A8 2025/8/22 19:50, Sun YangKai =E5=86=99=E9=81=93:
>> The compression level is meaningless for lzo, but before commit
>> 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
>> it was silently ignored if passed.
>>
>> After that commit, passing a level with lzo fails to mount:
>>      BTRFS error: unrecognized compression value lzo:1
>>
>> Restore the old behavior, in case any users were relying on it.
>>
>> Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount optio=
ns")
>> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
>> ---
>>
>>   fs/btrfs/super.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index a262b494a89f..7ee35038c7fb 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -299,7 +299,7 @@ static int btrfs_parse_compress(struct btrfs_fs_con=
text
>> *ctx,>
>>   		btrfs_set_opt(ctx->mount_opt, COMPRESS);
>>   		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
>>   		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
>>
>> -	} else if (btrfs_match_compress_type(string, "lzo", false)) {
>> +	} else if (btrfs_match_compress_type(string, "lzo", true)) {
>>
>>   		ctx->compress_type =3D BTRFS_COMPRESS_LZO;
>>   		ctx->compress_level =3D 0;
>>   		btrfs_set_opt(ctx->mount_opt, COMPRESS);
>>
>> --
>> 2.47.2
>=20
> A possible improvement would be to emit a warning in
> btrfs_match_compress_type() when @may_have_level is false but a
> level is still provided. And the warning message can be something like
> "Providing a compression level for {compression_type} is not supported, =
the
> level is ignored."
>=20
> This way:
> 1. users receive a clearer hint about what happened,

I'm fine with the extra warning, but I do not believe those kind of=20
users who provides incorrect mount option will really read the dmesg.

> 2. existing setups relying on this behavior continue to work,

Or let them fix the damn incorrect mount option.

I'm fine with warning, but the mount should still fail.
Or those people will never learn to read the doc.

> 3. the @may_have_level semantics remain consistent.
>=20
>=20


