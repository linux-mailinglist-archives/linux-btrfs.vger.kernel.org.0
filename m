Return-Path: <linux-btrfs+bounces-13124-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1942AA91908
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 12:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD035A3A65
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 10:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62105232363;
	Thu, 17 Apr 2025 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Jq/Y5u9i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBC522FDF0
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884935; cv=none; b=u3JotS0x72ZoApeQa6wofAki79SzJhCZOOvOw10mJ1Rp6u6HUaYDuZam0GHRnkaFU8fe7TusqP1B/Dz2PwZ2nQcjq8359jQbiRyN7/JZiYF4YHPM9iSwe4Mlo3dIa4jjvjCgxhoughx0f0y8vG30ItPW3g4UCRPONGefry9snIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884935; c=relaxed/simple;
	bh=NuUWt8rlf/VFJzsB0/fE1dIgUkiJHPR+bsm1qhBiPs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ush+zFYphlZuWWP0a8MXyrj/yMLnRlI4JEHTNUg4OmY31A+8hzrt/nRsbaMPFU4paEVAZRnE8NWT25WtfSrpTseBLOq4JaKknvEPcgxttxGVZ1BI+kEVegujYUrtu5be/eeku1sIrsVv2XCnlV7Rq2M+4FlGOYppsI6tI7OWhAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Jq/Y5u9i; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744884929; x=1745489729; i=quwenruo.btrfs@gmx.com;
	bh=Mpj6n4+3hp049c6YIvRGMs0kXDllSKy/PpOUpKRGOT4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Jq/Y5u9ianwoRUUg81sqFZz+7DB1Dh7b3PGX/yMpgEAcndNZtrmFUnGnI2259swG
	 ZOj2WA1st/cIjSQ3g9Rch9SeZ61IZ8rYG8y0o0xLSvYAAbgBf/JdYwJcU6/SnuIG6
	 aJL8Cene51Up4RsUTa8kgpJxzJXNcGjFL9y73hEn0aKTxRTdSbAx9f2DcI5o75s+G
	 +KhQPV4pG04h5Z1J2rRB0c6fae8EYvnvRa1fgrxiCq38nOn5kxJzmawTe9YN/2gyI
	 EEmaXab69HFFHu3SfUeMrGDvgH8/Ly0fkJLBGfIDgRGsyouAAAYqmvzDNHjb/u04Q
	 4aHbuz/J2VbVmmsF2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6KYb-1vBeIb27OT-01607D; Thu, 17
 Apr 2025 12:15:29 +0200
Message-ID: <8ad1f78e-3ea0-4a50-8d9b-f0078ff0f810@gmx.com>
Date: Thu, 17 Apr 2025 19:45:24 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs v6.15-rc2 baseline
To: Luis Chamberlain <mcgrof@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org
Cc: kdevops@lists.linux.dev
References: <Z__4Fu6VsCVDFKkO@bombadil.infradead.org>
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
In-Reply-To: <Z__4Fu6VsCVDFKkO@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0sumtxYFWqHlmFiA6WhEHa6kf6iFnAwbk5oeTbVNKNhUMDNUzLA
 DQ9nWhgNMt1pnNap94WDNwfxb5zwwN12MwdJhbk2LBh+Dw1YPrfYRM7Unf+REvHaN7Mx9RH
 TZ47mb9H7DLXPq31FRoWIkTSvm/EYVidk13R22f5wCS+cnBR1fRGGd95cIPeFra8TIXphDK
 qprDfP28xftgRQq+NsYcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f0H3UQzQqRc=;qFTzyPJdclATJJNwxfUpOf7mO2Q
 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
 w==



=E5=9C=A8 2025/4/17 04:03, Luis Chamberlain =E5=86=99=E9=81=93:
> btrfs developers,
>=20
> kdevops has run fstests on v6.15-rc2 across the different btrfs profiles
> it currently defines, and the results are below.
>=20
> The btrfs profiles which kdevops currently supports are:
>=20
>    - btrfs_simple

