Return-Path: <linux-btrfs+bounces-1118-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C548981C29B
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 02:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E36287BEE
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 01:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CAF33CE;
	Fri, 22 Dec 2023 01:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="k+q0xsFv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F587258F
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Dec 2023 01:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1703207612; x=1703812412; i=quwenruo.btrfs@gmx.com;
	bh=iQfJN0kOlvSbMb1HPBNSO2QBqxyszlHC2VMU4dFqxcI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=k+q0xsFvKtf9owwdNvr4PShZuuG88fUChCO3V7a8wOh2ZDPNwB3njpArwJu7TvDa
	 bvqWEg6mqlBcoGA1wSVM9+6Hqpz5gz+dhCHcdMqntK8w6xlKDQ7ccLW3/+TJSdbph
	 IVvY5kBLX/JC/vtF8FMgrlToCPXHRtGVWgWLbtqKV0P2QrdYKjbbMvdPXUelmVECE
	 WRH1h0OIzANys20QyVJD61xxMXejLcGPJr12ibhIbI/9ycVuSdsHFYwUJJMdlUNgH
	 RRExuFQer6WWQmJe09neqbOklw9EyKs0i5X0JU/ZO/8oL+n1tSj2GEKAG41F4XhPh
	 lgfPYuOuwf7jczHM+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.114.154]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MfpSl-1qo3AQ0HUH-00gIp1; Fri, 22
 Dec 2023 02:13:31 +0100
Message-ID: <57a0f910-a100-4f31-ad22-762e8c0ecb39@gmx.com>
Date: Fri, 22 Dec 2023 11:43:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
Content-Language: en-US
To: Christoph Anton Mitterer <calestyo@scientia.org>, Qu Wenruo
 <wqu@suse.com>, Andrei Borzenkov <arvidjaar@gmail.com>
Cc: kreijack@inwind.it, linux-btrfs@vger.kernel.org
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
 <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
 <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com>
 <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
 <9ce30564e238d1be0deafb8cab8968f800a8deaa.camel@scientia.org>
 <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com>
 <62e9ad23d4829f30600ea6e611d2cd4636f080cc.camel@scientia.org>
 <7acc8ea1-079d-42bb-8880-dbd9bbfa100b@libero.it>
 <fecad7ce2cea1ff125a842d8c53f1fbfe4f1d231.camel@scientia.org>
 <CAA91j0VNf9UQTYOn688eboGB_bw4YeKOXnKAt1uAYRZwYA3UPg@mail.gmail.com>
 <b47ed92f14edde7db5c1037a75b38652afa6c1c1.camel@scientia.org>
 <e6ef9ab3-06ab-4360-b205-3a7559b6b388@gmx.com>
 <979fd68a4a766f823366797eab1060e5c515a776.camel@scientia.org>
 <ba9556f9-4784-4bf8-8fa1-49b17df6d31e@gmx.com>
 <c085dabb449f8088156d906062db0b9fa0f7fe32.camel@scientia.org>
 <aa69e84f-d466-457d-9b29-47043c2aef53@suse.com>
 <bf5726d2a30996d06204b17d05daec9c77b7d769.camel@scientia.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <bf5726d2a30996d06204b17d05daec9c77b7d769.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xkALLfvMfbkLodRdBGXeOMA98shhSICCXJP6aoFijpZvX0x+E81
 2HdRw1/e2rfXobr6k0lswvAen/5wUb1zrZ4BxWa1OgZKCp+wdA2RLtzPlOnt9yeAER+bjpV
 tpaaVqYJkK5Cr710CKn+AX3tCFAMGUXpK9fzYnK+31TE/AM+aJFthzSMRL46279d04uShEG
 jkAvWJEuD55ad8puI9x1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wLsHXHP7tx4=;jvR+nsvrHAYprlkqIZxMVP3nHxz
 lnT9a+S86IYSjagEKAqiGZ+PI6hzw6J+iuKnA39PXxfRnDIF19Ghv5BLQlf9moTZaJrFwvj4E
 FO46/fQrvIVTfOxsBZZPrXoLMoyH+XHg/3/HHIb3ipqoDh9Yzz9VtHbxnvkrvLR7iA3SNsW0V
 DgTf/0dRAJHz2P4nHM4yjLlPT0Wog4gPMpF8WYqIhVUP61AFmR4aXLepw2Gd2w7tNM+PEsfvH
 a0LAvLQbhD6AvNBsVO0Zdo3CmjhSP7lTPlPFsSo1cNsaejp4CpPgB0Z6kWK/ssQai14vqkN68
 L7Vxl9UNeK5ajr8gI3ZvqHqcSEB/T3aleytwWu0F/cJCJfI7+L14hQ9lGs7CHrlZOTIdWnO20
 t8b3VA2IJXL+kCvigkMZE8NouaLtmwWi7S4FCg/Rma2FKfY+e51uFVovo8IGR+ZaHfsBbvqlW
 O71xqjiyy0WTslJXIvftNOj7h2Oa8L40uzo/1MwReJbVZvW2nQzPsV/20nQkpqbzNLchPYOxK
 my3N79nc5Gdd6Uea+Wv9vD/W0CUQMEngnhxDh3MHlA0DRQFlLExg6FP/nNH1YbrjNYKIboBSm
 +z3LZMraXJ3GPEZZk2xewaZEC+k8n51UY7aa5qp5T1FoA34tSmW527FlBWkLe3SGNl65AdDl4
 ycc5s5oq28eEIKS4h3fyBZkAUYhWzG7+7qzTaN0/0zxFAO+mcmJ/zdEVKahYI0TJQLoOwyG1Q
 Ebq45DJG3JUJYKzA8ITYrcq+GZ/flzNbiHS4e6aPQxEUKHh4+5e0lEFjYW0yNO0Em4inVkiu5
 3zi39x6d66GMxR/itzLuz2vpL1tvtE6o8ZSOWwo8d+rlA2dUcYwKl+jLYibt/JvsXz+GweLX+
 DW/LNhYQZ5766S35J5WRX/RkKG+wRvXEkASA7Mffz6KqSlHWjYbEkOYJdOszRwkRTU/Ym9Wjd
 XV2VvyvfpkUVmeAjzKJsSwAtz00=



On 2023/12/22 11:26, Christoph Anton Mitterer wrote:
> On Fri, 2023-12-22 at 11:23 +1030, Qu Wenruo wrote:
>> But the problem comes on why defrag doesn't work.
>> I'll look into this during the holiday season, but I strongly believe
>> it's the PREALLOC inode flag.
>> We should take it seriously now.
>
> Oh and keep in mind that - as I've hopefully had mentioned in the
> beginning - this is all on 6.1.55 (Debian stable)-

That's not a big deal, because before sending that reply, I have already
reproduced the problem using 6.6 kernel, so it's a long existing problem.
Just like the whole PREALLOC and compression problem.

Thanks,
Qu
>
> Thanks,
> Chris.
>

