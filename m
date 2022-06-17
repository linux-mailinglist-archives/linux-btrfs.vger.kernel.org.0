Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE7354F8E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 16:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382619AbiFQOGM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 10:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382548AbiFQOGL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 10:06:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC194D63B
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 07:06:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8AD7921D04;
        Fri, 17 Jun 2022 14:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655474768;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BZs4QO7br+CGPlF71rD1hGjobR57X+eMHbMgl/HxvCE=;
        b=fRoQOj3wykeDXib/kc2i0k+J6gURPYKZxRT5H0jsL4cnqo+bc28rimjqGETx6cZkXAEKvG
        eFz0Ct5K8edf57fdGSj6v5jH5BhtJ+Jcu/oqdhIkLXj2sxZnvaKSCQvbpcuw2E+blCGAnF
        xyPOG9GlNIL8I/ZSvHSNx2UQzMFVJ60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655474768;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BZs4QO7br+CGPlF71rD1hGjobR57X+eMHbMgl/HxvCE=;
        b=yVmE2YYc1x0b9u7Dem0Fd2ymnzSjDR+XDmdEB9c+rkR++XIVMljvsK2ZM+PcQuCrSFyTUg
        y+4/hnQP1Vg47EDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 650FD13458;
        Fri, 17 Jun 2022 14:06:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FBzEF1CKrGLmJQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 17 Jun 2022 14:06:08 +0000
Date:   Fri, 17 Jun 2022 16:01:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 9/9] btrfs: unify tree search helper returning prev and
 next nodes
Message-ID: <20220617140133.GI20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1654706034.git.dsterba@suse.com>
 <62221b54b299b54442187a9675e9a9532b6e4cbd.1654706034.git.dsterba@suse.com>
 <a76b424b-86f5-3af7-73b0-fd22f5dc4854@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a76b424b-86f5-3af7-73b0-fd22f5dc4854@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 16, 2022 at 12:51:50PM +0300, Nikolay Borisov wrote:
> 
> 
> On 8.06.22 г. 19:43 ч., David Sterba wrote:
> > Simplify helper to return only next and prev pointers, we don't need all
> > the node/parent/prev/next pointers of __etree_search as there are now
> > other specialized helpers. Rename parameters so they follow the naming.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   fs/btrfs/extent_io.c | 113 ++++++++++++++++++++++---------------------
> >   1 file changed, 57 insertions(+), 56 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index ae27b7a5e56c..48c5432a7c8f 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -374,9 +374,7 @@ void free_extent_state(struct extent_state *state)
> >    *
> >    * @tree:       the tree to search
> >    * @offset:     offset that should fall within an entry in @tree
> > - * @next_ret:   pointer to the first entry whose range ends after @offset
> > - * @prev_ret:   pointer to the first entry whose range begins before @offset
> > - * @p_ret:      pointer where new node should be anchored (used when inserting an
> > + * @node_ret:   pointer where new node should be anchored (used when inserting an
> >    *	        entry in the tree)
> >    * @parent_ret: points to entry which would have been the parent of the entry,
> >    *               containing @offset
> > @@ -386,69 +384,76 @@ void free_extent_state(struct extent_state *state)
> >    * pointer arguments to the function are filled, otherwise the found entry is
> >    * returned and other pointers are left untouched.
> >    */
> 
> The comment should be changed as it's no longer valid. Currently it states:
> 
> If no such entry exists, then NULL is returned and the other
> pointer arguments to the function are filled, otherwise the found entry 
> is returned and other pointers are left untouched.
> 
> When no such entry exists, the other pointer arguments to the function 
> are indeed filled, however the function now returns the first entry that 
> ends _before_ the offset i.e this function can never return NULL.
> 
> So it return either the entry which contains 'offset' or the last entry 
> before offset.

Updated to:

+  * Return a pointer to the entry that contains @offset byte address and don't change
+  * @node_ret and @parent_ret.
+  *
+  * If no such entry exists, return pointer to entry that ends before @offset
+  * and fill parameters @node_ret and @parent_ret, ie. does not return NULL.
