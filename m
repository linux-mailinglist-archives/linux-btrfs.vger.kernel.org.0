Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96F53FC9BB
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 16:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbhHaObj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 10:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235064AbhHaObi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 10:31:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C3DD60FD8
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 14:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630420243;
        bh=a3D6GlEdrC3Mo06W2WWTYvMW2m3GtsmOHtkhQUOJxQ0=;
        h=From:To:Subject:Date:From;
        b=eoEs9bd4FvKeaTi9K+i0DDDZKpU35CVxThk6+l0myxKPvOH56/szaNQ/v0mJkLNY9
         iM1R4cqqkeyAJojTmT3w9nq8PnKd5uM9Sccsd/i1HsFcltrTlHkuU3GkOXYACqUv+Q
         uk26Q3mhz2b1McY7515z+tiwlxtHYjmXMK48MZxK/Po9rngA4cgQbCramc6nhIzlmN
         uGjrfbeGECqc2jO7P8D7/GRpGRehCzy/MY7ONLKcbKhLBccPxUuaRXKOHLfd0NJtdS
         Xi+gSy/CHGr2QVb5DqQ3AR948wP7IbqvCbhuz3nem95kRJuOiPbu2B4cYGP28jMjri
         S5nJSB1rCseaw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/10] btrfs: set of small optimizations for inode logging
Date:   Tue, 31 Aug 2021 15:30:30 +0100
Message-Id: <cover.1630419897.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The following patchset adds a few optimizations for inode logging, along
with some necessary refactorings/cleanups to be able to implement them.
Test results are in the change log of the last patch.

Filipe Manana (10):
  btrfs: check if a log tree exists at inode_logged()
  btrfs: remove no longer needed checks for NULL log context
  btrfs: do not log new dentries when logging that a new name exists
  btrfs: always update the logged transaction when logging new names
  btrfs: avoid expensive search when dropping inode items from log
  btrfs: add helper to truncate inode items when logging inode
  btrfs: avoid expensive search when truncating inode items from the log
  btrfs: avoid search for logged i_size when logging inode if possible
  btrfs: avoid attempt to drop extents when logging inode for the first time
  btrfs: do not commit delayed inode when logging a file in full sync mode

 fs/btrfs/tree-log.c | 208 +++++++++++++++++++++++---------------------
 1 file changed, 110 insertions(+), 98 deletions(-)

-- 
2.28.0

