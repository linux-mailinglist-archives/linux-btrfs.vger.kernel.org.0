Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E27617DE7
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 14:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiKCN3D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 09:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiKCN3C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 09:29:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B612D647C
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 06:29:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7722B1F8AC;
        Thu,  3 Nov 2022 13:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667482140;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8nHHy/8jIdKCxaZErAxLgy318cls6Q1pnWGciN7lwzg=;
        b=vpmA9tLRGu7IyogsDqo0I85mukz++xbfmztHuKrU0XFqixtunXksgVFmH23Um4wX6ZYX4/
        j1dgmFMmJyHPa2EkAwUjsXMXKS6MHJ5U5Y5nx9OMFA4RFvj5kdK4b3MtncndlK6c/Gzf3p
        vi9zHc8uHakDvh3SGqIjLhdPLA4VmiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667482140;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8nHHy/8jIdKCxaZErAxLgy318cls6Q1pnWGciN7lwzg=;
        b=QgjRTuv/vTeqsN9yrZJ5dhDsSoNkBGwAgU6Sq4YLi1HtW4bsx5o8MsmQ0dHmgC8uYfj3/A
        h1G7sYzPQF4lsDCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FF2C13480;
        Thu,  3 Nov 2022 13:29:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jx3gERzCY2PLXQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 03 Nov 2022 13:29:00 +0000
Date:   Thu, 3 Nov 2022 14:28:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/40] btrfs: simplify btree_submit_bio_start and
 btrfs_submit_bio_start parameters
Message-ID: <20221103132841.GN5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1667331828.git.dsterba@suse.com>
 <5f4b7a11669006529515316bececcddbdf513534.1667331828.git.dsterba@suse.com>
 <97d1de75-62ec-dcf8-2d0d-e783a07a24fd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97d1de75-62ec-dcf8-2d0d-e783a07a24fd@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 02, 2022 at 08:12:06AM +0800, Anand Jain wrote:
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 962e39b4f7cb..2a61b610e02b 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -2550,8 +2550,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
> >    * At IO completion time the cums attached on the ordered extent record
> >    * are inserted into the btree
> >    */
> > -blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
> > -				    u64 dio_file_offset)
> 
> > +blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio);
>   Remove the semicolon at the end of the function declaration.

Right, thanks. It gets removed in the next patch so the whole series
compiles, I don't think it needs to be resent.
