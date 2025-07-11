Return-Path: <linux-btrfs+bounces-15458-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CBFB0168C
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 10:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1703B70DF
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 08:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965A72253F9;
	Fri, 11 Jul 2025 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="YiJPqxSe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68062222591
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752223083; cv=none; b=F0RvlTOi7j3lGaGhRUNlUT94uKdYLk+7GpQlaL6jnP3JWmT3Iy/h22OVCM46LyuqeTPRX/4aioIC6MSz62jSVEO/gScwwc/HQfjyLguK4kAC5aceiFNTYi+WywqhaegJ+N04r6vA2On6yhCc56YTUPMt0Nv9/ELoBMw5dDqgKuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752223083; c=relaxed/simple;
	bh=GFzihMhN7U5wWGxpsZwdQI0oddfN7uWRsA1zkzeee3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eZTAAJRJqnx2mW3CmAGnwQTGV2ZtFmxh88cxU6AmUhf+iyhFHEi05MmWcwD5OYQur0u5WNmzh2Ts5O1f1vUoF4Nmwf//GyekkTRXCVtMSpkrHYvoNd2g4FZ052sUdcLL7//kbvX5Fpf8pCORrvvOMVOyvfLMDYmXiLArxb1gGPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=YiJPqxSe; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752223079; x=1752827879; i=quwenruo.btrfs@gmx.com;
	bh=ocfVtNOVEY+yD/+Gtk3B2fHRtc8uDMziXUXpNGF/z3I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YiJPqxSeCMX95o1TJrRNFEXozW4QZoWSS2QyGDKzLR9PLEKqAOZ8za++2aCjjBBW
	 UGO0haiPIdFpc8xKQK2/OecfzUascPXQCLCdQeCuGHHsp59VnXgE3XdEq3ZKMrh7N
	 vs3NO9FWODDDCjwJLDSuanaZv7zpxbn57p8D88SD1l2I2GbPxVNMtXkRV8HjZGpSz
	 +Q6izeNiVQX/1V/nZtJFPh8ANrJol69fc0S9jEpgSHLYTybdWS/plpyrw/UUwlEmy
	 q9/NJH/PVTrIS5rCl0fYVuiun/yWirqHyy6vPHDQTAFoZSUMmch0yOOTySdkGrrtT
	 JLtLAIeMwMAypDK7eg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKKUp-1uMarJ0Ejn-00Rq1e; Fri, 11
 Jul 2025 10:37:58 +0200
