Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DE8774E72
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 00:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjHHWlA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Aug 2023 18:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjHHWk7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Aug 2023 18:40:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0B5FD
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 15:40:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 308CE1F45E
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 22:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691534457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=s+v9Qs9rnLOD1rhG+TpFEKEA6oqDGuSdWgMrfi3ZcsA=;
        b=gPF9wFVZoSpFS/E5STcmkze9/NOmIp5n5LIxtyR40GNbzenTmWTW0afO6/2mIqXGa0Idbi
        s7XCgjoWkimlc1C1kHQy2PNUAKwcFDBPBwvkOcOh6DiS1XA/aMoN9NCNGdB+mX1C0lBaPp
        FIL74N0OOhV2gI1pxKSnxQPFZ6Yix+0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 857CC139D1
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Aug 2023 22:40:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ff0ZFHjE0mQICgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Aug 2023 22:40:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs-progs: tests false alerts fixes
Date:   Wed,  9 Aug 2023 06:40:40 +0800
Message-ID: <cover.1691533896.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the resent and aggregate version of the fixes I sent but mostly
eaten by the recent vger down time.

Those are small fixes for the false alerts I hit during my local runs.

Most of them are subtle fixes, only the last one is more like an
optimization.

Qu Wenruo (4):
  btrfs-progs: tests/mkfs/005: use udevadm settle to avoid false alerts
  btrfs-progs: tests/misc/030: do not require v1 cache for the test case
  btrfs-progs: tests/misc/046: fix false alerts on write detection
  btrfs-progs: tests/misc/058: reduce the space requirement and speed up
    the test

 tests/misc-tests/030-missing-device-image/test.sh     | 8 --------
 tests/misc-tests/046-seed-multi-mount/test.sh         | 4 +++-
 tests/misc-tests/058-replace-start-enqueue/test.sh    | 5 ++---
 tests/mkfs-tests/005-long-device-name-for-ssd/test.sh | 4 +++-
 4 files changed, 8 insertions(+), 13 deletions(-)

--
2.41.0

