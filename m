Return-Path: <linux-btrfs+bounces-1976-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AEB844923
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 21:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A991F28799
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 20:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F871383A5;
	Wed, 31 Jan 2024 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="dMO3x/mu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E17924A18
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706734084; cv=none; b=pJWcEcBbYToDDbw1qzOQ5jmzuvPQw8k7/Q78jpFrudPXvTHzEzif5hLmNoaBbeKiNLLdCoDsWJEwXNKUCaF+pr5sBBwJXSLxUgb291HjTgZrG1BEsTEh/BVrkpseydgzDKgSlmO6neKEUESr55VkWk84VgZ8IUCOrNCA8tfv/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706734084; c=relaxed/simple;
	bh=gLYCw0XfFtmeBbHX3q/heTTWVB5AEQXL2Ey3NAm/iDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOpfjTopvV123IdKQv8T6qN2nYi0RhY4vrQMyetLmjHdcxdXu+9wuWZ/MaglCQQ/bsv6SGls7SREOm5X1SzPm2FE+xEywm//qL9pTgmOwvtJjKR6cNJo96ym7VOdZ3VmHNpNeRk8pl2rh7tK22JLuvsgl1504dLvRNmxZIuYnjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=dMO3x/mu; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42a4516ec46so1533451cf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 12:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706734081; x=1707338881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m4Rd7bKe/3GEPSP9o8VH8TGDhCoqQAtoeJ3yAlhS8uY=;
        b=dMO3x/murCElUTm83j519aIzsHVDl/7fHTpMiH1z4RRmg1Oscx8SIGuCaVKvEZ0Y3b
         4VJPHh7JBLj+1EcXX8LiZ8EcaUxFgaT9NCYTEi8QtCb7GzHKq9anc+gIwRAKqdL2/DR8
         yPGLz5A4CJTlxvoHXxBSwawH3dNlzEv5/M9JHMfBZcI18L7do8mb9ruZrhAIfVoI1a9C
         4AJL0CJOtnMPk9AnW9DgNoweqdA2oK5rNaTEZEQVxDiH4LtgHIypstv/2uKC6NbNbHLn
         diYuJfynZ4xhcQ7zBVbTeboh6dUddYWve5EgfKyxjdTCYt8oHBkOHbBeZOyDWU+HyRqV
         Xz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706734081; x=1707338881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4Rd7bKe/3GEPSP9o8VH8TGDhCoqQAtoeJ3yAlhS8uY=;
        b=lNukNaeSwYcbMM9ZkCWxNuWWduIzBV6rLVeR2bLFp21amGKwfOjZ3Rmo96K8PTrcBD
         6Ij8SuG5EhYqxCLmym/5RBBOV26Ecu6oMC4C7gN8ETuo9bV1rxH5ktd+lAWvH5z3EAmk
         SdgSX1+F7DDllR5KUVXKZtdYSIx50tVM1mKs9eZE+MZ2RgaDWiR3s+U+/lEYfk9KGgq3
         WUVMJgjabJXdhpZ54Oud71pDOiNN2Tg+NIdgLA7QONHzfDlPCcSXN7TqC9f0frJxt377
         PmczeQz6vo7TJjMObXO1RKeNIkuFhfVj+DHn6IRcFatjj7+agfKp0hNyXUTcVldw5Zhz
         p0ZQ==
X-Gm-Message-State: AOJu0Yy3IAAuxqG3KhHJKdXbdtlKFqom9nKmCYeSNk7S8ztfP6/tbcYP
	D7mdHGkmVuC2ls70LTs6MsYVbfG0Qs5C0pRVLzry9LWrt7bkkvTRLxQdONRU5W4rZd2OHmGqTPu
	/
X-Google-Smtp-Source: AGHT+IEPWSjfTWYrVk5v1LjvR7omz0bo3kDLGJU/xF1NczrviCC9PKqxfeZdEZ7zpaRGWZLNiIvrvA==
X-Received: by 2002:a05:622a:c1:b0:42a:68f8:df76 with SMTP id p1-20020a05622a00c100b0042a68f8df76mr5242817qtw.29.1706734081319;
        Wed, 31 Jan 2024 12:48:01 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ep5-20020a05622a548500b00429acfe5bb4sm5485351qtb.40.2024.01.31.12.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 12:48:01 -0800 (PST)
Date: Wed, 31 Jan 2024 15:48:00 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs-progs: mkfs: optimize file descriptor usage in
 mkfs.btrfs
