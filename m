Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649164A5D5B
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 14:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbiBANWJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 08:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiBANWI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 08:22:08 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549BFC061714
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Feb 2022 05:22:08 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id p125so15293783pga.2
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Feb 2022 05:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zH9EetKIIpj8oOS9lKWFK/YMDTYS6eSrgaj73MS9i9I=;
        b=B8+ua298BD19Q1jaQq7Vki3diGBZXcap9GqOkQ3udvOyrg4ObmOQv43LGQp1+BYKvl
         CR6yz2tIZYhGyRjECJ9AU5l32G6U+/QHyFyW0WHI5hHMa1DxaVV3uR2fY32y17FcPSFk
         NjMB8Dl8V5UmkeP+eS5vWuKz+Kc5DisDuuTV7v0ynVoSnRLjIYSFIURwpR6J7JX89gbd
         u6uXDfYn5KK8tXPd82emZxIEFv/89fUpMeEGL8+JcSJZlai1PxHdecRE8Bef7sCAe550
         WzFu0ga0j8Y3FHMnpszS3nTs9V44hha+OnkuV9juAUsJFHKpSRP/aYGR3ZYP+nsAPp1k
         Xy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zH9EetKIIpj8oOS9lKWFK/YMDTYS6eSrgaj73MS9i9I=;
        b=Fl9GK/zcvGmzyuR2IS6yvpTmvi2jS9gWQC3w1YfzFgigngSM6/Pad1NGCC4vnn7QTZ
         2UTFwyUhDXhw8sPaLI9HxcFGy0d7phiRQ0wCPYoR1Xpjozd4QkWhng6pR7mVcVvFybL0
         JNqnNTOPyjcqI1UbWpptg5JX42bt3KcHabKmTDGudvhZXWSURs7JlqVo5kBNKtz1xuae
         YNZp8as/9M4XVq7iW3hCXQ3MO9qcTR3MVz58/A3Rxd3qTbyWXDx7i+8WZ8VjKEDrHmNr
         uN/gt7+XRwQT1oTIZnLSsC8dOSZrgg5M9cxlV6tNYLaxOKX+K+ksYgwdA0sVi+BhSGui
         bVKA==
X-Gm-Message-State: AOAM533qe/arpDqgdNgJnLsvWed1TgqdlueHcYSeq/H3NMDfB2LUz4Dj
        znFKuT2l56PaIi9gIrVIwB8=
X-Google-Smtp-Source: ABdhPJxvJQ+HdNfZRCng89MkBZ5jCBXnXmCqFhs44ntSoxW9fbQMfAN2cxxXllu5Z8i336i+x2BIJg==
X-Received: by 2002:a63:924c:: with SMTP id s12mr20681545pgn.257.1643721727687;
        Tue, 01 Feb 2022 05:22:07 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id mq15sm3347582pjb.8.2022.02.01.05.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 05:22:07 -0800 (PST)
Date:   Tue, 1 Feb 2022 13:22:00 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: replace modifing qgroup_flags to bitops
Message-ID: <20220201132200.GB260020@realwakka>
References: <20220201125331.260482-1-realwakka@gmail.com>
 <6ff48650-b42e-0254-a5e2-745e483acd78@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ff48650-b42e-0254-a5e2-745e483acd78@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 01, 2022 at 09:06:18PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/2/1 20:53, Sidong Yang wrote:
> > This patch replaces the code modifying or checking qgroup_flags to
> > bitops like set_bit or test_bit. These bit operations works atomically
> > that it protects qgroup_flags value.
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> >   fs/btrfs/ioctl.c  |  2 +-
> >   fs/btrfs/qgroup.c | 68 ++++++++++++++++++++++-------------------------
> 
> Oh, no btrfs_tree.h nor qgroup.h, I already know what the typical
> pitfall you fell into...

