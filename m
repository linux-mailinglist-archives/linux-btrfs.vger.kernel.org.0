Return-Path: <linux-btrfs+bounces-13136-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E274A91CDF
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 14:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D815A7F91
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 12:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2BF35979;
	Thu, 17 Apr 2025 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="egEIS0D5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D3B35972
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894183; cv=none; b=lLWVnpa0VP8BPLDAcK1fBs+aWH9twi3IejHMDzRVgs17cSoi6WunpLz2FQz1xVvN3p3UXT+ISXbd3hFbZ6Tl9EUc7p8VHrNxaRTMEH3k6GJ5ODu5FmQW5RXrKlxY9g56+XQ+fNs8VjlkIidadtvHnDHdJV9XUkQU1wxTvrP3nik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894183; c=relaxed/simple;
	bh=od1Uf562vP/VVSNHV47MJ5Ln0BSGFv2O6dq+9GPIml0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmXklJlkpKkzK1Yd92ibZB40SrYbozaZrAsdroKki2xX4SKiJC1+Z4Y4rAn98uzkAlTO9I2FP1w9hvR/YUk9IZywNIDbgHsE8yF5zCMwmVVHBjKVYKkTd+O/Y6TJ12FHa1qYWObZYRpXVribZEaucOYHk4PfVWSzgkq1h51Q5cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=egEIS0D5; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6fead317874so6292327b3.0
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744894181; x=1745498981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=knhpycVIOkzvSqnBPsSYrylUpx1icTp0MfrfAk8/5gk=;
        b=egEIS0D5vrtDOmyqBBiMAevh3j4ZOSDwjlwKaaM7npDE9dUIXVHa9FWrXewVXY/gA1
         FRQpkW7qtmk4hf34K5qx7fDfo6rK9P9B0v+3ToWCfaqejuzpvqK1hMw1XyByqWYz66n+
         Brl9YSp1QFjTrl1AkPJU70suDID9rwdaAF+u79tohgtQuvYjEmoedsqEqGKRtoD5TLvh
         yAduRUWSxYS6cpMdcZ/ARefzNJDwHP3uquPZFpDZRMoM/zOgouBnCtlZRn4PmtxfzmTH
         o8PMvYd7tfijXlh4mR2q6Al2yBMrsxJptrmceVjiXLpEXVlRi0liGDQeyWpehxoU2vLw
         D9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744894181; x=1745498981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knhpycVIOkzvSqnBPsSYrylUpx1icTp0MfrfAk8/5gk=;
        b=c8jixea4Kynh1Aq43IFFLeAaegfWqI1QnP05NZFFnZngLnPySAo8aGHkEpP+FKcTMX
         FbzbFw3BnHhYVonv5+UeZNh3CcAxxN0LnZ3pfGdMU7iU6SeyTKzwU2jEJ6qw0+P/gp3I
         KQWopscTGVxb6ymmCWW4ljnPDhuWNjqwXwpvi+Fo3RtCaMRE0zGB63kEXwG9Y2JuQ8jW
         D64VvgMndqutU5kyufrHucAa/QhPw1m2j0Gm6+PbVcLnhD1ogcSGft8dbihB456X2/WW
         CFQFo1H4xCsjxpgqPMGvF0126WMV0DRYgnAc6U+HPie3rhqT06bNjJU/DQLNOd+xCnwa
         3jBw==
X-Gm-Message-State: AOJu0Yw3JHZFcIWL7AHhianfqVvn4wxLfehz4z19anusPCP6GPtiveWk
	929oP5EQfrBc6bu2XGIVyaFVtcPjcM6/qKH6HRlA3vSFGTLgRpiZ2p7/Rd8uVAYQOjtGTcI+49C
	D
X-Gm-Gg: ASbGncubtmk9GMPBZKZQbn+U7IOECOk+tlkKoN7IVuAGPVxAQyM0jEluvNrupYRnPEk
	5OhFul/kx+Pxy5jpRiYrB/cnJ3mWam677KFLbR/pKvDG22yWGWD5dazM5YsJln1GhBz0jsPHNSG
	Nze9LroxwxmLNuQKTh2C2BFgd1v4+eQOqLmCqPAnArjaiM53ViMHJAtLNr+t9dPpRj3y1j87xIa
	mdSdsNTF/Jm5sX/dRf7qSWByDuyRdqxt325JH3L+zbDJjOe3KU+OyRQ6+wqCD9Rm+aFp7PrtjXl
	3H3Vvd4F7SjcEh9JvV4IeV+1NRXvUjWOLB3/VXzX4PFzEjq0wRKyiOJP9t+8xcvQjY0/IY4UToT
	EKg==
X-Google-Smtp-Source: AGHT+IHen8E2H+PNxqeTifl2QlUZmyBgRwce5bmhaCwOhqPpnAXDx6dapIVpokLQxw+OG4Bd+Q7S9Q==
X-Received: by 2002:a05:690c:6f0a:b0:6f7:ae50:6edd with SMTP id 00721157ae682-706b335ec55mr84944357b3.30.1744894181218;
        Thu, 17 Apr 2025 05:49:41 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e11ce34sm46776567b3.38.2025.04.17.05.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 05:49:40 -0700 (PDT)
Date: Thu, 17 Apr 2025 08:49:39 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 13/13] btrfs: reclaim from sub-space space_info
Message-ID: <20250417124939.GF3574107@perftesting>
References: <cover.1744813603.git.naohiro.aota@wdc.com>
 <5b85a0d4bed9703a9332abbeb7bfb6802959f369.1744813603.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b85a0d4bed9703a9332abbeb7bfb6802959f369.1744813603.git.naohiro.aota@wdc.com>

On Wed, Apr 16, 2025 at 11:28:18PM +0900, Naohiro Aota wrote:
> Modify btrfs_async_{data,metadata}_reclaim() to run the reclaim process on
> the sub-spaces as well.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/space-info.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 62dc69322b80..0f543e3cb2fe 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -1221,6 +1221,9 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
>  	fs_info = container_of(work, struct btrfs_fs_info, async_reclaim_work);
>  	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
>  	do_async_reclaim_metadata_space(space_info);
> +	for (int i = 0; i < BTRFS_SPACE_INFO_SUB_GROUP_MAX; i++)
> +		if (space_info->sub_group[i])
> +			do_async_reclaim_metadata_space(space_info->sub_group[i]);

Just a formating thing, for multi-line for loops, even with a single if, it's
cleaner to have the braces.  I find it easier to read and less error prone.
Thanks,

Josef

