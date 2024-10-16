Return-Path: <linux-btrfs+bounces-8954-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AC49A0031
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 06:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52D20B2688F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 04:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C97F18B49F;
	Wed, 16 Oct 2024 04:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="c9T99MWz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8B118B47A;
	Wed, 16 Oct 2024 04:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052724; cv=none; b=mEWk8tSma5NTr8Et7ocCCBwCf+MjNhCDDlcaPf0xumEX9/1E34K6Yg6AafIIWtzRghcliN+Wyy7E4C7RzawzcQ5eqQ2JgkuKFn+Z+suCOTVv0E9P3CxpgTshY78SSbupFxraylOgGZcrwueZgoF19ua5ZAtEAqaw3U/Exupxugk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052724; c=relaxed/simple;
	bh=uqvk/tRj+S6ibTglXMsQluv2gY7fdie13fTs0LCIjOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CGYOe8BY/o3RkPDPFTC2RS1108Z40CV/ymbUg4J+gKjNoI9XBw3ZioYTXGNnlxb8V3XHQK/rC3UdGp339QovKlMqweBw3Mgxv7rgMYuL74dM0Qb28UPkyzuxs7GxdmPT3i15NnmnBnVr6TdWNJaOXYxFAf0QN6Ice5s2hDxeEr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=c9T99MWz; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729052713; x=1729657513; i=quwenruo.btrfs@gmx.com;
	bh=x8kEetWCVFd7YmYiLs+qXShY70fxVgqv2o+yrzHNepo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=c9T99MWzphlYUOI17AMFd0qSJlBVBT8ZLJ8aSsyjA8L79wfYn7hQ4YrqgJt0Q8Kb
	 nGns3Okwm52OFQr2nyZIeLVQhgfcG4MI6xeOY+b24a61uwksxEwCvEhrnbhYD1WVs
	 d5XnBQEjKsHQ4QiEzvxm14OtWr6SQr3JJznVvhw38JI9fmn8lE4WjD6L+Jb/5fIHi
	 L/B4QZAiCJujaIZcN0MUNQMinAZ39xV+wjcZbmZ7q8HSLh7PvSNtBAKeuvf0+l4R3
	 6gUmWP0Ic7Feo9S7t2uT31mlMpZwxrD49A5gcWEPnkwL3heiC1IXmEy+sZc9SF3Go
	 H2a69afI3ozoCiKQJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1po0-1syjjc3voW-002FTa; Wed, 16
 Oct 2024 06:25:13 +0200
Message-ID: <7773a237-9c97-42c4-8548-913faa24654b@gmx.com>
Date: Wed, 16 Oct 2024 14:55:09 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: add test for cleaner thread under seed-sprout
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com, fstests@vger.kernel.org
References: <9925ac0001b867a523a8c9c838536b50c2b19348.1729034727.git.boris@bur.io>
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
In-Reply-To: <9925ac0001b867a523a8c9c838536b50c2b19348.1729034727.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aTA+qoTWGgWZANXFSxiLVW46RdraH08/48LVCHGYT4LvYyY6Yay
 Y9ZUV0GZd7t0WeG9jtFrXCw1H318lcwn8PNRY7NDQeJJ1zE+NHdItC4Vqz7Wv7BC+xEDktF
 1IAcb4fbJQifNw5wm31qzB/8dKptbBfcSWRm1E3EWX882m78lJ1UGNMF2+wpZM5pWrafRF3
 eiVXOj+GANly0zHlE3o+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+x67Jnb4MUk=;36XTp45IfnpeRjpKKdJADacZORY
 JB46FDT6wd0SMN1Tz5bIv+/TdqB7hUsP07vrbMsln74NZucFN820ajuGTeKkPIUmo/oNlMTW6
 9fkA9vvtuKXFFzhHNT9WMW3bKonwtN9DRxWk8i4PhNEnfKT/6LNbm1H+StV3MF1cKAuz7Zmrx
 XRjvQ8n8gqOfrieG9hbnF9+re9xSoxrhocwyl6irfNuycJudewmk49wrVEjSRHd7LICuxqOvP
 HCSScUn/KFLDIN9Vd3c8rgVCw3U/0jsOSX8KEPI9mN5a9TO9nzu6jQuvPssSDOtVeOkvAmn+u
 E5yLprvPq8roafbm0MU+Uh3do7K84EN05XhiEAQlS8GWTxurjbBDZF9aI/QAWohOyjdax9Epx
 cB5SplNtrqtp6AHqucaYggrGrbXP8pNK0W7EYzqPbuTv7qm1lT0ykOCqgD0ziCon+LjuVaFRu
 WdF4SPOLHujd3ZBDGyTcJ7eMaVZlqZjvYjn0rMJT9AvlG8AZmUn5T//UnU6ltQuQQZfXeKn48
 HLA3V7vmMnewSC/SyZ+pX2OrfrDGG4d+kIA8McHNwFtQwoOTCKtqxKbWAgG2+LqT39XBFv8H+
 nrWIlUo/v/2kvjxeRpjCvoxY+M8Tkki/uV1bR3XLO6Mtt/86cWXIEno53ALXB/eqrLWab/K1A
 EAx9jL9fwVhEQyzvB9pgU5q4fPraUF+u8nNXqFSs05rNljOKZt0vk+ZCVjw1jn40ASJsw9BGF
 mq+eRCrragyZn19zVb0i0fCN8S+UNhV7UJgppgoPMeptvw+2pS4hTHGBe6FANglf5JjCBTGne
 GuzsqXSD6O3/kgjQ+eUP6KJw==



