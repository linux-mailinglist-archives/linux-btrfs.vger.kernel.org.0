Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE423E9224
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 15:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhHKNEH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 09:04:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46346 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhHKNEG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 09:04:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8E07D221A4;
        Wed, 11 Aug 2021 13:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628687022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tvGe6rFj2D2IpN0Sb57EJqDnExYJmJpmJQ3O2nG2vic=;
        b=NvBcQWDeaZii66cBIECqisTd1QEGEYn9zZZ2DLXXVT55zufIzR51EcY3mOvLNuXic2y5KE
        adld9QP62v7BXHRhOLyHsW1bhhMMPPsWyoB0m4wWHBa2T5IOxzNSvlWCLZsJ88z7x8diV5
        defSMREHUi5K5lYMhNEXVi6eAaY9Fa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628687022;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tvGe6rFj2D2IpN0Sb57EJqDnExYJmJpmJQ3O2nG2vic=;
        b=jhmCXwMEgM+qF/LQsSV4AE2XbARm2zGkuNlhGhsik1ImCEfKr2G7AGnKTram8kxmhm2JQk
        xi74EcUsGFVZaAAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D84313C27;
        Wed, 11 Aug 2021 13:03:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CO4xF63KE2GbLgAAMHmgww
        (envelope-from <mpdesouza@suse.de>); Wed, 11 Aug 2021 13:03:41 +0000
Message-ID: <ac570727def61c72bc7bdaf6b00ecf6e7d32b728.camel@suse.de>
Subject: Re: [PATCH] btrfs: quota: Introduce new flag to cancel quota rescan
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Date:   Wed, 11 Aug 2021 10:03:41 -0300
In-Reply-To: <2a3969a40f76f574577f5374999eb7d24299473d.camel@suse.de>
References: <20210617123436.28327-1-mpdesouza@suse.com>
         <0fb61e88-8fab-0cda-1fe8-d37ed437d5f5@gmx.com>
         <2a3969a40f76f574577f5374999eb7d24299473d.camel@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 2021-07-28 at 13:49 -0300, Marcos Paulo de Souza wrote:
