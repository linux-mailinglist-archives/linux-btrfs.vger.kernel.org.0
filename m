Return-Path: <linux-btrfs+bounces-18769-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 99952C3A1D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 11:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C38C350A0A
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 10:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CB030F541;
	Thu,  6 Nov 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EWJw7Utr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A02211706
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423477; cv=none; b=pf6o10Tx6F9V4lN87/ikF+2QlPXr357yJwRw7KebfjBUAqfb9nak7TCnjHExx0vge0cxwsyizNLi1XVPvJYoxAYh4eHw31ufCy+ZUtnmUT7qtFSb5rA0ZLVMhFDv0u5M0Wrf52vuQS0ZonFRJZ23U9A/KqebBh2WXE+290PXOfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423477; c=relaxed/simple;
	bh=vT6p2Ft83AUVQpnKCW7qD9vJskfIVgaA8WibD4YKicI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1SFsLxb9c5DqqGYx4ROZUTdOlj/vTB103nFMqAaLWuCPTKBTt9DoZM7cYkuhs215Kppp07Nf3CALvxvhs5Q0scmEXXwrm/AfYaX3fcaiSoPxZX3ORNN7voaunHMSfVHBcLwUIJFfGL8J+bovfshmSW5TdV0rL4+ZWEjOHqVxjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EWJw7Utr; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-429bcddad32so558234f8f.3
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Nov 2025 02:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762423474; x=1763028274; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9pzqQqc6IcRolbDep+B7yNbdFvNbgM81NTbfjuCoPvY=;
        b=EWJw7Utr7kFd1f8ZUvIiWqRkqtKpp52g+YmchQCC4S05k6Cd7cFYbI+ad6Z/wgp0vc
         l3t3z4j+yGbb0fk4sgWWdegtBJxI7obj6qrPaE6kNk8wzESqc6MD/iCcSb/mmGOXArGL
         mhkhgr1QN2TVly2laj9kolEjdnI0pFcssp/wBrHarXmhYgzioJfGI39iU6o3sTh0K5Ca
         qLC4ZWZb4HKr+Vjy5a+nNMWqiCWm9OZxnLVoca1XNJZBF02yK7jlDllo8dxNSvUoOVbQ
         rwmSQewTkbu/RagiSfsR/QUNYV97HrT5pqew0iD3rNbxZ+rLSmGbbTzi/FimbAeDctQw
         y8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762423474; x=1763028274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pzqQqc6IcRolbDep+B7yNbdFvNbgM81NTbfjuCoPvY=;
        b=e5SqG5i6jnZosjL+aSl7Ws9GOAKFYQ14/BOC8vTsVzEfkDAtYOgX5h0+KUUBTzM3dQ
         o2D+Bu89WY7IeEbxMVDYFSDqM/ZUCAgO1cNFu6VVMjVhrspLHCm1ceV4jvKfs1KjLXp6
         1puuj1Bh19u/HI20VQhHF5tCjW5PRElzCeyM+agCd4blplr5Ex8t5b4HwDvQ14JJwRdI
         QonVxOtYN6+gUFo/0/QCAntCavTZP1XXWksWZpMY9Z5HHtfAjQVGlp6q18587j15wUfC
         WCOrMGVmUae5vhY0zmodONipY08OVu4pbGWXY3CYcpLcVzYrmlmD4N8DST5kvf80pRiy
         a5hA==
X-Forwarded-Encrypted: i=1; AJvYcCX13lBl3OOQyGzYVeMga2NEx+SuJnq60MKyRHg9dj2p/cZU0asv1/5+QIpOKr6HMqPkKZKzxGgA1wskFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjrUfpM3/70W7Y9zCJ95987w+zjIcBFwD2ElBiSb6Hn0puOSps
	pXrWlLgPcgyeo97VfxfH44QyUnInTIoN/BGDKAnosRE0KItGXMAecczKYsggCyIMez+09AM3/nb
	yv0kL4VeHVMsxdiOWx4ff+6wd6LAWxC6pOoCpIdwFDA==