Message-ID: <20240131204800.GB3203388@perftesting>
References: <06b40e351b544a314178909772281994bb9de259.1706714983.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06b40e351b544a314178909772281994bb9de259.1706714983.git.anand.jain@oracle.com>

On Wed, Jan 31, 2024 at 11:49:28PM +0800, Anand Jain wrote:
> I've reproduced the missing udev events issue without device partitions
> using the test case as below. The test waits for the creation of 'by-uuid'
> and, waiting indefinitely means successful reproduction. as below:
> 
> --------------------------------------------------
> #!/bin/bash
> usage()
> {
> 	echo
> 	echo "Usage: ./t1 sdb btrfs"
> 	exit 1
> }
> 
> : ${1?"arg1 <dev> is missing"} || usage
> dev=$1
> 
> : ${2?"arg2 <fstype> is missing"} || usage
> fstype=$2
> 
> systemd=$(rpm -q --queryformat='%{NAME}-%{VERSION}-%{RELEASE}' systemd)
> 
> run_testcase()
> {
> 	local cnt=$1
> 	local ret=0
> 	local sleepcnt=0
> 
> 	local newuuid=""
> 	local logpid=""
> 	local log=""
> 	local logfile="./udev_log_${systemd}_${fstype}.out"
> 
> 	>$logfile
> 
> 	wipefs -a /dev/${dev}* &>/dev/null
> 	sync
> 	udevadm settle /dev/$dev
> 
> 	udevadm monitor -k -u -p > $logfile &
> 	logpid=$!
> 	>strace.out
> 	run "strace -f -ttT -o strace.out mkfs.$fstype -q -f /dev/$dev"
> 
> 	newuuid=$(blkid -p /dev/$dev | awk '{print $2}' | sed -e 's/UUID=//' -e 's/\"//g')
> 
> 	kill $logpid
> 	sync $logfile
> 
> 	ret=-1
> 	while [ $ret != 0 ]
> 	do
> 		run -s -q "ls -lt /dev/disk/by-uuid | grep $newuuid"
> 		ret=$?
> 		((sleepcnt++))
> 		sleep 1
> 	done
> 
> 	#for systemd-239-78.0.3.el8
> 	log=$(cat $logfile|grep ID_FS_TYPE_NEW)
> 	#for systemd-252-18.0.1.el9.x86_64
> 	#log=$(grep --text "ID_FS_UUID=${newuuid}" $logfile)
> 
> 	echo $cnt sleepcnt=$sleepcnt newuuid=$newuuid ret=$ret log=$log
> }
> 
> echo Test case: t1: version 3.
> echo
> 
> run -o cat /etc/system-release
> run -o uname -a
> run -o rpm -q systemd
> if [ $fstype == "btrfs" ]; then
> 	run -o mkfs.btrfs --version
> elif [ $fstype == "xfs" ]; then
> 	run -o mkfs.xfs -V
> else
> 	echo unknown fstype $fstype
> fi
> echo
> 
> for ((cnt = 0; cnt < 13; cnt++)); do
> 	run_testcase $cnt
> done
> -----------------------------------------------------------------
> 
> 
> It appears that the problem is due to the convoluted nested device open
> and device close in mkfs.btrfs as shown below:
> 
> -------------
>  prepare_ctx opens all devices <-- fd1
>    zero the super-block
>    writes temp-sb to the first device.
> 
>  open_ctree opens the first device again <-- fd2
> 
>  prepare_ctx writes temp-sb to all the remaining devs <-- fd1
> 
>  fs_info->finalize_on_close = 1;
>  close_ctree_fs_info()<-- writes valid <--- fd2
> 
>  prepare_ctx is closed <--- fd1.
> -------------
> 
> This cleanup patch reuses the main file descriptor (fd1) in open_ctree(),
> and with this change both the test cases (with partition and without
> partition) now runs fine.
> 
> I've done an initial tests only, not validated with the multi-device mkfs.
> More cleanup is possible but pending feedback;  marking this patch as an RFC.

I'd like to see the cleaned up version of this patch, but I have a few comments.

1) I think re-using the fd is reasonable, tho could this just be reworked to
   create the temp-sb and write this to all the devs, close the file
   descriptors, and then call open_ctree?

2) I hate adding another thing into a core file that we'll have to figure out
   how to undo later as we sync more code from the kernel into btrfs-progs, I'm
   not sure if there's a way around this, but thinking harder about adding
   something to disk-io.c that is for userspace only would be good.

Thanks,

Josef

