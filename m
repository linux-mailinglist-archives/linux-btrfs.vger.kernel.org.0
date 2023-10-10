Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE6E7C45B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Oct 2023 01:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344232AbjJJXuK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 19:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344212AbjJJXuJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 19:50:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B4A9D
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 16:50:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1EDB81F6E6
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 23:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696981804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6ymlOvIHjDgb9xAOQlD7b18TMcga+ymDCN0MurfZRoE=;
        b=qh71sW7AVQ1EolPxx1nzUByDMuYmD1fR+HX2fITpNL6meADNf5ll+tsjM94BC+D022qMbN
        fv6nzhnzpTPS/YCzUs/ZDpbCDlmX7isnQE8eN9ziVlSh+3K4+4rbyZtK8dYaNL2DfEXz5M
        6gnnndBdwgVhdXjgwCuGW+z1WMUEQyI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EA5E1348E
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 23:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vib6LyrjJWXySwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 23:50:02 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs-progs: make sure "mkfs --rootdir" copies all the attributes for the rootdir
Date:   Wed, 11 Oct 2023 10:19:42 +1030
Message-ID: <cover.1696981203.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[CHANGELOG]
v2:
- Add more attributes to be copied for rootdir, including:
  * mode
  * uid
  * gid
  * timestamps

- Update the test case
  * Use two loopback devices
    One to store the source directory, so that we're ensured to have
    xattr support.
  * Add checks for all the uid/gid/mode attributes

We got a bug report that "mkfs.btrfs --rootdir" copies all the xattr but
the xattr of the source directory.

It turns out that we only do the regular xattr/gid/uid/mode/timestamps
copy for all the child inodes, not the source directory itself.

Fix it and create a test case for it.

Qu Wenruo (2):
  btrfs-progs: mkfs/rootdir: copy missing attributes for the rootdir
    inode
  btrfs-progs: tests/mkfs: make sure rootdir inode got its attributes
    copied

 mkfs/rootdir.c                             | 88 ++++++++++++++++------
 tests/mkfs-tests/027-rootdir-inode/test.sh | 60 +++++++++++++++
 2 files changed, 127 insertions(+), 21 deletions(-)
 create mode 100755 tests/mkfs-tests/027-rootdir-inode/test.sh

--
2.42.0

