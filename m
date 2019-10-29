Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 074D8E8E14
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2019 18:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfJ2R2o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Oct 2019 13:28:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:38242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbfJ2R2o (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Oct 2019 13:28:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A7729B241;
        Tue, 29 Oct 2019 17:28:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1E643DA734; Tue, 29 Oct 2019 18:28:52 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Minor parameter cleanups
Date:   Tue, 29 Oct 2019 18:28:52 +0100
Message-Id: <cover.1572369984.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can remove write_flags parameter in case the function also has wbc
(and the value is equal).

David Sterba (2):
  btrfs: sink write_flags to __extent_writepage_io
  btrfs: sink write flags to cow_file_range_async

 fs/btrfs/extent_io.c | 8 +++-----
 fs/btrfs/inode.c     | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

-- 
2.23.0

