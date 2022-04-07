Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A405F4F83B3
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Apr 2022 17:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344858AbiDGPlm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Apr 2022 11:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiDGPll (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Apr 2022 11:41:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2B61EAC5
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 08:39:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C13E01F85A;
        Thu,  7 Apr 2022 15:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649345979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0zryOdAOhXX+JSsIMiTAcfbYqiYW2F58vPtzR5jjMEE=;
        b=lxhu1ZFGYS2LF8T6xvDWD89EPe40bWaJMp/JvwFnukuEYG6L1MSal1WjdO6HMyuDSpMPxB
        K9HwusDpbiHM0ObZAVg1htvdBHzg7lfNbWy9DOyJ/MrDuYXlxLqC/XsIxPGJHAGpwfjZ7+
        xvozVu0wgrzICmQMxYnPx5zAjtp7/AU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A22013A66;
        Thu,  7 Apr 2022 15:39:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qd/mI7sFT2LpdQAAMHmgww
        (envelope-from <gniebler@suse.com>); Thu, 07 Apr 2022 15:39:39 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH 0/6] Turn delayed_nodes_tree into XArray and adjust usages
Date:   Thu,  7 Apr 2022 17:38:48 +0200
Message-Id: <20220407153855.21089-1-gniebler@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

XArrays offer a somewhat nicer API than radix trees and were implemented
specifically to replace the latter. They utilize the exact same underlying
data structure, but their API is notionally easier to use, as it provides
array semantics to the user of radix trees. The higher level API also
takes care of locking, adding even more ease of use.

The btrfs code uses radix trees directly in several places, such as for the
`delayed_nodes_radix` member of the btrfs_root struct.

This patchset converts `delayed_nodes_radix` into an XArray, renames it
accordingly and adjusts all usages of this object to the XArray API.
It survived a complete fstests run.

Gabriel Niebler (6):
  Turn delayed_nodes_tree into delayed_nodes_xarray in btrfs_root
  btrfs_get_delayed_node: convert to using XArray API
  btrfs_get_or_create_delayed_node: convert to using XArray API
  __btrfs_release_delayed_node: convert to using XArray API
  btrfs_kill_all_delayed_nodes: convert to using XArray API
  __setup_root: convert to using XArray API for delayed_nodes_xarray

 fs/btrfs/ctree.h         |  4 ++--
 fs/btrfs/delayed-inode.c | 48 ++++++++++++++++++----------------------
 fs/btrfs/disk-io.c       |  2 +-
 fs/btrfs/inode.c         |  2 +-
 4 files changed, 26 insertions(+), 30 deletions(-)

-- 
2.35.1

