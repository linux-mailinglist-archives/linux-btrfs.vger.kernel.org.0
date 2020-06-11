Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972531F69CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 16:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgFKOTv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 10:19:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbgFKOTv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 10:19:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0882F20801;
        Thu, 11 Jun 2020 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591885190;
        bh=iBtLF+CBhTmtuou9PxAkvWs1JyESEMIpwdk/QHqOQXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z3qJLpU6SJwDEAgOqrrIDTRc+I7WXjSzI0eD7wi4GcSwrhXNh4RsdUlWEUaGkc9TY
         SxxyaVsM4dId5UyIYKx+SqOx4VBiChgA5BPQJIo+6LTHzFPveocjceexsM6Dt1yBKn
         DNtlMfGNvQh6k0Y8v3uyCiIOGdH5Khj5mO+PerWI=
Date:   Thu, 11 Jun 2020 16:19:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Liao Pingfang <liao.pingfang@zte.com.cn>,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Wang Liang <wang.liang82@zte.com.cn>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [PATCH v2] btrfs: Remove error messages for failed memory
 allocations
Message-ID: <20200611141943.GA1245098@kroah.com>
References: <59c4741e-5749-4782-33f8-cc3a30ecf5e5@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59c4741e-5749-4782-33f8-cc3a30ecf5e5@web.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 11, 2020 at 04:00:21PM +0200, Markus Elfring wrote:
> > As there is a dump_stack() done on memory allocation
> > failures, these messages might as well be deleted instead.
> 
> * I imagine that an other wording variant can become clearer
>   for the change description.
> 
> * I suggest to reconsider the patch subject.
> 
> 
> …
> > +++ b/fs/btrfs/check-integrity.c
> > @@ -632,7 +632,6 @@  static int btrfsic_process_superblock(struct btrfsic_state *state,
> >
> >  	selected_super = kzalloc(sizeof(*selected_super), GFP_NOFS);
> >  	if (NULL == selected_super) {
> > -		pr_info("btrfsic: error, kmalloc failed!\n");
> >  		return -ENOMEM;
> >  	}
> 
> 
> How do you think about to use the following error handling instead?
> 
> 	if (!selected_super)
> 		return -ENOMEM;
> 


Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