=E5=9C=A8 2024/10/16 09:57, Boris Burkov =E5=86=99=E9=81=93:
> We have a longstanding bug that creating a seed sprout fs with the
> ro->rw transition done with
>
> mount -o remount,rw $mnt
>
> instead of
>
> umount $mnt
> mount $sprout_dev $mnt
>
> results in an fs without BTRFS_FS_OPEN set, which fails to ever run the
> critical btrfs cleaner thread.
>
> This test reproduces that bug and detects it by creating and deleting a
> subvolume, then triggering the cleaner thread. The expected behavior is
> for the cleaner thread to delete the stale subvolume and for the list to
> show no entries. Without the fix, we see a DELETED entry for the subvol.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
> Changelog:
> v2:
> - update to real copyright info
> - add extra rw->ro transition checks
> - remove unnecessary _require_test
> ---
>   tests/btrfs/323     | 49 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/323.out |  2 ++
>   2 files changed, 51 insertions(+)
>   create mode 100755 tests/btrfs/323
>   create mode 100644 tests/btrfs/323.out
>
> diff --git a/tests/btrfs/323 b/tests/btrfs/323
> new file mode 100755
> index 000000000..ca57b1a1e
> --- /dev/null
> +++ b/tests/btrfs/323
> @@ -0,0 +1,49 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 323
> +#
> +# Test that remounted seed/sprout device FS is fully functional. For ex=
ample, that it can purge stale subvolumes.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick seed remount
> +
> +. ./common/filter
> +_require_command "$BTRFS_TUNE_PROG" btrfstune
> +_require_scratch_dev_pool 2
> +
> +_fixed_by_kernel_commit XXXXXXXX \
> +	"btrfs: do not clear read-only when adding sprout device"
> +
> +_scratch_dev_pool_get 2
> +dev_seed=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
> +dev_sprout=3D$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
> +
> +# create a read-only fs based off a read-only seed device
> +_mkfs_dev $dev_seed
> +$BTRFS_TUNE_PROG -S 1 $dev_seed
> +_mount $dev_seed $SCRATCH_MNT >>$seqres.full 2>&1
> +_btrfs device add -f $dev_sprout $SCRATCH_MNT >>$seqres.full
> +
> +# switch ro to rw, checking that it was ro before and rw after
> +findmnt -n -O rw $SCRATCH_MNT
> +_mount -o remount,rw $SCRATCH_MNT
> +findmnt -n -O ro $SCRATCH_MNT
> +
> +# do stuff in the seed/sprout fs
> +_btrfs subvolume create $SCRATCH_MNT/subv
> +_btrfs subvolume delete $SCRATCH_MNT/subv
> +
> +# trigger cleaner thread without remounting
> +_btrfs filesystem sync $SCRATCH_MNT
> +
> +# expect no deleted subvolumes remaining
> +$BTRFS_UTIL_PROG subvolume list -d $SCRATCH_MNT
> +
> +_scratch_dev_pool_put
> +
> +# success, all done
> +echo "Silence is golden"
> +status=3D0
> +exit
> diff --git a/tests/btrfs/323.out b/tests/btrfs/323.out
> new file mode 100644
> index 000000000..5dba9b5f0
> --- /dev/null
> +++ b/tests/btrfs/323.out
> @@ -0,0 +1,2 @@
> +QA output created by 323
> +Silence is golden


