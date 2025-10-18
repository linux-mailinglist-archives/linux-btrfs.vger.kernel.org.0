Return-Path: <linux-btrfs+bounces-18000-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE69BBED710
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 20:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575203B6FE9
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 18:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD51D258CD7;
	Sat, 18 Oct 2025 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GtHyowQR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18EE1E2858
	for <linux-btrfs@vger.kernel.org>; Sat, 18 Oct 2025 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760810517; cv=none; b=eaoLk8VtGoSU3Mmm621ibhNd2FT9fVZAng0uOmtfS/0kMrhzcJdl/H1xN4NcpkBHJauYN98Tu38+oijSnmoUGJu2RQdO6vari6NeEkWSEa/DOj64egMaQmyTId4uowzUap9f9J6SWQze0IUR7Bwc34QG688xuvyrzxLQtjejUOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760810517; c=relaxed/simple;
	bh=WHki9h4QINzD1HuEr+Xp2ZhY7ZE3yPZEKK9FWFcFoQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThsXkBrTYS3/zuE5CcdFkBXQsmVWVbdOeOhkV3AbgjDOeIBxZQe2dV4UlF8GhDkeuvskEXT8vWA96cc3lhTdjfPtL4WP397qlIfnPqtPNG6I/pvl5h2ZAi9MrjtiNoT6f8A2bKDz+dgZpsXs4w8kheLJx3wYHpbsczJoqwVfw7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GtHyowQR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-471066cfc2aso26811785e9.0
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Oct 2025 11:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760810513; x=1761415313; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fesa7zfnyQPwvNS008TVkL6pT2+7y4mb6RtsZYkI/nc=;
        b=GtHyowQRwJwrstCUHuMlAyVVn6MJ3WIcFr5HWww+gXpi931x9HgLjJQ0vdK+ub2MM6
         v0CN3ZfVi2BxpmgxBo/0ui7lDjzfmKpVydxG92YFZSSDwQNn5iIXXPUSRZWyTfEYng9r
         z09iGRiWayJ0ts8Wy/0OzSL6XhVUdc5wtOG+Oo7+PBjc3CYcSWAvScMb1QGOHxhYRnJj
         HnNuJT0N8hF0qYDYnP96oLjDxaHf5M6zUBffTaumF3aMLAUk3UANTOBvayev1AMomQnf
         lE5mNSje+sxyKL9NVVvWbVFsC8Q+uaxKwp/0ffh/l/sU2TxFvTlOJwrljl8ZV98aAI1S
         bGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760810513; x=1761415313;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fesa7zfnyQPwvNS008TVkL6pT2+7y4mb6RtsZYkI/nc=;
        b=USJju3+OkLgtiFFomke5QJrE8TmBXo3afInUppcV/Y/tFfEgZhN57Ubk0rp6bwOKnk
         3uBj48U3PMkHWMD/nGdkWZkg8f/dEmvziWVSCwvlphURmk2XCvBwWcox3HN1FUXkLdus
         JfgipDwCyaKGW8UOm7EQm1zgR2R8ZaLCOIIYFNDIk+9kmY8pczGktsJr1JJXjmJbrFrE
         RD13H+Goqf14uj4TO+LhFjT1FAZYWadDzBG63Kp0rr9BxOsUzr/Q+l4vC784Cj/mBXyk
         U0ckUgUuJpM2XU1YLYw8qyY44vqoO54QUWWhMBirXQ+4znrXvhwPcDEEr/pGDr2krMn2
         RUsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0uiisz4Xka2sglGV4hkITB6CMKZFJFrTUwQu2CYbq9sBIX/oqIa4I/1+qL7KUauj1yFucAh6In93RPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxE/taJr1o8pxehnp/2j+dFsIqMoiQNVn26RwEgEkuruE770NeM
	w62LZSSsOajiTMRiR5/OJ+MtPQ2ZZi4bfHJs5Fcb4Ut94AXLW7OFqrYGMMphoOa0SO9hYXUzgNv
	nYz/mEQmUhAEbPL96U8BRdPUP4V5QHVvp96JLUcO/HA==
