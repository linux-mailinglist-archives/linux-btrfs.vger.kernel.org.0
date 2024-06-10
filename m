Return-Path: <linux-btrfs+bounces-5615-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5167902979
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 21:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADB728488F
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 19:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39D914F123;
	Mon, 10 Jun 2024 19:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JV5Eh2bn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827651EB5B
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718048637; cv=none; b=ZAexjZHZFk/G+pwTuCYUPEzOPlvS91WP8++faVjvROT7j9VyRUTExzA/LQya/aXCbDFnKcUAR93dAARkosw9R4k7NeSEKaT+iUAeKEemVH95afPkGT/60Wc3z8YdP/IZD5z12QD2dqnqba1E4MGolN0hk23npbpp6cOvZvaKzfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718048637; c=relaxed/simple;
	bh=NwQJNx9srCsHR1oXqicEl2zxyVzc0tYR1H1+T/lrpNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5ntes1M0Qd1Yq4TjPdf0ThNh0Bamc2Tu3TRzCy9X2JPHbnDLXtpgBepJrHH24igunNepwS0nCnqf1H5pUJr8pMaNGj6USrsgYu0lOWf5SMRjH4Gt49AuFQhf1oyEP8uWxYUzuBmLsLTLQM9dDo4wu72yaZBWNSRhAZfE2QBv/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=JV5Eh2bn; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfb0ccbd401so2157603276.0
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 12:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1718048633; x=1718653433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qw5+VsdhRywpk2BTwqyAr7RLtJMnVZ6iQGrwmpugQIQ=;
        b=JV5Eh2bnd97K9r0XUO2eW9cs3WujONVK461rQKSYudpPfs0FYC/ZLoKCGEP85Sh4W+
         uThk4RT4DFeWFUfiP5IZjrpqzZe5x6AedZqsKmTaF7HfTibkNUaNrxK9gt0iLND3qq1K
         xAL1eZGkAM3wWJnHNruc2qYMMlL8QDp0Mw/335nigBILGzr6R1zNNg55ghR1WeoyXhud
         iqQTOWchxqnTF3cE+FgWqRXESEdW6950ITR7uZnje0UINKI/tOYdCIUbkJ6DHSOk9wvb
         3oHmNQ/33mHgQDGvu/3b+i3UX8o9z9Uh9CRoyV6p1k1yyxmsyQmyic7Ej5QfOlr+olI1
         vzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718048633; x=1718653433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qw5+VsdhRywpk2BTwqyAr7RLtJMnVZ6iQGrwmpugQIQ=;
        b=TZjOaipm6MStrbbjPaS3o9BMCxQTKm/rUZMBdOom3vofVZ3WwuO4hWcUnpaTGFU4sx
         caq1/prlKm214EvwAneDaTJ8J6+jVFvpgZqz46QB2cz5kFi620u6fvsWfbw5adCtmU00
         sYm0pIvT9039muBCeF2oyIzdCfTJRIl4HtMBL6jwAJo6oiwvaC+4lxqSIfy2xiBCwiNU
         Z+NAgQYRaxZMWNY8Se17LeRrFitaO58y5OOH0XAYo2JhH8RAFLiMjXFPk2pzR/jD6Mwx
         svdC7q0s1mMlayepFRgy5il19lJiOk9CWTrX19HmrQC0aSx/5YItwqbxlvvBpsUXiYnz
         t7Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVoSfz9cJNPVtUHou0cbitYXib2e+OybpMWZ2QiDxOw5MPK90o7xaPX9SFPeMj+t1NlGYnXc5LKC2Ckfa4T2F2Ekt2YAokWOGv07AM=
X-Gm-Message-State: AOJu0Yw/eAgRNaV59aYvxgl+PI9GEpN9RYPQA6hWtkVN/EVx6f8HfXMp
	jU9ncdy2pdu54wVKJoA/ZkuBWIwtHwP5BU3trPVyWi2njwhKJ82uZn25R65GlmA=
X-Google-Smtp-Source: AGHT+IFx1drU/OF9dPe5rnR3QcIKC6kbD7HIcAqjMWyaisYYHIilRo2oIwKwsrToihX3KGS+MCceDg==
X-Received: by 2002:a25:d347:0:b0:dfa:febf:5a72 with SMTP id 3f1490d57ef6-dfafebf5d04mr8707739276.38.1718048633375;
        Mon, 10 Jun 2024 12:43:53 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dfae53027b5sm1735103276.38.2024.06.10.12.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 12:43:53 -0700 (PDT)
Date: Mon, 10 Jun 2024 15:43:52 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 2/3] btrfs: replace stripe extents
Message-ID: <20240610194352.GB235772@perftesting>
References: <20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org>
 <20240610-b4-rst-updates-v1-2-179c1eec08f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610-b4-rst-updates-v1-2-179c1eec08f2@kernel.org>

On Mon, Jun 10, 2024 at 10:40:26AM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> If we can't insert a stripe extent in the RAID stripe tree, because
> the key that points to the specific position in the stripe tree is
> already existing, we have to remove the item and then replace it by a
> new item.
> 
> This can happen for example on device replace operations.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/ctree.c            |  1 +
>  fs/btrfs/raid-stripe-tree.c | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 1a49b9232990..ad934c5469c4 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -3844,6 +3844,7 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
>  	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
>  
>  	BUG_ON(key.type != BTRFS_EXTENT_DATA_KEY &&
> +	       key.type != BTRFS_RAID_STRIPE_KEY &&

This seems unrelated.  Thanks,

Josef

