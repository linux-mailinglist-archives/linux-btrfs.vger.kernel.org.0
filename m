Return-Path: <linux-btrfs+bounces-6345-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B440D92D922
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 21:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FB01C22884
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 19:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC7A1991A0;
	Wed, 10 Jul 2024 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="h3TojTBP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E49F1990C4
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jul 2024 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639678; cv=none; b=nIphgb4rAwjNt6UWR1+9NpzOhOhd9oyKqm/z179S3ErkO0IlR6Vd7/kSa76VyT3Y0YZ0Fn9GzgHNU3j4qTR9bjl6rS0M2h9tuSAWzz3w/XBrec2nGasL+b7/VOFVxK+VvZkKr1xcoTfmwoySImhw2Hs3TyWiYgQ2ghDlWDeuZbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639678; c=relaxed/simple;
	bh=+Bn5VJiwOXcrTIU3RXjTgj5F5dvmXpO5UqtqPG3jh3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWMtzvzdXjPmj2Fa5BEchXIPVQV7axdxTuuQTqsvpTvau20lzLCpJ4hbZmSZmHWUZ+1pBhdoeli4xDFhDVK41KXJmzB51P/TNcNh7TgU62Thpa8I60+yd6GDUhKbaFnJeiTCVsKGTZeZkveYyKWuyFIuMf6PfhaUhWeKvnJuJ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=h3TojTBP; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e03a6196223so72260276.3
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Jul 2024 12:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720639675; x=1721244475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s/RRDQrRIuExQCMH9TkK95lYLLgoOXxN9TtWCkuYvI4=;
        b=h3TojTBPUadJkZy9nZVTp0zLb61IZ0vq+eGy1p0MF9qkKRqpk3NhPCb7o/YHKluObo
         fnNK5R7o4a5YpKiVeswiBz6S/IIoK+mUGfhAcYQ/sXzhB10pQluZ2YbTv2gWMD3pLoYM
         GAJK0UzpKigPFT5Kgm0MNju7hLNW695/Ip2Zg84CkZThWp9nvhIoVa8Y5Sk6QMSbFSA2
         9MjgkdNf0AybAD3xsiUQa793MWKAwz3JW1abA66Oq4UbVuD1w2GiklDgPa5eC9JQboho
         IiiFd0RW9oo0vP1o3dVgBam9xgF8wb9oVaucR3GF/RxrfEx+Iu+Bdd3VQ+djjQuH7r2V
         khBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720639675; x=1721244475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/RRDQrRIuExQCMH9TkK95lYLLgoOXxN9TtWCkuYvI4=;
        b=EhHVGPXLXb27gjN4cTne7mL96pPkIRPHtD38DNY/dG30QQqZZfNy6tHUZsaIIpxvL2
         Ob96A8etJl2NjJcOcWpfw5G3dqfDcFYVBbilFsja+8gys4UIHPtYLbUIY/Ga/z6LtGxE
         uxDN+VCmoZG8P8vrSqd3MFCRRnbNV61F5k0QHqAqk2iRIoi2UUndgr5c9QqP2kqrJvlX
         75v9+1i+olaQmfnwNifVFTzXzPTGNRyWmbjngaWCKP8XGX7h0OttJ4zE2PPBZDM5jpYv
         VtenobhVBPZZQ+IB+0il57OM0lq3u2RhnLA1HkEV4v+a/0VgxI5rgBsvI2fvP4dWd1AP
         44Uw==
X-Gm-Message-State: AOJu0YzIkmOVs5Nyr/BoPvXtxH3hi/y906OGTdcR8vrRj7VZuDKIUNzz
	GM1ZQsCPaU+QT+OewWC9OJ5N1zRTbS+mnbqfdl0rAI1R/z4iGCl/8JQ+5OGVSfg=
X-Google-Smtp-Source: AGHT+IH8iliEuP5DFzBNwJmBYE73wbsy2NB06YsJDYUrqxhTpN7Ogm9E+tSk1hnJbHtdFba9IhdvFw==
X-Received: by 2002:a25:8011:0:b0:e02:bf87:7cce with SMTP id 3f1490d57ef6-e041b177ddamr6904839276.64.1720639675351;
        Wed, 10 Jul 2024 12:27:55 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba8ad29sm19733216d6.116.2024.07.10.12.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 12:27:54 -0700 (PDT)
Date: Wed, 10 Jul 2024 15:27:53 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: fix zone_unusable accounting on making BG
 RW again
Message-ID: <20240710192753.GB1167307@perftesting>
References: <1626ef0d42713eaa6e050a6a64be8a811446ad5a.1720624977.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626ef0d42713eaa6e050a6a64be8a811446ad5a.1720624977.git.naohiro.aota@wdc.com>

On Thu, Jul 11, 2024 at 12:23:54AM +0900, Naohiro Aota wrote:
> When btrfs makes a block group read-only, it adds all free regions in the
> BG to space_info->bytes_readonly. That free space excludes reserved and
> pinned regions. OTOH, when btrfs makes the BG read-write again, it moves
> all the unused regions into the block group's zone_unusable. That unused
> region includes reserved and pinned regions. As a result, it counts too
> much zone_unusable bytes.
> 
> Fortunately (or unfortunately), having erroneous zone_unusable does not
> affect the calculation of space_info->bytes_readonly, because free
> space (num_bytes in btrfs_dec_block_group_ro) calculation is done based on
> the erroneous zone_unusable and it reduces the num_bytes just to cancel the
> error.
> 
> This behavior can be easily discovered by adding a WARN_ON to check e.g,
> "bg->pinned > 0" in btrfs_dec_block_group_ro(), and running fstests test
> case like btrfs/282.
> 
> Fix it by properly considering pinned and reserved in
> btrfs_dec_block_group_ro(). Also, add a WARN_ON and introduce
> btrfs_space_info_update_bytes_zone_unusable() to catch a similar mistake.
> 
> Fixes: 169e0da91a21 ("btrfs: zoned: track unusable bytes for zones")
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

