Return-Path: <linux-btrfs+bounces-4210-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FFF8A3E41
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 21:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C822281CD6
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 19:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B5A5467B;
	Sat, 13 Apr 2024 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbsdXEpp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A68C4D9F4
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713037240; cv=none; b=b8VwmA1EfeS8sRERQfHHx14ShQ3upTaXYknX0VK6u4cP5WdwPV+DEOXw0+USRpH9Fyr/LPZydj/3/13TikwDPBqUQgIlob0LcS2J9+QNsjsgU1leWnoIs6hURNW6NUz7YNiVVifwwxRfnUKPR4Daj9zVQBb48somiURUcDRz8Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713037240; c=relaxed/simple;
	bh=GXpxrynSThDC2k/DG8BheDTapWNKA+FsaYFkfpfdzjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRu9OTNE9Tk68NU3FEn/nbvL0MACndeEs6WuMaYKzxQMdh6JhbOFRlhgwlVJjamYrZgft2wjaI4JA4H1KjUeMH/0opiDIoZti2tj656gmjqoRx1d5+zXuxMdr9yPZws8EPBO7icZKhQdL7SycW1eti/zr/LObHJOixOyz3tOoyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YbsdXEpp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713037238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNoe5ASoQh7cUmPNmyPTbhdyQmlTunknwP5bJVZdJCw=;
	b=YbsdXEppMWdj7prFFt6wYESpaQV1xCuf2kfixLpGtiqf1L5bnQf7o4KU94UR75UBm7dWX7
	zuWaiVy1sJxezQRQBrOZXsVeVsT3GeHG5rYnq5KLaexHoy3lASQEDXO/CBTOGaceXHtxCj
	ByOUnJ37N+7/0Se35A6xHILeRGgPwcA=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-CDdOxUsIOQKg_QtfKNHTHQ-1; Sat, 13 Apr 2024 15:40:34 -0400
X-MC-Unique: CDdOxUsIOQKg_QtfKNHTHQ-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d6a4133641so217682839f.2
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 12:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713037234; x=1713642034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNoe5ASoQh7cUmPNmyPTbhdyQmlTunknwP5bJVZdJCw=;
        b=iKXKUZv7W/jLawU5y5csFn1okWMBb8l4ZW4QSjT8Y2oVr4XAveI7G1o0b9mT8YVdxb
         Rlh8nO4Wtse0BDDHxqD9VHFmfjhOBVhq6E5wITPbQU1IA8g5XFPxbAmuxJjzX5HtgrZI
         2Ju0GNu++Uv8qg+24fOWQ4ORZaOsn1ufiHelIEgIKkeIWBdYKku3ATbdFW0prtDdP7Rw
         k7vBJ9dOafD8u54rsPZlKBL5xQy6M/FbL0uWOaXwX7M/F+JcbA7+d4thjL/yruQArZmu
         +oIpsdFhOU7E/3kB48pR/pPGCB8Do64qL0CIhIQi4UnPscH3bSn0QYZ9CdAHxrWODmxQ
         0Mpw==
X-Forwarded-Encrypted: i=1; AJvYcCXkat6uEoio2uW7kbjeEyhw2DWZ/zdH8JQEJqgyj45nWlI6JabE8CekXFIr5EunXM79twL/zVHMRX0stqH5rP3G4ZaysFmIaLc/puE=
X-Gm-Message-State: AOJu0YxZAAcfB4+iB704B633j82zZ4g1TzyJXCCAinXkmSnJkS1FkQsx
	vJcxqQ81Zm38PsY7LTznVhBVzgiDGdy+m0us2tGhlrmjAojfsYbgdJm5paJC2MLyyefr6WlC/La
	WJ+V4ffaodYLNhVZ8UXcUl/fR2ORz6rqYq7OMBIKC52Au14AaTOr6L2qV9dxv
X-Received: by 2002:a05:6e02:1c0d:b0:36a:3ee8:b9f6 with SMTP id l13-20020a056e021c0d00b0036a3ee8b9f6mr7346122ilh.12.1713037233698;
        Sat, 13 Apr 2024 12:40:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp2xLoExfGhTh58FuNbD/VSBNNWxJLy52+GVjxhFe6n3QtEJ/v3tw+kQsQyZ0FCuUx6lYGQA==
X-Received: by 2002:a05:6e02:1c0d:b0:36a:3ee8:b9f6 with SMTP id l13-20020a056e021c0d00b0036a3ee8b9f6mr7346102ilh.12.1713037233292;
        Sat, 13 Apr 2024 12:40:33 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q10-20020a63504a000000b005e438fe702dsm4462054pgl.65.2024.04.13.12.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 12:40:32 -0700 (PDT)
Date: Sun, 14 Apr 2024 03:40:29 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/125 197 198: cleanup using SCRATCH_DEV_NAME
Message-ID: <20240413194029.cqanjm6i4bdhaqdh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <703aa9f2e34bf4dcc1fc5eec7ef4f65a6705ff14.1712634550.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <703aa9f2e34bf4dcc1fc5eec7ef4f65a6705ff14.1712634550.git.anand.jain@oracle.com>

On Tue, Apr 09, 2024 at 11:51:11AM +0800, Anand Jain wrote:
> Use SCRATCH_DEV_NAME[n] to provide the device path for each device from
> the scratch device pool. Also, in btrfs/197, remove common/filter since
> it calls common/filter.btrfs.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> There are other test cases that potentially could use SCRATCH_DEV_NAME,
> but for now, only 3 of those are being fixed.

