Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E356611BE
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Jan 2023 22:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjAGVDf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Jan 2023 16:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAGVDf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Jan 2023 16:03:35 -0500
X-Greylist: delayed 188 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 07 Jan 2023 13:03:33 PST
Received: from len.romanrm.net (len.romanrm.net [IPv6:2001:41d0:1:8b3b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E294B43D80
        for <linux-btrfs@vger.kernel.org>; Sat,  7 Jan 2023 13:03:33 -0800 (PST)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by len.romanrm.net (Postfix) with SMTP id 71B584020A
        for <linux-btrfs@vger.kernel.org>; Sat,  7 Jan 2023 21:03:32 +0000 (UTC)
Date:   Sun, 8 Jan 2023 02:03:31 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     linux-btrfs@vger.kernel.org
Subject: Weird behavior (no commit?) when writing to a really slow block
 device
Message-ID: <20230108020331.3491fb52@nvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I am rsyncing some files from fast devices (100-200 MB/s) to a slow remote one
(15 MB/s) over nbd.

There is some strange behavior, at least on my current kernel 5.10.161:

  * free space shown in "df" does NOT decrease even after many hours and
    hundreds of GBs already written;

  * freshly written files (already fully copied by rsync log) are shown with
    their real size in "ls -la", but all have zero size in "du".

I keep an eye on: watch "grep -e Dirty -e Writeback: /proc/meminfo"
This currently shows:

  Dirty:            554936 kB
  Writeback:       3388616 kB

The latter figure hovers around 3.5-4 GB all the time. For these syncing
setups, I have these settings tweaked on this machine (so I guess it's not as
large as it could have been with 64 GB of RAM):

  vm.dirty_background_ratio=5
  vm.dirty_ratio=10

As I understand the described weird symptoms would have cleared up if there
was a complete flush of data and metadata. And I suspect issuing a "sync" on
command-line would cause that to occur. But the question is why this didn't
occur on its own, as said above, over many hours of copying? If I disconnect
the block device now, wouldn't everything copied so far be actually lost?

I know there are the "commit" and "flushoncommit" options, but in this case I
haven't overridden either. Mount options are:

  rw,noatime,nodiratime,compress=zstd:3,nossd,space_cache=v2,skip_balance,subvolid=5,subvol=/

So if I had to guess, given a slow block device and the constant ongoing write
load trying to stream at a much faster rate, the "commit" doesn't actually
happen, neither in its predefined default interval of 30 seconds, nor during
much much longer (hours).

-- 
With respect,
Roman
