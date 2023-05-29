Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF0A714AAF
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 15:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjE2Nul (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 09:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjE2Nuj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 09:50:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CF2AB;
        Mon, 29 May 2023 06:50:34 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9CA7D21A86;
        Mon, 29 May 2023 13:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685368233;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R2lhbyOz4tj3CsY5Yx4Ny70+DkqTgxQOwmeHUuUYfDo=;
        b=fQDtz4rSbwEf4MtoZSYdnSRv0VTYPV7cmFUzNRCdUC0CcgD4ZIaFchwAcFt733LFSeEWeb
        l+xxisDNzJ2mZqc50gBjZ6quj9xu6GKrV9Fewy4R9ehO+2qksGRx8aa2oPpW9IIN/O1NKG
        b2sWxs1yWvMKNakCcDcg9YvFTNpgqMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685368233;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R2lhbyOz4tj3CsY5Yx4Ny70+DkqTgxQOwmeHUuUYfDo=;
        b=g2mu58CaNuTxDR4HWLVL+CA2ufha0hHuDX/EsF/SAY28GRKazScVDVIl2qHjpbkQZGOFAJ
        vH9AM0k0rvUTUnCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6953013508;
        Mon, 29 May 2023 13:50:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 3pJNGKmtdGRIZgAAGKfGzw
        (envelope-from <dsterba@suse.cz>); Mon, 29 May 2023 13:50:33 +0000
Date:   Mon, 29 May 2023 15:44:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     pengfuyuan <pengfuyuan@kylinos.cn>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix csum_tree_block to avoid tripping on
 -Werror=array-bounds
Message-ID: <20230529134423.GE575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230523070956.674019-1-pengfuyuan@kylinos.cn>
 <a79a7e9d-f6b5-00c8-65c8-f914cf0be0b2@gmx.com>
 <20230523193212.GA32559@twin.jikos.cz>
 <20230526143514.GA575@twin.jikos.cz>
 <871f146c-2fd8-4322-2288-4be90c0baf8a@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871f146c-2fd8-4322-2288-4be90c0baf8a@kylinos.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 29, 2023 at 11:28:59AM +0800, pengfuyuan wrote:
> 
> On 2023/5/26 22:35, David Sterba wrote:
> > On Tue, May 23, 2023 at 09:32:12PM +0200, David Sterba wrote:
> >> On Tue, May 23, 2023 at 03:33:22PM +0800, Qu Wenruo wrote:
> >>> On 2023/5/23 15:09, pengfuyuan wrote:
> >>> Although even with such change, I'm still not sure if it's any better or
> >>> worse, as most of the calculation can still be bulky.
> > The final version is
> >
> > 	for (i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++)
> >
> > ie. 'INLINE_EXTENT_BUFFER_PAGES > 1' can be evaluated at compile time
> > and result in removing the for loop completely.
> >
> > Pengfuyuan, can you please do a build test that it does not report the
> > warning anymore? The diff is:
> >
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -88,7 +88,6 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
> >          const int first_page_part = min_t(u32, PAGE_SIZE, fs_info->nodesize);
> >          SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
> >          char *kaddr;
> > -       int i;
> >   
> >          shash->tfm = fs_info->csum_shash;
> >          crypto_shash_init(shash);
> > @@ -96,7 +95,7 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
> >          crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
> >                              first_page_part - BTRFS_CSUM_SIZE);
> >   
> > -       for (i = 1; i < num_pages; i++) {
> > +       for (int i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++) {
> >                  kaddr = page_address(buf->pages[i]);
> >                  crypto_shash_update(shash, kaddr, PAGE_SIZE);
> >          }
> > ---
> 
> I did a build test on the mips64 architecture, the compilation passed, 
> and it no longer reported warnings.

Thanks, patch added to misc-next.
