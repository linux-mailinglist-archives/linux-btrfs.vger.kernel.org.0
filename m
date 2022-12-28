Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E166587E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Dec 2022 00:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiL1Xcr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Dec 2022 18:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiL1Xcp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Dec 2022 18:32:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4224120A9
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Dec 2022 15:32:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AA4C77602C
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Dec 2022 23:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672270362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=LuP+Jh6RiBKx8yPVKEb7gU1BpPny46Vr0qiLomeFh+s=;
        b=JZ/4lmIfak/9GNcoSELdwxWjqepvncOj2n7LXhG2kmRcmAXj1nWILtzaL4WVDO6Uh0GHHj
        WIYRxVY1l9SSuIDRM9+2QLbWJP8CIGcG/ow89rUDN2FymUAgO1k9dE9of/u7pl3OgIK/TQ
        L6hyULMPNL6HeOhonWpPcY6jy3ilBi4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3902138F9
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Dec 2022 23:32:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q0DMLhnSrGP/BAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Dec 2022 23:32:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fixes for commit 947a629988f1 ("btrfs: move tree block parentness check into validate_extent_buffer()")
Date:   Thu, 29 Dec 2022 07:32:22 +0800
Message-Id: <cover.1672190127.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a regression report from Mikhail that his btrfs RAID0 fs
randomly flips to RO after commit 947a629988f1.

It turns out that, the offending commit can not handle tree blocks
crossing stripe boundary.

Although tree blocks crossing stripe boundary is not an ideal situation,
we should still be able to correctly handle it.

This patchset firstly adds the missing level mismatch error message,
then fix the offending commit.

Qu Wenruo (2):
  btrfs: add error message for metadata level mismatch
  btrfs: fix the false alert on bad tree level

 fs/btrfs/disk-io.c   |  4 ++++
 fs/btrfs/extent_io.c | 31 ++++++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 5 deletions(-)

-- 
2.39.0

