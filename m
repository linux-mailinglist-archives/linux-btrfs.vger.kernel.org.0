Return-Path: <linux-btrfs+bounces-6528-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E9193432E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2024 22:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D04BBB21092
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2024 20:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05081849F3;
	Wed, 17 Jul 2024 20:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PJOmvklR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3DA181D05
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2024 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721247699; cv=none; b=J/nhlRDfrB07Am/h1cOM4IJc4MejqeNIyh8T83O34GKGDkkct4gFYOHR5Bt13IM+a6a+d1FMfyxbsgkLoIBMZXc6zbE4RyesxT/LSor+e1WD1ilpUB5X7BjiYhCsqbMH9xRW1HkQZ4fh0xAvqx1hsW6d36+6nPY1AMbb7MVeDnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721247699; c=relaxed/simple;
	bh=F62dhyXKuf3KuoDqBu23LhP34ibc2G9DlvcvwONj4Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggp9Tokk8TcxxmIfNHtNBlSY6UHQxbW6mSkOY5kwlsgTwwBCmJbhKGt3iq45suKRvxsVcmTKg87e2pK9WVlHmJdfmrBu+Hcm3S/+1lcgtkELwy0va5qYXTXnGF44eocS0tW3rsOd3zAfY2CgVssK/50/PwD+A0+d9BEjFZo/ANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PJOmvklR; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so45346a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2024 13:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721247695; x=1721852495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mcYek1X47IdJAigxA1PBJaYwzUbk4Cxy09ZUwrhJ/mQ=;
        b=PJOmvklRfuRFO1BxFfcH4ZHuJ+jxyhhEhAjoUo6mp9ouNO69yaRugjntlSqVL2TBPm
         G+JEjvKPSbg/jheBmgoffRJSP/QDsOlOPgI4qjgQBE2d/s20xZmfkg/TI+8mLar/4E8Z
         Ku34Wyrv/Z00Ws3rZ+L4+pbtyvt3WUQ1GNyCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721247695; x=1721852495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcYek1X47IdJAigxA1PBJaYwzUbk4Cxy09ZUwrhJ/mQ=;
        b=Xq6jDjVEIQapxjXdad8l0uhrmghQniWJagAkjP2OHhGhjCNrlSIl5l4on68aX21dx5
         6zn9792XAMpr72ohChFgNy67NkrUiaVvBNAsM60I3rEHtZIBzAWQHrz8p354dYzIec82
         eMxFlUvOHpxzE3aQSA/6X2AdCuZHYXmkm5dGd60hK68ShWcB1nA07AMlD/QVygGil4u2
         nX38V5VzoSVF6QvEvgI5F1q9MIuvwAMbG5WiWIbLO73GurQuF1yVQkJTP7voyyfN/P45
         PPelquYmflisZ28batrfQt4Kz9j3t6B/eAs+18rIyDbbbdGSLC5iZd/TSAgnqC48y7kY
         ivTw==
X-Gm-Message-State: AOJu0YxcxlrEsVJupzuBO21jFhfPXFKaNcrsw8TrDOgE26aGvES/UKDt
	09Re3zoRex+1lsMFMmmMnH8qcLlKdsS6/ZJkw7ZD6dFH3CXj6K0/T/jQavW4NF6aJVLTZXXtmpo
	+J3yNPw==
X-Google-Smtp-Source: AGHT+IEFwkRnaoz4G/j3W5rBI7OBOD/GZstkC5uth/EivN0XDHxDwo5r93njE2wStGr6BPZDzgWCmw==
X-Received: by 2002:a50:8d4b:0:b0:57c:9da5:fc09 with SMTP id 4fb4d7f45d1cf-5a05bfaba0dmr1988540a12.23.1721247695371;
        Wed, 17 Jul 2024 13:21:35 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b24f56d24sm7447624a12.23.2024.07.17.13.21.34
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 13:21:34 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a09634354eso45329a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2024 13:21:34 -0700 (PDT)
X-Received: by 2002:a50:d593:0:b0:58c:6edf:d5d2 with SMTP id
 4fb4d7f45d1cf-5a05bad527fmr1878679a12.15.1721247694305; Wed, 17 Jul 2024
 13:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721066206.git.dsterba@suse.com>
In-Reply-To: <cover.1721066206.git.dsterba@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jul 2024 13:21:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgw9uyrpi+qL28Ee650p7jaXEMjUoRzXBymraoENDMt6w@mail.gmail.com>
Message-ID: <CAHk-=wgw9uyrpi+qL28Ee650p7jaXEMjUoRzXBymraoENDMt6w@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.11
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 11:12, David Sterba <dsterba@suse.com> wrote:
>
> There's a merge conflict caused by the latency fixes from last week in
> extent_map.c:btrfs_scan_inode(), related commits 4e660ca3a98d931809734
> and b3ebb9b7e92a928344a. Resolved in branch for-6.11-merged and that's
> been in linux-next for a few days.

Oh, and I notice that my resolution is slightly different, but looks
like the actual code is equivalent.

I kept the "q" logic that had been introduced by commit 4e660ca3a98d
("btrfs: use a regular rb_root instead of cached rb_root for
extent_map_tree").

I don't know how you prefer the code, but it kept the two "while
(node)" loops in that file looking similar.

Of course, they were very different in other respects (ie
drop_all_extent_maps_fast() does all extents unconditionally with that
retry logic, while btrfs_scan_inode() has that whole "bail out on any
contention" model, so whatever.

Anyway, it all *looks* ok to me, but please go and double-check that I
didn't mess something up.

                Linus

