Return-Path: <linux-btrfs+bounces-11532-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ADEA398C9
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 11:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04EDF3A85D4
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 10:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86BC233D99;
	Tue, 18 Feb 2025 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCIvqsug"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F5A22F140
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2025 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874013; cv=none; b=ni1jkeaO7jsRO48U8jNSMSduXHv/ilcwcsbitwPZGR2qT3KeytyUMxjEzwXN8ZJCU3QzDYeBWQ21ftJtHGLlUjN2VBIdh5mTikGRyMz1o074nI6535oNuU3Ye0SA0zkdBrPYkHjoWMmhmqDkKmT+cQpGte3a+77ZhnYMvQZXs7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874013; c=relaxed/simple;
	bh=oQij1NMNr4mtaXRJRBQM8SgEjryJxmb+5n4VtA3y1g4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wde3njWD8I/2LG8ekgilH3nrvgbpJYdzH+kY03KcObMXyW9x6izFRQaQbrlgoY23pkAZ38t1UUH9O7NY3EGQ7K0E0QW7p58rmKCLeuYTvk5lEdVZ5iRxUaPZdnjsWaqDX2Yd1ZKJxqMrhWcMVZxY5mBu4BA52bW2MSWnhLN16+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCIvqsug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE85DC4CEE8
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2025 10:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739874012;
	bh=oQij1NMNr4mtaXRJRBQM8SgEjryJxmb+5n4VtA3y1g4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nCIvqsug6xMfTc8Lfsj/eM7O9+BVP4SZfqitZjO38UD027UvYskTGevUlQyYL71BT
	 a0BsaVeIsspYSl181H/opCmMELV4b9FhCehCTbHgANXAjAs7XZzIPWO95KiUdPv0Yw
	 rJ1iDFZLAbetkiTGQTvkFugMoOoJp2sVKt4H/yaRVk8L9iQHAahY+LqQEakeno2gbs
	 aYGqdyLO8EtOiswGWMrErK1CNnjP9j8t8DTlhhboTao0JSAXBcKqQ459bMneeNw1U5
	 9kJpaB/XlFi/twXXLxONJ+X/HJNVhAWaqCJ8bELvK03EbiAnnop0hKxpp/fpq7Svd4
	 Exnmq9J/94iww==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abb97e15bcbso341400266b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2025 02:20:12 -0800 (PST)
X-Gm-Message-State: AOJu0Yw32ZQ0bqau0nazqmKUq2aonPWzH5mJMEqec3feo3I4eXLG+V8M
	xBr4ZflKN7CV1tpwVDCoHqBYq+tA4MnIobGhh+F8D6sGQlPPzFG0q+4YU7Rxv15qHlFXxyRhZ87
	obiSF48v+LytIDdK2OSIIL4tF6us=
X-Google-Smtp-Source: AGHT+IGO5FzyDFVcUEaBHhtN4WD///tUj1wuFFayZHokLiyVmwbaGmtBGX2N7EogAqp/b481H7CWHHyoq5DVE2GKshg=
X-Received: by 2002:a17:907:7b8b:b0:ab7:e41d:34b6 with SMTP id
 a640c23a62f3a-abb70dce45amr1267777066b.28.1739874011307; Tue, 18 Feb 2025
 02:20:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739710434.git.fdmanana@suse.com> <663658b73e3cd9dd5e34e8eee34f4959f6ccb5ec.1739710434.git.fdmanana@suse.com>
 <3ce8e257-3822-48f1-9c09-f7e774475435@wdc.com>
In-Reply-To: <3ce8e257-3822-48f1-9c09-f7e774475435@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 18 Feb 2025 10:19:34 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6R=oknKFa9Xd6detM_kt5m9J2ynJ+do8BJMFMP2rKyzw@mail.gmail.com>
X-Gm-Features: AWEUYZnp4LFU9Jd6S35-hLuHtzQTHs5hjPMFzADZRcz-_eHKktx0PAkF6ERVW0I
Message-ID: <CAL3q7H6R=oknKFa9Xd6detM_kt5m9J2ynJ+do8BJMFMP2rKyzw@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: skip inodes without loaded extent maps when
 shrinking extent maps
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 6:18=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 16.02.25 14:16, fdmanana@kernel.org wrote:
> > +static struct btrfs_inode *find_first_inode(struct btrfs_root *root, u=
64 min_ino)
>
> Can we call it something like find_first_inode_for_shrinker() or sth
> like that?

Sure, I'll rename it to find_first_inode_to_shrink() at commit time then.

Thanks.

>
> It is very similar to btrfs_find_first_inode() but not the similar
> enough to be the subset of it and I find that quite confusing.
>
> Otherwise
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

