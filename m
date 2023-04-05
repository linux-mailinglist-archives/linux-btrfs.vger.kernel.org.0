Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA41A6D853B
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 19:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjDERvh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 13:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjDERvf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 13:51:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052E95266
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 10:51:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 975CD62979
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 17:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814F6C433EF
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 17:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680717094;
        bh=x3JT/XN5iE55MB3c29Dhe8GTCx5GM8e+Iv7OATkwWGE=;
        h=From:To:Subject:Date:From;
        b=EPhoJQEIYgDNcAJtWrYU7t/4uQmqcD9Bs8rWBmLeg6WiAT9uTGPVSxkOiyPA1qDwS
         4QV7jgY+mNETBgFN7QNVH3Nk5HrNet2iEXvrarFtghDydAnMFsJowdz3YxrlD8yYw2
         uI+PtRBALOkc+8pmsDxomiMPLBpOkQWE1TGnGD8Zkm1UW/38J6N8vihMjIXzy/6Evm
         UK2POYhe/bv+2fUtwNPm6RrXfPp2hD5WSviHleEfkiXoAzeKqZdYMfkMm2a99WO8a2
         uVZLtgY+Wny0QNOxs82ks8OxZGnhhclmqSLz0mvKHWx8UfNC7mh8ap3+h718TKRQS+
         mHZ5YeVcu5YAg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: some fsync updates when logging directories
Date:   Wed,  5 Apr 2023 18:51:28 +0100
Message-Id: <cover.1680716778.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Two optimizations for directory logging, more details on the changelogs.

Filipe Manana (2):
  btrfs: avoid iterating over all indexes when logging directory
  btrfs: use log root when iterating over index keys when logging directory

 fs/btrfs/btrfs_inode.h | 32 +++++++++++++++---
 fs/btrfs/tree-log.c    | 76 +++++++++++++++++++++++++++---------------
 2 files changed, 77 insertions(+), 31 deletions(-)

-- 
2.34.1

