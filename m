Return-Path: <linux-btrfs+bounces-5198-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3708CBB95
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 08:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3123F282922
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 06:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384C477F32;
	Wed, 22 May 2024 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Bc17jaqq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455B52033A
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716360637; cv=none; b=jT0kiP8btaub8Mx8nNkB2TmVfvQP9l2ziFDfBdhKh7TzOUxNSkfAss3gN2Y2E2IFEjIdVXm9hpsdirFFPNfgWS5VxRJvVwAFRXwyKhKXrFGjRVy7iZve4vHBGHHtzHW4esbIHPsTCJilAbgWOY+kPBFOIF3M+SQZeseP8CVkBdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716360637; c=relaxed/simple;
	bh=bbzhulLOR44r56rBzJ6Nd5FBKw+qJfnbgVfHEiEBqL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tYp2EcWLFBxs7rpk4OfCvl7Y9UhbrJrp9bkPcubikiRbwLKkmTln/tfHP+rAhaOLX/gfDpg5NlIVmQimFjzUXPLPlsPlMCcGplw7pZAR4UMjbSuTb0sxcYRTbUASjcesobne8AzUANp23VCrvGunzGC1bP/TSl7zjWzQDjjD6XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Bc17jaqq; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1716360631; x=1716965431; i=quwenruo.btrfs@gmx.com;
	bh=KsJ88Q2T6pL7eyLCZVYpCYh2BXfWeVlQ3WarVAAGZsQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Bc17jaqqzAU0V/xy882eN8hzb92Pd2tk652oPaQlQvZRDTBSqGFplL+1z6tUeSzK
	 DtfE+s1MEOiLazF/qt7PD88ChpZ9aXJl7segzEwTwp4Qpe51JhtFd108yatheD4nC
	 8k6Ko5Nm6qSEl1tgmSy6MiGszA082C1ID3uUUijGLMtftzLeL18TfETQJES7bkST3
	 uRqayT140epjG4XFslMpOwTuiDpcm2ro20okyTrokZYjFH1bi04fPyZmI++D3lLja
	 WXb1KTiNfbW7oS7oVE7ZdFYb4HBsXWV+Z0aWb2TnwRNV6P+nGFoIXAb1MrBqgRV2+
	 6AaS9/lmcOhIo5Ha7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPXdC-1rx4tg1Vac-00QE94; Wed, 22
 May 2024 08:50:31 +0200
Message-ID: <dfd8887b-a2cb-425f-8705-0d6a94cefb9c@gmx.com>
Date: Wed, 22 May 2024 16:20:26 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] btrfs-progs: zoned: proper "mkfs.btrfs -b"
 support
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20240522060232.3569226-1-naohiro.aota@wdc.com>
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
In-Reply-To: <20240522060232.3569226-1-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tuou5bzEzZDochAnJQKOYBoxq4drrFUWKgQ8YP4dty7UklFQ2RV
 na7xjJs+p0iHoBUGksU3U2A5/AdpuRI1PHtyoPaHK2XlqKXO+pMTP3no93on8Dl7dihpNGN
 vohC+fyavGtOEyzLu89kAOzBLvSmx/mqcHWqT6qhhjhLlAZN5JsErPbCoKDb4QfNGbxyORT
 j8DjPmGraeRyoiisP9RTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IP3uvFEZUHU=;d6zx9ud9rIqo0OWpH0D/aw3f8K0
 n30H/mcXL4SGlYlByQDh09B02jGK4zBqJYHHy3OepaWe/mkWfYkh4XG2gEUNp118qfSdMPWi6
 u1YaHKHmtf/xPq8i6riECi+ugwBOiH4LDCyMSxH0AxCC3UJk2x5vagJoiZF4sXSwe5D02U1f6
 Od7vZz6fAC/TxhpKFbWmuaRAV2MkLOBSpvCsyVpb3+QHexsgQqKBwmBWaxDlMW9hhpWmWtlWj
 wpAKv/vlfqJBysAjFJV0Kd5knJ9qL+rRuKSc0oqK6Jzg3WTo8y4MjWqqVYYMOGD7YEZcrrw/c
 RmkcLPs8Tl2P+SpRDqnm7bz004TlToYnMlkVkDccO1Yq7cDOwEd8xn5VVuMT0sbX+9AHukzYW
 5Kyl870zcEYzGM1FhLUTOph4R4AHj6w/BrvJHvKxXsP7dh1zSaAmgKB4jgn8ADfmfD3ywNeUj
 WWPiMlGLRkf7vRGUkfb8hv19ZRhkLoK99oas/XD22VQz4ZhFsdrnhkjSP+tKBMRJjDNDLD4V4
 ptMYoLj0UbNi6dbbthmWS9il0EFcbVaCt/x/Ivv3qY+mYav3T/mcEwFgUAjzvPbG+EnWwhwLp
 CI4QBYujcZtUx8jenOCEIAkAYfxWQmw2Ac9cy4sn/E2Ll+ZZp7b7EiJiIxwUKim6eqdE7Mt6w
 TZkZi/SyKctxxltsQ9tKm/nJ7ttxVl0s1/3Pf6ev/PCz8GRTzX2SvPwat/CuQIkJYpwSi7c8g
 UPeKIMLkeviYwxcgVgg5DC5MjzarzNuUral1SxOq1/zO4UcNX8Q/Ykm0nsEucFI6/vG1ZBEZO
 MBsgLfdB3E8hBcqxa6Gb+jZxb2bxn06ZzmoQWLczydMhU=



