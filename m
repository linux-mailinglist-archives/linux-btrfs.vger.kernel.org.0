Return-Path: <linux-btrfs+bounces-17225-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6936EBA4849
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 17:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2E83BD034
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 15:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8642253EF;
	Fri, 26 Sep 2025 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAqMJp6C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7882E224240
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902284; cv=none; b=OPr1hOJsO2SYzvGAx4hzUdz48nOVJgLf5J4AWb6ypkaqnoatn/RRguysWfCXAnXkss0GCzRNEtJmQq9hV/1RsXx3tNQPW83kdzZbPKHVxgXFU6t0mbHyWh/AiBQLofQj0rPmWdWtB0WTgPh8gotQdyoJOSLByhCIbhyQ3nzZUvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902284; c=relaxed/simple;
	bh=QEBb8CvmzifXijQilZ6wiqu1lNq4+xZewyvZT2bnvfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wmhu/5+suK5ywPha1kbRHIxbgsKj/K+sqwqaLctbwVwzHfVBnOvBZdugywLk+DNNbz/i1blkg4RgDYmKvzEDyZk3p4KYu7+aEUgvGEGuqKlfYVamCq4gf3JvXtCI2YVKAm9M/diicjQVAvOi3zXTaRWaNhU2TUwXs4XeevYIrNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IAqMJp6C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758902281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lbAmfikudN6BqTKToQsuN7u+mvQbsqyab96HtsMyKbc=;
	b=IAqMJp6CgUarx6QwKedHtd3LmAX3YtI35AxGHLQhFeDI+LYAUl9/QjegBcYdiGsFaPNpIH
	dQ5PgdcE2/ygCE18oYfHODME0ovThcrklFKYm8ZyGAVa40Z0RWdI8KkGAKHEMRlBUSMrGB
	X840frDO6Gvo+rUg1DzZv3E2eOvMJEM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-x_XvZad2MN6L4kmpnD2uyQ-1; Fri, 26 Sep 2025 11:57:59 -0400
X-MC-Unique: x_XvZad2MN6L4kmpnD2uyQ-1
X-Mimecast-MFC-AGG-ID: x_XvZad2MN6L4kmpnD2uyQ_1758902279
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b5516e33800so3010621a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 08:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758902279; x=1759507079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbAmfikudN6BqTKToQsuN7u+mvQbsqyab96HtsMyKbc=;
        b=dsZ00hP1xHt4BEponc31q98xwtcx50w1dCfoOYNBhkkFVq5SwQd/YTlBRLmUX0g0fR
         1IvzPaAdNUGvH0iXrn6UTyQknMcnHEP9Jnv/0d6HavoLnBU64P6GWeBjqMPhgLWaP9ds
         uKtJA5u9v/ttbcTyRLK2ZzrfD4pBRnt0Hj83TiJAPhe5deZPck1f7NZH7BN3hddgXV/W
         pu/do+euAGqmq664Ese0okxRQFAbJFO7az3mCNg+/34po/9IrKGEHV6axx7TylsBgTk/
         e3Dh0SnZDNykn8N4mf6jQDq/jZ/uV/02rUTnJ49aeaxq2qNvF2nIa0LDOIZCXHRO3VwB
         7Usw==
X-Forwarded-Encrypted: i=1; AJvYcCXJRpI1do8IA40BWh0MhdQckI3I8LB6LlA8PdEiz1qBB25zeTk3M7Zxnxm9NZ3JNzXEz642YrQ8ew1kdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSKYah4YISizIgXqw5OS99cO3ueQwmITdrG1IEz2XHymv2bg6M
	eIS5K2WeXv2KJ1edhCarzFSFugr34Nmr2Ae8qYRXirgFwL6jEyhEhR3qWoK60R2GU9bwbfhZw1z
	7conqWxM1GeCqcG1RSjzVokOsSEFzC7w+5+nGm6L2AX4M0YGLKk+GdGXYHKXS0ea7
