Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09504618B92
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 23:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKCWcr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 18:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiKCWcq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 18:32:46 -0400
Received: from len.romanrm.net (len.romanrm.net [IPv6:2001:41d0:1:8b3b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F348C7B
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 15:32:44 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by len.romanrm.net (Postfix) with SMTP id E00F74007C;
        Thu,  3 Nov 2022 22:32:40 +0000 (UTC)
Date:   Fri, 4 Nov 2022 03:32:40 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Matt Huszagh <huszaghmatt@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: How to replace a failing device
Message-ID: <20221104033240.7f219ed4@nvm>
In-Reply-To: <87sfiz3egt.fsf@gmail.com>
References: <87v8nyh4jg.fsf@gmail.com>
        <20221102003232.097748e7@nvm>
        <87v8nw3dcg.fsf@gmail.com>
        <20221103171848.540a9056@nvm>
        <87sfiz3egt.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 03 Nov 2022 14:39:14 -0700
Matt Huszagh <huszaghmatt@gmail.com> wrote:

> I was able to run btrfs scrub successfully with the problematic drive
> removed. Logs show that the following file has a checksum error:
> 
> BTRFS warning (device dm-0): checksum error at logical 10087829524480 on dev /dev/dm-4, physical 1883324207104, root 28842, inode 27543115, offset 74526720, length 4096, links 1 (path: matt/.recoll/library/xapiandb/docdata.glass)
> 
> What can I do to get BTRFS to no longer report a checksum error? Do I
> need to delete this along with all snapshots that contain it?

I believe that's one way, yes; or truncate it to zero bytes, or fully
overwrite with its copy from a backup.

> Ok, thanks for the input. But in theory, BTRFS with a redundant data
> RAID (such as RAID1 or RAID10) should allow scrub to preserve all data
> if a single drive fails, no?

It could, what I meant is that the experience you get while having a disk
failure does not seem polished enough.

For a start, it will cease to mount, and will require adding a "degraded"
mount option. Then, newly written data may get a "single" data profile, and
mounting with "degraded" the second time may fail. To work-around this you
could use the "ro" mount option as well, except that now FS-level operations
like adding or replacing a device will not work. How does one get out of this,
I am not entirely sure.

And there were some reports of bad experience with a disk failure during
normal operation (i.e. device going away, or starting to fail reads or
writes). In theory a RAID system should barely notice such an event, and let
the user smoothly disconnect and pop-in a replacement drive, then continue
working, not to mention without even a reboot. But from the general impression
from user reports, in Btrfs that currently stays only a theory at best.

-- 
With respect,
Roman
