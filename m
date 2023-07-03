Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E547A74613E
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 19:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjGCRPr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 13:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGCRPq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 13:15:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D07710CB
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 10:15:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7CBC60FCD
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 17:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5BEC433C8
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 17:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688404535;
        bh=5E693DGdkXkgvgWP7rfmwt3P7OxY4Hg7qbNdZ+Z+NsE=;
        h=From:To:Subject:Date:From;
        b=lEkUgliB2at15G834HDsFwW5JPFHsUOhR7cFf4fNgsPaccrZfUdcRpm5kWhzah7V+
         nwzW0sKgnjksVmPiwzKTivudrf7z9sLS8e8CPlJzRR0qlB/LMUWP+yw7uejuIisjjK
         6mMc/7SeIEtb/wCd/nNw7LPhpjpRwQka0xmkbG2nWrX95eXHTRWD+ngOjoZul4Eeqg
         fkhfL6UQ2/ljOUOq2pbqy1lC35k3G4XyA2jfOX4LQCifXBQ1Stv8W/CEp05uhrog3f
         K7SSpDsBEC+IKBpuuZZiMbyYBTQ0GV57kUvrldvqpGRk0qhc1MlZiX8ege1oSAs654
         Zo22T19A8BPvQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fix error paths of btrfs_orphan_cleanup()
Date:   Mon,  3 Jul 2023 18:15:29 +0100
Message-Id: <cover.1688403622.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

These fix two issues with error paths of btrfs_orphan_cleanup(), a double
iput() on an inode and an iput() against a ERR_PTR(-ENOENT) inode pointer,
resulting in a crash. More details on the changelogs.

Filipe Manana (2):
  btrfs: fix double iput() on inode after an error during orphan cleanup
  btrfs: fix iput() on error pointer after error during orphan cleanup

 fs/btrfs/inode.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

-- 
2.34.1

