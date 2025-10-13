Return-Path: <linux-btrfs+bounces-17684-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1113DBD1F85
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 10:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7DE3BD3E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 08:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BB52ECD03;
	Mon, 13 Oct 2025 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TWUOxepc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FC72EC0BF
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343316; cv=none; b=cWVIXErOwi9L/P5GDELLzusnKFfsuNS8qs0DqcRy6/DHt1O6Vn25o7mR/oam7yWzWry1vewQKF56AoDCmn/z2ehT3rfYkBi1ObwWv3AyZEPH1Gy79lWr5Di/klZGHK/CiSjMhEVFF6viY+3cmHIwxrnOCIjbMlN07CCfEmKOTcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343316; c=relaxed/simple;
	bh=ZDF9V6SdJC6O5Ci089i93CmqQdlIvNR7SmEpklYtaiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OURJb1JML9J6KGr03s01K6x/f/sG5qttZPg3JZtF9atsoPf2mRVL9PywwSeMnKYKIvsf7zKu7j3UB3xxxZFZXr4UUd5E+5x0aWg8CJ2tRc2j5fhKp7YjIuBe5lVIRSBoIDGApI4ru+aqF4KwS1HUrCuk7SOH5X6X+4+5Ya7kHRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TWUOxepc; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f44000626bso2748893f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 01:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760343312; x=1760948112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R740my9A/r0yGv8JF/opdryBZzIxczQeXr2k5izULh4=;
        b=TWUOxepc3LLnWjGWhlpuHdQuyOvh1ON8xPxTWN1Zt6RiP1dtffxt4BH+p9AwPuPWyA
         geHyO99HKN5xJeEgPSwZSVggoXYsZPRq4ILO8nzuMg5ZksDS24Zk+jMdG16+tMSJImxz
         wtpNPgMSRbeik7p43Pew6RjImi0HsVflcYX0kBYv0BIi5iPuPZO6MNT5BEoyQ3Axt4hL
         IrsdBj05F4bFxR+l/enqx/DIwwBTw8wttmrzTfskfs/TkXAAGD9nuV6pFiLgc9vaRJZ8
         HHMC3vJMy38yQU6/w5sVcUlez0lZ+Ayesxup9glXl39siTmpxyelVxLCOFwS7MPAsAHF
         J0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343312; x=1760948112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R740my9A/r0yGv8JF/opdryBZzIxczQeXr2k5izULh4=;
        b=ui9k9RfGyIgIzGEeOkzQeE6Hgnmzo4NJ9EUGjwwr1XXSvjh3gspXZGvnijFfzoXTBS
         43sXGVt0qd2DB5i+hU4lfGxWAJUbOb1dSNJBd2ml0h1sRuuqMOClE97YG/Exu2XpuHX2
         Z66Plshw2HctnYsLKdtN0W2E+ZOWRTFHrGwAEwD0aVv/z73qOpTs0jPKeSl0lcDo1HYX
         NJB5Cla+ZDxg82tcIEkvwMm2XGDoar6mTS7TwTMQi3uD7Z8Hf+ek4REZVQIfyDTaKvRu
         zwOyzyLUjsJ+Krhvp1ocvGCh60uzldATnCxUtZcQjfEOIgFsQn6VSXwir+N6ImO1Un3y
         YQOA==
X-Forwarded-Encrypted: i=1; AJvYcCXlUZYCr6NixLa2G4yj1mJFEBkOSQytNP4Jubu23tDyjvhlW9pg5y0kRgSlLzc8LfSwsIaOA2fV5/WV3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Dw9cOsYzVX748J3oEVVA73VqZG2FULCaNOkxozi5kab7pi3V
	b50yQxOHw06zmtRuuXylwCmagLUkIxWpwswISkgScpLPE+Ppcz0qONgeq7x5sksIe9MPmn/hh5/
	bEuw0VCcbYmF05Bzrqdq5QYfsZDxfjzvxXrr9XnSfkA==
X-Gm-Gg: ASbGncssynzajaOtS20/AI+CAjNajMgtF7wSbx7DJua4HgV1B+YiDeAIvRZ3wEZOfoi
	R9K13/sKkZ0SdshRB/bGMfJ8w5VQ9l6a+ubu9iyr9csu1v+wfCfwaKFkScvTUfgs5ozlI7l0tes
	yUK0+lDqbP6s4Jcrhbk7INwvWO0HcRP5WcOM8N3jqkhFeeI+GdaM7ut8Fd/fFgqZH41koiBoijd
	gwhTMKdg51AL7TIZaQJSJ/4Yi28Y1Fe9Dc=
X-Google-Smtp-Source: AGHT+IEXSnK8vgh5qb4+sZ5l2hFRJWnorbBdcfDu2E4RvgYsaMIAeq5q8p6/Cp6GKDAeCkB0EX+DEBuZJrHy3pYKRvM=
X-Received: by 2002:a05:6000:430b:b0:3ed:e1d8:bd72 with SMTP id
 ffacd0b85a97d-42666da6dc9mr13043087f8f.17.1760343312390; Mon, 13 Oct 2025
 01:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013025808.4111128-1-hch@lst.de> <20251013025808.4111128-6-hch@lst.de>
 <65aad714-3f1d-4f4b-bb8f-6f751ff756b7@kernel.org>
In-Reply-To: <65aad714-3f1d-4f4b-bb8f-6f751ff756b7@kernel.org>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 13 Oct 2025 10:15:01 +0200
X-Gm-Features: AS18NWCgT3XSP_MN-BMfr65K92-imDhnpGub1dZ7jpbkZ5N0Fj6p03e4QIM-oxw
Message-ID: <CAPjX3FdRvkie6XMvAjSXb4=8bcjeg1qNjYVT5KOBUDrc+H=nDQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] btrfs: push struct writeback_control into start_delalloc_inodes
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 09:56, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> On 2025/10/13 11:58, Christoph Hellwig wrote:
> > In preparation for changing the filemap_fdatawrite_wbc API to not expose
> > the writeback_control to the callers, push the wbc declaration next to
> > the filemap_fdatawrite_wbc call and just pass thr nr_to_write value to
>
> s/thr/the
>
> > start_delalloc_inodes.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> ...
>
> > @@ -8831,9 +8821,10 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
> >                              &fs_info->delalloc_roots);
> >               spin_unlock(&fs_info->delalloc_root_lock);
> >
> > -             ret = start_delalloc_inodes(root, &wbc, false, in_reclaim_context);
> > +             ret = start_delalloc_inodes(root, nr_to_write, false,
> > +                             in_reclaim_context);
> >               btrfs_put_root(root);
> > -             if (ret < 0 || wbc.nr_to_write <= 0)
> > +             if (ret < 0 || nr <= 0)
>
> Before this change, wbc.nr_to_write will indicate what's remaining, not what you
> asked for. So I think you need a change like you did in start_delalloc_inodes(),
> no ?

I understand nr is updated to what's remaining using the nr_to_write
pointer in start_delalloc_inodes(). Right?

--nX

> >                       goto out;
> >               spin_lock(&fs_info->delalloc_root_lock);
> >       }
>
>
> --
> Damien Le Moal
> Western Digital Research
>