> On Thu, 2021-06-17 at 20:44 +0800, Qu Wenruo wrote:
> > On 2021/6/17 下午8:34, Marcos Paulo de Souza wrote:
> > > Until now, there wasn't a way to cancel a currently running quota
> > > rescan. The QUOTA_CTL ioctl has only commands to enable and
> > > disable,
> > > thus, no way to cancel and restart the rescan. This functionality
> > > can be
> > > useful to applications like snapper, that can create and delete
> > > snapshots, and thus restarting the quota scan can be used instead
> > > of
> > > waiting for the current scan to finish.
> > 
> > This implies there are some operations which would make qgroup
> > accounting go crazy when doing rescan.
> > 
> > My first idea is doing qgroup inherit during rescan.
> > 
> > As we can't handle it now, we will make the fs with INCONSISTENT
> > bit,
> > and forget about it.
> > 
> > But if a rescan is running, then when it finishes, the INCONSISTENT
> > bit
> > get cleared, giving a false view of the qgroup numbers.
> > 
> > I hope the commit message can have better background on this part.
> > 
> > > The new command BTRFS_QUOTA_CTL_CANCEL_RESCAN can now be used in
> > > QUOTA_CTL ioctl to reset the progress of the rescan and stopping
> > > btrfs_qgroup_rescan_worker.
> > > 
> > > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > > ---
> > > 
> > >   Can someone check if locking only qgrop_ioctl_lock is enough
> > > for
> > > this case, or
> > >   if I missed something? Thanks!
> > > 
> > >   fs/btrfs/ctree.h           |  1 +
> > >   fs/btrfs/ioctl.c           |  3 +++
> > >   fs/btrfs/qgroup.c          | 29 +++++++++++++++++++++++++++++
> > >   fs/btrfs/qgroup.h          |  1 +
> > >   include/uapi/linux/btrfs.h |  1 +
> > >   5 files changed, 35 insertions(+)
> > > 
> > > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > > index 6131b58f779f..e1f2153d4a42 100644
> > > --- a/fs/btrfs/ctree.h
> > > +++ b/fs/btrfs/ctree.h
> > > @@ -933,6 +933,7 @@ struct btrfs_fs_info {
> > > 
> > >   	/* qgroup rescan items */
> > >   	struct mutex qgroup_rescan_lock; /* protects the
> > > progress item
> > > */
> > > +	bool qgroup_cancel_rescan;
> > >   	struct btrfs_key qgroup_rescan_progress;
> > >   	struct btrfs_workqueue *qgroup_rescan_workers;
> > >   	struct completion qgroup_rescan_completion;
> > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > index 0ba98e08a029..b39b6ff4650f 100644
> > > --- a/fs/btrfs/ioctl.c
> > > +++ b/fs/btrfs/ioctl.c
> > > @@ -4206,6 +4206,9 @@ static long btrfs_ioctl_quota_ctl(struct
> > > file
> > > *file, void __user *arg)
> > >   	case BTRFS_QUOTA_CTL_DISABLE:
> > >   		ret = btrfs_quota_disable(fs_info);
> > >   		break;
> > > +	case BTRFS_QUOTA_CTL_CANCEL_RESCAN:
> > > +		ret = btrfs_quota_cancel_rescan(fs_info);
> > > +		break;
> > >   	default:
> > >   		ret = -EINVAL;
> > >   		break;
> > > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > > index d72885903b8c..077021fc63c8 100644
> > > --- a/fs/btrfs/qgroup.c
> > > +++ b/fs/btrfs/qgroup.c
> > > @@ -1233,6 +1233,21 @@ int btrfs_quota_disable(struct
> > > btrfs_fs_info
> > > *fs_info)
> > >   	return ret;
> > >   }
> > > 
> > > +int btrfs_quota_cancel_rescan(struct btrfs_fs_info *fs_info)
> > > +{
> > > +	int ret;
> > > +
> > > +	mutex_lock(&fs_info->qgroup_ioctl_lock);
> > > +	fs_info->qgroup_cancel_rescan = true;
> > > +
> > > +	ret = btrfs_qgroup_wait_for_completion(fs_info, false);
> > > +
> > > +	fs_info->qgroup_cancel_rescan = false;
> > > +	mutex_unlock(&fs_info->qgroup_ioctl_lock);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >   static void qgroup_dirty(struct btrfs_fs_info *fs_info,
> > >   			 struct btrfs_qgroup *qgroup)
> > >   {
> > > @@ -3214,6 +3229,7 @@ static void
> > > btrfs_qgroup_rescan_worker(struct
> > > btrfs_work *work)
> > >   	int err = -ENOMEM;
> > >   	int ret = 0;
> > >   	bool stopped = false;
> > > +	bool canceled = false;
> > > 
> > >   	path = btrfs_alloc_path();
> > >   	if (!path)
> > > @@ -3234,6 +3250,9 @@ static void
> > > btrfs_qgroup_rescan_worker(struct
> > > btrfs_work *work)
> > >   		}
> > >   		if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info-
> > > >flags)) 
> > > {
> > >   			err = -EINTR;
> > > +		} else if (fs_info->qgroup_cancel_rescan) {
> > > +			canceled = true;
> > > +			err = -ECANCELED;
> > >   		} else {
> > >   			err = qgroup_rescan_leaf(trans, path);
> > >   		}
> > > @@ -3280,6 +3299,14 @@ static void
> > > btrfs_qgroup_rescan_worker(struct btrfs_work *work)
> > >   		}
> > >   	}
> > >   	fs_info->qgroup_rescan_running = false;
> > > +
> > > +	/*
> > > +	 * If we cancel the current rescan, set progress to zero to
> > > start over
> > > +	 * on next rescan.
> > > +	 */
> > > +	if (canceled)
> > > +		fs_info->qgroup_rescan_progress.objectid = 0;
> > > +
> > 
> > Not sure if this is needed.
> > 
> > >   	complete_all(&fs_info->qgroup_rescan_completion);
> > >   	mutex_unlock(&fs_info->qgroup_rescan_lock);
> > > 
> > > @@ -3290,6 +3317,8 @@ static void
> > > btrfs_qgroup_rescan_worker(struct
> > > btrfs_work *work)
> > > 
> > >   	if (stopped) {
> > >   		btrfs_info(fs_info, "qgroup scan paused");
> > > +	} else if (canceled) {
> > > +		btrfs_info(fs_info, "qgroup scan canceled");
> > >   	} else if (err >= 0) {
> > >   		btrfs_info(fs_info, "qgroup scan completed%s",
> > >   			err > 0 ? " (inconsistency flag
> > > cleared)" :
> > > "");
> > > diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> > > index 7283e4f549af..ae6a42312ab8 100644
> > > --- a/fs/btrfs/qgroup.h
> > > +++ b/fs/btrfs/qgroup.h
> > > @@ -245,6 +245,7 @@ static inline u64 btrfs_qgroup_subvolid(u64
> > > qgroupid)
> > > 
> > >   int btrfs_quota_enable(struct btrfs_fs_info *fs_info);
> > >   int btrfs_quota_disable(struct btrfs_fs_info *fs_info);
> > > +int btrfs_quota_cancel_rescan(struct btrfs_fs_info *fs_info);
> > >   int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info);
> > >   void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info);
> > >   int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info
> > > *fs_info,
> > > diff --git a/include/uapi/linux/btrfs.h
> > > b/include/uapi/linux/btrfs.h
> > > index 22cd037123fa..29a66dd01df7 100644
> > > --- a/include/uapi/linux/btrfs.h
> > > +++ b/include/uapi/linux/btrfs.h
> > > @@ -714,6 +714,7 @@ struct btrfs_ioctl_get_dev_stats {
> > >   #define BTRFS_QUOTA_CTL_ENABLE	1
> > >   #define BTRFS_QUOTA_CTL_DISABLE	2
> > >   #define BTRFS_QUOTA_CTL_RESCAN__NOTUSED	3
> > > +#define BTRFS_QUOTA_CTL_CANCEL_RESCAN 4
> > 
> > Well, this needs to be determined by David.
> 
> Ping David :)

Ping v2 :)

> 
> > Despite that, it looks OK to me.
> > 
> > Thanks,
> > Qu
> > 
> > >   struct btrfs_ioctl_quota_ctl_args {
> > >   	__u64 cmd;
> > >   	__u64 status;
> > > 

