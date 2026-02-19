Return-Path: <linux-btrfs+bounces-21778-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKB2Gp/4lmn4swIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21778-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 12:48:47 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C903015E699
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 12:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D95B302AE02
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 11:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B04D30B52C;
	Thu, 19 Feb 2026 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnnDACdA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC822EAD1C
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771501701; cv=none; b=N49XIuIbuQhzOYYTZ8YPrIoAHGr9ynhzrOFCgvyTxMgck+++SOSBNnzqGU5oyI5YtejYugWUvObMXSchBuNy2XXQtW7kZjYymVRIZQqFQrxJ10TapQHMIXITSOBWFvRuv6nEWbKZEvvX06rmEoTKUatE0kTow+knEa963IVQPX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771501701; c=relaxed/simple;
	bh=4iYum1M+EGn3AfArpU6vHnRVKHWTGkWUnKoJ8blVoiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mx/zM4QbUQh2ChjG11ce1hxJwdIWF9rKgv3wp5dm47vWQnJJB7oZeetjPzWaRcMQI9qwwTD0Eit70FLBphMdJj4hlWzj/7QCrH+e9/RadTGEqjeP1MTyG5YvWzCU75jY+Neg4j2Cq6fnX0IGUrYKzsrIiTXA3nNcmDmjuGRQKuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnnDACdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4492AC4CEF7
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 11:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771501701;
	bh=4iYum1M+EGn3AfArpU6vHnRVKHWTGkWUnKoJ8blVoiw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XnnDACdATyI4swwqFa8SPpGV+V7NEOL0SJqHyMQEF9zoIKaBKLrerMlGUUD0cupZi
	 NDNMSM79kz5DuPSj0CCU4sJAyMhCmbQlusYLVEmqRBKe4LGb4Kd/zIsKfXU9PDNLRw
	 DCWZWIP6aTyVbMSROwj1hXHAx51aMsyjNWjyg2WXFFkRDUZ0RQoNVQvsLTKY8AKOED
	 lOdKXYuqJmSzlggcNgmrwm8rGWe6t5imlIVJYM7XE7yHSWxwf8uP/8cnTUTb40KVYi
	 2T48yceM1fAY7BppsZWehbScfmCFEPu3MFchJgqYMb2e7aBUT/Z2AD5jjn53b4lLkr
	 EMCBjbNSdDxug==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b884ad1026cso140424966b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 03:48:21 -0800 (PST)
X-Gm-Message-State: AOJu0YyQzN3qIcFDidBDkIuJ58x+ADvaEY2dPXoyKkSIFsVJb+LmP+wX
	hv+LtttPupcJXo9SmlOvcnwVExB+o8rcR/Or+oWdhm8eVMDSrbQVQYTf+E326u91+0aQJ0LGTvu
	gxUpvNbzOD2f/ve5AfsBGp+q+kZD0niM=
X-Received: by 2002:a17:907:3ea3:b0:b7a:2ba7:197e with SMTP id
 a640c23a62f3a-b903db66396mr293938366b.29.1771501699686; Thu, 19 Feb 2026
 03:48:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9cd4f22eb48de2ebca28146f6db26548a8a207e7.1766123622.git.wqu@suse.com>
In-Reply-To: <9cd4f22eb48de2ebca28146f6db26548a8a207e7.1766123622.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 19 Feb 2026 11:47:42 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7uCbcVxcTSK5hd-5_yApfCVarms0u8LGgV8RqX+s8+kw@mail.gmail.com>
X-Gm-Features: AaiRm51acYvxmVX6IT8eItl-wmZqsAdHcYOZO3fSRkaQ-P0wqH7cHlLyU7D0EVU
Message-ID: <CAL3q7H7uCbcVxcTSK5hd-5_yApfCVarms0u8LGgV8RqX+s8+kw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: mark qgroup inconsistent if dropping a large subvolume
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21778-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C903015E699
X-Rspamd-Action: no action

