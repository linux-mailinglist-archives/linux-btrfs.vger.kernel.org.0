Return-Path: <linux-btrfs+bounces-2769-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF11D866C29
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 09:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5891C22BD6
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 08:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E621CD1B;
	Mon, 26 Feb 2024 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="d4celLX0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CA01CA87
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936052; cv=none; b=lW+f9w+dvHBuv+0+teeD8SLSVVO9DyT+h3qxjvIvv5ke137XL+EroI5g6Cj53kRcmLIUFM88s4JIDOGv0rt1sCmwILH39ndBLH1hNzxZA4K5fBPqMhukG83EM3gsdtNaOG6ZxKFHEJcBXYP/2ebhCm9LOnYQl9L9AlqC7NJbjyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936052; c=relaxed/simple;
	bh=OgPr33qeJxSN1ACFIn4rsbOwqQ7JzF96ye/o470bEHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKZ0y6wgyvv0inxU7PWjjfTNWlc15v9cPrPntLAvVKgk7B1GD4CM4zNaUMv8H4m6TKsC0u2OarKTndlgcroG5Q144ePB8N498Iyqzm31b6lv+qCw4V1H/ZJ4mJM9LLxPVakg6cMQhBvEeYiDtesas+A22/IvU9ETZlq6zmNgC+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=d4celLX0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so3672153a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 00:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1708936049; x=1709540849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RG8h9HtTqCH0xD/0lp/MK6evwSHkizYp8Z0N+/dsPdM=;
        b=d4celLX0P6jBSCp8LLD68JLofuxG37dTOs9Ualsu0f/cldUauXiEPTNyDg3AqjrgTZ
         LUopENJZyRvP+kAYz7YvF0MQZ6X8NBE44orv5UzFr1LiOHPg1wRQuGomzQaDEAMTr6ux
         IBenw/kkiOuoxzX8uVX8BLHtRWbVz2y5JTW3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708936049; x=1709540849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RG8h9HtTqCH0xD/0lp/MK6evwSHkizYp8Z0N+/dsPdM=;
        b=Tqz77gpiaUzhrC5xjOym3kcRq13nti+DqRo2HIKD7EPfOm95a7LO/rQPTtdNvGqAiW
         Ze5G/TTxvkQHZNGmWyAhQHjFl6b1CK0CTMLvx3rO/OsuFLySoH/V5sNUo58o9qmGUNAm
         lfTVbu6K9LqvuYY5kLii+fQbSvcX+Hloi8mDltgMKWpHRqsQISqyTkw/E4feR8h5W5Gg
         ChWIcAM/wdhybB7tOK5dTflCoTo6Vqy7FG2xePNU+VMdvwFiCQxuxTl94hqjwINkIQq/
         ztG9bPEZtytPts45bYGRnusCAypIdE33Ncf/89nVJ576GWM4ISSQNTKVOUQlMUCzZpRt
         W3/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpC8m+p/T/y1JSbg+AvhOKOevjUuVa1inJw1zV+VK6JdpQqozdpS+bgzo0dzs7s+vEXbIAtxRPPsvSO6S0xzPjHD4nSlOJOsjaN58=
X-Gm-Message-State: AOJu0YxQj18ZvD9q8jk3MY1SBk1UYrwdAGQ7iOQ/SAEkcML4QA0vO1ZR
	yBbgr34oE617yOfsDRkrkOnXnZ/OChhrxT9NiB2LNkxCJGZD840jZckMt7//4ixa2PXRT8lkOPU
	r8JQYtylpvXHh8NRQ+9YjPkjnuBxjoIJZk1XtGQ==
X-Google-Smtp-Source: AGHT+IG0pgMt4vUs7EtTrd5627D4m1+vfVpIva+Me50maxinT8JXAUNoW+2KDn+dpslvef9S4XuUmVkrbBD1zZuYPIw=
X-Received: by 2002:a17:906:3c7:b0:a3e:720a:b961 with SMTP id
 c7-20020a17090603c700b00a3e720ab961mr389723eja.34.1708936049011; Mon, 26 Feb
 2024 00:27:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq>
 <CAJfpeguBzbhdcknLG4CjFr12_PdGo460FSRONzsYBKmT9uaSMA@mail.gmail.com>
 <20240221210811.GA1161565@perftesting> <CAJfpegucM5R_pi_EeDkg9yPNTj_esWYrFd6vG178_asram0=Ew@mail.gmail.com>
 <w534uujga5pqcbhbc5wad7bdt5lchxu6gcmwvkg6tdnkhnkujs@wjqrhv5uqxyx>
 <20240222110138.ckai4sxiin3a74ku@quack3> <CAJfpegtUZ4YWhYqqnS_BcKKpwhHvdUsQPQMf4j49ahwAe2_AXQ@mail.gmail.com>
 <20240222160823.pclx6isoyaf7l64r@quack3>
In-Reply-To: <20240222160823.pclx6isoyaf7l64r@quack3>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 26 Feb 2024 09:27:17 +0100
Message-ID: <CAJfpegvvuzXUDusbsJ1VO0CQf5iZO=TZ8kK7V3-k738oi5RM5w@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF TOPIC] statx extensions for subvol/snapshot
 filesystems & more
To: Jan Kara <jack@suse.cz>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Josef Bacik <josef@toxicpanda.com>, 
	linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 17:08, Jan Kara <jack@suse.cz> wrote:

> > If we are going to start fixing userspace, then we better make sure to
> > use the right interfaces, that won't have issues in the future.
>
> I agree we should give this a good thought which identification of a
> filesystem is the best.

To find mount boundaries statx.stx_mnt_id (especially with
STATX_MNT_ID_UNIQUE) is perfect.

By supplying stx_mnt_id to statmount(2) it's possible to get the
device number associated with that filesystem (statmount.sb_dev_*).  I
think it's what Josef wants btrfs to return as st_dev.

And statx could return that in stx_dev_*, with an interface feature
flag, same as we've done with stx_mnt_id.  I.e. STATX_DEV_NOHACK would
force the vfs to replace anything the filesystem put in kstat.dev with
sb->s_dev.

Thanks,
Miklos

