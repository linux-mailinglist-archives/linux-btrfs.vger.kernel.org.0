Return-Path: <linux-btrfs+bounces-12085-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E7BA56703
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 12:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C471897DD5
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 11:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461D3217673;
	Fri,  7 Mar 2025 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X84mUDUN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DAB20F083
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347979; cv=none; b=Ae98DjJsGP+n2mLl/kkLQmWKzlPBHQz12k7k5cCyun5UbcDKYFMyPT27YzoyyfEJo+p+w6Wy1FGHi6YBVuHqzYalzlvwfKiVWJwOyvTAX18gLBSr1VlROxLr/qTawDsSwqBGMZZrhIwls1hQKSKPMcbooB3x39q4+RAaYaLCj58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347979; c=relaxed/simple;
	bh=sbhmXiTZCSvCzYAWDZTPIv5FNojcW6vCEwH2H7w4Unc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aummWpNeeE6jqaodVceNIdShhb2yfKdYq9lZ2KFhph9RZ5Ksd3jqu5ByRV95lGHR0cVI7GUwlfrBOSgGTyqSruDVipS5RaZqQIuAR0ZHdG5hz/lU63Vp/p7mPgUoUp0eTJutY1QfKB6ASPknWh8GNCPV8UTi/Gd4atgWMgk8CZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X84mUDUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF135C4CED1
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 11:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741347975;
	bh=sbhmXiTZCSvCzYAWDZTPIv5FNojcW6vCEwH2H7w4Unc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X84mUDUNvhm2VWQfI/i9WO6Bb6Mq1zMDMMTpw+EnZxuULIn6BI0F5HbDxPJHjCIno
	 dfboSL84gJeyyJskJonesZ9Uv53YqEyLhQUMnaxPbgmlUI0z9n1JcQSEeXWJmGlg9M
	 pQ956pLuhSMkosYzZ+MMNjH9JdcsVcuz2LH6K68FcGbae3/EuLVg+0DBw9KTGoD9wg
	 XoT6QOyfMF0yGIcWjMVkzQ6uFC2tAC4iU0OUU/DUY0KBUC9KqEd6ykjzDzfZP2WtmS
	 n0ALvIjOv7K3c//Ts7CNr0m2OAQwvfyVuW9qfafjcLBgQKceCA2x9Yq73URWcXTAcU
	 wwDT3blD1kiLA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaecf50578eso330359566b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Mar 2025 03:46:14 -0800 (PST)
X-Gm-Message-State: AOJu0YwcZdZnZnmU3HHnu5Tzw3/Y0IaV6Y26QLricK+jp2Wjm/LcYV8p
	oCXgQPw1d+5dH9nTwOgQSC3gBnIrHWwvOc/DIl5nRV3GVlCz9a4oBOo93ErNAbhhSvEYxud5GWB
	mLzDVyoJFG88RRFSeTqGmyUuXI68=
X-Google-Smtp-Source: AGHT+IGz7VHCxE06no1GReFfTGiAIxHu/q3hW/+hS4VjraLPHA5K5NPY6vXmEfo/pjHZEsU443yR6ZdxsP4Mar2ltmA=
X-Received: by 2002:a17:906:dc8e:b0:abf:75ba:c99f with SMTP id
 a640c23a62f3a-ac252f8ffdcmr329700466b.46.1741347973463; Fri, 07 Mar 2025
 03:46:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741321288.git.wqu@suse.com> <b74cc16979970a14aae45eba0c8ac792389ed473.1741321288.git.wqu@suse.com>
In-Reply-To: <b74cc16979970a14aae45eba0c8ac792389ed473.1741321288.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 7 Mar 2025 11:45:35 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4OA=CPBw9ft+3F8onjuHafaAqJRQx7gXpSjLQ88eBHBw@mail.gmail.com>
X-Gm-Features: AQ5f1Jo3yEKVyjdNFJ0IEUB-ryCxjQHrs90rLLxyTew2MVdxjXT4sQFody2c9V0
Message-ID: <CAL3q7H4OA=CPBw9ft+3F8onjuHafaAqJRQx7gXpSjLQ88eBHBw@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: add extra warning if delayed iput is added
 when it's not allowed
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 4:27=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Since I have triggered the ASSERT() on the delayed iput too many times,
> now is the time to add some extra debug warnings for delayed iput.
>
> After all btrfs_commit_super() calls, we should no longer allow any new
> delayed iput being added.
>
> So introduce a new BTRFS_FS_STATE_NO_DELAYED_IPUT for debug builds, set
> after above mentioned timing.
> And all btrfs_add_delayed_iput() will check that flag and give a
> WARN_ON_ONCE().
>
> I really hope this warning will never be triggered.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c | 3 +++
>  fs/btrfs/fs.h      | 4 ++++
>  fs/btrfs/inode.c   | 4 ++++
>  3 files changed, 11 insertions(+)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 320136a59db2..bb20c015b779 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4417,6 +4417,9 @@ void __cold close_ctree(struct btrfs_fs_info *fs_in=
fo)
>                 if (ret)
>                         btrfs_err(fs_info, "commit super ret %d", ret);
>         }
> +#ifdef CONFIG_BTRFS_DEBUG
> +       set_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->fs_state);
> +#endif

We'll want this earlier, right after we call
btrfs_run_delayed_iputs(), so that we don't miss the case where for
example we are forgetting to flush some queue and then the delayed
iput is added after running iputs and before calling
btfs_commit_super(), or right after calling btrfs_commit_super() and
before setting the bit.

>
>         kthread_stop(fs_info->transaction_kthread);
>         kthread_stop(fs_info->cleaner_kthread);
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index b8c2e59ffc43..ee298dd0f568 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -117,6 +117,10 @@ enum {
>         /* Indicates there was an error cleaning up a log tree. */
>         BTRFS_FS_STATE_LOG_CLEANUP_ERROR,
>
> +#ifdef CONFIG_BTRFS_DEBUG
> +       /* No more delayed iput can be queued. */
> +       BTRFS_FS_STATE_NO_DELAYED_IPUT,
> +#endif
>         BTRFS_FS_STATE_COUNT
>  };
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8ac4858b70e7..d2bf81c08f13 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3435,6 +3435,10 @@ void btrfs_add_delayed_iput(struct btrfs_inode *in=
ode)
>         if (atomic_add_unless(&inode->vfs_inode.i_count, -1, 1))
>                 return;
>
> +#ifdef CONFIG_BTRFS_DEBUG
> +       WARN_ON_ONCE(test_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->f=
s_state));
> +#endif
> +

I would get rid of the #ifdef CONFIG_BTRFS_DEBUG everywhere. It's very
cheap code, negligible.

Thanks.



>         atomic_inc(&fs_info->nr_delayed_iputs);
>         /*
>          * Need to be irq safe here because we can be called from either =
an irq
> --
> 2.48.1
>

