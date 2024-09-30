Return-Path: <linux-btrfs+bounces-8332-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8FA98ABB0
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 20:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D46728422C
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 18:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5DD1990D7;
	Mon, 30 Sep 2024 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="HMjskevT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B092B9A5
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719870; cv=none; b=GEmyokWKdTjXotGHRtzW4Fj452rDOP61vfY9aDgzlB0ZE4SBHyMK+9BnxM+mASsI/XtdRSKD89NPnBPe+bR0XLwEv+GBMCPom2pnOKV+DUUcWo5FgHAHf465/AQUaNWsHti/wBny+zqn0OHhtSBQgDhH7YtefM2mOT5n8cWEv/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719870; c=relaxed/simple;
	bh=o/7MwESEuqvyrtayUeAQKK+Z+0BE3Y7Dx7RyFw7ZRPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ml1kpigmPI8wHz625g+W9KZ5feMpQyDNOR+6vSZNRr5rJObDroOgeSPiSY1X6mltWlmbq5ooKuDTLhGm0J99960J4lw7mCl8HIWByX/0FATLxSOyicgQZBrGK6+ySfTeU1psCZVZm/4mXuGJEw4PCr9QLJ7irbBCbPHjYD0nR8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=HMjskevT; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-710e14e2134so2602441a34.0
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727719867; x=1728324667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8WansNhApWYgYmqyymjv5mvS9XYByzymHYH90CGRR24=;
        b=HMjskevTgawGIth0yvJkqNzsI6SxTodlb2lfoRHNHH+Y4vx1lI0R7Ghq2Hq32WWWOm
         RlK6gJ6k3fFSdiuOuB0xtUSX3JLQi37EDGNrvone+W+PRMzfYs3jqXnrA5JmV49crTSa
         Y/ja2T9o3v9GkXSIfBUSxYbmfbaX/FRJqWvckdmak8u7HkaUGupfz5Zz6D+Ie52MwCJT
         F7JxvFKVnbX3NUUe7JpFLbhE7PdgQf70SJM+7Lara1SyqqjCEPKmcoGzK373cqj0uafV
         bIReoIhPTr+6/Vk+ZmvJdQo1u8Ggj1df3mPDds5zWyrqoxx6/IiHFF3m/EblilEvXKxB
         gmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719867; x=1728324667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WansNhApWYgYmqyymjv5mvS9XYByzymHYH90CGRR24=;
        b=BW832isE1EdEIiyz0xF1R/800JvPV+fHC9b7Vq/fID8jchiSccDHD2OoBiEmjYXLg6
         hyDP60OZSiuAB3CWwSFEL5R0+nRQucNHm1dFLrqVHClc+mwLxUI8wFBliw8s6nJ51TLf
         aG/H7Repmrlig0oYccfznLqaScmjcOrV8hHDJXKQU+A3xM7PmW0lXiOLBfMSoSPg2FYy
         q/yuPZIE/UZaUbHhm/2cxP/kmQezRZE3dLhE109cVLPqEBPG7N+1FgAx0YiJWA/wjXzJ
         Q5WDmIb3kZrYwxb0LthjY57X1oijRlnDEKq09DhkuHDLFlxY+RS/eNBDcG8LYdsK6nwr
         1A3w==
X-Gm-Message-State: AOJu0YxrS8brUI81Pb5p9l93yex+dBFfd5I4mqyPrMTOp9x/uXvT8dKZ
	7Ixijm89N2lpYzUNmEJGB7nV/SWX02uQLnIh1VDbQRjAd/AcAN+YpiXdQQqt+zEfGGWr5OyioEy
	h
X-Google-Smtp-Source: AGHT+IFGqrXCTQ2mJtEYoKwBCFFnMFQMIer+f93jtKymfLwcXejv1037vqrq6p48ti7LylQTC7LtoQ==
X-Received: by 2002:a05:6358:54a6:b0:1ba:564b:48eb with SMTP id e5c5f4694b2df-1becbb361a0mr503405155d.6.1727719867499;
        Mon, 30 Sep 2024 11:11:07 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b610b88sm42144906d6.48.2024.09.30.11.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:11:06 -0700 (PDT)
