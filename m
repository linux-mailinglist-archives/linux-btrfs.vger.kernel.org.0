Return-Path: <linux-btrfs+bounces-22126-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L9AI4ERpGlcWQUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22126-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 11:14:25 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B201CF0E8
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 11:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD99A301AD37
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2026 10:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A403358BA;
	Sun,  1 Mar 2026 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b="JtAqwDd8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6276F335081
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Mar 2026 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772360055; cv=pass; b=lDEr5DbcRHN0p9wcQUhpXEJz5ZVGFqX8UrTuqmD92HUud8rkvgM478SvUpVWrXPhQEEKUNYDQ9CT1NPdtJ0SPUhb1MsLtbQJnX/SKv6KRTCEF5/w9Q8wOFqAXKpBmw4/oRZyyJgcx9hDcXk34w2Qo9u3AiW4S54sxROVwvh04A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772360055; c=relaxed/simple;
	bh=K/p9SY7vSgSqQ5XG2GaZI4QLUqPntDGJHVhob7W34Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkAGe/Dtl3PDK8j3myxSbVVGohi0dj7roqQJbb690qCUa0NOw8NVXkuv1M5YGHj98Q7CNq4TMqKome+lzbys6qTJul7l89vUXVgGBRHlwMgJC39W1OzIl0EBNd7fWFaBsaT2zcWjUR2252pvBH35tb7TEwtyutVy3k+qr7Sq6Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com; spf=pass smtp.mailfrom=zadarastorage.com; dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b=JtAqwDd8; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zadarastorage.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3598c1ad542so58722a91.0
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Mar 2026 02:14:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772360054; cv=none;
        d=google.com; s=arc-20240605;
        b=QgIiad4rIAVZuV1qiRyJarlAOnxdjCMQO6LqT2dNO/uwqltsLkGt7kFAtNaTZMG+eL
         heMwyYEdI2tXcwQeUZhYRJ/mZgH1oTKB8qDVHPTBbgWMvbtHJeMPqT7/eJD1ubcp4+ig
         qi/gcMKN2BDQI0fq8iAUtHckQDBtkTLQb7FtQO59G8NVht7onj3qbN/MiP1PgSlm5KVw
         V7aAZE7K/yABLjrTH9RNKavUAOt8gfXPhSJSMTkf0OZyblrsvsxda4iyOshJkuhqmN7h
         YRoQgUv+01C16MAHD7hKjYqLILBLk7Bmp8QEwDEyWyXZgRsE3XfW7YeTGfJuT3d2I4Jd
         /JcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3BHa1keyf1xGo8dvWfdTC9xT5rJbBYIj5M2HtnsQ4yY=;
        fh=ANJS8JfboSysVOj/a7dOgD6pYSGBivnuEzxRLMjiVIo=;
        b=YxVo32143MC6vBU5n8AGE3LhOSoMfIhbQ0RWXYOA1AbD67+r0polMBVWIqDrgDAlVQ
         jT4YrIPjqaRk+HSqVToGpukrXRCowQJhBUobMjr5F8MU6bUkL3JZpivyodu6curwT39R
         0gntIYtmZTjWhPkuj20o9lJVWuJQDG+zpZg3D8TYDxY1c2b8C+qUyLcSKspIg4wetP/o
         ADOCHf09T4nl/ozIV8JN2zUYcJWt+3crmr4YYZ4fDf6fPEgqePLzTC+4Yq70SQWhYZrj
         /vXzHAisRD1j0hE/YgEFBx5CtMTNEtO/HvSL2HgFRGIqMkJeUMaEAkLsK+MllmN02+27
         qxNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara.com; s=google; t=1772360054; x=1772964854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BHa1keyf1xGo8dvWfdTC9xT5rJbBYIj5M2HtnsQ4yY=;
        b=JtAqwDd8y9U8MpVsXivOWI3Q+j07jgYEHQw9ZpSXylQmFv2ijHQMPW5tYApbE5bREQ
         vKAUDUb2Wf2Y5TTeNO/O5tgT5uf8gRUL9LPniR7sSTqx88N6wcPDe9A/oSa8hR88PcM2
         iaF1AXhUATbPr2vdOEnhxyVOGPtOixReqdOWlZhA3/ypHcYb96VgR2acIDLoBpTI+oln
         RGWZcRvDExXyy1pXcJ3LRYxaRxPTw8o0hLmdMiFuYUyWQxFWSAL66gQ+lFQJXvkA6OTH
         0nTP/iYLWZbY1ncnhi1G/3WPgEHziS9X9zLNdFtT2pjDCVhTD8at1WJAYtkjUL/KKlnM
         3aNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772360054; x=1772964854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3BHa1keyf1xGo8dvWfdTC9xT5rJbBYIj5M2HtnsQ4yY=;
        b=bqx6LVfx3DkRc1wssH2SkxlOZaEveq1Ou+gPhJZwKZFi8KQ+wb81H+tWrXOzaLV8bd
         fvIwEPQi5N1r3fJbajNKTMbOrZMC8GWoh/SnN8q9P7wI7JjAKlUjLfThE8ZggXjVtcOE
         fXtSKhUeMNyTyrG92+bH/Z+yNwWCE2Cl/JrgGtqxvjnVI9O2VophJ5LsrqqkXz8adEIv
         T/bhhJmWrSD1MQRfyScr+oxwlMjgYvYZj5X8KgcFmws24qZzqJQlkiJ/3ZQfbGhjDVhv
         gvuHr8pjKWt47MresjFphgD3NY/FDssPvGk8TPqKdElpbBi3nx3HsMhd0gtSsKe0dZ31
         yMIA==
