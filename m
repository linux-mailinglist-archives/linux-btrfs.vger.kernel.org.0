Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02F16C9064
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Mar 2023 20:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjCYTSb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Mar 2023 15:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCYTSa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Mar 2023 15:18:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F289272B
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Mar 2023 12:18:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DBCE822CFF
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Mar 2023 19:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679771907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=N9DGoUDuxkoMuob7JG63v0g8El6GIZL1gFVF18vYBtE=;
        b=NDf3eHgUi6ZpUYzP4E4A5VDiTVV06nCXxljVwf8rIY+PtXDi6ujVBZjDyFSNBxyHkyKH/w
        dCnTcKBQh0LsiwUuw9zB9Lu47BSCrKryuDOmfchVkL2CYHSvZnKjUkSywvhpQ5dHZl68Ah
        /T+xieou+9Bq5NlnpTr3QXQgcJqTmSs=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CFEED2C141
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Mar 2023 19:18:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9DFFEDA7DE; Sat, 25 Mar 2023 20:12:16 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.2.2
Date:   Sat, 25 Mar 2023 20:12:16 +0100
Message-Id: <20230325191216.23500-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 6.2.2 have been released. This is a bugfix release.

Changelog:
   * fix build on old x86 architectures with builtin crypto
   * device stats: fix printing wrong values in tabular output
   * qgroup show: fix qgroup id formatting in json output
   * restore: fix restoring xattrs on directories
   * restore: don't modify metadata in dry-run mode
   * balance: fix some cases wrongly parsed as old syntax
   * balance: warn when deprecated syntax is used
   * seeding: fall back to old way if sysfs device fsid is not available
   * convert: handle orphan file ext4 feature
   * other:
      * sync ioctl definitions
      * enable github CI
      * update documentation

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
