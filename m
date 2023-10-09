Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DFD7BD29D
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 06:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345030AbjJIErZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 00:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjJIErX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 00:47:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FCDA4
        for <linux-btrfs@vger.kernel.org>; Sun,  8 Oct 2023 21:47:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1FEDA1F895
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 04:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696826841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gG87p2MUFLCBd9UgT4y3oTVgCdkqIVYC5AD7Vb6JNVA=;
        b=X/FmB1YV0NsJcRJtzYlGDj1rXNjse8l/zcULnSSiA7mTohjxAsj3eh4oLwag/KTjIzn48R
        Uh229o71Etv9kke+fH4oK2kauGDVfqo7X91NHg1JHTFfY6QWA+pQjtiepZFtYJiDEXdJLV
        mUaGkOPiAwo/KOA6L2ax66hBqAnS7wc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB17413586
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 04:47:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SbjPIteFI2VSVQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Oct 2023 04:47:19 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: move inode cache removal functionality to "btrfs rescue" group
Date:   Mon,  9 Oct 2023 15:16:58 +1030
Message-ID: <cover.1696826531.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
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

This is the first step to move those cache clearing functionality to
"btrfs rescue", as "btrfs check" doesn't looks that proper just to clear
various cache.

This patchset is handling issue #669 by moving the rarely used inode
cache clearing to "btrfs rescue" as the safe and first step.

Qu Wenruo (2):
  btrfs-progs: move clear-cache.[ch] from check to common directory
  btrfs-progs: move inode cache removal to rescue group

 Documentation/btrfs-check.rst   |  5 +++-
 Documentation/btrfs-rescue.rst  |  6 ++++
 Makefile                        |  6 ++--
 check/main.c                    |  3 +-
 cmds/rescue.c                   | 52 +++++++++++++++++++++++++++++++++
 {check => common}/clear-cache.c |  2 +-
 {check => common}/clear-cache.h |  0
 convert/main.c                  |  2 +-
 tune/main.c                     |  2 +-
 9 files changed, 70 insertions(+), 8 deletions(-)
 rename {check => common}/clear-cache.c (99%)
 rename {check => common}/clear-cache.h (100%)

--
2.42.0

