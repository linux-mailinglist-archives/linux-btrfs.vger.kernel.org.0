Return-Path: <linux-btrfs+bounces-18089-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EDFBF498D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 06:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 594324E22A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 04:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C397224B09;
	Tue, 21 Oct 2025 04:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBC0TcPQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF61C2FB
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 04:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761021895; cv=none; b=oj5uedvR64NF9BEJ8VeQiHCiqVftDeMcO4AodkVSoUzONa04LZyrCCOikFjgJwhcK9DZangGUT4RpfQYMQO6rxcLqGEs9t/QNwtBvJHIxNq026t+gf64c4GTus9U7Do5yQS1eUixlXkk1Z3n7SwiZGH5Y2l8xbwqvHMagjW6QZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761021895; c=relaxed/simple;
	bh=9kxqybzlE1Fr37/9VYjEybQFCr8RkY8xjdsfiUZklso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V26oKJMUKW9nSR2b4ez9xbBlVjDsAtNWB6t176BXND98/fb8k0kf7SZf0acBWjBc46cTIbA6kADHbZd6gqjUEewQN5A9CcWxX92SboeLeVixURZpFxzDSBeGlvf5bPkpWajIMSBFr7S+Dyx9qu9sbRSPR5M2jVXlJOAyBtoDCY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBC0TcPQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so1965951b3a.0
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 21:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761021893; x=1761626693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LDtraCp9cZKtKPbSxjbOSWy6oE08Rv3lBvkhlrTZUhA=;
        b=eBC0TcPQiWaY89yKF3ARu5nWzLnC67Um1F8gbuVcN6GF9mYiz5TNMypsO5THcZQx/Z
         2OwIcA9+BFxZwhPUhFKLOAVRCjnA0OFmqLynXBAowAwMxy+kNHcb/fNhPSMAU6NQeWKS
         kux47Ua6VMkULCWr9h3RAgLoww8nD9ai7l0nDiwffrLGWoo3BfLLvicfjl00yh4lz64N
         U+uq2RJTmKN13b2OnY4E/i0RQ39vIcz8586BEo/aOzJsGyNrOKtcj5YOq6h+ceBvrUnr
         9y0YanlN2rpEWwdYbS5qWbbRGwnY66Yqy5w2EAJndp6snCPNvhDZ2Ga8fQVrOHZt3mpl
         sO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761021893; x=1761626693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDtraCp9cZKtKPbSxjbOSWy6oE08Rv3lBvkhlrTZUhA=;
        b=SAAxdpT6YRCFlF3itgfDW6+5pajZ8LvAMM6NQdyFSxUE+sqGrBsYvY+W7LVd76efSs
         wkkVN0Baw2WgT1i4WOFobibpj7KgOnQGyd3Mhq7cOcchE/MIckB1tb9QjPEIyH1/n1j6
         krKcjqgsDUdi0TYWOlzL7MKHq56MagbT3EIsJdIN9VhtisTcqGuk1G+nJHo7UPosEz7C
         5GXkfqVHA0YP831kHfsxwpBW0jqsy11FX8lJlUbHNwCOlx5f0lCcSeAey5SYHth4h+Wr
         cpVzhps7xfi/ClR7de7HhGJEEl1akCiEcpXytjiOvAyUvkOdUD3Rv6FKURfjSSJxbUs9
         P2KQ==
X-Gm-Message-State: AOJu0YyFGqUqTTp1GaIZ+MPmryIq1LYvX5nIpjoqOrA9a7WBbHaHnT5z
	590cMLCTUByEiyA++QmdoKawp9RZ2Qbp3cIE566ETEhsGhBBsfqJJjr1
X-Gm-Gg: ASbGncv4PCHRgDcqe0DUZD5aoHr0M6cNdkxnfzJ3168HXHEeC3iS3DMYCWQZ8SlXojL
	wGXeYchjSgCP5MwCTsx3LMWWQBWFyu40zX2ffoJqvY/P7/EZSP3T6PPkhUyEoVieXhxUkJQKjs2
	WwZ9qdTo4kD47xYTe0c9Ymz29UCUJK1HDoXIqE2NkmnVrYlyEIdDusnJH7MqcJ+DSO9gFzWxl9d
	CfkAgdyhbk0ZtxcdSU3AtYC6AvYi2J6Mt4rTW+K5TNiltc70G9SL64wdDyCCctu8jEv+/hHkcL7
	QZI1sSgb5/fMGxTXDbcKA7lbYxln1hCtTtt+BJzeey47tJB75NJnPmXeQylqCJqLXS8idV0GiaV
	5eFLNgd+apFH9xobWHsa/MOznKebpPrIJq8J8iuCYPZBykdcr9yzB1rbODEVKHSDs3XI1P6xyQA
	+qdEE9ADiaDBmNUdc/Y7YAnw==
