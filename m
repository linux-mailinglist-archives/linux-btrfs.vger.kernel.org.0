Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 406354BAAF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 16:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfFSOEo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 10:04:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:42864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbfFSOEn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 10:04:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 66241AC0C
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 14:04:42 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/4] Spring cleaning
Date:   Wed, 19 Jun 2019 17:04:36 +0300
Message-Id: <20190619140440.5550-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just a couple of patches that remove unneeded code. The first one does away 
with an always true if construct and the rest remove code which has been #if 0
for quite some time.

Nikolay Borisov (4):
  btrfs-progs: Remove redundant if
  btrfs-progs: Remove commented code
  btrfs: Remove old send implementation
  btrfs-progs: check: Remove duplicated and commented functions

 check/main.c  |  69 -------------
 cmds-send.c   |  61 ------------
 extent-tree.c | 270 +-------------------------------------------------
 3 files changed, 5 insertions(+), 395 deletions(-)

-- 
2.17.1

