Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC46C7128C5
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 16:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243886AbjEZOn1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 10:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244024AbjEZOnY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 10:43:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469F0E5B;
        Fri, 26 May 2023 07:42:51 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 55FD121AC4;
        Fri, 26 May 2023 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685112083;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eeU2Ed9/38MVS07hDa6KW2/dvvNF/NLXETrwK8cMJJY=;
        b=pYz2bNjIRBrFrw0E4gVKpXSy3jid1MNAV2Nh7nY8Yz7KEJIWD8F6FlYZjcytjgizewqEPK
        SzvMESFTub3slSTzdygbAvbHWata0Qr4hRuPOCFB4ngscqPVpI8MptKet7lqmVzSpBvYYW
        AWE/Nqo/nxgRWdlP7g9RhinjBtXDMLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685112083;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eeU2Ed9/38MVS07hDa6KW2/dvvNF/NLXETrwK8cMJJY=;
        b=H5H7E93nlvh/n/Zn7/Pv0c8GlALhBmjUOZxIGLdAp9MWrxm5bG7XqNbBTabi96DwI3UlMX
        2ryoBretMWI8uDDA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1DBD913684;
        Fri, 26 May 2023 14:41:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id VukTBhPFcGSqfAAAGKfGzw
        (envelope-from <dsterba@suse.cz>); Fri, 26 May 2023 14:41:23 +0000
Date:   Fri, 26 May 2023 16:35:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>, pengfuyuan <pengfuyuan@kylinos.cn>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        pengfuyuan <pengfuyuan@kylinos.cn>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix csum_tree_block to avoid tripping on
 -Werror=array-bounds
Message-ID: <20230526143514.GA575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230523070956.674019-1-pengfuyuan@kylinos.cn>
 <a79a7e9d-f6b5-00c8-65c8-f914cf0be0b2@gmx.com>
 <20230523193212.GA32559@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523193212.GA32559@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 23, 2023 at 09:32:12PM +0200, David Sterba wrote:
> On Tue, May 23, 2023 at 03:33:22PM +0800, Qu Wenruo wrote:
> > On 2023/5/23 15:09, pengfuyuan wrote:
> > Although even with such change, I'm still not sure if it's any better or
> > worse, as most of the calculation can still be bulky.
> 
> Yeah I think the calculations would have to be conditional or keeping
> some state. I'd like to keep the structure of the first page and the
> rest.
> 
> Possible ways is to add extra condition
> 
> 	for (i = 1; i < num_pages && i < INLINE_EXTENT_BUFFER_PAGES; i++)

The final version is

	for (i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++)

ie. 'INLINE_EXTENT_BUFFER_PAGES > 1' can be evaluated at compile time
and result in removing the for loop completely.

Pengfuyuan, can you please do a build test that it does not report the
warning anymore? The diff is:

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -88,7 +88,6 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
        const int first_page_part = min_t(u32, PAGE_SIZE, fs_info->nodesize);
        SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
        char *kaddr;
-       int i;
 
        shash->tfm = fs_info->csum_shash;
        crypto_shash_init(shash);
@@ -96,7 +95,7 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
        crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
                            first_page_part - BTRFS_CSUM_SIZE);
 
-       for (i = 1; i < num_pages; i++) {
+       for (int i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++) {
                kaddr = page_address(buf->pages[i]);
                crypto_shash_update(shash, kaddr, PAGE_SIZE);
        }
---

Thanks.
