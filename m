Return-Path: <linux-btrfs+bounces-13375-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70BAA9A2BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 08:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1175F7A3A9D
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 06:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D8C1E98E0;
	Thu, 24 Apr 2025 06:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcCX1vHR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C3F1E0E0C
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745477935; cv=none; b=Tx9NSZUeNDCehwGwfusDAHTcg53GGcappnbILLByykqcc7LsMs9qwp9I0TSsArgVUOIRk9/jA5N14KEEXlN1juXMppEcJteRiC0kMZs9TS9dtHHc2ssffJ3dWzcOCVF+Zx5/pSYsICwIxelzv12mEzb+7890LTmW21PermEZkcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745477935; c=relaxed/simple;
	bh=Mq4h5ub5qX9UA3BolJ57kzejvX3WMUGaWovCnNJjzoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zua0jxKUBQs5Ftr/gm1ZaJ9iuhQ4LuIszefZAkOTfdouExLnKQCgGABUf7gnaTOOWj+sHo4oGA/mrFryBMs28XXBITk9gzgFpvqKM0xOf+Et5OxeLI9Zil6ximZlsbsGy5IlkzpzdLoM8QkdkKps3cuTiuPcfx7U/X62LXxTTkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZcCX1vHR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745477932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pUbFyXJ3kCaqhmWZjfD7lwtZD5fhxv6RKAeS3TktyW4=;
	b=ZcCX1vHRxlk2uvnldk3zWwIsXhIKZZ6PLj3KYfBbiGGqFiSGholc2qGmeCo1w36dK/pGGn
	I2tHicb5GaGJRsaHeG40KRAZbtHPb6uuCM9REt1+g2bluTMR8UV0fetzHwa2g6e0xQTohS
	s2VTqgg4y1dR5x19QACg+MT9HDQQbnI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-ay9p5Cg0MwavGKr1cd0Ejg-1; Thu, 24 Apr 2025 02:58:50 -0400
X-MC-Unique: ay9p5Cg0MwavGKr1cd0Ejg-1
X-Mimecast-MFC-AGG-ID: ay9p5Cg0MwavGKr1cd0Ejg_1745477929
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-227e2faab6dso6505615ad.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 23:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745477929; x=1746082729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUbFyXJ3kCaqhmWZjfD7lwtZD5fhxv6RKAeS3TktyW4=;
        b=RdXsH2VH7FFRAGkCAThSEvJYm/rkWDZrYZTmGuz1RI+SzmRpFdu7eC77aRV8399plw
         FH4qjHm219QmKX/AnDhgJCMMN5gLUimWIfb2In+09WaLjF3/DvtXo4iIvDw7t1r0Ikom
         Ux3EjbEIeLMxSPfrZEbmSmR6+opoi9EpmyvUp+YCh/ysl4zJ3cQ2eg6PdoLB6WZBUKgf
         0pcriKpbv/q0vQyBj9kPWmATB2rQeNck8g8wFc82h/FI2vtq4Tlc4ZxgQYOU3Un/Gv1g
         bvjCFQHVwE/3o6e8uLZFYrqlZS9sKnmVfNmKPWkmVvG0dgkguO2uQtJ22sxj5iqwskEn
         msSA==
X-Gm-Message-State: AOJu0YyILKPFrhBCFrjfliviM8JMdTU0sdEKbbuIIbUFhdjzAKfjvCaR
	tiimBamKVUaR33vFGET5j3svVkwdxHPgkFdT6ev57lRuja5YPquv07HNJU6hZ8BJV9D4j61gv2Z
	Z1grCMqK1g06EZbc3UI/SeK4Lzj13shES4q7SbuBA3TSqxx8jYVz7DSS2xdNDzMPTmk32
X-Gm-Gg: ASbGncs6ho9vA8ia8o97AZmcEnPyYl1AUHm44gU/WqrCIjXgUBh5+sTsHMgMPVI8PV0
	F1ggMLvLJKfFYRP5nzjuOsgHVG0+fLfzbaEVpNvkRVKz33GW0miqCOW84uQRRAJWoKzhkumwLv4
	NxbdOBnHA/7bsMipY+RnCwWlbyS+ZOdVk7XoQsCn4elkHbympDJvplmIfL7wkH6H3M0RbyCzGJh
	jpQ8pnGakz58nDPBqG40hwUbkdC65LoLMLRoQ6BeJXpRRQsA9T4rtYQRoeFlWsr5qmkRII+yszk
	vqHNgTW9GzDr45azFLwBS8SdmiLSHCtOgqs+jV8aBJcPayI8whbZ
