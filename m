Return-Path: <linux-btrfs+bounces-990-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A66B88159ED
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Dec 2023 15:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668E1285153
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Dec 2023 14:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0A830355;
	Sat, 16 Dec 2023 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="GsCGD0YJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195E03033F
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Dec 2023 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5cd81e76164so14549877b3.1
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Dec 2023 06:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1702738327; x=1703343127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oA7sme/wc8753vvLvAf7lyhPDObfPHeWsrUyMBHufRA=;
        b=GsCGD0YJXo7MF5W8yRlotCs0epdFjq7wsJSiqyRpH9Ek/o+ztdTmsI6qe8EI6IYgkP
         KaNZ3XKdT6s6nOyWILXFFqiWYZJdFN/kBe+UOdK64SK82YLDYi6JEsUx/vAcRhhTAyv6
         CNLf/jhl1zU8oXQZhERzyUCxr8OG/UPUUGcyec4CDFVFIaQuq+Iw165kDy3Y7p91nOCQ
         8s5G49wSTedhlWLh/xZnzFUPG48VaW5AT5tqN6/1KHgUoNqrRsSwmkIUq214TANcBCUO
         Us+3TsR075DG1vezSFvb9KLYXy9pJLejLYcRcqiPUc/d+SBYzW3+2eJvL2RwxAQC2tOa
         hPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702738327; x=1703343127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oA7sme/wc8753vvLvAf7lyhPDObfPHeWsrUyMBHufRA=;
        b=TonWC9pfuagk3PrX2/M+hFwyKvGuU0je4fzjvQk+x8fGTAiuzpyq5uWhuB4Meu0nZh
         ET1dmCA2kcjZI7hma/1rLv5A3ZIDUtjEm9JLUKKLDiWbPec6QiGt44k5V5UY30O9no4D
         HbQlUh8bE5QLnYrCfSWQKz6HA8As4ofDF4FfiP1NpZ+NlN7itwYA0aqwb+rxxlTO3aN+
         fi62Mslw/YVCyuYtDWEQH38XUbaJh2LmKhTCOfHtn3VfA4Ftr3k2cmZZ49yBLLw9Bm4e
         BETglQr1HTpQVJEz52Xd8oUA9vszS6TV3ObvSm2te/Fk5aAEkhj1ffSE7WgbfKcPgAPt
         guLQ==
X-Gm-Message-State: AOJu0YwUnD7AR8m6cHXCAIeUhvxQd9NJ3S2lRB01dMWXIgGmBgu+T+d3
	Jgy7HlnNr5uVh1OJelUVg37ljA==
X-Google-Smtp-Source: AGHT+IHWGNP6VHnf5q0ZRFEjeJKxW9r1newfiPTngMIN/hqAeqSoGGRlOnrewaj3tKDeCu4fOTF1QA==
X-Received: by 2002:a81:df01:0:b0:5d7:1940:dd62 with SMTP id c1-20020a81df01000000b005d71940dd62mr12001424ywn.56.1702738327012;
        Sat, 16 Dec 2023 06:52:07 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j14-20020a81920e000000b005d951c0084esm2134721ywg.21.2023.12.16.06.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 06:52:06 -0800 (PST)
Date: Sat, 16 Dec 2023 09:52:05 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH 1/3] btrfs: call btrfs_close_devices from
 ->kill_sb
Message-ID: <20231216145205.GA1023996@perftesting>
References: <20231213040018.73803-1-ebiggers@kernel.org>
 <20231213040018.73803-2-ebiggers@kernel.org>
 <20231213084123.GA6184@lst.de>
 <20231215214550.GB883762@perftesting>
 <20231216041221.GA8850@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216041221.GA8850@lst.de>

On Sat, Dec 16, 2023 at 05:12:21AM +0100, Christoph Hellwig wrote:
> On Fri, Dec 15, 2023 at 04:45:50PM -0500, Josef Bacik wrote:
> > I ran it through, you broke a test that isn't upstream yet to test the old mount
> > api double mount thing that I have a test for
> > 
> > https://github.com/btrfs/fstests/commit/2796723e77adb0f9da1059acf13fc402467f7ac4
> > 
> > In this case we end up leaking a reference on the fs_devices.  If you add this
> > fixup to "btrfs: call btrfs_close_devices from ->kill_sb" it fixes that failure.
> > I'm re-running with that fixup applied, but I assume the rest is fine.  Thanks,
> 
> Is "this fixup" referring to a patch that was supposed to be attached
> but is't? :)

Sorry, vacation brain, here you go.

Josef

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f93fe2e5e378..2dfa2274b193 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1950,10 +1950,20 @@ static int btrfs_get_tree_super(struct fs_context *fc)
  */
 static struct vfsmount *btrfs_reconfigure_for_mount(struct fs_context *fc)
 {
+	struct btrfs_fs_info *fs_info = fc->s_fs_info;
 	struct vfsmount *mnt;
 	int ret;
 	const bool ro2rw = !(fc->sb_flags & SB_RDONLY);
 
+	/*
+	 * We got a reference to our fs_devices, so we need to close it here to
+	 * make sure we don't leak our reference on the fs_devices.
+	 */
+	if (fs_info->fs_devices) {
+		btrfs_close_devices(fs_info->fs_devices);
+		fs_info->fs_devices = NULL;
+	}
+
 	/*
 	 * We got an EBUSY because our SB_RDONLY flag didn't match the existing
 	 * super block, so invert our setting here and retry the mount so we

