Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF291619E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 19:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgBQSnr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 13:43:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:33478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbgBQSnq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 13:43:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1065CAAC6;
        Mon, 17 Feb 2020 18:43:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8EF44DA7A0; Mon, 17 Feb 2020 19:43:28 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 5.6-rc2
Date:   Mon, 17 Feb 2020 19:43:26 +0100
Message-Id: <cover.1581962653.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

this is fix for sleeping in a locked section bug reported by Dave Jones,
caused by a patch dependence in development and pulled branches. I
picked the existing patch over the fixup that Filipe sent, as it's a
bit more generic fix. I've verified it with a specific test case, some rsync
stress and one round of fstests. Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 1b9867eb6120db85f8dca8ff42789d9ec9ee16a5:

  btrfs: sysfs, move device id directories to UUID/devinfo (2020-02-12 18:28:22 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.6-rc1-tag

for you to fetch changes up to 52e29e331070cd7d52a64cbf1b0958212a340e28:

  btrfs: don't set path->leave_spinning for truncate (2020-02-17 16:23:06 +0100)

----------------------------------------------------------------
Josef Bacik (1):
      btrfs: don't set path->leave_spinning for truncate

 fs/btrfs/inode.c | 2 --
 1 file changed, 2 deletions(-)
