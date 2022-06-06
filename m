Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2672F53ECFC
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 19:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiFFRYs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 13:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFFRYr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 13:24:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029D1719EC
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 10:24:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EC48821B5F
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 17:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654536283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=70F4g/GwyeYHdPcLolxQzXkXMS2+9UlZS3cX1091rrA=;
        b=n3LbgUl4Q1kRKySoSBcRcV/eo/YpWBrLrjpgc2PM4YMZM6N8qcWE2j1blYrjAoEArOnnGh
        uD9R/I9CzLW7omWeJshoqjPsO85SgVNis0hfB9EpEEh4v7xmGbPFBP2/Ebn1dZ26kIRI1P
        zgeypLxXfUVw+thVqszGEjJoRZufQz4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E4BE42C141
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 17:24:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6B844DA8F5; Mon,  6 Jun 2022 19:20:16 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.18.1
Date:   Mon,  6 Jun 2022 19:20:16 +0200
Message-Id: <20220606172016.320-1-dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
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

btrfs-progs version 5.18.1 have been released. This is a bugfix release.

Changelog:
  * fixes:
    * convert: fix self reference of toplevel directory
    * build: make kernel lib headers compatible with C++
  * zoned mode: verify minimum zone size 4MiB
  * libbtrfs: cleanups, merge headers and remove declarations of unexported
    symbols
  * other: documentation updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

David Sterba (15):
      btrfs-progs: docs: add link to released tarballs
      btrfs-progs: kernel-lib: make headers C++ compatible
      btrfs-progs: docs: reformat btrfs-property manual page
      btrfs-progs: convert: fix self-reference of directory
      btrfs-progs: docs: update Gloassary
      btrfs-progs: libbtrfs: add clean targets
      btrfs-progs: libbtrfs: use own copy of ctree.h, extent_io.h, send.h and extent-cache.h
      btrfs-progs: libbtrfs: drop ifdef BTRFS_FLAT_INCLUDES where not necessary
      btrfs-progs: libbtrfs: remove declarations without exports in send-utils
      btrfs-progs: libbtrfs: remove declarations without exports in extent_io.h
      btrfs-progs: libbtrfs: remove declarations without exports in extent-cache.h
      btrfs-progs: libbtrfs: move extent_io.h to ctree.h
      btrfs-progs: libbtrfs: move extent-cache.h to ctree.h
      btrfs-progs: update CHANGES for 5.18.1
      Btrfs progs v5.18.1

Johannes Thumshirn (1):
      btrfs-progs: zoned: add upper and lower zone size boundaries

frukto (2):
      btrfs-progs: docs: fix typo in mkfs.btrfs
      btrfs-progs: docs: make description of list output more clear
