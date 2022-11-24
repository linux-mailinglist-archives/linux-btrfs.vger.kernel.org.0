Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBAE637DBF
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Nov 2022 17:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKXQv1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Nov 2022 11:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiKXQvZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Nov 2022 11:51:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B0E172909
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Nov 2022 08:51:24 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C8EE61F45B
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Nov 2022 16:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669308682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dqtY1LhdjekKYtgx5T3aaWsMvkzRWgD5+UnwyrL9okI=;
        b=kpDgpenzE2Vos/BAz8USrT/7vckvuGozJpV6BXZSslY4i+bGWIrkqceRzTWRHclO8hW4pP
        m/ax8gTNxEVQWSLSdhb1bJ0Bj8Cg0U7+ULLhKH3GWIoI+KdF/hCZy4G31WN0flNL1vIuzE
        UStPbtQ+OVdW5dEZ2hySZqJIfkydAmo=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C0F922C141
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Nov 2022 16:51:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B26D8DA85E; Thu, 24 Nov 2022 17:50:52 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.0.2
Date:   Thu, 24 Nov 2022 17:50:52 +0100
Message-Id: <20221124165052.24789-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 6.0.2 have been released. This is a bugfix release.

Changelog:
   * fixes:
      * resize cancel did not work in some cases
      * fix fileattr stream command format and add workaround when it cannot be applied
      * properly handle degraded raid56 reads
      * fi defrag: fix verbosity, don't print file names by default
      * receive: fix silent data loss after fall back from encoded write
   * fi mkswapfile: new command to create a formatted swapfile in one go

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

David Sterba (6):
      btrfs-progs: filesystem: new subcommand mkswapfile
      btrfs-progs: completion: add recently added commands
      Revert "btrfs-progs: resize: return error value from check_resize_args()"
      btrfs-progs: defrag: fix verbosity with default level
      btrfs-progs: update CHANGES for 6.0.2
      Btrfs progs v6.0.2

Filipe Manana (5):
      btrfs-progs: receive: fix parsing of attributes field from the fileattr command
      btrfs-progs: receive: work around failure of fileattr commands
      btrfs-progs: receive: add debug messages when processing encoded writes
      btrfs-progs: receive: add debug messages when processing fallocate
      btrfs-progs: receive: fix silent data loss after fall back from encoded write

Qu Wenruo (2):
      btrfs-progs: properly handle degraded raid56 reads
      btrfs-progs: tests: add test case for degraded raid5

