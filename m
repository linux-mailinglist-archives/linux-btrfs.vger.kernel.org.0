Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E051955947E
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 10:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiFXIB2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 04:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiFXIB2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 04:01:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608706B8C1
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 01:01:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1B1F61F8D1;
        Fri, 24 Jun 2022 08:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656057686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=B+5xL5CVtEyyR2TAuLr6QfoLSMKaymOKnyl73DEF/2E=;
        b=OrkxPGT+n5Ifs0GXGuaaZhQm7jx3cdTxJZV7x7smFrvhgOTUpeEX/ZEvQ30+MO0+hDKRGO
        PTRdoi5yKYaEaV8LLm+iL97fydAYaE2XjyPT7onoNF8+eRHkDje/XM7jmOylFAwKmvgpRv
        6Y6tm7Jd+V2JQMQGhlwiGTQFzTuC8oU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D411713ACA;
        Fri, 24 Jun 2022 08:01:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f+D+MFVvtWLmXAAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 24 Jun 2022 08:01:25 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/2] Cleanup 2 sysfs flags
Date:   Fri, 24 Jun 2022 11:01:21 +0300
Message-Id: <20220624080123.1521917-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
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

This series removes MIXED_BACKREF/BIG_METADATA sysfs files. While discussing
flags with David it transpired that those 2 have been merged for quite some time
and practically all modern (created in the last 9 years) filesystem will have
them set. They are not opt-in so let's use this fact to simplify our list of
sysfs flags.

Nikolay Borisov (2):
  btrfs: remove MIXED_BACKREF sysfs file
  btrfs: remove BIG_METADATA syfs file

 fs/btrfs/sysfs.c | 4 ----
 1 file changed, 4 deletions(-)

--
2.25.1

