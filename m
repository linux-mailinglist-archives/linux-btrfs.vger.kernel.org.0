Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCF5731806
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jun 2023 14:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbjFOMBd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jun 2023 08:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244403AbjFOMBJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jun 2023 08:01:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F227DA3
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jun 2023 04:56:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 744D01FE0C
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jun 2023 11:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686830172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zVHx/np3JGWTujEibxc/YSiOJVv636y/9jPj8ZgQBJ8=;
        b=G6IC8+bjNSkZxHjNSkmDpX08s4fXKzPBdh/yhOL4pfKRH62O0ZX9dKKFDJ1MtDwQCXsTSB
        9jbyzMXrVYtBzST5fEqabkUUsKJQS9Qj3FwWkvfg7ZZfK3EWsnBuZEb4iMSHu9QTCuFj4R
        shQZc3a3xERAfl9eDw+XnVNHfMZdwKc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6438D2C141
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jun 2023 11:56:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4E896DA7D7; Thu, 15 Jun 2023 13:49:53 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.3.2
Date:   Thu, 15 Jun 2023 13:49:53 +0200
Message-Id: <20230615114953.14715-1-dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
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

btrfs-progs version 6.3.2 have been released. This is a bugfix release.

Changelog:

   * build: fix mkfs on big endian hosts
   * mkfs: don't print changed defaults notice with --quiet
   * scrub: fix wrong stats of processed bytes in background and foreground mode
   * convert: actually create free-space-tree instead of v1 space cache
   * print-tree: recognize and print CHANGING_FSID_V2 flag (for the
     metadata_uuid change in progress)
   * other:
      * documentation updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
