Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175D8586C67
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Aug 2022 15:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiHAN6B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Aug 2022 09:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiHAN57 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Aug 2022 09:57:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF6D2DE8
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 06:57:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07C2B61278
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 13:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC2FC433C1
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 13:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659362277;
        bh=qOPnNlHwpVnvHS7PC7cj5hNdglp8MGPCUL+d71NGmBE=;
        h=From:To:Subject:Date:From;
        b=Tyr5kDb4dE8Ayg1jnSQkJvOND2MsMi646SkWHOZVZIH6lMpFKsmWKboC/5vWa8bek
         uK96tOMv2kDJPIRBk7qSqaD+scwWGMQSAU14+r0+Ec7zYTgABcuhBoMa2xDyy05i+y
         6hHbzHIDLnVt49KesM/+kZ3bWbrQi0go2crVuNpI/nd3Dx5HjfFcK2fHcE5+dO+dlH
         IJc4OyOr8gzMuFe+rQZn5fvpSN0SptgFyyA067QUm/HMrNmkDS9MRzn0fVqr5CEwfr
         +FnxAqCQ1KXDGu4tb86KkHRriL7hUxN+KX0G9LNwf8QMef7R7vK7pRd63Kp/+0reDm
         ZkKmUkvSOW65Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: a couple fixes for log replay and a refactoring
Date:   Mon,  1 Aug 2022 14:57:50 +0100
Message-Id: <cover.1659361747.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Fix two minor issues during log replay, when processing inode references,
and rework a bit the processing of new inode references to remove some
special code for special cases.

Filipe Manana (3):
  btrfs: fix lost error handling when looking up extended ref on log
    replay
  btrfs: fix warning during log replay when bumping inode link count
  btrfs: simplify adding and replacing references during log replay

 fs/btrfs/tree-log.c | 168 +++++---------------------------------------
 1 file changed, 16 insertions(+), 152 deletions(-)

-- 
2.35.1