Message-ID: <e94fb0c8-278c-40a6-8491-c15a4c0cb2db@gmx.com>
Date: Fri, 11 Jul 2025 18:07:54 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use cached state when falling back from NOCoW
 write to CoW write
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <db0dd3c800bc997511aa800e0b90616ca7b8b4b5.1752222571.git.fdmanana@suse.com>
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
In-Reply-To: <db0dd3c800bc997511aa800e0b90616ca7b8b4b5.1752222571.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4NXi4WdEnbCUWR/9+PI3wG7ImoSGhb+jMUxQjNrcDOoYltK5H9e
 B5yJvKHsahTvdZbiOuQquDwicjoCjKoRYZc3Os0NqYnACdvUe2aIzsOkGIXCQnf2ac1D6o8
 /Jdn9U7ElD5ZWgEFZhPM5qE66doKmbIEZeh8MjkN+/1MYG/qGjsBVPBQibb09GbFfmGDEzS
 FSJLSgaBWTyBbTEi5ab2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CSGYocqPuq0=;Ey5KTcjoz9Ur4Z0gZiYPLrX0MrN
 a15b37qVfhToTmoXR0xbB7gD4tmse8V9tiYwcybnvpdMcKakyUCXmYclRCEuLcIqRqHqxY7Fk
 PpNG+Gko65/j/Sa/47cYgd9JN5Qn0G+UIDUs6/dSRmTnW33huFgNSkM3psq6fueQDTRIxxAjx
 uzwkEwpbxLIBInxdKBnBfTzg5RQGF6N1hoQu5sKU+yOMLWw1O9n8fOdsft4C5Qu7do+IXLlWk
 /vFgMRIaWmlXIfumRv2gxmriixTjGzYCdpSuqfFqQY0OlTUZZHRHmu4dwN7nkhbn8Ypg/g9XW
 2tGQ3tgPuP98ny6JW5/rvgRudENT5oTTa9s4kkfBD00LiS8kuSL0g/RBeC0m6EsiGk5f07143
 9qdx6P31bj11HLZCMcVTwmbFXWnD8zdtfuswFVQnPWxKcrIxn/xLa8HDY0hyPAACEnroiNXwf
 krIzihCfsmvAJ2IvD/oHklj5BFNTghBtuW4blMBKm7q1SgnKpFVQrbyYlKaEj4A68MVb/gDp0
 zFIlKVG6/LlxjTpD4nV9ci1J0JOCFR9SlPQHKl2nbeb6sZDJjD+puWZtXvp+fdiQNx/baPcK6
 i8HtBDgWyT3bciKWiBL3lbb11z2Yd37MQ27Z7727XweK7gP6CsxQwdm3sGSL5f6Np5I2viyMN
 TeCzoH6N0R2ovUT0hSil6krhkADhf/PPJPcz5vtkCix077xE4/MAU9xzKkJYxBR907Id9LokJ
 Ljp3Zcd/C69Lsmi/ExoEjqPO5mEDTcLL/a6veZnggRvOpsWGZCaNZMspkyTeJFreKd/3CDKxk
 s98/ilvMICf4G7n/ykXbqFsBqApP/qyRXcpvfmRx6j6Vu5Sq8E4BotN72VOiyC7218nzTEr2w
 TN3g83is6jfNrCA8DGCTqDdOX3bkW6Ioqk1TQogHZpde7BCL3qd+NNt04q73oA5eNggVj9r4b
 lDtylLezX9KqBoTizcHIyIqcgnLVCfC4k/mQW5F+ekuL7fCBVpYjLi3x8WhXFq+s9hT/v93Pg
 UM8yur1SHlm4W96QRD6LPOwWWyv3zTZ+IhX/B5/pze5BSRbq4wF08QkGu1h7mveA6EqOCFVLc
 o9AMDXHJng60fNTxfmAOBUVRL4b9A0KYD3MVRdm/Uak2/9FfPSNwTD/XFn85GeYnC5xO4eqcA
 GRdttYXy10G8tgxiiFRqKSdZCjedMekGmqi5Md+OB16P/BOLKyn1llyaxhFi7B67ojOj001Mi
 DY9VNr7qiDzaVsnHRjML6oFc55MjcRwCD6MoZCPv5TND9CZzFeW3cgaLG6lJ6pKbXg1diwT9s
 zK8NVNSN0RHtwfDb5Q/2J9IUUTteVK512HagMHCgXGVOjaxoxgre43svwNE74k12ORKyzNgU6
 mNmCjDgMKSlwuHAvEIJ3ZyRFeemvkKqZLRdAA9Lk+w0Cs5BjkMVAl99MVvRgvyzeQC9LnP2gM
 wtBjN76//xp+Ckbyonc1/xAIpYlH7S9HvE8h96mjSoVOOaU2dzVnbnCYj5xw7yONYCb89AB5p
 QMummktKc/jozICiJF8xTEjexp1i2dVS+yvkDh4+dOPmYrSVJ1UUDws9KQaxCT3wA6WDB7OVF
 fOM5tfhn+RprOuQTuOxCBoKl8Vz4nBDkbOZudK8ibAskPyRyNmYkvrvxn9e2BLHQP7YqDmhBr
 T/pUyDTUL01SLOt0Enf0Y2DEvLOpFRkKbAqmFZCX4j7O/Fktu0US/VKzj03DTyac+1AJjY5el
 3p6/QsT+HVJadB+R5lWR4DdBCZbsFwHEV2c0caOw1FWHMC4iBbsqMHKwsrxKPLxdbYf9hv+oY
 RxyWCYihsmwDRzy+8lsN5uTxGdFHzdFaUtUK23aSaLAwwYG/vZjBgfJlBvWp2UkAQSIWfqvp7
 ZR3ubjnWmwbPCaSvLsihLdC6YVCth3BL72TwlX8MurIY5hUU2NtiUVrwM37bTNNFGG+pHsbiP
 Mo8/aZ9nNaBQ5mfaQcr0ZzhBm4mpL1dslVUq6OfxzQIEoBrDLnWDVDaWefFA6D1CNPfPrs6iV
 YT16AtDKu5UPV8CsBaEqlI6nNml6KMt+IaTDIWd2ftrJo+J+s8e9ybkVAPoptJWZ0/EwMzDLB
 DODUCocE8+10nS0bvxxEvupoLzc7x2yv+OLGOy/4rOyB02N8PNRJzHEn1KzFJUhaH6eqTExd7
 NHc3e/pM0c6P0ziYHgXcKgb/s+HNlU7rctUgpun+r+0Xjwsdcw+tm9K5upySAUafqPOvijHm6
 GlmijteR9q0MxNlGW2CUl/g3Ju4XPuKfpg8Z7nlNsTfeUmmp2i2c3bgCQZXqmE3zO7jN0ePih
 VVBTIeJHU+o5pQiLY4EEL8D2BMjej/kP9lTeW6h/CLDDiG00rcRxXfOLBn0P3d0sx9Tie5sB9
 EDCRWQ4ZY/peCNB2z7VZoS78hcTIkLi7UyOTq7xpBoazjlfSHDdy8vt5XlR4RQnIa/4Ji0h2Y
 t7CtQhHV506C34JDvk/fGqzh7wP0UH4IbXfUjKquCZhQ+6eyP9MxZxbZc48A07Ff70Rd+Vxmw
 GsJ6+R6P7xFufE00lXESbPaykMoFInOWnQNGwUVrEgFSkB+mE9Ci1oOvmRlUxDnJmLDmTwP2Q
 iz3t+f59pVID12XDsydXDTpCLjb5hLEKvRzO9IbsAh6ngLsEMXP+DilPx5bvgx8LjribXvocn
 3D9pDF8NqcuiE714QzLqum9HCYvvpz7Mowx4lC6n7E4tWjT9/ir0izPL0Htt9F9qqunu4NHM4
 h3JI1Vl4GOwVLNnohJO3WbVyDEfFoEGD8DOJGK1JfrWKQTMZ/Yv0zIic2J2DMh89WnbCu5qa+
 LXdMEwOzZL740/gl/r3Sgvpy2kys/Tu/zXfCGB6kJB4tg3vx0c7SSGpBPiBJMeS/tvl2kVc5F
 wu96gS4EdYFbsyhFV8iLY1Q0N0RHvMDa4SNVGBA1WTH7dlI5c44Ofv1B7mVqazep7wPTJemHe
 x3BOr6SCi/vuR5R5Y6dQVGG0jc7/SiWBXfU7B9ZZFT86MwJqb3W7moRm1Lr0+FB6HGykbXMVe
 IuYx1+L44m3ZopLD7rD56vQpvwwLK3FGdPo54aKkeg19Opdd7gluAVtGBOg4VslaRi5KnFbhN
 6X8CaC2Obe5V6LgdPiOfDJI4Jk+iUMunsDPdFmQEGrNBCijqjHeC0dUalmQcgmUEylpgX6hQ4
 mtmHklTo66wyvguyGmd1w7OFj4ve9K7F7pj9YQMjeUFlY8/8e8RRTCmKxgzjMz1uBl4NrG9p4
 70S7Mea+EXGV7XK9ePfP6JB/qzEQSfpA1WTrHFfDdl+bhaNsd9YA7z3wYGm3PUlLWrvG0WneN
 mKC9y32syCugTksOHSrhKWUiWcgubFexDoAcnoTiI6naGbPhAVecLZADAAqyI8gMB6Mwo4IFq
 SjdtNwdGPXJeV4CwzR1AIELgzPFPF8S5SOy+U5fQm9WBwK02ibnPT3dZbQOk5qsEmszVvzhsn
 ak7dVBSio5ToTWJ2GwOj2WUFo0vkXoUvlgdrcNIi/Q3Fo56yrJ60pN2UDwnFpsnhLe6a66xuX
 g+3CkqX4ZS2hF8vhmZAuHlQ=



=E5=9C=A8 2025/7/11 18:00, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> We have a cached extent state record from the previous extent locking so
> we can use when setting the EXTENT_NORESERVE in the range, allowing the
> operation to be faster if the extent io tree is relatively large.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

In fact I think we should even remove btrfs_clear_extent_bits() helper,=20
that doesn't provide any real help, and there is no counter part like=20
btrfs_set_extent_bits().

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 6aa1e66448fa..6781956197c7 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1754,7 +1754,8 @@ static int fallback_to_cow(struct btrfs_inode *ino=
de,
>   		spin_unlock(&sinfo->lock);
>  =20
>   		if (count > 0)
> -			btrfs_clear_extent_bits(io_tree, start, end, EXTENT_NORESERVE);
> +			btrfs_clear_extent_bit(io_tree, start, end, EXTENT_NORESERVE,
> +					       &cached_state);
>   	}
>   	btrfs_unlock_extent(io_tree, start, end, &cached_state);
>  =20


