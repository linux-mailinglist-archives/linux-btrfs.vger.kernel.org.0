Return-Path: <linux-btrfs+bounces-19423-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A6EC93478
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Nov 2025 00:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CEF7347B59
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 23:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A5A2E92C0;
	Fri, 28 Nov 2025 23:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="B7fEDjXv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2497289367
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Nov 2025 23:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764371648; cv=none; b=JnvlPlv+cahfL9iUpU+eiumPcQqDwi/l8ZtRn9vwc+9xzd3KKpBw5BZeUiL+hlqrlwf9wbxuOfwh3WZY9KQS9JDDMBUS/A6sYmJYPHOU/EeOPZUK160RmNCm86n2FcO/ZfS6EFar1pw9dbO5olweXJ+6YvKL0f6SEsReccmJsnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764371648; c=relaxed/simple;
	bh=9IwVIZTnyszfwi3ekqAa+EHYQvsNUbik1oIdseciFSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JA2/4azq7QBCxxsjLu1kTx0U6XiKxmcct63droGKmVXA0Osct2YKajctD79OUsh+t9795Dlk6i7HM44Z0EhZ7w9xx6JZnSy6n4vMQ3dr6xSHP0HIuGdLrNvNQom4AeJ28k3Z9a+ooDqBVU6vDM80cCv8q6MoR1sAMlLk2FB4VK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=B7fEDjXv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29568d93e87so24449695ad.2
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Nov 2025 15:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1764371646; x=1764976446; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6AvZNVY9yWJZowNF+A+sj8e562yB5icDnY3CIsRJ3hY=;
        b=B7fEDjXvKFiRwY+SaBeO0j9lLSTYWEnUw3TnAugaqWXg99zDXA3SFU1+4aYWVNLi7M
         H+f9KIR7tadhM/TWnk9MBr915xwe6YiI+cWtidN4eAU+9/PSdFG6UfIwpZ1h1eytSOXr
         orLurSelc41iwsJy6PuugruHi06Px88HqSO2z+B+j2a0WzbWWMED8wSYIBmqCPlwZa04
         oyVbjHRKjGPOmubseRI5YaX37ne1VMU4MSHsUxzNW86nkXkud+p6s5zoEE/qUJeH38bT
         wg2PV2BmWiFSwFlTkNE2hUF2+XkgZ6iGNkogjh4uzbFTN1ozhAWd2x3xcRs+Y/VgMxRn
         kO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764371646; x=1764976446;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6AvZNVY9yWJZowNF+A+sj8e562yB5icDnY3CIsRJ3hY=;
        b=VXH6XqQaVaZpuUDcJfffZuiAlC6yXNB/2de+AiEB7L+LD+rHurO8XO/ygT2FhqZBGg
         25yZIxyqEW375gYOaWaxKxnZNo9wNMTPWj7VHpUtPxD4uhgboyomMaGz5xV3JcRQnNJF
         /Urmhr6b8+EOGgaKj8aFlHuBTvSWiRfeBDQEcKNzqeHR6pR+rD7UEBYQFgiw3pRkHMNV
         uHis0JD6Yy4mVcYd8KSqQbZKZpefpD41dkmUuzMr7nejqzzEu1FzBc73wYMrz4FNrs1a
         cXsCQdJylP9IpnME6xwUr0y0GL67Pl4qRZng1LuyLbIcjcOnOdui6rsbZYjDVIM+HMB+
         rlTw==
X-Forwarded-Encrypted: i=1; AJvYcCX7zcLEDNgnCw7beO4WekYzPS2vcWvKtfdkTBUPNrRegVUggTLVqNd2MbIysgWqDoUAvQCVemx4VWX2mA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4rkxIL/ajh72h5BcbRTLhs1+q0VFT4F0K0mhtAogjoeiS0Jrb
	LV6YocEnkl0ntgQs5/oO53h2Yj2An3pzZF5OZb8WQdeeJTLC5Gm68keiZDZTx88M68c=
X-Gm-Gg: ASbGncspECd837X5B7jbbtMaZ6BV3qWxjm+70vDZ3/ERuXqxKuHgUKTXbO0lV6awBl4
	Ba+EXKBXqJiMO1q64VH3c8MHUN7NSyFjBxl0wdt+ZoIIV1QnM1M0sizAygFSP6V67GobOfwNJML
	BEoKJ6eB4IU/qJukF3vE+v9yTrvJiDDKV0OQvF8eERpINDLbzZJiB3eWpXavPGi/EG6PBXDvAQw
	Kl/4ErcLjqcwB7v93Ht2CPLiP+KZe1m7MdlGfSy0Xc/2l5sU3x349HE+C0Y78bHr+GpG+I0uYx5
	X5TqR/AADMsQbzfoip9TSQmGMy2DYnfbeCnU09r1nor4AFDlm3p1t1wqFdFucgAwwJHTSok8c0J
	xtqQKuaRelVyRzmOHBaGG70B5Qq/VSUbUZPZJ/TaClWOoFRIpcXKmPMiXRDSpuQVJ45o2iTj+DJ
	dD+cKiMdzvA3Cd
X-Google-Smtp-Source: AGHT+IFqQ2m8t8dgg57YGupVi8aQgrE+rdBaNDq2iGrSg/ZC5WNjXJQ3HXJffW7a2oileKv94BCiWg==
X-Received: by 2002:a05:7022:ff47:b0:119:e55a:9c00 with SMTP id a92af1059eb24-11cbba535a2mr10313633c88.28.1764371645784;
        Fri, 28 Nov 2025 15:14:05 -0800 (PST)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb057cb0sm26681546c88.9.2025.11.28.15.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 15:14:05 -0800 (PST)
