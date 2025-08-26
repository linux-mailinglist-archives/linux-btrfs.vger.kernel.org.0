Return-Path: <linux-btrfs+bounces-16424-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FF8B373CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 22:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CD5680C83
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 20:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364422C08CA;
	Tue, 26 Aug 2025 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="dmeKdsRA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DED22083
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756239913; cv=none; b=itvMYUEmVcxnKH0rcF/XqyMcNS1wGslKzpNT5dfQEjewWb68kB1iaSoaRT1MYhseDVxCYAcVx35ySca6WcA2hgPIMX6J/s9KOEzcQsNtWuBWuGDAzMqtSEIcYPCBZ+W0iL/9CgU6Lh9GRwXF8+k+UiR9yVJ8i9GK3eHkwPjzgCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756239913; c=relaxed/simple;
	bh=cMsVwJsEIt27jbh7LEYta5w8OlO5LgzPcW6GCACf1f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JC7ZZxuyfAUROVfNliL6Nj+VNH3y4EMTiFKz1Zx9eDuX+Uc3IAF/qVKyXa89SC01ZQRPs28Hya2kN4+bTLPTNR7C+asKc0K4O8N8MMpGN95jErG1/Lq90sxrX4lWcItVQ1+fFxxHFCAvKANW0nMln7QOsdovH5nXjH1Foa5k8WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=dmeKdsRA; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d601859f5so46856537b3.0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 13:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756239909; x=1756844709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hnUAbt5lSfMgTkci+pnj894VO3wJZbRmjRdQcE7tdI8=;
        b=dmeKdsRASE/OhThoMH+RcMPvkNdzvIkZ44A8pVzI0qZCnfDBct7csSB1/PZdMZXkQ3
         LrgXdDGkzcinIzt0/DVswRYFrq5/bTkOeR/jmdN2KmI1ptfKTG2aFq2GnNIzbzQZQ0yy
         U06/+Hq5MNUItpMOw72IU6/DJ0FdNwRuGKva0+kWtSCDpC8wIX2WUNeFhF9Ii94X43gl
         7YyFGDNxn0o3PAjvxq3Yg87EZ+SPwGSQFcJlX0qfGe8/Z7yaiclpmrWvRWw7eNtyEn+L
         IYia1L69UyTUi8iOo2WUu7wRr0c1m1sM2U6nAzZGUZFdp6ryTnswyObDxUhijwQP12Tz
         dFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756239909; x=1756844709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnUAbt5lSfMgTkci+pnj894VO3wJZbRmjRdQcE7tdI8=;
        b=epqGUj9X1bHLbOkj3+VmnU4meEhv9IN5Fkr+3foho1nXXGUQGmR9BZGHu4ibgs5nda
         ugr3s5Gmhr00P6EMMU/vyD0ZwRUDZ46LShE7mi6wqZXHQGU+veX+VI1OTuRqFreGNIQ/
         uNWmQ/YeIWVldF9liFQY6dYBdtMtzYr/P3DbwRQj6Se0F5OWXHTz+lEjY71SqP9XBh5n
         BbCuKw5MVxgHYDM6kapQckSjvqf6fq/5w8wKE2cr+0b9SARx9V5yx3SYXX2iH8iWGuGL
         FcGV8eDLrY+P2u+E/MapEsI2KjrgKycTgY2/dt0GVeSubdAacU86fQN9szpz9jSOp6qC
         sZGw==
X-Gm-Message-State: AOJu0YzCvfEO83XyHPGFvO/l6KuK+gAA0J8AFhtKPVetG8dcZE5Rt46e
	I+ieLxdTGIfl1MxtUhxGWsh3mHzyoyJqHsUaBaoTPMRKf1sWB05dgP6Kp2iXFuzPROA=
