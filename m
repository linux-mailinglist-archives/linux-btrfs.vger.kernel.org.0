Return-Path: <linux-btrfs+bounces-3987-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0938089A710
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 00:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25521F21975
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 22:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7911B17555A;
	Fri,  5 Apr 2024 22:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qzDjW8hg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8465B1C6A8;
	Fri,  5 Apr 2024 22:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712354746; cv=none; b=tQRCQwJhrFROH7HlUM+V1EVAe0w9gNbal4I7sWFBOzu9MAWCJRYhecnqKKKVrbynGx5t+hY7TLtD88d7HRcYtb+GaDUkUNbTXWcoywE4IgPIlEdfMjNn1BwwGtilb0FlpJmumHVNtm1Uw25C4JNtdzZOyRAj11r6FjORKtmAH0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712354746; c=relaxed/simple;
	bh=GbZeBF8lbF+hNNUujZ1Q41HtBUBLFde8zaHcOIt2mlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UgcGE9TMbmnfJF3Lciq4vpYHepRxKygDXiQcIzAdp7W7F+CenZD4BSB/u/JoOX0hOsA/Os/YAZosrVj4J8uh1eXcuWnLBMc/wccNSpeWR+yfjRonfOy8674iZjsembDJ6EMKn9lLdxFTpkwT7HqESpiJL4L79akt1jbXL7vJ9zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=qzDjW8hg; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712354733; x=1712959533; i=quwenruo.btrfs@gmx.com;
	bh=JMI4p6oYjxLbsRUaIzOTLgwitdV/wSYXBF8SOYRFMsA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=qzDjW8hgbyHJWUn4Xh9TOm7ur0JntNYmkriWF9miFDOcWz/2ughhIZKsz5vaIcUi
	 FKAu9oJ5FEYR3vLv7Zxpkgw7MyJDD8RqNUv+WERHuftaL/Qyv5/iV/cp3i3yqPE11
	 ecy/HtFeTGNJQxJD5/kFxuTGL1duuJTgdeR2F3tm9ex1H4mqpfqfqfUVFNN5Xe6Ab
	 3jOv2zgxncoAESk8e2UjClGM00DerYWIzFR5bn97LqFmeLf0foAF3nWAmu0XrisqV
	 I7NpAqsGpmXtibahkMczQkJWpBb8ohFzTi8NoR9dNszdU3y6g68OmELgDed3U/0bd
	 gzkqu7zREpRJ/C+78g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHXBp-1rxUFg05XV-00Dasz; Sat, 06
 Apr 2024 00:05:33 +0200
Message-ID: <a4ec0dcf-677a-4f84-aebe-851203ae0f4a@gmx.com>
Date: Sat, 6 Apr 2024 08:35:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fstests: btrfs: subvolume snapshot fix golden output
To: Anand Jain <anand.jain@oracle.com>, zlang@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 josef@toxicpanda.com, dsterba@suse.cz
References: <cover.1712306454.git.anand.jain@oracle.com>
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
In-Reply-To: <cover.1712306454.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4uFmU/fsmdJgZPrsoPDffsF2e3b5cZlacsEhiFdaCH8kA+/wPlN
 gnP0xr817sheIZSUn3ykYp2a51xT+1VibCwRvJgfPTHfv4lt3WoRWBPWfYqNaxJBMXyiz3z
 u3yblAukRdEWhlpJfyIW5hVK6u3b4hqk2qer7sMEysxy3Osb7hvagA6L4EyoVyXJI3QWg3n
 K0hIPOIl0WBigaZUVtJdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BFezGFuQw2E=;FSACn4voXRjg6T4CUMV7V00IBOY
 pTihalbaBLfJshdpZOWC6ryeoksd72Hd3JT3u8+Y7jE+/bzhCZBIgEDVr81D9ilG5uMCjZZzG
 GwbBvmcCZCXSXl8i/74lhI1+nKRaNEp+s4+dNMktFemmP8iX43nsU1X7Eja9M+lhWjmWVzk2M
 wgTT4rlGqEQ/2+oz9b0UIFSaYKE/J/kbGX0vPrfaKoA48ADaC5708jqGOB91UffjNKtn/TJMx
 n5PBzJsgH44Bp6PReEa1GG52SXQhUw+d3NwzDGaPpUDo5AObR39Ldv3ptB+VS48YF4Zjlz7Z7
 Sx/0TAb80olKaY+itIuPogWpq7QNKTD4yAe4tTSLJIpqhCmI5ZP1ihmd5qchc5RL/l+Yy0Byt
 vmyvrOjue5Nd0uUDqg1TpZg8w3jbx1FAtbFfmuTZUBS3rp4El8cB3//dfA13TK2HkJV5hQIN0
 0xD/66BNSVqQAp7O/g/uip4eu0OYf+KWwOAeOvdAGiethdFtovE1bipT2I9jypk2bculCBRnm
 IbqO7GFOAUUz6R0FvBoKRa4HG8SUdtIVkoiK6Jhy42dG6Aog2pKE8cojX8JhfT0vhc012UwDy
 CFfKs/2N/VG2ESk0gZjMqBwXHj/NSzN/E82e3kUJLFJeU0LtfW1nHhqTUiyfk1SIOquFcvczG
 0h6ajN0/ziykyTkuBEjFAXI+yCw1zm9zOaa9NRDGhx8tDGGGThWpwNmUf/6UFy6KG/DmXW2y1
 7KCGcAHgeZlWL68a4t+Wqc4XTzb84nYutBTfotNjz46WVaKWAdKJ/pc6mEao6YZccdpkgafvV
 0659ARRl2aKVWNINb6SbGfpbOJNWwbr7QXoRwgVz2eOCs=



=E5=9C=A8 2024/4/5 19:15, Anand Jain =E5=86=99=E9=81=93:
> Update test cases with the new golden output for the command btrfs
> subvolume snapshot, further introduce a helper _filter_snapshot() to
> make it compatible with older btrfs-progs.

BTW, you're missing quite a lot of other test cases.

At least there should be around 20 test cases affected.

>
> Anand Jain (2):
>    common/filter.btrfs: add a new _filter_snapshot
>    btrfs: create snapshot fix golden output
>
>   common/filter.btrfs | 9 +++++++++
>   tests/btrfs/001     | 3 ++-
>   tests/btrfs/001.out | 2 +-
>   tests/btrfs/152     | 6 +++---
>   tests/btrfs/152.out | 4 ++--
>   tests/btrfs/168     | 6 +++---
>   tests/btrfs/168.out | 4 ++--
>   tests/btrfs/202     | 4 ++--
>   tests/btrfs/202.out | 2 +-
>   tests/btrfs/300.out | 2 +-
>   tests/btrfs/302     | 4 ++--
>   tests/btrfs/302.out | 2 +-
>   12 files changed, 29 insertions(+), 19 deletions(-)
>

