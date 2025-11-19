Return-Path: <linux-btrfs+bounces-19154-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E672CC6F659
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 15:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 029EC2EFDF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455B7369206;
	Wed, 19 Nov 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a/oCbNqx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2275D278753
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563173; cv=none; b=TndEH5c9Y9kIrnVePKc4UQmSGQ2m4+JQNM5RLZ6JyVXcFw6WOln+LpEUZBEX+SK3vwraPtoWsCJcz8p8fKviE6AVTQTkoYoEgtRFz8eQs1TdQlp5ZR7QEJGWhczN/QcEo1dJczd/fzjF1p65jv4LRxZWKAci4+9gms4BWq9ptj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563173; c=relaxed/simple;
	bh=YNlz37St4yhtg1LNv4Ziptcl1WhSBVFF0tAatBtVo9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGZe1CKgf50eqxxDCXRyBn7uUKUtDRtbTFonF9gi3meQJhUv6WD5YKfNQqMgTGdbwCkjirHdLPISmo5eVVvkkC8NSURg6OL+WvQ9h3g8KzuWIBQsOqgzCatgZ1b+Z2XgIgu0McwmORUKBYetRQvhsTl8AbqqH0Z64rDjOYd7LS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a/oCbNqx; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so4141949f8f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 06:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763563169; x=1764167969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rz1y+SzbfbO1o+CGc3JVhvRUe2jwyjtiSjGdiH3ci5Y=;
        b=a/oCbNqx05Yy5Y8o7ZzX72cc4QQk+vhjiO42lhYqtnJnsAsmZV/xt+slwin+zP9TXf
         ZNtfai4pIhvMxpIdfgCOoU2DPn8u4t815/JmnBBwEuvzRW21WvyTjTCe/3ly26U6P4PR
         nq1VD/1OUkVSHUvF0DFJwQ6Fne/Y74EgoKY6MEagxG4zIW3XglcQytXmKf4KnPDBreOu
         e9vgjZLLchaCRmkPo3BEFz71alimJh7SdSDtRHqThGn2ck1yXK6M3pzdFrHdV0YYBqtX
         C4zYy8yExL51DOsz9SlJKCN6VCMF9L/k0vgldzFGNCBmo2mSaZLl62erc4UCIhF1BMa4
         Pbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763563169; x=1764167969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rz1y+SzbfbO1o+CGc3JVhvRUe2jwyjtiSjGdiH3ci5Y=;
        b=aX3689ZLbvK5RaHXjtwLWym6zCFsisV7SC9RhCm1MTbr1qF0wGM1s5M1+XZppR+FB8
         zoANBZ6PqKc1f2f88Ux5hCzgCu03u/RQWMC4bwOUpAiRskrNowQevkgzAsDgwR0LsFIY
         XBMSavhneJiEEve/0gkPb3p3dBx9IOWSlTuEVvpNZxqYW1R6CXGy/bJkBaX4scwB9u/L
         sO/yDqKCRDhpBqmH9o+cU/17vAqW/9/ICcMs6F0wFJKv0kjSyc+niuIY+kOe+9QqJUzN
         z4SFg1OJFbvMU411X4AFtkok4yenFtFosaZMCQFn+FH1HAhlH7D0Kbn9gwMZCOHxkfcX
         yiow==
X-Forwarded-Encrypted: i=1; AJvYcCXo6NjNfr3H0MRTiFe3PGngB6k+qX5ieFkd5ZHTl10FxFiMAyZb/UAV76BtWKBLd5D3+DckKZ5dDDFhRg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc17QrDFedMfQ/55tFApTEIb927IFvPbaGpUW4/z613gN3V0fY
	mNP+/FT3Z/jpkOMLAyXbbv4MhQk+Xn+IA25Wzc97tJwRG7YTrbzgVN+J1t/NZEAj2ANtcdYGbEN
	xbL7UgkM2/7YACJp60HmJIsC1V5RV1MoFVkdfMsrVHw==
