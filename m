Return-Path: <linux-btrfs+bounces-7378-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D661495A5B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 22:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5031F22FA6
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 20:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A16116FF44;
	Wed, 21 Aug 2024 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VNTU/eEH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CCB1D12F4
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724271222; cv=none; b=JbZ0VMpmp+60oRjziCuM/Wp4GAv+V4Uk9OB3AqKFXs8WraHrRt1vQlzPkhXk2Xf6i4He9J146Y29FBNMv1OW42+ewD6p8gt3NhRUaTZ1h0ghn4LopA8QKUiwXkMw64fp71G5JR1Jjeb74dYW6vjrcRb7W2GuftsPuJytHzLy/dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724271222; c=relaxed/simple;
	bh=LURSiKjo2JQN9dRGWFRkWt6N1bvrp+X/h+jx6sqK4L0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+ORTNSYHvspUDQEVKszL5L5ECq9ND8Cnjri87GpC+WbMiT+mJG/HyzaObK0OWXufIPn7rh2pUea93LghT8+6NVZV32XxuilJppvmhO8fIVZzkoQup26KVa+qxzZmXcoSXq+phnEnavwrwmdZ11T0cYZ5AqsIKQx7V6kO2dU//U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=VNTU/eEH; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e13c23dbabdso118414276.3
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 13:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724271220; x=1724876020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YYmNcsedkOqUFLEQeKe1yqW9pGRfFKO4juWfk6FKFmU=;
        b=VNTU/eEH94wpXyGmPB1BdqE68+dwIk+Ck91tBIZz89QN/TAWRgFxnuLjLh8CWAygFd
         Oc5YbbkTAbBBiT3owI6CPH9jSCEM7/xk2Qa0L5qhjygcOgynDVKSYXVqTvx2Bi0/g+Ur
         2Rzmk+xxYtV5uNvkYoWCVcM2V9LpuO12nvIjtT+AudVjwNgRee3l7cDbSqzazsS+E4lU
         rd6ZQ7yNtfi9ng02gkbBc1ufcPxkHvWiWNEMedQX4FQ9YiZ05kW3L0WvqpVwide7o1CE
         D1lZ8PGdH5KXd8t/Cc1rPE+IkXnVAzfcYvem9QLRt56kA7epJB9I8pOC723Jf04zFtGg
         HFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724271220; x=1724876020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYmNcsedkOqUFLEQeKe1yqW9pGRfFKO4juWfk6FKFmU=;
        b=cEObY1LF6vZks0u7GbmhVhMGsgfuZXK7tdK+YdoZhpCLD7pUM9H80y2NHvUTrxZWW7
         +KWc/BRpXkQ4vD03A9g1vRkmqg4d/alZYgFZhy0R0TgX03+jY7vzTQkd/3+3b99djZML
         Mgs6Dod+tVW0UBEoSjNrLcVe+1VBEtKyhO/ri2qQygXtK/xBdxD7YuEziPeU0j0KecNa
         i65ZNd+aY6TOD3LDDIf5NbloNUQI7OhdlmufImKC2Loh+d69icEsXHjK9IiYGdC9AQBn
         HvTW4r2eQpfoWsTduEmpxp44HIL/S2RYtxBJKKJsKzk9ga7sfRVRgd7fYd18bE6F3Tzn
         McOA==
X-Forwarded-Encrypted: i=1; AJvYcCX3jVOXixeeel7dKv1j6Vn/m+teuLyfXMHqd1AvBagpwCzGWcRJJMBKBOnpJ0MRfMGM7w7xCiM33HKOCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxC2WHquXyoQuC1dszsNr8FpFcI5ltdmiSfAzJ9r9Mn90Hs8J9F
	EQXR5ySdX+W47VDVyHjol0Y/VOG4QKpS39Ik3nWPqayUFsIFvBhJ5TIc7hwURt8=
X-Google-Smtp-Source: AGHT+IGx0uv0WJiwFWZKjviM9+GmZlu0vQylW48VVx9PfvDLz248cWEULf/z5v0Gbzu1ZFB5VbSdUw==
X-Received: by 2002:a05:6902:2508:b0:e16:4d32:adcd with SMTP id 3f1490d57ef6-e166549c3damr3770246276.29.1724271219864;
        Wed, 21 Aug 2024 13:13:39 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e67e660sm3818276.54.2024.08.21.13.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 13:13:39 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:13:38 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: syzbot <syzbot+dfb6eff2a68b42d557d3@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (6)
Message-ID: <20240821201338.GA2109582@perftesting>
References: <0000000000008f55e4062036c827@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008f55e4062036c827@google.com>

On Wed, Aug 21, 2024 at 12:45:25PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5c43d43bad35 Merge branches 'for-next/acpi', 'for-next/mis..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=13471a05980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c91f83ae59feaa1f
> dashboard link: https://syzkaller.appspot.com/bug?extid=dfb6eff2a68b42d557d3
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10efded5980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e94093980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cc2dd4be620e/disk-5c43d43b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/81d40d99ddbf/vmlinux-5c43d43b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/bc6aed0f2bc5/Image-5c43d43b.gz.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/d55321fffedc/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+dfb6eff2a68b42d557d3@syzkaller.appspotmail.com
> 
> BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!

Can we disable syzbot issues for this specific error?  Btrfs uses lockdep
annotations for our tree locks, so we _easily_ cross this threshold on the
default configuration.  Our CI config requires the following settings to get
lockdep to work longer than two or three tests

CONFIG_LOCKDEP_BITS=20
CONFIG_LOCKDEP_CHAINS_BITS=20
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12

but there's no way to require that in our config (nor do I think we should
really be able to tbqh).  It makes more sense for syzbot to just ignore this
particular error as it's not actually a bug.  Thanks,

Josef

