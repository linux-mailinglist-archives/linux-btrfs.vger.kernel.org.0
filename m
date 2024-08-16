Return-Path: <linux-btrfs+bounces-7230-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419F995478E
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 13:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6586D1C21D66
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 11:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B151991D2;
	Fri, 16 Aug 2024 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IreKD9hI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C557198A2A
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2024 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806595; cv=none; b=bb+FlduN82Z+Xy+wsNPKxs7mLyC4BkddlXddJSPRXWyIRSaVoDYfUF2Kiai9qG7DcWKCzzEijR/HukZoVhae64ANkuIfPOnhNSkf7IzEJnIr5niQdESSPC6lKd5YWc7UjFQn6PfjNI7EK9FQZEL+uxOHZ5y8Z5+j7ckemBOwVD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806595; c=relaxed/simple;
	bh=pYOUMBCP0WNB15J+GNvzfzDe8PXrGGnFDbD2tZOoBvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUmnXNRChhDEu48Vf83u9Glg07tf+qQQvDWAfbhF8lsWwEdW+E0JAPIMHoPIdTc5XQxg7OYUDBTYaEsjWZyw19nsXrbSYKjw1ygCMGGxa6Z+7dlS3aBge/JRPziYBQLGdmRPJ4xW01vEPtVtMXpBdiMR45KAOxbznzA7Yr/saGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IreKD9hI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DF6C32782
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2024 11:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723806594;
	bh=pYOUMBCP0WNB15J+GNvzfzDe8PXrGGnFDbD2tZOoBvo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IreKD9hIpSekT6A8nNMp5z/rB5eEQJgMffMiZ04XuH6IRkPywk9oc/GhM0myoyotK
	 aZEq6DCUOwsHl7Nm4/7me9UMV3uoZUSk78cjWZkAdnASit8HgV74z/ndIYfRRfZ/Ug
	 bFySKXuLmrlZqS7gsbUwDWR1U5ttmXmIKRw4QWgyH0caRcWEMyQUKCEJB7w2XHy9r4
	 AQYhxO2Cg6c1OpQ3ev7MBCJVlqzvyucqgBGckM+vWYmRecmVmbxIFyQUomNU6r6I8j
	 0eIYQgUH1lFK3Wejl/RMsQ41lhWsttlhnQwFNGt+2a2OZ6G4JEncZQAJT+7IZ7LtLr
	 1eJPyexu1wsig==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so26370241fa.0
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2024 04:09:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YxA1uJ4l85HRzOgUFytTSv6HrWgWJ9Dp61EKP2HRwxTMq8GYvx+
	7rQ0j3rV3OtoCk0K6uSViYaSImEdoQVZPmzwM8Q/61MrZIzoSG8Vcw10GCarLAebQHEZoQlFCA0
	iC3VZXaJ+nCWWXsqrpUyzakJE/j8=
X-Google-Smtp-Source: AGHT+IGjQbLNUi4SXf7BdqTKHxJqLAu86imFKuRicACuNqV9ITtPMQQV/Kj1V1j6Rj9FkhpnGlNIEkvHYIBcD89eKJo=
X-Received: by 2002:a05:6512:280b:b0:530:ae99:c7fa with SMTP id
 2adb3069b0e04-5331c690bddmr1575841e87.10.1723806592939; Fri, 16 Aug 2024
 04:09:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b5f8d32e8b4fb1bfb3a88f5373530980f1d2f523.1723798569.git.wqu@suse.com>
In-Reply-To: <b5f8d32e8b4fb1bfb3a88f5373530980f1d2f523.1723798569.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 16 Aug 2024 12:09:16 +0100
X-Gmail-Original-Message-ID: <CAL3q7H68VyuHLe3Y4ieBtkHk3ET3=sbXrCadK8Q9ck=EskeLEQ@mail.gmail.com>
Message-ID: <CAL3q7H68VyuHLe3Y4ieBtkHk3ET3=sbXrCadK8Q9ck=EskeLEQ@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: only run extent map shrinker inside cleaner kthread
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Ivan Shapovalov <intelfx@intelfx.name>, 
	=?UTF-8?Q?Jannik_Gl=C3=BCckert?= <jannik.glueckert@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 9:58=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> There are still reports about extent map shrinker is causing high CPU
> usage.
>
> It turns out that the call backs can be very frequent, even inside
> kswapd (and we can have multiple kswapd if the system have several
> nodes).

You mean numa nodes?
Are you sure that's the problem, and not something like tasks waiting
long for a kswapd task because it's doing extent map removal?

>
> For the only other fs implementing the reclaim callbacks, XFS does it
> very differently by ensure the following conditions:
>
> - Make sure there is only one reclaim work queued
>
> - Add a delay before queuing the reclaim workload
>   The default delay is 18s (60% of xfs_syncd_centisecs)
>
> In btrfs, there is already a context which is very similar to the XFS
> condition: cleaner kthread.
>
> There is only one cleaner kthread for the fs, and it's waken periodically
> (the same time interval as commit interval, which is 30s by default).
>
> So it's much better to run the extent map shrinker inside cleaner
> kthread.

No please, don't do it in the cleaner.

There's already a lot of different work that the cleaner does, from
running delayed iputs, to defrag inodes, remove deleted roots, etc.
Adding the shrinker there only increases the delay for those tasks and
those tasks increase the delay for the shrinker to run and free
memory.

