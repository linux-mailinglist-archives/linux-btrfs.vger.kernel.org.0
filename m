Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60837210EE2
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 17:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbgGAPQa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 11:16:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:51700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727887AbgGAPQa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 11:16:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C85CACBD;
        Wed,  1 Jul 2020 15:16:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6B4BFDA781; Wed,  1 Jul 2020 17:16:13 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Removal of deprecated mount options
Date:   Wed,  1 Jul 2020 17:16:13 +0200
Message-Id: <cover.1593616511.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Both options have no effect for a long time, no need to keep them
around.

David Sterba (2):
  btrfs: remove deprecated mount option alloc_start
  btrfs: remove deprecated mount option subvolrootid

 fs/btrfs/super.c | 12 ------------
 1 file changed, 12 deletions(-)

-- 
2.25.0

