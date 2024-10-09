Return-Path: <linux-btrfs+bounces-8682-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E91996552
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 11:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6F51F25462
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 09:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA95818A6DD;
	Wed,  9 Oct 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Aa7pkk48"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E8018C92E
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466109; cv=none; b=urcuPOl77+BTqwszYTDMcevdq1j7+H1XxHYBFSXAB0Eo59M6H1tBhA2zvqyx7rU/VOFWFaUKTP4YjGC3wTLHuYES14Jv6YlFeIj4RItlFfU7oN63ZutR8uCUrvLg8rA8uJAqlgkyleV6cYjFOwbRgXEPPV4TWqT9xYKaOqZTy/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466109; c=relaxed/simple;
	bh=/Xb7WtlFkg2nkhNUkPc5fsXZZJQYk0/rbC+gfbX1oao=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=mOSh+1kLpxAW8NvJh82jz5kh5A1wSmThUTWRFsm8jWtQQB981OLyRmKGspLd6c7A32lneNieolkhItGDlhn/aCA9Yxl565aoFxbJGjpr2LaU3nDsw2car/cY/Lolcho9mVEIUDrmejnlIo5Cl5wi3ESZMoHbe5iMQ0vsKfgLLM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Aa7pkk48; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fac3f1287bso71651531fa.1
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 02:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728466105; x=1729070905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EIGd9D72WaDkO+/Jsgr4eDErDlcHM9fU4v/1OvYN8lY=;
        b=Aa7pkk487CahBVX77sEn/PZna9QOKZQtc7ompSPLEG/2hOkHsnYi6Y72rHh6kYlpKo
         67MamYuui44UiOFTdw3j0hC8RC8EbJfs0MN9SS/T7WQGxGS+Nw+3Q8ZYNzd463BNkO5x
         jgIXsEM2z5XATIh0kdZr6RtbCt4H/S7mpfpVlRC1prsY9xaAzfdnKbl/qNTQljlKZ/UA
         87ogQp+rfuDZFBC9NFBcZTXt/vEERrr/I/vpXs9YC/0PGCxeiIK4SP54F/lXHUinV84N
         S34fpgtFz2joLE9zHLivVuWsaffD/Ej28f3zVXR/8ChCcZhfYe50dRUUdhpDsfZtDw6y
         /0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728466105; x=1729070905;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIGd9D72WaDkO+/Jsgr4eDErDlcHM9fU4v/1OvYN8lY=;
        b=lUzoAVCJcUgV46kaf4ACaGprs+n+hgimmrfPlu69mZzTcgwB4NqUOedMGTi1Rts59w
         Cwi46/PIMX8vLJalPdWzQk8gOyNzq34OJHzC492a/FaPlW3D4Ro3o/KGOAp6ckOtd81C
         nOAAUT8ygBzH5h5F7tN2zAMQ2pqOeV7l4r3LZ5rbGlLam7IGsorSIDitbMWtvfrgBeMR
         JaLPUPM9doPH4FS5F/bGcbD6x+Pl15g9OcT5Mc7oSEXITeImZL0r0jUzfoppKJRrEy3N
         pLu3gYSKqzc1Dw2IebrzwzQ9x194R2KlnTJV3aRxY6zr11wJMJs06toAZ1FmYbmskDXW
         vQpw==
X-Gm-Message-State: AOJu0YzN6j5YXxlqYu0iJg+sLHCne+e92De7pvafSlodssUMbRxI/KxW
	T24I90YBEDZXo5B4YS2plIOhVTPbEQhG/TBt3+s93QifXayUdqOTQQNyQuvug9GGvM98QcLG2/a
	x
X-Google-Smtp-Source: AGHT+IEh7xvXDf1oCWV4ojfgRfVt9p5TN1KHxC8tUor0NNKLlusU5S+v40/42UnjmMGAyXK2QI4uAQ==
X-Received: by 2002:a2e:be2c:0:b0:2f7:a759:72a7 with SMTP id 38308e7fff4ca-2fb1873820emr13321731fa.22.1728466104532;
        Wed, 09 Oct 2024 02:28:24 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5ca9a48sm1140355a91.51.2024.10.09.02.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 02:28:23 -0700 (PDT)
