Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7D241EDD8
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Oct 2021 14:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhJAMyU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Oct 2021 08:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhJAMyT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Oct 2021 08:54:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4723E61A58
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Oct 2021 12:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633092755;
        bh=Z0LpNqPRoTNyuOTLFoaN9ykOsI7rFnGQGZ8Jr35lnLc=;
        h=From:To:Subject:Date:From;
        b=UlEMjIvnlMTLcdTfs47jfIJaxvLylUbfhZn9cq0RssZnNuTbqWbhjdliEFdxayw9/
         Vq0nq4x992fRWrbwTAm5/XEu64WNCNw7njMtztEZVXXI1XybxjQOcGVjWoJr9yrrFV
         PdM+VQ+zzgkA2qnQjAwRU9ngK374KBEaP2FaPj+0R9FRZlowr6lqCVi8ZRZ9cA0ln7
         OtojZxfj1lVbPbhKnez4o/Af+9Pidb0EHouOfJQuEKv77ZkeXr3ybDHZZgO9L8o/zn
         SEjdJsNuxt0B/owuL+Po0u9+SvwRsJ0S0666mfgV/NV5uCIE4yE3AV7kwBWQAU8aux
         eJtZui/dtopRw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: fix missing error handling when replaying directory entries
Date:   Fri,  1 Oct 2021 13:52:29 +0100
Message-Id: <cover.1633082623.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Some places during log replay are ignoring errors when looking up directory
entries in a subvolume/fs tree. This fixes all those places and makes sure
we get consistent error hanlding when looking dir items and dir index items.

Filipe Manana (4):
  btrfs: deal with errors when checking if a dir entry exists during log replay
  btrfs: deal with errors when replaying dir entry during log replay
  btrfs: deal with errors when adding inode reference during log replay
  btrfs: unify lookup return value when dir entry is missing

 fs/btrfs/ctree.h    |  2 +-
 fs/btrfs/dir-item.c | 48 +++++++++++++++++++++++++--------
 fs/btrfs/tree-log.c | 65 ++++++++++++++++++++++++++++-----------------
 3 files changed, 79 insertions(+), 36 deletions(-)

-- 
2.33.0

