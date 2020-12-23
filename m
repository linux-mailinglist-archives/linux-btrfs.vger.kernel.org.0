Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E2D2E215B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Dec 2020 21:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgLWUc7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Dec 2020 15:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgLWUc6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Dec 2020 15:32:58 -0500
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E35FC061794
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Dec 2020 12:32:18 -0800 (PST)
Received: from tux.applied-asynchrony.com (p5b07ef82.dip0.t-ipconnect.de [91.7.239.130])
        by mail.itouring.de (Postfix) with ESMTPSA id 0D85CD31D8E;
        Wed, 23 Dec 2020 21:31:33 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id B8791EEB5C0;
        Wed, 23 Dec 2020 21:31:32 +0100 (CET)
Subject: Re: [BUG] 500-2000% performance regression w/ 5.10
To:     Josef Bacik <josef@toxicpanda.com>, rene@exactcode.de,
        linux-btrfs@vger.kernel.org
References: <B4BB2DCB-C438-4871-9DDD-D6FB0E6E4F1B@exactcode.de>
 <0382080a1836a12c2d625f8a5bf899828eba204b.1608752315.git.josef@toxicpanda.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <276b374f-57fe-f354-9571-9f76d743785d@applied-asynchrony.com>
Date:   Wed, 23 Dec 2020 21:31:32 +0100
MIME-Version: 1.0
In-Reply-To: <0382080a1836a12c2d625f8a5bf899828eba204b.1608752315.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-12-23 20:41, Josef Bacik wrote:
> Could you give this a try?  I'm not able to reproduce the problem, but I'm

Since I wanted to rule out NVME/block layer/scheduler etc. I tried and
could reproduce it immediately, see below. Didn't notice it earlier since
most of btrfs is read-mostly.. :(

> testing inside of a VM.  I'm in the middle of Christmas stuff, but I'll get
> ahold of a giant machine at work tomorrow and see if I can reproduce there.
> Meanwhile can you give this a shot?  I have a sneaking suspicion why it happens
> on your baremetal and not in VM's, and this will be a partial enough of a revert
> of the patch you bisected to validate what I'm thinking.  THanks,

The patch doesn't apply to 5.10.x since btrfs_start_delalloc_roots() does not
have the trailing true/false argument yet. I removed it, which seemed to have
worked. :}

Results using -dsingle/-msingle/space tree, all on tmpfs:

Unpatched:

kernel tree, ~1.1G:
$time (cp -a /tmp/linux-5.10.3 /tmp/butter && sync -f /tmp/butter)
( cp -a /tmp/linux-5.10.3 /tmp/butter && sync -f /tmp/butter; )  0.37s user 3.26s system 6% cpu 52.144 total

-> slow as hell since it's thousands of small files. Writeback runs at ~5-10 MB/s.

large file:
$fallocate -l 2G /tmp/largefile
$time (cp -a /tmp/largefile /tmp/butter && sync -f /tmp/butter)
( cp -a /tmp/largefile /tmp/butter && sync -f /tmp/butter; )  0.00s user 0.91s system 75% cpu 1.215 total

-> OK-ish since it's just one big file.

With your patch & the 'true' arg to btrfs_start_delalloc_roots() removed:

kernel tree:
$time (cp -a /tmp/linux-5.10.3 /tmp/butter && sync -f /tmp/butter)
( cp -a /tmp/linux-5.10.3 /tmp/butter && sync -f /tmp/butter; )  0.28s user 2.44s system 60% cpu 4.475 total

rewrite:
$time (cp -a /tmp/linux-5.10.3 /tmp/butter && sync -f /tmp/butter)
( cp -a /tmp/linux-5.10.3 /tmp/butter && sync -f /tmp/butter; )  0.28s user 2.87s system 93% cpu 3.357 total

Clearly better.

Hope this helps :)

Holger
