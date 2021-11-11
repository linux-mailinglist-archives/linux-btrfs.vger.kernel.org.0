Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEF044D7E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 15:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhKKOQa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 09:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhKKOQa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 09:16:30 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5D4C061766
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Nov 2021 06:13:40 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id l8so5395942qtk.6
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Nov 2021 06:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=L/BF0pWf37yiYefiAoeEf+IGmaMOfv50USqxjUV96LY=;
        b=7T4XLBJVhOXeQwrEllY9oVovhCdinu31M6JH4nt/xu3f31UTANkzrsmk/V8vtdwc7d
         WW2sD98m8xB020cbIIWD4CbeErssGw5H/5ShRGnkGOBR1znOa6hLhq++IEY12BGEhd69
         8wI5rO/T2Htk/Ff3BGsMOK3KUqPko2zryvgo2lTngLMSwNEAGoy7j2zt5qGAE8HHdWcQ
         RPMttcbr7Gjr4w4JvVaoj/6d/MBsb6afZYVO9zvm2AnovOdT9JaxQYJBrYM3jcEQapKX
         i7c9uqakyHo+grHrdA/zabBpTFBsVlxXHhdQA7GHjzRatjAFpJFefxrDPuFqWqmmw9ic
         voZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=L/BF0pWf37yiYefiAoeEf+IGmaMOfv50USqxjUV96LY=;
        b=y3UsVouyawefZPU7BVhIhCZ0wUkH/yrUWlt2TaWDRO60c/XFGAwlSANpACoKaratAX
         LHIO4Q7EjEjkGD8+mKDdSZfv3WcsyPE8sDvuO7lF0Jas+xTH/ZG8X7QO7M1OZc+XPAwD
         Y9R1+LoKd/51YPH7pb8cb411ZGtphd9sbgSAaE7wVWcO2kSSXkdgreeydjMfA8JTQa/o
         TguOdd9kas5JiNset5Ku0Bbsmecnl2TXPjpSiCDzpqpzaFiWIwV3LI6WF2sWD5Aw+sw8
         Vo2ZnE4mNsDBWf+q7MU+VSeuRa+SloyUSX2zUId3ubKNNs5zbkCViGx6SIfUtky1UqX5
         akdQ==
X-Gm-Message-State: AOAM531NY55dJJjY/8V7uYZ0OtGKXdl6yW/vN9FKkxXMxvnQKMZTDOkW
        Y7ab/l+u7JLt1N23bbGbysuZdw==
X-Google-Smtp-Source: ABdhPJzm2+xDbEavjKhSRAQGVoX72jq3tDLqj7Om1xEjZ33P8BBG+EptVq9YYrN74xbK+tsMvTTm4Q==
X-Received: by 2002:ac8:5d87:: with SMTP id d7mr8034030qtx.146.1636640019990;
        Thu, 11 Nov 2021 06:13:39 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x190sm1322043qkb.115.2021.11.11.06.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 06:13:39 -0800 (PST)
Date:   Thu, 11 Nov 2021 09:13:37 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 2/7] btrfs: check for priority ticket granting before
 flushing
Message-ID: <YY0lETfvTPmkvhA9@localhost.localdomain>
References: <cover.1636470628.git.josef@toxicpanda.com>
 <efd7030290cfce311cea39f381b2e5cb38761336.1636470628.git.josef@toxicpanda.com>
 <f0f97d68-cf01-515b-f787-3ccb924ff9ad@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0f97d68-cf01-515b-f787-3ccb924ff9ad@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 11, 2021 at 03:14:20PM +0200, Nikolay Borisov wrote:
> 
> 
> On 9.11.21 г. 17:12, Josef Bacik wrote:
> > Since we're dropping locks before we enter the priority flushing loops
> > we could have had our ticket granted before we got the space_info->lock.
> > So add this check to avoid doing some extra flushing in the priority
> > flushing cases.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> > --->  fs/btrfs/space-info.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> > index 9d6048f54097..9a362f3a6df4 100644
> > --- a/fs/btrfs/space-info.c
> > +++ b/fs/btrfs/space-info.c
> > @@ -1264,7 +1264,7 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
> >  
> >  	spin_lock(&space_info->lock);
> >  	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info);
> > -	if (!to_reclaim) {
> > +	if (!to_reclaim || ticket->bytes == 0) {
> 
> nit: This is purely an optimization, handling the case where a prio
> ticket N is being added to the list, but at the same time we might have
> had ticket N-1 just satisfied (or failed) and having called
> try_granting_ticket might have satisfied concurrently added ticket N,
> right? And this is a completely independent change of the other cleanups
> being done here?
> 

It's definitely just an optimization, but it can be less specific than this.
Think we came in to reserve, we didn't have the space, we added our ticket to
the list.  But at the same time somebody was waiting on the space_info lock to
add space and do btrfs_try_granting_ticket(), so we drop the lock, get
satisfied, come in to do our loop, and we have been satisified.

This is the priority reclaim path, so to_reclaim could be !0 still because we
may have only satisified the priority tickets and still left non priority
tickets on the list.  We would then have to_reclaim but ->bytes == 0.

Clearly not a huge deal, I just noticied it when I was redoing the locking for
the cleanups and it annoyed me.  Thanks,

Josef
