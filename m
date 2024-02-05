Return-Path: <linux-btrfs+bounces-2126-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F2584A8E3
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 23:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBBD4B235CC
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 22:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BD45F545;
	Mon,  5 Feb 2024 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="rIPn0sI7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A765DF34
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170336; cv=none; b=iGHaD2eyF4diEULc3oxlot9KHLpPxbz7Je/PETdnpOk5mdkDxj78bEqi4eO7m0MQwR4/caYllYytRsOmkfCLUqFro0vXLUdWpYlqQKYX32bB74OFzP4+8jdIl1ycI+bBNKcovo60ewlEwG+1BrMvx+/jRwW70Dwybz9JHWqkKmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170336; c=relaxed/simple;
	bh=fXqCZbcBxU+Dl9zb7VwlQjoseiraK8MLA3UaXDw+Sok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktSMk/Iaw7wdF8WO4CJ8iB/VofcRoLcwO+vt/2rq09EF3qkzkSu74GrQq2aJzfTHgMxwxYu3JTHfZfiWdQnVbJHN/pH8qZRUDn3XcuOCeNS9DnnWogdFmKBQzl1He1r0mET/my94FGBwIsUUzepExI6+ew2JLkdjysz5KM+NDPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=rIPn0sI7; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso4873163a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Feb 2024 13:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707170332; x=1707775132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RCce4pV3xPOpa0Za3QiaoPauzc6TdqvdOGmTYYs8YWk=;
        b=rIPn0sI79mq7NbQHmPpQHNbDU/oLqETMyhOmKVtTBSYBQVoANMs26Zk8TshTBczon0
         l+PlJJSDx13Qr5uwkSFvaUlYnLj9zTKg26ePCdBecAUqAv8Dk+uAg8vyQMEGZ6oNRZmY
         RaVAqacTClXWft6fohsAstnbk158fvRfixCWqs/HpYEfBbfQk5LxzCbANso7QvtaWNg2
         i/18jdpKq/GhuLDpaxBMjnOQl+Dyg0VbpxyA7yRvX6PnORKdrs0YnszefY2l/DeVZCCB
         ykiHjmAPFJCnpu4+yj7M1aCSAe0DFSstdchSrb4HGyDKDovEinWLpy1CQzJW6bZvhSm3
         RVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707170332; x=1707775132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCce4pV3xPOpa0Za3QiaoPauzc6TdqvdOGmTYYs8YWk=;
        b=jSwaKdx5byU+PT7erAtTqYAUgAOQozjrbfy4Lud5/YPfSy2JXqo0yySxzA4xwZKKra
         +Awc9dt3YKsVgmSsz7hpv13PXr/jMeUyFuLLRND86jpGX7+NWQm5uZjjhojf7mdL+QFy
         dcBbQ0jCT/2zJcBZPBAxEodKFUPMRdeEapAi/ngyB6ukD5cPKRLJq+AQLwH2Ys+BLO90
         N77Z1ApSicir5PUPgFlQfLfzQ2Tw6pkj8XHSgSm8J5ZG/uvLegsFm0VQOWoeMb8wwtim
         oMK/Qd07NIvWIb0UxRrE3V/aSwhMyVPpT1qA9CDVlLj7N6nKiq7utr7CRA8JeMBizr8P
         jwIQ==
X-Gm-Message-State: AOJu0YyZF89nRfK7NQQHkRjBaue+oSqm2ghstNopZnoMqxbDrbTobMqV
	c3KclsHOuQX/tEZ0+ecl3OHUIeUW8qYhpngTKMBb0i3RpFPYtXZxd4Z4mW0tdrQ=
X-Google-Smtp-Source: AGHT+IGpyt5NWDGnI0khW1wkoK90/F1ldXluyiDGMdK3jQA9tZXTqTvflL1xE6RlSXU3tUzaKjY8Lg==
X-Received: by 2002:a05:6a21:2d0a:b0:19c:7e6f:85f2 with SMTP id tw10-20020a056a212d0a00b0019c7e6f85f2mr462782pzb.1.1707170332483;
        Mon, 05 Feb 2024 13:58:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXfoiv3knB/SSXG8SVBFwzWWBW4atkK43PqHLEoHiySTJ+YmhaUJU2ngxDwfMe1JDaMdpi99UM1XuPBYwlaQ6iz/O4Ya9QxhbGcev8Glr4wO6FK7+kIXHO7pwT7pPg+Qa7JdbDAekq+oL0HJO6+26rNLubU31yvhucCTe387Ccm85s2D6KKw0vSfRvXCPoyHA/qD8PYXTJEKvr/YyRooerssQ==
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id m22-20020aa78a16000000b006e035133b72sm350032pfa.134.2024.02.05.13.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:58:51 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rX6zJ-002Ypp-0V;
	Tue, 06 Feb 2024 08:58:49 +1100
Date: Tue, 6 Feb 2024 08:58:49 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/6] fs: super_block->s_uuid_len
Message-ID: <ZcFaGRV08WQOxCzb@dread.disaster.area>
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
 <20240205200529.546646-2-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205200529.546646-2-kent.overstreet@linux.dev>

On Mon, Feb 05, 2024 at 03:05:12PM -0500, Kent Overstreet wrote:
> Some weird old filesytems have UUID-like things that we wish to expose
> as UUIDs, but are smaller; add a length field so that the new
> FS_IOC_(GET|SET)UUID ioctls can handle them in generic code.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  fs/super.c         | 1 +
>  include/linux/fs.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/fs/super.c b/fs/super.c
> index d35e85295489..ed688d2a58a7 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -375,6 +375,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>  	s->s_time_gran = 1000000000;
>  	s->s_time_min = TIME64_MIN;
>  	s->s_time_max = TIME64_MAX;
> +	s->s_uuid_len = sizeof(s->s_uuid);

So if the filesystem doesn't copy a uuid into sb->s_uuid, then we
allow those 16 bytes to be pulled from userspace?

Shouldn't this only get set when the filesystem copies it's uuid
to the superblock?

And then in the get uuid  ioctl, if s_uuid_len is zero we can return
-ENOENT to indicate the filesystem doesn't have a UUID, rather that
require userspace to determine a filesystem doesn't have a valid
UUID somehow...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

