Return-Path: <linux-btrfs+bounces-20686-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95321D39FBF
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 08:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C0733011EE2
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 07:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D6B2F1FFA;
	Mon, 19 Jan 2026 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vgOYJKeg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513C02F12BA
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Jan 2026 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768807683; cv=none; b=e6OTPg4THo9REuIk7EHngkjD5hhBQmkFYGuLr5Kgg1KetBZL8I9b4bZEHrR70kbWkd8LzPM2wNfS3H+SEuw5F+5Wfmdh111PaSiUqBcChfMoH1wtqdfneQp1bCPAX0ka+BPx0QEQTAS/zv8l2Cjrx8iS3tEf1Kx93BAMB61I59s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768807683; c=relaxed/simple;
	bh=d9xl/iI9UPX2IDDp1nKA5HJOuKaEYnYwT6b0wN7INJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ervwQylW9gM4mGl3G8uLgSlidw3lFTTF6dhMuCKNgn3l9O2vAk+DX6USsWOqhO/+lsjo9ESQwsUhxP4d4BXNOVbDb8aX2vCiRTYJoPWHLsu7sKlz/bONKNpubY36HMi8unvqoekBCsZEcyM8Ho5IlV3O8+CI3QV11zl/uJ4XatY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vgOYJKeg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso25747245e9.2
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 23:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768807680; x=1769412480; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gjZF61Mob2R7lpJD1kAufU/8HzfWHmcAmOJYV9b0W4k=;
        b=vgOYJKegrt2+d6UrMIEhgXEeHyvF9OoQ3KYYkaOPRcf/nn3YAR7VFt7sis5m6Q7lja
         wvM1p9xK4wjBNP3aZTQODK3gPGSplUi5BtLqt2k5XCIxITE3nkj1l1FYjbIP5m/HCgTK
         xhlGH7py3sPaz7SozKv8/WJ6jgzcoQvy2pJsCih7ofWt8JDFDoHqQI2GjroYnrmS+oe2
         MF/ZXf8sVuk+s66KKZg7MWjWRKASNaEKp4AJftUuJz+KT5XGRP6vt/4Nb6hDJuukCEak
         FSzsfEZRbjvbKDnaqLVZ+QxBzCymFpgvQAT/hPidu34u/YVjjM9dGPNlU8dD+DfCcAgV
         Y2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768807680; x=1769412480;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjZF61Mob2R7lpJD1kAufU/8HzfWHmcAmOJYV9b0W4k=;
        b=ECMwKk1SV2lpP4SrEu3HUKTgg1CEYoN0RqRlLfWU8D9ArTzQgX5iBI9WYTKz39+i4z
         BMt2zMDwQdOvr+nM8W5ZJmtWys3HUhOi0qq1/sNhxmtqFripHoJkg1LUct5hxv4FeemU
         c2BsB8sVIdf5/0PvL1UTczRLL0ArNZsdE8TsmNeKs3PgRxre32YpYPeig5cv26qA9X3Q
         v0y9KzPTMMq4S/QCM4vol8Bbx1VDwi6uar145mqNlT97sxuJUPVmwZowEs8s94Ml2obx
         0B5F9qUjPK5Zhe02vi03Uqe2hFcIbBxbzVVd19htiytPlW3o6wozfgAmPceJ07LeGVIJ
         wWnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2McFVVJAGbExyPAmuUAKKUe37ELcUI0ITNIz5x+s1iDkfTo27oj0ZHwFzLO4jilt0sob5bbcl7xxgmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIrBbOzEcRGcFOLZhK/VEpZY2AXjuXcQHfmlbNaoMaDkn3Ese0
	/b8Qyr9tDzzm4ee+Fd3/8wOUPsGPfMyiRKaVb3PsJkNo29yL6afONAI2jaDp4kJsWsw=
