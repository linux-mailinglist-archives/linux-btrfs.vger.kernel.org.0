Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E306220BDC3
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jun 2020 04:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgF0Cm5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 22:42:57 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42004 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgF0Cm5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 22:42:57 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 337E17358D8; Fri, 26 Jun 2020 22:42:56 -0400 (EDT)
Date:   Fri, 26 Jun 2020 22:42:56 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs raid5 hangs at the end of 'btrfs replace'
Message-ID: <20200627024256.GT10769@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On kernel 5.4.41, I did a btrfs replace of a failed disk on a -draid5
-mraid1 filesystem with 3 btrfs devices on top of dm-crypt and lvm.

The first attempt ended with a hang and watchdog reboot.  After rebooting
and mounting the filesystem, 'btrfs replace' resumed automatically.

btrfs replace locked up at the end of the replace operation, after 
reporting in the kernel log that it had finished with 0 errors.  This is
the 'btrfs-devreplace' kernel stack a couple of hours after 'btrfs status'
reported completion and all disks were idle:

        [<0>] btrfs_rm_dev_replace_blocked+0x8b/0xb6
        [<0>] btrfs_dev_replace_finishing+0x554/0x5d8
        [<0>] btrfs_dev_replace_kthread+0x110/0x160
        [<0>] kthread+0x12d/0x150
        [<0>] ret_from_fork+0x27/0x50

        (gdb) l *(btrfs_rm_dev_replace_blocked+0x8b)
        0xffffffff815afa6f is in btrfs_rm_dev_replace_blocked (fs/btrfs/dev-replace.c:552).
        547      * blocked until all in-flight bios operations are finished.
        548      */
        549     static void btrfs_rm_dev_replace_blocked(struct btrfs_fs_info *fs_info)
        550     {
        551             set_bit(BTRFS_FS_STATE_DEV_REPLACING, &fs_info->fs_state);
        552             wait_event(fs_info->dev_replace.replace_wait, !percpu_counter_sum(
        553                        &fs_info->dev_replace.bio_counter));
        554     }

One reboot later, the replace resumed from 93% and finished ('btrfs
replace' process exited).  All the devices are back to their correct IDs.
Something is still broken, because resize does not work:

        # btrfs fi resize 8:max .
        Resize '.' of '8:max'
        ERROR: resizing of '.' failed: add/delete/balance/replace/resize operation in progress
        # btrfs balance status .
        No balance found on '.'

Another reboot later, the replace is finally really done, and I can
resize the replaced device.
