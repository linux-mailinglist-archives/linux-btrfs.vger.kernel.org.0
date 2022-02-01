Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098AA4A5CCE
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 14:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbiBANGY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 08:06:24 -0500
Received: from mout.gmx.net ([212.227.15.19]:47731 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238344AbiBANGX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Feb 2022 08:06:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643720781;
        bh=/jvOCuPuGS+tnU6uFmX93hvEGiVrfjOAEBn8VxMhDHY=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=h6jDoYScZ3QzkvhCwq7YuMm/j7kXdy2XDCdJOmyzLX70tOAPSxkqHsz78K0MnltEL
         fpO87GkMqjqjs0XfiMoE3YFiGVEF8mS5z1Frd00UqFEFtGNr5a5qFk+kX9iKLuh03K
         K6xIk7n8RWJq/x60L+KERkqU5KiaZ2esxtf7Ca0E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mlf0K-1mXXhe48uI-00ii2c; Tue, 01
 Feb 2022 14:06:21 +0100
Message-ID: <6ff48650-b42e-0254-a5e2-745e483acd78@gmx.com>
Date:   Tue, 1 Feb 2022 21:06:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] btrfs: qgroup: replace modifing qgroup_flags to bitops
Content-Language: en-US
To:     Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org
References: <20220201125331.260482-1-realwakka@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220201125331.260482-1-realwakka@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IGG3QD953QTc6Vn4uJINBLyv/vs0/U/jR3ZRXv48O1fQqpY8ohI
 G6pd8M8P77aXYzV7yTWpj0zCx3cPO/WW3OJtgSt9JrtGwD7/FPcxS9yJC1/D2g/X3YvQSGz
 NXoR5GzZeBgAttm09MuU/VW2ITq+Eh0NpAIniBYXjRrVazOMO7zrjyx+MBW3iJYYKxp738E
 YCtiElFsz/6HbBelkD86g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:62EQsk44YLg=:vWOlGjNDFznGPiMJ6Ggb/u
 +cGcDcW6uawcdCvHdexQwfdUiMZteVhgdqWyBn2pndDfwOQ3yExZe6mjYrS8Uu8nn/CHcP3Yp
 Or2+ft8DGeA+iExV1jS5aAF8u/QuBdGdkJRA+sm0oKOAxU8OPsO2LSSCuSh+BVbHD7IbX+s+q
 MduAOssne1G9Ztwy7Ds2qxWDaANXp8J6PXs+aSl4cZaB38GcWEaF6lSSVgN/261OwEsTfxnjE
 q8EF0Te4b7KXex8DcepKhmZUK6BrZcFss4rFnGXHw7GNlmpY0pYF7so+wxrmvL77Pbn9ANgUm
 0b2OCQP2PRHD+9kXzL4MPbKf54lCNKOjv+PjT5oDGimDM1osHSeV42AHURFzP0CcpCQJpC1vs
 Z8HBt3e0ICFzYtBLP8hm5MAxOFNhiWzs/yG/diSJdERSr2OQJKg+3rtDJfv34QtNBby+qABNK
 YLU/Alc6TmLPVPLZfHbxjTbdPrfP2XP8cREG0b1QpUJebQTK7wrN5/RD+KyXhpwN1QlDTMhIh
 wvv7e5wSXzXqSvOXnPCvBQj/tG8T2QJOkg7j2WA7yXHMAJqu+WftL8TRzgcrUaBFs2NfQTrCy
 owuUrmFeApeSGVWDCbbZMo7Dh+dc/iGIrabb4P98LYuvW6lsuHz0M0CyQkG3z6VQRQr8lkfL4
 DpNLjhOJLtq9n26dVjOzH6BNE1bipW8Ho3Wxb1Pp3eAdJ5bUCpS99svq+mrOMTgxlIqgt4JM4
 oz1BCTpRO5KfWewBbf2q/dBjN96eWBAJymXNzQ2aJGKAnJdxh/D+X6Mey5ACBi1RZ5o8qImQN
 w+47BdqyKW4lzsepF33jOv3XEnebo6PiFzlt2L/z1fgseLbdo0DWZ3zI/5hREbGOhHfmJL90l
 XXB/FprkyyBfzzM+PG85JZGr6c8GO5h146dnkKa0Vokpbbktucn1PR9qOb8nikFBak8yUpB3u
 8zB8BP6PYksEWDjVQDXSH/smOpCziGDNqK+N9FURUhSqEV0t/MjVeO3tsgwXWsSTcOvAlRO7h
 mj1lOfQv0WBP3q2AjPh/POp0+i8l4QN4oL/F2EuFx1/LiU3kM22M8zTx6U3MaMzeBPuPpQxbO
 flYB/0117+xny4=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/1 20:53, Sidong Yang wrote:
