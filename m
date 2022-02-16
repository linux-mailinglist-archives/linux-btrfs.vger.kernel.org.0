Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31984B93E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 23:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbiBPWcI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 17:32:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiBPWcH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 17:32:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767DB9FB71
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 14:31:53 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 34F7E1F37D
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 22:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645050712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xGFNCXH3YlUh/jNf+8PIBMSheJt/4OORIzbTbdLcDcE=;
        b=oNO/0vE1nhojcUaQfj7z/WAo6GWOadfTk2yBBQq13AuVxzcNCblO39Kd/kTECXObBL9jBB
        qaGdnB+DCZ7QlfXMXUmEZJt1LG0ltrX13qPCYqjzfeE+SkE8U0Qp406isQAdNQxexhEz4N
        0iDeMa8v+g6KhzgrKNN+wRTcCAeE7lY=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2F2C5A3B84
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 22:31:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 69D9ADA829; Wed, 16 Feb 2022 23:28:07 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.16.2
Date:   Wed, 16 Feb 2022 23:28:07 +0100
Message-Id: <20220216222807.21681-1-dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.16.2 have been released. This is a bugfix release.

Changelog:

* mkfs: fix detection of profile type for zoned mode when creating DUP
* build:
  * add missing stub for zoned mode helper when zoned mode not enabled
  * fix 64bit types on MIPS and PowerPC
  * improved zoned mode support autodetection, for systems with existing
    blkzone.h header but missing support for zone capacity
* other:
  * doc updates
  * test updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

David Sterba (6):
      btrfs-progs: build: add stub definition for non-zoned build
      btrfs-progs: build: improve autodetection of zoned mode
      btrfs-progs: tests: add more configure options for build tests
      btrfs-progs: tests: drop 32-on-64bit build support
      btrfs-progs: update CHANGES for 5.16.2
      Btrfs progs v5.16.2

Howard (1):
      btrfs-progs: subvolume snapshot: added clarity how snapshot path is interprted

Johannes Thumshirn (1):
      btrfs-progs: pass in block-group type to zoned_profile_supported

Josef Bacik (1):
      btrfs-progs: sanity check global roots key.offset

Philip Guyton (1):
      btrfs-progs: docs: update remaining non-zero dev stats -s option to -c

Rosen Penev (1):
      btrfs-progs: fix 64-bit mips and powerpc types

dathide (1):
      btrfs-progs: docs: remove incorrect statement about mkfs runtime features

jtagcat (1):
      btrfs-progs: docs: clarify zstd level mapping
