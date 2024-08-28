Return-Path: <linux-btrfs+bounces-7656-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A254963562
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 01:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3AA11C223B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 23:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2971AE039;
	Wed, 28 Aug 2024 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="oNTURfTf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC321AD9D0
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 23:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887594; cv=none; b=DQXqX+zK+v7xLhdxktdC84uluVn7QcR/Tib+nTwlTc0eXjRHeUVUQbDQZMUqiV5IoFqbXzxYUehzWXttxhN7vfrn+IyZD1YX9W7yakiyecGTmQSMG170+kw6Ao/FSUu09HyRyblF6dXX2MzuVEtcIT/RygLoUOWjCPGOw2soEYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887594; c=relaxed/simple;
	bh=De/f46csxBOYVISXRWAVk84VMXyO5Mq/Lcp+zBR2y8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyYl9TfA6qAKd6ppVpwP3cSV3i6VGXrEYWOh0GYWCRtORjDvLgkMkbzXQst8yZ3u2kfZuhCXOBlj0L9/5XCmDCtdIltm0Zk+Cv2Hh2bxCBqlCbYBNVzc1hrnQt6G1IKC1fMVEA5wvZ8NSlLFDodjkPjzp/KLkHcT19Afvx8Bee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=oNTURfTf; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-699ac6dbf24so846137b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 16:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724887591; x=1725492391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YcKEMHyp4gzTx2Mi1b6ZzHDbAJSlkdx6TGhL2DJYEao=;
        b=oNTURfTfcLLJJTbeUaxJP4v72aEKpo+glVaumOaEKB9fDe+40HKfzvscWFbWLkVz/x
         +4VEXux55dPJs1xKF42H0VxMHuCYCXaAOVTDEanBVEWyss8yldvTGLH15LnsicDfTHVj
         hIiEBK2D2XvpjRVJd4GogkgWDNZy6jQkg0i7T72jFQO7Byhx1jJhzXD01ujLWXAe+WNE
         2k31NE+BHaRBeAyntqi+YmS20+qu+5cnjAVoHYb1XIDDb/HhdVmEv7P0pmVb3f9EZSi2
         MCNPIi4OI89yOLWTGPahK7rwsI3Q1SvvYJdr/8DkGFcAKjYjpQgB3duayQz/0Q1MdrKH
         UQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724887591; x=1725492391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcKEMHyp4gzTx2Mi1b6ZzHDbAJSlkdx6TGhL2DJYEao=;
        b=eSiUjmsOqnZP8Obn8JmHAi5wjciTVxkq3aKrYWsUpFWskEDjhayIMi2nzE7FBPIcSz
         WuEE2ZYTjovgra64z4qsCCL1WflezkMLSHSOhpHLGJqTRfAHaPxkPtNB/sUupzac9BMf
         4UOBBsr26Ed655dDxdLEjOEhvoazMGWXdrcJdEdQUaZibESuzimPdr7Fv8v8BuLxJJwQ
         uCfeg6CkA8S2ALTr4mbGcxFY4tZf5y4TFSTPJJLnmvkiBUQQmBntmtlXGlQQI9LjlCgD
         Vvr7WzAHvJax99xqBvCsWdJDrBERtwd4olgDA4876kA0YbZitrgl2U2GtN1GrrBspmqY
         9OaA==
X-Gm-Message-State: AOJu0YwLSAfpDVCNfF99d4VtmuNlLgl644P0mnPdgTkhuOt+Sgoq3QOD
	8Qu5Q/oWWlj290QaCF8neEPX9/Xs+GbJr+WgH9rpbzIad6KJn13B48bcRGXEpUPOThgpkcQT5QQ
	m
X-Google-Smtp-Source: AGHT+IFY03YEnZ0opOvdjMCrkk+vSLxz4KZ+xFHVAQFBMh25kjXa6tlDUPjf5vXo1OAaeNdQN+kVPA==
X-Received: by 2002:a05:6902:15cc:b0:e11:baf6:a323 with SMTP id 3f1490d57ef6-e1a5ae02245mr1161106276.39.1724887591045;
        Wed, 28 Aug 2024 16:26:31 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340ca6a94sm344766d6.118.2024.08.28.16.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 16:26:30 -0700 (PDT)
