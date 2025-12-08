Return-Path: <linux-btrfs+bounces-19584-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6490CCAE35F
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 22:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 500CC30A0314
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 21:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D902DF719;
	Mon,  8 Dec 2025 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQrGvnIw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFKGzG50"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E002E03EA
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765228620; cv=none; b=hYRT4YUTEzmLyye5bZh9IV+UNhJl30BCd6800JjRbhH5LBQxKrqtaLRwsyF3F+F3PaYRPdUVqrVL4OAlydQDyKn4UG3YGxfTjfkvF8KhmDJMlIxFD9f4H1TxQkWY16buR7JV6Y3XlC1gMAezVh3d3vKgkhcMRLSvN+lhclx8/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765228620; c=relaxed/simple;
	bh=5qGC2F3TSPuLPR1QccjvC8Wi8HoL2P4T2S8jzm5W6eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8TPrwu8W1eisdkqEMD6j8LdHGCqtk/tzt7yTnP6NRrKEuUMwi+f+xMZL0QEkczA4xnAEa1LNZJogsgjR0A24LGo2FUGcp2DJmk+Ke6UXEEdgdhTvjFVKHoZiqTedR9xGQ0GKlHt4egCXft73H3V7/Y9j2/eoil3QGG/xTGl32Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fQrGvnIw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFKGzG50; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765228617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3cjLyi8J1W1mVcyJajqeGZwTWZZ/xf0eZlzYpjjz4as=;
	b=fQrGvnIwKxNknra5UAMXMpl5TbKtWArd3DCnkwBLb2siR4Jsh9bL2KPDW5izeAvqqSNcKD
	d3TUqPvUYuWiTr5NYNcbvbM2ZsSli3k6Bn1TtIUbU///DsybCzZS377vXyII+Wu2wR11J5
	YMWcl3y2j6vHXYnUzRWbGzWSpHeb/jM=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-Fcfg57gDPxq1fGStuvOGag-1; Mon, 08 Dec 2025 16:16:56 -0500
X-MC-Unique: Fcfg57gDPxq1fGStuvOGag-1
X-Mimecast-MFC-AGG-ID: Fcfg57gDPxq1fGStuvOGag_1765228616
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7881cff41b7so66471757b3.2
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Dec 2025 13:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765228616; x=1765833416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cjLyi8J1W1mVcyJajqeGZwTWZZ/xf0eZlzYpjjz4as=;
        b=bFKGzG50etizIk2eqfk0P93oWnzxvNyz5+Ctt6eUn6Jn2W8FV1/uookzKgeYOESU17
         0TgkDNIJxRk2pQsOtjLMIfyNZpLoal4778BqMbaVdSA3rX0SpWItrn6rqxa8VBFm7Qu+
         ZyF0VWtOwd2xmQGEd6UlbErHD94UiR3OJajp75YTi4F196Umxy60PD3boIW6EF084pwc
         r2TYLIe8gqul+w5OrrLGZ2pA5Ec/MGdtfXcb10DnmLFTxR1Ma8IuRjXLSgXKGLZqqXTl
         SewaXhAv49THEyELA7MlTTrIUSMc+sNBUZusIddgD3bNuWkXwgxEPP1zIsGs2DpY6nyT
         QYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765228616; x=1765833416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3cjLyi8J1W1mVcyJajqeGZwTWZZ/xf0eZlzYpjjz4as=;
        b=Q1wQx3beuCV1EAgt93RRr3vv3lb07NEKYdnQH7zE+CHCv16M54UqQfylY9I1sYRipn
         3zjlNnvN10H21AqiERKHlYFSECtMKM7mwq7g0OG7/PAp4hZDq2Dr4HhBcPp/68s5acG5
         XKuS1x5sdRhXiLIhV8//6xuBwuwHY1q5enxi4RzaX99lRZPmFFClfrdveyeP9OnTT/KZ
         O/9wLDoHN1eJ0B4vs6oGmwbm5MyHtlULSqC7HVGgL9BkfWiQlGD4z33LROE/7cBUAeBj
         A0dW7yWtj7EeStzhmFzPcGGITrS/LEShgIYmMXttOX9vWa8GyRLhUh5KO0nAeGR+63Lb
         PyqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ0vxRIPbvYgmLIFfGBov5tiRVGQB0ROaFyd0Oi0c5t2o1CZ4NOGgRJIXkpEhb13ejdiUKd13015KP9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ODvImHB/EcA5fCHW5wY3c6R7bzsQwGdmm4YQHNN2IaDdLNfu
	IbD3QRpVgUfKhL6RN1EhgVgjBeQd8yQkK0v7GGupE5mYlbbZiSoNzP/3O5vmao+BwpK1qptwgr0
	QsmSyyvnvYuhvyD6oO+gKqp9yAx4Vyfygu9aT1VF34iqz4ekOFE9mrcD/gERR9CRqNcB9+UoQBA
	3vDpNnlbCvIVI25aXZvEf3nKZ563y2Rl+Q4BICflg=