> This patch replaces the code modifying or checking qgroup_flags to
> bitops like set_bit or test_bit. These bit operations works atomically
> that it protects qgroup_flags value.
>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>   fs/btrfs/ioctl.c  |  2 +-
>   fs/btrfs/qgroup.c | 68 ++++++++++++++++++++++-------------------------

Oh, no btrfs_tree.h nor qgroup.h, I already know what the typical
pitfall you fell into...

>   2 files changed, 33 insertions(+), 37 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index cc61813213d8..19b0b59abe77 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4435,7 +4435,7 @@ static long btrfs_ioctl_quota_rescan_status(struct=
 btrfs_fs_info *fs_info,
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>
> -	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
> +	if (test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags))=
 {

set/clear/test_bit() all use bit number, not the flag value...

It will still work and pass tests, as instead of
setting/clearing/testing the first, the second or the third bit, now
it's testing the 2nd, 4th and 8th bit.

It's not triggering any obvious bug because there are only 3 bits used.

So I'm afraid you need to first convert those flag values into bit
number first, which would either show up in btrfs_tree.h or internally
defined in qgroup.h.

Thanks,
Qu

>   		qsa.flags =3D 1;
>   		qsa.progress =3D fs_info->qgroup_rescan_progress.objectid;
>   	}
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index db680f5be745..9fabc62ff2a5 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -499,16 +499,16 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info =
*fs_info)
>   out:
>   	btrfs_free_path(path);
>   	fs_info->qgroup_flags |=3D flags;
> -	if (!(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_ON))
> +	if (!test_bit(BTRFS_QGROUP_STATUS_FLAG_ON, &fs_info->qgroup_flags))
>   		clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
> -	else if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN &&
> +	else if (test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_fl=
ags) &&
>   		 ret >=3D 0)
>   		ret =3D qgroup_rescan_init(fs_info, rescan_progress, 0);
>
>   	if (ret < 0) {
>   		ulist_free(fs_info->qgroup_ulist);
>   		fs_info->qgroup_ulist =3D NULL;
> -		fs_info->qgroup_flags &=3D ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
> +		clear_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags);
>   		btrfs_sysfs_del_qgroups(fs_info);
>   	}
>
> @@ -1197,7 +1197,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_i=
nfo)
>   	spin_lock(&fs_info->qgroup_lock);
>   	quota_root =3D fs_info->quota_root;
>   	fs_info->quota_root =3D NULL;
> -	fs_info->qgroup_flags &=3D ~BTRFS_QGROUP_STATUS_FLAG_ON;
> +	clear_bit(BTRFS_QGROUP_STATUS_FLAG_ON, &fs_info->qgroup_flags);
>   	spin_unlock(&fs_info->qgroup_lock);
>
>   	btrfs_free_qgroup_config(fs_info);
> @@ -1353,7 +1353,7 @@ static int quick_update_accounting(struct btrfs_fs=
_info *fs_info,
>   	}
>   out:
>   	if (ret)
> -		fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> +		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags=
);
>   	return ret;
>   }
>
> @@ -1659,7 +1659,7 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *=
trans, u64 qgroupid,
>
>   	ret =3D update_qgroup_limit_item(trans, qgroup);
>   	if (ret) {
> -		fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> +		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags=
);
>   		btrfs_info(fs_info, "unable to update quota limit for %llu",
>   		       qgroupid);
>   	}
> @@ -1735,7 +1735,7 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_tr=
ans_handle *trans,
>   	ret =3D btrfs_find_all_roots(NULL, trans->fs_info, bytenr, 0, &old_ro=
ot,
>   				   true);
>   	if (ret < 0) {
> -		trans->fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_INCONSISTE=
NT;
> +		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &trans->fs_info->qgrou=
p_flags);
>   		btrfs_warn(trans->fs_info,
>   "error accounting new delayed refs extent (err code: %d), quota incons=
istent",
>   			ret);
> @@ -2211,7 +2211,7 @@ static int qgroup_trace_subtree_swap(struct btrfs_=
trans_handle *trans,
>   out:
>   	btrfs_free_path(dst_path);
>   	if (ret < 0)
> -		fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> +		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags=
);
>   	return ret;
>   }
>
> @@ -2581,7 +2581,7 @@ int btrfs_qgroup_account_extent(struct btrfs_trans=
_handle *trans, u64 bytenr,
>   	}
>
>   	mutex_lock(&fs_info->qgroup_rescan_lock);
> -	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
> +	if (test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags))=
 {
>   		if (fs_info->qgroup_rescan_progress.objectid <=3D bytenr) {
>   			mutex_unlock(&fs_info->qgroup_rescan_lock);
>   			ret =3D 0;
> @@ -2715,23 +2715,23 @@ int btrfs_run_qgroups(struct btrfs_trans_handle =
*trans)
>   		spin_unlock(&fs_info->qgroup_lock);
>   		ret =3D update_qgroup_info_item(trans, qgroup);
>   		if (ret)
> -			fs_info->qgroup_flags |=3D
> -					BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> +			set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT,
> +					&fs_info->qgroup_flags);
>   		ret =3D update_qgroup_limit_item(trans, qgroup);
>   		if (ret)
> -			fs_info->qgroup_flags |=3D
> -					BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> +			set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT,
> +					&fs_info->qgroup_flags);
>   		spin_lock(&fs_info->qgroup_lock);
>   	}
>   	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
> -		fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_ON;
> +		set_bit(BTRFS_QGROUP_STATUS_FLAG_ON, &fs_info->qgroup_flags);
>   	else
> -		fs_info->qgroup_flags &=3D ~BTRFS_QGROUP_STATUS_FLAG_ON;
> +		clear_bit(BTRFS_QGROUP_STATUS_FLAG_ON, &fs_info->qgroup_flags);
>   	spin_unlock(&fs_info->qgroup_lock);
>
>   	ret =3D update_qgroup_status_item(trans);
>   	if (ret)
> -		fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> +		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags=
);
>
>   	return ret;
>   }
> @@ -2849,7 +2849,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle=
 *trans, u64 srcid,
