Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A54D554BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 18:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfFYQlu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jun 2019 12:41:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:52542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbfFYQlu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jun 2019 12:41:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3AE4FAE4D;
        Tue, 25 Jun 2019 16:41:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3BDD4DA8F6; Tue, 25 Jun 2019 18:42:34 +0200 (CEST)
Date:   Tue, 25 Jun 2019 18:42:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/11] btrfs: move the space_info handling code to
 space-info.c
Message-ID: <20190625164234.GQ8917@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
References: <20190618200926.3352-1-josef@toxicpanda.com>
 <20190618200926.3352-5-josef@toxicpanda.com>
 <20190625115843.GO8917@twin.jikos.cz>
 <20190625125429.zuwdgfpt7ddoikhs@MacBook-Pro-91.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625125429.zuwdgfpt7ddoikhs@MacBook-Pro-91.local>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 25, 2019 at 08:54:30AM -0400, Josef Bacik wrote:
> On Tue, Jun 25, 2019 at 01:58:43PM +0200, David Sterba wrote:
> > On Tue, Jun 18, 2019 at 04:09:19PM -0400, Josef Bacik wrote:
> > > --- /dev/null
> > > +++ b/fs/btrfs/space-info.c
> > > @@ -0,0 +1,177 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (C) 2019 Facebook.  All rights reserved.
> > > + */
> > 
> > How does the copyright claim work here? You're just moving code from a
> > file (extent-tree.c) that has
> > 
> >   "Copyright (C) 2007 Oracle.  All rights reserved."
> > 
> > Adding company copyright to new files that implement something
> > completely new seems to be fine and I don't object against adding it,
> > though personally I think it's pointless to add the copyrights when
> > there's the Signed-off-by mechanism and full and immutable history of
> > changes tracked in git and newly the SPDX tag to disperse any confusion
> > about licensing of individual files.
> > 
> 
> Yeah I agree, fix it however you like, the signed-off chain seems to be what's
> important.  Thanks,

Thanks, I've summarized that on wiki so we can point to that when
needed.

https://btrfs.wiki.kernel.org/index.php/Developer%27s_FAQ#Copyright_notices_in_files