Message-ID: <4b176046-f0f2-4b76-ae03-08c6394baa9a@suse.com>
Date: Wed, 9 Oct 2024 19:58:19 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: generic/563: use fs blocksize to do the writes
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
 Zorro Lang <zlang@kernel.org>
References: <20240929235038.24497-1-wqu@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <20240929235038.24497-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Zorro,

Mind to merge this fix?

It got 2 reviews and at least one verification on 64K page systems.

Thanks,
Qu

在 2024/9/30 09:20, Qu Wenruo 写道:
> [FALSE ALERTS]
> If the system has a page size larger than 4K, and the fs block size
> matches the page size, test case generic/563 will fail:
> 
>      --- tests/generic/563.out	2024-04-25 18:13:45.178550333 +0930
>      +++ /home/adam/xfstests-dev/results//generic/563.out.bad	2024-09-30 09:09:16.155312379 +0930
>      @@ -3,7 +3,8 @@
>       read is in range
>       write is in range
>       write -> read/write
>      -read is in range
>      +read has value of 8388608
>      +read is NOT in range -33792 .. 33792
>       write is in range
>      ...
> 
> Both Ext4 and btrfs fail with 64K block size and 64K page size
> 
> [CAUSE]
> The test case writes the 8MiB file using the default block size xfs_io
> pwrite, which is 4KiB.
> 
> Since the fs block size is 64K, such 4KiB write is unaligned inside a
> block, causing the fs to read out the full page.
> 
> Thus the pwrite will cause the fs to read out every page, resulting the
> above 8MiB+ read value.
> 
> [FIX]
> Fix the test case by using the fs block size to avoid such unaligned
> buffered write.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/generic/563 | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/563 b/tests/generic/563
> index 0a8129a6..e8db8acf 100755
> --- a/tests/generic/563
> +++ b/tests/generic/563
> @@ -94,6 +94,8 @@ sminor=$((0x`stat -L -c %T $LOOP_DEV`))
>   _mkfs_dev $LOOP_DEV >> $seqres.full 2>&1
>   _mount $LOOP_DEV $SCRATCH_MNT || _fail "mount failed"
>   
> +blksize=$(_get_block_size "$SCRATCH_MNT")
> +
>   drop_io_cgroup=
>   grep -q -w io $cgdir/cgroup.subtree_control || drop_io_cgroup=1
>   
> @@ -103,7 +105,7 @@ echo "+io" > $cgdir/cgroup.subtree_control || _fail "subtree control"
>   echo "read/write"
>   reset
>   switch_cg $cgdir/$seq-cg
> -$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" -c fsync \
> +$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite -b $blksize 0 $iosize" -c fsync \
>   	$SCRATCH_MNT/file >> $seqres.full 2>&1
>   switch_cg $cgdir
>   $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> @@ -114,9 +116,9 @@ check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
>   echo "write -> read/write"
>   reset
>   switch_cg $cgdir/$seq-cg
> -$XFS_IO_PROG -c "pwrite 0 $iosize" $SCRATCH_MNT/file >> $seqres.full 2>&1
> +$XFS_IO_PROG -c "pwrite -b $blksize 0 $iosize" $SCRATCH_MNT/file >> $seqres.full 2>&1
>   switch_cg $cgdir/$seq-cg-2
> -$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
> +$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite -b $blksize 0 $iosize" $SCRATCH_MNT/file \
>   	>> $seqres.full 2>&1
>   switch_cg $cgdir
>   $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> @@ -134,7 +136,7 @@ reset
>   switch_cg $cgdir/$seq-cg
>   $XFS_IO_PROG -c "pread 0 $iosize" $SCRATCH_MNT/file >> $seqres.full 2>&1
>   switch_cg $cgdir/$seq-cg-2
> -$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
> +$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite -b $blksize 0 $iosize" $SCRATCH_MNT/file \
>   	>> $seqres.full 2>&1
>   switch_cg $cgdir
>   $XFS_IO_PROG -c fsync $SCRATCH_MNT/file


