Return-Path: <linux-btrfs+bounces-11033-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F20A18CE6
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 08:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE593AC32E
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 07:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF941C07C1;
	Wed, 22 Jan 2025 07:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G3r7+s38"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339AC1DFFD
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737531768; cv=none; b=b43gIqwrys2tRTXCf0UEQzF8YnD/twEJu6+Bnjp6+Nr5krGaqGZ5WBsoHoNisOw7RfRx25DQHlyICU6JTATiF893G944dvvxyGEQ832OUx34lU1DfQU1HL4mVvrPzR5jqIXOZFJmPvHZspxW8D8ool4tG6KqNpa+eL0SAVKdW7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737531768; c=relaxed/simple;
	bh=VLCq7xujO5jtxAIgMxpmj6JhpoFnivs3ta4yBtx0qYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDZ7oPq9M7myfh1ysjBqXVGewjhUkA+qsMteMu798fSV6J0Kpah4fb/XfY+WDQEIrGqVlshMWGv+dk69mKgK3S5wBFI1eUMKJmBS2TKXLug9orlU6ou/g/iW8dCPNDGjmuRkDwPeSTZkfjVuWfXOkqModVauId5v91kQtLEaIdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G3r7+s38; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aafc9d75f8bso1046434966b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2025 23:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737531763; x=1738136563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1rkJLBKSWdYz2W8bPZBglfSs6M4BsWtulT8XdTJ5n94=;
        b=G3r7+s38+GKoTIPOPPr56RHvhjTvpaTqquE0lqnBdPMZkDeQJHLEF2gVzNQylMOzsP
         4jEDXvdpCX6dC1kCI3RidDqHgFas5YEPVJr1gC87cye81OwjPQYfh0v1A8kQ/HvU5qjq
         7t9ZLSj2nKGXvUEws8leQNtVilxSUl1lAZMeesdzgi2vHGAl2jc4i7U4Wy36RduKePqU
         5nw+kOAbpHs8oV/NcG18HGMefndvf6ntVsVZI4xbp9LM0HN6PexlOd6x5o6zCsneZUJT
         yOjoRhEx+RaEKem9yWFr0mwj9UQ+azdBHRcnRixlAJ4Hb52W92WkDyP93d6O2XT5bp01
         KMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737531763; x=1738136563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rkJLBKSWdYz2W8bPZBglfSs6M4BsWtulT8XdTJ5n94=;
        b=tcJzd3TLsJWYbqah7fj0r9uoymzYpxoB9/LlZUN7Q3bwbBeADOSg04ZjxzoBpLu6iG
         Aj6m8FyjmjwK2bbIzENkfL8chyhWTnKWPxq3Ol/4aHPCRitzpPH/8kxLSjrmcV5qODF0
         67l2WCyLiXhhzRFxrdK9xj2izzn+ROU5ihzqWO+/x9ItaziNq96TE3DJvuwEw5X9BHXc
         HAWHvyLz0BLZxfVDFyQRIZLxO32pngSNtpYXByknSaLizpZ43HD843IUDS2uGb/7WIzv
         yGJRqsuui6Roqe6KnSUCoSWFtB+NS96EByguTY0yaSQyLfa5xVil3ahCZvkN7s9/e++S
         V/Ww==
X-Gm-Message-State: AOJu0YxKdKHu9JsoaxnDdyTr50Brb+4RRY7JRdLt+1vR4QW2/pM8lBAv
	Z5kZuPYNB3+D1u4WtavtYcXrn2iTP5IkCQM/9ccHh62CoM0noVzPIy86sPiMiFAjLZI5NkLTn+s
	k1L0T10rcO0mwEPJESX6+vpzmLZp6RkWpbuMNaX26LioVrXZQkXw=
X-Gm-Gg: ASbGnctWxtdoESUpC7WzIQ0qWremi2/6Ee/NLCgu7oYwx7KVYzfe3QXSWy/oCLfPvC4
	7hmv49cgneqDX0qwlgMgbECechnieDHf0RTvFmJ7+peBJQ3+qmA==
X-Google-Smtp-Source: AGHT+IHIPJzLRaDloQUDoPKlj9LpwpjHC4id1R9FqCsPwOUjG0l7nSVaiGFrJBPo+2rIxSZKAUOAvXoGhEDWThwVY5M=
X-Received: by 2002:a17:907:3da0:b0:aab:d8df:9bbb with SMTP id
 a640c23a62f3a-ab38b42d8e0mr1924022166b.41.1737531763345; Tue, 21 Jan 2025
 23:42:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121183751.201556-1-maharmstone@fb.com>
