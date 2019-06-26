Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC78567B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2019 13:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfFZLgc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jun 2019 07:36:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:44236 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727139AbfFZLgc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jun 2019 07:36:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF211AB9B;
        Wed, 26 Jun 2019 11:36:30 +0000 (UTC)
Date:   Wed, 26 Jun 2019 13:36:29 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     "Hongzhi, Song" <hongzhi.song@windriver.com>
Cc:     ltp@lists.linux.it, linux-btrfs@vger.kernel.org
Subject: Re: Bug Report: fs_fill: fails on btrfs with "ENOSPC" when disk size
 = 512M
Message-ID: <20190626113629.GA13189@rei.lan>
References: <a361073f-3fbd-13af-b688-01da6b443b22@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a361073f-3fbd-13af-b688-01da6b443b22@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!
Not being able to delete a file on a filled filesystem sounds like a
filesystem bug to me. CCying Btrfs mailing list.

>       Description:
> 
> fs_fill fails on Btrfs when /dev/loop//*size = 512M*/.
> I tested other size, 256M 1G, all passed.
> 
> 
>       Kernel:
> 
> v5.2-rc1, qemux86-64
> 
> |# make -j40 ARCH=x86_64 CROSS_COMPILE=x86-64-gcc use qemu to bootup kernel |
> 
> 
>       LTP:
> 
> master branch: date 20190625
> 
> 
>       Reproduce:
> 
> |build ltp source and cp ltp all outputs to qemu # vi runltp in 
> function: create_block() dd if=/dev/zero of=${TMP}/test.img bs=1024 
> count=262144 ---> dd if=/dev/zero of=${TMP}/test.img bs=1024 
> count=524288 # runltp -f fs -s fs_fill |
> 
> 
>       Issue:
> 
> The issue maybe not reproduced everytime but four fifths chance.
> 
> |safe_macros.c:358: BROK: fs_fill.c:67: unlink(mntpoint/thread9/file0) 
> failed: ENOSPC safe_macros.c:358: BROK: fs_fill.c:67: 
> unlink(mntpoint/thread4/file0) failed: ENOSPC [ 154.762502] BTRFS 
> warning (device loop0): could not allocate space for a delete; will 
> truncate on mount [ 155.691577] BTRFS warning (device loop0): could not 
> allocate space for a delete; will truncate on mount [ 156.017697] BTRFS 
> warning (device loop0): could not allocate space for a delete; will 
> truncate on mount |
> 
> 
>       Analysis:
> 
> One new kernel commit contained in v5.2-rc1 introduces the issue.
> 
> |commit c8eaeac7b734347c3afba7008b7af62f37b9c140 Author: Josef Bacik 
> <josef@toxicpanda.com> Date: Wed Apr 10 15:56:10 2019 -0400 btrfs: 
> reserve delalloc metadata differently ...|
> 
> 
> Anyone's reply will be appreciated.
> 
> --Hongzhi
> 
> ||

-- 
Cyril Hrubis
chrubis@suse.cz
