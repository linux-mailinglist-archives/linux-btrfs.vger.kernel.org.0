Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25671E7DE5
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 May 2020 15:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgE2NFy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 May 2020 09:05:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:40368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgE2NFx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 May 2020 09:05:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 97BD3AE0F;
        Fri, 29 May 2020 13:05:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 33F0CDA7BD; Fri, 29 May 2020 15:05:46 +0200 (CEST)
Date:   Fri, 29 May 2020 15:05:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Joe Perches <joe@perches.com>
Cc:     Yi Wang <wang.yi59@zte.com.cn>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: Re: [PATCH] btrfs: Replace kmalloc with kzalloc in the error message
Message-ID: <20200529130546.GR18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Joe Perches <joe@perches.com>,
        Yi Wang <wang.yi59@zte.com.cn>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
References: <1590714057-15468-1-git-send-email-wang.yi59@zte.com.cn>
 <5418df56f217437bd33c4cb70098db29c177d5b3.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5418df56f217437bd33c4cb70098db29c177d5b3.camel@perches.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 28, 2020 at 07:03:45PM -0700, Joe Perches wrote:
> On Fri, 2020-05-29 at 09:00 +0800, Yi Wang wrote:
> > From: Liao Pingfang <liao.pingfang@zte.com.cn>
> > 
> > Use kzalloc instead of kmalloc in the error message according to
> > the previous kzalloc() call.
> []
> > diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
> []
> > @@ -632,7 +632,7 @@ static int btrfsic_process_superblock(struct btrfsic_state *state,
> >  
> >  	selected_super = kzalloc(sizeof(*selected_super), GFP_NOFS);
> >  	if (NULL == selected_super) {
> > -		pr_info("btrfsic: error, kmalloc failed!\n");
> > +		pr_info("btrfsic: error, kzalloc failed!\n");
> 
> As there is a dump_stack() done on memory allocation
> failures, these messages might as well be deleted instead.

I wouldn't bother changing the strings, removing them entirely sounds
like a better idea to me.
