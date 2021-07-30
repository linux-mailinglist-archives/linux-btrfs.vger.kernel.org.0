Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9733DBA4B
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jul 2021 16:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbhG3OVi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jul 2021 10:21:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49458 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239266AbhG3OVa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jul 2021 10:21:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0DFDA22010
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 14:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627654884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fiUFu/k10utv0qGlJrcc6DNmudEJEKJ4ILjmiLOvHVQ=;
        b=Mh1G1fFTpbQAYaTytKTjsGlD4o3W/5xCzbVI3XMDjXjJKfHv1bagvWIExMwHUkU6/aPhJO
        Mtk9gmVsNwAx4tOjo/8eZyqBsIE4yJ4qC25hbMarEUJ7n51YrubToGL+MX6KqUjRg4tb//
        ElEWi0AJYgiKjhtE2Gu7/LX60o248v0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 05ED7A3B8B
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 14:21:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DF0AADB284; Fri, 30 Jul 2021 16:18:37 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.13.1
Date:   Fri, 30 Jul 2021 16:18:37 +0200
Message-Id: <20210730141837.30571-1-dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.12.1 have been released. This is a bugfix release.

Changelog:

* build: fix build on musl libc due to missing definition of NAME_MAX
* check:
  * batch more work into one transaction when clearing v1 free space inodes
  * detect directoris with wrong number of links
* libbtrfsutil: fix race between subvolume iterator and deletion
* mkfs: be more specific about supported profiles for zoned device
* other:
  * documentation updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

David Sterba (5):
      btrfs-progs: add nparity for raid1c34 definitions
      btrfs-progs: ci: add script to do build test on musl
      btrfs-progs: mkfs: update message when creating zoned fs with non-single profiles
      btrfs-progs: update CHANGES for 5.13.1
      Btrfs progs v5.13.1

Omar Sandoval (1):
      libbtrfsutil: fix race between subvolume iterator and deletion

Qu Wenruo (4):
      btrfs-progs: docs: fix the out-of-date comment about free space tree support
      btrfs-progs: check: batch v1 space cache inodes when clearing
      btrfs-progs: check/original: detect directory inode with nlinks >= 2
      btrfs-progs: tests: check nlinks for directories

Sidong Yang (1):
      btrfs-progs: cmds: fix build on musl when using NAME_MAX

er888kh (1):
      libbtrfsutil: fix typo in README example

