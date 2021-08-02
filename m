Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB473DD503
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Aug 2021 13:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhHBL7v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Aug 2021 07:59:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40934 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhHBL7u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Aug 2021 07:59:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1781621FA1;
        Mon,  2 Aug 2021 11:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627905580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lhL3499Hy8X+h78psXVZW8SgA53VqrNh7tkz5JIJ3+s=;
        b=QxnTHGE35H/FbhDp/wvHeHGoBdQVbkBWl+B8tUy6nQFCxgEO2v+b1HBYyKhWOneTx7CrkC
        gYNjlis9twMasuhEsPeSSdbphu2uq0Qn7fAfhuunovweMUqWZZZB4zmiSzkf0FX+Ig38Vr
        RHwnTW1IezzUNr/cAElGuEeJWJhRYP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627905580;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lhL3499Hy8X+h78psXVZW8SgA53VqrNh7tkz5JIJ3+s=;
        b=BBW+2mCif/NOoNeKeI9cPr8JymcQzdQiJz/Mur9ZVczJU0AFuXUhf73wLAB78/dImTQyTU
        cRhsSlbXavHM0sAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EC7213C68;
        Mon,  2 Aug 2021 11:59:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aXcqFireB2GMXgAAMHmgww
        (envelope-from <mpdesouza@suse.de>); Mon, 02 Aug 2021 11:59:38 +0000
Message-ID: <79174ed15aad71804853225a54d8acb0ff59b568.camel@suse.de>
Subject: Re: [PATCH] btrfs: send: Simplify send_create_inode_if_needed
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, fdmanana@suse.com
Date:   Mon, 02 Aug 2021 08:59:40 -0300
In-Reply-To: <ab7f7888-75f8-8145-1b7b-c77888a038b6@suse.com>
References: <20210801233549.25480-1-mpdesouza@suse.com>
         <ab7f7888-75f8-8145-1b7b-c77888a038b6@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 2021-08-02 at 10:39 +0300, Nikolay Borisov wrote:
> 
> On 2.08.21 г. 2:35, Marcos Paulo de Souza wrote:
> > The out label is being overused, we can simply return if the
> > condition
> > permits.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> > ---
> >  fs/btrfs/send.c | 15 ++++-----------
> >  1 file changed, 4 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > index 75cff564dedf..17cd67e41d3a 100644
> > --- a/fs/btrfs/send.c
> > +++ b/fs/btrfs/send.c
> > @@ -2727,19 +2727,12 @@ static int
> > send_create_inode_if_needed(struct send_ctx *sctx)
> >  	if (S_ISDIR(sctx->cur_inode_mode)) {
> >  		ret = did_create_dir(sctx, sctx->cur_ino);
> >  		if (ret < 0)
> > -			goto out;
> > -		if (ret) {
> > -			ret = 0;
> > -			goto out;
> > -		}
> > +			return ret;
> > +		if (ret > 0)
> > +			return 0;
> 
> nit: Personally I'd prefer in such cases to use an if/else if
> construct
> since which branch is taken is dependent on the same value. To me
> using
> an if/else if is a more explicit way to say "those 2 branches are
> directly related). However it's not a big deal.

Indeed, it's better. Should I send a v2 in this case or david can just
add an 'else' to the last if clause?

  Thanks

> 
> >  	}
> >  
> > -	ret = send_create_inode(sctx, sctx->cur_ino);
> > -	if (ret < 0)
> > -		goto out;
> > -
> > -out:
> > -	return ret;
> > +	return send_create_inode(sctx, sctx->cur_ino);
> >  }
> >  
> >  struct recorded_ref {
> > 

