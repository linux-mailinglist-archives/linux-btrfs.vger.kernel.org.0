Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803CE753E9D
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 17:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbjGNPRr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 11:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbjGNPRq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 11:17:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804CC1BD4
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 08:17:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 42F5E220C3
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 15:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689347864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=3wuF9bAx8hX6s5r5wVko0LuySvZyQk4HakmL7YtlCqc=;
        b=qOIACrYnEwt33at2a6+Xn4Z0uWcr8+vnMXMAExYS12s7ddHVr8rNJKoQIwIvlxnT4p4sL+
        KLCoKDtPnz/pG0WvvpFe8dozlKiDouNFE45ePnxmov5clTZuQyhJ+wQqvNl2OSJk+0t38U
        vJBiOyP9NjCG1loPbtq4tSJBOi+gnaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689347864;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=3wuF9bAx8hX6s5r5wVko0LuySvZyQk4HakmL7YtlCqc=;
        b=c+TeSejnekrKfvzstXrTjMtNhJ+CXyYOoNau9DOvVXW6JKqT85LsK8cMu/ggICBghuQdIc
        BBiLfEmvEV4NONAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5CB413A15
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 15:17:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GAR0LxdnsWQtNgAAMHmgww
        (envelope-from <rgoldwyn@suse.de>)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 15:17:43 +0000
Date:   Fri, 14 Jul 2023 10:18:19 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove duplicate free_async_extent_pages() on
 reservation error
Message-ID: <p6swvbl7oht2xiz7nrw3iexpa5ytuqdhbwneqm3phcm5igejd3@ao2eyoslwbdj>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While performing compressed writes, if the extent reservation fails, the
async extent pages are first free'd in the error check for return value
ret, and then again at "goto out_free".

Remove the first call to free_async_extent_pages().

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index dbbb67293e34..cb742242ce26 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1217,7 +1217,6 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 				   async_extent->compressed_size,
 				   0, *alloc_hint, &ins, 1, 1);
 	if (ret) {
-		free_async_extent_pages(async_extent);
 		/*
 		 * Here we used to try again by going back to non-compressed
 		 * path for ENOSPC.  But we can't reserve space even for

-- 
Goldwyn
