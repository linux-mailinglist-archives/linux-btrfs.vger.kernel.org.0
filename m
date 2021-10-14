Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D6D42DF2F
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 18:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhJNQeb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 12:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbhJNQea (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 12:34:30 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE329C061753
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 09:32:24 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id y10so5961928qkp.9
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fZ1p7YeF4ME+UAazH4qetlLx+6NO+qO58pmkbIx9AYc=;
        b=y2s56uTjy+aCSy+xrtLT6dO3qLQIMEbdIJc+rT+C/EJskCfAAS2Pyp2F+m53PEGAth
         ZbE+veyvZ4QrR+U5MFZ+OPvrqU/WOG3YMzouQFkQVR4XavnboDH+kosWvlB298AcMM74
         zU5lP67QkhJKxqCYe3R8pNxD/H+jEIm/iLyDapaPnepAVOGw8JYEicr3vEgL0SrqitPN
         oKPvZqSwSIbW1SKBIQOqqu/bkCxEPcobobV5jCozR6li3aJxko3Mo5/bF5QxS28XN/BQ
         G8okOMGd3xEgZ6z+tcFHecwEhQYBoxgKICOigvazuZ55Mgq+BLIv1fbRDgfpLfLtB9pd
         ktCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fZ1p7YeF4ME+UAazH4qetlLx+6NO+qO58pmkbIx9AYc=;
        b=Pvkdwl3GnE2aAH1d/+GcsPHJ7IzXCPTPmhvL0AKPUG6Vxq0tjL8c0cOUR/pjx7TSyp
         YZMxVOj2T4Zz6IeDeB5XIRwy86jo8u7qV8OdctWr02me3whuPz7GEAEHXAVa4MZU0D6e
         Cyr1bZ0MD4KFOIgeskI/H0TVgD5NTZceinzDVh/pwGoIT7FrPsI3iOulSbk6j0wgoRJV
         OPzt54oy6epCS0faFkGhGqIwYYVBD1/JaRa4tZ/K31Kg8nni/LHHLKzghnNcJiYUOTAv
         OZKtUD+/lqT3qTzQzawntG2edLNBciJr3t5cdS177+nu+EUq32Xw4l7DhrEjLr9v0ZHr
         QjrA==
X-Gm-Message-State: AOAM532KWFoGxsw6/Ol4hfkPmFQDnHVklovaXOxWETvDg6CWYMReIXKG
        hWXdcDKbJOlvPf5dXGb33d1c4Q==
X-Google-Smtp-Source: ABdhPJxBzvBdJD3UKJMIPSGjIDYzOQ5Cc+E1xJO3VBAIYM9tYowf8YgW5Zlog5jlQRzLgLPGPUT8kA==
X-Received: by 2002:a37:a3d1:: with SMTP id m200mr5754781qke.61.1634229143981;
        Thu, 14 Oct 2021 09:32:23 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v22sm1451917qkf.79.2021.10.14.09.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 09:32:23 -0700 (PDT)
Date:   Thu, 14 Oct 2021 12:32:22 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: update device path inode time instead of bd_inode
Message-ID: <YWhblpJgxJ81nA5i@localhost.localdomain>
References: <00b8cf32502e30403b9849a73e62f4ad5175fded.1634224611.git.josef@toxicpanda.com>
 <20211014153347.GA30555@lst.de>
 <YWhRr123vMRtiHF4@localhost.localdomain>
 <20211014155341.GA32052@lst.de>
 <YWhUCilH3TjmQC+X@localhost.localdomain>
 <20211014160520.GA445@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014160520.GA445@lst.de>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 14, 2021 at 06:05:20PM +0200, Christoph Hellwig wrote:
> On Thu, Oct 14, 2021 at 12:00:10PM -0400, Josef Bacik wrote:
> > 1 fs/btrfs/volumes.c  update_dev_time      1900 generic_update_time(d_inode(path.dentry), &now, S_MTIME | S_CTIME);
> 
> This is the onde we're talking about.
> 
> > 4 fs/inode.c          inode_update_time    1789 return generic_update_time(inode, time, flags);
> 
> This is update_time().
> 
> And all others are ->update_time instances.
> 
> > > Looking at this a bit more I think the right fix is to simply revert the
> > > offending commit.  The lockdep complains was due to changes issues in the
> > > loop driver and has been fixed in the loop driver in the meantime.
> > > 
> > 
> > Where were they fixed?  And it doesn't fix the fact that we're calling open on a
> > device, so any change at all to the loop device is going to end us back up in
> > this spot because we end up with the ->lo_mutex in our dependency chain.  I want
> > to avoid this by not calling open, and that means looking up the inode and doing
> > operations without needing to go through the full file open path.
> 
> This all looks like the open_mutex (formerly bd_mutex) vs lo_mutex inside
> and outside chains, and they were fixed.
> 

They weren't, I just ran with the original fix reverted and I got the same
splat.  We need to not call into the blockdevice open call at all, and even if
they were fixed we'd just get screwed at some point in the future.  The less I
have to worry about things outside of fs/btrfs the better.

> > The best thing for btrfs here is to export the update_time() helper and call
> > that to avoid all the baggage that comes from opening the block device.  Thanks,
> 
> update_time is a bit too low-level for an export as it requires a fair
> effort to call it the right way.

It's about the same complexity as touch_atime(), and clearly I still need it to
fix the lockdep splat.  Thanks,

Josef