Date: Wed, 28 Aug 2024 19:26:29 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Rolf Wentland <R.Wentland@gmx.de>
Subject: Re: [PATCH] btrfs: interrupt long running operations if the current
 process is freezing
Message-ID: <20240828232629.GA2980463@perftesting>
References: <7c5345c3acb54ca6e02fdb2398d9af14a0bebd35.1724885694.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c5345c3acb54ca6e02fdb2398d9af14a0bebd35.1724885694.git.wqu@suse.com>

On Thu, Aug 29, 2024 at 08:25:00AM +0930, Qu Wenruo wrote:
> [BUG]
> There is a bug report that running fstrim will prevent the system from
> hibernation, result the following dmesg:
> 
>  PM: suspend entry (deep)
>  Filesystems sync: 0.060 seconds
>  Freezing user space processes
>  Freezing user space processes failed after 20.007 seconds (1 tasks refusing to freeze, wq_busy=0):
>  task:fstrim          state:D stack:0     pid:15564 tgid:15564 ppid:1      flags:0x00004006
>  Call Trace:
>   <TASK>
>   __schedule+0x381/0x1540
>   schedule+0x24/0xb0
>   schedule_timeout+0x1ea/0x2a0
>   io_schedule_timeout+0x19/0x50
>   wait_for_completion_io+0x78/0x140
>   submit_bio_wait+0xaa/0xc0
>   blkdev_issue_discard+0x65/0xb0
>   btrfs_issue_discard+0xcf/0x160 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   btrfs_discard_extent+0x120/0x2a0 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   do_trimming+0xd4/0x220 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   trim_bitmaps+0x418/0x520 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   btrfs_trim_block_group+0xcb/0x130 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   btrfs_trim_fs+0x119/0x460 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   btrfs_ioctl_fitrim+0xfb/0x160 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   btrfs_ioctl+0x11cc/0x29f0 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   __x64_sys_ioctl+0x92/0xd0
>   do_syscall_64+0x5b/0x80
>   entry_SYSCALL_64_after_hwframe+0x7c/0xe6
>  RIP: 0033:0x7f5f3b529f9b
>  RSP: 002b:00007fff279ebc20 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>  RAX: ffffffffffffffda RBX: 00007fff279ebd60 RCX: 00007f5f3b529f9b
>  RDX: 00007fff279ebc90 RSI: 00000000c0185879 RDI: 0000000000000003
>  RBP: 000055748718b2d0 R08: 00005574871899e8 R09: 00007fff279eb010
>  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
>  R13: 000055748718ac40 R14: 000055748718b290 R15: 000055748718b290
>   </TASK>
>  OOM killer enabled.
>  Restarting tasks ... done.
>  random: crng reseeded on system resumption
>  PM: suspend exit
>  PM: suspend entry (s2idle)
>  Filesystems sync: 0.047 seconds
> 
> [CAUSE]
> PM code is freezing all user space processes before entering
> hibernation/suspension, but if a user space process is trapping into the
> kernel for a long running operation, it will not be frozen since it's
> still inside kernel.
> 
> Normally those long running operations check for fatal signals and exit
> early, but freezing user space processes is not done by signals but a
> different infrastructure.
> 
> Unfortunately btrfs only checks fatal signals but not if the current
> task is being frozen.
> 
> [FIX]
> Introduce a helper, btrfs_interrupted(), to check both fatal signals and
> freezing status, and apply to all long running operations, with
> dedicated error code:
> 
> - reflink (-EINTR)
> - fstrim (-ERESTARTSYS)
> - relocation (-ECANCELD)
> - llseek (-EINTR)
> - defrag (-EAGAIN)
> - fiemap (-EINTR)
> 
> Reported-by: Rolf Wentland <R.Wentland@gmx.de>
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I don't love the name, can we call it something like

btrfs_task_interrupted()

or something?  I don't want people to get confused about what it's doing.  Once
you rename it you can put

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

on it, thanks,

Josef

