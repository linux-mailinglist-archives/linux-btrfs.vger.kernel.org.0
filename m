Return-Path: <linux-btrfs+bounces-22176-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCWEDGHmpmnjZAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22176-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 14:47:13 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B7F1F0A2E
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 14:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ADEB0302944B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 13:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA4E3382DA;
	Tue,  3 Mar 2026 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SPVwXEK9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1643C308F15
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545337; cv=pass; b=jB76ekw0u/b7kiwo7Z/YONzpzpMu5yQW9rl7Z22SYnaM73eXuwGlI6/jmMRARrCHKn7T0J3PoZim3brzVwVN8iqqkYmjKhs5fOloTRqRVd/6RmoEPTuvyaWI5AHeXNMNaRUfufNHqxgqZhxS4wSPE3brBbBr1xJGJ43aPeQ4D/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545337; c=relaxed/simple;
	bh=wgYWEoqsML2P5iIsD4BqeYCULYtO2ps0y8epzXQyMd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/uKux1iKy5nHQlnHAc3FupGrWjPJ/sHaKd+jVpjoU7ImolRSW0P9B4h7rl4fEBh4VMBXclB4Vpi9hfERre15yKjIWWiLM24+5tpPvNykHDok0zn9MFhSl0eGZWvXMJ5P963XKW/zEGC6zFyLuIsxYtNzN85tXW5sRO3sRVK1DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SPVwXEK9; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43992e3f9b8so5724913f8f.3
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Mar 2026 05:42:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772545334; cv=none;
        d=google.com; s=arc-20240605;
        b=ik1G7IKFBDBrwYU9bcv27Xs5q8b1VZVqUohfmZyRQwYI71Anou0KM1EMcT2NfUfg/V
         GidRadeHWhUriXuhn4e2Ssq+K9xxAgeTfCWAwcRaAhr5tIPoCIGjULbilR5o26vVbaGW
         YpBrOzN+jvku07VV3ycq56N7ahTtlcGwyQcRuB35NMwIIBvYnlTlna2ZrTHJ2cVlpyDM
         CzgwzoHG8ePe9dBIzaOAuJ5dOYIOndUcGT0RqwsoaOrtS1mF44q4pa7u0XtQiwUOU7+f
         H6RBRRVAxAd+ISqraaPZuBT+6mrQ64H9AwqGRbCX5kU+dVIh6IC6OOxJ2PVmo0U+3gm0
         jhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YJaqiIjGfzl7r+r7hHRF7Oqm8KAWNGUWa5R8il4nFL8=;
        fh=i0CU+zpsr2L0WBbM2fRcAyk2I5xR1DN0v4HQTXFR+Lw=;
        b=a1zLKKgaF2fQ/UzgM/iDMP0q0P2q+3A6Bxwz3PagESvtFbv7DxznqmPfE6s7paibH+
         mTVxBQnIh1BMGrNmQbGhjvhMcdNYvGKOJz4pkPOCC8XJn/HgV7YtqjqwdjWFAJiW0C3n
         UtrbVIND03V+B7eEr/X7a/yPS+ROG0IjX2XG4lEojOPJu0Bl517kmX5UXsDwf15l23AR
         OsQAcWMKbG+Z1wsIWyduYH5Xt4CZhpNx9TLInv6AK3g56ssG6ZohfKA8E2Wr9l9cEeSk
         ojhmfDZsGjyPvXsr9Az1aVl4Ahq1LxYXolGrQu1sQYOGfpMG7kczmib3PRGbwOzBRUwX
         0AwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772545334; x=1773150134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YJaqiIjGfzl7r+r7hHRF7Oqm8KAWNGUWa5R8il4nFL8=;
        b=SPVwXEK9iCmnZ4Cp7rDazWQT0c9sKx/n3NcAo1znEacaYh2DHSSw4kfg1+7jT5CGGM
         3uY3vregmeSIUHb+MDcuBw/c4JtuOJjYqM8c3VnyQuwhoU4XdgZDCltlROTMArbcM/Mi
         UrpJjkaArEvOqd1GKYid6DBE1M0sfvNO8ShGWryABlcw8Yl8eckTFTS65bQyjLllNPoy
         uWZznh5m8mOJc5TteptL0JKYfq3Hkk7npZa4njIl418sWhIlFLLUQ48PGM+iZLd3Gk80
         T+sQFAa7wGDwqq/BgdN3hUqTHHEbby9ZiPRrojbMOoSf1CgR0JWlQcAghijOaj6p/Tak
         gG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772545334; x=1773150134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJaqiIjGfzl7r+r7hHRF7Oqm8KAWNGUWa5R8il4nFL8=;
        b=ZrIOpbnHhXPB+cPm0dgL4LMS9KbjKLTYL/rYoud7sbAIvoCGeM0kqswysMrAoYLIB6
         JvrMrsiF2R+tGZYjP9izsVYWOczI5dlW7NiEOf1CzZJUgjnQ9A7M7CHZQC83/+sPwQZk
         tkkbVfdm6ujHongShkaOYYc/VpuhDebeV+TO9sNI9eLU9ni5zsRW9JNiW5FAwbwzlQ4x
         I2TWBaLbPdK2OYq+RLZpKJsfea77K3OL4QXBu8wSI5qV2oXpYHStXW2He3OchRYmMp2K
         ajTyC/srxR74/b0Guz3Klv+uBkqNecyHdpqlXYuDaAyQfl4Oc7BTKQxRxwSAqCrUmKb1
         j+6w==