X-Gm-Gg: ASbGncvnDWPnOJYDxsYeGB9dbkdnFyE3b4pmxupWGZQI86oKcn0BQKX+C6QJ0WIwH8r
	3EOYGkZd5L0ujEuQjF1Jirc/vygfCH6NLsYUKoZ1xiq2sil7z89LMAucF6Zc5u9ue4mhVX4JKH5
	LIUMRL/lxjE/JmrzzZX0F+vSkbLMCZS+c3KetlCDcS56E/ReeCWYr0S+ZsS3Mqkks+2Qkrf+OGG
	vhilzuR8PHQlap2CLD0zYlOcqHorF5LXYYrLkj4JcM3NRSBFQ7gxnP+Y4juklrbA3YjWf9LzghY
	6krYuNGoDwP/jiNHmMOjVzBJXN0j8rs1eXnThfgj4re46nupTjquMDWDncLT8+lVksCTq2veRC5
	xbPJLzGx702SB49v23s0TCiO/KUcfVBi+Pb77gKRzHD/HKoCTtXg86czl20LiTJCwPF9Uig==
X-Google-Smtp-Source: AGHT+IHBdHCzb2iYv1648mBqjozZqfOvl5BFnFXpX9wvIvsBl/6i4tQYyWcQaSt66vNVkDObDhYAJw==
X-Received: by 2002:a05:690c:e1a:b0:71e:7336:9c94 with SMTP id 00721157ae682-71fdc536707mr183645187b3.32.1756239909293;
        Tue, 26 Aug 2025 13:25:09 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18ee79esm26619637b3.73.2025.08.26.13.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 13:25:08 -0700 (PDT)
Date: Tue, 26 Aug 2025 16:25:07 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	Filipe Manana <fdmanana@suse.com>,
	Leo Martins <loemra.dev@gmail.com>, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH] btrfs: fix subvolume deletion lockup caused by inodes
 xarray race
Message-ID: <20250826202507.GA2119633@perftesting>
References: <f7e05205fd33d9e510ec1295e0cc8cfdf395cb89.1756237895.git.osandov@osandov.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e05205fd33d9e510ec1295e0cc8cfdf395cb89.1756237895.git.osandov@osandov.com>

On Tue, Aug 26, 2025 at 01:01:38PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> There is a race condition between inode eviction and inode caching that
> can cause a live struct btrfs_inode to be missing from the root->inodes
> xarray. Specifically, there is a window during evict() between the inode
> being unhashed and deleted from the xarray. If btrfs_iget() is called
> for the same inode in that window, it will be recreated and inserted
> into the xarray, but then eviction will delete the new entry, leaving
> nothing in the xarray:
> 
> Thread 1                          Thread 2
> ---------------------------------------------------------------
> evict()
>   remove_inode_hash()
>                                   btrfs_iget_path()
>                                     btrfs_iget_locked()
>                                     btrfs_read_locked_inode()
>                                       btrfs_add_inode_to_root()
>   destroy_inode()
>     btrfs_destroy_inode()
>       btrfs_del_inode_from_root()
>         __xa_erase
> 
> In turn, this can cause issues for subvolume deletion. Specifically, if
> an inode is in this lost state, and all other inodes are evicted, then
> btrfs_del_inode_from_root() will call btrfs_add_dead_root() prematurely.
> If the lost inode has a delayed_node attached to it, then when
> btrfs_clean_one_deleted_snapshot() calls btrfs_kill_all_delayed_nodes(),
> it will loop forever because the delayed_nodes xarray will never become
> empty (unless memory pressure forces the inode out). We saw this
> manifest as soft lockups in production.
> 
> Fix it by only deleting the xarray entry if it matches the given inode
> (using __xa_cmpxchg()).
> 
> Fixes: 310b2f5d5a94 ("btrfs: use an xarray to track open inodes in a root")
> Cc: stable@vger.kernel.org # 6.11+
> Co-authored-by: Leo Martins <loemra.dev@gmail.com>
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Heh, I was just noticing weirdness here as I started converting inodes over to
using an xarray instead of a hash.  Nice catch,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

