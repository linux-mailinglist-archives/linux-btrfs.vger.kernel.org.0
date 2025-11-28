Return-Path: <linux-btrfs+bounces-19415-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F50EC92E08
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 19:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 596D84E1D92
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 18:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E461A273D6F;
	Fri, 28 Nov 2025 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="fVPTbZ4w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B949123E32D
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Nov 2025 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764353167; cv=none; b=qShpA6D+zGaolzxm1+f9eELunqACwFZO0G8Dix7jc/3LIHJ8rhOwmyoDEpch6CnNc3tNUKClWHrFnlVWCjxCIE34VI0Zxb32ZpfDiQgXcLgkPJ7/uFOa+WjW363Lk2fl/hcbs034laAvz4U8qxxrmfu4FkGahsO2XZsNi/ZliDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764353167; c=relaxed/simple;
	bh=6w0WqNLswcBxi6LRI5vB+VPqgxywN9zCOksdOzS0zR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMf2hRzuCa5m4nEZI8jYWk4aXwVEPN1knV9npu/jPQjXDHwyN73PK38gjG+CDcPO7GU4/xbXFocrI6C+OB4PETo1Voqs6RpQk5wU360uUF2zfjP263xODp3VPGzel8wnuVMOxCO3+OZ2dCitbG1Ix+uoN7vuljjos/m9ilv+qf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=fVPTbZ4w; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2955623e6faso23710745ad.1
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Nov 2025 10:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1764353163; x=1764957963; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dgb47dnkWdmAc7YttyFgO1rjl/binCxUPsmVtpY7Z1U=;
        b=fVPTbZ4wJ79VIHQQuY2YJiKnxqfPhlp16/K/nLwiHqXDW8IzFK0rxGEW0+Xnh/k9M5
         ssbyew/6s+Is5hHfz7lEsYvxdp5ZNDddhPLu0NLC6oPS22xkxKcr/74RmO4toGMzPL/h
         hCYHfOrCRPKIQfIqfakGjCRS9sSwlenslfjvozLLizrvXm+6XVMeGHh8gXLaSd/UrqUW
         tygxXyALMN6+/SkcEw/8JHlwbRUONbf6ThtSIOv7Z2TcM30eR+9OhQkWD0NJxYzLc4Na
         D8BCXugiLNdsAyYepD7dJSvOmQsbBkiW25cM6LPy5WLJQpBLBbMqyRw1AYYJdL4URHJm
         7Wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764353163; x=1764957963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dgb47dnkWdmAc7YttyFgO1rjl/binCxUPsmVtpY7Z1U=;
        b=JQcCpGB03181ZbefAWfZYqraF63QDfWfcQjORTMcHQXlTjOst5tZ4SS9fu4EZeamXr
         gr0W8x6cfvOQusptIGvZQMZCiee9NL6QqUEEj2RT4S/h3g0dZBxqcj6qONThLXT+hDXY
         guW46xyVWzpWnlji3XcXpSx/svLJDd7olbUD7szfhT08BK/QobhrzMtST/XRp4/Cw4C5
         hKY0F3zct6I3k2B54pJjS3MgYt+omrIEIQrakH+SmLTdAY24GAyS4A5XhtYyjz03+aEl
         WeFG1Xh2LFjmxt09Jb7B7FW/40l/CPe41B6XZ1xBpScqjpGR3/a/sdj4fN4WOP4J0vIo
         xigw==
X-Forwarded-Encrypted: i=1; AJvYcCWcWuWhstqyrxa/kTvK5XJ1ip/klVUThyPROtfw5YwzxkbsjcLa/AVd30Ur8EFSJNW5eKC2e8mAzGGXqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWSvTzB8UCf50aXG5P/qaCFZuv+MtwOeezuVpK4bfxFS/QW2Fv
	wL4X0kztExg2R+qVtexD8z8sCKOx50N4jkasigkUh/dRS++OTgqoYvYvcpHMuB86rkg=
X-Gm-Gg: ASbGncui/iwc3Nj3iILvS43p1v8kohS9WNE443+Ar9KnoyTWr8QNWp4g+pHmvWy2BkY
	Dd8mlFwg1oD9JpQDtU2WBz+3HPEY6q1/L8LEqVUVOXXqytTRvNgx0+LN0Gdd1UnKHSaSexQw4OG
	jFIQYvCYNG+UL2yKZwKvb+hn//aieZQJFy1Zr2FQFbM9OXGg1WTiEzZ9h7sKJ1/oPgnJkc5Xob5
	lfGvSuEe9vnxSswjJzICthtVLUHHD9zuskG4G04O+uyvedwU0xt+l35edfK9J9J6vGmAbeP0i0X
	jEEh/oUQ+thLtI1+L2YVZBq/BRxr+1VDpGh/3ohaElXFxu8B2FC8Xiym3GrZRXW4Hs3Jji1/95Z
	Y+t91eto4bZ0SRE8tqJfyLKJVAYYvO2nPktijB+39nOzKL87XfFBh8EzDr5rlDgzlkaaSVex6AW
	PKKmyOuO+uUHDX
X-Google-Smtp-Source: AGHT+IG/G/Qlu/NJA45f7NjuwNCsI3vIWAHFoRQ5BSeGUXXkGPCFpQePUYpxgWRXhcyUcAsZRYsBBg==
X-Received: by 2002:a17:903:2f10:b0:295:c2e7:7199 with SMTP id d9443c01a7336-29bab16b24emr156343865ad.29.1764353162734;
        Fri, 28 Nov 2025 10:06:02 -0800 (PST)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb5519dsm52268095ad.93.2025.11.28.10.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 10:06:02 -0800 (PST)
