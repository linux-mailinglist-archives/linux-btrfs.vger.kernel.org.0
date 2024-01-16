Return-Path: <linux-btrfs+bounces-1493-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E646C82FC6A
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 23:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0511C27E06
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 22:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8010E5A783;
	Tue, 16 Jan 2024 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="KTiMy+kc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CBC286AD
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 20:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705438566; cv=none; b=LaNA0783HSVAcz4b9W47RBg7OKvB17VaCrQ8qxS16BqKom5/OvRFe6j/GFZe38mXeKnzWdlmrgbmlU+mK66QwvBMay5zWSu3fB6q5Cwq58UGKQdW6P3n5OMXQosIfC4T8p11h19wE59VRIA62fQTNp1f0T877ssrYGkJFy5xdg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705438566; c=relaxed/simple;
	bh=qkJUyIiGo86M3vJLmeWZoSuCSRe8dbtkBlXcHSS3RgI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=P9iXjvEz/FW4anZPvYl+VTCiZ1DKhF7Cy4kzXcjYSnb1gYRHgaVp/abvWbqb1v3j+j9VWAeqxtx67ysHzwdPDfr5N/4uE9ftdKB4xaRBQvnc+edfygjOUO/byYfpt1I0xm5JniRK6+dckMcRcUzmWB9ZFfAPqgHR/Ywfl34kWXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=KTiMy+kc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d54b765414so70385905ad.0
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 12:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1705438564; x=1706043364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R4ODcMiKnN9uc2CQEPWploNVotAW/sU5YV82cEbm6cw=;
        b=KTiMy+kc8JM8fXcGwycKna1LSTL4do94MyhgRte9j54JnihFeB1IA0sO7I1owyyMTx
         xaE+G752K7bgmoG4qavU3fZOI+hW74eNbuNT1ueZ8bVUe3FArp6BiEsrYzZLHQUA6P1k
         Apo6rUKDDAkPt/GMi4cxlwuTXUxJSPWAIL+3z2LDDqDVU0R6A9o5UxJehJanaCncpAjA
         4hpap9oWpHxkD51lQyNt4UECrCO/xR9Jr8j5yqWQ5lr6zUkWtXaFLO2UV/pSYowQsSFG
         /+H0+IWMlrN47NstkWCeb+E8NMKZZhJsqJu/STzTPEao3E+UKHE7Ga7yokD8HdX6K2co
         wWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705438564; x=1706043364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4ODcMiKnN9uc2CQEPWploNVotAW/sU5YV82cEbm6cw=;
        b=sYeJ4x7PmIoEWqUxoCEvxiPTfoPN44GDJ0M9rWo9l2v1cMf+wzH/ipHwq62+BulSas
         zgPpegghE6IEgUKobBqBh9stB0iVao9daonK7z4gEGy0HS196MQbiDtWFAtdBS7JaCji
         JqVR+VYPne0xBdfajvfSbePvYMQJ2eDaIGOvG8zDhfP3kBTgT2aRl4wB5SDeSwJj73ZM
         qZ7K+pQJZg1HryrQUA+Scc+S9XjPA5OjH6UmdqAv0g9NhsSsvMCOpIJYhVEF4CxZP/7y
         Cr88dVfspehWqoP8g321JM+MinVfFeYakKVS1V5xZcSfkeKFzerXsd/61RMWXPa7jfOi
         5XbA==
X-Gm-Message-State: AOJu0YzZwXfKs/t6FaiQbQMGUB0frv4v3h2yMe9+xiFIYCHkEuF/QQQt
	wVDHwrTF5Ysoojy3dVNJaqYU4NzRpPxGHA==
X-Google-Smtp-Source: AGHT+IFwoCp6EyOkXVbSZ/bZy3zGhRgZXj/tnkE3Ntm0JfGhaZXJ5mMWTPmLTDkXojp/i0RmI+gT9w==
X-Received: by 2002:a17:903:1c4:b0:1d4:ca3d:742e with SMTP id e4-20020a17090301c400b001d4ca3d742emr10699298plh.67.1705438564540;
        Tue, 16 Jan 2024 12:56:04 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090264cf00b001d5e734868esm1716838pli.241.2024.01.16.12.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 12:56:03 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rPqTZ-00BIHT-0N;
	Wed, 17 Jan 2024 07:56:01 +1100
