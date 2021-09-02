Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656893FEE64
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 15:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344966AbhIBNJr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 09:09:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33926 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344953AbhIBNJq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 09:09:46 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 85AAC1FF97
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Sep 2021 13:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630588127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pGZrM7Ts71lmga0MV1V0wTY90/X0gGrpWVsW/IDFsFw=;
        b=L3G27T8SnINcTceo2TpNG0vhkcMuzfca36D6MwuMIsiUYl0P1ArviwWH/bERYc0TAOfqTd
        n42O4dc3Q7DqAsPq3LQntW4F4HhI332O9o3dom67A8iSnSDieR9eq/wC0k62bDx5XLgFH/
        altAnx2DwzHSMetc0+H/Wxqk5pCQ00w=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id BA24513712
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Sep 2021 13:08:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id nmJLHt7MMGEsEAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Sep 2021 13:08:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: error messages enhancement for bad tree blocks
Date:   Thu,  2 Sep 2021 21:08:40 +0800
Message-Id: <20210902130843.120176-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When handling a corrupted btrfs image, there are tons of meaningless
error messages from btrfs-check:

  incorrect offsets 8492 3707786077

Above error message is meaningless, it doesn't contain which tree block
is causing the problem, just some random expected values with corrupted
values.

On the other hand, btrfs kernel tree-checker has way better error
messages, and even more checks than the counterpart in btrfs-progs.

So let's just backport the superior tree-checker code to btrfs-progs,
with some btrfs-progs specific (but minor) modifications.

Now the error message would look more sane (although a little too long):

  corrupt leaf: root=2 block=72164753408 slot=109, unexpected item end, have 3707786077 expect 8492

Qu Wenruo (3):
  btrfs-progs: use btrfs_key for btrfs_check_node() and
    btrfs_check_leaf()
  btrfs-progs: backport btrfs_check_leaf() from kernel
  btrfs-progs: backport btrfs_check_node() from kernel

 check/main.c          |   9 +-
 check/mode-original.h |   2 +-
 kernel-shared/ctree.c | 246 ++++++++++++++++++++++++++----------------
 kernel-shared/ctree.h |   5 +-
 4 files changed, 163 insertions(+), 99 deletions(-)

-- 
2.33.0