X-Gm-Gg: ASbGnctLAJmnYmO9rQDg4+b69mC9E0L/s32JVFewIvhWqmna0PaeQfDMPwY0UAacK20
	QDjK5G7rEWWj97Z0s88oXWGwVTA0XzKQ1EQz5S6xUCvI/qUXK9EZQ1mrVwErJPnzH37K9ehq+a8
	L23ssTF2HalBdYsDnMiKCE5BPPWOZHU2Eym2ben01+io4wTQwpY47+n7SYjUOParPhOlith/z/1
	WzpcbDeA9VDgOXnfGPxkp0w3Zk4qFCFTVxmzpAg1uw8m8/y84xxl+WNHXfQ3uGce2IVzehJ3l0z
	Xf7kq5JGT5BheJeZhuNr+GvyTCuogKxu7smX5D9g
X-Google-Smtp-Source: AGHT+IHz1MXB7rPFHHNdaS7u5uUSUGTl5psHsLeVsJBItes2hEszQkNCTlc3h4n1tqs/j6l8DijJIaztcor0onVW85E=
X-Received: by 2002:a05:600c:820f:b0:471:176d:bf8a with SMTP id
 5b1f17b1804b1-4711791cd3dmr60228365e9.35.1760810512992; Sat, 18 Oct 2025
 11:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015121157.1348124-1-neelx@suse.com> <20251017164526.GM13776@twin.jikos.cz>
In-Reply-To: <20251017164526.GM13776@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Sat, 18 Oct 2025 20:01:42 +0200
X-Gm-Features: AS18NWCSZIBUpej3QuFGO9yMXc_ZXIFiDqYhoaNIO0PVOCFgOijbX7mltrqjKQQ
Message-ID: <CAPjX3Fft_GkM-pbAG+UpGDLYdEEvVQ9NNPpcAqo4YivoAcFgDQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] btrfs-progs: fscrypt updates
To: dsterba@suse.cz
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Oct 2025 at 18:45, David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Oct 15, 2025 at 02:11:48PM +0200, Daniel Vacek wrote:
> > This series is a rebase of an older set of fscrypt related changes from
> > Sweet Tea Dorminy and Josef Bacik found here:
> > https://github.com/josefbacik/btrfs-progs/tree/fscrypt
> >
> > The only difference is dropping of commit 56b7131 ("btrfs-progs: escape
> > unprintable characters in names") and a bit of code style changes.
> >
> > The mentioned commit is no longer needed as a similar change was already
> > merged with commit ef7319362 ("btrfs-progs: dump-tree: escape special
> > characters in paths or xattrs").
> >
> > I just had to add one trivial fixup so that the fstests could parse the
> > output correctly.
> >
> > Daniel Vacek (1):
> >   btrfs-progs: string-utils: do not escape space while printing
> >
> > Josef Bacik (1):
> >   btrfs-progs: check: fix max inline extent size
> >
> > Sweet Tea Dorminy (6):
> >   btrfs-progs: add new FEATURE_INCOMPAT_ENCRYPT flag
> >   btrfs-progs: start tracking extent encryption context info
> >   btrfs-progs: add inode encryption contexts
> >   btrfs-progs: interpret encrypted file extents.
> >   btrfs-progs: handle fscrypt context items
> >   btrfs-progs: check: update inline extent length checking
> >
> >  check/main.c                    | 36 ++++++++++--------
> >  common/string-utils.c           |  1 -
> >  kernel-shared/accessors.h       | 43 ++++++++++++++++++++++
> >  kernel-shared/ctree.h           |  3 +-
> >  kernel-shared/print-tree.c      | 41 +++++++++++++++++++++
> >  kernel-shared/tree-checker.c    | 65 +++++++++++++++++++++++++++------
> >  kernel-shared/uapi/btrfs.h      |  1 +
> >  kernel-shared/uapi/btrfs_tree.h | 27 +++++++++++++-
> >  8 files changed, 186 insertions(+), 31 deletions(-)
>
> Thanks, it's all preparatory stuff so I'll add it to devel. The escaping
> may need another look so the fstests don't fail.

fstests may need to be fixed. The escaping is actually needed for
generic/582 to work correctly with btrfs. More details in the other
mail.

I'll double check with fstests again.

