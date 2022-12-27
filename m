Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846FA65676E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Dec 2022 06:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiL0Fzh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Dec 2022 00:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiL0Fz3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Dec 2022 00:55:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA45A21B2
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Dec 2022 21:55:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 34C2021A5A
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Dec 2022 05:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672120526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Kx1ob97WAbV9XLFkLsm83tR38ukL5g06uV/gJq4nOV8=;
        b=loWSaGWtmux9o3FXlzgpF0uTu433IVPJxWSDJvsgK5cqCPjUCRPTAhK6cpC2j9X8QOz7wA
        vbkeWud8zGL8FxACmo5O6Vjxar2o07qFK4c1m5EpGhJinITipOoBYbEYyJkUSlNiCX4BeM
        /kYH64oWQnTrAfqLtap67L/TqCJhrn0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D81A133F5
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Dec 2022 05:55:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XUfqEc2IqmMBRgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Dec 2022 05:55:25 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: fix the uuid report in "btrfs subvolume list -u"
Date:   Tue, 27 Dec 2022 13:55:06 +0800
Message-Id: <cover.1672120480.git.wqu@suse.com>
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

There is a regression caused by commit d729048be6ef ("btrfs-progs: stop
using btrfs_root_item_v0").

Just fix it and add a simple test case for it.

Qu Wenruo (2):
  btrfs-progs: fix the wrong timestamp and UUID check for root items
  btrfs-progs: misc-tests: add a test case to make sure uuid is
    correctly  reported

 cmds/subvolume-list.c                         | 11 ++++++--
 .../056-subvolume-list-uuid/test.sh           | 28 +++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)
 create mode 100755 tests/misc-tests/056-subvolume-list-uuid/test.sh

-- 
2.39.0

