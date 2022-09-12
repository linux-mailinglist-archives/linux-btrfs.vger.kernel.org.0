Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71BE5B5F26
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 19:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiILRUE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 13:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiILRTy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 13:19:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E99A616F
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 10:19:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 389A220588
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 17:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663003190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pLMT5ekNhyNteeE1KBGfzr0qQIXNeG1W/Si/iCb/IJw=;
        b=ryG9BUBCQ/JFijbuyPhs5kBjhiUQ058PZDRLcmdYQKYF2hAFhU4A0LPRHK1YaMjSTIMjLF
        Y1+oxD8HSTKXCT83cXWGlGDfMWVeteuNrUBvSsyQCHjxlaJtV0Ij4Faf7y6/E3pLOm2snb
        hAwukKi+MSYZ2cxG1n6isyoQTha9hI0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 316042C141
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 17:19:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 39D39DA832; Mon, 12 Sep 2022 19:14:25 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.19.1
Date:   Mon, 12 Sep 2022 19:14:24 +0200
Message-Id: <20220912171425.21222-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.19.1 have been released. This is a bugfix release.

Changelog:

   * fix memory leaks (extent buffer, path)
   * check: verify block device size vs item
   * rescue fix-device-size: allow to shrink device item
   * receive: fix crash on wrong pinter free()
   * other:
      * experimental: support for block-group-tree
      * documentation updates
      * new tests

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

David Sterba (7):
      btrfs-progs: docs: add new 5.19 features
      btrfs-progs: docs: add stub page for kernel changes
      btrfs-progs: tests: add matching line for extent leaks to scan-results
      btrfs-progs: mkfs: drop numeric flag from -O and -R option list
      btrfs-progs: tests: fix misc/016 encoded write, permissions of send stream file
      btrfs-progs: update CHANGES for 5.19.1
      Btrfs progs v5.19.1

Qu Wenruo (9):
      btrfs-progs: fix eb leak caused by missing btrfs_release_path() call.
      btrfs-progs: check: verify the underlying block device size is valid
      btrfs-progs: tests: add test case for shrunk device
      btrfs-progs: rescue: allow fix-device-size to shrink device item
      btrfs-progs: mkfs: dynamically modify mkfs blocks array
      btrfs-progs: don't save block group root into super block
      btrfs-progs: separate block group tree from extent tree v2
      btrfs-progs: btrfstune: add the ability to convert to block group tree feature
      btrfs-progs: mkfs: add artificial dependency for block group tree

Su Yue (1):
      btrfs-progs: free extent buffer after repairing wrong transid eb

Wang Yugui (1):
      btrfs-progs: receive: fix a segfault when passing error pointer to free()

