Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CADFC3F05
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 19:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfJARwP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 13:52:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:60182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725844AbfJARwP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Oct 2019 13:52:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E372FB1B6;
        Tue,  1 Oct 2019 17:52:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7EC0BDA88C; Tue,  1 Oct 2019 19:52:31 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Bit helpers cleanup
Date:   Tue,  1 Oct 2019 19:52:31 +0200
Message-Id: <cover.1569951996.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Depends on patch "btrfs: fix balance convert to single on 32-bit host
CPUs" that's now in misc-next and cleans up the helpers as discussed at

https://lore.kernel.org/linux-btrfs/20190912235507.3DE794232AF@james.kirk.hungrycats.org/

David Sterba (2):
  btrfs: add 64bit safe helper for power of two checks
  btrfs: use has_single_bit_set for clarity

 fs/btrfs/misc.h         | 11 +++++++++++
 fs/btrfs/tree-checker.c | 14 +++++++-------
 fs/btrfs/volumes.c      |  7 +------
 3 files changed, 19 insertions(+), 13 deletions(-)

-- 
2.23.0

