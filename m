Return-Path: <linux-btrfs+bounces-13628-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA61AA73CA
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 15:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229363BE981
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 13:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D8F2550A9;
	Fri,  2 May 2025 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CKln8aA6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDAC22094
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746192787; cv=none; b=EeJrNSGdLPrALU5boS6rvmn1/Il7jPWivqoLdgFhZI5MTIwMjaYGlvSPIJNMBJQDlxZsPbqBSvt1ZOCmo1x7GAUritEZtUWzW2ZDqK0VraSORnE03AeF0RlQqdGBa47ZtosmeorQvmhx0o8FLBo3hw33XXXnd1goa8ENdEh6YIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746192787; c=relaxed/simple;
	bh=FlW/UF7f7/Gtamx2vgMlkyZxhslwL/odgFSE981p8z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOENi4ynVF1wgjwDQXzeMOzlr9pQubM4fUl7DqubtibYA2xKax9vgPxgp02yF6VtzsTodpRVy8d9+VlFIQZeI0mTLJb2xXmtzGAJ73CpImPi/U3EQjKL2+FSo3Z0ouOa+j6zZlPMarBh5sEMmnJAGkK47Hc9+AtUWFwMyvvjD9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CKln8aA6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5f435c9f2f9so2916164a12.1
        for <linux-btrfs@vger.kernel.org>; Fri, 02 May 2025 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746192784; x=1746797584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qjz2fDPTv6J6jq00AOM6r2QStLI+YzEJmsBkOrPIgg4=;
        b=CKln8aA6iNJ0skOHxkzxqC65NWifdmpbiXgXnqqXo7iNPORBVBeJagFKL1I9YTq6Nt
         50XME69m0b2mvfXrrjtsEL7digQtEb9YM0AxA9EO4UOh+PgNSbTlFyqzlhhNDAi8j+5V
         plUwgaK6GSBV9LuwiSGHkl7Jyoiao/p2v3Bxl0Yu4sKRGfW7A9M6c+j5MHR401P2Z6Sj
         +uMWH5hUPYlbX2Vs8yOPE4RQFuPo5g++EMwKI8iaDhBuZi4NkhcAWWKwRe853AtitIpi
         YQXdOkzEdw3rgwRfLKLq1xClSaSc7QGK8k5MxoQ5ZtYjLT7+VoNiecAYydORD5dLiIf6
         Fwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746192784; x=1746797584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qjz2fDPTv6J6jq00AOM6r2QStLI+YzEJmsBkOrPIgg4=;
        b=sAD1/JxIiGYvH/4TjKyUmZDHDCsP4QYZ7QPFL6xTcQXCuYpW7AImlLvfEyXN4Y05gX
         jpsHhsK3HIu3OlPdS2St2k0gCJTCMllz7nRlZNM64/mgPe1EvYh/cdA2k+Az9W8PAdo5
         +b7dlyUS6+abID+YBxw4D1JqC01pnFvvB0eondycj2Uty9TfIxomhEhlI7G+Td1/1YpA
         f3uUSJzTydiya6SlCHLxFzUp0ozabx+JdgJVlf64u8SE5blbLJCmpoPKbAQ1bwDArmwN
         RuD8YdKv45W4SNXWXjt89FU7x3RzOxFeLIMRE7LVZzd0vVIX+cLC+JALI3dNGMxTyaB3
         0CUw==
X-Forwarded-Encrypted: i=1; AJvYcCX9pg2xJRjb9Sjo7G0+g2CD8GGK8A7FfnJo0nThIl+VyYiec1aF9dwiQXbjJWjw2ltKdR93cxA0N5hmBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1aP5Vh1JnAt87jV8d79eceX5GvTbdNyZVCpFXxzMQri6kiF5n
	M5lsUY4VZi3UtYOfjBTRvtXuENxLOk5aPXVPTFnv2zTR+c54GKYU2c/t5xkbBmXwKBRUuKZSw/G
	27/KDMTJDgehw0dPFwusJu1xr9tc/+YtG1PCuC04oR4O+Tb4YonU=
X-Gm-Gg: ASbGncslw1nEJ6vyHoUM1n05gmP8d2d6/geTp4BU9TlH6hjFEf6oyNQCZVU4eov2j2M
	4nxt+tN6Y9ros3jGt+I2IwGmCLvsQTUXgui0qHHy+AnIiMhWjMGE6/7Zk3r3EPxVwAu5F+nZ+hV
	XDqhowEI/ySkGFXUnv/qpd
X-Google-Smtp-Source: AGHT+IGCkyVYluzodGE1J7J34y5ts0uAXKxSz8cEGDGAhwLTOMiy3mYcZTInbxMWyS8TcdHWZu6t2EkWb1UamCiH1/A=
X-Received: by 2002:a17:907:7d87:b0:ac2:a4ec:46c2 with SMTP id
 a640c23a62f3a-ad17afcb2e1mr295610566b.49.1746192784105; Fri, 02 May 2025
 06:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746031378.git.dsterba@suse.com> <CAPjX3FcAA=2cR4WqxFUOXZ4zYHS8hS75-ii0HPKQddgwhtr=Vg@mail.gmail.com>
 <20250502132407.GR9140@suse.cz>
In-Reply-To: <20250502132407.GR9140@suse.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 2 May 2025 15:32:52 +0200
X-Gm-Features: ATxdqUE22UU_U_8-qPy33iEXgpL3vVhbB5998ddVPAm0jyJ-kpkKq-AHK1pGtKw
Message-ID: <CAPjX3FfMsjumdvv+BxtknhuGbXROKSioo5KGf-pj0_DafXsYkA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Transaction aborts in free-space-tree.c
To: dsterba@suse.cz
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 May 2025 at 15:24, David Sterba <dsterba@suse.cz> wrote:
>
> On Fri, May 02, 2025 at 03:15:49PM +0200, Daniel Vacek wrote:
> > On Wed, 30 Apr 2025 at 18:45, David Sterba <dsterba@suse.com> wrote:
> > >
> > > Fix the transaction abort pattern in free-space-tree, it's been there
> > > from the beginning and not conforming to the pattern we use elsewhere.
> > >
> > > David Sterba (4):
> > >   btrfs: move transaction aborts to the error site in
> > >     convert_free_space_to_bitmaps()
> > >   btrfs: move transaction aborts to the error site in
> > >     convert_free_space_to_extents()
> > >   btrfs: move transaction aborts to the error site in
> > >     remove_from_free_space_tree()
> > >   btrfs: move transaction aborts to the error site in
> > >     add_to_free_space_tree()
> > >
> > >  fs/btrfs/free-space-tree.c | 48 +++++++++++++++++++++++++-------------
> > >  1 file changed, 32 insertions(+), 16 deletions(-)
> >
> > This looks like unnecessary duplicating the code. Shall we rather go
> > the other way around?
>
> What do you mean? There's some smilarity among the functions so yeah
> the add/remove pairs can be merged to one, but this is orthogonal to the
> transaction abot calls.

Not that. I meant the code looks simpler without these patches. If
this is the pattern used elsewhere, maybe we should rather change
elsewhere to follow free-space-tree.c?

