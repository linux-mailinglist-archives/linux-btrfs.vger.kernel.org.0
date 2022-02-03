Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130744A8709
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 15:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351558AbiBCOz5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 09:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351554AbiBCOz4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 09:55:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B711C061714
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 06:55:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2318DB83477
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 14:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547F0C340E4
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 14:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643900153;
        bh=MReN2p8Bka41/3gmEZmP1bHqf008DUjsZfREQ/G8OoU=;
        h=From:To:Subject:Date:From;
        b=dcgXACYExDzDTMD93ofYszUGJmt7QjTj+a3iqpad7biwrKwocvLbVZiI5FmN+nuBL
         CIQbYjemfo0kndBtem7wttfBvN+twcmVe/O8obHmLq03tVziqX4jmK9owQkXrS1pCI
         KYS2/dE2QqM8Qcv69ZuUWboKO+OjB9L381OPHO917NmmS/IQIo1IhNB1gHjghynwWc
         ZJ07m1ibW9/id+QWYeEX/tlJ9poOsC1JU8bQA671PTD7daKYSiJr6AueEEIfYvtd87
         KbIiRB5zig1HXMnoaFIFbc8sACPXK+a3iJG8cHqco9eTf/nbRd/8vBXMxKZYUorvXG
         Ku6Gr/sIlC7qg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs: some minor improvements and cleanups mostly around extent logging
Date:   Thu,  3 Feb 2022 14:55:44 +0000
Message-Id: <cover.1643898312.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This is a mix of small improvements around logging extents, replacing
extents in a log tree or subvolume tree, while others are more generic
ones, and some cleanups. They are grouped in the same patchset, but they
are all independent of each other.

Filipe Manana (6):
  btrfs: remove unnecessary leaf free space checks when pushing items
  btrfs: avoid unnecessary COW of leaves when deleting items from a leaf
  btrfs: avoid unnecessary computation when deleting items from a leaf
  btrfs: remove constraint on number of visited leaves when replacing extents
  btrfs: remove useless path release in the fast fsync path
  btrfs: prepare extents to be logged before locking a log tree path

 fs/btrfs/ctree.c    | 66 ++++++++++++++++++++++++++-------------------
 fs/btrfs/file.c     |  5 +---
 fs/btrfs/tree-log.c | 65 +++++++++++++++++++-------------------------
 3 files changed, 67 insertions(+), 69 deletions(-)

-- 
2.33.0

