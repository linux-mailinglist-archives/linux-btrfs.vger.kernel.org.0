Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AAF2524D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 02:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHZArj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 20:47:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:45232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbgHZArj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 20:47:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A213B004
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 00:48:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: small compile warning fixes
Date:   Wed, 26 Aug 2020 08:47:32 +0800
Message-Id: <20200826004734.89905-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although the global parameter fs_info would affect all repair tests...

Qu Wenruo (2):
  btrfs-progs: fix compile warning due to global fs_info cleanup
  btrfs-progs: remove the unused variable in
    check_chunks_and_extents_lowmem()

 check/mode-lowmem.c         | 15 ++++++---------
 kernel-shared/ctree.h       |  3 +--
 kernel-shared/extent-tree.c |  2 +-
 3 files changed, 8 insertions(+), 12 deletions(-)

-- 
2.28.0

