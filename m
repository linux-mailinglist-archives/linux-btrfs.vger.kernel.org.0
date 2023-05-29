Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0262714CEA
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 17:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjE2PXH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 11:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjE2PXF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 11:23:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029A5C4
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 08:23:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0B8C31FD6B
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685373782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=LekmqNY7lDAfaY8qOXvajRtg1NEUMIgkxs69pMidhJA=;
        b=A7HDH+2pIvZNd/BWqoq8CRT1VF6OCdA2Uimjg4yl0dYdLnJNVsFtpy+h4/E1tJVo6JUEol
        oj2JP2ATvnGDJ0AItTUSkIsRd8OEWzrvMvlWnzKL6aE4/CtjaUstaoi+3NchvCA4g2o4rH
        ROIKUWeNDQbbHwhKwhIDnsSrLxfc8MY=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F37702C141
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:23:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C6BA1DA82D; Mon, 29 May 2023 17:16:52 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.3.1
Date:   Mon, 29 May 2023 17:16:52 +0200
Message-Id: <20230529151652.4916-1-dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 6.3.1 have been released. This is a bugfix release.

Changelog:

  * convert: fix checksum of a block relocated from 0-1M range
  * qgroup show: fix formatting of limit values in json output
  * receive: report paret subovl UUID on errors
  * btrfsune: new option --convert-to-free-space-tree to convert from
    block-group-tree back to extent tree for block group tracking
  * mkfs: make option --rootdir more verbose and report start when filling
    from the given directory starts
  * experimental:
    * btrfstune: checksum switch logic reimplemented, conversion of all
      metadata and data now works, resume from various states also supported
  * other:
    * more CI github actions test coverage
    * more kernel/userspace source code sync
    * warning fixes
    * code cleanups
    * documentation updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
