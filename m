Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A4B604FCC
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 20:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJSSjm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 14:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJSSjl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 14:39:41 -0400
X-Greylist: delayed 576 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 11:39:39 PDT
Received: from manchmal.in-ulm.de (manchmal.in-ulm.de [217.10.9.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5507236BF3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 11:39:38 -0700 (PDT)
Date:   Wed, 19 Oct 2022 20:29:59 +0200
From:   Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
To:     linux-btrfs@vger.kernel.org
Subject: Endless "reclaiming chunk"/"relocating block group"
Message-ID: <1666204197@msgid.manchmal.in-ulm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_05,HEXHASH_WORD,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

On some systems I observe a strange behaviour: After remounting a BTRFS
readwrite, a background process starts doing things on the disk,
messages look like

| BTRFS info (device nvme0n1p1): reclaiming chunk 21486669660160 with 100% used 0% unusable
| BTRFS info (device nvme0n1p1): relocating block group 21486669660160 flags data
| BTRFS info (device nvme0n1p1): found 4317 extents, stage: move data extents
| BTRFS info (device nvme0n1p1): found 4317 extents, stage: update data pointers

and (with differing numbers) this goes on for hours and days, at a
read/write rate of about 165/244 kbyte/sec. The filesystem, some 2.5
Gbyte total size, is filled to about 55%, so even if that process
touches each and every block, it should already have handled everything,
several times.

Now, I have no clue what is happening here, what triggers it, if it will
ever finish. Point is, this takes a measuarable amount of I/O and CPU,
and it delays other processes.


Some details, and things I've tested:

This behaviour is reproducible 100%, even with a btrfs created mere
moments ago.

The filesystem was created using the 5.10 and 6.0 version of the
btrfs-progs (both as provided by Debian stable and unstable resp.).

Using the grml rescue system (stable and daily, the latter kernel 5.19),
the system does not show this behaviour.

The group block number is constantly increasing (14 digits after two
days), in other words, I have not observed a wrap-around.

It was suggested in IRC to format using the --mixed parameter, no avail.

It was also suggested to set the various bg_reclaim_threshold to zero to
stop this process, no avail.

This is amd64 hardware without any unusual elements. I could easily
reproduce this on a fairly different platforms to make sure it's not
hardware specific.

Scrubbing did not show any errors, and the problem remained.


The host runs a hand-crafted kernel, currently 5.19, and I reckon this
is the source of the problem. Of course I've compared all the BTRFS
kernel options, they are identical. In the block device layer
configuration I couldn't see any difference that I can think would
relate to this issue. Likewise I compared all kernel configuration
options mentioned in src/fs/btrfs/, still nothing noteworthy.


So I'm a bit out of ideas. Unless there's something obvious from the
description above, perhaps you could give a hint to the following: The
process that emits the messages above, is there a way to stop it, or to
report completion percentage? Looking intobtrfs_reclaim_bgs_work
(block-group.c), it doesn't look like it. Are block group numbers really
*that* big, magnitudes over the size of the entire filesystem?

Regards,

    Christoph

