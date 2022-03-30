Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F934EBD64
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 11:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244668AbiC3JP7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 05:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244667AbiC3JP6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 05:15:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD8D24F3E
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 02:14:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1DFEE1F37B;
        Wed, 30 Mar 2022 09:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648631653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Rg/rcqyFlAU0lVTz3rZpbtOo/zPhvMyUsRheIYoZDoI=;
        b=BpumeNVago3C3iuiJXSPqKB8dVJKAiUSY/9isk6lJPc9Ws922vYKBOgPsyWjeIfjT1FHRf
        XKzj/DDPCiHNzwP4gva4xjIhOPxrjXfBFI4eh44KHJgmdGe5U5hDQAR9ipN3jt2vvgiLBo
        GoIs2f27eRGebc+K4KywA4O3xOk3ih4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D305613A60;
        Wed, 30 Mar 2022 09:14:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qgS0MGQfRGKiVQAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 30 Mar 2022 09:14:12 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/3] Remove balance v1 ioctl
Date:   Wed, 30 Mar 2022 12:14:04 +0300
Message-Id: <20220330091407.1319454-1-nborisov@suse.com>
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

It was slated for removal in 5.18. So here are the patches which remove the
relevant bits (patch 1 and 2). As a result of this simplification code can be
juggled around a bit so further simplify btrfs_ioctl_balance(patch 3).



Nikolay Borisov (3):
  btrfs: remove balance v1 ioctl
  btrfs: remove checks for arg argument in btrfs_ioctl_balance
  btrfs: simplify codeflow in btrfs_ioctl_balance

 fs/btrfs/ioctl.c | 69 ++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 44 deletions(-)

--
2.25.1

