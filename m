Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF30429FA9
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 10:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhJLIXl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 04:23:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42042 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbhJLIXl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 04:23:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0B6FB22183;
        Tue, 12 Oct 2021 08:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634026899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ivHLg3+nDu1jskDIcw7HrzHiEJCFO+ACJh8yUuB/RTM=;
        b=Lp/OzbemXMM4dNfeUi0Iznjib84A79+AV1YPT3DqqF3znVt5y4KLm76QgEyv0gjqfsA072
        poHxN2Pc3v9djlkTXSobHwGxSc8o+LOmwocZtRD3Dnh1eeyX7csJUUSMPBIAH7eKi4SMaT
        1OzgAKFA9vRxBTPim/zNr4WUZck5nYg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE0D313AD5;
        Tue, 12 Oct 2021 08:21:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M2TOL5JFZWGkRgAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 12 Oct 2021 08:21:38 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 0/5] Make real_root used only in ref-verify
Date:   Tue, 12 Oct 2021 11:21:32 +0300
Message-Id: <20211012082137.1476078-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Updated version incorporating David's feedback:

* Used the short form of the ternary operator in the last patch
* Made all patches subject lines begin with lower case
* Expanded the condition in the 4th patch when setting skip_qgroup

Nikolay Borisov (5):
  btrfs: rename root fields in delayed refs structs
  btrfs: rely on owning_root field in btrfs_add_delayed_tree_ref to
    detect CHUNK_ROOT
  btrfs: add additional parameters to
    btrfs_init_tree_ref/btrfs_init_data_ref
  btrfs: pull up qgroup checks from delayed-ref core to init time
  btrfs: make real_root optional

 fs/btrfs/delayed-ref.c | 19 ++++++++--------
 fs/btrfs/delayed-ref.h | 51 ++++++++++++++++++++++++------------------
 fs/btrfs/extent-tree.c | 32 +++++++++++++-------------
 fs/btrfs/file.c        | 13 ++++++-----
 fs/btrfs/inode.c       |  4 ++--
 fs/btrfs/ref-verify.c  |  4 ++--
 fs/btrfs/relocation.c  | 28 +++++++++++------------
 fs/btrfs/tree-log.c    |  2 +-
 8 files changed, 81 insertions(+), 72 deletions(-)

--
2.25.1

