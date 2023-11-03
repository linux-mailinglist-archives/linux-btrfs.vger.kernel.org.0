Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BE07E07AE
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 18:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjKCRmU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Nov 2023 13:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjKCRmT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Nov 2023 13:42:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A4A1BD
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Nov 2023 10:42:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9047A21889
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Nov 2023 17:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699033330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=DujMBPDclAl7zXzpeZd45YODUXY4gxbLmntFLyill38=;
        b=D00ytgyM4ez4FCJeueCw1TJedW/nHui9EXk62+Q7D208Nqep9n9ZRYpSOzRSlesGd+KlBG
        ACi+bkbAOKcOmJ8cd/zYSUUx7JDCZhYU1BA37MCAAF79AM9iiwrGBSOOzdQABqGjXK0Br+
        3aAAeM5KWo8hY8mdROpQ/qUCVbmo620=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4FBDA2C515
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Nov 2023 17:42:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3E09ADAA12; Fri,  3 Nov 2023 18:35:12 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.6
Date:   Fri,  3 Nov 2023 18:35:10 +0100
Message-ID: <20231103173512.2372-1-dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 6.6 have been released.

A mix of new minor features or commands and bug fixes.

Changelog:

* new global option --dry-run, now implemented for 'subvolume delete'
* fi defrag: new option --step to defragment files in steps, report progress
* balance: removed support for obsolete short syntax 'btrfs balance /path'
* mkfs: print zone count for each device in the overview
* check:
  * verify inline ref ordering
  * deprecate --clear-space-cache, moved to the 'rescue' group
* rescue clear-space-cache: new command moved from 'btrfs check' implementing
  the same as option --clear-space-cache (to be deprecated and removed in the
  future)
* dump-tree: output sequence number for inline refs
* fixes:
  * fi resize: fallback to lowest devid when 1 does not exist, previously the
    command would fail with "No such device"
  * fi usage: fix "devices 0 != 1" message and broken output on multi-device
    filesystem
  * open files in non-blocking mode when reading fsid, this could hang when
    trying to open fifo files or some special character devices, was observed
    with 'prop set/get'
* experimental:
  * mkfs: parametric zone size for emulated zoned mode
* other:
  * cleanups refactoring
  * new and updated tests
  * CI updates
  * documentation updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.6
