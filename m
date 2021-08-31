Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E283FC679
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 13:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhHaLOj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 07:14:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42470 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241709AbhHaLOi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 07:14:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 78D991FD38;
        Tue, 31 Aug 2021 11:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630408422;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PjCZNSPjckHqcOZT7BRsq47UCFQQasJD8vE1VJ4chZ4=;
        b=Wn2jZHnO9lBWsSQ1Iirs2ZGJwRj2saZQebPCt/pN5ug3qu95NbUxUsUIoICxU72hJjBIMe
        54bf8HYkt+WA5VqZbcNh4PMvA9U2KsbpvNjYGGrmxC+tjia1l3qAqCXtZ7sGUxhWVpcMnK
        nHgzdIiJLkYtkVUV0jTlAS1EBptYKPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630408422;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PjCZNSPjckHqcOZT7BRsq47UCFQQasJD8vE1VJ4chZ4=;
        b=hFlsF/EHkPTHrCjXhIjaN4RG6CS8E5tH5Ef14rWgiqepY+dXD+LnIrew8XEfh8u8zu+v88
        YhJQlDeuhZfcrgBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6F697A3B99;
        Tue, 31 Aug 2021 11:13:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BA919DA733; Tue, 31 Aug 2021 13:10:51 +0200 (CEST)
Date:   Tue, 31 Aug 2021 13:10:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 5/8] btrfs: inode: use btrfs_for_each_slot in
 btrfs_read_readdir
Message-ID: <20210831111051.GH3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20210826164054.14993-1-mpdesouza@suse.com>
 <20210826164054.14993-6-mpdesouza@suse.com>
 <f9647be1-25a9-e29b-4524-9b5ebf752567@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9647be1-25a9-e29b-4524-9b5ebf752567@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 30, 2021 at 04:05:28PM +0300, Nikolay Borisov wrote:
> > @@ -6137,35 +6136,19 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
> >  	key.offset = ctx->pos;
> >  	key.objectid = btrfs_ino(BTRFS_I(inode));
> >  
> > -	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> > -	if (ret < 0)
> > -		goto err;
> > -
> > -	while (1) {
> > +	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
> 
> I don't think it's necessary to use iter_ret, instead you can use ret
> directly. Because if either btrfs_search_slot return an error or
> btrfs_valid_slot then ret would be set to the respective return value
> and the body of the loop won't be executed at all, no?

Yeah thre's no reason to add another variable in this case. As long as
the loop body does not use ret internally, then reusing ret is fine.

The point of having an explicit return value for the iterator is to be
able to read the reason of failure after the iterator scope ends, so it
can't be defined inside. We'd need to be careful to make sure that the
iterator 'ret' is never used inside the body so that could be also
useful to put to the documentation. I think a coccinelle script can be
also useful to catch such things.
