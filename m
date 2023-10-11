Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270137C5EAF
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Oct 2023 22:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjJKUtv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Oct 2023 16:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbjJKUtu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Oct 2023 16:49:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C5A91
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 13:49:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5EE8B2185D
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 20:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697057385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=eCaljftjYitF2sZhjZZI8FfoF+mFRr3yw/AAd7t8+iI=;
        b=hBcMqDNHYyG6EAs9yXa2aWLOSBgIePalFqJY/JzeVJh1NlpPmj18h2zPr6HQGL6+dqbzqY
        tlLvq1006CgT8gBU8IGOpzf3j6QS1+nq/Iappk7LuqdEAuw+Dt78oq5Y2DCRw//ObcF1xy
        i0TqoAZLvV3E+9Sc6Xo3G+vWeDDeAVQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91712134F5
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 20:49:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t55DFGgKJ2XCJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 20:49:44 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/2] btrfs-progs: make sure "mkfs --rootdir" copies all the attributes for the rootdir
Date:   Thu, 12 Oct 2023 07:19:24 +1030
Message-ID: <cover.1697057301.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Score: 3.90
X-Spamd-Result: default: False [3.90 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_ONE(0.00)[1];
         TO_DN_NONE(0.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[18.64%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[CHANGELOG]
v3:
- Use 'stat()' instead pf 'lstate()' for the rootdir
  This would follow a softlink for the rootdir.

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

