Return-Path: <linux-btrfs+bounces-16317-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0087AB33519
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 06:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0FC3A1D89
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 04:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BE72550D8;
	Mon, 25 Aug 2025 04:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mO4wuJ8Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AC22101AE;
	Mon, 25 Aug 2025 04:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096490; cv=none; b=rTWcysVA0K8UdExKdompdYq7PWWGKL+3StSWGmNTasbncs4o9hWhNF4c3DfkwoEtpluLXD1EaofHCeGmVk5pPyNcSq8l4vz9N4JIMEYkJeeP1VXC0M5qNyRHB25el4KkDTdOp62tw3HqcjqSkOPczz+VwVd90vNG+h4hyzhv69U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096490; c=relaxed/simple;
	bh=zTsPFKELVvKnjI6HgvtPLF1eDW8CfYdReP5o5so51PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQgCR89Qaxbv43RbDSsq/3+d8XyqhaXdWMaYGmJL7p0PDMDmccvpiQ3WA46tqnEsruVXg0RozxrysjsqSnhQzH5wi2B0P38JNm5TR4rGwqHJGRtYUK1RIlg/HNZXb7zVyKCnK9naoYA0M6b4u5C8I3lO7ri0Gfaa1BnX4oa9nGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mO4wuJ8Y; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32326e67c95so4326949a91.3;
        Sun, 24 Aug 2025 21:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756096487; x=1756701287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBHkA7YjOiPDA/Rr3r3DIHpfIB6xpgImsae3wOrKln0=;
        b=mO4wuJ8YqkYTDdGDfmshBqNLmnVfNY7S8Y+k20Rmy5yCsr3NFjMiiL0WmvWl4FOY2i
         MYzhCP4KNBxaxYET0bHbAHqR1rUc2JKOI1sWlou34Z2vRE080js/+hJV5M8S53q3ipZa
         1DoltypurEdzrFcJPaEYQXJDDVHMWhf+6nFsLc0ict21N8kC6lzwVs6Ky5GGgW3cKWIg
         sALtQYBrB7ckNaa83qk9LSno/FjVzKQ8CzJrJwNfMVqUIKPEVMzpLUj1tD62fmzrypxo
         EuvEJF+dEOxQ7hp9xg75bEF9vT7K5dVvMAIxsGqRTlDGn68k8//MTftZbCoT2lAvAb4q
         VQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756096487; x=1756701287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBHkA7YjOiPDA/Rr3r3DIHpfIB6xpgImsae3wOrKln0=;
        b=izl94CoHnMNET8wd3PEnlEau66/awvFoerX4OQtxxbLXbHE5lSko9ODitatHSKJF0+
         KBbUke3w70uNFQpUK8ExIpcj8pB0ZyCw6BDDAKW/mVs6z9sbDXtYDVVAyjuSVJeKJjF4
         ZfXTKfa5T6fMAQxWt7mDeCJAkLPO1Vlj7KeA8w/60HCU6FryXDbCM+SfZP2xbbm4Ao68
         rAHA5upKJJc3YHD9TL9sh6A0tFs+C6vswbKebdYMaI1iQ/p+mBkgwfAthiSnOn8Dy5bc
         sL2nY5VZlhcIhvkpjOqFPSgh3uHUq1+nqeShJg6eCutZPrNnNKNIrB6N5swy0LUxuXr4
         kfFQ==
X-Gm-Message-State: AOJu0YwY+hP2ZoiIXnSwwANyw0CjqotR7Z3tkKGBftYjBkh5Fr9Ij1Db
	bg2XlCSRi9GbJOPCxZ8GaSzHGNTs+ZQ8pMhPjDeO7YJfd4eZ0ObrLxnCuDqflA==
X-Gm-Gg: ASbGnculda5PBf7YXysQCzrSpsHx6EXTPHzlLtgsAcAxW6Fbre1L5TfzQEopE0fbo0t
	fOTK7dOJcZe7rGXQ13Ka5PBItFrcKoSUQlG7EORu0Nfk+roKuLBLsYXk/nUXDGsP/jeiWd6cnxR
	x4hMAMk83Hik+QmJ8EgNVukKOfpStPvg9aToJ0rRK+vW+ktUz5SmlOou6b1a1vAvzjYFwJ579x/
	WQQdmiSuhgXheMnqr4PxwpV6K/kwV7XdsDZ4CQxE9PSNzme3Jw02wxn3PQdhn6YPCIiwtTXr3iV
	6BZBmU9MHU1gpD05sF9wNpQ5vsmQ3X6iN7jtxB5W5Ipw1y6FjRB7Y1xn6VjU/LbGVUIUH6rAX7k
	Ju37SJ726n++YQ3maL/hyxUE5ZAIiGwGBryeoUSopykm2ho1PkapMhg==