X-Gm-Gg: AY/fxX6N7Dnw0x2lj3iip5ptGKfgErzKmoCfvGjjX+zgJOH19OBsI199kWJQY8m4Xdx
	uQ2KhptANC6Q2JMgnK0TnRLVLQQI9WIUoURLe7kQ7rCzgQ5cfCuQaHjpkwx4EY5ydzd10I/3zKT
	yuQs2bfs8p4Ekjqcng+tmLciiQRv3HgMhuMoqYHbgcmuCnOjJsT62AxtLSjyd8LRIOk/+tyLWi+
	H7DVcOH8jEv1tFbUjgzndL26YqlEoUriJ7j0w21Z+MpBv7xBByVkIzQx904t3Ze9pMJPvXYUkno
	rIqRON7IIMY2v7U70RCKwhb+6ObsN7IQrsTQVDw67b8HHue7SaM61Konn6vRo+7zrE8ERUeWh/0
	pfTsuqaJa39LXNzUSreFY3Dl9HkRJrvT4VaRB3Z5lxF/tBEkLDn/Ifu3fl68otH1mWuCV/SCJ0n
	POFkFRldEVPH+mjdjQ
X-Received: by 2002:a05:600c:4449:b0:477:7b9a:bb0a with SMTP id 5b1f17b1804b1-4801e34318cmr129707365e9.21.1768807679568;
        Sun, 18 Jan 2026 23:27:59 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8c0475sm212576225e9.10.2026.01.18.23.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 23:27:59 -0800 (PST)
Date: Mon, 19 Jan 2026 10:27:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "oe-kbuild@lists.linux.dev" <oe-kbuild@lists.linux.dev>,
	"fdmanana@kernel.org" <fdmanana@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"lkp@intel.com" <lkp@intel.com>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH] btrfs: use the btrfs_block_group_end() helper everywhere
Message-ID: <aW3c_HzQw-dfQUeg@stanley.mountain>
References: <202601170636.WsePMV5H-lkp@intel.com>
 <9398ca7c-f114-47f9-ac22-8fd8f67214a7@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9398ca7c-f114-47f9-ac22-8fd8f67214a7@wdc.com>

On Mon, Jan 19, 2026 at 06:49:34AM +0000, Johannes Thumshirn wrote:
> On 1/19/26 7:40 AM, Dan Carpenter wrote:
> > d4452bc526c431 Chris Mason     2014-05-19  1202  	u64 start, extent_start, extent_end, len;
> > 7fc5a6968403c7 Filipe Manana   2026-01-16 @1203  	const u64 block_group_end = btrfs_block_group_end(block_group);
> >                                                                                                            ^^^^^^^^^^^^
> > Dereferenced.
> >
> > d4452bc526c431 Chris Mason     2014-05-19  1204  	struct extent_io_tree *unpin = NULL;
> > d4452bc526c431 Chris Mason     2014-05-19  1205  	int ret;
> > 43be21462d8c26 Josef Bacik     2011-04-01  1206
> > 5349d6c3ffead2 Miao Xie        2014-06-19 @1207  	if (!block_group)
> >                                                               ^^^^^^^^^^^
> > Too late.
> 
> I _think_ this check is bogus.
> 
> On one hand  write_pinned_extent_entries() gets called by 
> __btrfs_write_out_cache(), which has the following comment at the top:
> 
> /*
>   * Write out cached info to an inode.
>   *
>   * @inode:       freespace inode we are writing out
>   * @ctl:         free space cache we are going to write out
>   * @block_group: block_group for this cache if it belongs to a block_group
> 
> but then __btrfs_write_out_cache() is only called by 
> btrfs_write_out_cache() which looks like this:
> 
>      ret = __btrfs_write_out_cache(inode, ctl, block_group,
>                        &block_group->io_ctl, trans);
> 
> so iff block_group really is NULL, we'd have a NULL pointer dereference 
> when accessing block_group::io_ctl.
> 
> 
> Same for all the if (block_group) constructs in __btrfs_write_out_cache().
> 

The zero day bot can't use cross function analysis because it doesn't
scale to the number of trees which the bot tests...  Otherwise, sure,
Smatch would silence this warning.

If we remove the NULL check here, should we also remove the NULL checking
in __btrfs_write_out_cache()?  Otherwise there is still a potential that
something will complain about inconsistent NULL checking.

regards,
dan carpenter