Sorry, I realized this error. 
> 
> >   2 files changed, 33 insertions(+), 37 deletions(-)
> > 
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index cc61813213d8..19b0b59abe77 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -4435,7 +4435,7 @@ static long btrfs_ioctl_quota_rescan_status(struct btrfs_fs_info *fs_info,
> >   	if (!capable(CAP_SYS_ADMIN))
> >   		return -EPERM;
> > 
> > -	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
> > +	if (test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags)) {
> 
> set/clear/test_bit() all use bit number, not the flag value...
> 
> It will still work and pass tests, as instead of
> setting/clearing/testing the first, the second or the third bit, now
> it's testing the 2nd, 4th and 8th bit.
> 
> It's not triggering any obvious bug because there are only 3 bits used.
> 
> So I'm afraid you need to first convert those flag values into bit
> number first, which would either show up in btrfs_tree.h or internally
> defined in qgroup.h.

Thanks for detailed guide. I would write a new patch for this.

Thanks,
Sidong

> 
> Thanks,
> Qu
> 
> >   		qsa.flags = 1;
> >   		qsa.progress = fs_info->qgroup_rescan_progress.objectid;
> >   	}
> > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > index db680f5be745..9fabc62ff2a5 100644
> > --- a/fs/btrfs/qgroup.c
> > +++ b/fs/btrfs/qgroup.c
> > @@ -499,16 +499,16 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
> >   out:
> >   	btrfs_free_path(path);
> >   	fs_info->qgroup_flags |= flags;
> > -	if (!(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_ON))
> > +	if (!test_bit(BTRFS_QGROUP_STATUS_FLAG_ON, &fs_info->qgroup_flags))
> >   		clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
> > -	else if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN &&
> > +	else if (test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags) &&
> >   		 ret >= 0)
> >   		ret = qgroup_rescan_init(fs_info, rescan_progress, 0);
> > 
> >   	if (ret < 0) {
> >   		ulist_free(fs_info->qgroup_ulist);
> >   		fs_info->qgroup_ulist = NULL;
> > -		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
> > +		clear_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags);
> >   		btrfs_sysfs_del_qgroups(fs_info);
> >   	}
> > 
> > @@ -1197,7 +1197,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
> >   	spin_lock(&fs_info->qgroup_lock);
> >   	quota_root = fs_info->quota_root;
> >   	fs_info->quota_root = NULL;
> > -	fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_ON;
> > +	clear_bit(BTRFS_QGROUP_STATUS_FLAG_ON, &fs_info->qgroup_flags);
> >   	spin_unlock(&fs_info->qgroup_lock);
> > 
> >   	btrfs_free_qgroup_config(fs_info);
> > @@ -1353,7 +1353,7 @@ static int quick_update_accounting(struct btrfs_fs_info *fs_info,
> >   	}
> >   out:
> >   	if (ret)
> > -		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> > +		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags);
> >   	return ret;
> >   }
> > 
> > @@ -1659,7 +1659,7 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
> > 
> >   	ret = update_qgroup_limit_item(trans, qgroup);
> >   	if (ret) {
> > -		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> > +		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags);
> >   		btrfs_info(fs_info, "unable to update quota limit for %llu",
> >   		       qgroupid);
> >   	}
> > @@ -1735,7 +1735,7 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
> >   	ret = btrfs_find_all_roots(NULL, trans->fs_info, bytenr, 0, &old_root,
> >   				   true);
> >   	if (ret < 0) {
> > -		trans->fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> > +		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &trans->fs_info->qgroup_flags);
> >   		btrfs_warn(trans->fs_info,
> >   "error accounting new delayed refs extent (err code: %d), quota inconsistent",
> >   			ret);
> > @@ -2211,7 +2211,7 @@ static int qgroup_trace_subtree_swap(struct btrfs_trans_handle *trans,
> >   out:
> >   	btrfs_free_path(dst_path);
> >   	if (ret < 0)
> > -		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> > +		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags);
> >   	return ret;
> >   }
> > 
> > @@ -2581,7 +2581,7 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
> >   	}
> > 
> >   	mutex_lock(&fs_info->qgroup_rescan_lock);
> > -	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
> > +	if (test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags)) {
> >   		if (fs_info->qgroup_rescan_progress.objectid <= bytenr) {
> >   			mutex_unlock(&fs_info->qgroup_rescan_lock);
> >   			ret = 0;
> > @@ -2715,23 +2715,23 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
> >   		spin_unlock(&fs_info->qgroup_lock);
> >   		ret = update_qgroup_info_item(trans, qgroup);
> >   		if (ret)
> > -			fs_info->qgroup_flags |=
> > -					BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> > +			set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT,
> > +					&fs_info->qgroup_flags);
> >   		ret = update_qgroup_limit_item(trans, qgroup);
> >   		if (ret)
> > -			fs_info->qgroup_flags |=
> > -					BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> > +			set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT,
> > +					&fs_info->qgroup_flags);
> >   		spin_lock(&fs_info->qgroup_lock);
> >   	}
> >   	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
> > -		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_ON;
> > +		set_bit(BTRFS_QGROUP_STATUS_FLAG_ON, &fs_info->qgroup_flags);
> >   	else
> > -		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_ON;
> > +		clear_bit(BTRFS_QGROUP_STATUS_FLAG_ON, &fs_info->qgroup_flags);
> >   	spin_unlock(&fs_info->qgroup_lock);
> > 
> >   	ret = update_qgroup_status_item(trans);
> >   	if (ret)
> > -		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> > +		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags);
> > 
> >   	return ret;
> >   }
> > @@ -2849,7 +2849,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> > 
> >   		ret = update_qgroup_limit_item(trans, dstgroup);
> >   		if (ret) {
> > -			fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> > +			set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags);
> >   			btrfs_info(fs_info,
> >   				   "unable to update quota limit for %llu",
> >   				   dstgroup->qgroupid);
> > @@ -2955,7 +2955,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> >   	if (!committing)
> >   		mutex_unlock(&fs_info->qgroup_ioctl_lock);
> >   	if (need_rescan)
> > -		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> > +		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags);
> >   	return ret;
> >   }
> > 
> > @@ -3270,10 +3270,10 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
> > 
> >   	mutex_lock(&fs_info->qgroup_rescan_lock);
> >   	if (err > 0 &&
> > -	    fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT) {
> > -		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> > +		test_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags)) {
> > +		clear_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags);
> >   	} else if (err < 0) {
> > -		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> > +		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags);
> >   	}
> >   	mutex_unlock(&fs_info->qgroup_rescan_lock);
> > 
> > @@ -3292,7 +3292,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
> > 
> >   	mutex_lock(&fs_info->qgroup_rescan_lock);
> >   	if (!stopped)
> > -		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
> > +		clear_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags);
> >   	if (trans) {
> >   		ret = update_qgroup_status_item(trans);
> >   		if (ret < 0) {
> > @@ -3332,13 +3332,11 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
> > 
> >   	if (!init_flags) {
> >   		/* we're resuming qgroup rescan at mount time */
> > -		if (!(fs_info->qgroup_flags &
> > -		      BTRFS_QGROUP_STATUS_FLAG_RESCAN)) {
> > +		if (!test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags)) {
> >   			btrfs_warn(fs_info,
> >   			"qgroup rescan init failed, qgroup rescan is not queued");
> >   			ret = -EINVAL;
> > -		} else if (!(fs_info->qgroup_flags &
> > -			     BTRFS_QGROUP_STATUS_FLAG_ON)) {
> > +		} else if (!test_bit(BTRFS_QGROUP_STATUS_FLAG_ON, &fs_info->qgroup_flags)) {
> >   			btrfs_warn(fs_info,
> >   			"qgroup rescan init failed, qgroup is not enabled");
> >   			ret = -EINVAL;
> > @@ -3351,12 +3349,11 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
> >   	mutex_lock(&fs_info->qgroup_rescan_lock);
> > 
> >   	if (init_flags) {
> > -		if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
> > +		if (test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, fs_info->qgroup_flags)) {
> >   			btrfs_warn(fs_info,
> >   				   "qgroup rescan is already in progress");
> >   			ret = -EINPROGRESS;
> > -		} else if (!(fs_info->qgroup_flags &
> > -			     BTRFS_QGROUP_STATUS_FLAG_ON)) {
> > +		} else if (!test_bit(BTRFS_QGROUP_STATUS_FLAG_ON, &fs_info->qgroup_flags)) {
> >   			btrfs_warn(fs_info,
> >   			"qgroup rescan init failed, qgroup is not enabled");
> >   			ret = -EINVAL;
> > @@ -3366,7 +3363,7 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
> >   			mutex_unlock(&fs_info->qgroup_rescan_lock);
> >   			return ret;
> >   		}
> > -		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_RESCAN;
> > +		set_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags);
> >   	}
> > 
> >   	memset(&fs_info->qgroup_rescan_progress, 0,
> > @@ -3422,12 +3419,12 @@ btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info)
> > 
> >   	trans = btrfs_join_transaction(fs_info->fs_root);
> >   	if (IS_ERR(trans)) {
> > -		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
> > +		clear_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags);
> >   		return PTR_ERR(trans);
> >   	}
> >   	ret = btrfs_commit_transaction(trans);
> >   	if (ret) {
> > -		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
> > +		clear_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags);
> >   		return ret;
> >   	}
> > 
> > @@ -3471,7 +3468,7 @@ int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
> >   void
> >   btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info)
> >   {
> > -	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
> > +	if (test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags)) {
> >   		mutex_lock(&fs_info->qgroup_rescan_lock);
> >   		fs_info->qgroup_rescan_running = true;
> >   		btrfs_queue_work(fs_info->qgroup_rescan_workers,
> > @@ -4167,8 +4164,7 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_trans_handle *trans,
> >   	spin_unlock(&blocks->lock);
> >   out:
> >   	if (ret < 0)
> > -		fs_info->qgroup_flags |=
> > -			BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> > +		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags);
> >   	return ret;
> >   }
> > 
> > @@ -4255,7 +4251,7 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
> >   		btrfs_err_rl(fs_info,
> >   			     "failed to account subtree at bytenr %llu: %d",
> >   			     subvol_eb->start, ret);
> > -		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> > +		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags);
> >   	}
> >   	return ret;
> >   }
