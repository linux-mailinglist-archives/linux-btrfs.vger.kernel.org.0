Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEE15BB93F
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Sep 2022 18:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiIQQA3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Sep 2022 12:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIQQA1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Sep 2022 12:00:27 -0400
Received: from rin.romanrm.net (rin.romanrm.net [51.158.148.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA5015FFF
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Sep 2022 09:00:25 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id 233105B0
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Sep 2022 16:00:22 +0000 (UTC)
Date:   Sat, 17 Sep 2022 21:00:21 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     linux-btrfs@vger.kernel.org
Subject: Converting from single to raid0 creates a ton of unused data chunks
Message-ID: <20220917210021.5a84dc82@nvm>
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

Hello,

Just finished converting the remaining "single" data chunks on my FS to
"raid0", with btrfs-progs v5.10.1, kernel 5.10.140.

Before:

  Data, RAID0: total=200.00GiB, used=193.06GiB
  Data, single: total=107.00GiB, used=105.12GiB
  System, RAID1: total=32.00MiB, used=48.00KiB
  Metadata, RAID1: total=2.00GiB, used=488.64MiB
  GlobalReserve, single: total=353.98MiB, used=0.00B
  WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
  WARNING:   Data: single, raid0

Converting:

  # btrfs fi balance start -dprofiles=single -dconvert=raid0,soft /mnt/ssdm/
  Done, had to relocate 110 out of 209 chunks

After:

  Data, RAID0: total=412.00GiB, used=297.21GiB
  System, RAID1: total=32.00MiB, used=48.00KiB
  Metadata, RAID1: total=2.00GiB, used=466.83MiB
  GlobalReserve, single: total=332.31MiB, used=0.00B

As you can see it created a ton of "slack" in the RAID0 Data allocation.

Sure, I can collapse it down with:

  # btrfs fi balance start -dusage=50 /mnt/ssdm/
  Done, had to relocate 56 out of 209 chunks

And the result will be:

  Data, RAID0: total=302.00GiB, used=297.21GiB
  System, RAID1: total=32.00MiB, used=48.00KiB
  Metadata, RAID1: total=2.00GiB, used=466.83MiB
  GlobalReserve, single: total=332.19MiB, used=0.00B

But is this expected? I wonder what if this somewhat runaway chunk creation
would face no more free space to allocate for these, would the balance fail
with ENOSPC then?

-- 
With respect,
Roman
