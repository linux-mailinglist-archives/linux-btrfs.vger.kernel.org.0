Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA3C42653B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Oct 2021 09:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhJHHcD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Oct 2021 03:32:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33530 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhJHHcD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Oct 2021 03:32:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2ADB41FD35
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Oct 2021 07:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633678207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=VIMzQvzoCsaitva82AiiKj+vgrR6UcS+UxSa/K6kUU8=;
        b=EnC86r7+iflW1wh1E9GhLDJJrfQ/d5udjzjqlkFiPPbYKSmeyu8dGFMmDHftlDwI1s+XOR
        y/yd4RKOBs6tM9DrM/T4ODhwLX7rb81+A9t6BcPzVysV5yfhtBKCI4ZbuXIkBBAeW3MHJG
        4xXyZzzPq1p6ZhYh71aRSQHeykfoq2Y=
Received: from adam-pc.lan (wqu.tcp.ovpn2.nue.suse.de [10.163.34.62])
        by relay2.suse.de (Postfix) with ESMTP id 2AFA2A3B85
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Oct 2021 07:30:05 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: remove btrfs_bio::logical member
Date:   Fri,  8 Oct 2021 15:29:58 +0800
Message-Id: <20211008073000.62391-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although we have two call sites setting btrfs_bio::logical, but only one
call site it really reading btrfs_bio::logical.

Furthermore, that only reader can grab the same info from
btrfs_dio_private without any hassle.

Thus it means btrfs_bio::logical duplicated and can be removed.

This in fact proves my initial suspicion, that btrfs_bio::logical is
duplicated, and the logical bytenr can be fetched using
bio->bi_iter.bi_sector.

This saves 8 bytes from btrfs_bio, without any complicated refactor.

Qu Wenruo (2):
  btrfs: rename btrfs_dio_private::logical_offset to file_offset
  btrfs: remove btrfs_bio::logical member

 fs/btrfs/btrfs_inode.h |  7 ++++++-
 fs/btrfs/extent_io.c   |  1 -
 fs/btrfs/inode.c       | 29 ++++++++++++++---------------
 fs/btrfs/volumes.h     |  1 -
 4 files changed, 20 insertions(+), 18 deletions(-)

-- 
2.33.0