>
>   		ret =3D update_qgroup_limit_item(trans, dstgroup);
>   		if (ret) {
> -			fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> +			set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flag=
s);
>   			btrfs_info(fs_info,
>   				   "unable to update quota limit for %llu",
>   				   dstgroup->qgroupid);
> @@ -2955,7 +2955,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle=
 *trans, u64 srcid,
>   	if (!committing)
>   		mutex_unlock(&fs_info->qgroup_ioctl_lock);
>   	if (need_rescan)
> -		fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> +		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags=
);
>   	return ret;
>   }
>
> @@ -3270,10 +3270,10 @@ static void btrfs_qgroup_rescan_worker(struct bt=
rfs_work *work)
>
>   	mutex_lock(&fs_info->qgroup_rescan_lock);
>   	if (err > 0 &&
> -	    fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT) {
> -		fs_info->qgroup_flags &=3D ~BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> +		test_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flag=
s)) {
> +		clear_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_fla=
gs);
>   	} else if (err < 0) {
> -		fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> +		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags=
);
>   	}
>   	mutex_unlock(&fs_info->qgroup_rescan_lock);
>
> @@ -3292,7 +3292,7 @@ static void btrfs_qgroup_rescan_worker(struct btrf=
s_work *work)
>
>   	mutex_lock(&fs_info->qgroup_rescan_lock);
>   	if (!stopped)
> -		fs_info->qgroup_flags &=3D ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
> +		clear_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags);
>   	if (trans) {
>   		ret =3D update_qgroup_status_item(trans);
>   		if (ret < 0) {
> @@ -3332,13 +3332,11 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info=
, u64 progress_objectid,
>
>   	if (!init_flags) {
>   		/* we're resuming qgroup rescan at mount time */
> -		if (!(fs_info->qgroup_flags &
> -		      BTRFS_QGROUP_STATUS_FLAG_RESCAN)) {
> +		if (!test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags=
)) {
>   			btrfs_warn(fs_info,
>   			"qgroup rescan init failed, qgroup rescan is not queued");
>   			ret =3D -EINVAL;
> -		} else if (!(fs_info->qgroup_flags &
> -			     BTRFS_QGROUP_STATUS_FLAG_ON)) {
> +		} else if (!test_bit(BTRFS_QGROUP_STATUS_FLAG_ON, &fs_info->qgroup_fl=
ags)) {
>   			btrfs_warn(fs_info,
>   			"qgroup rescan init failed, qgroup is not enabled");
>   			ret =3D -EINVAL;
> @@ -3351,12 +3349,11 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info=
, u64 progress_objectid,
>   	mutex_lock(&fs_info->qgroup_rescan_lock);
>
>   	if (init_flags) {
> -		if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
> +		if (test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, fs_info->qgroup_flags))=
 {
>   			btrfs_warn(fs_info,
>   				   "qgroup rescan is already in progress");
>   			ret =3D -EINPROGRESS;
> -		} else if (!(fs_info->qgroup_flags &
> -			     BTRFS_QGROUP_STATUS_FLAG_ON)) {
> +		} else if (!test_bit(BTRFS_QGROUP_STATUS_FLAG_ON, &fs_info->qgroup_fl=
ags)) {
>   			btrfs_warn(fs_info,
>   			"qgroup rescan init failed, qgroup is not enabled");
>   			ret =3D -EINVAL;
> @@ -3366,7 +3363,7 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, =
u64 progress_objectid,
>   			mutex_unlock(&fs_info->qgroup_rescan_lock);
>   			return ret;
>   		}
> -		fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_RESCAN;
> +		set_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags);
>   	}
>
>   	memset(&fs_info->qgroup_rescan_progress, 0,
> @@ -3422,12 +3419,12 @@ btrfs_qgroup_rescan(struct btrfs_fs_info *fs_inf=
o)
>
>   	trans =3D btrfs_join_transaction(fs_info->fs_root);
>   	if (IS_ERR(trans)) {
> -		fs_info->qgroup_flags &=3D ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
> +		clear_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags);
>   		return PTR_ERR(trans);
>   	}
>   	ret =3D btrfs_commit_transaction(trans);
>   	if (ret) {
> -		fs_info->qgroup_flags &=3D ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
> +		clear_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags);
>   		return ret;
>   	}
>
> @@ -3471,7 +3468,7 @@ int btrfs_qgroup_wait_for_completion(struct btrfs_=
fs_info *fs_info,
>   void
>   btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info)
>   {
> -	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
> +	if (test_bit(BTRFS_QGROUP_STATUS_FLAG_RESCAN, &fs_info->qgroup_flags))=
 {
>   		mutex_lock(&fs_info->qgroup_rescan_lock);
>   		fs_info->qgroup_rescan_running =3D true;
>   		btrfs_queue_work(fs_info->qgroup_rescan_workers,
> @@ -4167,8 +4164,7 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_t=
rans_handle *trans,
>   	spin_unlock(&blocks->lock);
>   out:
>   	if (ret < 0)
> -		fs_info->qgroup_flags |=3D
> -			BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> +		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags=
);
>   	return ret;
>   }
>
> @@ -4255,7 +4251,7 @@ int btrfs_qgroup_trace_subtree_after_cow(struct bt=
rfs_trans_handle *trans,
>   		btrfs_err_rl(fs_info,
>   			     "failed to account subtree at bytenr %llu: %d",
>   			     subvol_eb->start, ret);
> -		fs_info->qgroup_flags |=3D BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> +		set_bit(BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT, &fs_info->qgroup_flags=
);
>   	}
>   	return ret;
>   }
