Return-Path: <linux-btrfs+bounces-7369-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DB095A3AA
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 19:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37624B223B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 17:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC2B1B252D;
	Wed, 21 Aug 2024 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="oKf/3zOm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955CA1494D1
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260549; cv=none; b=IVnbeyIgwtBO0Vqp1UMUtAztsk5jtbbFYMJ+K1QbKUYlFanIAG05e1zSCM26JvBk8WwWv+06kVXKmj/5E3skdwl/An3mmJ6H9td2h9BkUy/9qmiBBa8fBxTTB8mZiEEp/LxjQwUVaAsGGvW977KPc6SXY/7r2JMKbwBsHn4uaYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260549; c=relaxed/simple;
	bh=CXUZMTfR+ctY64S4wLWT95QPyMLbTeVBl9F9I/RbGzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXEJYVu6gcmwJIqRA4ECFQPFplX86xJ08SkLJL98BWkL3hgfWwdhikChpt4qmnqySs29rpoW1FevzqFHVl3Pavn61gzaEBi7e5FAasQe729P5gVM9Yc6S1Rl4j405xHQCWTEvZRYCXWmfJoUUKsvYycZp5qIqsj0mp7UxH5z+as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=oKf/3zOm; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e03caab48a2so925791276.1
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724260546; x=1724865346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nnz/9bRfV4eCE7Gj4szszeqMiVZN0a+HcNTY9eR9KK4=;
        b=oKf/3zOmfbmjL28EvUdVtlIBWWa0T7hBI2wPbqeoCXt8d7SW+azEVy+zwq8r67P5D8
         NP+ycpstC1ugfFMDVZFKxfGbDPsGz24jgMBI1E5Ik7PHcRPRVL74L9NWIQktPAniNIF/
         1BpJ9P9tSYaMaZANul2tHW9Vy3o22NDJPW9f6wx+g/O05WcLE/c2YWFHiHD4i9sJzJaf
         0x4tIGXx90lQlRVnnC91UxWeLUgFPYN8FjQBa4GGHThyhn+V6HlEqUtTgNoBhOtTgHhD
         7+VzESlA1jMt25bmYdWULsVsam7X0pnk0qiya/WyTar02/n9cTvzt7Ll7SOPAExT24RZ
         i0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724260546; x=1724865346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnz/9bRfV4eCE7Gj4szszeqMiVZN0a+HcNTY9eR9KK4=;
        b=rICeiMj+7rmet6DZqjiTRFt/pRQpmvBCgDGCyk5cw4U2SrR0TZvuyrl3/o5dOIhxRS
         FrvaiKAW16AQLdYhOk2wZCWeoX8ReBpJvzD6H7BYxbEwLXeD6nzotaXeLHQBRx8ppBgV
         ZICQ13XsDOVYig0lMZtl/BttvgzC1FsFDQdONMoAaqjAvhvemJSK1jKzzUhvGfC83zqp
         idPu/XSQ1dTrdxDpfdEfTCQTEaZBxGp+9GAeTxiHXHiPiDV2GOIwv7BXvdyZ9TR1Y7Hq
         nBpnk7mGg/vx8n8JAseX25oksZziWAjBlNU0UP610dSULqLhl3+RzA3uueMqhq0debqS
         QpRg==
X-Forwarded-Encrypted: i=1; AJvYcCUvoxWBehH2pgDzGBg7knKkZfbZXKGLPnbrLxp82gb4MQG6nZeBMOkub1Eu7vWWfdxAOmWnYXtIwJRhQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVCoz7bDiWf3rVsQu0HnA7gA3AgDmckShKjVPZ7fphEaJaB71z
	sprl+oDiWks/cBmMKwtiDU9D7ea9DRwqqgaHwxTAD8W/obQe+7TdGjdJ1Cg3cASp4HMtGjOTAm/
	F
X-Google-Smtp-Source: AGHT+IH/k3XRCeN1yFBxEuJh7fGjWPwPN5ESb1A5WZiWw5eWEfWhdrnOx6PA8oM/9J1Kjpjv36J3lw==
X-Received: by 2002:a05:6902:a90:b0:e11:446b:d43b with SMTP id 3f1490d57ef6-e17762890a5mr359370276.16.1724260546569;
        Wed, 21 Aug 2024 10:15:46 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1172006e05sm2943867276.43.2024.08.21.10.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 10:15:46 -0700 (PDT)
Date: Wed, 21 Aug 2024 13:15:45 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: stripe-tree: correctly truncate stripe extents on
 delete
Message-ID: <20240821171545.GA1998418@perftesting>
References: <20240820143434.25332-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820143434.25332-1-jth@kernel.org>

On Tue, Aug 20, 2024 at 04:34:33PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> In our CI system, we're seeing the following ASSERT()ion to trigger when
> running RAID stripe-tree tests on non-zoned devices:
> 
>  assertion failed: found_start >= start && found_end <= end, in fs/btrfs/raid-stripe-tree.c:64
> 
> This ASSERT()ion triggers, because for the initial design of RAID stripe-tree,
> I had the "one ordered-extent equals one bio" rule of zoned btrfs in mind.
> 
> But for a RAID stripe-tree based system, that is not hosted on a zoned
> storage device, but on a regular device this rule doesn't apply.
> 
> So in case the range we want to delete starts in the middle of the
> previous item, grab the item and "truncate" it's length. That is, subtract
> the deleted portion from the key's offset.
> 
> In case the range to delete ends in the middle of an item, we have to
> adjust both the item's key as well as the stripe extents.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c | 50 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 4c859b550f6c..c8365d14271f 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -61,7 +61,55 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
>  		trace_btrfs_raid_extent_delete(fs_info, start, end,
>  					       found_start, found_end);
>  
> -		ASSERT(found_start >= start && found_end <= end);
> +		if (found_start < start) {
> +			struct btrfs_key prev;
> +			u64 diff = start - found_start;
> +
> +			ret = btrfs_previous_item(stripe_root, path, start,
> +						  BTRFS_RAID_STRIPE_KEY);

This is only safe if we're not path->slots[0] == 0, otherwise we'll do
btrfs_prev_leaf(), which doesn't modify anything, adn then we'll be in trouble.
If this is safe then a comment indicating why we expect this to only back up one
slot, and maybe an

ASSERT(path->slots[0] > 0);

before the btrfs_previous_item to make sure we don't screw this up later.
Thanks,

Josef

