Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA0084CDD5
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 14:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfFTMjp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 08:39:45 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38290 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfFTMjp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 08:39:45 -0400
Received: by mail-qt1-f195.google.com with SMTP id n11so3023452qtl.5
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wJdpi/symUB1vzMKQJ/tl1P/hibIlU69GN33ZMUfjSo=;
        b=QACMIe/eXbSDlWoqiEmQtCMmqOgbb7qmmFz9OqPwvvn8f7s+WOwkAramOFlg3z48Vv
         udN9A5JoVn06ZM/tmEbzfkrCCap16avbrdpEyJKK/WidHYCS5hH1pimgyMbGrGdKxglR
         qoR5ydKZw93uTrvMNcEwbiVXPBJcjKV7qb/Vye4l8IO5xhDzSqUROD+lqMLadM8q0qNe
         t8rc1Wa71d7NtBpM8hXSgRJxulXhDaeNtPEp8Fv5otaiZS/pNYaPVQqTZMVuk//e8gc9
         77r2H2WcNXsRHRvKIF09o7xgmxyqz4jJBtGr23qWQdQrKTmnCLZRrmZTGcaA54MM81K2
         VGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wJdpi/symUB1vzMKQJ/tl1P/hibIlU69GN33ZMUfjSo=;
        b=tta/nd8JUW7ua/uyXPIYXbt7UhLw/1oG4L0LSqEknrZ4ek1uT1Zf+PxTohCbFru1Oe
         sYt8v0fjlW9kJIwreREfvg/1AeByE7XF46vke94VPkH2RezLSdv3f1Ht4aWyIEqmiGqm
         qxAAzZL+D0oQPQOJNXlo8zNmmeMcStZQq5lP/TFkZ8KhDlTBXri0ppNggvzEuj0BPSc2
         n/BhdfEw4fIogRZIFW1/KTEwTR0/nZXhYkn8ZVu4PB+L5va7kWl7anQvdKFsOKwNNk2d
         3eZR03E6G4VF8xDd6/hD6ZLuA44ia2wJFF0JgpGIjV1LtEFY9vIdKcBqHjycYQ/dRjLs
         qGKw==
X-Gm-Message-State: APjAAAVRVH4CjxJg18cC6IntzlcWKNUCqZHgksuH4r5qIezwI7OiddB5
        m9qnubFBy1ONDaXJMlzsyd6Usg==
X-Google-Smtp-Source: APXvYqw+wboBS70byacGia/Wolcanlj7YUnwg8R82May2fgUVuwVxFjnBX0okVQsnWXNpkHNwoWMxw==
X-Received: by 2002:a0c:ae6d:: with SMTP id z42mr23233600qvc.8.1561034384191;
        Thu, 20 Jun 2019 05:39:44 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m44sm16142281qtm.54.2019.06.20.05.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 05:39:43 -0700 (PDT)
Date:   Thu, 20 Jun 2019 08:39:42 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/8] btrfs: stop using block_rsv_release_bytes everywhere
Message-ID: <20190620123941.c6kdylyukyjhuuek@MacBook-Pro-91.local>
References: <20190619174724.1675-1-josef@toxicpanda.com>
 <20190619174724.1675-6-josef@toxicpanda.com>
 <8fb785be-79ad-1870-447c-fc87f7bebb04@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fb785be-79ad-1870-447c-fc87f7bebb04@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 20, 2019 at 11:32:21AM +0300, Nikolay Borisov wrote:
> 
> 
> On 19.06.19 г. 20:47 ч., Josef Bacik wrote:
> > block_rsv_release_bytes() is the internal to the block_rsv code, and
> > shouldn't be called directly by anything else.  Switch all users to the
> > exported helpers.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/extent-tree.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 6995edf887e1..d1fce37107b4 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -4750,12 +4750,11 @@ static void btrfs_inode_rsv_release(struct btrfs_inode *inode, bool qgroup_free)
> >  void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr)
> >  {
> >  	struct btrfs_block_rsv *block_rsv = &fs_info->delayed_refs_rsv;
> > -	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
> >  	u64 num_bytes = btrfs_calc_trans_metadata_size(fs_info, nr);
> >  	u64 released = 0;
> >  
> > -	released = block_rsv_release_bytes(fs_info, block_rsv, global_rsv,
> > -					   num_bytes, NULL);
> > +	released = __btrfs_block_rsv_release(fs_info, block_rsv, num_bytes,
> > +					     NULL);
> 
> You should use btrfs_block_rsv_release when qgroup_to_release is NULL.
> 

btrfs_block_rsv_release() is a void, __btrfs_block_rsv_release returns how much
was free'd.  This could be cleaned up later, but I'm purposefully trying to not
change code and just move things around.  Thanks,

Josef
