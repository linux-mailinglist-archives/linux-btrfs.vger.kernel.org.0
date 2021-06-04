Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F5F39C0D0
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 21:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhFDTv6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 15:51:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34346 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhFDTv5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 15:51:57 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 584271FD47;
        Fri,  4 Jun 2021 19:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622836210;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3SEQZgIisST05mURq0rZP2MQQ/XXki6ApHx1Smt2LUQ=;
        b=fDyGyRc2wBzM7R4O4p9+r22rAYRH+AtuXG80VtWukW6ONO6D2p6K4TCAsY1ULoE2qsJwMM
        cheIOW4roc1QsjZVzmsrimuyN/eRlUoXAeDzmGEqFQJAduC/NfJi9+3ZAzzjmcQC3u6OT/
        tg5vsYKtWNSDmKxsChHeHH0C9/Opqjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622836210;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3SEQZgIisST05mURq0rZP2MQQ/XXki6ApHx1Smt2LUQ=;
        b=kte8sU9UrsWFjnVrwNs9bDZaVFDOMMY803JUm8MvYbSB8RePmgwcR/BvSP5SanF9sNz+sE
        XV7Zvd+pHNtDFNAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4F189A3B85;
        Fri,  4 Jun 2021 19:50:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 818ADDB228; Fri,  4 Jun 2021 21:47:28 +0200 (CEST)
Date:   Fri, 4 Jun 2021 21:47:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        Dave Sterba <DSterba@suse.com>
Subject: Re: [PATCH] btrfs-progs: Correct check_running_fs_exclop() return
 value
Message-ID: <20210604194728.GE31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        Dave Sterba <DSterba@suse.com>
References: <20210409155644.qkk6puelfjvtjwqs@fiona>
 <7efdb3f8-ff4e-48a1-158c-863629bcb6b6@oracle.com>
 <20210412155641.k6bmcznis77hv7ba@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412155641.k6bmcznis77hv7ba@fiona>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 12, 2021 at 10:56:41AM -0500, Goldwyn Rodrigues wrote:
> On  6:50 10/04, Anand Jain wrote:
> > On 09/04/2021 23:56, Goldwyn Rodrigues wrote:
> > > check_running_fs_exclop() can return 1 when exclop is changed to "none"
> > > The ret is set by the return value of the select() operation. Checking
> > > the exclusive op changes just the exclop variable while ret is still
> > > set to 1.
> > > 
> > > Set ret exclusively if exclop is set to BTRFS_EXCL_NONE.
> > > ---
> > 
> > SOB missing.
> 
> Yes, missed that.
> 
> > 
> > >   common/utils.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/common/utils.c b/common/utils.c
> > > index 57e41432..2e5175c3 100644
> > > --- a/common/utils.c
> > > +++ b/common/utils.c
> > > @@ -2326,6 +2326,8 @@ int check_running_fs_exclop(int fd, enum exclusive_operation start, bool enqueue
> > >   			tv.tv_sec /= 2;
> > >   			ret = select(sysfs_fd + 1, NULL, NULL, &fds, &tv);
> > >   			exclop = get_fs_exclop(fd);
> > > +			if (exclop == BTRFS_EXCL_NONE)
> > > +				ret = 0;
> > >   			continue;
> > >   		}
> > >   	}
> > > 
> > 
> > 
> > This is bit inconsistent from what is done a few lines above:
> > 
> >         exclop = get_fs_exclop(fd);
> >         if (exclop <= 0) {
> >                 ret = 0;
> >                 goto out;
> >         }
> > 
> > We return 0 for both BTRFS_EXCLOP_NONE || BTRFS_EXCLOP_UNKNOWN.
> > 
> 
> I am not sure why we are translating the sysfs file value to enums. The
> only status we are concerned about is with "none", anything besides that
> is considered to be busy, for code flow purposes. For error display, we
> can print whatever the sysfs file contains. Was this done for i18n?

No, I changed it to string to enum because this is separating the actual
input from sysfs to the internal representation of a valid state. The
original patch read the sysfs file and compared string everywhere, this
is not a good practice. i18n is not done anywhere in progs so that's not
the reason.
