Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820A3428A92
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 12:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbhJKKMX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 06:12:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58980 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhJKKMV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 06:12:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B81B622009;
        Mon, 11 Oct 2021 10:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633947020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=SSa1ppWWLcBSLPKWP4kYojlS71HeIE3nWFzHmJpcKmc=;
        b=MZavzCRF5Tr9lebZkooknHSiYd6fMVz/1I598aM8ywzQlaclTW0z/t3KqAD8H8ao4KBFW7
        hzPkbo4rZhuZrQhm0dno6h8hoSPyhYDCKwaHoUCC0uWGi0wDrrchWW1AINm+5ExYN7YYrm
        F2Xk1A0WmKSJ7tApx9kB9SuqyQMLi+U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86CAF13C4C;
        Mon, 11 Oct 2021 10:10:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1lImHowNZGGJLwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 11 Oct 2021 10:10:20 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/5] Make real_root used only in ref-verify
Date:   Mon, 11 Oct 2021 13:10:14 +0300
Message-Id: <20211011101019.1409855-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here's a small series that refactors the way btrfs_ref::real_root and
btrfs_ref::skip_qgroup are used. Currently the former is used in ref-verify but
also in order to perform the is_fstree() check on it in delayed-ref core. Given
the complexity and amount of information that the delayed ref machinery hauls
around it becomes really non-evident that delrefs really don't care about
real_root itself but rather only if qgroup processing should happen or not.

Instead of having the check burried in the core this series changes the data
flow in such a way that real_root will only be used for ref-verify's operation
and 'skip_qgroup' will contains the final condition of whether qgroup processing
should take place for a given delref.


Nikolay Borisov (5):
  btrfs: Rename root fields in delayed refs structs
  btrfs: Rely on owning_root field in btrfs_add_delayed_tree_ref to
    detect CHUNK_ROOT
  btrfs: Add additional parameters to
    btrfs_init_tree_ref/btrfs_init_data_ref
  btrfs: pull up qgroup checks from delayed-ref core to init time
  btrfs: make real_root optional

 fs/btrfs/delayed-ref.c | 19 +++++++++---------
 fs/btrfs/delayed-ref.h | 44 +++++++++++++++++++++---------------------
 fs/btrfs/extent-tree.c | 32 +++++++++++++++---------------
 fs/btrfs/file.c        | 13 ++++++++-----
 fs/btrfs/inode.c       |  4 ++--
 fs/btrfs/ref-verify.c  |  4 ++--
 fs/btrfs/relocation.c  | 28 +++++++++++++--------------
 fs/btrfs/tree-log.c    |  2 +-
 8 files changed, 74 insertions(+), 72 deletions(-)

--
2.25.1