X-Gm-Gg: ASbGncvib/AyUTI1wgf0M9VyAD/CwZUyYn6bwnjhci7VVAhDs0PX1BmVI3TXM3xBLhq
	6bBsIHz7TzHecwaKKwRJ8VpC7a7JPC5F8fB5TrWt862SdCAoPS73/35YaX1vuLBkF/y5hdVAp+d
	4/s3xa1bO4dc/87UReLJzLEMl7ZINuko3S6ewk+DTjxsEJOAIaXIA0bRYkOwkcV1OG
X-Received: by 2002:a05:690c:4a02:b0:786:61f3:e4e with SMTP id 00721157ae682-78c33c74655mr90034747b3.54.1765228616033;
        Mon, 08 Dec 2025 13:16:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiCY42NqIRZgl6uVDR8LkykQzXJsYzMaVLpZgyirQa+mlv/Jyf+1nBV5OG4dbWD1DDVxjeGc24WpTFqReJ20Q=
X-Received: by 2002:a05:690c:4a02:b0:786:61f3:e4e with SMTP id
 00721157ae682-78c33c74655mr90034377b3.54.1765228615599; Mon, 08 Dec 2025
 13:16:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208121020.1780402-1-agruenba@redhat.com> <20251208193724.GB4859@twin.jikos.cz>
In-Reply-To: <20251208193724.GB4859@twin.jikos.cz>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 8 Dec 2025 22:16:44 +0100
X-Gm-Features: AQt7F2pWqhuOxBDn48p5d1W8IkDa9mkk1UO6HtSX6_QdJl4e-fg9m6lrjlZDn5M
Message-ID: <CAHc6FU6vax1eNB-xrYLuZX5s-RLRhtctG7=3NO+h_GPj5o=W-Q@mail.gmail.com>
Subject: Re: [RFC 00/12] bio cleanups
To: dsterba@suse.cz
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-raid@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 8:43=E2=80=AFPM David Sterba <dsterba@suse.cz> wrote=
:
> On Mon, Dec 08, 2025 at 12:10:07PM +0000, Andreas Gruenbacher wrote:
> > With these changes, only a few direct assignments to bio->bi_status
> > remain, in BTRFS and in MD, and SOME OF THOSE MAY BE UNSAFE.  Could the
> > maintainers of those subsystems please have a look?
>
> The btrfs bits look good to me, we expect the same semantics, ie. not
> overwrite existing error with 0. If there are racing writes to the
> status like in btrfs_bio_end_io() we use cmpxchg() so we don't overwrite
> it.

Really? I'm not talking about the status field in struct btrfs_bio but
about the bi_status field in struct bio. The first mention of
bi_status I can find in the btrfs code is right at the beginning of
btrfs_bio_end_io():

  bbio->bio.bi_status =3D status;

If status is ever BLK_STS_OK (0) here and bbio->bio is a chained bio,
things are already not great.

I believe we should eliminate all direct assignments to bi_status and
use bio_set_status() instead. I'm not familiar enough with the btrfs
code to make that replacement for you, though.

A cursory look at struct btrfs_bio suggests that those objects cannot
be chained like plain old bios (bio_chain()). This means that
cmpxchg() may actually work for catching the first error that occurs.
For chained regular bios, cmpxchg() won't catch the first error, at
least not if the length of the chain is greater than two.

Thanks,
Andreas


