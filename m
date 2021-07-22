Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629033D2CD0
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 21:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhGVSxi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 14:53:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37836 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhGVSxi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 14:53:38 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 661C51FF0C;
        Thu, 22 Jul 2021 19:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626982452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6cn6lQbVmHhnZkx84PaevJhuBImAxax88iMg/MHRT3A=;
        b=qgMVjegBpeFmWF0ZFCqrh4I2EiQrOiuIhrPDXkqwLDwUZpY5I7FIb0x7eAWNtf/BIKp6fy
        D2zYGok8u04DBkSr3XUvAhDncTVsD8nMKng8IQLKA5eCMwxiMgoMQZSkvPJF8gDIri9/Wf
        ebWOk1PnVPwwyGMYle/hKHB/1TvnvZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626982452;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6cn6lQbVmHhnZkx84PaevJhuBImAxax88iMg/MHRT3A=;
        b=Q/0BzxHBSf2pAYb90oyPPZcjVHbk40niWLevveui7J8tkav3msu983Cmaeaup6Rir4/a1L
        DF6JxAkvdpp04nBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 10D3E139A1;
        Thu, 22 Jul 2021 19:34:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id qHfKNTPI+WDnTAAAGKfGzw
        (envelope-from <rgoldwyn@suse.de>); Thu, 22 Jul 2021 19:34:11 +0000
Date:   Thu, 22 Jul 2021 14:34:10 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: mark compressed range uptodate only if all bio
 succeed
Message-ID: <20210722193410.6ixnxt734ohcb625@fiona>
References: <20210709162922.udxjidc3kgxkgzx3@fiona>
 <20210722143438.GZ19710@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722143438.GZ19710@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16:34 22/07, David Sterba wrote:
> On Fri, Jul 09, 2021 at 11:29:22AM -0500, Goldwyn Rodrigues wrote:
> > In compression write endio sequence, the range which the compressed_bio
> > writes is marked as uptodate if the last bio of the compressed (sub)bios
> > is completed successfully. There could be previous bio which may
> > have failed which is recorded in cb->errors.
> > 
> > Set the writeback range as uptodate only if cb->errors is zero, as opposed
> > to checking only the last bio's status.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> >  fs/btrfs/compression.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> > index 9a023ae0f98b..30d82cdf128c 100644
> > --- a/fs/btrfs/compression.c
> > +++ b/fs/btrfs/compression.c
> > @@ -352,7 +352,7 @@ static void end_compressed_bio_write(struct bio *bio)
> >  	btrfs_record_physical_zoned(inode, cb->start, bio);
> >  	btrfs_writepage_endio_finish_ordered(BTRFS_I(inode), NULL,
> >  			cb->start, cb->start + cb->len - 1,
> > -			bio->bi_status == BLK_STS_OK);
> > +			!cb->errors);
> 
> Right, that would only test the last bio. Have been able to reproduce
> it?
> 

No, I don't have a reproducer. Just observed it while reading the code.

> Anyway, added to misc-next, thanks.

Thanks.

-- 
Goldwyn
