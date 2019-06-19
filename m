Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4236B4B388
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 10:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbfFSIDT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 04:03:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:45602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730418AbfFSIDT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 04:03:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29E8EAF55;
        Wed, 19 Jun 2019 08:03:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     dm-devel@redhat.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] dm log writes: Add support for filter bios based on its type
Date:   Wed, 19 Jun 2019 16:03:10 +0800
Message-Id: <20190619080312.11549-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Current dm-log-writes will record all bios, no matter if the bios is
METADATA (normally what we care) or is DATA (normally we cares less for
the log-replay context).

This causes a lot of extra space required for log device. E.g write 10M,
sync, overwrite that 10M file, this would cause over 20M for log device
just for the data.

This patchset introduces two way to specify the dump type:
- dump_type=%s optional option for constructor
  The default dump_type is ALL, thus no behavior change.

- dump_type=%s message type to change type on the fly

Also to cooperate the new dump_type= option, always output the dump_type
for STATUSTYPE_TABLE.

A common use case would be:
 # dmsetup create log --table 0 $(blockdev --getsz $dev) log-writes $dev $log_dev
 # mkfs.btrfs -f /dev/mapper/log
 # dmsetup suspend log
 # dmsetup message log 0 dump_type=METADATA|FUA|FLUSH|DISCARD|MARK
 # dmsetup resume log
 # mount /dev/mapper/log <mnt>
 # <do some work load>
 # umount <mnt>
 # dmsetup remove log
 # <replay>

Now the log device will not record data writes, thus hugely reduce the
space requirement for log device, allowing more operations to be down
before hitting the space limit.

Currently btrfs check doesn't check data checksum by default, thus even
we have wrong data on-disk, we should be fine checking the metadata.

I'm not 100% sure if this applies to other filesystems, but as long as
metadata writes is marked correctly, other filesystems can also benifit
from this feature.

Qu Wenruo (2):
  dm log writes: Allow dm-log-writes to filter bios based on types to
    reduce log device space usage
  dm log writes: Introduce dump_type= message type to change dump_type
    on the fly

 drivers/md/dm-log-writes.c | 177 ++++++++++++++++++++++++++++++++++---
 1 file changed, 167 insertions(+), 10 deletions(-)

-- 
2.22.0

