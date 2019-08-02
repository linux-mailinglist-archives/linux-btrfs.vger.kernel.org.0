Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7797ED10
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 09:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389277AbfHBHDr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 03:03:47 -0400
Received: from mail1.windriver.com ([147.11.146.13]:55752 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732058AbfHBHDr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Aug 2019 03:03:47 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x723BsMQ006917
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 1 Aug 2019 20:11:54 -0700 (PDT)
Received: from [128.224.162.188] (128.224.162.188) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 1 Aug
 2019 20:11:53 -0700
Subject: Re: Bug Report: Btrfs prompts "can't allocate space for delete" when
 block size arounds 512M
From:   "Hongzhi, Song" <hongzhi.song@windriver.com>
To:     <linux-btrfs@vger.kernel.org>, <josef@toxicpanda.com>,
        <linux-kernel@vger.kernel.org>
CC:     <dsterba@suse.com>, <ltp@lists.linux.it>
References: <b501bcff-8be0-4303-8789-363fda4658e5@windriver.com>
Message-ID: <f6795b4b-d70e-491e-e7ce-d235ca1b95ff@windriver.com>
Date:   Fri, 2 Aug 2019 11:11:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b501bcff-8be0-4303-8789-363fda4658e5@windriver.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.188]
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add linux-kernel@vger.kernel.org.

Ping...


Thanks,

--Hongzhi


On 7/17/19 4:34 PM, Hongzhi, Song wrote:
> Hi friends,
>
> *Description:*
>
>
>     One LTP testcase, fs_fill.c, fails on btrfs with kernel error when 
> unlink files on Btrfs device:
>
>     "BTRFS warning (device loop0): could not allocate space for a 
> delete; will truncate on mount".
>
>
>     I found the loop block device formatted with btrfs roughly rangs 
> from 460M to 560M will cause the error.
>
>     256M and 1G all pass.
>
>
>     The fs_fill.c source code:
>
> [https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/fs_fill/fs_fill.c] 
>
>
>     The fs_fill.c calls unlink which triggers the error.
>
> [https://github.com/linux-test-project/ltp/blob/e3457e42c1b93f54bb81da746eba314fd34ad40e/testcases/kernel/fs/fs_fill/fs_fill.c#L55] 
>
>
> [https://github.com/linux-test-project/ltp/blob/e3457e42c1b93f54bb81da746eba314fd34ad40e/lib/safe_macros.c#L358] 
>
>
>
> *Error info:*
>
>     The issue maybe not reproduced everytime but four fifths chance.
>
>     fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file0
>     safe_macros.c:360: BROK: fs_fill.c:55: 
> unlink(mntpoint/thread10/file0) failed: ENOSPC
>     safe_macros.c:360: BROK: fs_fill.c:55: 
> unlink(mntpoint/thread11/file0) failed: ENOSPC
>     [62477.378848] BTRFS warning (device loop0): could not allocate 
> space for a delete; will truncate on mount
>     [62477.378905] BTRFS warning (device loop0): could not allocate 
> space for a delete; will truncate on mount
>
>
>
> *Kernel:*
>
>     After v5.2-rc1, qemux86-64
>
>     # make -j40 ARCH=x86_64 CROSS_COMPILE=x86-64-gcc
>     use qemu to bootup kernel
>
>
> *LTP:*
>
>     master branch: I tested on 20190625
>     Reproduce:
>
>     // build Ltp
>     # cd Ltp-source
>     # ./build.sh
>
>     // copy files to qemu
>     # cp runltp testcases/kernel/fs/fs_fill/fs_fill to qemu
>
>     // login to qemu:
>     // adjust block device size to 512M
>     # vi runltp
>     in function: create_block()
>         dd if=/dev/zero of=${TMP}/test.img bs=1024 count=262144
>         --->
>         dd if=/dev/zero of=${TMP}/test.img bs=1024 count=524288
>
>     // execute testcase
>     # runltp -f fs -s fs_fill
>
>
> *Analysis:*
>
>     One new kernel commit contained in v5.2-rc1 introduces the issue.
>
>     commit c8eaeac7b734347c3afba7008b7af62f37b9c140
>     Author: Josef Bacik <josef@toxicpanda.com>
>     Date:   Wed Apr 10 15:56:10 2019 -0400
>
>         btrfs: reserve delalloc metadata differently
>         ...
>
>
> Anyone's reply will be appreciated.
>
> --Hongzhi
>
>
>
>
>