X-Google-Smtp-Source: AGHT+IFAuMCYgWaw4/7KZ7/cLX3OGgjJ/ZPXFbnyQggfH+LWnKNPEbNZNK1NoYY9oTl5A04nj7ZASA==
X-Received: by 2002:a05:6a20:a9e:b0:334:98f8:b24c with SMTP id adf61e73a8af0-334a8629de8mr14358787637.50.1761021893366;
        Mon, 20 Oct 2025 21:44:53 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.204.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230121f96sm10081918b3a.76.2025.10.20.21.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 21:44:52 -0700 (PDT)
Message-ID: <e4d6a3d9-2a19-4d89-ac7f-899189329f18@gmail.com>
Date: Tue, 21 Oct 2025 10:14:48 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] btrfs/290: Make the test compatible with all
 supported block sizes
Content-Language: en-US
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, fdmanana@kernel.org,
 quwenruo.btrfs@gmx.com, zlang@kernel.org
References: <cover.1760332925.git.nirjhar.roy.lists@gmail.com>
 <9849006dd25950d390a8b300ad056e0d4be00394.1760332925.git.nirjhar.roy.lists@gmail.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <9849006dd25950d390a8b300ad056e0d4be00394.1760332925.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/13/25 11:09, Nirjhar Roy (IBM) wrote:
> This test fails with 64k block size with the following error:
>
>       punch
>       pread: Input/output error
>       pread: Input/output error
>      +ERROR: couldn't find extent 4096 for inode 261
>       plug
>      -pread: Input/output error
>      -pread: Input/output error
>      ...
>
> The reason is that, some of the subtests are written with 4k blocksize
> in mind. Fix the test by making the offsets and sizes to multiples of
> 64k so that it becomes compatible/aligned with all supported block sizes.

Hi Filipe,

Do you have any additional feedback on this? I have made the changes 
suggested by you in [v1]

[v1] 
https://lore.kernel.org/all/CAL3q7H58hDCrYMqDwdO_Lf7B2J+Wdv5FpAw6u5NkDK0ExZ8K0A@mail.gmail.com/

--NR

>
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>   tests/btrfs/290 | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tests/btrfs/290 b/tests/btrfs/290
> index 04563dfe..471b6617 100755
> --- a/tests/btrfs/290
> +++ b/tests/btrfs/290
> @@ -106,15 +106,15 @@ corrupt_reg_to_prealloc() {
>   # corrupt a file by punching a hole
>   corrupt_punch_hole() {
>   	local f=$SCRATCH_MNT/punch
> -	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
> +	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 192k" $f
>   	local ino=$(get_ino $f)
>   	# make a new extent in the middle, sync so the writes don't coalesce
>   	$XFS_IO_PROG -c sync $SCRATCH_MNT
> -	$XFS_IO_PROG -fc "pwrite -q -S 0x59 4096 4096" $f
> +	$XFS_IO_PROG -fc "pwrite -q -S 0x59 64k 64k" $f
>   	_fsv_enable $f
>   	_scratch_unmount
>   	# change disk_bytenr to 0, representing a hole
> -	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr --value 0 \
> +	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 65536 -f disk_bytenr --value 0 \
>   								    $SCRATCH_DEV
>   	_scratch_mount
>   	validate $f
> @@ -123,14 +123,14 @@ corrupt_punch_hole() {
>   # plug hole
>   corrupt_plug_hole() {
>   	local f=$SCRATCH_MNT/plug
> -	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
> +	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 192k" $f
>   	local ino=$(get_ino $f)
> -	$XFS_IO_PROG -fc "falloc 4k 4k" $f
> +	$XFS_IO_PROG -fc "falloc 64k 64k" $f
>   	_fsv_enable $f
>   	_scratch_unmount
>   	# change disk_bytenr to some value, plugging the hole
> -	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr \
> -						   --value 13639680 $SCRATCH_DEV
> +	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 65536 -f disk_bytenr \
> +						   --value 218234880 $SCRATCH_DEV
>   	_scratch_mount
>   	validate $f
>   }
> @@ -166,7 +166,7 @@ corrupt_root_hash() {
>   # corrupt the Merkle tree data itself
>   corrupt_merkle_tree() {
>   	local f=$SCRATCH_MNT/merkle
> -	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
> +	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 192k" $f
>   	local ino=$(get_ino $f)
>   	_fsv_enable $f
>   	_scratch_unmount

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


