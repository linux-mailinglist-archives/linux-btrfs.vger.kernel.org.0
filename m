Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43900443312
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 17:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbhKBQjr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 12:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbhKBQNw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 12:13:52 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449ACC0613B9
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Nov 2021 09:10:27 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id s1so17911507qta.13
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Nov 2021 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xs/hUNnt4SJtje4TDpjvMYwWwssDf5czyN1WO11VqAg=;
        b=XIVE/E8HiC//pZ9OceGDLjmQJOpK9e4+MOb0+ge78/yQXfHGCXzjy03YKafcSXCPPX
         ErZO8jqD/ljonXxt4D9jqTLL39J/KkJpj1HawxVRnKD8YPvsnzvrr+qXMj8BevhItCis
         Sqk7EFpqfL86VutbR2WKkmZ8KMS/CwRZLXeAvpXLnkUpZe/0MrIUOFLUlTdAUEEBztxG
         LSt3GuJ1CiSvY5CWU3eOo7VrFpc/+3OjsbaN4R0OhQTm+FMrUamP2ZIPocr3s2shplb+
         gHY1pb++LJBapCBkAKFcFuzmURiOD3o9jGHaOjePMDg0rggR7eGv3jI+npymDtHCtTUH
         4mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xs/hUNnt4SJtje4TDpjvMYwWwssDf5czyN1WO11VqAg=;
        b=UvRBWsN8QLazE8I3yaB4EcvMvbzH/143qs6sRt1xTeDfoV0PMYZ7MVYcRykBEWAq79
         Jx4ey2JvFZ1XFR5qSulHaNVrp8KFH3IRdKSId4OkosFsHbC/xSLHrJ1W/oldF8KXg8N6
         8fKOiMj1rLNRDlddyZ4we89Xwwwmk6RBdmNnnKdm1A74QtpjVzpM1ec30yGDvwwqgLcC
         UoMGVQhvEAuMOYagcKRavo4Mz7I9DYna55Vlnz3W63SBxCVjJRLhEqvbkM8p9BmLPhsL
         ncSUtjKTTIU/0VKfQiLdxt6IxrIwIPNus+9ApkKq0m9Coqczr2OmVSc4mxopg5RyhbNV
         t/eQ==
X-Gm-Message-State: AOAM530/BbkYgHbdT8twQ9JrGQLxoUgvczB7N8tjJuJQhyq+S92O7Mkp
        fMvz4W27wto8HHc/80Qkd8Q+wRyr59A6IQ==
X-Google-Smtp-Source: ABdhPJwC81pn3d40hwPXzkozsYCQnN/+d6bhiMD7Z9/am9L8K6XPEtmxWpkuQsvjDleEu26V2YDSlg==
X-Received: by 2002:a05:622a:508:: with SMTP id l8mr39120367qtx.55.1635869426184;
        Tue, 02 Nov 2021 09:10:26 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f21sm7324076qtk.61.2021.11.02.09.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:10:25 -0700 (PDT)
Date:   Tue, 2 Nov 2021 12:10:24 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 0/3] Balance vs device add fixes
Message-ID: <YYFi8CRmQW4L5phF@localhost.localdomain>
References: <20211101115324.374076-1-nborisov@suse.com>
 <YYFLlL4NTF4L+PmE@localhost.localdomain>
 <516c7eaf-3fb2-fe61-08f8-ac4201752121@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <516c7eaf-3fb2-fe61-08f8-ac4201752121@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 02, 2021 at 05:25:32PM +0200, Nikolay Borisov wrote:
> 
> 
> On 2.11.21 г. 16:30, Josef Bacik wrote:
> > On Mon, Nov 01, 2021 at 01:53:21PM +0200, Nikolay Borisov wrote:
> >> This series enables adding of a device when balance is paused (i.e an fs is mounted
> >> with skip_balance options). This is needed to give users a chance to gracefully
> >> handle an ENOSPC situation in the face of running balance. To achieve this introduce
> >> a new exclop - BALANCE_PAUSED which is made compatible with device add. More
> >> details in each patche.
> >>
> >> I've tested this with an fstests which I will be posting in a bit.
> >>
> >> Nikolay Borisov (3):
> >>   btrfs: introduce BTRFS_EXCLOP_BALANCE_PAUSED exclusive state
> >>   btrfs: make device add compatible with paused balance in
> >>     btrfs_exclop_start_try_lock
> >>   btrfs: allow device add if balance is paused
> >>
> >>  fs/btrfs/ctree.h   |  1 +
> >>  fs/btrfs/ioctl.c   | 49 +++++++++++++++++++++++++++++++++++++++-------
> >>  fs/btrfs/volumes.c | 23 ++++++++++++++++++----
> >>  fs/btrfs/volumes.h |  2 +-
> >>  4 files changed, 63 insertions(+), 12 deletions(-)
> >>
> > 
> > A few things
> > 
> > 1) Can we integrate the flipping into helpers?  Something like
> > 
> > 	btrfs_exclop_change_state(PAUSED);
> > 
> >    So the locking and stuff is all with the code that messes with the exclop?
> 
> Right, I left the code flipping balance->paused opencoded because that's
> really a special case. By all means I can add a specific helper so that
> the ASSERT is not lost as well. The reason I didn't do it in the first
> place is because PAUSED is really "special" in the sense it can be
> entered only from BALANCE and it's not really generic. If you take a
> look how btrfs_exclop_start does it for example, it simply checks we
> don't have a running op and simply sets it to whatever is passed
> 
> > 
> > 2) The existing helpers do WRITE_ONCE(), is that needed here?  I assume not>    because we're not actually exiting our exclop state, but still
> seems wonky.
> 
> That got me thinking in the first place and actually initially I had a
> patch which removed it. However, I *think* it might be required since
> exclusive_operation is accessed without a lock ini the sysfs code i.e.
> btrfs_exclusive_operation_show so I guess that's why we need it.
> 
> Goldwyn, what's your take on this?
> 
> > 
> > 3) Maybe have an __btrfs_exclop_finish(type), so instead of 
> > 
> > 	if (paused) {
> > 		do thing;
> > 	} else {
> > 		btrfs_exclop_finish();
> > 	}
> > 
> >   you can instead do
> > 
> > 	type = BTRFS_EXCLOP_NONE;
> > 	if (pause stuff) {
> > 		do things;
> > 		type = BTRFS_EXCLOP_BALANCE_PAUSED;
> > 	}
> > 
> > 	/* other stuff. */
> > 	__btrfs_exclop_finish(type);
> > 
> > then btrfs_exclop_finish just does __btrfs_exclop_finish(NONE);
> 
> I'm having a hard time seeing how this would increase readability. What
> should go into the __btrfs_exclop_finish function?
> 

btrfs_exclop_finish would become __btrfs_exclop_finish(type) and do all the
work, but instead of setting NONE it would set type.

Honestly I could go either way, having a helper would make it more readable than
it is, because then its

if (pause)
	btrfs_exclop_pause();
else
	btrfs_exclop_finish();

I'm not strong on this, I think having a helper instead of open coding helps
given the number of places it's used.  Perhaps just doing that step will make it
clean enough.  Thanks,

Josef
