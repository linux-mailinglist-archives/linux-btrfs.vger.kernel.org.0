Return-Path: <linux-btrfs+bounces-13537-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 819C6AA4521
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 10:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231851895B97
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 08:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5916A21423E;
	Wed, 30 Apr 2025 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V/XXfSFh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46456AD3
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001292; cv=none; b=txvl2slq0C8j4GjV8wafPyOoVEMAgurtlTBnTLop71gDWc2nEbi8g5fsB0wmhJ9/xZrUZWn8/bnGJGG9wj0MvnvOFftZUtQVS92IC47tkT5WzwNaIh/vxC8zkdRP9WYfL0Yr3cv00jBGPduPi1LjsAhqhq4+njxE1PzBuJ1hWYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001292; c=relaxed/simple;
	bh=fmtdM2CPWNoSGtqCaZKgL0xYYYt6+JNVVhkMJ+bSf78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFywA9coTGv2PnepS8Kh/SrkRCX58TJruz3DSd6ne7VPQxQRq7TuHFtjhxSjFglU1ojBqHgeZRA+WDRMttguPAllV51cYC3f/oQ6GzlwyOFl+uLEwycDQP4t0UOHOFGPJfrAkyMBuqYXq0ofZC9cxNYYkczdKnki5Fn9yWEOFxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V/XXfSFh; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so1097661666b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 01:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746001289; x=1746606089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JoXuPa8XPN028EXJ/KAd1SC1yPdabYe6dR0fihdGMkE=;
        b=V/XXfSFhLIpLdSxdY6csTfC4yXDiikF1jZfXysYRjWt4mXL7S2oHjwK4RIm7pkhFtA
         suMJXtxUL/fw/xmUFINJvJ5AAuvnX1gb/tEcCDnGMqrwphmLVV6OWqF595iPFj20K+d0
         sFyEZevFR1YUl8lLUxtp1R0bg3VggjQvlbNNyo4MYF5cfFbKJk8oU2w40ct67obWZvM5
         1nkvlJXnZ1EHEffgHIhLyOPA04GtXVT+CEXrMolz6LOWJDPqo0SbHgPLrSY9rhfBBMJG
         EJvtvp86Qi3747Z1Rvp2qlJlJTBRlJEgMb0sFPhML2agXxpNOvQu+lFG40oQuGsob67s
         2bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746001289; x=1746606089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JoXuPa8XPN028EXJ/KAd1SC1yPdabYe6dR0fihdGMkE=;
        b=GYv6b5vfJMvPJJ7hEqIsg3esA8InYDik7c4WkBE3gpCgjm5xVLVTQSAgpasiuFux+6
         +ECDrpdCH7T21GBLncey+71Z5VOlijZDJJhFRN7J6hllILbgMjFEU6Gn5qQDArEdaBqF
         T9vS61mz+vwiFTvh3CAUq1rMq3yrsuOjB29UzwXvnWwZvTg1/AfGUpF157mXKnrmEbJ8
         8casqt70KPrWJ54q5oPvlQSG/TvbWodIninEjCGW1z2AkNdNxtSllbaDioQNtV7IrbMz
         c+ZmU2Wz9NxVSQu6yqzfzoynjrZoMzaKTFBjV/cRl0mCXKDsl2oJEPoax/1X1ziUrRzn
         qpgA==
X-Forwarded-Encrypted: i=1; AJvYcCXpiDGnH9iV5y+2p/3d7+nl5yef7X4A1rHMq+WhFA8ZfgTSdJkKPPd1Rr2xOx3Ihc3OT8AEhOu+uJwpgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC9bHSxBg+6cZD/eR9ZwqsNmeakz06EB0x+r08/JY7To+uIboE
	aK+s7FCaZTL/67fk5RD5hbr2WeMgyGe6pMnyyrjtoeIfytMOSLRKe/7RK6tvEfGIVDgTqjjdGKk
	5grJoTa+Pq9aDz3xo2dWiEBcE7CRzodP864FmQg==
X-Gm-Gg: ASbGnctJmGRTHMtCsv6ODNvVgE7pD2LB9MgiXDkKI1Op+EfcZE2w6dqvDXqvMDdMmdh
	p41hlGEh3nlAD4tv7RqYVE9SSPKCJOrmpPXB+/qHXq48TQuoj1FRFwuQfCsJJh3uBZneyB4P4IU
	JW708vy4pNut6H2S369GFd
