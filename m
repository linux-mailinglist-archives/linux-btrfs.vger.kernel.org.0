Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AD645A5A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 15:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbhKWOdM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 09:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbhKWOdG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 09:33:06 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C1CC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Nov 2021 06:29:58 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id n15so20043749qta.0
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Nov 2021 06:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lcovj7XhTyf6a/hrsQsq6FgBmB14STDf1/yXgWfU1lw=;
        b=vnm+d301/4JNB8hVIBditPCFkFtwJwI0qa8dHGFQ7WwI2oRr6R6eLqD2Lg9YGHax0k
         07w99drSRFdUU/KKrnbGexSOAxoAtSgBbNeu8AlxnnVFMOE25HVD4se50yYwf5O2WhHA
         N6AwtrV/zDzt0goC29a3+6tNXUPzC4UyRPgX+eW+ulxf59879JFEFM0lVMbI4GF0qEU7
         kj1L4/MESV8Q4ZHkA/FPJVvvEy3Svf/shNHbtQ8gbQBmfuq/TkG/omT7663TKGLoj6tt
         tkx7G8pc2EmJ8O4FYOGlKpBzoYuwfjXzBwfLIqu8tGIapNEfZBsqv4NAd8z32wZUgJeX
         jlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lcovj7XhTyf6a/hrsQsq6FgBmB14STDf1/yXgWfU1lw=;
        b=hQXDbBrBObFQ39HoPBG8y/impyO6i2NdMxQiiGJGKwKrW2qa9E/0Hs60siSrW4K8rH
         1ZizKv2X6N9eV3pQ4S7F8zGZg0FRKFziwIkZST/4KRHEovinRGmUwdFh7SyNMl7cYygr
         p6ARaFPSrSu5bOP5uxU4kytpaoUFL+ocCNwcBfcgAUP/0Skj2O9+2q3/HGMOdBaA5AxI
         t1gqqyAT0m6/BnqsmNxZM5OiMN4l7XVFRW7BGyOg+ApEZ+f+qChOOvFq3YqTEovikSiR
         qrRUqlhOQHdvi3PJNJkcw9UpfdsAHy9CRvPFje22TslLR4q2HClQFXztKEr72x6LpIuB
         vMhA==
X-Gm-Message-State: AOAM532MJ9IeO4YfS1BrBu20XnHZG2UXOdUXNZ614Vc+JxXAgSZkbz81
        29GEdyuY/UY4dxSPZR2jlcYexLbu/O4Q1g==
X-Google-Smtp-Source: ABdhPJy+OrT9obiKH1SjRjvHssrnd/yGm802W/oTaQ1k4wy/UNgBjN2ciJt/yv/HmjF52KAaUkM65g==
X-Received: by 2002:a05:622a:410:: with SMTP id n16mr6833784qtx.369.1637677797511;
        Tue, 23 Nov 2021 06:29:57 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s22sm6793655qko.88.2021.11.23.06.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 06:29:55 -0800 (PST)
Date:   Tue, 23 Nov 2021 09:29:54 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fail if fstrim_range->start == U64_MAX
Message-ID: <YZz64qAUHAZZnxPO@localhost.localdomain>
References: <3990fc5294f2a20a8a4b27c5be0b4b1359f7f1a6.1637618651.git.josef@toxicpanda.com>
 <e31d5b36-a8f3-05a1-040a-7295c3f64b42@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e31d5b36-a8f3-05a1-040a-7295c3f64b42@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 23, 2021 at 07:29:04AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/11/23 06:04, Josef Bacik wrote:
> > We've always been failing generic/260 because it's testing things we
> > actually don't care about and thus won't fail for.  However we probably
> > should fail for fstrim_range->start == U64_MAX since we clearly can't
> > trim anything past that.  This in combination with an update to
> > generic/260 will allow us to pass this test properly.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >   fs/btrfs/extent-tree.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 13a371ea68fc..6b4a132d4b86 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -6065,6 +6065,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
> >   	int dev_ret = 0;
> >   	int ret = 0;
> > 
> > +	if (range->start == U64_MAX)
> > +		return -EINVAL;
> > +
> 
> Isn't the next overflow check would catch anything which length is not
> U64_MAX?
> 

Yes, but if you do range->start == U64_MAX and len == 0 it'll pass.  We're being
pedantic here, but it's a simple enough sanity check.  Thanks,

Josef
