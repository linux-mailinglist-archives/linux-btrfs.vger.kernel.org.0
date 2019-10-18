Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43ED3DC3C1
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2019 13:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442539AbfJRLQN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 07:16:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:38898 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2442532AbfJRLQM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 07:16:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C5FEB36D;
        Fri, 18 Oct 2019 11:16:11 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, quwenruo.btrfs@gmx.com,
        anand.jain@oracle.com, rbrown@suse.de,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 2/2] btrfs-progs: docs: fix warning test
Date:   Fri, 18 Oct 2019 13:16:04 +0200
Message-Id: <20191018111604.16463-2-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191018111604.16463-1-jthumshirn@suse.de>
References: <20191018111604.16463-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The warning about the dangers of repair was lacking a bit grammatically odd.

Fix it to read more naturally.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 Documentation/btrfs-check.asciidoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/btrfs-check.asciidoc b/Documentation/btrfs-check.asciidoc
index b963eae5cdce..1a4d8167ccba 100644
--- a/Documentation/btrfs-check.asciidoc
+++ b/Documentation/btrfs-check.asciidoc
@@ -23,8 +23,8 @@ by the option '--readonly'.
 *btrfsck* is an alias of *btrfs check* command and is now deprecated.
 
 WARNING: Do not use '--repair' unless you are advised to do so by a developer
-or an experienced user, and then only after having accepted that no 'fsck'
-successfully repair all types of filesystem corruption. Eg. some other software
+or an experienced user, and then only after having accepted that no 'fsck' can
+successfully repair all types of filesystem corruption. Eg. some software
 or hardware bugs can fatally damage a volume.
 
 The structural integrity check verifies if internal filesystem objects or
-- 
2.16.4

