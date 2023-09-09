Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86D77997D6
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Sep 2023 14:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345513AbjIIMIt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Sep 2023 08:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjIIMIs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Sep 2023 08:08:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01CCCCA
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Sep 2023 05:08:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9229FC433C8;
        Sat,  9 Sep 2023 12:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694261323;
        bh=z2bApQ1dR9UUZgfwFOrkJZFnYua9wMnKEqy1QTeVQK0=;
        h=From:To:Cc:Subject:Date:From;
        b=kmPQ1MY/T6LUuZvFPGb+7EgZRNCcgRiWpJR8EgGORG3T9WFRUZ+YqvhsJ49vt2k+A
         LM4q14cOG1ay5vnYPKlPRd3NEZDEaCKK92Slr1oeKH1wIpJuf+kIUTbyZZCvDmCFTp
         uNBthGMjXtQTEsmeLCUtPAgL45TlYTa7URmVzlYQ3ovU2W3qBi25poKSNihYDkGC1u
         MY1ag8XS2wkPBvhAS2YaRONz/yw1z6WUeQaYM5DraquM3HZJ38trFEBAr2U4UKhy1k
         qcm2bu/wShmrE1DXty8qeIhla8VtM2R7LdcrWJ7rp96BFxLbNkUffJ+cTS1+U276DR
         TbPjmj8euIDkg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     ian@ianjohnson.dev, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 0/2] btrfs: updates for directory reading
Date:   Sat,  9 Sep 2023 13:08:30 +0100
Message-Id: <cover.1694260751.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Tweak and fix a bug when reading directory entries after a rewinddir(3)
call. Reported by Ian Johnson.

Link: https://lore.kernel.org/linux-btrfs/YR1P0S.NGASEG570GJ8@ianjohnson.dev/T/#u

Filipe Manana (2):
  btrfs: set last dir index to the current last index when opening dir
  btrfs: refresh dir last index during a rewinddir(3) call

 fs/btrfs/inode.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

-- 
2.40.1

