Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88A3A20177
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 10:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEPImx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 04:42:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:60162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfEPImx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 04:42:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 47B2EAEBC
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2019 08:42:52 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/3] Fix "filesystem" command when fs is on file image
Date:   Thu, 16 May 2019 11:42:47 +0300
Message-Id: <20190516084250.19363-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series fixes the following use case: 

truncate -s 3g btrfs.img
mkfs.btrfs btrfs.img
btrrfs fi show .img
ERROR: not a valid btrfs filesystem: /root/btrfs.img


As evident this currently produces an error due to libblkid not recognising the 
image file as a filesystem. This stems from the fact progs doesn't force the 
addition of the image file to libblkid's cache. This series rectifies this. 

Patch 1 extends btrfs_scan_devices to take an optional path argument which will 
be added to libblkid's cache. 

Patch 2 Makes 'btrfs filesystem' Utilizes this btrfs_scan_devices' new
interface if it detects we want to query a filesystem placed on an image file. 

Patch 3 Adds simple test case to ensure this works as expected and is not 
broken in the future. 

Nikolay Borisov (3):
  btrfs-progs: Make btrfs_scan_devices take a path
  btrfs-progs: Correctly identify fs on image files in "filesystem"
    subcommands
  btrfs-progs: tests: Test fs on image files is correctly recognised

 cmds-device.c                                   |  2 +-
 cmds-filesystem.c                               |  3 +--
 disk-io.c                                       |  2 +-
 tests/cli-tests/010-fi-show-on-new-file/test.sh | 16 ++++++++++++++++
 utils.c                                         | 18 +++++++++++++++---
 utils.h                                         |  2 +-
 6 files changed, 35 insertions(+), 8 deletions(-)
 create mode 100755 tests/cli-tests/010-fi-show-on-new-file/test.sh

-- 
2.7.4