On Fri, Dec 19, 2025 at 5:54=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Commit 011b46c30476 ("btrfs: skip subtree scan if it's too high to avoid
> low stall in btrfs_commit_transaction()") tries to solves the problem of

solves -> solve

> long transaction hang caused by large qgroup workload triggered by
> dropping a large subtree.
>
> But there is another situation where dropping a subvolume without any
> snapshot can lead to the same problem.
>
> The only difference is that non-shared subvolume dropping triggers a lot
> of leaf rescan in one transaction. In theory btrfs_end_transaction()
> should be able to commit a transaction due to various limits, but qgroup
> workload is never part of the threshold.

What do you mean by btrfs_end_transaction() should be able to commit a
transaction?
We never trigger transaction commits there.


>
> So for now just follow the same drop_subtree_threshold for any subvolume
> drop, so that we can avoid long transaction hang.
>
> Unfortunately this means any slightly large subvolume deletion will mark
> qgroup inconsistent and needs a rescan.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent-tree.c | 10 ++++++++++
>  fs/btrfs/qgroup.c      | 14 ++++++++++++++
>  fs/btrfs/qgroup.h      |  1 +
>  3 files changed, 25 insertions(+)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 1dcd69fe97ed..59fe3d89e910 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -6151,6 +6151,16 @@ int btrfs_drop_snapshot(struct btrfs_root *root, b=
ool update_ref, bool for_reloc
>                 }
>         }
>
> +       /*
> +        * Not only high subtree can cause long qgroup workload,
> +        * a lot of level 0 drop in a single transaction can also lead
> +        * to a lot of qgroup load and freeze a transaction.

I find this confusing. So it's saying that we can do a lot of heavy
qgroup work if we drop a lot of trees that have a single node (root is
a leaf, at level 0)?

But the code added in this patch doesn't do anything about that, it
only looks at a single root to drop by checking its level against
fs_info->qgroup_drop_subtree_thres, which has a default value of 3.
That paragraph gives the idea we will check if we have many roots to
drop below the threshold and do something about it too, not just for
the case of a root at or above the threshold.

The code seems ok, it's just this comment and that part in the
changelog doesn't make sense to me.
Thanks.

> +        *
> +        * So check the level and if it's too high just mark qgroup
> +        * inconsistent instead of a possible long transaction freeze.
> +        */
> +       btrfs_qgroup_check_subvol_drop(fs_info, level);
> +
>         wc->restarted =3D test_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
>         wc->level =3D level;
>         wc->shared_level =3D -1;
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 14d393a5853d..4dfeed998c54 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -4953,3 +4953,17 @@ int btrfs_record_squota_delta(struct btrfs_fs_info=
 *fs_info,
>         spin_unlock(&fs_info->qgroup_lock);
>         return ret;
>  }
> +
> +void btrfs_qgroup_check_subvol_drop(struct btrfs_fs_info *fs_info, u8 le=
vel)
> +{
> +       u8 drop_subtree_thres;
> +
> +       if (!btrfs_qgroup_full_accounting(fs_info))
> +               return;
> +       spin_lock(&fs_info->qgroup_lock);
> +       drop_subtree_thres =3D fs_info->qgroup_drop_subtree_thres;
> +       spin_unlock(&fs_info->qgroup_lock);
> +
> +       if (level >=3D drop_subtree_thres)
> +               qgroup_mark_inconsistent(fs_info, "subvolume level reache=
d threshold");
> +}
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index a979fd59a4da..785ed16f5cc4 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -453,5 +453,6 @@ void btrfs_qgroup_destroy_extent_records(struct btrfs=
_transaction *trans);
>  bool btrfs_check_quota_leak(const struct btrfs_fs_info *fs_info);
>  int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
>                               const struct btrfs_squota_delta *delta);
> +void btrfs_qgroup_check_subvol_drop(struct btrfs_fs_info *fs_info, u8 le=
vel);
>
>  #endif
> --
> 2.52.0
>
>

