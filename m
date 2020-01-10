Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A511136CC0
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 13:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgAJMLj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 07:11:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:35272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727868AbgAJMLi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 07:11:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 61293AE57;
        Fri, 10 Jan 2020 12:11:37 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/4] More split-brain fixes for metadata uuid feature
Date:   Fri, 10 Jan 2020 14:11:31 +0200
Message-Id: <20200110121135.7386-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here are 4 patches which fix a newly found split-brain scenario in the
METADATA_UUID_INCOMPAT code. They are mostly the identical with Su's
original submission but I have reworked the changelogs and some function
names. Hence, I retained his authorship of the patches.

First 2 patches factor out some code with the hopes of making find_fisd a bit
more readable and simplifying the myriad of nested 'if' in device_list_add.

Patch 3 extends find_fsid_changed to handle the case where a disk with
METADATA_UUID_INCOMPAT and FSID_CHANGING_IN_PROGRESS is scanned after a disk
which has successfully been switched to FSID == METADATA_UUID state and has
created btrfs_fs_devices.

Patch 4 handles the counterpart situation - a fully switched disk is scanned
after one which has had METADATA_UUID_INCOMPAT and FSID_CHANGING_IN_PROGRESS
set.

This series should be applied to stable branches following 5.0 when the
metadata_uuid feature got introduced.

This patchset was tested with btrfs-progs' misc 034-metadata-uuid test and a full
xfstest run with no regressions. I will also be sending an improvement to the
test case which exercises the newly added code.

  btrfs: Call find_fsid from find_fsid_inprogress
  btrfs: Factor out metadata_uuid code from find_fsid.
  btrfs: Handle another split brain scenario with metadata uuid feature
  btrfs: Fix split-brain handling when changing FSID to metadata uuid

 fs/btrfs/volumes.c | 158 ++++++++++++++++++++++++++++-----------------
 1 file changed, 100 insertions(+), 58 deletions(-)

--
2.17.1