X-Gm-Gg: ASbGncv+AUuCIboofJYfnHH3XY8dqzqwQLpVJdk47/8vrnGD258MIQzrSzg/qzZcl1V
	jYDF1KoF3vdAQGcyGNzk7OLeh+VPz/Q+HmaDHvr53YbaMzc3E6lnd92t7vAhO00T3kzHemLa08y
	hUxLqJrD7cFIXRyO0iXu0Q7JcBPrpbtzjA9qFD3NLwnR8MEoT+YT8LfG+nHrwe7K26iVpRT4m+L
	uHIxIPQCjtKNXuMEt+dOSj60nN5rQEh8y2god9loZBy679gFcUohxvkAMv2w+StprFMqs21xyAZ
	Cin2et4aUqqfbf7pQXIsGreSN1p4jyyp1FioeAAsO4PVjDyB6ZQq07XS8A2Ps4zdfWcBAr1Lp+k
	9S9yC
X-Received: by 2002:a05:6a21:3381:b0:2cb:5f15:ebf8 with SMTP id adf61e73a8af0-2e7ca7d6b46mr9027585637.27.1758902278645;
        Fri, 26 Sep 2025 08:57:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH96BUNIs4nlT/UUuxp8unsBbBn2QPoH6tmB3oSq3Mg9aUq5muVxP6EvMvA3dINyNKcCRGAGw==
X-Received: by 2002:a05:6a21:3381:b0:2cb:5f15:ebf8 with SMTP id adf61e73a8af0-2e7ca7d6b46mr9027548637.27.1758902277980;
        Fri, 26 Sep 2025 08:57:57 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810cfdb99fsm3350338b3a.31.2025.09.26.08.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:57:57 -0700 (PDT)
Date: Fri, 26 Sep 2025 23:57:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anajain.sg@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] common/rc: helper functions to handle block devices
 via sysfs
Message-ID: <20250926155753.yhhrbfnilvmk2t47@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1758148804.git.anand.jain@oracle.com>
 <512a6148be0d8da51278f94a29b959f3950bcc0b.1758148804.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <512a6148be0d8da51278f94a29b959f3950bcc0b.1758148804.git.anand.jain@oracle.com>

On Thu, Sep 18, 2025 at 08:32:46AM +0800, Anand Jain wrote:
> From: Anand Jain <anand.jain@oracle.com>
> 
> _bdev_handle(dev)
> 	get sysfs handle for a given block device.
> 
> _has_bdev_sysfs_delete(dev_path)
> 	Checks if the block device supports sysfs-based delete.
> 
> _require_scratch_bdev_delete()
> 	Test if the scratch device does not support sysfs delete.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/rc | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 81587dad500c..627ddcc02fb8 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4388,6 +4388,32 @@ _get_file_extent_sector()
>  	echo "$result"
>  }
>  
> +_bdev_handle()
> +{
> +	local device=$(echo $1 | rev | cut -d"/" -f1 | rev)
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

basename $1 ?

if you hope to make sure it's not link, you can

basename $(_real_dev $1)

> +
> +	test -e /sys/class/block/${device}/device/scsi_disk/ || \
> +			_notrun "Failed to obtain sys block handle"
> +
> +	ls /sys/class/block/${device}/device/scsi_disk/
> +}
> +
> +_has_bdev_sysfs_delete()
> +{
> +	local dev_path=$1
> +	local device=$(echo $dev_path | rev | cut -d"/" -f1 | rev)
> +	local delete_path=/sys/class/block/${device}/device/delete
> +
> +	test -e $delete_path
> +}
> +
> +_require_scratch_bdev_delete()
> +{

I'm wondering if it's better to call "_require_block_device" at first, before
checking the /sys ?

> +	if ! _has_bdev_sysfs_delete $SCRATCH_DEV; then
> +		_notrun "require scratch device sys delete support"
> +	fi
> +}
> +
>  # arg 1 is dev to remove and is output of the below eg.
>  # ls -l /sys/class/block/sdd | rev | cut -d "/" -f 3 | rev
>  _devmgt_remove()
> -- 
> 2.51.0
> 
> 


