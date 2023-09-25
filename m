Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A491E7AD990
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 15:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjIYNvZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 09:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjIYNvX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 09:51:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05841111
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 06:51:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B0EB21F45F;
        Mon, 25 Sep 2023 13:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695649875;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4+nUCDYj2Pszo8zapRw5pmI2INTBU2BT+cYnZGzPQV0=;
        b=rEub7pcA3ui+7tmVWCfJh+0bmKT5du3l8Qh4H3HCtt2Lw8SQ4wx4F4p+Qtxu+hJdTYfhI5
        4FbdT9TMJ8mnNWfgC4MbtT66XcThSV/j2GniIWO7g0mXwPQz/oaV++62DaCRQ066Iah/hz
        NQE03fvfC0ZG7wetk4YUIxIGtL3DzRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695649875;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4+nUCDYj2Pszo8zapRw5pmI2INTBU2BT+cYnZGzPQV0=;
        b=y4oZCJ4DIYdNCzknbgP/fsYZFIx3FjDVSr/Hi6OyxbwsINcCat8JqJpgb62flNXPr4+Gjy
        v+17NrtPs5c2DkDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8256B1358F;
        Mon, 25 Sep 2023 13:51:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BfryHlOQEWVdHgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Sep 2023 13:51:15 +0000
Date:   Mon, 25 Sep 2023 15:44:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/8] btrfs: relocation: use enum for stages
Message-ID: <20230925134438.GM13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695380646.git.dsterba@suse.com>
 <e20220675e8d2501f4b98bae12a105615abe634b.1695380646.git.dsterba@suse.com>
 <fb37b3db-3dfd-4bf6-8207-84d318da244a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb37b3db-3dfd-4bf6-8207-84d318da244a@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 23, 2023 at 07:59:54AM +0930, Qu Wenruo wrote:
> 
> 
> On 2023/9/22 20:37, David Sterba wrote:
> > Add an enum type for data relocation stages.
> >
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   fs/btrfs/relocation.c | 16 +++++++++-------
> >   1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > index 9ff3572a8451..3afe499f00b1 100644
> > --- a/fs/btrfs/relocation.c
> > +++ b/fs/btrfs/relocation.c
> > @@ -125,6 +125,12 @@ struct file_extent_cluster {
> >   	u64 owning_root;
> >   };
> >
> > +/* Stages of data relocation. */
> > +enum reloc_stage {
> > +	MOVE_DATA_EXTENTS,
> > +	UPDATE_DATA_PTRS
> > +};
> > +
> >   struct reloc_control {
> >   	/* block group to relocate */
> >   	struct btrfs_block_group *block_group;
> > @@ -156,16 +162,12 @@ struct reloc_control {
> >   	u64 search_start;
> >   	u64 extents_found;
> >
> > -	unsigned int stage:8;
> > +	enum reloc_stage stage;
> 
> Wouldn't this cause extra hole?

No, it's an int and after u64, the bitfields are in an int as well, so
both are aligned. The diff after the change:

@@ -7711,15 +7711,14 @@ struct reloc_control {
        u64                        reserved_bytes;       /*  1496     8 */
        u64                        search_start;         /*  1504     8 */
        u64                        extents_found;        /*  1512     8 */
-       unsigned int               stage:8;              /*  1520: 0  4 */
-       unsigned int               create_reloc_tree:1;  /*  1520: 8  4 */
-       unsigned int               merge_reloc_tree:1;   /*  1520: 9  4 */
-       unsigned int               found_file_extent:1;  /*  1520:10  4 */
+       enum reloc_stage           stage;                /*  1520     4 */
+       unsigned int               create_reloc_tree:1;  /*  1524: 0  4 */
+       unsigned int               merge_reloc_tree:1;   /*  1524: 1  4 */
+       unsigned int               found_file_extent:1;  /*  1524: 2  4 */
 
        /* size: 1528, cachelines: 24, members: 19 */
-       /* padding: 4 */
        /* paddings: 2, sum paddings: 8 */
-       /* bit_padding: 21 bits */
+       /* bit_padding: 29 bits */
        /* last cacheline: 56 bytes */
 };
---
