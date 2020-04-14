Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9FA1A8293
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Apr 2020 17:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439348AbgDNPXZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Apr 2020 11:23:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:49086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390831AbgDNPXP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Apr 2020 11:23:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4D89AAC26;
        Tue, 14 Apr 2020 15:23:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A41C0DA823; Tue, 14 Apr 2020 17:22:33 +0200 (CEST)
Date:   Tue, 14 Apr 2020 17:22:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Tang Bin <tangbin@cmss.chinamobile.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] btrfs: Fix backref.c selftest compilation warning
Message-ID: <20200414152233.GV5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Tang Bin <tangbin@cmss.chinamobile.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
References: <20200411154915.9408-1-tangbin@cmss.chinamobile.com>
 <20200414151931.GU5920@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200414151931.GU5920@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 14, 2020 at 05:19:31PM +0200, David Sterba wrote:
> On Sat, Apr 11, 2020 at 11:49:15PM +0800, Tang Bin wrote:
> > Fix missing braces compilation warning in the ARM
> > compiler environment:
> >     fs/btrfs/backref.c: In function ‘is_shared_data_backref’:
> >     fs/btrfs/backref.c:394:9: warning: missing braces around initializer [-Wmissing-braces]
> >       struct prelim_ref target = {0};
> >     fs/btrfs/backref.c:394:9: warning: (near initialization for ‘target.rbnode’) [-Wmissing-braces]
> > 
> > Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> > Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
> > ---
> >  fs/btrfs/backref.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> > index 9c380e7..0cc0257 100644
> > --- a/fs/btrfs/backref.c
> > +++ b/fs/btrfs/backref.c
> > @@ -391,7 +391,7 @@ static int is_shared_data_backref(struct preftrees *preftrees, u64 bytenr)
> >  	struct rb_node **p = &preftrees->direct.root.rb_root.rb_node;
> >  	struct rb_node *parent = NULL;
> >  	struct prelim_ref *ref = NULL;
> > -	struct prelim_ref target = {0};
> > +	struct prelim_ref target = {};
> 
> I wonder why this initialization is a problem while there are about 20
> other uses of "{0}". The warning is about the embedded rbnode, but why
> does a more recent compiler not warn about that? Is this a missing fix
> from the one you use?
> 
> I don't mind fixing compiler warnings as long as it bothers enough
> people, eg. we have fixes reported by gcc 7 but I'm hesitant to fix
> anything older without a good reason.

This seems to be the bug report

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53119
"Bug 53119 - -Wmissing-braces wrongly warns about universal zero
initializer {0} "
