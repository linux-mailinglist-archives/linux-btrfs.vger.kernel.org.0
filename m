Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6367622AD4
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Nov 2022 12:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiKILoR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Nov 2022 06:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiKILoD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Nov 2022 06:44:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DBE13CDC;
        Wed,  9 Nov 2022 03:43:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8626C61A2D;
        Wed,  9 Nov 2022 11:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1871BC433D6;
        Wed,  9 Nov 2022 11:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667994222;
        bh=cBkwL0l/7muXc82RZAoZ923kAFNTHLZpF1APu0PNwFo=;
        h=From:To:Cc:Subject:Date:From;
        b=MJMB/e3iJwAWIxVz3kijtiIFeVO/P+2JTraDTnEgZSGwQ0XSeQjrNCOyl6joCwZvw
         uRPsgT+4QnHYryVUNLKHnMFiLvA4PhGMfJfWJtN0EQDOLcWUwKF+M7HZAVK9NxdKxl
         ylY0IcwJvjCkRzq/Jpd7vial2xlgoghrOzoorIlTZjqB8X7/k8fae33H8O0Gn1irPv
         WGjqBnlrFJRnOaJBbNIM+3NvdQh8sRTsnQIdhZDEwrPLvjLdaKtXiy/x17FbYuxMBO
         FB1W87RI0VAF1OWxDSFACg9J6T3JZ23GZlWg+BI5OTCWsm7e6NUgK2aGA2IyhJolmU
         XSNTNzuL2dt2A==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 0/3] btrfs: fix some test failures with btrfs-progs 5.19 and 6.0
Date:   Wed,  9 Nov 2022 11:43:33 +0000
Message-Id: <cover.1667993961.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The output of some commands changed with btrfs-progs 5.19 and 6.0, as well
as the --leafsize/-l command line option was removed from mkfs. These make
some tests fail. This patchset changes the tests so that they work with the
new btrfs-progs versions as well as older versions.

Filipe Manana (3):
  btrfs/003: fix failure on new btrfs-progs versions
  btrfs/053: fix test failure when running with btrfs-progs v6.0+
  btrfs: fix failure of tests that use defrag on btrfs-progs v6.0+

 tests/btrfs/003 | 5 +++--
 tests/btrfs/021 | 4 +++-
 tests/btrfs/053 | 4 ++--
 tests/btrfs/256 | 4 +++-
 4 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.35.1

