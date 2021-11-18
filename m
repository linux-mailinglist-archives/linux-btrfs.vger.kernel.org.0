Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B827C455839
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 10:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245249AbhKRJvC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 04:51:02 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53948 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245246AbhKRJu6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 04:50:58 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1949E212C1
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 09:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637228878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+ntObkqKlkZd+1iwgP2GUlkY/SCaGegRUos2orfznJs=;
        b=H0vNLizjfzTBonmAXieWI7uUqBz4goWbkb9iEnXryBTVmwo3vEwdYoxIoAG6mfGa02NoMZ
        eU2i+Dg4jAfT4Dcfzn/Sv2w80PxcfY1B5EcNmiEVHPDK/J/XrZMfrBhev0bLq3Q8jpDxA+
        DoIR8OK9jx4GdUV++Uo6GQTb1RCPZi4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 13973A3B84
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 09:47:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C201DDA781; Thu, 18 Nov 2021 10:47:53 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs pre-release 5.15.1-rc1
Date:   Thu, 18 Nov 2021 10:47:53 +0100
Message-Id: <20211118094753.18900-1-dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

this is a pre-release announcement of btrfs-progs, 5.15.1-rc1. There are fixes
and documentation updates.

The proper release is scheduled to this Friday, +1 day (2021-11-19).

There is no -rc1 tag and no tarball, the changes are in git branch v5.15.x in
the devel repositories.

Changelog:

* fixes:
  * fi usage: fix wrongly reported space of used or unallocated space
  * fix detection of block device discard capability
* check: add more sanity checks for checksum items
* build: make sphinx optional backend for documentation

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

