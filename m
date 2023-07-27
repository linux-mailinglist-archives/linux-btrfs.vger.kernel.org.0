Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3213B765454
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 14:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjG0Mvd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 08:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjG0Mvc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 08:51:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5BC1737
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 05:51:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2AA9A1F890
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 12:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690462290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YaRXDAJlvrj+V7loirQFZWoU73i8z3T7nedyaRPZqqw=;
        b=XCC3V+6e/rP2TsNsF8WIU9isXSblPHyANAZMrZV6011z4+FPjob9YzfRemnnsg24kZiHTu
        ZGDtOsMQDO1xUTg5WtlxZ5Jdb+mpRUhtXVYygom+s7r4jUxo3j1mYvGGFV1xLKLrH1Mg2r
        Qo0wFUTOlE/1L15SHMkiVLTAzYsmnyE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 194A42C142
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 12:51:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 33CA0DA7FB; Thu, 27 Jul 2023 14:45:09 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.3.3
Date:   Thu, 27 Jul 2023 14:45:07 +0200
Message-ID: <20230727124509.16855-1-dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 6.3.3 have been released. This is a bugfix release.

There are two bug fixes, the rest is CI work, documentation updates and some
preparatory work.  Due to no other significant changes queued, the release 6.4
will be most likely skipped.

Changelog:

   * add btrfs-find-root to btrfs.box
   * replace: properly enqueue if there's another replace running
   * other:
      * CI updates, more tests enabled, code coverage, badges
      * documentation updates
      * build warning fixes

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.3.3