X-Gm-Message-State: AOJu0YzdHx09e6j/Wg+Np4a2G6Bjcz9Z2CMWs+h9llr4AbLT+KU38r0b
	qk6C2G7xiRHE8yrE8N0cR3eFs7w9jI3IAWb/bkySionewjbChKmdzwWDiT5HQATs5FtTWfC/DKt
	F5JZ4cEbJFhb/McKATksHpNLzbaLspexeihjii8YyDm7vX71eZLTEDYM=
X-Gm-Gg: ATEYQzxwzySOc1oT1RvROuISKU/2yhDzsuyL5+8ooD5U9VOGnG7WC6OU9h5xOm4UM16
	C6XPUcDC/IjlFTqLw5R50j5Zdyar3bgUFATfEc8dRRVDqQGpRlPvdEdgJv9qEUCRF4AsijicBqb
	wKoGzoIXrTiUvWJYqDP4vArJwjsQu4/IsnjJJhMZYD6e2JzujVJp5eozMzpzaSsoYDINbDP6JXn
	KdQp8apvfUZ93yBrWkA30Hd5lyQ1Ru8HcJiX9CnTe0UOMiqvheJScdxY7kfNSC+xaEGedkiTv/h
	6dAv9iEz
X-Received: by 2002:a17:90a:dfce:b0:336:9dcf:ed14 with SMTP id
 98e67ed59e1d1-35965ceb193mr8186360a91.23.1772360053721; Sun, 01 Mar 2026
 02:14:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226113419.28687-1-alex.lyakas@zadara.com>
 <20260226173746.GA2968189@zen.localdomain> <20260226182915.GA2992537@zen.localdomain>
