Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D62E35CA85
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Apr 2021 17:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241854AbhDLP4f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Apr 2021 11:56:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:33124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238498AbhDLP4e (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Apr 2021 11:56:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4E4C0AF03;
        Mon, 12 Apr 2021 15:56:15 +0000 (UTC)
Date:   Mon, 12 Apr 2021 10:56:41 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, Dave Sterba <DSterba@suse.com>
Subject: Re: [PATCH] btrfs-progs: Correct check_running_fs_exclop() return
 value
Message-ID: <20210412155641.k6bmcznis77hv7ba@fiona>
References: <20210409155644.qkk6puelfjvtjwqs@fiona>
 <7efdb3f8-ff4e-48a1-158c-863629bcb6b6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7efdb3f8-ff4e-48a1-158c-863629bcb6b6@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On  6:50 10/04, Anand Jain wrote:
> On 09/04/2021 23:56, Goldwyn Rodrigues wrote:
> > check_running_fs_exclop() can return 1 when exclop is changed to "none"
> > The ret is set by the return value of the select() operation. Checking
> > the exclusive op changes just the exclop variable while ret is still
> > set to 1.
> > 
> > Set ret exclusively if exclop is set to BTRFS_EXCL_NONE.
> > ---
> 
> SOB missing.

Yes, missed that.

> 
> >   common/utils.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/common/utils.c b/common/utils.c
> > index 57e41432..2e5175c3 100644
> > --- a/common/utils.c
> > +++ b/common/utils.c
> > @@ -2326,6 +2326,8 @@ int check_running_fs_exclop(int fd, enum exclusive_operation start, bool enqueue
> >   			tv.tv_sec /= 2;
> >   			ret = select(sysfs_fd + 1, NULL, NULL, &fds, &tv);
> >   			exclop = get_fs_exclop(fd);
> > +			if (exclop == BTRFS_EXCL_NONE)
> > +				ret = 0;
> >   			continue;
> >   		}
> >   	}
> > 
> 
> 
> This is bit inconsistent from what is done a few lines above:
> 
>         exclop = get_fs_exclop(fd);
>         if (exclop <= 0) {
>                 ret = 0;
>                 goto out;
>         }
> 
> We return 0 for both BTRFS_EXCLOP_NONE || BTRFS_EXCLOP_UNKNOWN.
> 

I am not sure why we are translating the sysfs file value to enums. The
only status we are concerned about is with "none", anything besides that
is considered to be busy, for code flow purposes. For error display, we
can print whatever the sysfs file contains. Was this done for i18n?

Of course, to maintain backward compatibility, we need to check on
existence of the file.

Anyways, I will re-post this patch with what is done a few lines above.

-- 
Goldwyn
