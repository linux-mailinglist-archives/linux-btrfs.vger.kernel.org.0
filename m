Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D4F257928
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 14:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgHaMZ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 08:25:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:35432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgHaMZ4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 08:25:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11E4BB7CD;
        Mon, 31 Aug 2020 12:25:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4EBC0DA840; Mon, 31 Aug 2020 14:24:44 +0200 (CEST)
Date:   Mon, 31 Aug 2020 14:24:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/5] btrfs: Factor out reada loop in __reada_start_machine
Message-ID: <20200831122444.GV28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200715104850.19071-1-nborisov@suse.com>
 <20200715104850.19071-2-nborisov@suse.com>
 <e4da26dc-5a45-96ca-ed7b-ab8e8ec2abaf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4da26dc-5a45-96ca-ed7b-ab8e8ec2abaf@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 29, 2020 at 11:06:32PM +0800, Anand Jain wrote:
> On 15/7/20 6:48 pm, Nikolay Borisov wrote:
> > This is in preparation for moving fs_devices to proper lists.
> > 
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> > ---
> >   fs/btrfs/reada.c | 21 ++++++++++++++++-----
> >   1 file changed, 16 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
> > index 243a2e44526e..aa9d24ed56d7 100644
> > --- a/fs/btrfs/reada.c
> > +++ b/fs/btrfs/reada.c
> > @@ -767,15 +767,14 @@ static void reada_start_machine_worker(struct btrfs_work *work)
> >   	kfree(rmw);
> >   }
> >   
> > -static void __reada_start_machine(struct btrfs_fs_info *fs_info)
> > +
> > +/* Try to start up to 10k READA requests for a group of devices. */
> > +static int __reada_start_for_fsdevs(struct btrfs_fs_devices *fs_devices)
> 
>   In my experience David doesn't prefer __ prefix for helper functions.

Right, I've updated the patch to drop the __ as there's no other
function without the underscores (unlike __reada_start_machine/reada_start_machine)