Hi Anand,

This patch can't be merged, failed as:
  Applying: btrfs/125 197 198: cleanup using SCRATCH_DEV_NAME
  error: patch failed: tests/btrfs/197:55
  error: tests/btrfs/197: patch does not apply
  error: patch failed: tests/btrfs/198:40
  error: tests/btrfs/198: patch does not apply
  Patch failed at 0001 btrfs/125 197 198: cleanup using SCRATCH_DEV_NAME

I'll leave this patch to your next PR, please check and rebase it properly.

Thanks,
Zorro

> 
>  tests/btrfs/125 |  6 +++---
>  tests/btrfs/197 | 13 +++++--------
>  tests/btrfs/198 | 12 +++++-------
>  3 files changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/tests/btrfs/125 b/tests/btrfs/125
> index d957c13911b4..f742d14f858c 100755
> --- a/tests/btrfs/125
> +++ b/tests/btrfs/125
> @@ -45,9 +45,9 @@ _require_btrfs_raid_type raid5
>  
>  _scratch_dev_pool_get 3
>  
> -dev1=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}'`
> -dev2=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}'`
> -dev3=`echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $3}'`
> +dev1=${SCRATCH_DEV_NAME[0]}
> +dev2=${SCRATCH_DEV_NAME[1]}
> +dev3=${SCRATCH_DEV_NAME[2]}
>  
>  echo dev1=$dev1 >> $seqres.full
>  echo dev2=$dev2 >> $seqres.full
> diff --git a/tests/btrfs/197 b/tests/btrfs/197
> index 9ec4e9f052ba..196110cbdad2 100755
> --- a/tests/btrfs/197
> +++ b/tests/btrfs/197
> @@ -22,7 +22,6 @@ _cleanup()
>  }
>  
>  # Import common functions.
> -. ./common/filter
>  . ./common/filter.btrfs
>  
>  # real QA test starts here
> @@ -55,24 +54,22 @@ workout()
>  	_scratch_pool_mkfs "-d$raid -m$raid" >> $seqres.full 2>&1 || \
>  							_fail "mkfs failed"
>  
> -	# Make device_1 an alien btrfs device for the raid created above by
> +	# Make device # 2 an alien btrfs device for the raid created above by
>  	# adding it to the $TEST_DIR/$seq.mnt
>  
>  	# don't test with the first device as auto fs check (_check_scratch_fs)
>  	# picks the first device
> -	device_1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
> -	$BTRFS_UTIL_PROG device add -f "$device_1" "$TEST_DIR/$seq.mnt" >> \
> +	$BTRFS_UTIL_PROG device add -f "${SCRATCH_DEV_NAME[1]}" "$TEST_DIR/$seq.mnt" >> \
>  		$seqres.full
>  
> -	device_2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
> -	_mount -o degraded $device_2 $SCRATCH_MNT
> +	_mount -o degraded ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
>  	# Check if missing device is reported as in the .out
>  	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
>  		_filter_btrfs_filesystem_show > $tmp.output 2>&1
>  	cat $tmp.output >> $seqres.full
> -	grep -q "$device_1" $tmp.output && _fail "found stale device"
> +	grep -q "${SCRATCH_DEV_NAME[1]}" $tmp.output && _fail "found stale device"
>  
> -	$BTRFS_UTIL_PROG device remove "$device_1" "$TEST_DIR/$seq.mnt"
> +	$BTRFS_UTIL_PROG device remove "${SCRATCH_DEV_NAME[1]}" "$TEST_DIR/$seq.mnt"
>  	$UMOUNT_PROG $TEST_DIR/$seq.mnt
>  	_scratch_unmount
>  	_spare_dev_put
> diff --git a/tests/btrfs/198 b/tests/btrfs/198
> index c5a8f39217d3..ad43b4d1b59b 100755
> --- a/tests/btrfs/198
> +++ b/tests/btrfs/198
> @@ -40,21 +40,19 @@ workout()
>  	_scratch_pool_mkfs "-d$raid -m$raid" >> $seqres.full 2>&1 || \
>  							_fail "mkfs failed"
>  
> -	# Make device_1 a free btrfs device for the raid created above by
> -	# clearing its superblock
> +	# Make ${SCRATCH_DEV_NAME[1]} a free btrfs device for the raid created
> +	# above by clearing its superblock
>  
>  	# don't test with the first device as auto fs check (_check_scratch_fs)
>  	# picks the first device
> -	device_1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
> -	$WIPEFS_PROG -a $device_1 >> $seqres.full 2>&1
> +	$WIPEFS_PROG -a ${SCRATCH_DEV_NAME[1]} >> $seqres.full 2>&1
>  
> -	device_2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
> -	_mount -o degraded $device_2 $SCRATCH_MNT
> +	_mount -o degraded ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
>  	# Check if missing device is reported as in the 196.out
>  	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
>  		_filter_btrfs_filesystem_show > $tmp.output 2>&1
>  	cat $tmp.output >> $seqres.full
> -	grep -q "$device_1" $tmp.output && _fail "found stale device"
> +	grep -q "${SCRATCH_DEV_NAME[1]}" $tmp.output && _fail "found stale device"
>  
>  	_scratch_unmount
>  	_scratch_dev_pool_put
> -- 
> 2.39.3
> 
> 


