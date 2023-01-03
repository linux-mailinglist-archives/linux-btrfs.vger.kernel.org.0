Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAECE65C35B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 16:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjACPyg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Jan 2023 10:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjACPyQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Jan 2023 10:54:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE5FA44B
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Jan 2023 07:54:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5E93C340AB;
        Tue,  3 Jan 2023 15:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672761253;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Puw+UzvFBvJPq+ow7IJ0pnGNr8GEYyc6Ibb3wUgEAsA=;
        b=f3xKsq/Im0pi5YP3OaGtRHja/pH92kYK24tXH7QXMhil+Jcp8OTMXmtYDukyvoRvRBLkDX
        kABbEgMdUcQc+AWMNZdeP4t3wlyj9E2jcS4CFyKGGF7DmcBMJ05IUUpmLTmjtdXkyOuORQ
        sZclTEhSUnU0zJFhybxVqIYbKnSSDB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672761253;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Puw+UzvFBvJPq+ow7IJ0pnGNr8GEYyc6Ibb3wUgEAsA=;
        b=y5UOhJjYS1Vj7pZAbo1AYSY8rVp3YkXgYeVQfwGJeOE95eE7AA8iVua6ii51f+rnumMCAf
        //o8SnMKL5dLz2Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21E361390C;
        Tue,  3 Jan 2023 15:54:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5oBdB6VPtGOneQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 03 Jan 2023 15:54:13 +0000
Date:   Tue, 3 Jan 2023 16:48:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Siddhartha Menon <siddharthamenon@outlook.com>,
        linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Subject: Re: [PATCH 1/2] Check return value of unpin_exten_cache
Message-ID: <20230103154842.GP11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <PAXP193MB2089D68F6B6E11464FB202FFA7F19@PAXP193MB2089.EURP193.PROD.OUTLOOK.COM>
 <a4f17a96-5441-b894-96ef-ae05816dfebe@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4f17a96-5441-b894-96ef-ae05816dfebe@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 01, 2023 at 08:00:10AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/1/1 02:47, Siddhartha Menon wrote:
> > Signed-off-by: Siddhartha Menon <siddharthamenon@outlook.com>
> > ---
> >   fs/btrfs/inode.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 8bcad9940154..cb95d47e4d02 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -3331,7 +3331,7 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
> >   						ordered_extent->disk_num_bytes);
> >   		}
> >   	}
> > -	unpin_extent_cache(&inode->extent_tree, ordered_extent->file_offset,
> > +	ret = unpin_extent_cache(&inode->extent_tree, ordered_extent->file_offset,
> >   			   ordered_extent->num_bytes, trans->transid);
> 
> Unfortunately this makes no difference, and in fact it's making the code 
> much worse.

The return value should be there but not all errors are handled.

> That function unpin_extent_cache() won't return anything other than 0.

The errors after lookup_extent_mapping should be handled and not just
WARN_ON.