X-Google-Smtp-Source: AGHT+IGpBq/RTpgieVy5arQVsUovgH5v7YiM5KjoFBf6iUybxR6sXuZygH9JWCqrYn/9Ku77IlGD6EuW1I6FklnG+2w=
X-Received: by 2002:a17:907:970a:b0:acb:b71c:1eaa with SMTP id
 a640c23a62f3a-acee21ac4fcmr149852666b.23.1746001289091; Wed, 30 Apr 2025
 01:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429151800.649010-1-neelx@suse.com> <20250430080317.GF9140@twin.jikos.cz>
In-Reply-To: <20250430080317.GF9140@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 30 Apr 2025 10:21:18 +0200
X-Gm-Features: ATxdqUGg62QfCeOdFgR7irU9rqwhXy1s-YIMvWe6W4HXsSIgP846bek9CpOoeAY
Message-ID: <CAPjX3FfBoU9-wYP-JC63K6y8Pzocu0z8cKvXEbjD_NjdxWO+Og@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove extent buffer's redundant `len` member field
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Apr 2025 at 10:03, David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Apr 29, 2025 at 05:17:57PM +0200, Daniel Vacek wrote:
> > Even super block nowadays uses nodesize for eb->len. This is since commits
> >
> > 551561c34663 ("btrfs: don't pass nodesize to __alloc_extent_buffer()")
> > da17066c4047 ("btrfs: pull node/sector/stripe sizes out of root and into fs_info")
> > ce3e69847e3e ("btrfs: sink parameter len to alloc_extent_buffer")
> > a83fffb75d09 ("btrfs: sink blocksize parameter to btrfs_find_create_tree_block")
> >
> > With these the eb->len is not really useful anymore. Let's use the nodesize
> > directly where applicable.
>
> I've had this patch in my local branch for some years from the times we
> were optimizing extent buffer size. The size on release config is 240
> bytes. The goal was to get it under 256 and keep it aligned.
>
> Removing eb->len does not change the structure size and leaves a hole
>
>  struct extent_buffer {
>         u64                        start;                /*     0     8 */
> -       u32                        len;                  /*     8     4 */
> -       u32                        folio_size;           /*    12     4 */
> +       u32                        folio_size;           /*     8     4 */
> +
> +       /* XXX 4 bytes hole, try to pack */
> +
>         long unsigned int          bflags;               /*    16     8 */
>         struct btrfs_fs_info *     fs_info;              /*    24     8 */
>         void *                     addr;                 /*    32     8 */
> @@ -5554,8 +5556,8 @@ struct extent_buffer {
>         struct rw_semaphore        lock;                 /*    72    40 */
>         struct folio *             folios[16];           /*   112   128 */
>
> -       /* size: 240, cachelines: 4, members: 14 */
> -       /* sum members: 238, holes: 1, sum holes: 2 */
> +       /* size: 240, cachelines: 4, members: 13 */
> +       /* sum members: 234, holes: 2, sum holes: 6 */
>         /* forced alignments: 1, forced holes: 1, sum forced holes: 2 */
>         /* last cacheline: 48 bytes */
>  } __attribute__((__aligned__(8)));
>
> The benefit of duplicating the length in each eb is that it's in the
> same cacheline as the other members that are used for offset
> calculations or bit manipulations.
>
> Going to the fs_info->nodesize may or may not hit a cache, also because
> it needs to do 2 pointer dereferences, so from that perspective I think
> it's making it worse.

I was considering that. Since fs_info is shared for all ebs and other
stuff like transactions, etc. I think the cache is hot most of the
time and there will be hardly any performance difference observable.
Though without benchmarks this is just a speculation (on both sides).

> I don't think we need to do the optimization right now, but maybe in the
> future if there's a need to add something to eb. Still we can use the
> remaining 16 bytes up to 256 without making things worse.

This really depends on configuration. On my laptop (Debian -rt kernel)
the eb struct is actually 272 bytes as the rt_mutex is significantly
heavier than raw spin lock. And -rt is a first class citizen nowadays,
often used in Kubernetes deployments like 5G RAN telco, dpdk and such.
I think it would be nice to slim the struct below 256 bytes even there
if that's your aim.

