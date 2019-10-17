Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFDDBDA3E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 04:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfJQCin (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 22:38:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:59848 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727233AbfJQCim (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 22:38:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DDBFBB1EE
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Oct 2019 02:38:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: qgroup: Bug fixes for trace events
Date:   Thu, 17 Oct 2019 10:38:35 +0800
Message-Id: <20191017023837.32264-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Several stupid bugs exposed for qgroup related trace events.
Fix them.

Changelog:
v2:
- Split patches

Qu Wenruo (2):
  btrfs: qgroup: Fix wrong parameter order for trace events
  btrfs: qgroup: Fix bad entry members of qgroup trace events

 fs/btrfs/qgroup.c            | 4 ++--
 include/trace/events/btrfs.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.23.0

