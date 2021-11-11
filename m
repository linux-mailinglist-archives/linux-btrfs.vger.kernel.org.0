Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0D744D90E
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 16:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhKKPUY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 10:20:24 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47748 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbhKKPUP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 10:20:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0D56521B28;
        Thu, 11 Nov 2021 15:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636643846;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/W2TYpCJyXKcqeW9JIjD87opy4YLYg9CDaWhQbg4zoI=;
        b=HoEg7sS5OdWBL3MiHm3tAOdTQu89oKwkjcijBsJMcTnPwVPJHLbeQJl63M4Bv/vf2J9h6v
        Sc/QwFqeuLsvytaQYwBKL29IsjdN/AeW7Ljk7nJZdNqZ+L8ZSQKKVASLMUTqE4XruYL8Lk
        FVn3CQKBnPyI2F1XxQypMyFZ+9n3j0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636643846;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/W2TYpCJyXKcqeW9JIjD87opy4YLYg9CDaWhQbg4zoI=;
        b=bs1pDm8td6yLhVFbj4vCnIzuPq9vfxeLVuvqO2ovz1KIGvveEFiww9B7YbolYXFU58d+jI
        4FIEzouUiNkNeGAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 04B55A3B90;
        Thu, 11 Nov 2021 15:17:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2BD28DA799; Thu, 11 Nov 2021 16:17:25 +0100 (CET)
Date:   Thu, 11 Nov 2021 16:17:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 2/7] btrfs: check for priority ticket granting before
 flushing
Message-ID: <20211111151725.GG28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636470628.git.josef@toxicpanda.com>
 <efd7030290cfce311cea39f381b2e5cb38761336.1636470628.git.josef@toxicpanda.com>
 <f0f97d68-cf01-515b-f787-3ccb924ff9ad@suse.com>
 <YY0lETfvTPmkvhA9@localhost.localdomain>
 <9efd1d38-cdcd-127e-3b44-d3c907000bfe@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9efd1d38-cdcd-127e-3b44-d3c907000bfe@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 11, 2021 at 04:50:48PM +0200, Nikolay Borisov wrote:
> 
> 
> On 11.11.21 г. 16:13, Josef Bacik wrote:
> > On Thu, Nov 11, 2021 at 03:14:20PM +0200, Nikolay Borisov wrote:
> >>
> >>
> >> On 9.11.21 г. 17:12, Josef Bacik wrote:
> >>> Since we're dropping locks before we enter the priority flushing loops
> >>> we could have had our ticket granted before we got the space_info->lock.
> >>> So add this check to avoid doing some extra flushing in the priority
> >>> flushing cases.
> >>>
> >>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >>
> >> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> >>
> >>> --->  fs/btrfs/space-info.c | 9 ++++++++-
> >>>  1 file changed, 8 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> >>> index 9d6048f54097..9a362f3a6df4 100644
> >>> --- a/fs/btrfs/space-info.c
> >>> +++ b/fs/btrfs/space-info.c
> >>> @@ -1264,7 +1264,7 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
> >>>  
> >>>  	spin_lock(&space_info->lock);
> >>>  	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info);
> >>> -	if (!to_reclaim) {
> >>> +	if (!to_reclaim || ticket->bytes == 0) {
> >>
> >> nit: This is purely an optimization, handling the case where a prio
> >> ticket N is being added to the list, but at the same time we might have
> >> had ticket N-1 just satisfied (or failed) and having called
> >> try_granting_ticket might have satisfied concurrently added ticket N,
> >> right? And this is a completely independent change of the other cleanups
> >> being done here?
> >>
> > 
> > It's definitely just an optimization, but it can be less specific than this.
> > Think we came in to reserve, we didn't have the space, we added our ticket to
> > the list.  But at the same time somebody was waiting on the space_info lock to
> > add space and do btrfs_try_granting_ticket(), so we drop the lock, get
> > satisfied, come in to do our loop, and we have been satisified.
> > 
> > This is the priority reclaim path, so to_reclaim could be !0 still because we
> > may have only satisified the priority tickets and still left non priority
> > tickets on the list.  We would then have to_reclaim but ->bytes == 0.
> > 
> > Clearly not a huge deal, I just noticied it when I was redoing the locking for
> > the cleanups and it annoyed me.  Thanks,
> 
> IMO such scenario description should be put in the changelog.

Agreed. I'll paste and edit it from this answer, no need to resend the
whole patch but I'd appreciate proofreading once it's in misc-next.
