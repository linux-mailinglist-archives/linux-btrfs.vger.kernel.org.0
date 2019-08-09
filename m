Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C1B87D40
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2019 16:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfHIOyb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Aug 2019 10:54:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:39720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbfHIOyb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Aug 2019 10:54:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 079CBAD7C
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2019 14:54:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E348FDA7C5; Fri,  9 Aug 2019 16:55:00 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Compression level API cleanups
Date:   Fri,  9 Aug 2019 16:55:00 +0200
Message-Id: <cover.1565362438.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Remove the callback indirection.

David Sterba (2):
  btrfs: define compression levels statically
  btrfs: compression: replace set_level callbacks by a common helper

 fs/btrfs/compression.c | 20 ++++++++++++++++++--
 fs/btrfs/compression.h | 11 +++++------
 fs/btrfs/lzo.c         |  8 ++------
 fs/btrfs/zlib.c        | 11 ++---------
 fs/btrfs/zstd.c        | 11 ++---------
 5 files changed, 29 insertions(+), 32 deletions(-)

-- 
2.22.0