In-Reply-To: <20250121183751.201556-1-maharmstone@fb.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 22 Jan 2025 08:42:32 +0100
X-Gm-Features: AbW1kvZQ3-xN3pxU3byirLRskSNoK29NJBTrwj2GxS-jGRMgCG3yfNOX3tCibR4
Message-ID: <CAPjX3FccHg8HUduLvOODAdj=SN3sNytOEx4TDhkKSJ+P_OVv7A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add io_stats to sysfs for dio fallbacks
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Jan 2025 at 19:38, Mark Harmstone <maharmstone@fb.com> wrote:
>
> For O_DIRECT reads and writes, both the buffer address and the file offset
> need to be aligned to the block size. Otherwise, btrfs falls back to
> doing buffered I/O, which is probably not what you want. It also creates
> portability issues, as not all filesystems do this.
>
> Add a new sysfs entry io_stats, to record how many times DIO falls back
> to doing buffered I/O. The intention is that once this is recorded, we
> can investigate the programs running on any machine where this isn't 0.

No one will understand what these stats actually mean unless this is
well documented somewhere.

And the more so these are not generic stats but btrfs specific.

So I'm wondering what other filesystems do in such a situation? Fail
with -EINVALID? Or issue a ratelimited WARNING?

Logging a warning is a very good starting point for an investigation
of the running program on a machine. Even more, the warning can point
you exactly to the offending task which the stats won't do as they are
anonymous in nature.

> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  fs/btrfs/direct-io.c |  6 ++++++
>  fs/btrfs/file.c      |  9 +++++++++
>  fs/btrfs/fs.h        |  8 ++++++++
>  fs/btrfs/sysfs.c     | 15 +++++++++++++++
>  4 files changed, 38 insertions(+)
>
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index 8567af46e16f..d388acf10f47 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -946,6 +946,12 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
>                 goto out;
>         }
>
> +       /*
> +        * We're falling back to buffered writes, increase the
> +        * dio_write_fallback counter.
> +        */
> +       atomic_inc(&fs_info->io_stats.dio_write_fallback);
> +
>         pos = iocb->ki_pos;
>         written_buffered = btrfs_buffered_write(iocb, from);
>         if (written_buffered < 0) {
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 36f51c311bb1..f74091482cb6 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -3644,10 +3644,19 @@ static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>         ssize_t ret = 0;
>
>         if (iocb->ki_flags & IOCB_DIRECT) {
> +               struct btrfs_fs_info *fs_info;
> +
>                 ret = btrfs_direct_read(iocb, to);
>                 if (ret < 0 || !iov_iter_count(to) ||
>                     iocb->ki_pos >= i_size_read(file_inode(iocb->ki_filp)))
>                         return ret;
> +
> +               /*
> +                * We're falling back to buffered reads, increase the
> +                * dio_read_fallback counter.
> +                */
> +               fs_info = BTRFS_I(iocb->ki_filp->f_inode)->root->fs_info;
> +               atomic_inc(&fs_info->io_stats.dio_read_fallback);
>         }
>
>         return filemap_read(iocb, to, ret);
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index b572d6b9730b..e659fb12cae6 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -406,6 +406,12 @@ struct btrfs_commit_stats {
>         u64 total_commit_dur;
>  };
>
> +/* Store data about I/O stats, exported via sysfs. */
> +struct btrfs_io_stats {
> +       atomic_t dio_read_fallback;
> +       atomic_t dio_write_fallback;
> +};
> +
>  struct btrfs_fs_info {
>         u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
>         unsigned long flags;
> @@ -851,6 +857,8 @@ struct btrfs_fs_info {
>         /* Updates are not protected by any lock */
>         struct btrfs_commit_stats commit_stats;
>
> +       struct btrfs_io_stats io_stats;
> +
>         /*
>          * Last generation where we dropped a non-relocation root.
>          * Use btrfs_set_last_root_drop_gen() and btrfs_get_last_root_drop_gen()
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 53b846d99ece..4dc772bc7e7b 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1526,6 +1526,20 @@ static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
>  BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
>               btrfs_bg_reclaim_threshold_store);
>
> +static ssize_t btrfs_io_stats_show(struct kobject *kobj,
> +                                  struct kobj_attribute *a, char *buf)
> +{
> +       struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> +
> +       return sysfs_emit(buf,
> +                       "dio_read_fallback %u\n"
> +                       "dio_write_fallback %u\n",
> +                       atomic_read(&fs_info->io_stats.dio_read_fallback),
> +                       atomic_read(&fs_info->io_stats.dio_write_fallback));
> +}
> +
> +BTRFS_ATTR(, io_stats, btrfs_io_stats_show);
> +
>  #ifdef CONFIG_BTRFS_EXPERIMENTAL
>  static ssize_t btrfs_offload_csum_show(struct kobject *kobj,
>                                        struct kobj_attribute *a, char *buf)
> @@ -1586,6 +1600,7 @@ static const struct attribute *btrfs_attrs[] = {
>         BTRFS_ATTR_PTR(, bg_reclaim_threshold),
>         BTRFS_ATTR_PTR(, commit_stats),
>         BTRFS_ATTR_PTR(, temp_fsid),
> +       BTRFS_ATTR_PTR(, io_stats),
>  #ifdef CONFIG_BTRFS_EXPERIMENTAL
>         BTRFS_ATTR_PTR(, offload_csum),
>  #endif
> --
> 2.45.2
>
>

