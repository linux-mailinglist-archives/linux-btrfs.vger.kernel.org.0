Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C3250589E
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 16:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbiDROKv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 10:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344194AbiDROJT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 10:09:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091BF36B79
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 06:10:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D8A11F381
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 13:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650287430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2PQ8e/0Oipr/MCA2ACgIux4IHLhqSDcEcMDoig8fCpw=;
        b=f3dBVNtSgkqKrjTC4EAnhiAQVUOW2+vUoyNfndtfEtbh2I87os6Avnf3pxdxlrYpiUfFvK
        DLmfa6Kr7x4rWaDdf9uJQNkBkaxsv4GMtH1Ixz6bqniETc7CThT4/n1lAOVUPyiARQPcuU
        Iz5aF0qnzmpACIXCnhoUf08GvAzaJ4c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C9D213ACB
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 13:10:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nSOVMERjXWKBMAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 13:10:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: bug fixes exposed during delayed chunk items insertion
Date:   Mon, 18 Apr 2022 21:10:06 +0800
Message-Id: <cover.1650287150.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm recently working on a prototype on seed device sprout at mkfs time,
and one core feature for it is delayed chunk item insertion.

Currently the delayed chunk item insertion is done, and mkfs sprout
prototype is pretty close to finish.

But during the development, I exposed some bugs in error handling path,
especially the 2nd one is exposed during testing, and it's there for a
while, affecting existing code base.

Currently my delayed chunk item insertion can survive all mkfs and fsck
tests, so I don't expect more bugs exposed, thus it's time for the pure
bug fixes first.

Qu Wenruo (2):
  btrfs-progs: fix a memory leak when starting a transaction on fs with
    error
  btrfs-progs: fix an error path which can lead to empty device list

 kernel-shared/transaction.c |  6 ++++--
 kernel-shared/volumes.c     | 15 +++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

-- 
2.35.1

