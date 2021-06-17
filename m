Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EED93AB3E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jun 2021 14:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhFQMqt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Jun 2021 08:46:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:37589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230473AbhFQMqt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Jun 2021 08:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623933878;
        bh=PTXQYxO6JSI9AXWmyiLxLwAgQ9Pu12N+Ve2ZFnPJQhg=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=aVl1Xg2AILJ5+1Ssw4sqeakTmMk2hOMYdgnjwBivSwRGJ6Fo/1Jz047xZfgC4foFR
         0HZ8SmNeWWeUb1tXd72yv+MFA6poheemzRUFl76zNvUuQ3/MEmXEjz+mgFHZN5Tf+L
         mUaE1D/58uSt/Ea5nC9QiOa0ET1+gr0nRQE17d+8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGyxX-1m6HZN0UeB-00E4Im; Thu, 17
 Jun 2021 14:44:38 +0200
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, wqu@suse.com
References: <20210617123436.28327-1-mpdesouza@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: quota: Introduce new flag to cancel quota rescan
Message-ID: <0fb61e88-8fab-0cda-1fe8-d37ed437d5f5@gmx.com>
Date:   Thu, 17 Jun 2021 20:44:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210617123436.28327-1-mpdesouza@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JiSLseyM55KSwu5gxjsU7sHEMry6gHVp7rkqit7VkhASq6Sqorr
 OURqGPnQxZT7RgdGv0qMH6uvcdeH/dHXaLnShYHwTMA+EY7Mxg6lfMQU6mqrKFGdRgR7oE6
 hHM3jEODbPGh3fe7tFvHbO7gHIKkaMNQ0AvnA9EOvroF3WNQ3zU03m1MfXhmnAwxQpWg6LM
 zGeMAYIClA5RmeKtwZqVg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gJNBKdXRVEg=:yyohzHB73BZlkS6RmMl3SK
 Rm8ReBEbdnWJQzUPXmkvfdmqcZnAkUVlsUExBPoTPYWWetIyJc2J6FSC3GNeuuYUA65P7nB0H
 zfsDnH5rm5NeR2ljy74tKpYPrmcksyERrwtS/gc0YNQ9LVcMDqt63NrdB6NZUKcvFqvZ6AE4W
 V3d89EyOyBmhK+6jtpogLu9Z37w0JwFF8YRDPK/KzfHD8D/WSI1OgLSVUYP/tbPLjBXrUrX34
 wjM+3FpzDVWhsVQK1XMwzgGYvz8pbscwFnj5w7ZCob173NkK7wZQQhGcQSA6zPjufQq6lMIlO
 Grbxjn1HRLVex2agHuJ9XR3hZ1Buwmifk14HuKGwNpD9Ukk3I17NAhLgTTuX/QReldOlXrOot
 clbeRjowgKIkpFdzkAnBa3cjUkXPOFJYzMduOPm64S9qStlgIK8Gk/mq/Dt+m4bfkgOnmnsjF
 wZenQNoQX+ppJk6bWKb/mHaq2z/cM5KX6Gpfyu6RmJf1d5rCmmXJj08Sh9z3n250J7Oq2Owk5
 azR7jdOEh2WM6/NyGPb+21AZGpoduIeMeyRmiBbfMDCb+sVnaW2d3xH576qceA7cHO1k+FjwA
 fk8xVza67767a+y/G63HjXErre3f9B2oOgTFsd2wxHV+2n8KCyxHxEnd0n9D+ZMsNkBjmrkw+
 XKBGYkQkxl1fd7soE6KNBYJayXhB9jQK4lbHRg65LRT47Cv2LZEQKZqZWRHeQTXyPbUztzXwP
 tPMafCDmEHxthcdEdLziwUs0tiafiPHn0eHTHFNDT4fXUSAMmSXezD382jgkXv+g75p26Uxbm
 lxNjC4Rt9UbaHfz7QOonsC5Yb2NokAymff9iy4x6v60QY/HK9DyWruXOanlApQMP7kBBrrPlQ
 uts5+FJ39REb1RtKzCcuNPWaw/mxKHwrAdEEGzj+eibA1a8kaxTCbEDOXINTSc5rHZldkVN7S
 yQAKKHh6oeokjpFtsJmZil/rcvcGMKm9x0u0GLXijs4ak14r7tE2wZF/5xlx8lMeTqgjQTJ9P
 y7+gYuYrt6KW9zbzleWzotTQBJFsMuXDj8tyURFttgWizabtUspPLTfSg0OrIvSmaPL3YHtZe
 bNjmwK58bzoup6OmgeIZCDN2zmKs0+RFt3WDVp1iw32QaZK/MXd1StZJw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/17 =E4=B8=8B=E5=8D=888:34, Marcos Paulo de Souza wrote:
> Until now, there wasn't a way to cancel a currently running quota
> rescan. The QUOTA_CTL ioctl has only commands to enable and disable,
> thus, no way to cancel and restart the rescan. This functionality can be
> useful to applications like snapper, that can create and delete
> snapshots, and thus restarting the quota scan can be used instead of
> waiting for the current scan to finish.

This implies there are some operations which would make qgroup
accounting go crazy when doing rescan.

My first idea is doing qgroup inherit during rescan.

As we can't handle it now, we will make the fs with INCONSISTENT bit,
and forget about it.

But if a rescan is running, then when it finishes, the INCONSISTENT bit
get cleared, giving a false view of the qgroup numbers.

I hope the commit message can have better background on this part.

