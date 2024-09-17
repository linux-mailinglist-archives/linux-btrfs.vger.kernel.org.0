Return-Path: <linux-btrfs+bounces-8099-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7456D97B54F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 23:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933751C22E71
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 21:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D21191F95;
	Tue, 17 Sep 2024 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KEW+utMs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227FC1531C5
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2024 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726609249; cv=none; b=o+gfn+w62hKk+8Uc4ikiBfLderJWOVylUL0lSm33qnYKfclhhs+XQr98po9hmLhB/7xuyUYF1NOnWuI/B9g/tGhFTPOoS6so4IqoN/Fd+dAsOrsJbg6ZdSP7fSeKRjQOP/WmRf7QyDfv2Wkolx/lH4hlLtaOCdn8Jv1I2MYFsgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726609249; c=relaxed/simple;
	bh=4bvRIu0nWOd3QEUV+5WKf4JPfcXLKHj+iDnmNEO0U8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FhFPWdw9IpCYop9kwQI4kfusvOz7t+/oH5v2l6XaQam8imlvfiPz5BebRHChIkueKhnC+sm3fTzm7UZJChoSCr26hmd3k5hSLvVa2x0vJyEXQxOrDWFtPoABPreMJNouA7hOBEsJJiOKtUCse6MCPt0N6TDoFDgmppUi0RcvzeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KEW+utMs; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726609242; x=1727214042; i=quwenruo.btrfs@gmx.com;
	bh=ZGlXF1mOQ4LGGehnKydMaZ9tnIRdx8monlLjfXACkL4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KEW+utMsmSastdjX8FVfTVY9dyqNd1xJhuiwQblZKorTRgQvRftsEamNasbg95Iy
	 Q3BSbDsPZjgiCHEbLgUibJRWq6/mbKpWUTbA9wF5Ejo/PdZyspRSvfntLMhsq2sCc
	 hw95ZzzJ8hEhWo8z1mSAvpkZnB2CTHqQfCqkrBcqYkvXoRFkk4gDLwRAjGXYA7OSQ
	 wwiSByYACo1I8OgHRjWUgELbHlKZ26IB/ELwxuuwuwoXZav/o5dEn1yvEJiDfZZMj
	 5DEpxtXt6x9iH3OIEzARh6+kQ/uv1UIwTg/CTdnnDD9N2oVvvfWJjHIxl/z2d876w
	 fGQrXQsqqY+tipnSPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MCsU6-1shqFV42wi-002apE; Tue, 17
 Sep 2024 23:40:42 +0200
Message-ID: <2ffd987f-f767-4fd2-b684-0c95d418a977@gmx.com>
Date: Wed, 18 Sep 2024 07:10:39 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS critical, corrupt node, unaligned pointer, should be
 aligned to 4096
To: Chris Murphy <lists@colorremedies.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <47636de6-8270-4a24-b97a-df9c267439c7@app.fastmail.com>
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
In-Reply-To: <47636de6-8270-4a24-b97a-df9c267439c7@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7/cHnN/xoV8oES0DO9avfm72cUS/EAiOh7np5qHzEQI5LgiSKbf
 9YBQql0XJrMe3kOYeaxFII/gT/EV6NOyz8Bvm2SGNFK3WgntsjBYrUW/bVZ/jDBiTw0JFVI
 csn8C47HX/J6dkZiEBRTEzZk00bwzhMgD2soPSlkcQmvbQysOVvTsBvMInFc+OCn5W9OkWq
 SfLEw2YrqKdnqFB4OVkWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2Ez7KgaUKTs=;PmpsjHcsqqTG72K8bxgZ39+1fIZ
 88N63EoHT+X2Yg2jITpBo6zwsLQX1pJxlkg1tjwGkBEp4Y1q7EOSQq1ux0bGXcA8eIRrLSftg
 y2whFDhh5dDl2vExgsgrzSBm5xCevWPubAemy/m0fusWVdMI71s4TGijvStx/vyGK1EErRBwm
 MF6D+lZvnoOeAT5ZitKg7mqN/jnNaJ6j9bRK1qBA5P9A31urSAt/+iOwzQvP3QtOsHCnS8qgN
 5xhIqPsORgEOxxSrec+FgG1jWVVu6A+A4TL550OoUiuJypWn0XrlnRKJv27lj4vSfY7kO/RQk
 XQRgmMBjCVMup6J47tIO4Q6fISs1Y4WxJeC/PJuuxxb4KU8JvSXqccCjDfwyV1qCEj8aQSBlN
 M9W6PePCvbJnb6wV6e3XtDPbmw871s09SuG3CNcOitqF0KrhNYKW4rWsIWzLxkuM0SVSeRaMc
 1Tmfy4UE77/cNI664uYScAAEOBx0/ze+UKIx4cl2eYF++60ewDGq1MuUuwlAnLvjxRpC2YTut
 WGbD1ykLYW5CuTixI5z935q+eItmFWhNdRR2Wm+oQfEVvwIOxdSiTU7YQ0r0c5F2oHguEgnZj
 ENhBAHA4wXXR2UY6pzYrRjQ7yVhuu3Kd0HHeTMAUX4S3xkUvy/5B4OSjJHzu6CW6UooFqGPG1
 uOG8xX9A7zFoNxeH0gW3Yg/mmgt/bGahgc0iW/0ounkIpBbgZrqR3Q0Q4IFMoi5c0mqE9MYcN
 kf+/QdFORXCHoWpnBv55sbsthC2IRoZASOUnfYKeaG/QlVp21CQW8BR90TxRdlwfX9Mv70C1N
 IkveX9VwYHqBMMegcZ2Ia4y0Xc0JH2Y3kcPgnfZQH3L4w=