It looks like the simple doesn't really mean "simply the default mkfs=20
options"?
Which is a surprise to me, as I'm digging into all the failures and only=
=20
at generic/015 I noticed this.

I really wish you can put `default` as the first profile.

>    - btrfs_nohofspace
>    - btrfs_noholes
>    - btrfs_holes
>    - btrfs_holes_zstd
>    - btrfs_noholes_lzo
>    - btrfs_fspace
>    - btrfs_noholes_zlib
>    - btrfs_noholes_zstd
>=20
> These are defined in the btrfs jinja2 template on kdevops [0] and descri=
bed
> on the ext4 kconfig [1]. Adding support for more profiles is just a matt=
er
> of editing these two files, please feel free to send a patch if you'd li=
ke
> kdevops to test more profiles. A full tarball of the fstests results are
> available on kdevops-results-archive [2]. Since we leverage git-lfs, you=
 can
> opt to only download this single tarball as follows:
>=20
> GIT_LFS_SKIP_SMUDGE=3D1 git clone https://github.com/linux-kdevops/kdevo=
ps-results-archive.git
> cd kdevops-results-archive
> git lfs fetch --include "fstests/gh/linux-btrfs-kpd/20250416/0001/linux-=
6-15-rc2/8ffd015db85f.xz"
> git lfs checkout "fstests/gh/linux-btrfs-kpd/20250416/0001/linux-6-15-rc=
2/8ffd015db85f.xz"

I guess it's better to name the archive as "*.tar.xz" (so that
*sh-completion can work).

>=20
> Few questions:
>=20
>   - Is this useful information?
>   - Do you want results for each rc release posted to the mailing list?

Definitely yes for both answers.

Especially the history of each release (each rc may be a little=20
overkilled, normally -rc1 and release would be good enough) is very=20
useful to do a quick pin down of certain bugs.

But before the quick failure analyse for btrfs-simple (really bad name=20
though), I'm wondering why there is no default one?
I can not find the default result inside the assets.

>=20
> KERNEL:    6.15.0-rc2-g8ffd015db85f
> CPUS:      8
> MEMORY:    4 GiB
>=20
> btrfs_simple: 1064 tests, 24 failures, 244 skipped, 12131 seconds
- btrfs/002
   OOM? What's going on? It killed the test case, thus failed.

- btrfs/170
   ENOSPC. This may be caused by metadata ENOSPC, which is further caused
   by the SINGLE profile, which gives a very small size compared to other
   profiles.

   We should address the default data/metadata chunk sizes in mkfs.btrfs.

- btrfs/220
- btrfs/226
   Both look like some older fstests repo.
   Especially btrfs/226 is updated to handle a recent direct IO fix.

- btrfs/271
   It looks like the mkfs.btrfs is not using RAID1 as the mkfs is
   specified to use "-m single".

   Need to enhance the test case.

- btrfs/300
   Looks like permission mask problems, as the failure has all the write
   permission for group owners and there is a weird "permission denied"
   error.

   The later may have btrfs-progs involved?

- btrfs/315
   The error messasge is a little different, "()" -> "system call".
   Maybe something related to "mount" itself?

- generic/015
- generic/17[1234]
   Those are ENOSPC behavior related, need to dig a little deeper.

- generic/371
- generic/511
- generic/546
- generic/679
   Again ENOSPC related, and I still suspect it's related to the
   default metadata chunk size.

- generic/633
- generic/64[45]
   Idmapp mount related, need further dig.

- generic/656
- generic/689
- generic/696
   Looks like some vfs tests, not sure why they fail.
   But since they are using the TEST_DEV, maybe something nor properly
   cleaned up at test failure?

- generic/730
   The dmesg shows no symbol for __get_urandom_u32_below, maybe
   related to that?

- generic/747
   The known failure.


Before I dig deeper, I really hope a default mkfs option run can be added.