X-Gm-Gg: ASbGnct/+Dpq1ybPrpsb+l+pP6e64qgXQkUeDle9fiRfl1/uq4dEkkz1Nijg9k8KY9I
	3h/JzPRJXWepKIlvXxd3sWT66oPfQdwHU3MfHUdiUdUp2PxOqO6tTWy+4RTY+LGpxerGVSG32i/
	1g4LMmBGL19vdKdUkfWLxz6K48Hhh4ZqGwTFL0ftwnj3OQbIaSHigg8hVEPtRspsiWRcKDoXwlj
	sJqiGnCjTwK/s0pPh+dN3+YkUVE/Bxo5vlZf3SkZ0m6numGCRCf5AWt6Su+UMQkQHOzuSgutC4F
	FUvRRkRxyarKq0NSrGEmGW3KEIRgNSXCeTsuUVyYDTYsN+LQ8vIasGlwegXdanpljXqLOPTH41f
	sCYY=
X-Google-Smtp-Source: AGHT+IEhjhpyfUkaGLCsZw/6a1gfPnlWZ2QhBEgl3tNVB9FAEELR+a6ve6vLz441BU9kzasekAlV/49toRwVD5Uutt4=
X-Received: by 2002:a05:6000:26cc:b0:42b:41dc:1b5d with SMTP id
 ffacd0b85a97d-42b593452f6mr19770620f8f.25.1763563169105; Wed, 19 Nov 2025
 06:39:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f03e80d62a824f4494335d2bb0dc217ec26a9e98.1763556089.git.fdmanana@suse.com>
 <2c984089-f13c-4a00-98aa-39c19927dd9b@wdc.com>
In-Reply-To: <2c984089-f13c-4a00-98aa-39c19927dd9b@wdc.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 19 Nov 2025 15:39:17 +0100
X-Gm-Features: AWmQ_bmoJDzrLbSgaCpbLikkJuV5lufijBjeb6PRWp0XkkB_bSyrYorEqxyLnDA
Message-ID: <CAPjX3Fdj3=ek2K-WY3doYM+VgnBhbr2tQZ+vhU_otxEOcd5Y0A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use test_and_set_bit() in btrfs_delayed_delete_inode_ref()
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "fdmanana@kernel.org" <fdmanana@kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Nov 2025 at 15:28, Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
> On 11/19/25 1:57 PM, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Instead of testing and setting the BTRFS_DELAYED_NODE_DEL_IREF bit in the
> > delayed node's flags, use test_and_set_bit() which makes the code shorter
> > without compromising readability and getting rid of the label and goto.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/delayed-inode.c | 11 ++++-------
> >   1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > index e77a597580c5..ce6e9f8812e0 100644
> > --- a/fs/btrfs/delayed-inode.c
> > +++ b/fs/btrfs/delayed-inode.c
> > @@ -2008,13 +2008,10 @@ int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode)
> >        *   It is very rare.
> >        */
> >       mutex_lock(&delayed_node->mutex);
> > -     if (test_bit(BTRFS_DELAYED_NODE_DEL_IREF, &delayed_node->flags))
> > -             goto release_node;
> > -
> > -     set_bit(BTRFS_DELAYED_NODE_DEL_IREF, &delayed_node->flags);
> > -     delayed_node->count++;
> > -     atomic_inc(&fs_info->delayed_root->items);
> > -release_node:
> > +     if (!test_and_set_bit(BTRFS_DELAYED_NODE_DEL_IREF, &delayed_node->flags)) {
> > +             delayed_node->count++;
> > +             atomic_inc(&fs_info->delayed_root->items);
> > +     }
> >       mutex_unlock(&delayed_node->mutex);
> >       btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
> >       return 0;
>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
>
> Just a side note here, because there's been a discussion on linux-block
> [1] about it,
>
> this now unconditionally dirties a cacheline, whereas the old version
> did only if needed.

Since it's protected by a mutex in this case it does not look like any
significant additional overhead.

And OT, aren't caches finally smart enough nowadays to detect the
value did not change so it's not strictly needed to dirty the line?
Just wondering...

> [1] https://lore.kernel.org/linux-block/20251106110058.GA30278@lst.de
>
>