X-Gm-Gg: ASbGncvWgghNvPPUDekKDp+Sw3nz+7j5WaSfzG1VHq14vV4HQRzCZUTGeKKVwPrYOU6
	2tOL7Lr13uDer6fL2zOuLIsq0QXKPuoYBjH7EXcvIoKBwXzZaTzno8Y5CfESdvjm2CKYxV6h/Yc
	dlBJN6LWiRNsQjwTXl9wMkKN5v6WcunnLXAv/nVCiUfJXv7gE2u1b3DObxccCouY+zWKplvzzBY
	YV9D007Bv/r+1gkiJORHP5jLPOQ0uEc4NcUkV+yfmNoVbksM45ZDVAdiS+u9zk7OZOsUIVlxKfj
	tr0Jrl3uC3apkEu9Wv72ST41IvqFiHFZIu32z0k82WjydYwaSKPHuKR81g==
X-Google-Smtp-Source: AGHT+IF9F1VA3FkhFo+HExPWDHAEgrgxeGGJA7rdOjuOxk6TFCz8t+ouX+7Zbvmcn9f9578SldeY9TT64Kn6ISeqc/8=
X-Received: by 2002:a05:6000:2386:b0:429:d3a7:18bd with SMTP id
 ffacd0b85a97d-429e334019cmr5012608f8f.59.1762423473555; Thu, 06 Nov 2025
 02:04:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
 <20251104-work-guards-v1-5-5108ac78a171@kernel.org> <CAPjX3FeEZd7gX1OeCxRXrdBMafHOONB2WQO_JOZuxKoVEygzuQ@mail.gmail.com>
 <5puaizn2a4dpoinvkct2nz5zdvvv5vdrlrmwcz7j6vl7qrxicb@b4qi4yfk4a5u>
In-Reply-To: <5puaizn2a4dpoinvkct2nz5zdvvv5vdrlrmwcz7j6vl7qrxicb@b4qi4yfk4a5u>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 6 Nov 2025 11:04:22 +0100
X-Gm-Features: AWmQ_bl_uakVnhsIAEGayoqj-TUUrVul9249azhsCYCCICpGbdkLg5N_W05IYjE
Message-ID: <CAPjX3FdKdV5ouW3Vjx1jMO8Ye_21x5CDtpOn+BBD_tou1gPkSg@mail.gmail.com>
Subject: Re: [PATCH RFC 5/8] ext4: use super write guard in write_mmp_block()
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Nov 2025 at 10:24, Jan Kara <jack@suse.cz> wrote:
>
> On Wed 05-11-25 19:33:35, Daniel Vacek wrote:
> > On Tue, 4 Nov 2025 at 13:16, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  fs/ext4/mmp.c | 8 ++------
> > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> > > index ab1ff51302fb..6f57c181ff77 100644
> > > --- a/fs/ext4/mmp.c
> > > +++ b/fs/ext4/mmp.c
> > > @@ -57,16 +57,12 @@ static int write_mmp_block_thawed(struct super_block *sb,
> > >
> > >  static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
> > >  {
> > > -       int err;
> > > -
> > >         /*
> > >          * We protect against freezing so that we don't create dirty buffers
> > >          * on frozen filesystem.
> > >          */
> > > -       sb_start_write(sb);
> > > -       err = write_mmp_block_thawed(sb, bh);
> > > -       sb_end_write(sb);
> > > -       return err;
> > > +       scoped_guard(super_write, sb)
> > > +               return write_mmp_block_thawed(sb, bh);
> >
> > Why the scoped_guard here? Should the simple guard(super_write)(sb) be
> > just as fine here?
>
> Not sure about Ted but I prefer scoped_guard() to plain guard() because the
> scoping makes it more visually obvious where the unlocking happens. Of
> course there has to be a balance as the indentation level can go through
> the roof but that's not the case here...

In a general case I completely agree. Though here you can see the end
of the block right on the next line so it looks quite obvious to me
how far the guarded region spans.

But the question is whether to use the guards at all. To me it's a
huge change in reading and understanding the code as more things are
implied and not explicit. Such implied things result in additional
cognitive load. I guess we can handle it eventually. Yet we can fail
from time to time and it is likely we will, at least in the beginning.

Well, my point is this is a new style we're not used to, yet. It just
takes time to adapt. (And usually a few failures to do so.)

--nX

>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

