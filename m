Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A68239F8BD
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jun 2021 16:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbhFHORL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Jun 2021 10:17:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42012 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbhFHORL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Jun 2021 10:17:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 44F64219C2;
        Tue,  8 Jun 2021 14:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623161717;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fNneOMji3fVSsopTxsNXHqXefzeyBsUEJ1N5GuoNAqM=;
        b=auC3N3CzUBQFpkVRU9Z6XAzFVcDscsX+w6TsY1udv1azVotpS2P0tZOTYTrDBnzrT6SU3g
        VehIk/xzN0R1PiiTsKJ0rwxKD8gct627vtkYX103ilW6Y3+B56+tHiF1umHvZybeIwtWb+
        cPDbNWaAbk3FlYqFZ9AT5q61uAzwrNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623161717;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fNneOMji3fVSsopTxsNXHqXefzeyBsUEJ1N5GuoNAqM=;
        b=mQqphZRbFphCbunAXvv4OgfmeTzjBk866aBGpJvufqLFVuJhNvM+PTTWV1sN1xCI0ztHtd
        JcynkMQUzO+LihDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2082CA3B84;
        Tue,  8 Jun 2021 14:15:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9744FDAF61; Tue,  8 Jun 2021 16:12:33 +0200 (CEST)
Date:   Tue, 8 Jun 2021 16:12:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Baokun Li <libaokun1@huawei.com>, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, weiyongjun1@huawei.com,
        yuehaibing@huawei.com, yangjihong1@huawei.com, yukuai3@huawei.com,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] btrfs: send: use list_move_tail instead of
 list_del/list_add_tail
Message-ID: <20210608141233.GQ31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Baokun Li <libaokun1@huawei.com>, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, weiyongjun1@huawei.com,
        yuehaibing@huawei.com, yangjihong1@huawei.com, yukuai3@huawei.com,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
References: <20210608031220.2822257-1-libaokun1@huawei.com>
 <e860684e-959b-d126-bb1d-3214878ab995@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e860684e-959b-d126-bb1d-3214878ab995@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 08, 2021 at 01:16:21PM +0800, Anand Jain wrote:
> On 8/6/21 11:12 am, Baokun Li wrote:
> > Using list_move_tail() instead of list_del() + list_add_tail().
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > ---
> >   fs/btrfs/send.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > index bd69db72acc5..a0e51b2416a1 100644
> > --- a/fs/btrfs/send.c
> > +++ b/fs/btrfs/send.c
> > @@ -2083,8 +2083,7 @@ static struct name_cache_entry *name_cache_search(struct send_ctx *sctx,
> >    */
> >   static void name_cache_used(struct send_ctx *sctx, struct name_cache_entry *nce)
> >   {
> > -	list_del(&nce->list);
> > -	list_add_tail(&nce->list, &sctx->name_cache_list);
> > +	list_move_tail(&nce->list, &sctx->name_cache_list);
> >   }
> 
> 
>   Looks good.
>   You can consider open-code name_cache_used() as there is only one user.

Yeah sounds like a good idea, with part of the function comment next to
the list_move_tail.