Date: Fri, 28 Nov 2025 15:14:03 -0800
From: Calvin Owens <calvin@wbinvd.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Demi Marie Obenour <demiobenour@gmail.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: mkfs.btrfs reproducibility
Message-ID: <aSosuz7E4_7mzgL9@mozart.vkv.me>
References: <0ff47dc5-cf0d-4b5a-8d84-f309a74cbf32@gmail.com>
 <9194ad3f-183d-46e9-afc3-b52ab2bf28cb@suse.com>
 <fa8d6257-649b-4de1-b723-64cbc34c0a7f@gmail.com>
 <3247ee84-5a0d-4561-8d25-b1b8e180215a@gmx.com>
 <14681d38-fbdf-4ac2-93fa-7eba21588930@gmail.com>
 <0b099290-03bf-4a1d-8411-716f78058586@gmx.com>
 <aSnkiEKGUon3pqa9@mozart.vkv.me>
 <b9f84c46-998a-4f45-a78c-fa501b24e912@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9f84c46-998a-4f45-a78c-fa501b24e912@gmx.com>

On Saturday 11/29 at 07:02 +1030, Qu Wenruo wrote:
> 在 2025/11/29 04:36, Calvin Owens 写道:
> > On Friday 10/17 at 09:20 +1030, Qu Wenruo wrote:
> > > 在 2025/10/17 09:12, Demi Marie Obenour 写道:
> > > > On 10/15/25 02:49, Qu Wenruo wrote:
> > > > > 
> > > > > 
> > > > > 在 2025/10/15 16:31, Demi Marie Obenour 写道:
> > > > > > On 10/15/25 01:47, Qu Wenruo wrote:
> > > > > > > 在 2025/10/15 16:13, Demi Marie Obenour 写道:
> > > > > > > > I need to create a BTRFS filesystem where /home and /tmp are BTRFS
> > > > > > > > subvolumes owned by root.  It's easy to create the subvolumes with
> > > > > > > > --subvol and --rootdir, but they wind up being owned by the user that
> > > > > > > > ran mkfs.btrfs, not by root.  I tried using fakeroot and it doesn't
> > > > > > > > work, regardless of whether fakeroot and btrfs-progs come from Arch
> > > > > > > > or Nixpkgs.
> > > > > > > > 
> > > > > > > > What is the best way to do this without needing root privileges?
> > > > > > > > Nix builders don't have root access, and I don't know if they have
> > > > > > > > access to user namespaces either.
> > > > > > > 
> > > > > > > Not familiar with namespace but I believe we can address it with some
> > > > > > > extra options like --pid-map and --gid-map options, so that we can map
> > > > > > > the user pid/gid to 0:0 in that case.
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Qu
> > > > > > 
> > > > > > Thank you!  This would be awesome.  In the meantime I worked around
> > > > > > the issue by having systemd-tmpfiles fix up the permissions.
> > > > > 
> > > > > Mind to share some details? I believe this will help other users, and I
> > > > > can add a short note into the docs.
> > > > 
> > > > I fixed the owner and permissions at startup.  This is not good
> > > > because it means that the image is not reproducible.
> > > 
> > > OK, so it's not the proper fix.
> > > 
> > > I'll continue working on the new --pid-map/--gid-map solution so that the
> > > files will have the proper gid/pid set.
> > 
> > Hi Qu,
> > 
> > I bumped into this: the issue is that mkfs.btrfs uses ntfw, which isn't
> > instrumented by the LD_PRELOADs from fakeroot.
> > 
> > The kludge patch below in btrfs-progs gives me the behavior I want, and
> > what I think Demi wanted as well.
> > 
> > Credit: https://github.com/NixOS/nixpkgs/issues/455331
> > 
> > Really though, IMHO it should be fixed in fakeroot: the Yocto clone of
> > it called pseudo does have ntfw support, as noted in the above issue. I
> > haven't had time to follow up on that yet but I will soon.
> 
> To me the LD_PRELOAD looks like just another hack.
>
> I'd like to know how many gid/uid maps normally there are for such usages.

It's an entire Linux system, and the mapping isn't static. On some
examples I just looked at it's 30-50 uids and 60K-80K files.

I don't really require a generalized mapping: I only need to create a
btrfs filesystem with file uid/gid/mode identical to files created
through fakeroot.

This is my crappy script in case it makes more sense (note the shebang):
https://github.com/jcalvinowens/kernel-testing/blob/master/scripts/make-image.sh

That works as-is with my kludgey example patch in btrfs-progs. To be
clear, I'm *not* proposing that patch as a real solution.

> If it's less than a few hundred, I think I can add some gid/uid mapping
> options to mkfs.btrfs, so that no extra hacks are needed.

Mapping uid/gid isn't sufficient for generic images, unfortunately: one
counterexample, image creation needs to be able to arbitarily mknod and
include the special files in the filesystem without running as root.
I've never seen that done any other way than fakeroot/pseudo.

In Yocto, btrfs-progs is the reason pseudo had nftw support added in the
first place:

    https://lore.kernel.org/yocto-patches/20250407191414.2992785-2-skandigraun@gmail.com/T/#mfd5a2338ea6fefc5ed734c0beb85ac26806b8684

But now that I've had more coffee, I think this is arguably a bug in
glibc: shouldn't nftw respect the LD_PRELOAD interposition of lstat()?
I don't understand why it can't be made to, but I need to do more
homework on this...

In any case: I welcome uid/gid map support in btrfs-progs, but IMO
that's a bit orthogonal to this problem.

Thanks,
Calvin