Date: Mon, 30 Sep 2024 14:11:05 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: send: fix invalid clone operation for file
 that got its size decreased
Message-ID: <20240930181105.GD667556@perftesting>
References: <5a406a607fcccec01684056ab011ff0742f06439.1727432566.git.fdmanana@suse.com>
 <794af660cbd6c6fc417a683bfc914bbf9fb34ab0.1727434488.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794af660cbd6c6fc417a683bfc914bbf9fb34ab0.1727434488.git.fdmanana@suse.com>

On Fri, Sep 27, 2024 at 12:03:55PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During an incremental send we may end up sending an invalid clone
> operation, for the last extent of a file which ends at an unaligned offset
> that matches the final i_size of the file in the send snapshot, in case
> the file had its initial size (the size in the parent snapshot) decreased
> in the send snapshot. In this case the destination will fail to apply the
> clone operation because its end offset is not sector size aligned and it
> ends before the current size of the file.
> 
> Sending the truncate operation always happens when we finish processing an
> inode, after we process all its extents (and xattrs, names, etc). So fix
> this by ensuring the file has a valid size before we send a clone
> operation for an unaligned extent that ends at the final i_size of the
> file. The size we truncate to matches the start offset of the clone range
> but it could be any value between that start offset and the final size of
> the file since the clone operation will expand the i_size if the current
> size is smaller than the end offset. The start offset of the range was
> chosen because it's always sector size aligned and avoids a truncation
> into the middle of a page, which results in dirtying the page due to
> filling part of it with zeroes and then making the clone operation at the
> receiver trigger IO.
> 
> The following test reproduces the issue:
> 
>   $ cat test.sh
>   #!/bin/bash
> 
>   DEV=/dev/sdi
>   MNT=/mnt/sdi
> 
>   mkfs.btrfs -f $DEV
>   mount $DEV $MNT
> 
>   # Create a file with a size of 256K + 5 bytes, having two extents, one
>   # with a size of 128K and another one with a size of 128K + 5 bytes.
>   last_ext_size=$((128 * 1024 + 5))
>   xfs_io -f -d -c "pwrite -S 0xab -b 128K 0 128K" \
>          -c "pwrite -S 0xcd -b $last_ext_size 128K $last_ext_size" \
>          $MNT/foo
> 
>   # Another file which we will later clone foo into, but initially with
>   # a larger size than foo.
>   xfs_io -f -c "pwrite -S 0xef 0 1M" $MNT/bar
> 
>   btrfs subvolume snapshot -r $MNT/ $MNT/snap1
> 
>   # Now resize bar and clone foo into it.
>   xfs_io -c "truncate 0" \
>          -c "reflink $MNT/foo" $MNT/bar
> 
>   btrfs subvolume snapshot -r $MNT/ $MNT/snap2
> 
>   rm -f /tmp/send-full /tmp/send-inc
>   btrfs send -f /tmp/send-full $MNT/snap1
>   btrfs send -p $MNT/snap1 -f /tmp/send-inc $MNT/snap2
> 
>   umount $MNT
>   mkfs.btrfs -f $DEV
>   mount $DEV $MNT
> 
>   btrfs receive -f /tmp/send-full $MNT
>   btrfs receive -f /tmp/send-inc $MNT
> 
>   umount $MNT
> 
> Running it before this patch:
> 
>   $ ./test.sh
>   (...)
>   At subvol snap1
>   At snapshot snap2
>   ERROR: failed to clone extents to bar: Invalid argument
> 
> A test case for fstests will be sent soon.
> 
> Reported-by: Ben Millwood <thebenmachine@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CAJhrHS2z+WViO2h=ojYvBPDLsATwLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com/
> Fixes: 46a6e10a1ab1 ("btrfs: send: allow cloning non-aligned extent if it ends at i_size")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

