Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A153063A802
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 13:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiK1MRO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 07:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiK1MQa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 07:16:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866C52A24F;
        Mon, 28 Nov 2022 04:08:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96F1AB80ABE;
        Mon, 28 Nov 2022 12:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F82C433C1;
        Mon, 28 Nov 2022 12:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669637260;
        bh=4Lw7leUPy/1sxV9yrRek1PiVw3JFZsgbNqED3C3x7yA=;
        h=From:To:Cc:Subject:Date:From;
        b=E3AOZI6zT7227dwygjjNnrH20X2usONHjkgSAvRhPoC800vkyevcP2ZCgmWhtIglW
         J5lTpKsc/mIz+pKaVUndVL37GEvMeG4+u07HE5QpDzUIB0yBxuhINYEY44vu6bXu5N
         dT6CnBkOx+4IyzQbROeH9Lt40NQPVYNXR4d8QGTMXdc0JF+c758hS9S19q9vA233gH
         lJWcpTQULjXZTNigQ4+SQrR+dFW1MuGRVquEqQP2eFnBY4ydTHSZGBhLVjS8RAMUaj
         lcRH9fdgO+opx76kOIqhfMVGDY5ZMpfyU6SFbeckRfNoOv9PBuVV24dOpaQQtRYDMl
         w4ApLLfE+e5ZA==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 0/4] fstests/btrfs: add a test case for send v2 and an update
Date:   Mon, 28 Nov 2022 12:07:20 +0000
Message-Id: <cover.1669636339.git.fdmanana@suse.com>
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

This adds a test case specific for send v2 with some preparatory work in
order to allow for that. Support for v2 send streams was added in
btrfs-progs v5.19 and the kernel support introduced with kernel 6.0.

More send v2 specific tests will be added later.

Filipe Manana (4):
  btrfs: add a _require_btrfs_send_v2 helper
  common: make _filter_fiemap_flags optionally print the encoded flag
  btrfs/280: also verify that fiemap reports extents as encoded
  btrfs: test a case with compressed send stream and a shared extent

 common/btrfs        | 14 +++++++
 common/punch        | 40 ++++++++++++++++++--
 tests/btrfs/280     |  4 +-
 tests/btrfs/280.out | 12 +++---
 tests/btrfs/281     | 89 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/281.out | 17 +++++++++
 6 files changed, 164 insertions(+), 12 deletions(-)
 create mode 100755 tests/btrfs/281
 create mode 100644 tests/btrfs/281.out

-- 
2.35.1

