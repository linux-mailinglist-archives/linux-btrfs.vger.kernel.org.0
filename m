Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 401F57FB9F
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 15:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406625AbfHBN7F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 09:59:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:36654 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387723AbfHBN7E (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Aug 2019 09:59:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5BC4AFA5;
        Fri,  2 Aug 2019 13:59:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7FEA3DADC0; Fri,  2 Aug 2019 15:59:37 +0200 (CEST)
Date:   Fri, 2 Aug 2019 15:59:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: tree-log: use symbolic name for first replay
 stage
Message-ID: <20190802135937.GX28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1564663765.git.dsterba@suse.com>
 <5e7f207680bb5e16c0ef4f8499b060bff308a8f5.1564663765.git.dsterba@suse.com>
 <053e458d-fffb-e483-0880-62a49ccda990@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <053e458d-fffb-e483-0880-62a49ccda990@oracle.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 02, 2019 at 11:50:26AM +0800, Anand Jain wrote:
> 
> For whole series.
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> One nit below.
> 
> On 8/1/19 8:50 PM, David Sterba wrote:
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   fs/btrfs/tree-log.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 5513e76cc336..f48c8b9b513b 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -6237,7 +6237,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
> >   	struct btrfs_fs_info *fs_info = log_root_tree->fs_info;
> >   	struct walk_control wc = {
> >   		.process_func = process_one_buffer,
> > -		.stage = 0,
> > +		.stage = LOG_WALK_PIN_ONLY,
> 
>   Why this isn't enum?

It could be, though the values of stage are used as raw int comparing it
to some value (eg. replay_one_buffer and LOG_WALK_REPLAY_ALL), so that's
beyond the scope of the simple conversion.
