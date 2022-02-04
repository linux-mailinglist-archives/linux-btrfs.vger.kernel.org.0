Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26754A9D86
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 18:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376831AbiBDRQj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 12:16:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38484 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbiBDRQi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 12:16:38 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9C395210F6
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 17:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643994997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=JZ0x7IMb27yXaf9BspdmUAWqblRPfDicL2Z+sM8iikI=;
        b=KK21sG9pKBV2fCxHZHdpXLWA+AmH4PiZ1qILHew8htaAaROyTPBHpKGLuxwUig9Bs7Y4Y1
        IbYPMtuHFX+ZzAiz+QTxh5pyael20N+BahowQdL14XL53J00TPgXb1Bwq+E4FBrkDmzgxN
        jK+Nk3EOGgk5aZ5ZQuYCopsYdL68VFU=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 95AEFA3B81
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 17:16:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EE6FEDA781; Fri,  4 Feb 2022 18:15:51 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.16.1
Date:   Fri,  4 Feb 2022 18:15:51 +0100
Message-Id: <20220204171551.25122-1-dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.16.1 have been released. This is a bugfix release.

Changelog:

* mkfs: support DUP on metadata on zoned devices
* subvol delete: drop warning for root when search ioctl fails
* check:
  * fix --init-csum-tree to not create checksums for extents that are not
    supposed to have them
  * add check for metadata item levels
* add udev rule for zoned devices as they require mq-deadline
* build: fix redefinition of ALIGN on mixed old/new kernel/userspace (5.11)
* other:
  * typo fixes
  * new tests
  * CI targets updated

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

Adam Borowski (2):
      btrfs-progs: fix a bunch of typos
      btrfs-progs: subvol delete: hide a warning on an unprivileged delete

David Sterba (7):
      btrfs-progs: kerncompat: add local definition for alignment macros
      btrfs-progs: ci: add run scripts for more targets
      btrfs-progs: ci: add Leap 15.4 for testing
      btrfs-progs: ci: add helpers to update base images
      btrfs-progs: subvol delete: more fine grained check when looking for default subvol
      btrfs-progs: update CHANGES for 5.16.1
      Btrfs progs v5.16.1

Johannes Thumshirn (3):
      btrfs-progs: add udev rule to use mq-deadline on zoned btrfs
      btrfs-progs: use profile_supported in mkfs as well
      btrfs-progs: zoned support DUP on metadata block groups

Qu Wenruo (8):
      btrfs-progs: backref: properly queue indirect refs
      btrfs-progs: check: move csum tree population into mode-common.[ch]
      btrfs-progs: check: don't calculate csum for preallocated file extents
      btrfs-progs: check: handle csum generation properly for --init-csum-tree --init-extent-tree
      btrfs-progs: tests: add test case for init-csum-tree
      btrfs-progs: check: lowmem: fix crash when METADATA_ITEM has invalid level
      btrfs-progs: check: orig: reject bad metadata backref with invalid level
      btrfs-progs: tests/fsck: add test image with invalid metadata backref level

Su Yue (1):
      btrfs-progs: make generic_err print physical address of extent buffer
