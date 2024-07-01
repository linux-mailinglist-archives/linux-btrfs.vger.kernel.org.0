Return-Path: <linux-btrfs+bounces-6113-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA15591E9AC
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 22:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F881C21632
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 20:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0F9171660;
	Mon,  1 Jul 2024 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="HKxKuu6I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCF916F850
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866096; cv=none; b=LH72wMPh0eoUxeP5fkKLdL35GHtzv/6LlnbrbkzWZOkCBpj1mJ5ziYNHwE7HILLAsPEN4sRDYka55D0AmnUzUvvN2RacF9uMi3vx+Vd0vB2BwrUZVKVxv10Z/TSIURsnmGfSMAwo50oea8maomBcmCS75hR6hNG8PLPaGexOMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866096; c=relaxed/simple;
	bh=pEuBrcitgvmBdTU+pzOHCoQC3u1MqREBXDnbJ7aAnT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsYMtr7uRkY95Inb/P6dUrsHNi6/G6Cts+FLQw5EIzEwd6uXENljPfo71gUKIaCSLV5RT357tTEj2mUozOiC2QmHxkuHDsr0clGDN4vcPjMwfL5PF2Z7p4jW3CUgI/Oxd9ICuBQH2F9354uaBeuNSh2wSFrdCeBFU6FCLdbCNpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=HKxKuu6I; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-80f4f7e6856so771790241.2
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Jul 2024 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719866093; x=1720470893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ozJECDpXSrQuKE8DEY40zEUib6xwQXmEwyD/DI8MRRk=;
        b=HKxKuu6IbnjlRm9dj5gxAoW/+NsNISi2cJxVfPetq1MPiJemQac1kj6+3zRU4bbQJx
         Kn4awHlUIKHgFv6w3V6o4rHJHKMt8QMvPCt7kf9CpIpPhjYhanhIQGrt/iCztRcMVQ9W
         v+X95uHkQoyiivmYcItvhdgJrNkfQJqY8tXmMwvWS9PDgLqTfbu1T1MnY47NQHyYZse6
         h6Eh7PK8ylLeCiGTJpOlwVzTPRkE6Wxc7bO+3IuzZGAGvHkeDqlFcD0undfOYKMVFyil
         KEiDC6r1M8xOaEcpwMoIjpKUOpRe03JyHdkeXu1I3ShONMsWNyP2bur0VwdX7Tcht0yN
         pXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719866093; x=1720470893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozJECDpXSrQuKE8DEY40zEUib6xwQXmEwyD/DI8MRRk=;
        b=XvKl7wlQjPQHcEXSglK/vHiL5GDxWKPrfaux2JPm545rmOFbt4HidNEYoxvHRKZrWo
         MTV+t0x7focMFe70uSTM0pHxKSSPsXTHXZxSESYIwoFql/RfKuouarPwnYnM6T8uOfin
         01kFRfk0ij4Pnr3e4K5k+7zXtm+/jMErhNGW9tjQRnzUG76lQ8Jr3HN9uphZPxjF0m5c
         3Y4WyjsArq8rag271oevuV/ccgKO/aF9bv0K8C39yJiZZihxbhKKkBE2QZaMZ87kLRmi
         kWModIaqlrUMd3NJZcIbawHpMYDCz54nb8LvynThHxX7hCUdTUFa1nA2YEJnjGZqPKTV
         fLpw==
X-Forwarded-Encrypted: i=1; AJvYcCVHi3CFDvFpz+U5ljSUt3ZOlLihW7OHlgk0wqIqR7ZWVHvTrCoXeMPsA1Nvyx8/q8D4ASytsAv7Z2EwSeRE6vqpJUrHkIxLeDcZgwg=
X-Gm-Message-State: AOJu0YzYESBY9rp9lOjkM8OtgM7nTwi/Qnx02v6PT77dITNZOIrsAyfV
	dyJk7dCnPjqPnjQF7jgn2xP6u2bQLEFwBkw/vEFXFz06rrj9LH0TfmDK6q6WrE4=
X-Google-Smtp-Source: AGHT+IHw3wIO6EWVDBs9VEb4k7K62FCyOBS2Dxfr1BuMYfu7sBepoSSnE3yVMSEuytYhGV4QJE8Gyg==
X-Received: by 2002:a05:6122:4fa6:b0:4ec:f8f0:7175 with SMTP id 71dfb90a1353d-4f2a5704fd3mr8693225e0c.11.1719866092656;
        Mon, 01 Jul 2024 13:34:52 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69308d8esm383412185a.124.2024.07.01.13.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:34:52 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:34:51 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] btrfs: replace stripe extents
Message-ID: <20240701203451.GB510298@perftesting>
References: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
 <20240701-b4-rst-updates-v3-1-e0437e1e04a6@kernel.org>
 <20240701135755.GE504479@perftesting>
 <0819d7c2-bb91-4dea-ac20-09191c0b2240@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0819d7c2-bb91-4dea-ac20-09191c0b2240@wdc.com>

On Mon, Jul 01, 2024 at 03:08:22PM +0000, Johannes Thumshirn wrote:
> On 01.07.24 15:58, Josef Bacik wrote:
> > On Mon, Jul 01, 2024 at 12:25:15PM +0200, Johannes Thumshirn wrote:
> >> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >>
> >> If we can't insert a stripe extent in the RAID stripe tree, because
> >> the key that points to the specific position in the stripe tree is
> >> already existing, we have to remove the item and then replace it by a
> >> new item.
> >>
> >> This can happen for example on device replace operations.
> >>
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >> ---
> >>   fs/btrfs/raid-stripe-tree.c | 34 ++++++++++++++++++++++++++++++++++
> >>   1 file changed, 34 insertions(+)
> >>
> >> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> >> index e6f7a234b8f6..3020820dd6e2 100644
> >> --- a/fs/btrfs/raid-stripe-tree.c
> >> +++ b/fs/btrfs/raid-stripe-tree.c
> >> @@ -73,6 +73,37 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
> >>   	return ret;
> >>   }
> >>   
> >> +static int replace_raid_extent_item(struct btrfs_trans_handle *trans,
> >> +				    struct btrfs_key *key,
> >> +				    struct btrfs_stripe_extent *stripe_extent,
> >> +				    const size_t item_size)
> >> +{
> >> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> >> +	struct btrfs_root *stripe_root = fs_info->stripe_root;
> >> +	struct btrfs_path *path;
> >> +	int ret;
> >> +
> >> +	path = btrfs_alloc_path();
> >> +	if (!path)
> >> +		return -ENOMEM;
> >> +
> >> +	ret = btrfs_search_slot(trans, stripe_root, key, path, -1, 1);
> >> +	if (ret)
> >> +		goto err;
> > 
> > This will leak 1 and we'll get an awkward btrfs_abort_transaction() call.  This
> > should be
> > 
> > if (ret) {
> > 	ret = (ret == 1) ? -ENOENT : ret;
> > 	goto err;
> > }
> > 
> > or whatever.  Thanks,
> 
> I wonder why I've never seen this in my testing. Could it be, that due 
> to the fact that btrfs_insert_item() returns -EEXIST on the same 
> key.objectid, we're more or less guaranteed it'll exist.

Yeah it's fine in the way it is currently, but if anything changes in the future
we're going to figure it out and be super sad we didn't just handle it right in
the first place.  Thanks,

Josef