X-Google-Smtp-Source: AGHT+IGeeGmH05uqQvqOLkqBDV8JT8rNlVHKFDCP+sqn1YIchMzqik/I7L6F1VZRl78R3GrhaMGKCA==
X-Received: by 2002:a17:90b:51c6:b0:324:24d:3207 with SMTP id 98e67ed59e1d1-32515eabb6dmr15163582a91.17.1756096487280;
        Sun, 24 Aug 2025 21:34:47 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.214.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254e71ff03sm5707483a91.16.2025.08.24.21.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 21:34:46 -0700 (PDT)
Message-ID: <ca7656e2-0b8b-42e4-8dee-c2da44cc0f11@gmail.com>
Date: Mon, 25 Aug 2025 10:04:39 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] generic/274: Make the pwrite block sizes and
 offsets to 64k
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org, quwenruo.btrfs@gmx.com
References: <cover.1755677274.git.nirjhar.roy.lists@gmail.com>
 <1110f20bb5d26b4bef5596a00d69c3459709ab65.1755677274.git.nirjhar.roy.lists@gmail.com>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <1110f20bb5d26b4bef5596a00d69c3459709ab65.1755677274.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/20/25 13:45, Nirjhar Roy (IBM) wrote:
> This test was written with 4k block size in mind and it fails with
> 64k block size when tested with btrfs.
> The test first does pre-allocation, then fills up the
> filesystem. After that it tries to fragment and fill holes at offsets
> of 4k(i.e, 1 fsblock) - which works fine with 4k block size, but with
> 64k block size, the test tries to fragment and fill holes within
> 1 fsblock(of size 64k). This results in overwrite of 64k fsblocks
> and the write fails. The reason for this failure is that during
> overwrite, there is no more space available for COW.
> Fix this by changing the pwrite block size and offsets to 64k
> so that the test never tries to punch holes or overwrite within 1 fsblock
> and the test becomes compatible with all block sizes.
>
> For non-COW filesystems/files, this test should work even if the
> underlying filesytem block size > 64k.

Hi Qu,

Do you have any other feedback for this? I have reverted the block size 
to 4k during fs filling as suggested in [1]

[1] 
https://lore.kernel.org/all/0a10a9b0-a55c-4607-be0b-7f7f01c2d729@suse.com/

--NR

>
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>   tests/generic/274 | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tests/generic/274 b/tests/generic/274
> index 916c7173..f6c7884e 100755
> --- a/tests/generic/274
> +++ b/tests/generic/274
> @@ -40,8 +40,8 @@ _scratch_unmount 2>/dev/null
>   _scratch_mkfs_sized $((2 * 1024 * 1024 * 1024)) >>$seqres.full 2>&1
>   _scratch_mount
>   
> -# Create a 4k file and Allocate 4M past EOF on that file
> -$XFS_IO_PROG -f -c "pwrite 0 4k" -c "falloc -k 4k 4m" $SCRATCH_MNT/test \
> +# Create a 64k file and Allocate 64M past EOF on that file
> +$XFS_IO_PROG -f -c "pwrite 0 64k" -c "falloc -k 64k 64m" $SCRATCH_MNT/test \
>   	>>$seqres.full 2>&1 || _fail "failed to create test file"
>   
>   # Fill the rest of the fs completely
> @@ -63,7 +63,7 @@ df $SCRATCH_MNT >>$seqres.full 2>&1
>   echo "Fill in prealloc space; fragment at offsets:" >> $seqres.full
>   for i in `seq 1 2 1023`; do
>   	echo -n "$i " >> $seqres.full
> -	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 conv=notrunc \
> +	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=64K count=1 conv=notrunc \
>   		>>$seqres.full 2>/dev/null || _fail "failed to write to test file"
>   done
>   _scratch_sync
> @@ -71,7 +71,7 @@ echo >> $seqres.full
>   echo "Fill in prealloc space; fill holes at offsets:" >> $seqres.full
>   for i in `seq 2 2 1023`; do
>   	echo -n "$i " >> $seqres.full
> -	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 conv=notrunc \
> +	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=64K count=1 conv=notrunc \
>   		>>$seqres.full 2>/dev/null || _fail "failed to fill test file"
>   done
>   _scratch_sync

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


