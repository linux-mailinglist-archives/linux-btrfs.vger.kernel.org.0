Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D872C2BCA
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Nov 2020 16:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389688AbgKXPtf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Nov 2020 10:49:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:57978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728429AbgKXPtf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Nov 2020 10:49:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606232974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4K54ldkBzF6KzrANipT6Blqlt8gE/wsb6Gcph6X03Zk=;
        b=TMoAT3pk3zOY8oSHJVF1Cl7yqZYOL18hzRQPtUygvLHCvv/DeaOQT+ocC5e3VwE+1/Ikmf
        jkLLkgNJdEDEieF50Vp6IZN+3ixSVsuJrI4NTwdJ9Du+3ICoiEB6iZn2e3N6CprBm8EjJR
        9ATzrieXOu5i62vIy7iwBkT21kw6BQo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7C61DAC2D;
        Tue, 24 Nov 2020 15:49:34 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/3] Simplify error handling in 3 functions
Date:   Tue, 24 Nov 2020 17:49:29 +0200
Message-Id: <20201124154932.3180539-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here are 3 very similar patches which switch some functions from using 2
variables to implement their error handling to using simply 1 as the standard in
the codebase dictates.

Nikolay Borisov (3):
  btrfs: Remove err variable from btrfs_delete_subvolume
  btrfs: Eliminate err variable from merge_reloc_root
  btrfs: Remove err variable from do_relocation

 fs/btrfs/inode.c      | 21 ++++++----------
 fs/btrfs/relocation.c | 57 +++++++++++++++----------------------------
 2 files changed, 26 insertions(+), 52 deletions(-)

--
2.25.1

