Return-Path: <linux-btrfs+bounces-8947-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B258299FAFA
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 00:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C801C23B6E
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 22:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABB51FBF73;
	Tue, 15 Oct 2024 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="eQJ88uVz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB50A1D63C2;
	Tue, 15 Oct 2024 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030105; cv=none; b=NmmI7KJU7tf6ZCh39AcENjNH1k41dcFqbshBEG6n4sefM7A3xIEAAoGibayZdXTbgW79SQiNNiewut9OM9666i1J19nxrVsDbus3L9RCIZprbQzUXdKZkaZP9XawyMWX/pfkz0jvFiuwTkaib9w10VB0fFHR08fGeb1cHKgZ5Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030105; c=relaxed/simple;
	bh=vhkf4bgNKCydFiw5BaVdafelI0qbEf04gvxaWG5stiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gB0FTcX7HzhCJgCXUBlSH3fH1HgCHHsLdYm/8VStGN9Veq/eogMR3Gh7YBkDtG242KqFIavAzceFrYG9KgOu7TuJXYxD+B3G0YyNvzGPTTh6E6jub3ES3UJr8BdkhktGDNpB/cZ6tXJQ0KDySrWUMGuIvSifZkbkW3eqt4YYkmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=eQJ88uVz; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729030094; x=1729634894; i=quwenruo.btrfs@gmx.com;
	bh=rArvooqrKYEsO/N0f9FrEEdUETKwAqAKXO+Akskww0A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eQJ88uVzB6woitONZxTY++tScIUUQC4CqXH82Z0N0UCzPuo2IZlGDxFk7bcAZmkY
	 onEziwiTw/xZ7FIOiEBJngssm+NlCZ/LqgvdYl0na7otkDFNaOaQJ2PGU1xU7WWF3
	 euQUPtRRgQb34DO8uQzfDjeykbrLlmokW59IeQI5MWG3r+v6Ezf4OGo/GuIgKLSEr
	 UzBbxkviJopNyu12h3Wb+1E23D28ed4mmBeFnrDgspArFj7rDTJKk0DJFGEG4ndND
	 FvJ/p/p1pqTIGc3DNiJ4GYMqHrirSrwCDLrX7RmDJkIx9XmstvPCgUKaB+sCDcaHP
	 Mhynw75UvhlZxYkwkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MzyuS-1tuBQG06mU-0174mT; Wed, 16
 Oct 2024 00:08:14 +0200
Message-ID: <37117890-c89e-4cd7-8d48-145edd2d5286@gmx.com>
Date: Wed, 16 Oct 2024 08:38:11 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add test for cleaner thread under seed-sprout
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com, fstests@vger.kernel.org
References: <37a3018160b04d127ec8eef1f1ccfb3583ce0e40.1729027883.git.boris@bur.io>
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
In-Reply-To: <37a3018160b04d127ec8eef1f1ccfb3583ce0e40.1729027883.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ia6YkUHX+Yw/GFH68/2xl2YMySf75KvlEVz03Jf+dYSkw5dT2qf
 PfaL4TIFYxtc3QquMCVgmwLrAfgTPIbVcC5m73XbT1gdsWQdYwgkGjg/uVn9nj+tKOwEK4M
 yM6kb4nrEdREVXQk+gT9ngiT9B66Ig+TePWN8nYC/fIuRo+hhI/3B/zF+sYXI7XW1TrV8eM
 D4LasouGvu+61uF/pL6Og==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JBmtMZ4SyB4=;9+bOzaLXUZU+nAdVdt8eB+5ZLd2
 b4zy+nwAXBvjFqRSXLxNFArEmb6LsbcHyDj+PkF9BuZE7JCST/Vfc8f/wjh1AqGwa2UZU/4UU
 JRi84onhLEzwD9OLiRlZPxOhOWJx3Ll7epyrjbLkyr1jHAQ7+hYVbticVlAYQueB2nqIGd/wQ
 b/HIxdu8z4wfjubxNql6c2uqv+4isHC4pUS5VoaE8YdijqgOM6DgVnVoWNhVLEOie5uFCfZDn
 JBvmESXYiKqPfliJEqMpalz/aJ+mineG08UnA5Z0DWwavltbSTp26BfMaJ3uf6pLKi3LF5DGp
 +5L4T9znp5YksmNaNJkqjbosLf4j+KtJS232DIhTdODB/JKS81ra0k4aHMDgKhk58/7T/3ocB
 ukhIhfa5QbdgHjcTgzoWdE7Z8rZ/8ybzuJ+xyhccoidkfvv6eFlPhevh3FPKYemap1ijpC+Bh
 Tu7uweWAPeF6lWa+5x8WUdOZwATcJEgY6TW+TYH84j3Jhdp3QaKKTpzcknWLVTevo0fEWs3t4
 i65kHk8P6APFbQZ3TBprpFW43OOP50IscKVXlFLwck8mpm12Gs8z0ZOvRW8W7pHuQ2o895zIB
 peqVae8zzJ6XU/QYONRAGkcHJVie/nxNJxrmqW41IGvarnRTaMRQtvGmFy+eoC08b0eiPuMQX
 vD7oCAtmT2bL3LrmFwZhVSXaciquX70vo0Nra5aIb0PP+GhvTQNF2jCP/JuAxGmImZdnDQ9uf
 E8brTIaU/T/q+fqS4XLdIKqqhxXLEY7ixy383cUgm9YGkUiwK9L7Z3UUykLzUFdc+gyayJMRr
 Nvfj8cCC6BI7TPwdVj7LQUAg==



=E5=9C=A8 2024/10/16 08:03, Boris Burkov =E5=86=99=E9=81=93:
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
> ---
>   tests/btrfs/323     | 46 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/323.out |  2 ++
>   2 files changed, 48 insertions(+)
>   create mode 100755 tests/btrfs/323
>   create mode 100644 tests/btrfs/323.out
>
> diff --git a/tests/btrfs/323 b/tests/btrfs/323
> new file mode 100755
> index 000000000..0aa45633b
> --- /dev/null
> +++ b/tests/btrfs/323
> @@ -0,0 +1,46 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 YOUR NAME HERE.  All Rights Reserved.

I guess "YOUR NAME HERE" is the new name of Meta. :)

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
> +_require_test

I didn't see any usage of TEST_DEV nor TEST_MNT, you can drop this
_require_test line.

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
> +# create a read-write fs based off a read-only seed device
> +_mkfs_dev $dev_seed
> +$BTRFS_TUNE_PROG -S 1 $dev_seed
> +_mount $dev_seed $SCRATCH_MNT >>$seqres.full 2>&1
> +_btrfs device add -f $dev_sprout $SCRATCH_MNT >>$seqres.full
> +_mount -o remount,rw $SCRATCH_MNT

If we determine to keep the fs RO after sprouting, shouldn't we also
check if the fs is still RO before the remount?

Otherwise looks good to me.

Thanks,
Qu

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


