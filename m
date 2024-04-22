Return-Path: <linux-btrfs+bounces-4471-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0664C8AC829
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Apr 2024 10:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3489D1C218CD
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Apr 2024 08:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8183D524A6;
	Mon, 22 Apr 2024 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="J5y3fT1k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A751C40
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Apr 2024 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776177; cv=none; b=kVgJ8VjlmLozISs8gxossUDS/QXqpbzpGnL8xG7VQg4g9MNQG0HLPx7WU48DTe5k2pmuCKX7nezxjgQHICnijt+MXJZMTBiY3mqstWjdhPorarIr5n7G7xAgT5zdvxQsys/ir20bm+/VNdCL8bldW3fI1mOIYYYuLE3B9tqVA9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776177; c=relaxed/simple;
	bh=KlDA+mzuQHgY2llGnkjpjscUQsm5ccOzUaUyBoW1ABE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDkFFGNKC0G5a7TS220tjAP/ihlTYaOtgNf0v0t5NMSz92ISJQZWtiO1/TwimYCaphEUrpqy5RgEk9yBMcbfYNgMdnaaT3cZUwCoLOZKTq8IE5cylMD3LY1G5D3ma97l2lLqfdXH9OmBcrwQeQqwwjf77MUG7n/3LIFPRFo0Ckw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=J5y3fT1k; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1713776165; x=1714380965; i=quwenruo.btrfs@gmx.com;
	bh=KlDA+mzuQHgY2llGnkjpjscUQsm5ccOzUaUyBoW1ABE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=J5y3fT1kQVuM1oG7bex9/R6rZnopP4xUUmRdd0ELsWcmHFvZRHJuaNuyNQ8Xfatb
	 50x0zaHPS5NHYP6REFbTxQpwFTmHV2MXweGRlKgAzCAgC+EWbPOfXBc1AQMMMQMKX
	 xm56/sS3Aor46o5L/8EzbfEzXQSKm9v05LYMqsmOKQCWHlVoHM8k0V9pUdXeZyUXw
	 PG1QK+pnvs/42dEAMRjhOl3Uz+N8o+fKFSKItlyBx1kzRewciGUPAFk5x1Xi/OEIs
	 p3bwfY0Cd41n94NyQJWYsqxnVxGsGJ5XcS7628XJiOIel9ko2y7u+d0UEsj3ZWZu3
	 MFvXyjYAn6F0ZWqU4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6bfq-1sly4g14GM-0182Jq; Mon, 22
 Apr 2024 10:56:05 +0200
Message-ID: <9086a324-b17a-4e00-906b-816fb2b05880@gmx.com>
Date: Mon, 22 Apr 2024 18:25:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS use-after-free bug at free_extent_buffer_internal
To: Sachi King <nakato@nakato.io>, u-boot@lists.denx.de
Cc: kabel@kernel.org, wqu@suse.com, linux-btrfs@vger.kernel.org
References: <3281192.oiGErgHkdL@youmu>
 <995dd168-8e1e-4b99-896c-ece4dc88d6e9@gmx.com>
Content-Language: en-US
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
In-Reply-To: <995dd168-8e1e-4b99-896c-ece4dc88d6e9@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OnLqQhTQy1xBmQX62aNyvc009v9RCRKNn/azxXAOn0Of5FhnVkh
 LntlbX04fKVHdqacrmzVeUa9Iav9jVOxj8Mul8R4j73HQTPJV7YQQ4xPFowOXsi2axO2wya
 4cGN0UR94FeT/44NTO16pPP4aFYD10RBmday/x2XcVdKiUAkue2/cNhj/fXdqeUsyiJ3GQW
 B6OLHjRk11X4UoOcOiX+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:47B513+HHHA=;1AFOLtfDMpHGAdII9mwMGqMvgNt
 AD/TPjHIZWnZu3Pw4kkxVpnExW7MSwqoyMiu7PyoyWnaso6tlWRkT6gcXF1U0umhls+EtTtDR
 W9NgCTI34I7VSEUBOxIa9riMdC3CGNhsNnzyKsQAoszsHszetnWcykszitdBdpikZX9KoTCBS
 hM1Ft4USTZjNPZlitd6PZl/Oo+eLQMq1CH2C4M+NH4H+EBATsxteULBMZPe4zY7WpTRrz8jQa
 KlDUEXf4YG1IAQj7Vl9sCfjAr0sYniFRnR7FzRreaAgR7lYH8yJZ5jfMgYmUmT6VEQz1YRocp
 80S5t8g2ci/oehPVJdTPxY/qP51xLxY605v6BGEUoyFJ2nqM9qF7Z6KDDFmW3OIiwcmM1x4Vk
 vxljcdL7HdDj3E8pz7fwm6rsezLg87dQI1N+Xs78wr7cKznWWb24ByAoDrSCb9oCl9FUZpyEY
 vf0+J6A0g5/Y7xhYORtU7PcL+21tSh+2TOYrqYdsXa5KCywYRqiZmo8UgZ+6lowZJ2Z3hJIl/
 azjWAUeFbFixUknOcdBjFEmm3icKLbWuJD/dBgqSyzmrad8GFVoD3F7dvI/2wg/4nYuJEkMz+
 KJvBEOZNQSBDBBHM07kGNU6yPr2swAHzNtz/oEd9WrtAfBJ1/B7PCkawBBRBt1uNsuQVvvOPU
 ln6shh/2jgmiZGBmkOw5TDwGCLDjmWGozPDBMp9UMgdQmmWmMO03VkWi+it7qocLNZ8g/c5uc
 R4fxjknYzjll7+/MOHgK+k9iTuGpltCM3V2V6IA7h2HReqpvaBGYOQsr3sBhUeiddklqgGMfJ
 btKWwlJCizuEN8cuW5V1hkV3VfeTv/iJ403DPJI3Eykos=



=E5=9C=A8 2024/4/22 16:45, Qu Wenruo =E5=86=99=E9=81=93:
[...]
>>
>> I added a print statement to free_extent_buffer_internal that prints th=
e
>> start address of the extent_buffer as I'm not sure what to be looking f=
or
>> here.=C2=A0 This print statement is before the decrement.
>>> printf("free_extent_buffer_internal: eb->start[%llx] eb->refs[%i]\n",
>>> eb->start, eb->refs);
>>

Just a small advice, in fact you can go with sandbox mode, running
U-boot in userspace, and bind a host file as a device to test the
filesystem code.

At least that's what I did for most U-boot bugs.

Thanks,
Qu

