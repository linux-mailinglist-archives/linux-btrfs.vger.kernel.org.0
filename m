Return-Path: <linux-btrfs+bounces-10442-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 389759F3EBC
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 01:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0034188A532
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 00:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F31F9FE;
	Tue, 17 Dec 2024 00:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZUtbvR7P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B204C9F
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734394934; cv=none; b=oYGRz9ZAqFtBe0ifOpkp8g4x1zlHWEV2Mdce17OlSpSeQUF22umCU+27gfinHllGO2dDpyBbtQIRZAB7lOAAony3WVOq2AY3chHHNTUxzmVUBeMsCFOT8d9r3xpxVNA+q22gm6FK8WstpU8THTPWBnnrzl7ub7NvYTVDq9Jkjpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734394934; c=relaxed/simple;
	bh=mZ7KBxRiNIDejZVpUVQ6nlPgNNXf0zptNyEy5l+UnBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMXeGWibxakngw1+6N8bNAAf0gE9ujhUh4tJ8EqqbvTb+2vm12c2LdmSdBM6C1gSSYawA2DWZP9NXzkpZpH5eO8a29RqY5WH+qPaZiCZ/gNdtKG/eD+92oPxD0dqKESZNd7lGxEB+luCNjG7SVBKu83qE/eT78yhiEdvOqIY2i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZUtbvR7P; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e387ad7abdaso3588577276.0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 16:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734394931; x=1734999731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71UboNKp8PBgSM3OXXE6el32SNwss2VOEFU3BrAALk0=;
        b=ZUtbvR7POJzs9AMT/ZxyccuYJWBODImPREZFWPi03Z5mV9bDqC6NUA5V/OPUvk+W6t
         VpAaVnfBDy7rgwHdBoCnK0jjZKH5tRdClFIsdessEWfEgVb7cnDyhbnGU4gTYBf465Mr
         eKoEQU77hFpzBLRElM9+AKvusZM25SkBpIMLI4Rw+Y+HgjdodPrpxpxb2r2+m/FdjoBp
         SN7q4j87wN8UmWasJn5aWMrx+TVYKxNX6T4h0TPH09/aLsSvo4LsyOUv1ViF2Zb++/le
         JJG/adDh1hMN8rauQle9yCgrMHO5yZcTcIcay/gMbn9AMRmWVxTGLRC4zDdrY5zfpFZx
         +k5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734394931; x=1734999731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71UboNKp8PBgSM3OXXE6el32SNwss2VOEFU3BrAALk0=;
        b=i2tjsUvp967nloUGGohIJEnJ/Hn8GoSxttFbBPbiP6y4y+g4Kff486YuOrVIKJM2Zq
         QQX8mTlgZSKcfbzvpbCUwCVYNsrXbj4IMGR1ylvHKYT3h3SDlXiAw+t5+YJFOhpfL2UV
         JatZIckW8nAmo5ie+uKTn+VwYXTziRhWm9jZ+u/NFpusHU3kRzPRmBmLoHIRJju+fpRk
         ETRHTXGojwQjDJLaGNUqAUdFA6WGwK/BoOlS+C64sxmVomGHbejXTPmUEyvYUiZMtQcI
         LK/zBr1hOmE/0jcXJrW+O5Me1U4D+S6EXHAmXOwVCb9KGGti3FBB60aZxh7y2vYXFQsz
         4Jcg==
X-Forwarded-Encrypted: i=1; AJvYcCVREG0iFzm/zQg6UT+lNNtsu9IDTzHeSNRHKZR5jOon55DSrtD/KMuWTAz20FWyF5zkVbfE5fqNX30CRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywor7BIFpsRg8MOGqqewOAiLhh5VajLphcNHZEhK6Fmowxbv4pN
	2/3NyMB7uPbfrqI5hWNMjnk2kgvYSn1fT+BLhJ39VF0Rw26FcO1MT3RXiIDx1+OKHNeXvzvrjPp
	pPS+/ty2+wZi3ZI3cYijOi9SwOFqqEbFw22ts
X-Gm-Gg: ASbGnctZHG/7+DdzaSwxUOWD6waMNrdq188ECtwUt0JGpOgdFwHUX2hitP/ANgSlid/
	w3dq5Qywb3dKnuEPpA+s+MIE/TrQpp+C3NXZ8
X-Google-Smtp-Source: AGHT+IHf0wZhbh7sOURNOzivfR+3asRXLLCmwV8fbsWRDWFE4TZAL8JlZRQzwQgdHYf9FYWmcVo2zFP8s+2cEpINRbE=
X-Received: by 2002:a05:6902:2006:b0:e4d:89e9:6a7f with SMTP id
 3f1490d57ef6-e4d89e96f63mr5429340276.50.1734394931644; Mon, 16 Dec 2024
 16:22:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216234308.1326841-1-song@kernel.org>
In-Reply-To: <20241216234308.1326841-1-song@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Dec 2024 19:22:01 -0500
Message-ID: <CAHC9VhSu4gJYWgHqvt7a_C_rr3yaubDdvxtHdw0=3wPdP+QbbA@mail.gmail.com>
Subject: Re: [RFC] lsm: fs: Use i_callback to free i_security in RCU callback
To: Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	willy@infradead.org, corbet@lwn.net, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, brauner@kernel.org, jack@suse.cz, cem@kernel.org, 
	djwong@kernel.org, jmorris@namei.org, serge@hallyn.com, fdmanana@suse.com, 
	johannes.thumshirn@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 6:43=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> inode->i_security needes to be freed from RCU callback. A rcu_head was
> added to i_security to call the RCU callback. However, since struct inode
> already has i_rcu, the extra rcu_head is wasteful. Specifically, when any
> LSM uses i_security, a rcu_head (two pointers) is allocated for each
> inode.
>
> Add security_inode_free_rcu() to i_callback to free i_security so that
> a rcu_head is saved for each inode. Special care are needed for file
> systems that provide a destroy_inode() callback, but not a free_inode()
> callback. Specifically, the following logic are added to handle such
> cases:
>
>  - XFS recycles inode after destroy_inode. The inodes are freed from
>    recycle logic. Let xfs_inode_free_callback() and xfs_inode_alloc()
>    call security_inode_free_rcu() before freeing the inode.
>  - Let pipe free inode from a RCU callback.
>  - Let btrfs-test free inode from a RCU callback.

If I recall correctly, historically the vfs devs have pushed back on
filesystem specific changes such as this, requiring LSM hooks to
operate at the VFS layer unless there was absolutely no other choice.

From a LSM perspective I'm also a little concerned that this approach
is too reliant on individual filesystems doing the right thing with
respect to LSM hooks which I worry will result in some ugly bugs in
the future.

> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  Documentation/filesystems/vfs.rst |  8 ++++-
>  fs/btrfs/fs.h                     |  1 +
>  fs/btrfs/inode.c                  |  4 +++
>  fs/btrfs/tests/btrfs-tests.c      |  1 +
>  fs/inode.c                        |  2 ++
>  fs/pipe.c                         |  1 -
>  fs/xfs/xfs_icache.c               |  3 ++
>  include/linux/security.h          |  4 +++
>  security/security.c               | 49 +++++++++++++++++++------------
>  9 files changed, 53 insertions(+), 20 deletions(-)

--=20
paul-moore.com

