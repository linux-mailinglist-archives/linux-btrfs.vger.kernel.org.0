Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152BC7DEC50
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 06:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348555AbjKBFeU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 01:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348448AbjKBFeT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 01:34:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A894128
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Nov 2023 22:34:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6C2C51F74D
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 05:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698903249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BxzI7IqphvIXEANyaJqnY7oU9eWQF8qW/z2iSjG88+U=;
        b=Q3SFEPuYw5Hm7txr9p0dOoDC/6HbsfVLeyj7E5S77YE/p1sOMB8DqTh+oP30FM8zJQQ/He
        gooBI+gRgcUyB5YWsbW4AomllhbRnWB52CmEB7dv3CNLaxbQablJMmBUAYVBso2fgyCtbA
        cZqPtYYJC8OblyTGMZTFwQb6OaIufjQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91AFD13460
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 05:34:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CpoKFNA0Q2U/AwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Nov 2023 05:34:08 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: subvolume create: accept multiple arguments
Date:   Thu,  2 Nov 2023 16:03:47 +1030
Message-ID: <cover.1698903010.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset adds the ability to accept multiple arguments for "btrfs
subvolume create" command, just like "mkdir".

And also we follow the error reporting part of "mkdir", any failure
would make the command to return 1 for error.

[PATCHSET STRUCTURE]
During the development, I found two missing error handling for strdup(),
thus here comes the first patch to fix them.

Then the 2nd patch implements the main part.

Finally the last patch is add the new test case for the error handling
part.

Qu Wenruo (3):
  btrfs-progs: subvolume create: handle failure for strdup()
  btrfs-progs: subvolume create: accept multiple arguments
  btrfs-progs: cli-tests: add test case for subvolume create multiple
    arguments

 Documentation/btrfs-subvolume.rst             |  11 +-
 cmds/subvolume.c                              | 223 ++++++++++--------
 .../021-subvolume-multiple-arguments/test.sh  |  37 +++
 3 files changed, 170 insertions(+), 101 deletions(-)
 create mode 100755 tests/cli-tests/021-subvolume-multiple-arguments/test.sh

--
2.42.0

