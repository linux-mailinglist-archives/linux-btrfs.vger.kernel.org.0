Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAC06A5FA2
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Feb 2023 20:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjB1T3i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Feb 2023 14:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB1T3h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Feb 2023 14:29:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9AF32517
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 11:29:35 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2AAC221A79
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 19:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677612574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nbvF3FiRJY6FkLJlJ4f5ASR3MRSdks/l+4YrVBvYhw0=;
        b=YHq+/UGPOMQK/vPRiA0tLkNoyQNWIwdz4rRD4OH8ZBxwXy8jNo1Ct3aRzJ++aEJPEfjv3X
        LCxMeu4FyVOsz/6PM4yLsKMrLS0M8DNeb+6ISR5SbwAO75rLAAXFsZ7CUOseQ04acXutd7
        5cT2+RfhBunZSfBXd7DBit9ZQuwGsFE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1F54B2C141
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 19:29:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D93DFDA7A3; Tue, 28 Feb 2023 20:23:35 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.2
Date:   Tue, 28 Feb 2023 20:23:35 +0100
Message-Id: <20230228192335.12451-1-dsterba@suse.com>
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

btrfs-progs version 6.2 have been released.

Changelog:
   * receive: fix a corruption when decompressing zstd extents
   * subvol sync: print total number and deletion progress
   * accelerated hash algorithm implementations in fallback mode on x86_64
   * fi mkswapfile: new option --uuid
   * new global option --log=level to set the verbosity level directly
   * other:
      * experimental: update checksum conversion (not usable yet)
      * build actually requires -std=gnu11
      * refactor help option formatting, auto wrap long lines

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
