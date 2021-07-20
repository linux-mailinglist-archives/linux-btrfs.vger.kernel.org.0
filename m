Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3C23CFDF1
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 17:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbhGTO65 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 10:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239618AbhGTOXI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 10:23:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49F0D610CC
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jul 2021 15:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626793425;
        bh=MV/Kzdl/czfp+nkaR4H/VqqfyCKDCEeYHVkTbXwAmmc=;
        h=From:To:Subject:Date:From;
        b=kspwf8+BzH93pOJCxBYxtvr9f6zstLobYqRH5Ge6G/6Nzv9GSH+t1Ko3p+CnzDEKb
         Z6RZ3cc/VbfinQyjXrYtqqnfL9tr93DcfVTe+e5V7MZKJxRFtLk1CHU+Zof7s9rnRN
         aOk9/G8PN5EyGJaTwbjYACgUR9XSbLgg1yzn9psxcYnk7ChZ9+bfc5iOS2m++D7D/e
         JNrshr88qRuiHccKl8pQF0aay4VzrVyczIiOwQxyJn2JCMi9F9fL7SoduCVZku3mdf
         GSc47ioGpe6R/lnVCRywt+rJAjCQHNr1FKu6bC99p157exnWZPRRfaXE7l24NS3gQc
         LQQfOMp/LIIkA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: a few fsync related minor improvements and a cleanup
Date:   Tue, 20 Jul 2021 16:03:39 +0100
Message-Id: <cover.1626791500.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The following patches remove some unnecessary code and bring a couple minor
performance improvements in the fsync path. They are independent of each other,
but are grouped in the same pathset just because they relate around the same
code. The last patch has some performance results in its changelog.

Filipe Manana (4):
  btrfs: remove racy and unnecessary inode transaction update when using
    no-holes
  btrfs: avoid unnecessary log mutex contention when syncing log
  btrfs: remove unnecessary list head initialization when syncing log
  btrfs: avoid unnecessary lock and leaf splits when updating inode in
    the log

 fs/btrfs/inode.c    | 12 ++++------
 fs/btrfs/tree-log.c | 56 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 50 insertions(+), 18 deletions(-)

-- 
2.30.2

