Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F51D577AA5
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 07:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiGRFtt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 01:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiGRFts (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 01:49:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE3955AB
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jul 2022 22:49:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7136568D06; Mon, 18 Jul 2022 07:49:44 +0200 (CEST)
Date:   Mon, 18 Jul 2022 07:49:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org
Subject: error writing primary super block on zoned btrfs
Message-ID: <20220718054944.GA22359@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Naohiro, (and willy for insights on the pagecache, see below),

when running plain fsx on zoned btrfs on a null_blk devices as below:

dev="/sys/kernel/config/nullb/nullb1"
size=12800 # MB

mkdir ${dev}
echo 2 > "${dev}"/submit_queues
echo 2 > "${dev}"/queue_mode
echo 2 > "${dev}"/irqmode
echo "${size}" > "${dev}"/size
echo 1 > "${dev}"/zoned
echo 0 > "${dev}"/zone_nr_conv
echo 128 > "${dev}"/zone_size
echo 96 > "${dev}"/zone_capacity
echo 14 > "${dev}"/zone_max_active
echo 1 > "${dev}"/memory_backed
echo 1000000 > "${dev}"/completion_nsec
echo 1 > "${dev}"/power
mkfs.btrfs -m single /dev/nullb1
mount /dev/nullb1 /mnt/test/
~/xfstests-dev/ltp/fsx /mnt/test/foobar

fsx will eventually after ~10 minutes fail with the following left
in dmesg:

[ 1185.480200] BTRFS error (device nullb1): error writing primary super block to device 1
[ 1185.480988] BTRFS: error (device nullb1) in write_all_supers:4488: errno=-5 IO failure (1 errors while writing supers)
[ 1185.481971] BTRFS info (device nullb1: state E): forced readonly
[ 1185.482521] BTRFS: error (device nullb1: state EA) in btrfs_sync_log:3341: errno=-5 IO failure

I tracked this down to the find_get_page call in wait_dev_supers
returning NULL, and digging furter it seems to come from
xa_is_value() in __filemap_get_folio returnin true.  I'm not sure
why we'd see a value here in the block device mapping and why that
only happens in zoned mode (the same config on regular device ran
for 10 hours last night).

