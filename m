Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F7054F83E
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 15:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbiFQNPY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 09:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiFQNPX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 09:15:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B590F56C1E
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 06:15:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 748D21FDE5;
        Fri, 17 Jun 2022 13:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655471719;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M1cibVtK6vl2ZLasD1YyF361aJqsIt55qbMSjZlF4ds=;
        b=y48ABaUwS2fIdRFSzT8V5cBA/0GhcHKGrvZLoY5hvGtLLuVEu3Ct2FKrAui7O9JXpbO8Di
        bfdy02u3+7Dxg0EMyem6xKHoqNdAp3YgY3iVKRujcQL4mul4YYWFdNKFcoIohPwjz4Bui5
        05woee9xHYMx6TR04zVcf9fEoxfRMyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655471719;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M1cibVtK6vl2ZLasD1YyF361aJqsIt55qbMSjZlF4ds=;
        b=97qCXJ6dJjbSEc+yhMo2RGhcXq5tnrI/COYtOqbFRmz7GX4zdG4vh2rkcuBdlh+Y6/OgE/
        qLr0oIc+eEHaCUAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52A5913458;
        Fri, 17 Jun 2022 13:15:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wqooE2d+rGJFDwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 17 Jun 2022 13:15:19 +0000
Date:   Fri, 17 Jun 2022 15:10:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/9] btrfs: lift start and end parameters to callers of
 insert_state
Message-ID: <20220617131044.GG20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1654706034.git.dsterba@suse.com>
 <1be84acd258f46425c4162fe3b34173be2512c20.1654706034.git.dsterba@suse.com>
 <3cb455cd-cf0f-1fc5-7e9f-cf60ba245989@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3cb455cd-cf0f-1fc5-7e9f-cf60ba245989@suse.com>
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

On Wed, Jun 15, 2022 at 05:17:13PM +0300, Nikolay Borisov wrote:
> 
> 
> On 8.06.22 г. 19:43 ч., David Sterba wrote:
> > Let callers of insert_state to set up the extent state to allow further
> > simplifications of the parameters.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   fs/btrfs/extent_io.c | 33 +++++++++++++++------------------
> >   1 file changed, 15 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 429096fc8899..1411286e5ef2 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -524,21 +524,14 @@ static void set_state_bits(struct extent_io_tree *tree,
> >    * probably isn't what you want to call (see set/clear_extent_bit).
> >    */
> >   static int insert_state(struct extent_io_tree *tree,
> > -			struct extent_state *state, u64 start, u64 end,
> > +			struct extent_state *state,
> >   			struct rb_node ***node_in,
> >   			struct rb_node **parent_in,
> >   			u32 *bits, struct extent_changeset *changeset)
> >   {
> >   	struct rb_node **node;
> >   	struct rb_node *parent;
> > -
> > -	if (end < start) {
> > -		btrfs_err(tree->fs_info,
> > -			"insert state: end < start %llu %llu", end, start);
> > -		WARN_ON(1);
> > -	}
> > -	state->start = start;
> > -	state->end = end;
> > +	const u64 end = state->end;
> 
> Why do you need an explicit end when it's only used in the while loop 
> and any possible changes actually come afterwards in case it's merged?

I think it's to minimize changes in the rest of the funciton, but you're
right that end === state->end. Although caching the value in local
variable could be a performance optimization for the tree search, I've
compared both versions, the value is in a register in both and the
non-cached also drops the stack allocation. So, I'll use state->end.