=E5=9C=A8 2024/5/22 15:32, Naohiro Aota =E5=86=99=E9=81=93:
> mkfs.btrfs -b <byte_count> on a zoned device has several issues listed
> below.
>
> - The FS size needs to be larger than minimal size that can host a btrfs=
,
>    but its calculation does not consider non-SINGLE profile
> - The calculation also does not ensure tree-log BG and data relocation B=
G
> - It allows creating a FS not aligned to the zone boundary
> - It resets all device zones beyond the specified length
>
> This series fixes the issues with some cleanups.
>
> This one passed CI workflow here:
>
> Patches 1 to 3 are clean up patches, so they should not change the behav=
ior.
>
> Patches 4 to 6 address the issues.
>
> Patches 7 to 10 add/modify the test cases. First, patch 7 adds nullb
> functions to use in later patches. Patch 8 adds a new test for
> zone resetting. And, patches 9 and 10 rewrites existing tests with the
> nullb helper.

Looks good to me overall, with only one small problem related to patch 5
commented.

You can add my reviewed-by after fixing that small
round_down()/round_up() problem.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
> Changes:
> - v3:
>    - Tweak minimum FS size calculation style.
>    - Round down the specified byte_count towards sectorsize and zone
>      size, instead of banning unaligned byte_count.
>    - Add active zone description in the commit log of patch 6.
>    - Add nullb test functions and use them in tests.
> - v2: https://lore.kernel.org/linux-btrfs/20240514182227.1197664-1-naohi=
ro.aota@wdc.com/T/#t
>    - fix function declaration on older distro (non-ZONED setup)
>    - fix mkfs test failure
> - v1: https://lore.kernel.org/linux-btrfs/20240514005133.44786-1-naohiro=
.aota@wdc.com/
>
> Naohiro Aota (10):
>    btrfs-progs: rename block_count to byte_count
>    btrfs-progs: mkfs: remove duplicated device size check
>    btrfs-progs: mkfs: unify zoned mode minimum size calc into
>      btrfs_min_dev_size()
>    btrfs-progs: mkfs: fix minimum size calculation for zoned mode
>    btrfs-progs: mkfs: align byte_count with sectorsize and zone size
>    btrfs-progs: support byte length for zone resetting
>    btrfs-progs: test: add nullb setup functions
>    btrfs-progs: test: add test for zone resetting
>    btrfs-progs: test: use nullb helper and smaller zone size
>    btrfs-progs: test: use nullb helpers in 031-zoned-bgt
>
>   common/device-utils.c                    | 45 +++++++-----
>   kernel-shared/zoned.c                    | 23 ++++++-
>   kernel-shared/zoned.h                    |  7 +-
>   mkfs/common.c                            | 62 ++++++++++++++---
>   mkfs/common.h                            |  2 +-
>   mkfs/main.c                              | 88 ++++++++++--------------
>   tests/common                             | 63 +++++++++++++++++
>   tests/mkfs-tests/030-zoned-rst/test.sh   | 14 ++--
>   tests/mkfs-tests/031-zoned-bgt/test.sh   | 30 ++------
>   tests/mkfs-tests/032-zoned-reset/test.sh | 43 ++++++++++++
>   10 files changed, 259 insertions(+), 118 deletions(-)
>   create mode 100755 tests/mkfs-tests/032-zoned-reset/test.sh
>
> --
> 2.45.1
>
>

