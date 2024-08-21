Return-Path: <linux-btrfs+bounces-7374-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369E995A463
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 20:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E214A282D68
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 18:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F3A1B3B0A;
	Wed, 21 Aug 2024 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ZbqPWpPF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36142142631
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263687; cv=none; b=qlv5hQtFQlv+isEJPbi2J2LTwlpBRNhT66Mm0MF75caqMOe055085Tv4d9iKDiJ3cWIojtkaAY+wFu6j2RKtM2fYAKddOMvaXGbfeFYvekZ3qsdDM+odAaA49ZZHNpPr9Fm8HnXBLuoy7u2w/mXLvEBhw99xktVbYWmN5TUb1Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263687; c=relaxed/simple;
	bh=0lVqIJGc2EApbGk353iTzWJaICl9QseyhZch818YFDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMVnpojN2UMOOh5StOwRHe61oEKrTJrVTRMzv0zkd3KC0wZaYdgBxfTqTTUGOJFAOnihqNgWMw6tX2O6bq/RPYBRTQgrQSX1QJ88c248vYIEFTX++ljCe6HOO7W7vIxL7C1jKuP2cxc53NOMu51nsyMzzD4L+4T3ADDfeGltLUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ZbqPWpPF; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e05f25fb96eso14113276.1
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 11:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724263685; x=1724868485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2dWuKHtJVS6aU/UltCyUUTv5aoTU265tGKaSxNwpdg=;
        b=ZbqPWpPFKP4dDIi9l343J99R9GzBkAFGtkyLN/NINrnaUfrocUnyG4xqj8LMLU185R
         IjzZjsbh0JSb6u81j8MYBgExi0oOFyUlXDWvDf0VyW7CNMBjqc/z8D9eM/2hMcY2K+M+
         udE+wUTDwTH2KEv3d62ivFWaV95zVqyLow/yOuqXY4RN1chz2fsbx/ns5MmUuWkkTIMi
         DfRqfbdnI2k3ePy09LiF4YnZ07ehESpLoVaZA+RPDVgUz2C6PD7JfoVIjr3/O1aClQhb
         35ADv7dW/CTQF7GDKOE4hOE+m0d8B7mEapa9ckplW2MVfujVPzbrxvDg72VFawz+9JKd
         qQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724263685; x=1724868485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2dWuKHtJVS6aU/UltCyUUTv5aoTU265tGKaSxNwpdg=;
        b=wp1LpQs+2djIgqUoLFWjsKXniHqKVwUx11FtDqchzyrj4WnsoyATFKj2B0I2LEd9Cf
         XvUQRG74WrDbvv6uMBumQ21sHFWYFDyzikx4CV7Ia4xpyex7enH7cj6TiiwE9DJV7OHj
         oTb8pIr+kMNXfEEDZhAYM6pr8YlZ+LWNyYoLRknAwZKnBmNrdt1gZcvdflGQhl1IyiUg
         0rlBmMMOAqBiMCgocYYUySrHpThlhAGHjIgpOH/3adh+WS79xm84ExqNoz1N78eXtQvA
         xEX6DVKoY54/b0HI4nK1RC94Ay7i5oUe7T/VAhiji+OI1djbZ0Bb3Fo/0Z2reZUMqKYj
         xkUQ==
X-Gm-Message-State: AOJu0YyXZBqAj+/hxraHftCnc5h9iifAUNlZ9XZohYfjXrnTncA/BQcB
	tHWn4l/avQgrx6twYONc9TmzvS0GlVj3jkyNArQRe60hgMj8mhIa0Gn0OQrDNNQ=
X-Google-Smtp-Source: AGHT+IGnmZPgepuL3HGkgA7tjMbmplROCP26e6nLpdI6NT2SWykOfXGaiQxacnbMvy6ZRM2xdJfSRA==
X-Received: by 2002:a05:6902:220e:b0:e14:db6f:d94b with SMTP id 3f1490d57ef6-e166553a542mr3575809276.44.1724263685226;
        Wed, 21 Aug 2024 11:08:05 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1171e709e1sm3098525276.34.2024.08.21.11.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 11:08:04 -0700 (PDT)
Date: Wed, 21 Aug 2024 14:08:04 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
	syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix the race between umount and btrfs-cleaner
Message-ID: <20240821180804.GF1998418@perftesting>
References: <20240821114628.645455-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821114628.645455-1-sunjunchao2870@gmail.com>

On Wed, Aug 21, 2024 at 07:46:28PM +0800, Julian Sun wrote:
> There is a race condition generic_shutdown_super() and
> __btrfs_run_defrag_inode().
> Consider the following scenario:
> 
> umount thread:             btrfs-cleaner thread:
> 			     btrfs_run_delayed_iputs()
> 			       ->run_delayed_iput_locked()
> 				->iput(inode)
> 				  // Here the inode (ie ino 261) will be cleared and freed
> btrfs_kill_super()
>   ->generic_shutdown_super()
>     			     btrfs_run_defrag_inodes()
> 			       ->__btrfs_run_defrag_inode()
> 				->btrfs_iget(ino)
> 				// The inode 261 was recreated with i_count=1
> 				// and added to the sb list
>     ->evict_inodes(sb)          // After some work
>     // inode 261 was added      ->iput(inode)
>     // to the dispose list        ->iput_funal()
>       ->evict(inode)                ->evict(inode)

This is wrong though, evict_inodes() isn't supposed to isolate if i_count == 1,
and iput_final sets I_FREEING, so we won't get the evict() from evict_inodes.
Something else is happening here.  Thanks,

Josef