In-Reply-To: <20260226182915.GA2992537@zen.localdomain>
From: Alex Lyakas <alex.lyakas@zadara.com>
Date: Sun, 1 Mar 2026 12:14:09 +0200
X-Gm-Features: AaiRm52BDsC1KVPDRidKF4rdEjaAXdvF-2qnqkrqDK-UUQbt89NQb84w--MDkMk
Message-ID: <CAOcd+r31fvMHskN93LNjbXrhpL0hF1kZd6rkVuhcEAgXHtcW-A@mail.gmail.com>
Subject: Re: [PATCH-RFC] btrfs: for unclustered allocation don't consider ffe_ctl->empty_cluster
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[zadara.com,none];
	R_DKIM_ALLOW(-0.20)[zadara.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-22126-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.lyakas@zadara.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[zadara.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,zadara.com:email,zadara.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bur.io:email]
X-Rspamd-Queue-Id: 19B201CF0E8
X-Rspamd-Action: no action

Hi Boris,

On Thu, Feb 26, 2026 at 8:28=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Thu, Feb 26, 2026 at 09:37:46AM -0800, Boris Burkov wrote:
> > On Thu, Feb 26, 2026 at 01:34:19PM +0200, Alex Lyakas wrote:
> > > I encountered an issue when performing unclustered allocation for met=
adata:
> > >
> > > free_space_ctl->free_space =3D 2MB
> > > ffe_ctl->num_bytes =3D 4096
> > > ffe_ctl->empty_cluster =3D 2MB
> > > ffe_ctl->empty_size =3D 0
> > >
> > > So early check for free_space_ctl->free_space skips the block group, =
even though
> > > it has enough space to do the allocation.
> > > I think when doing unclustered allocation we should not look at ffe_c=
tl->empty_cluster.
> >
> > I see what you are saying, and a the level of this situation and this
> > line of code, I think you are right.
> >
> > But as-is, this change does not contain enough reasoning about the
> > semantics of the allocation algorithm to realistically be anything
> > but exchanging one bug for two new ones.
> >

Thank you for your review and your comments below.

However, I am not sure what is it that you are actually requesting.
Do you expect me to describe the whole mechanics of find_free_extent()
and how its state is tracked through ffe_ctl?

> > What is empty_cluster modelling? Why is it included in this calculation=
?
> > Why should it not be included? Where else is empty_cluster used and
> > should it change under this new interpretation? Does any of this change
> > if there is actually a cluster active for clustered allocations?
I am not changing the meaning of any field of ffe_ctl, which tracks
the state of every call to find_free_extent().

I found an issue where "empty_cluster" is used erroneously in my opinion.

According to the code, "empty_cluster" describes the minimal amount of
free space in the block group, which we are considering to allocate a
cluster from. I am not changing the meaning of it.

My fix is suggesting that "empty_cluster" should not be used when
looking at free space in a block group during unclustered allocation.
Nothing else is changed. In the issue that I saw, this bug prevented
us from allocating a metadata block from a block group, when the block
group still had enough space to make a 4Kb allocation.

I tagged the patch as RFC, because I am unable to test it on the
latest mainline kernel, and I tested it on a stable LTS kernel 6.6.

Thanks,
Alex.





> >
> > etc. etc.
> >
> > Thanks,
> > Boris
> >
>
> I missed the RFC tag in the patch, so I would like to apologize for my
> negativity. In my experience with other bugs, the interplay between the
> clustered algorithm and the unclustered algorithm is under-specified so
> I think it is likely you have indeed found a bug.
>
> If you want to fix it, I would proceed along the lines I complained
> about in my first response and try to define the relationships between
> the variables in a consistent way that explains why we shouldn't count
> that variable here.
>
> If you do go through with sharpening the definition of empty_cluster,
> I would be happy to review that work and help get it in.
>



> Thanks,
> Boris
>
> > >
> > > I tested this on stable kernel 6.6.
> > >
> > > Signed-off-by: Alex Lyakas <alex.lyakas@zadara.com>
> > > ---
> > >  fs/btrfs/extent-tree.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > > index 03cf9f242c70..84b340a67882 100644
> > > --- a/fs/btrfs/extent-tree.c
> > > +++ b/fs/btrfs/extent-tree.c
> > > @@ -3885,7 +3885,7 @@ static int find_free_extent_unclustered(struct =
btrfs_block_group *bg,
> > >             free_space_ctl =3D bg->free_space_ctl;
> > >             spin_lock(&free_space_ctl->tree_lock);
> > >             if (free_space_ctl->free_space <
> > > -               ffe_ctl->num_bytes + ffe_ctl->empty_cluster +
> > > +               ffe_ctl->num_bytes +
> > >                 ffe_ctl->empty_size) {
> > >                     ffe_ctl->total_free_space =3D max_t(u64,
> > >                                     ffe_ctl->total_free_space,
> > > --
> > > 2.43.0
> > >

