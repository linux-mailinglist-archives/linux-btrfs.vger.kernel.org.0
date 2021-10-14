Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095CD42DEC8
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 18:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhJNQCU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 12:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhJNQCR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 12:02:17 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC517C061570
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 09:00:12 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id a16so4016764qvm.2
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 09:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Azk3o/XInF1j5qxtCLsxvHxJ0bGCg1c1m1UP2r0ZSAc=;
        b=lZpsT5zx3/HIbleC+7PJr4A9DHIXadThRdhQw6w/sNM/hZQ40AtzMS88gI7MAXKFV0
         3Kjz/7U2qcoRUpB8g3nkcWASZQHi/80eCKepZxagMucwSE4pZBWFIDEnMoeyVB+Osvyq
         89HIjMk1FSXmcpz0RMbWih6SBb2K1HnOE2Kzx/u/0one3JAMv8JuPI7TNOGH6Aaa9p1j
         1SZNG/K8OxXLZA7HgI75liag3WZrQvPy+8TYThorAYS76WEXM4QYZMHxVGMPsTIgfggo
         va5G1gwoLlTvNS0p3GhPQA1SGEcaWOeSH9FmP3/ef3MbcuRlnYMm410vTauJWUQJLHuX
         X7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Azk3o/XInF1j5qxtCLsxvHxJ0bGCg1c1m1UP2r0ZSAc=;
        b=3WaVFizRhFRqy33yUQwhccMl8Rs7balKQD7dOx/RGzkic+U6Frj5gyrFTctAEwCv57
         Ady68NHr7gw+WqyoE53uppN7U7Seuxix1Ve9N8En84xALKa5XLKLSgQ6mQebYa45Qhy8
         PHr2NA99qfsCOb/xOwMThCKv3RTuoJDHC+RQvjpemTqITKvav7Nb5+fyfWlV9LoY0qwd
         M//44CHGeydHkIE8qSzMGNifLByzjBMd0ATsTRThj3sv8siOzFs+HQdrxSh/b46qJLbn
         bZb9Tw8qIIkE39gMvFd3iW2iAmCXsnQjqpyPEwlbQwANmowdrPT7fTvlKFuytMrqbfRC
         IfEw==
X-Gm-Message-State: AOAM533LTrjPhHMCyqoAIlFJ82x1Kzo4GIm9D4cUkQKA8LXhUERBLBzy
        RIy8K3emQTfTGvzOL3UH+r0ydA==
X-Google-Smtp-Source: ABdhPJzoG1imjrbpLJhtTOLNXWh/gtPODvYTHvWZCY8P0+XNcpXI6l+grDVR2GjIkhBWQagKP401kA==
X-Received: by 2002:a05:6214:f06:: with SMTP id gw6mr6277590qvb.26.1634227211836;
        Thu, 14 Oct 2021 09:00:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u16sm1634369qki.47.2021.10.14.09.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 09:00:11 -0700 (PDT)
Date:   Thu, 14 Oct 2021 12:00:10 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: update device path inode time instead of bd_inode
Message-ID: <YWhUCilH3TjmQC+X@localhost.localdomain>
References: <00b8cf32502e30403b9849a73e62f4ad5175fded.1634224611.git.josef@toxicpanda.com>
 <20211014153347.GA30555@lst.de>
 <YWhRr123vMRtiHF4@localhost.localdomain>
 <20211014155341.GA32052@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014155341.GA32052@lst.de>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 14, 2021 at 05:53:41PM +0200, Christoph Hellwig wrote:
> On Thu, Oct 14, 2021 at 11:50:07AM -0400, Josef Bacik wrote:
> > On Thu, Oct 14, 2021 at 05:33:47PM +0200, Christoph Hellwig wrote:
> > > On Thu, Oct 14, 2021 at 11:17:08AM -0400, Josef Bacik wrote:
> > > > +	now = current_time(d_inode(path.dentry));
> > > > +	generic_update_time(d_inode(path.dentry), &now, S_MTIME | S_CTIME);
> > > 
> > > This is still broken as it won't call into ->update_time.
> > > generic_update_time is a helper/default for ->update_time, not something
> > > for an external caller.
> > 
> > Then we probably need to fix all the people currently calling it.
> 
> All other callers are from update_time / ->update_time.
> 

I'm seeing a lot more calls to generic_update_time elsewhere

  File                Function             Line
0 fs/inode.c          <global>             1779 EXPORT_SYMBOL(generic_update_time);
1 fs/btrfs/volumes.c  update_dev_time      1900 generic_update_time(d_inode(path.dentry), &now, S_MTIME | S_CTIME);
2 fs/gfs2/inode.c     gfs2_update_time     2146 return generic_update_time(inode, time, flags);
3 fs/inode.c          generic_update_time  1755 int generic_update_time(struct inode *inode, struct timespec64 *time, int flags)
4 fs/inode.c          inode_update_time    1789 return generic_update_time(inode, time, flags);
5 fs/orangefs/inode.c orangefs_update_time  913 generic_update_time(inode, time, flags);
6 fs/ubifs/file.c     ubifs_update_time    1382 return generic_update_time(inode, time, flags);
7 fs/xfs/xfs_iops.c   xfs_vn_update_time   1123 return generic_update_time(inode, now, flags);
8 include/linux/fs.h  __printf             2617 extern int generic_update_time(struct inode *, struct timespec64 *, int );

> > In the
> > meantime I'll add a helper to use the thing that calls ->update_time instead.
> > Thanks,
> 
> Looking at this a bit more I think the right fix is to simply revert the
> offending commit.  The lockdep complains was due to changes issues in the
> loop driver and has been fixed in the loop driver in the meantime.
> 

Where were they fixed?  And it doesn't fix the fact that we're calling open on a
device, so any change at all to the loop device is going to end us back up in
this spot because we end up with the ->lo_mutex in our dependency chain.  I want
to avoid this by not calling open, and that means looking up the inode and doing
operations without needing to go through the full file open path.

The best thing for btrfs here is to export the update_time() helper and call
that to avoid all the baggage that comes from opening the block device.  Thanks,

Josef