=E5=9C=A8 2024/9/18 03:34, Chris Murphy =E5=86=99=E9=81=93:
> Happens with 6.10.6-6.10.9, does not happen with 6.9.7.
>
> Complete kernel messages are attached to the bug report
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2312886
>
> kernel message excerpts:
>
> Sep 17 00:55:42 kernel: page: refcount:4 mapcount:0 mapping:00000000339e=
ecab index:0xef2f60 pfn:0x1528ae
> Sep 17 00:55:42 kernel: memcg:ffff9a2180399000
> Sep 17 00:55:42 kernel: aops:btree_aops ino:1
> Sep 17 00:55:42 kernel: flags: 0x17ffffd600422e(referenced|uptodate|lru|=
workingset|private|writeback|node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
> Sep 17 00:55:42 kernel: raw: 0017ffffd600422e ffffe31e054a2bc8 ffffe31e0=
54a2b48 ffff9a2180488338
> Sep 17 00:55:42 kernel: raw: 0000000000ef2f60 ffff9a232a13c1e0 00000004f=
fffffff ffff9a2180399000
> Sep 17 00:55:42 kernel: page dumped because: eb page dump
> Sep 17 00:55:43 kernel: BTRFS critical (device vda3): corrupt node: root=
=3D2 block=3D64205750272 slot=3D121, unaligned pointer, have 64012238993 s=
hould be aligned to 4096
> Sep 17 00:55:43 kernel: BTRFS info (device vda3): node 64205750272 level=
 1 gen 2593 total ptrs 206 free spc 287 owner 2
> ...
> Sep 17 00:55:43 kernel: BTRFS error (device vda3): block=3D64205750272 w=
rite time tree block corruption detected
> Sep 17 00:55:43 kernel: page: refcount:4 mapcount:0 mapping:00000000339e=
ecab index:0xef3a90 pfn:0x1ce336
> Sep 17 00:55:43 kernel: memcg:ffff9a2180399000
> Sep 17 00:55:43 kernel: aops:btree_aops ino:1
> Sep 17 00:55:43 kernel: flags: 0x17ffffd600422e(referenced|uptodate|lru|=
workingset|private|writeback|node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
> Sep 17 00:55:43 kernel: raw: 0017ffffd600422e ffffe31e04b94988 ffffe31e0=
738cdc8 ffff9a2180488338
> Sep 17 00:55:43 kernel: raw: 0000000000ef3a90 ffff9a2192f701e0 00000004f=
fffffff ffff9a2180399000
> Sep 17 00:55:43 kernel: page dumped because: eb page dump
> Sep 17 00:55:43 kernel: BTRFS critical (device vda3): corrupt leaf: root=
=3D256 block=3D64217481216 slot=3D3 ino=3D16205860, invalid dir item type,=
 have 33 expect (0, 9)
>
> ...
> Sep 17 00:55:43 kernel: BTRFS error (device vda3): block=3D64217481216 w=
rite time tree block corruption detected
> Sep 17 00:55:43 kernel: BTRFS: error (device vda3) in btrfs_commit_trans=
action:2505: errno=3D-5 IO failure (Error while writing out transaction)
> Sep 17 00:55:43 kernel: BTRFS info (device vda3 state E): forced readonl=
y
>
>

[17 Sep]
It shows everything we need to know:

  kernel: #011key 120 (40535728128 168 4096) block 64012189696 gen 2592
  kernel: #011key 121 (2774366982960963584 113 5236482350604877970)
block 64012238993 gen 2592
  kernel: #011key 122 (40538132480 168 4096) block 64012255232 gen 2592

Obviously the key 121 is corrupted and not continuous with other keys.

Furthermore, the generation looks good, so it looks like a range of
memory is corrupted.
The affected range includes the key and block ptr bytenr.

And for the other write time failure, it may be a bit flip (0x01 ->
0x21), at least there is no other obvious corruption unlike the node
pointer error.

Considering it's a VM for fedora project, I guess it has ECC memory so
that we can rule out the memory corruption by hardware.

[9 SEP]
Is the dmesg truncated? For every EUCLEAN case from
__btrfs_free_extent() we should have an error message line (that's the
standard practice to have an error message for each EUCLEAN error).

I can not see the needed error line, thus hard to say.

Thanks,
Qu

> --
> Chris Murphy
>

