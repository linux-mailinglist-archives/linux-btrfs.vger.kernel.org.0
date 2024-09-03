Return-Path: <linux-btrfs+bounces-7785-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A58596996C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 11:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446741F23B2C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 09:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A321A0BE4;
	Tue,  3 Sep 2024 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Yyqoved9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05EB1A0BCB;
	Tue,  3 Sep 2024 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356630; cv=none; b=lNafGDquR3xFYvfTJ1xgerIlJKZ6WR/hMDWnSLn+ybYa3Ayoy4mtG7gXsAGJGOb/No7IWeaKrmWSOCySh7+ygC4GSENesOaS7qQ8wf60sF0BexyvVDAUu0CsLekNem2w1Ov/ZsfL8SdlhFCVCmNrg+oZvwR+1NP20EEFQ3sxWJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356630; c=relaxed/simple;
	bh=lmdDPOvDLTN3XZiZ+tazhsXXBLHnnMTvsTexO6kEC80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIcGJLuIHpcXkkqlEbsjhHJhOj9rvSfSaMOIryyNxfVlnLsWx6zAQcwhu0qkjZZFCzpKTWHjT9jMDy2gnWeqoJUTdPJYAPuU/2jLPBPRaCV9PLqFabMpl+CBacdlbPZPxz7TiqXMFfWcfa2iDbH10jElj/qjborTUjHRL12m49g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Yyqoved9; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725356613; x=1725961413; i=quwenruo.btrfs@gmx.com;
	bh=lmdDPOvDLTN3XZiZ+tazhsXXBLHnnMTvsTexO6kEC80=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Yyqoved9qYXVGOvk5ZzowQAFLtSvJBvwQEwCgGUNYJ/eFGI2Rp6XJ3BWwQ0XNnvW
	 U3tde1OGWdTz4e/A1H7WcGVSFYPREW5ay7sE2xQCDBBfZo9dI1f0z9wsBL6aFmnF7
	 g1aI8FmaxucxT2XvNRRQiyyrUVt3nHJS0MFyjhJmVDqmxxOCogNcsAHay8/i+znEc
	 SQtL9CyndEWfKtsIGTk3hG7lbWWJ+K5ykYDuIDiIV7Gg9/Dwn2HOEv39legAG91Dn
	 W4W6/ziXKyBPstF8oDrB6Mq6Mw826hEA4ZdMhDQTEgsoNpUYFkv0gVaybEiKlVcWs
	 o0UZgR6AGdkxV29aTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3bX1-1s2yV53rbn-012J5Y; Tue, 03
 Sep 2024 11:43:33 +0200
Message-ID: <e5d765e8-e294-465f-adfc-ad4787116959@gmx.com>
Date: Tue, 3 Sep 2024 19:13:29 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] btrfs: Split remaining space to discard in chunks
To: Christoph Hellwig <hch@infradead.org>,
 Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240903071625.957275-1-luca.stefani.ge1@gmail.com>
 <20240903071625.957275-3-luca.stefani.ge1@gmail.com>
 <Zta6RR1gXPi7cRH3@infradead.org>
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
In-Reply-To: <Zta6RR1gXPi7cRH3@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S2nlwpKyfcOeaT6bbLqsoSIDSixNwGOJCugw46/Ll5oUIXpc700
 JslYv65JCs5eCUe1sB/yrhOohVDC4gC8eA/5wA1F4aOq4kPCdMqyEZBEFEdx69ZflfCOJ2K
 xpRRUh5Tjw5sE2B/skP1mgXI4YZcDE0I/3Eq3N7OzJzVFE8sOG5Ghuzxozz7/vcR+jnIjwu
 5mVuQ0Fkbvb9bIb/8PH6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DDg6Uu+92p0=;xZDv2Ol0WMo+oSPWrpaxB+FVtG/
 AnJvuZ8ahPpVgvvFQWOVSUOWAhVtVcHcoyZPGrqE/rNnoECs1Zwsk5uC+Yutf2jtpWUooBDH0
 HNb+/x++IrB2a6OhrWepV19cMnsBuYcihhlW2tJsazX4BmqgsbG+qD8Q/xwsxUODTOqrntlJF
 ULJWG3/g2yWVka2s2mWXRIO/zUcd4WMVeaxHmrNaeJ2+yH0x9CJm5TUu1Vu33niGYLry2bq/J
 clGkpeIGvUpPOw/v348XCTTgyIpmqecTIfCyZZoVzlf+RvNaGBAFKBEWHJWh5Ox8VIkbZaiGz
 vD6nQZYVekXJCiVIK62xdrOILu/yzObCw3gnn1q2ZWs79ImFgmBe6DVAZln2QI88jNDaJwkcG
 xEVyszWT2hxvEo8e6eyYLAm4mFX4W7yLCf1/FmJCnHKuS9rQXEtnRoPudStW+Mg9YnpRoNI25
 /1iNd/dW086ljOjsENcDv0ZJwjfooqL0fV/ghbl63g03ShpwlUe+ao5AhwBQRv+0FZZ4fAN+s
 t6FDAxIliI75AUXw17ky1S/GcsNpmUMGaJvZssRWixfUE8SJz+FBIQfknESNq/6Cddjx4ce4U
 60VEEUI/4ku698n3PfA5kyXTLQmBCDAHDkD1KBAoPZcy5IVB6H/Q3bB5NkBmbFBoBCDsCwT4+
 Vpxg6z6wAB+hlld5cdiyWUSnL6cznbtxeaQS7yG1vdHbRrhFP45ABJYSF8im+7C+mvk8ENZ67
 RisFNx+6YV+R2REVxnAq9MKD8yAeFIzOrPuCRSZyXJ2s/7zGk8E8UNDv6TfTJTT7h6FSfwP+M
 lc+0xG+ks5FnJGaz/7LurtIA==



=E5=9C=A8 2024/9/3 16:57, Christoph Hellwig =E5=86=99=E9=81=93:
> You'll also need add a EXPORT_SYMBOL_GPL for blk_alloc_discard_bio.

Just curious, shouldn't blk_ioctl_discard() also check frozen status to
prevent block device trim from block suspension?

And if that's the case, would it make more sense to move the signal and
freezing checks into blk_alloc_discard_bio()?

Thanks,
Qu