X-Forwarded-Encrypted: i=1; AJvYcCVQa5kURB3r9G/zPFhYraBc2NbOruC26YcVFYPhfjKDQzC/DZD26PFlgF9EqoGuQ6VD5KNgDaEGPH7KnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzI0FLOUTBf7tcLwpxgevkWdYawSiDKhSkQ4dC90GDxf9hRkkG6
	sqejX9dedb6KmZkAyTfYYjqmei5UfW70QqKj75lpw5aejLptgdxA6NV4VoIeRL72wVBhEiKJw9N
	M4az8ahZvhDNugK68YnFO0SqiHanbRrEEWasMPtjnFw==
X-Gm-Gg: ATEYQzzwa87I6LHqbNFPHCyrMqwpYUDKyDNx0Rero1AntHtA5//NJCJXlq2O50ExbGb
	k+0w/4XkxbEAdAry1ZC0gY7EpnqtldrTfUVyUKn0z47AFSNscknepIw2hfcYTrXu7TZf7w4z8SJ
	9cPjr4oi9QL7cQ3eP5XpspmP9LirSdxIeNzmgG5wF3bxwScsgMhZAvwiB61p5MHf4hkI0uREI3D
	NvadinLMSiiCMNo7QYDvVq6UsKd20U/l8TlimehHD5aLMQ++/cJGk8v9iWhC8yBVn/b5BS6VlXa
	zT8FFktJ78e31aSr/4uezduNA8SFgRdEtgmi5WOlsJwpFya7avCQyeLqa6MtadsDtQyfIGm+ic1
	C8qWf
X-Received: by 2002:a05:6000:103:b0:439:ba75:7dab with SMTP id
 ffacd0b85a97d-439ba75808amr8599438f8f.9.1772545334391; Tue, 03 Mar 2026
 05:42:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260206182336.1397715-29-neelx@suse.com>
 <20260208151350.3147841-1-clm@meta.com>
In-Reply-To: <20260208151350.3147841-1-clm@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 3 Mar 2026 14:42:02 +0100
X-Gm-Features: AaiRm53vOiLHz-pIgqzqpiZzKddGUEkGBHvzwx_BwVSRp9P3mvJA2QJFOq5bVis
Message-ID: <CAPjX3FfS-0Jx8NmMX1deQfUbhMv4sNWWLE4n_HbsD5PWrLte+A@mail.gmail.com>
Subject: Re: [PATCH v6 28/43] btrfs: populate ordered_extent with the orig offset
To: Chris Mason <clm@meta.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 72B7F1F0A2E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22176-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,toxicpanda.com:email,meta.com:email]
X-Rspamd-Action: no action

On Sun, 8 Feb 2026 at 16:14, Chris Mason <clm@meta.com> wrote:
> Daniel Vacek <neelx@suse.com> wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > For extent encryption we have to use a logical block nr as input for the
> > IV.  For btrfs we're using the offset into the extent we're operating
> > on.  For most ordered extents this is the same as the file_offset,
> > however for prealloc and NOCOW we have to use the original offset.
> >
> > Add this as an argument and plumb it through everywhere, this will be
> > used when setting up the bio.
> >
>
> Hi everyone,
>
> I'm running the btrfs for-next branch, along with the encryption patch set
> through my AI review prompts:
>
> https://github.com/masoncl/review-prompts
>
> I'm working on some btrfs specific instructions, but hopefully these reviews
> are already useful.  I've kept the headers to make it easier to double check
> that I'm actually replying to the right email, but please let me know if any
> parts of this are incorrect:
>
> commit 0e7f6a617a2642bbdf97bcd639fb887fa88189ad
> Author: Josef Bacik <josef@toxicpanda.com>
>
> btrfs: populate ordered_extent with the orig offset
>
> This commit adds orig_offset tracking to btrfs_ordered_extent and
> btrfs_file_extent structures for extent encryption support, where the
> offset into the extent is needed for IV generation.
>
> > diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> > index d3789109ca851..2d89ac05b1b38 100644
> > --- a/fs/btrfs/direct-io.c
> > +++ b/fs/btrfs/direct-io.c
> > @@ -155,6 +155,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
> >               file_extent->fscrypt_info = em->fscrypt_info;
> >       }
> >
> > +     file_extent->orig_offset = start - file_extent->offset;
> >       ordered = btrfs_alloc_ordered_extent(inode, start, file_extent,
> >                                            (1U << type) |
> >                                            (1U << BTRFS_ORDERED_DIRECT));
>
> [ ... ]
>
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index fbb968d4010b7..8078049f690e1 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
>
> [ ... ]
>
> > @@ -2296,6 +2298,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
> >                       cow_start = (u64)-1;
> >               }
> >
> > +             nocow_args.file_extent.orig_offset =
> > +                     found_key.offset - nocow_args.file_extent.offset;
> >               ret = nocow_one_range(inode, locked_folio, &cached_state,
> >                                     &nocow_args, cur_offset,
> >                                     extent_type == BTRFS_FILE_EXTENT_PREALLOC);
>
> Should this calculation use cur_offset instead of found_key.offset?

IIUC, no. We need to keep the offset from the original extent
precisely to keep the data consistent. That's the whole point.

--nX


> Looking at the DIO path in btrfs_create_dio_extent() (direct-io.c line
> 158), the orig_offset is calculated as:
>
>     file_extent->orig_offset = start - file_extent->offset;
>
> where 'start' is the current write position. In run_delalloc_nocow(),
> found_key.offset represents where the extent item is stored, while
> cur_offset represents the current write position (analogous to 'start'
> in the DIO path).
>
> When writing to a position within an existing extent (not at its start),
> using found_key.offset - file_extent.offset could produce incorrect
> values. For consistency with the DIO path, would the formula be:
>
>     nocow_args.file_extent.orig_offset =
>         cur_offset - nocow_args.file_extent.offset;
>
> This would ensure that NOCOW writes calculate orig_offset the same way
> as DIO writes, which matters for encryption IV generation where an
> incorrect offset would cause data corruption on reads.
>