Date: Fri, 28 Nov 2025 10:06:00 -0800
From: Calvin Owens <calvin@wbinvd.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Demi Marie Obenour <demiobenour@gmail.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: mkfs.btrfs reproducibility
Message-ID: <aSnkiEKGUon3pqa9@mozart.vkv.me>
References: <0ff47dc5-cf0d-4b5a-8d84-f309a74cbf32@gmail.com>
 <9194ad3f-183d-46e9-afc3-b52ab2bf28cb@suse.com>
 <fa8d6257-649b-4de1-b723-64cbc34c0a7f@gmail.com>
 <3247ee84-5a0d-4561-8d25-b1b8e180215a@gmx.com>
 <14681d38-fbdf-4ac2-93fa-7eba21588930@gmail.com>
 <0b099290-03bf-4a1d-8411-716f78058586@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b099290-03bf-4a1d-8411-716f78058586@gmx.com>

On Friday 10/17 at 09:20 +1030, Qu Wenruo wrote:
> 在 2025/10/17 09:12, Demi Marie Obenour 写道:
> > On 10/15/25 02:49, Qu Wenruo wrote:
> > > 
> > > 
> > > 在 2025/10/15 16:31, Demi Marie Obenour 写道:
> > > > On 10/15/25 01:47, Qu Wenruo wrote:
> > > > > 在 2025/10/15 16:13, Demi Marie Obenour 写道:
> > > > > > I need to create a BTRFS filesystem where /home and /tmp are BTRFS
> > > > > > subvolumes owned by root.  It's easy to create the subvolumes with
> > > > > > --subvol and --rootdir, but they wind up being owned by the user that
> > > > > > ran mkfs.btrfs, not by root.  I tried using fakeroot and it doesn't
> > > > > > work, regardless of whether fakeroot and btrfs-progs come from Arch
> > > > > > or Nixpkgs.
> > > > > > 
> > > > > > What is the best way to do this without needing root privileges?
> > > > > > Nix builders don't have root access, and I don't know if they have
> > > > > > access to user namespaces either.
> > > > > 
> > > > > Not familiar with namespace but I believe we can address it with some
> > > > > extra options like --pid-map and --gid-map options, so that we can map
> > > > > the user pid/gid to 0:0 in that case.
> > > > > 
> > > > > Thanks,
> > > > > Qu
> > > > 
> > > > Thank you!  This would be awesome.  In the meantime I worked around
> > > > the issue by having systemd-tmpfiles fix up the permissions.
> > > 
> > > Mind to share some details? I believe this will help other users, and I
> > > can add a short note into the docs.
> > 
> > I fixed the owner and permissions at startup.  This is not good
> > because it means that the image is not reproducible.
> 
> OK, so it's not the proper fix.
> 
> I'll continue working on the new --pid-map/--gid-map solution so that the
> files will have the proper gid/pid set.

Hi Qu,

I bumped into this: the issue is that mkfs.btrfs uses ntfw, which isn't
instrumented by the LD_PRELOADs from fakeroot.

The kludge patch below in btrfs-progs gives me the behavior I want, and
what I think Demi wanted as well.

Credit: https://github.com/NixOS/nixpkgs/issues/455331

Really though, IMHO it should be fixed in fakeroot: the Yocto clone of
it called pseudo does have ntfw support, as noted in the above issue. I
haven't had time to follow up on that yet but I will soon.

Thanks,
Calvin

-----8<-----
From: Calvin Owens <calvin@wbinvd.org>
Subject: [KLUDGE][btrfs-progs] Make the --rootdir argument work with fakeroot

Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 mkfs/rootdir.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 7bdd6245..0f2c23c9 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -1631,7 +1631,7 @@ out:
 	return ret;
 }
 
-static int ftw_add_inode(const char *full_path, const struct stat *st,
+static int ftw_add_inode(const char *full_path, const struct stat *unused,
 			 int typeflag, struct FTW *ftwbuf)
 {
 	struct btrfs_fs_info *fs_info = g_trans->fs_info;
@@ -1639,10 +1639,23 @@ static int ftw_add_inode(const char *full_path, const struct stat *st,
 	struct btrfs_inode_item inode_item = { 0 };
 	struct inode_entry *parent;
 	struct rootdir_subvol *rds;
-	const bool have_hard_links = (!S_ISDIR(st->st_mode) && st->st_nlink > 1);
+	struct stat kludgebuf;
+	const struct stat *st;
+	bool have_hard_links;
 	u64 ino;
 	int ret;
 
+	/*
+	 * KLUDGE: Explicitly call lstat(), so our view of the filesystem is
+	 * through the LD_PRELOAD installed by the fakeroot command.
+	 */
+	if (lstat(full_path, &kludgebuf)) {
+		error("Kludge with second stat() call failed: %m");
+		return ret;
+	}
+	st = &kludgebuf;
+	have_hard_links = (!S_ISDIR(st->st_mode) && st->st_nlink > 1);
+
 	/* The rootdir itself. */
 	if (unlikely(ftwbuf->level == 0)) {
 		u64 root_ino;
-- 
2.47.3