Date: Wed, 17 Jan 2024 07:56:01 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
	linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
Message-ID: <ZabtYQqakvxJVYjM@dread.disaster.area>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116-tagelang-zugnummer-349edd1b5792@brauner>

On Tue, Jan 16, 2024 at 11:50:32AM +0100, Christian Brauner wrote:
> Hey,
> 
> I'm not sure this even needs a full LSFMM discussion but since I
> currently don't have time to work on the patch I may as well submit it.
> 
> Gnome recently got awared 1M Euro by the Sovereign Tech Fund (STF). The
> STF was created by the German government to fund public infrastructure:
> 
> "The Sovereign Tech Fund supports the development, improvement and
>  maintenance of open digital infrastructure. Our goal is to sustainably
>  strengthen the open source ecosystem. We focus on security, resilience,
>  technological diversity, and the people behind the code." (cf. [1])
> 
> Gnome has proposed various specific projects including integrating
> systemd-homed with Gnome. Systemd-homed provides various features and if
> you're interested in details then you might find it useful to read [2].
> It makes use of various new VFS and fs specific developments over the
> last years.
> 
> One feature is encrypting the home directory via LUKS. An approriate
> image or device must contain a GPT partition table. Currently there's
> only one partition which is a LUKS2 volume. Inside that LUKS2 volume is
> a Linux filesystem. Currently supported are btrfs (see [4] though),
> ext4, and xfs.
> 
> The following issue isn't specific to systemd-homed. Gnome wants to be
> able to support locking encrypted home directories. For example, when
> the laptop is suspended. To do this the luksSuspend command can be used.
> 
> The luksSuspend call is nothing else than a device mapper ioctl to
> suspend the block device and it's owning superblock/filesystem. Which in
> turn is nothing but a freeze initiated from the block layer:
> 
> dm_suspend()
> -> __dm_suspend()
>    -> lock_fs()
>       -> bdev_freeze()
> 
> So when we say luksSuspend we really mean block layer initiated freeze.
> The overall goal or expectation of userspace is that after a luksSuspend
> call all sensitive material has been evicted from relevant caches to
> harden against various attacks. And luksSuspend does wipe the encryption
> key and suspend the block device. However, the encryption key can still
> be available clear-text in the page cache.

The wiping of secrets is completely orthogonal to the freezing of
the device and filesystem - the freeze does not need to occur to
allow the encryption keys and decrypted data to be purged. They
should not be conflated; purging needs to be a completely separate
operation that can be run regardless of device/fs freeze status.

FWIW, focussing on purging the page cache omits the fact that
having access to the directory structure is a problem - one can
still retrieve other user information that is stored in metadata
(e.g. xattrs) that isn't part of the page cache. Even the directory
structure that is cached in dentries could reveal secrets someone
wants to keep hidden (e.g code names for operations/products).

So if we want luksSuspend to actually protect user information when
it runs, then it effectively needs to bring the filesystem right
back to it's "just mounted" state where the only thing in memory is
the root directory dentry and inode and nothing else.

And, of course, this is largely impossible to do because anything
with an open file on the filesystem will prevent this robust cache
purge from occurring....

Which brings us back to "best effort" only, and at this point we
already have drop-caches....

Mind you, I do wonder if drop caches is fast enough for this sort of
use case. It is single threaded, and if the filesystem/system has
millions of cached inodes it can take minutes to run. Unmount has
the same problem - purging large dentry/inode caches takes a *lot*
of CPU time and these operations are single threaded.

So it may not be practical in the luks context to purge caches e.g.
suspending a laptop shouldn't take minutes. However laptops are
getting to the hundreds of GB of RAM these days and so they can
cache millions of inodes, so cache purge runtime is definitely a
consideration here.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