I'd rather have this done as an unbounded work queue item like we do
for space reclaim.
In fact one thing I have in my todo list is to get rid of the cleaner
and have all work done in work queues (it's not that straightforward
as it may seem).

>
> And make the free_cached_objects() callback to only record the latest
> number to free.
>
> Link: https://lore.kernel.org/linux-btrfs/3df4acd616a07ef4d2dc6bad6687015=
04b412ffc.camel@intelfx.name/
> Link: https://lore.kernel.org/linux-btrfs/c30fd6b3-ca7a-4759-8a53-d42878b=
f84f7@gmail.com/
> Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
> Reported-by: Jannik Gl=C3=BCckert <jannik.glueckert@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
>
> I do not have an environment which can trigger the reclaim that
> frequently, thus more tests would be appreciated.

So I'd rather have time spent analysing things and testing them than
having hypothetical test patches.

>
> If one wants to test, please use this branch:
> https://github.com/adam900710/linux.git em_shrink_freq
>
> And enable CONFIG_BTRFS_DEBUG (since the previous patch hides the
> shrinker behind DEBUG builds).
>
> ---
>  fs/btrfs/disk-io.c    |  3 +++
>  fs/btrfs/extent_map.c |  3 ++-
>  fs/btrfs/extent_map.h |  2 +-
>  fs/btrfs/fs.h         |  1 +
>  fs/btrfs/super.c      | 22 +++++++---------------
>  5 files changed, 14 insertions(+), 17 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index a6f5441e62d1..624dd7552e0f 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1542,6 +1542,9 @@ static int cleaner_kthread(void *arg)
>                  * space.
>                  */
>                 btrfs_reclaim_bgs(fs_info);
> +
> +               if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
> +                       btrfs_free_extent_maps(fs_info);
>  sleep:
>                 clear_and_wake_up_bit(BTRFS_FS_CLEANER_RUNNING, &fs_info-=
>flags);
>                 if (kthread_should_park())
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 25d191f1ac10..1491429f9386 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -1248,13 +1248,14 @@ static long btrfs_scan_root(struct btrfs_root *ro=
ot, struct btrfs_em_shrink_ctx
>         return nr_dropped;
>  }
>
> -long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_sc=
an)
> +long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info)
>  {
>         struct btrfs_em_shrink_ctx ctx;
>         u64 start_root_id;
>         u64 next_root_id;
>         bool cycled =3D false;
>         long nr_dropped =3D 0;
> +       long nr_to_scan =3D READ_ONCE(fs_info->extent_map_shrinker_nr_to_=
scan);
>
>         ctx.scanned =3D 0;
>         ctx.nr_to_scan =3D nr_to_scan;
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index 5154a8f1d26c..070621b4467f 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -189,6 +189,6 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *=
inode,
>  int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
>                                    struct extent_map *new_em,
>                                    bool modified);
> -long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_sc=
an);
> +long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info);
>
>  #endif
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 3d6d4b503220..a594c8309693 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -636,6 +636,7 @@ struct btrfs_fs_info {
>         spinlock_t extent_map_shrinker_lock;
>         u64 extent_map_shrinker_last_root;
>         u64 extent_map_shrinker_last_ino;
> +       long extent_map_shrinker_nr_to_scan;
>
>         /* Protected by 'trans_lock'. */
>         struct list_head dirty_cowonly_roots;
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 98fa0f382480..5d9958063ddd 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2402,13 +2402,7 @@ static long btrfs_nr_cached_objects(struct super_b=
lock *sb, struct shrink_contro
>
>         trace_btrfs_extent_map_shrinker_count(fs_info, nr);
>
> -       /*
> -        * Only report the real number for DEBUG builds, as there are rep=
orts of
> -        * serious performance degradation caused by too frequent shrinks=
.
> -        */
> -       if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
> -               return nr;
> -       return 0;
> +       return nr;
>  }
>
>  static long btrfs_free_cached_objects(struct super_block *sb, struct shr=
ink_control *sc)
> @@ -2417,15 +2411,13 @@ static long btrfs_free_cached_objects(struct supe=
r_block *sb, struct shrink_cont
>         struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
>
>         /*
> -        * We may be called from any task trying to allocate memory and w=
e don't
> -        * want to slow it down with scanning and dropping extent maps. I=
t would
> -        * also cause heavy lock contention if many tasks concurrently en=
ter
> -        * here. Therefore only allow kswapd tasks to scan and drop exten=
t maps.
> +        * Only record the latest nr_to_scan value. The real scan will ha=
ppen
> +        * at cleaner kthread.
> +        * As free_cached_objects() can be triggered very frequently, it'=
s
> +        * not practical to scan the whole fs to reclaim extent maps.
>          */
> -       if (!current_is_kswapd())
> -               return 0;
> -
> -       return btrfs_free_extent_maps(fs_info, nr_to_scan);
> +       WRITE_ONCE(fs_info->extent_map_shrinker_nr_to_scan, nr_to_scan);

This is never reset to 0, so the shrinker will run even when we don't
need to free extent maps anymore, doing extra work, causing some
fsyncs to go to the slow path, etc.

If you can wait about 1 week for me to be back from vacation, I can
continue with plans I have for the shrinker, and just disable the
shrinker in the meanwhile.

Thanks Qu.

> +       return 0;
>  }
>
>  static const struct super_operations btrfs_super_ops =3D {
> --
> 2.46.0
>
>

