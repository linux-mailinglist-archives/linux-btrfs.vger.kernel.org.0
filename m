Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95560459635
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 21:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhKVUnx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 15:43:53 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48900 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhKVUnx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 15:43:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6C622218E0
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 20:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637613645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WZ3QI10GbxMviu6lFUXuot6VqlhIK2LnQZvPlOo4ko4=;
        b=MvBpkJnH1T2Y7cOWrJc0ZICJKgGlzopg32f+2GqKIterwrNlFFtCX/uBb/tDB49ljsJ5jD
        ULJLrOpTibwj/3eRO/FWWw5+MLOGoqgakkO/Alhyoa9hBxIQwTGYIIZKgR/SgTIxLSW0sd
        FwTLDb8nrtstq0a5ymAcdbgZH9W3BPU=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 66C1DA3B81
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 20:40:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 77516DA735; Mon, 22 Nov 2021 21:40:38 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.15.1
Date:   Mon, 22 Nov 2021 21:40:38 +0100
Message-Id: <20211122204038.11466-1-dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.15.1 have been released. This is a bugfix release.

Changelog:

* fixes:
  * fi usage: fix wrongly reported space of used or unallocated space
  * fix detection of block device discard capability
* check: add more sanity checks for checksum items
* build: make sphinx optional backend for documentation

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

David Sterba (7):
      btrfs-progs: docs: add Glossary from wiki
      btrfs-progs: docs: RST formatting fixups
      btrfs-progs: docs: fix RST mkfs.btrfs table formatting
      btrfs-progs: docs: disable RST smartquotes for em-dash
      btrfs-progs: docs: integrate sphinx build
      btrfs-progs: docs: mention ntfs2btrfs conversion tool
      btrfs-progs: update CHANGES for 5.15.1

Mark Harmstone (1):
      btrfs-progs: check: add check for too many csum entries

Nikolay Borisov (2):
      btrfs-progs: fi usage: don't reset ratio to 1 if we don't have RAID56 profile
      btrfs-progs: fi usage: fix calculation of chunk size for RAID1/DUP profiles

Qu Wenruo (1):
      btrfs-progs: raid56: fix the wrong recovery condition for data and P case

Wang Yugui (1):
      btrfs-progs: fix discard support check