>
> The new command BTRFS_QUOTA_CTL_CANCEL_RESCAN can now be used in
> QUOTA_CTL ioctl to reset the progress of the rescan and stopping
> btrfs_qgroup_rescan_worker.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>
>   Can someone check if locking only qgrop_ioctl_lock is enough for this =
case, or
>   if I missed something? Thanks!
>
>   fs/btrfs/ctree.h           |  1 +
>   fs/btrfs/ioctl.c           |  3 +++
>   fs/btrfs/qgroup.c          | 29 +++++++++++++++++++++++++++++
>   fs/btrfs/qgroup.h          |  1 +
>   include/uapi/linux/btrfs.h |  1 +
>   5 files changed, 35 insertions(+)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 6131b58f779f..e1f2153d4a42 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -933,6 +933,7 @@ struct btrfs_fs_info {
>
>   	/* qgroup rescan items */
>   	struct mutex qgroup_rescan_lock; /* protects the progress item */
> +	bool qgroup_cancel_rescan;
>   	struct btrfs_key qgroup_rescan_progress;
>   	struct btrfs_workqueue *qgroup_rescan_workers;
>   	struct completion qgroup_rescan_completion;
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 0ba98e08a029..b39b6ff4650f 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4206,6 +4206,9 @@ static long btrfs_ioctl_quota_ctl(struct file *fil=
e, void __user *arg)
>   	case BTRFS_QUOTA_CTL_DISABLE:
>   		ret =3D btrfs_quota_disable(fs_info);
>   		break;
> +	case BTRFS_QUOTA_CTL_CANCEL_RESCAN:
> +		ret =3D btrfs_quota_cancel_rescan(fs_info);
> +		break;
>   	default:
>   		ret =3D -EINVAL;
>   		break;
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index d72885903b8c..077021fc63c8 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1233,6 +1233,21 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_=
info)
>   	return ret;
>   }
>
> +int btrfs_quota_cancel_rescan(struct btrfs_fs_info *fs_info)
> +{
> +	int ret;
> +
> +	mutex_lock(&fs_info->qgroup_ioctl_lock);
> +	fs_info->qgroup_cancel_rescan =3D true;
> +
> +	ret =3D btrfs_qgroup_wait_for_completion(fs_info, false);
> +
> +	fs_info->qgroup_cancel_rescan =3D false;
> +	mutex_unlock(&fs_info->qgroup_ioctl_lock);
> +
> +	return ret;
> +}
> +
>   static void qgroup_dirty(struct btrfs_fs_info *fs_info,
>   			 struct btrfs_qgroup *qgroup)
>   {
> @@ -3214,6 +3229,7 @@ static void btrfs_qgroup_rescan_worker(struct btrf=
s_work *work)
>   	int err =3D -ENOMEM;
>   	int ret =3D 0;
>   	bool stopped =3D false;
> +	bool canceled =3D false;
>
>   	path =3D btrfs_alloc_path();
>   	if (!path)
> @@ -3234,6 +3250,9 @@ static void btrfs_qgroup_rescan_worker(struct btrf=
s_work *work)
>   		}
>   		if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
>   			err =3D -EINTR;
> +		} else if (fs_info->qgroup_cancel_rescan) {
> +			canceled =3D true;
> +			err =3D -ECANCELED;
>   		} else {
>   			err =3D qgroup_rescan_leaf(trans, path);
>   		}
> @@ -3280,6 +3299,14 @@ static void btrfs_qgroup_rescan_worker(struct btr=
fs_work *work)
>   		}
>   	}
>   	fs_info->qgroup_rescan_running =3D false;
> +
> +	/*
> +	 * If we cancel the current rescan, set progress to zero to start over
> +	 * on next rescan.
> +	 */
> +	if (canceled)
> +		fs_info->qgroup_rescan_progress.objectid =3D 0;
> +

Not sure if this is needed.

>   	complete_all(&fs_info->qgroup_rescan_completion);
>   	mutex_unlock(&fs_info->qgroup_rescan_lock);
>
> @@ -3290,6 +3317,8 @@ static void btrfs_qgroup_rescan_worker(struct btrf=
s_work *work)
>
>   	if (stopped) {
>   		btrfs_info(fs_info, "qgroup scan paused");
> +	} else if (canceled) {
> +		btrfs_info(fs_info, "qgroup scan canceled");
>   	} else if (err >=3D 0) {
>   		btrfs_info(fs_info, "qgroup scan completed%s",
>   			err > 0 ? " (inconsistency flag cleared)" : "");
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index 7283e4f549af..ae6a42312ab8 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -245,6 +245,7 @@ static inline u64 btrfs_qgroup_subvolid(u64 qgroupid=
)
>
>   int btrfs_quota_enable(struct btrfs_fs_info *fs_info);
>   int btrfs_quota_disable(struct btrfs_fs_info *fs_info);
> +int btrfs_quota_cancel_rescan(struct btrfs_fs_info *fs_info);
>   int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info);
>   void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info);
>   int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index 22cd037123fa..29a66dd01df7 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -714,6 +714,7 @@ struct btrfs_ioctl_get_dev_stats {
>   #define BTRFS_QUOTA_CTL_ENABLE	1
>   #define BTRFS_QUOTA_CTL_DISABLE	2
>   #define BTRFS_QUOTA_CTL_RESCAN__NOTUSED	3
> +#define BTRFS_QUOTA_CTL_CANCEL_RESCAN 4

Well, this needs to be determined by David.

Despite that, it looks OK to me.

Thanks,
Qu

>   struct btrfs_ioctl_quota_ctl_args {
>   	__u64 cmd;
>   	__u64 status;
>
