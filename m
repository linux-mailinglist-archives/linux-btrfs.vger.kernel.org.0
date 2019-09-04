Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6CBA7E0F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 10:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfIDIlL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 04:41:11 -0400
Received: from mail5.windriver.com ([192.103.53.11]:45074 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728598AbfIDIlL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Sep 2019 04:41:11 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x848dwSc017399
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 4 Sep 2019 01:40:25 -0700
Received: from [128.224.162.188] (128.224.162.188) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 4 Sep
 2019 01:39:52 -0700
Subject: Re: Bug?: unlink cause btrfs error but other fs don't
To:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
References: <49edadc4-9191-da89-3e3b-ca495f582a4d@windriver.com>
CC:     <josef@toxicpanda.com>
From:   "Hongzhi, Song" <hongzhi.song@windriver.com>
Message-ID: <bbdb613c-020b-03ec-c218-57299c3f6b29@windriver.com>
Date:   Wed, 4 Sep 2019 16:39:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <49edadc4-9191-da89-3e3b-ca495f582a4d@windriver.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.188]
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Nikolay,

 >

There were multiple fixes from Josef recently improving btrfs enospc
handling with tiny filesystems (which is generally not the targeted use
case of btrfs). The code lives in
https://github.com/kdave/btrfs-devel/commits/misc-next  should you want
to test it. Otherwise re-test after next merge windows when those
patches are supposed to be merged for 5.4

 >


Thank for your reply, I will keep eyes on the branch.

ps: this email is my simply testcase from ltp


--Hongzhi


On 9/4/19 4:02 PM, Hongzhi, Song wrote:
> Hi ,
>
>
> *Kernel:*
>
>     After v5.2-rc1, qemux86-64
>
>     make -j40 ARCH=x86_64 CROSS_COMPILE=x86-64-gcc
>     use qemu to bootup kernel
>
>
> *Reproduce:*
>
>     There is a test case failed on btrfs but success on other 
> fs(ext4,ext3), see attachment.
>
>
>     Download attachments:
>
>         gcc test.c -o myout -Wall -lpthread
>
>         copy myout and run.sh to your qemu same directory.
>
>         on qemu:
>
>             ./run.sh
>
>
>     I found the block device size with btrfs set 512M will cause the 
> error.
>     256M and 1G all success.
>
>
> *Error info:*
>
>     "BTRFS warning (device loop0): could not allocate space for a 
> delete; will truncate on mount"
>
>
> *Related patch:*
>
>     I use git bisect to find the following patch introduces the issue.
>
>     commit c8eaeac7b734347c3afba7008b7af62f37b9c140
>     Author: Josef Bacik <josef@toxicpanda.com>
>     Date:   Wed Apr 10 15:56:10 2019 -0400
>
>         btrfs: reserve delalloc metadata differently
>         ...
>
>
> Anyone's reply will be appreciated.
>
> --Hongzhi
>