Thanks,
Qu

>    Failures: btrfs/002 btrfs/170 btrfs/220 btrfs/226 btrfs/271
>      btrfs/300 btrfs/315 generic/015 generic/171 generic/172
>      generic/173 generic/174 generic/371 generic/511 generic/546
>      generic/633 generic/644 generic/645 generic/656 generic/679
>      generic/689 generic/696 generic/730 generic/747
> btrfs_nohofspace: 1064 tests, 14 failures, 235 skipped, 13468 seconds
>    Failures: btrfs/002 btrfs/192 btrfs/220 btrfs/226 btrfs/300
>      btrfs/315 generic/633 generic/644 generic/645 generic/656
>      generic/689 generic/696 generic/730 generic/747
> btrfs_noholes: 1064 tests, 193 failures, 235 skipped, 13744 seconds
>    Failures: btrfs/002 btrfs/028 btrfs/049 btrfs/121 btrfs/122
>      btrfs/123 btrfs/126 btrfs/149 btrfs/153 btrfs/156 btrfs/180
>      btrfs/181 btrfs/182 btrfs/183 btrfs/187 btrfs/189 btrfs/191
>      btrfs/193 btrfs/194 btrfs/199 btrfs/200 btrfs/203 btrfs/204
>      btrfs/205 btrfs/210 btrfs/212 btrfs/213 btrfs/214 btrfs/215
>      btrfs/217 btrfs/220 btrfs/223 btrfs/226 btrfs/228 btrfs/229
>      btrfs/242 btrfs/245 btrfs/246 btrfs/251 btrfs/258 btrfs/259
>      btrfs/263 btrfs/279 btrfs/281 btrfs/283 btrfs/285 btrfs/287
>      btrfs/295 btrfs/299 btrfs/300 btrfs/301 btrfs/310 btrfs/315
>      btrfs/316 btrfs/319 btrfs/322 btrfs/331 generic/102 generic/157
>      generic/158 generic/161 generic/162 generic/163 generic/164
>      generic/165 generic/166 generic/167 generic/168 generic/170
>      generic/171 generic/172 generic/173 generic/174 generic/176
>      generic/183 generic/185 generic/188 generic/189 generic/190
>      generic/191 generic/194 generic/195 generic/196 generic/197
>      generic/199 generic/200 generic/201 generic/202 generic/203
>      generic/242 generic/243 generic/253 generic/254 generic/259
>      generic/265 generic/266 generic/267 generic/268 generic/271
>      generic/272 generic/276 generic/278 generic/279 generic/281
>      generic/282 generic/283 generic/284 generic/287 generic/289
>      generic/290 generic/291 generic/292 generic/293 generic/295
>      generic/296 generic/297 generic/298 generic/301 generic/302
>      generic/329 generic/330 generic/331 generic/332 generic/333
>      generic/334 generic/353 generic/356 generic/357 generic/358
>      generic/359 generic/373 generic/374 generic/387 generic/414
>      generic/415 generic/447 generic/457 generic/493 generic/501
>      generic/513 generic/514 generic/515 generic/517 generic/518
>      generic/540 generic/541 generic/542 generic/543 generic/544
>      generic/546 generic/562 generic/588 generic/614 generic/628
>      generic/629 generic/630 generic/633 generic/634 generic/643
>      generic/644 generic/645 generic/648 generic/656 generic/657
>      generic/658 generic/659 generic/660 generic/661 generic/662
>      generic/663 generic/664 generic/665 generic/666 generic/667
>      generic/668 generic/669 generic/670 generic/671 generic/672
>      generic/673 generic/674 generic/675 generic/689 generic/696
>      generic/698 generic/702 generic/730 generic/732 generic/733
>      generic/738 generic/741 generic/747 generic/754
> btrfs_holes: 1064 tests, 192 failures, 235 skipped, 13880 seconds
>    Failures: btrfs/002 btrfs/028 btrfs/049 btrfs/121 btrfs/122
>      btrfs/123 btrfs/126 btrfs/149 btrfs/153 btrfs/156 btrfs/180
>      btrfs/181 btrfs/182 btrfs/183 btrfs/187 btrfs/189 btrfs/191
>      btrfs/193 btrfs/194 btrfs/199 btrfs/200 btrfs/203 btrfs/204
>      btrfs/205 btrfs/210 btrfs/212 btrfs/213 btrfs/214 btrfs/215
>      btrfs/217 btrfs/220 btrfs/223 btrfs/226 btrfs/228 btrfs/229
>      btrfs/242 btrfs/245 btrfs/246 btrfs/251 btrfs/258 btrfs/259
>      btrfs/263 btrfs/279 btrfs/281 btrfs/283 btrfs/285 btrfs/287
>      btrfs/295 btrfs/299 btrfs/300 btrfs/301 btrfs/310 btrfs/315
>      btrfs/316 btrfs/319 btrfs/322 btrfs/331 generic/157 generic/158
>      generic/161 generic/162 generic/163 generic/164 generic/165
>      generic/166 generic/167 generic/168 generic/170 generic/171
>      generic/172 generic/173 generic/174 generic/176 generic/183
>      generic/185 generic/188 generic/189 generic/190 generic/191
>      generic/194 generic/195 generic/196 generic/197 generic/199
>      generic/200 generic/201 generic/202 generic/203 generic/242
>      generic/243 generic/253 generic/254 generic/259 generic/265
>      generic/266 generic/267 generic/268 generic/271 generic/272
>      generic/276 generic/278 generic/279 generic/281 generic/282
>      generic/283 generic/284 generic/287 generic/289 generic/290
>      generic/291 generic/292 generic/293 generic/295 generic/296
>      generic/297 generic/298 generic/301 generic/302 generic/329
>      generic/330 generic/331 generic/332 generic/333 generic/334
>      generic/353 generic/356 generic/357 generic/358 generic/359
>      generic/373 generic/374 generic/387 generic/414 generic/415
>      generic/447 generic/457 generic/493 generic/501 generic/513
>      generic/514 generic/515 generic/517 generic/518 generic/540
>      generic/541 generic/542 generic/543 generic/544 generic/546
>      generic/562 generic/588 generic/614 generic/628 generic/629
>      generic/630 generic/633 generic/634 generic/643 generic/644
>      generic/645 generic/648 generic/656 generic/657 generic/658
>      generic/659 generic/660 generic/661 generic/662 generic/663
>      generic/664 generic/665 generic/666 generic/667 generic/668
>      generic/669 generic/670 generic/671 generic/672 generic/673
>      generic/674 generic/675 generic/689 generic/696 generic/698
>      generic/702 generic/730 generic/732 generic/733 generic/738
>      generic/741 generic/747 generic/754
> btrfs_holes_zstd: 1064 tests, 196 failures, 256 skipped, 15608 seconds
>    Failures: btrfs/011 btrfs/028 btrfs/049 btrfs/121 btrfs/122
>      btrfs/123 btrfs/149 btrfs/153 btrfs/180 btrfs/181 btrfs/182
>      btrfs/183 btrfs/187 btrfs/189 btrfs/191 btrfs/193 btrfs/194
>      btrfs/199 btrfs/200 btrfs/203 btrfs/204 btrfs/205 btrfs/210
>      btrfs/212 btrfs/213 btrfs/214 btrfs/215 btrfs/217 btrfs/220
>      btrfs/223 btrfs/226 btrfs/228 btrfs/229 btrfs/242 btrfs/245
>      btrfs/246 btrfs/251 btrfs/258 btrfs/259 btrfs/263 btrfs/265
>      btrfs/266 btrfs/267 btrfs/268 btrfs/269 btrfs/279 btrfs/281
>      btrfs/283 btrfs/285 btrfs/287 btrfs/288 btrfs/289 btrfs/295
>      btrfs/297 btrfs/299 btrfs/300 btrfs/310 btrfs/315 btrfs/316
>      btrfs/319 btrfs/322 btrfs/331 generic/157 generic/158 generic/161
>      generic/162 generic/163 generic/164 generic/165 generic/166
>      generic/167 generic/168 generic/170 generic/171 generic/172
>      generic/173 generic/174 generic/176 generic/183 generic/185
>      generic/188 generic/189 generic/190 generic/191 generic/194
>      generic/195 generic/196 generic/197 generic/199 generic/200
>      generic/201 generic/202 generic/203 generic/225 generic/242
>      generic/243 generic/253 generic/254 generic/259 generic/265
>      generic/266 generic/267 generic/268 generic/271 generic/272
>      generic/276 generic/278 generic/279 generic/281 generic/282
>      generic/283 generic/284 generic/287 generic/289 generic/290
>      generic/291 generic/292 generic/293 generic/295 generic/296
>      generic/297 generic/298 generic/301 generic/302 generic/329
>      generic/330 generic/331 generic/332 generic/333 generic/334
>      generic/353 generic/356 generic/357 generic/358 generic/359
>      generic/373 generic/374 generic/387 generic/414 generic/415
>      generic/447 generic/493 generic/501 generic/513 generic/514
>      generic/515 generic/517 generic/518 generic/540 generic/541
>      generic/542 generic/543 generic/544 generic/546 generic/562
>      generic/588 generic/614 generic/628 generic/629 generic/630
>      generic/633 generic/634 generic/643 generic/644 generic/645
>      generic/648 generic/656 generic/657 generic/658 generic/659
>      generic/660 generic/661 generic/662 generic/663 generic/664
>      generic/665 generic/666 generic/667 generic/668 generic/669
>      generic/670 generic/671 generic/672 generic/673 generic/674
>      generic/675 generic/689 generic/696 generic/698 generic/702
>      generic/730 generic/732 generic/733 generic/738 generic/741
>      generic/754
> btrfs_noholes_lzo: 1064 tests, 198 failures, 248 skipped, 15934 seconds
>    Failures: btrfs/011 btrfs/028 btrfs/049 btrfs/121 btrfs/122
>      btrfs/123 btrfs/149 btrfs/153 btrfs/180 btrfs/181 btrfs/182
>      btrfs/183 btrfs/187 btrfs/189 btrfs/191 btrfs/193 btrfs/194
>      btrfs/199 btrfs/200 btrfs/203 btrfs/204 btrfs/205 btrfs/210
>      btrfs/212 btrfs/213 btrfs/214 btrfs/215 btrfs/217 btrfs/220
>      btrfs/223 btrfs/226 btrfs/228 btrfs/229 btrfs/242 btrfs/245
>      btrfs/246 btrfs/251 btrfs/258 btrfs/259 btrfs/263 btrfs/265
>      btrfs/266 btrfs/267 btrfs/268 btrfs/269 btrfs/279 btrfs/281
>      btrfs/283 btrfs/285 btrfs/287 btrfs/288 btrfs/289 btrfs/294
>      btrfs/295 btrfs/297 btrfs/299 btrfs/300 btrfs/310 btrfs/315
>      btrfs/316 btrfs/319 btrfs/322 btrfs/331 generic/157 generic/158
>      generic/161 generic/162 generic/163 generic/164 generic/165
>      generic/166 generic/167 generic/168 generic/170 generic/171
>      generic/172 generic/173 generic/174 generic/176 generic/183
>      generic/185 generic/188 generic/189 generic/190 generic/191
>      generic/194 generic/195 generic/196 generic/197 generic/199
>      generic/200 generic/201 generic/202 generic/203 generic/225
>      generic/242 generic/243 generic/253 generic/254 generic/259
>      generic/265 generic/266 generic/267 generic/268 generic/271
>      generic/272 generic/276 generic/278 generic/279 generic/281
>      generic/282 generic/283 generic/284 generic/287 generic/289
>      generic/290 generic/291 generic/292 generic/293 generic/295
>      generic/296 generic/297 generic/298 generic/301 generic/302
>      generic/329 generic/330 generic/331 generic/332 generic/333
>      generic/334 generic/353 generic/356 generic/357 generic/358
>      generic/359 generic/373 generic/374 generic/387 generic/414
>      generic/415 generic/447 generic/457 generic/493 generic/501
>      generic/513 generic/514 generic/515 generic/517 generic/518
>      generic/540 generic/541 generic/542 generic/543 generic/544
>      generic/546 generic/562 generic/588 generic/614 generic/628
>      generic/629 generic/630 generic/633 generic/634 generic/643
>      generic/644 generic/645 generic/648 generic/656 generic/657
>      generic/658 generic/659 generic/660 generic/661 generic/662
>      generic/663 generic/664 generic/665 generic/666 generic/667
>      generic/668 generic/669 generic/670 generic/671 generic/672
>      generic/673 generic/674 generic/675 generic/689 generic/696
>      generic/698 generic/702 generic/730 generic/732 generic/733
>      generic/738 generic/741 generic/754
> btrfs_fspace: 1064 tests, 14 failures, 235 skipped, 16601 seconds
>    Failures: btrfs/002 btrfs/192 btrfs/220 btrfs/226 btrfs/300
>      btrfs/315 generic/633 generic/644 generic/645 generic/656
>      generic/689 generic/696 generic/730 generic/747
> btrfs_noholes_zlib: 1064 tests, 197 failures, 248 skipped, 18301 seconds
>    Failures: btrfs/011 btrfs/028 btrfs/049 btrfs/121 btrfs/122
>      btrfs/123 btrfs/149 btrfs/153 btrfs/180 btrfs/181 btrfs/182
>      btrfs/183 btrfs/187 btrfs/189 btrfs/191 btrfs/193 btrfs/194
>      btrfs/199 btrfs/200 btrfs/203 btrfs/204 btrfs/205 btrfs/210
>      btrfs/212 btrfs/213 btrfs/214 btrfs/215 btrfs/217 btrfs/220
>      btrfs/223 btrfs/226 btrfs/228 btrfs/229 btrfs/242 btrfs/245
>      btrfs/246 btrfs/251 btrfs/258 btrfs/259 btrfs/263 btrfs/265
>      btrfs/266 btrfs/267 btrfs/268 btrfs/269 btrfs/279 btrfs/281
>      btrfs/283 btrfs/285 btrfs/287 btrfs/288 btrfs/289 btrfs/295
>      btrfs/297 btrfs/299 btrfs/300 btrfs/310 btrfs/315 btrfs/316
>      btrfs/319 btrfs/322 btrfs/331 generic/157 generic/158 generic/161
>      generic/162 generic/163 generic/164 generic/165 generic/166
>      generic/167 generic/168 generic/170 generic/171 generic/172
>      generic/173 generic/174 generic/176 generic/183 generic/185
>      generic/188 generic/189 generic/190 generic/191 generic/194
>      generic/195 generic/196 generic/197 generic/199 generic/200
>      generic/201 generic/202 generic/203 generic/225 generic/242
>      generic/243 generic/253 generic/254 generic/259 generic/265
>      generic/266 generic/267 generic/268 generic/271 generic/272
>      generic/276 generic/278 generic/279 generic/281 generic/282
>      generic/283 generic/284 generic/287 generic/289 generic/290
>      generic/291 generic/292 generic/293 generic/295 generic/296
>      generic/297 generic/298 generic/301 generic/302 generic/329
>      generic/330 generic/331 generic/332 generic/333 generic/334
>      generic/353 generic/356 generic/357 generic/358 generic/359
>      generic/373 generic/374 generic/387 generic/414 generic/415
>      generic/447 generic/457 generic/493 generic/501 generic/513
>      generic/514 generic/515 generic/517 generic/518 generic/540
>      generic/541 generic/542 generic/543 generic/544 generic/546
>      generic/562 generic/588 generic/614 generic/628 generic/629
>      generic/630 generic/633 generic/634 generic/643 generic/644
>      generic/645 generic/648 generic/656 generic/657 generic/658
>      generic/659 generic/660 generic/661 generic/662 generic/663
>      generic/664 generic/665 generic/666 generic/667 generic/668
>      generic/669 generic/670 generic/671 generic/672 generic/673
>      generic/674 generic/675 generic/689 generic/696 generic/698
>      generic/702 generic/730 generic/732 generic/733 generic/738
>      generic/741 generic/754
> btrfs_noholes_zstd: 1064 tests, 197 failures, 248 skipped, 27142 seconds
>    Failures: btrfs/011 btrfs/028 btrfs/049 btrfs/121 btrfs/122
>      btrfs/123 btrfs/149 btrfs/153 btrfs/180 btrfs/181 btrfs/182
>      btrfs/183 btrfs/187 btrfs/189 btrfs/191 btrfs/193 btrfs/194
>      btrfs/199 btrfs/200 btrfs/203 btrfs/204 btrfs/205 btrfs/210
>      btrfs/212 btrfs/213 btrfs/214 btrfs/215 btrfs/217 btrfs/220
>      btrfs/223 btrfs/226 btrfs/228 btrfs/229 btrfs/242 btrfs/245
>      btrfs/246 btrfs/251 btrfs/258 btrfs/259 btrfs/263 btrfs/265
>      btrfs/266 btrfs/267 btrfs/268 btrfs/269 btrfs/279 btrfs/281
>      btrfs/283 btrfs/285 btrfs/287 btrfs/288 btrfs/289 btrfs/295
>      btrfs/297 btrfs/299 btrfs/300 btrfs/310 btrfs/315 btrfs/316
>      btrfs/319 btrfs/322 btrfs/331 generic/157 generic/158 generic/161
>      generic/162 generic/163 generic/164 generic/165 generic/166
>      generic/167 generic/168 generic/170 generic/171 generic/172
>      generic/173 generic/174 generic/176 generic/183 generic/185
>      generic/188 generic/189 generic/190 generic/191 generic/194
>      generic/195 generic/196 generic/197 generic/199 generic/200
>      generic/201 generic/202 generic/203 generic/225 generic/242
>      generic/243 generic/253 generic/254 generic/259 generic/265
>      generic/266 generic/267 generic/268 generic/271 generic/272
>      generic/276 generic/278 generic/279 generic/281 generic/282
>      generic/283 generic/284 generic/287 generic/289 generic/290
>      generic/291 generic/292 generic/293 generic/295 generic/296
>      generic/297 generic/298 generic/301 generic/302 generic/329
>      generic/330 generic/331 generic/332 generic/333 generic/334
>      generic/353 generic/356 generic/357 generic/358 generic/359
>      generic/373 generic/374 generic/387 generic/414 generic/415
>      generic/447 generic/457 generic/493 generic/501 generic/513
>      generic/514 generic/515 generic/517 generic/518 generic/540
>      generic/541 generic/542 generic/543 generic/544 generic/546
>      generic/562 generic/588 generic/614 generic/628 generic/629
>      generic/630 generic/633 generic/634 generic/643 generic/644
>      generic/645 generic/648 generic/656 generic/657 generic/658
>      generic/659 generic/660 generic/661 generic/662 generic/663
>      generic/664 generic/665 generic/666 generic/667 generic/668
>      generic/669 generic/670 generic/671 generic/672 generic/673
>      generic/674 generic/675 generic/689 generic/696 generic/698
>      generic/702 generic/730 generic/732 generic/733 generic/738
>      generic/741 generic/754
> Totals: 9576 tests, 2184 skipped, 1225 failures, 0 errors, 137340s
>=20


