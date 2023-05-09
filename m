Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2AA6FBC0D
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 02:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjEIAnp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 20:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEIAno (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 20:43:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB84A5FC9
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 17:43:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5280621D54
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 00:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683593014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=h/eVZCRkCbD8Tvv6vnzJdvA5SigGzpx/FLuMZTmBozE=;
        b=LH/BEahPSSZr3zZjpf5uCp/uevFPPqC1+j6d1JOhgXbX281LRvMGvaQK2h12+O73QxTiej
        dESDymZh3l1n5aFc/MHQOvMYCJbJc0cGo8AgO8Y5NeqcRCPVw+pUS/OuXvgrDs0tsOxWQo
        SUFMbclLGepFTfnr+boW1KYYSUm/VYE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C5F5134B2
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 00:43:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b1WuGDWXWWScDgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 09 May 2023 00:43:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: convert: fix csum generation for migrated ranges
Date:   Tue,  9 May 2023 08:43:13 +0800
Message-Id: <cover.1683592875.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is an internal report that btrfs/012 failed on 64K page size
systems.

It turns out that with 64K block size for ext4, even an empty ext4 can
lead to csum errors for the image file.

The root cause is the bad csum generation, which read incorrect data
from the disk, and leads to bad csum generated. (while the on-disk data
is still correct).

This patchset would fix the bug and add a test case for it.

Qu Wenruo (2):
  btrfs-progs: convert: fix bad csum for migrated range.
  btrfs-progs: tests/convert: add a test case to check the csum for the
    image file

 convert/main.c                                   | 12 ++++++++++--
 .../023-64k-blocksize-migrated/test.sh           | 16 ++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100755 tests/convert-tests/023-64k-blocksize-migrated/test.sh

-- 
2.40.1

