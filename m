Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E195570574
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 16:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiGKOW6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 10:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiGKOW6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 10:22:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DA4643F5
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 07:22:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 700B9CE131F
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 14:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FA8C34115
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 14:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657549373;
        bh=t6tIkhjtlCP1Z8b47gaZhIIXyYzjYpW/JppOw05ghI8=;
        h=From:To:Subject:Date:From;
        b=FWPImIcrhSrgTU5jOm7QhDXOr+bDPh7G5B4coOVQrPox7UgOTy7lbbig/yLHy5f8W
         jXKBWC6brW/XTZCboHIjOPxj/KutyQBg0vmK82UDwHo0/0DX07hPnPkBMh364M+sLH
         q5v3yZuj8uVZqeAV7Y0l6LC0nkz11u+UmNn+HGYGgPKemibPehOs6LJcZi+OlsZxm5
         8ut8Y+XMDoBIOf1U9r56loizjzTDg1epKhpHWVENWwu/aDKLo0poOAm3XnvR7HeR+w
         84tkCag4HkLOxmByX5SgANCSj8uwIqXRpxJ+UMuAqNXBMyDg66mVrqOvtMXCe4bIkM
         yd7bqIV2j+olQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: optimize btrfs_ino()
Date:   Mon, 11 Jul 2022 15:22:48 +0100
Message-Id: <cover.1657549024.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The following patchset optimizes btrfs_ino(), an inline function that is
used pretty much everywhere, to avoid doing less work and be trivial on
64 bits systems. Details on the changelogs of the patches.

Filipe Manana (2):
  btrfs: set the objectid of the btree inode's location key
  btrfs: add optimized btrfs_ino() version for 64 bits systems

 fs/btrfs/btrfs_inode.h       | 22 +++++++++++++++++-----
 fs/btrfs/disk-io.c           |  4 +++-
 fs/btrfs/tests/btrfs-tests.c |  1 +
 3 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.35.1

