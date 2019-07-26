Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC3D76E5D
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 17:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfGZP6M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 11:58:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:43868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbfGZP6M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 11:58:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4C812AEC7
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2019 15:58:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BCACEDA811; Fri, 26 Jul 2019 17:58:47 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.2.1
Date:   Fri, 26 Jul 2019 17:58:47 +0200
Message-Id: <20190726155847.12970-1-dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.2.1 have been released. This is a bugfix release.

Changes:
  * scrub status: fix ETA calculation after resume
  * check: fix crash when using -Q
  * restore: fix symlink owner restoration
  * mkfs: fix regression with mixed block groups
  * core: fix commit to process all delayed refs
  * other:
    * minor cleanups
    * test updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

Adam Borowski (1):
      btrfs-progs: fix a printf format string fatal warning

David Sterba (7):
      btrfs-progs: props: update descriptions
      btrfs-progs: props: convert to C99 initializers
      btrfs-progs: props: update help texts
      btrfs-progs: tests: switch messages to _log
      btrfs-progs: restore: fix chown of a symlink
      btrfs-progs: update CHANGES for v5.2.1
      Btrfs progs v5.2.1

Filipe Manana (1):
      Btrfs-progs: mkfs, fix metadata corruption when using mixed mode

Grzegorz Kowal (2):
      btrfs-progs: scrub: fix ETA calculation
      btrfs-progs: scrub: fix status lines alignment

Josef Bacik (1):
      btrfs-progs: deal with drop_progress properly in fsck

Naohiro Aota (1):
      btrfs-progs: check: initialize qgroup_item_count in earlier stage

Omar Sandoval (1):
      btrfs-progs: receive: get rid of unnecessary strdup()

Qu Wenruo (3):
      btrfs-progs: Exhaust delayed refs and dirty block groups to prevent delayed refs lost
      btrfs-progs: extent-tree: Unify the parameters of btrfs_inc_extent_ref()
      btrfs-progs: tests: Avoid debug log populating stdout
