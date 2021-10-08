Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C43426D34
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Oct 2021 17:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242650AbhJHPFW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Oct 2021 11:05:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36912 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242905AbhJHPFU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Oct 2021 11:05:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7FAA32013C
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Oct 2021 15:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633705404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Bz3Ija1Hi2xctoY8kxqkT2DIIpqimHZls81LKa7hZbY=;
        b=X6n14BPR0RG23M/vp7xH34AG276a80rlVKp73MCKRkEsaI8VhjlnIYiYi4E5gq13LLwfSi
        d8RwDUtHfSe3BKp1vmwvzQ665BpjuJyOgbVY/JhfUIZN680tT0rm6OjOvuw6xRXD0AkR8t
        YgnvY3eMgDx/wGiRjPs75P1saNXjm9c=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 78327A3B81
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Oct 2021 15:03:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A9AF0DA799; Fri,  8 Oct 2021 17:03:02 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.14.2
Date:   Fri,  8 Oct 2021 17:03:02 +0200
Message-Id: <20211008150302.18203-1-dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.14.2 have been released. This is a bugfix release.

Notable thing is the new libudev dependency that's on by default as I believe
most systems have udev available. The reason is to support multipath devices.
If you don't want the dependency, do ./configure --disable-libudev .
The rest are fixes or houskeeping changes.

Changelog:

* fixes
  * zoned mode
    * properly detect non-zoned devices in emulation mode
    * properly create quota tree
    * raid1c3/4 also excluded from unsupported profiles
  * use sysfs-based detection of device discard capability, fix mkfs-time trim
    for non-standard devices
  * mkfs: fix creation of populated filesystem with free space tree
  * detect multipath devices (needs libudev)
* replace start: add option -K/--nodiscard, similar to what mkfs or device add has
* dump-tree: print complete root_item
* mkfs: add option --verbose
* sb-mod: better help, no checksum calculation on read-only actions
* subvol show:
  * print more information (regarding send and receive)
  * print warning if read-write subvolume has received_uuid set
* property set:
  * add parameter -f to force changes
  * changing ro->rw switch now needs -f if subvolume has received_uuid set,
    (see documentation)
* build
  * optional libudev (on by default)
* other
  * remove deprecated support for CREATE_ASYNC bit for subvolume ioctl
  * CI updates
  * new and updated tests

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

Anand Jain (1):
      btrfs-progs: fix comments in cmd_filesystem_show

David Sterba (25):
      btrfs-progs: tests: fix fsck/024 to work with free-space-tree
      btrfs-progs: do sysfs detection of device discard capability
      btrfs-progs: replace start: add option -K/--nodiscard
      btrfs-progs: mkfs: add option -v/--verbose
      btrfs-progs: mkfs: switch to global verbosity options
      btrfs-progs: sb-mod: don't fixup checksum for read-only ops
      btrfs-progs: sb-mod: improve help
      btrfs-progs: device scan: rename is_path_device
      btrfs-progs: build: make libudev selectable
      btrfs-progs: build: capitalize variable names in the summary
      btrfs-progs: ci: disable libudev for musl build
      btrfs-progs: ci: update base images with libudev-devel
      btrfs-progs: ci: add openSUSE Leap 15.3 image
      btrfs-progs: ci: add missing docker scripts for musl image
      btrfs-progs: gitignore: update paths in Documentation
      btrfs-progs: subvol show: print send and receive generation and timestamp
      btrfs-progs: dump-tree: print complete root_item
      btrfs-progs: zoned: also exclude raid1c3 and raid1c4 from supported profiles
      btrfs-progs: tests: make misc/038 work with free-space-tree
      btrfs-progs: prop set: add force parameter
      btrfs-progs: prop set: ro->rw and received_uuid
      btrfs-progs: tests: subvolume ro->rw switch and received_uuid
      btrfs-progs: docs: subvolume ro->rw and incremental send
      btrfs-progs: subvol show: print a warning with rw and receive_uuid
      btrfs-progs: update CHANGES for 5.14.2

Johannes Thumshirn (1):
      btrfs-progs: remove max_zone_append_size logic

Josef Bacik (1):
      btrfs-progs: remove data extents from the free space tree

Naohiro Aota (2):
      btrfs-progs: do not zone reset on emulated zoned mode
      btrfs-progs: properly format btrfs_header in btrfs_create_root()

Nikolay Borisov (4):
      btrfs-progs: remove support for BTRFS_SUBVOL_CREATE_ASYNC
      btrfs-progs: build: add optional dependency on libudev
      btrfs-progs: ignore devices representing paths in multipath
      btrfs-progs: add fallback code for multipath device detection for static build

Qu Wenruo (1):
      btrfs-progs: check: fix indentation of --clear-ino-cache option

