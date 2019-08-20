Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABA09660E
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2019 18:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfHTQQ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 12:16:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:57520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbfHTQQ5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 12:16:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B0A24AD2B
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2019 16:16:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 12A96DA7DA; Tue, 20 Aug 2019 18:17:22 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 0/2] Compression level API cleanups
Date:   Tue, 20 Aug 2019 18:17:22 +0200
Message-Id: <cover.1566313756.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Remove the callback indirection.

v2:
* switch to unsigned int and use min()

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

