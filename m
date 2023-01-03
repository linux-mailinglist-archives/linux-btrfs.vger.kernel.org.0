Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4147665C53A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 18:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbjACRlw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Jan 2023 12:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238264AbjACRld (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Jan 2023 12:41:33 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013CD12605
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Jan 2023 09:41:20 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 073E933C3C
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Jan 2023 17:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672767679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dAM4TUWBzA0AoAwOmuWkpe7j7OS/kKad7Hf97hJoxEs=;
        b=RT/fIHLliBEdyBIKBVua8uMMwd+32bmDnbcP4ZydXCVDJBEt3Z8rRrW660nCNbNrwNre7g
        v7TMsEaC4cjmCpDRZFNP5kJiw4OUUrmDbFM0B/Tz6RRLgKdVtht1QtAt5so4K4JPEExsDf
        /897oo+JNe33P7te+8QxexpLhaMCKnY=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F3FE82C188
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Jan 2023 17:41:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 78CA3DA7A3; Tue,  3 Jan 2023 18:35:49 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.1.1
Date:   Tue,  3 Jan 2023 18:35:49 +0100
Message-Id: <20230103173549.10791-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 6.1.1 have been released. This is a bugfix release.

The 6.1 caused a big breakage, build and due to change in subvolume list output
that's parsed by some tools. My appologies, the end of year is not the best
time to do a release.

I did a test build with snapper that uses libbtrfs directly.
Containerd-related projects pull the 'storage' module that has meanwhile fixed
the build against 6.1 but with 6.1.1 it'll break again, so this may take a few
days until all related projects get updated dependencies.

Changelog:

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

David Sterba (4):
      Revert "btrfs-progs: rename qgroup items to match the kernel naming scheme"
      btrfs-progs: kerncompat: hide definition of __init
      btrfs-progs: update CHANGES for 6.1.1
      Btrfs progs v6.1.1

Qu Wenruo (2):
      btrfs-progs: subvol list: fix the wrong timestamp and UUID check for root items
      btrfs-progs: misc-tests: add a test case to make sure uuid is correctly reported
