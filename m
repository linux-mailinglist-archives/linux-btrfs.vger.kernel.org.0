Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D363D7318
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbhG0KYx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:24:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236280AbhG0KYr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:24:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74949619BB
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 10:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627381487;
        bh=1+g4QRp3uzQNzhHnAW5PaxoRp1WyYKxz6xFMrAJNalo=;
        h=From:To:Subject:Date:From;
        b=u3oa5asBkkjm63dEjwNYR6lx0DQTuDdozOSdaVkHSPVqrGxvTNNAI58xAco12+/VA
         fhgF7JYYqbnPF6+mgeJhlAAexlxqR8Sp0bQ1mL3Wh/bnJBNF/39XOqEwKerieclSwn
         XmF1k+KOlVJ+HGHOqAxG18SQDtYEvr9ly7xGG5phn7b7//YdT2TwXbnetduoUE1lFC
         ay3KhcH7Mxesu7bvfr8IEaSWpCFHd+X9pUYbyMX9ojsdItJFZ5zkUYP/g+GfL0NVNb
         aLebErzsKLiTd8kQIDY4jxXjOqnpTNTPN6fD1veqVhZUMSEQNhxQZGKTcfAL/IvTOJ
         GoJnDVIRtwvPA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: fsync changes, a bug fix and a couple improvements
Date:   Tue, 27 Jul 2021 11:24:42 +0100
Message-Id: <cover.1627379796.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The first patch in the series fixes a bug where a directory fsync, following
by inode eviction, followed by renaming a file and syncing the log results
in losing a file if a power failure happens and the log is replayed.

The remaining two changes are independent, and are about avoiding unnecessary
work during operations that need to check or modify the log (renames, adding
a hard link, unlinks) and making renames hold log commits for a shorter
period.

Filipe Manana (3):
  btrfs: fix lost inode on log replay after mix of fsync, rename and inode eviction
  btrfs: eliminate some false positives when checking if inode was logged
  btrfs: do not pin logs too early during renames

 fs/btrfs/inode.c    | 48 +++++++++++++++++++++++++++++++++++++++------
 fs/btrfs/tree-log.c | 29 ++++++++++++++++-----------
 2 files changed, 60 insertions(+), 17 deletions(-)

-- 
2.28.0

