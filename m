Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91A679DE47
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 04:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjIMC2y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 22:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjIMC2x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 22:28:53 -0400
Received: from w1.tutanota.de (w1.tutanota.de [81.3.6.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA091713
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 19:28:49 -0700 (PDT)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
        by w1.tutanota.de (Postfix) with ESMTP id BCD32FBFADF
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Sep 2023 02:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1694572127;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
        bh=Cc/R0rNkiCHxmvDwlGKbQI0pZsVjlCkXX1PrwgEH1EM=;
        b=hcEdfSIGMJmiFv1Yoaa/ZjiHHxtitTaoKYWrWadBPJNGICIZ0cBg+CRFJauuClD9
        jnfVJ7oAak4JZrtj0uqDzDN5G8l1PqXe7l2cr2ONC4/YngGf1tvbXEowAihyF1yGWLu
        eXMhBknxQSJi/Fh/Axeb2nto3EurGCJb8Xltukr+dnUUXO9NULjFS4RdghYKKycDHzY
        htBNJmunNCdV+JOyeiFS2Cjfp7TfDxWkXAH3Pn3y3kyjzU2udv3rv4evgxIeoX6QmMY
        XBMeebXtpA+voYsHtizLwvCOXNRrzVBKpmr0lBSVkXdTFkILgC6lxybJay9Fkh18QT4
        RctYmi1gJg==
Date:   Wed, 13 Sep 2023 04:28:47 +0200 (CEST)
From:   fdavidl073rnovn@tutanota.com
To:     Linux Btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <NeBMdyL--3-9@tutanota.com>
Subject: Deleting large amounts of data causes system freeze due to OOM.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear Btrfs Mailing List,

Full disclosure I reported this on kernel.org but am hoping to get more exposure on the mailing list. 

When I delete several terabytes of data memory usage increases until the system becomes entirely unresponsive. This has been an issue for several kernel version since at least 5.19 and continues to be an issue up to 6.5.2-artix1-1. This is on an older computer with several hard drives, eight gigabytes of memory, and a four core x86_64 cpu. Slabtop output right before the system becomes unresponsive shows about four gigabytes used by khugepaged_mm_slot and three used by btrfs_extent_map. This happens in over the span of a couple minutes and during this time btrfs-transaction is using a moderate amount of cpu time.

While this is happening the free space reported by btrfs filesystem usage slowly falls until the system is unresponsive. If I delete smaller amounts of data at a time memory usage increases but if the system doesn't go out of memory all the disk space is freed and memory usage comes back down. Deleting things bit by bit isn't a useful workaround because this also happens when deleting a snapshot even if it won't free any disk space and I am trying to use this computer for incremental backups.

The only things that seem to cause a difference are the checksum used and slower hard drives. Checksum changes the behavior of the issue. If using xxhash when I remount the filesystem it seems to try to either restart or continue the delete operation causing another out of memory condition but using the default crc32 remounting the filesystem has it in the original state before the delete command was issued and nothing happens (I haven't tried any other checksums). Having slower (SMR) drives as part of the device causes the out of memory to happen much faster. Nothing else like raid level, compression, kernel version, block group tree have seemed to change anything.

My speculation is that operations to finish the delete are being queued up in memory faster than they can be completed until the system completely runs out of memory. That would explain what's happening, why slower drives make it worse, and why deleting small amounts of data works. I'm not sure why checksum seems to change the behavior when remounting the filesystem.

I am willing to do destructive testing on this data to hopefully get this fixed.

Sincerely,
David
