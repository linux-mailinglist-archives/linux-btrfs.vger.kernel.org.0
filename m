Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED413C70B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 14:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbhGMMuA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 08:50:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37830 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbhGMMuA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 08:50:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8CC3E2272E
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 12:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626180429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qKy76IRGb/1EVHxfaxEhO8D74LeW4JQkJsmLztoYpfU=;
        b=exEXk03/YGj8wqQjO0PO57bTiGUzvpWZVLAguNjgxcmgiyVZ2D0c0D6MbvQGCKLvzd7QyF
        Aq4SHDBlpxBp7jMZehhvCuuFoe7MRUDGvcyL+FdaOjosSo3oLkxNhgq6xdLAcTu6Ywhpz3
        /1EDbLpkVL8fuEoZe6+AghfJSgufUeA=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 86C71A3B90
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 12:47:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B5D0EDA790; Tue, 13 Jul 2021 14:44:32 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.13
Date:   Tue, 13 Jul 2021 14:44:32 +0200
Message-Id: <20210713124432.28354-1-dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.13 have been released.

Notable fixes:

* restore does not loop anymore for file extents or directory scan, requesting
  user interaction for such operation has proved to be wrong

* newer btrfs-progs on older kernels (e.g. 4.19) can fail the command
  'device scan' which in turn could prevent boot due to mismatch of zoned
  device support

There are some new chapters in manual page section 5 about general topics.
Please open an issue in case you find errors or would like to add some content
or references.

Changelog:

* restore: remove loop checks for extent count and directory scan
* inspect dump-tree: new options to print node (--csum-headers) and data
  checksums (--csum-items)
* fi usage:
  * print stripe count for striped profiles
  * print zoned information: size, total unusable
* mkfs: print note about sha256 accelerated module loading issue
* check: ability to reset dev_item::bytes_used
* fixes
  * detect zoned kernel support at run time too
  * exclusive op running check return value
* fi resize: support cancel (kernel 5.14)
* device remove: support cancel (kernel 5.14)
* documentation about general topics
  * compression
  * zoned mode
  * storage model
  * hardware considerations
* other
  * libbtrfsutil API overview
  * help text fixes and updates
  * hash speedtest measure time, cycles using perf and print throughput

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

Anand Jain (1):
      btrfs-progs: fix inspect-internal --help incomplete sentence

David Sterba (36):
      libbtrfsutil: add API summary
      btrfs-progs: device remove: add support for cancel
      btrfs-progs: fi resize: add support for cancel
      btrfs-progs: crypto: add time-based measurement to hash-speedtest
      btrfs-progs: crypto: print throughput in hash-speedtest
      btrfs-progs: crypto: fix printf warnings in hash-speedtest
      btrfs-progs: drop "2b" from blake2 in speed test
      btrfs-progs: crypto: add perf support to speed test
      btrfs-progs: zoned: make it work without kernel support
      btrfs-progs: print-tree: convert mode to bitmask
      btrfs-progs: dump-tree: add options to dump checksums
      btrfs-progs: switch %Lu to %llu format
      btrfs-progs: restore: convert to error message helpers
      btrfs-progs: restore: remove loop check during file copy
      btrfs-progs: restore: remove loop check during directory scan
      btrfs-progs: restore: group help options
      btrfs-progs: remove stale user transaction ioctl definitions
      btrfs-progs: docs: add section about compression
      btrfs-progs: docs: add more results for checksums
      btrfs-progs: docs: add section about zoned devices
      btrfs-progs: docs: update device related info
      btrfs-progs: docs: write section about storage model
      btrfs-progs: docs: add section about hardware considerations
      btrfs-progs: docs: note about loading accelerated sha256
      btrfs-progs: mkfs: print note about loading sha256 when used
      btrfs-progs: zoned: use fixed width type when reading zone size
      btrfs-progs: add helper for opening sysfs fsid directory
      btrfs-progs: add helper to read zone size from sysfs
      btrfs-progs: fi usage: print zone size in the overview
      btrfs-progs: fi usage: swap order of Used and zoned information
      btrfs-progs: docs: document zone device stats
      btrfs-progs: docs: more about hardware considerations
      btrfs-progs: docs: more hw considerations
      btrfs-progs: README: update links
      btrfs-progs: update CHANGES for 5.13
      Btrfs progs v5.13

Goldwyn Rodrigues (1):
      btrfs-progs: correct check_running_fs_exclop() return value

Hugo Mills (1):
      btrfs-progs: docs: minor fixes for spelling and idiom

Qu Wenruo (2):
      btrfs-progs: check: add the ability to reset btrfs_dev_item::bytes_used
      btrfs-progs: tests/fsck: add test case to make sure btrfs check can reset btrfs_dev_item::bytes_used

Sidong Yang (2):
      btrfs-progs: device usage: print number of stripes in relevant profiles
      btrfs-progs: zoned: fix memory leak in btrfs_sb_io()