X-Received: by 2002:a17:902:c951:b0:223:64bb:f657 with SMTP id d9443c01a7336-22db3db4372mr19910985ad.46.1745477928923;
        Wed, 23 Apr 2025 23:58:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp4F3lJehLK6fNysSSu8+KMDZHOyBGyeEI5W28spywhS1ZzLpoUglQm3vpYzEwkGCtYfmMUQ==
X-Received: by 2002:a17:902:c951:b0:223:64bb:f657 with SMTP id d9443c01a7336-22db3db4372mr19910775ad.46.1745477928477;
        Wed, 23 Apr 2025 23:58:48 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221600sm5762725ad.213.2025.04.23.23.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 23:58:48 -0700 (PDT)
Date: Thu, 24 Apr 2025 14:58:44 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/315: fix golden output mismatch caused by
 newer util-linux
Message-ID: <20250424065844.zl63dwo6w5hsr2ob@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250424060608.251847-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424060608.251847-1-wqu@suse.com>

On Thu, Apr 24, 2025 at 03:36:08PM +0930, Qu Wenruo wrote:
> [BUG]
> With util-linux v2.41.0 and newer, test case btrfs/315 will fail like
> the following:
> 
> btrfs/315 1s ... - output mismatch (see /home/adam/xfstests-dev/results//btrfs/315.out.bad)
>     --- tests/btrfs/315.out	2025-04-24 15:31:28.684112371 +0930
>     +++ /home/adam/xfstests-dev/results//btrfs/315.out.bad	2025-04-24 15:31:31.854883557 +0930
>     @@ -1,7 +1,7 @@
>      QA output created by 315
>      ---- seed_device_must_fail ----
>      mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
>     -mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
>     +mount: TEST_DIR/315/tempfsid_mnt: () failed: File exists.
>      ---- device_add_must_fail ----
>      wrote 9000/9000 bytes at offset 0
> 
> [CAUSE]
> 
> With util-linux v2.41.0, the mount failure error message changed to the following:
> 
>   mount: /mnt/test/315/tempfsid_mnt: fsconfig() failed: File exists.
> 
> Thus the existing filter only striped the "fsconfig" part, leaving the
> "()" without changing it to " system call".
> 
> [FIX]
> The existing filter on error message is doomed from day one.
> I'm fed up with the stupid catch-up game depending on util-linux, so
> let's just stripe everything between "mount" and " failed", just leaving
> the golden output to:
> 
>   mount failed: File exists.

Hi Qu,

Thanks for helping fstests works with lastest until-linux.

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/315     | 14 +++++++++-----
>  tests/btrfs/315.out |  2 +-
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/btrfs/315 b/tests/btrfs/315
> index e6589abe..9b5bc789 100755
> --- a/tests/btrfs/315
> +++ b/tests/btrfs/315
> @@ -30,9 +30,8 @@ tempfsid_mnt=$TEST_DIR/$seq/tempfsid_mnt
>  
>  _filter_mount_error()

I thought it's a common helper in common/filter, but I found it's a local
function of btrfs/315 with "_" prefix ... it's not recommended using "_"
prefix for a local function.

And there's a _filter_error_mount() in common/filter, could you help to
merge this _filter_mount_error function onto common/filter:_filter_error_mount,
then turn to use the common one? Then we don't need to maintain two different
functions to filter mount errors :)

Thanks,
Zorro

>  {
> -	# There are two different errors that occur at the output when
> -	# mounting fails; as shown below, pick out the common part. And,
> -	# remove the dmesg line.
> +	# There are different errors that occur at the output when
> +	# mounting fails:
>  
>  	# mount: <mnt-point>: mount(2) system call failed: File exists.
>  
> @@ -41,10 +40,15 @@ _filter_mount_error()
>  
>  	# For util-linux v2.4 and later:
>  	# mount: <mountpoint>: mount system call failed: File exists.
> +	#
> +	# For util-linux v2.41 and later:
> +	# mount: <mountpoint>: fsconfig() failed: File exists.
> +	#
> +	# Instead of playing the stupid catchup game, removed everything
> +	# between ":" and "failed:".
>  
>  	grep -v dmesg | _filter_test_dir | \
> -		sed -e "s/mount(2)\|fsconfig//g" \
> -		    -e "s/mount\( system call failed:\)/\1/"
> +		sed -e "s/: TEST_DIR\/315\/tempfsid_mnt: .* failed:/ failed:/g"
>  }
>  
>  seed_device_must_fail()
> diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
> index 3ea7a35a..fb493e90 100644
> --- a/tests/btrfs/315.out
> +++ b/tests/btrfs/315.out
> @@ -1,7 +1,7 @@
>  QA output created by 315
>  ---- seed_device_must_fail ----
>  mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
> -mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
> +mount failed: File exists.
>  ---- device_add_must_fail ----
>  wrote 9000/9000 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -- 
> 2.49.0
> 
> 


