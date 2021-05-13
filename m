Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB0D37F94B
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 May 2021 16:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbhEMOC6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 10:02:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:43824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234170AbhEMOCz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 10:02:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620914502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1+YNp7qsM0h1DpDs/2LeI7ondYoan4e1g4S0oCGf75c=;
        b=U45iDp1zFHJ5aLI6OXymNs56Usph5fQ6iOKMTDMb0/ngLtPW2QYx/Vcd2WpDGu3ptD10v6
        0HvIutJJJn/EeOdd4n77MWNNBntddVC6k7rTABVGqTMRuYnefRjzRG1PS9VHTjqOHQHsCj
        8cyP+MTaam3ib9Z65s9Oh5kZcPZiMPM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6835AB153
        for <linux-btrfs@vger.kernel.org>; Thu, 13 May 2021 14:01:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 21BB9DA8EB; Thu, 13 May 2021 15:59:12 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.12.1
Date:   Thu, 13 May 2021 15:59:11 +0200
Message-Id: <20210513135912.7330-1-dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.12.1 have been released. This is a bugfix release.

This fixes namely missing symbols in libbtrfs that break snapper, sorry.

Changelog:

  * build: fix missing symbols in libbtrfs
  * mkfs: check for minimal number of zones
  * check: fix warning about cache generation when free space tree is enabled
  * fix superblock write in zoned mode on 16K pages

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

David Sterba (6):
      btrfs-progs: fix libbtrfs build, missing symbols
      btrfs-progs: build: remove duplicate library from libbtrfs-test
      btrfs-progs: ci: list hosted CI requirements
      btrfs-progs: build: note minimal version for zoned support
      btrfs-progs: update CHANGES for 5.12.1
      Btrfs progs v5.12.1

Johannes Thumshirn (1):
      btrfs-progs: mkfs: check for minimal needed number of zones

Su Yue (2):
      btrfs-progs: do not BUG_ON if btrfs_add_to_fsid succeeded to write superblock
      btrfs-progs: check: continue to check space cache if sb cache_generation is 0
