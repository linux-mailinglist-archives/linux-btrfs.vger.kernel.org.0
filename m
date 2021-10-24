Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623154389F5
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Oct 2021 17:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhJXPmB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Oct 2021 11:42:01 -0400
Received: from michael.mail.tiscali.it ([213.205.33.246]:57658 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229782AbhJXPl7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Oct 2021 11:41:59 -0400
Received: from venice.bhome ([78.14.151.87])
        by michael.mail.tiscali.it with 
        id 9rXM2600l1tPKGW01rXMhF; Sun, 24 Oct 2021 15:31:22 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 0/2][V8] btrfs-progs: allocation_hint disk property
Date:   Sun, 24 Oct 2021 17:31:18 +0200
Message-Id: <cover.1635089206.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.33.0
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1635089482; bh=LHDVT/WMJalScjr688fju4Scx1EHJUL2IFalyimyK9o=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=6UGeY78bfsLzb3seIhmvL1FzfU7Yyhhg09Il5XDjI/+f3xhfLVo0SLIb3Gqa6vYFU
         YtBaCQXK9WhljCOtM7cipzHexwgseiVLsSK3BHIX5Di55yOYzmCzzcUq8HznTjntSk
         RAvx+EidTw/MCCeRjZ0EhhC485sj0mUw/DvnPE+w=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

This patches set is the userspace portion of the serie
"[PATCH V8] btrfs: allocation_hint mode".

Look this patches set for further information.

G.Baroncelli

Goffredo Baroncelli (2):
  btrfs-progs: new "allocation_hint" property.
  Update man page for allocator_hint property.

 Documentation/btrfs-property.asciidoc |  17 +++
 cmds/property.c                       | 199 ++++++++++++++++++++++++++
 kernel-shared/ctree.h                 |  14 ++
 3 files changed, 230 insertions(+)

-- 
2.33.0

