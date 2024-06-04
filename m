Return-Path: <linux-btrfs+bounces-5447-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623638FB838
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 17:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8457287D86
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 15:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDEC145A03;
	Tue,  4 Jun 2024 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Y6HZwija"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCB713D24C
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516706; cv=none; b=Cb1wmSnx/1PZgJUzF7LgmVjDDtlNU1h6G9qvb5W1QsdTRgAMnZ6sVFF+tid/pb6IKTH7dO4wxy1Moxh70274K8nWIn/Ih2d1VIlw7ykFNdJDgH3qsr04sZ0T0f9rRLvvYzi4+EHCJPiC0+QuYWSa5U76hTunLMHyGNZFcwnHAdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516706; c=relaxed/simple;
	bh=oRtCUvm1fqUQ0CgfSDBQK9eayzR4l8PIQOgT1rr6zoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZT/Qu5cl40NwGuRdRbLE79vdtIWkeOp2/N8prAuT9s58dbqjmmL6p/xvEwrISAkKe8vft2dcVElfbLcVscvhtQT4A6l0zAFHvMzm3rBJq5ZEjKYfJgYtkOOIw2m7OZySHN5BCad8Z8gTlXmlsfpGwYozM71Nva7B2YALD8pMtoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Y6HZwija; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f47f07aceaso37534755ad.0
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Jun 2024 08:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717516695; x=1718121495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6vIXBPeYUJtWQLlZqlqI5ca5MrarSzbSUZQoKzjLk6U=;
        b=Y6HZwijaq1vG3oy7O3vHLoLOOSAuJoS2sfsitwvu0skD5XysWKgzUsS930V8Orf82d
         +4eoHgOXF5+7B8jcSsyAkbQ2R03++Q6AiuP3p2qEGEDwGg3fKhrrcinnGoBiKswWikO5
         FMoufdNMC5ComPXlT2Oo3TW41zpypP4DKRe2EC9IT5LFFtKVWwXaP7jIY64HOJl+LjQh
         ndGod+DHDzWmEV3ima3FV8xUPqUA8ep/qrNpZPl5uNsxgKkJcUuQWtXOD0voEyAsK1C/
         Ume+UtejpUuJa4XpT8IgLTBJuD0LMMo3fxfVp9Ca3EDvsaZMwRRawdR9J7HcsMNkLdBs
         ng4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516695; x=1718121495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vIXBPeYUJtWQLlZqlqI5ca5MrarSzbSUZQoKzjLk6U=;
        b=RzMfgYD7QHxFOqhE6FAhw/KizSUBGtJpX5HCH5S+iEZezFXVQIMO2POBhNZy7UGgd/
         6tiBUpBHr2eLUtEYu/2mA1oLk9c7abvwuiQpFDM6RYJ7xX6nrPFVVA2+WQWj1Yt9dYam
         7NK7pkVxW2NIJyz4WZ73HY78rK7z1xxn6PlcB3B7//QmkztdC9u1eQbZWyrd0/9dZ42J
         05goFLr7UV1gfiDmwml7Wty6vWreB3D3MmA3jy2M90uE1qurxuKD7+5tZ5n1bgr5YuvN
         1SWAdb/SpnlP9MANOjjhY3r7oWTKXrtax5bqZsX+gWjpkQhCTrJNJeEhmN6QmOOb/9Eu
         2Uzg==
X-Gm-Message-State: AOJu0YyUvwK9GYOGJFeyMu9Bp7Fydut4FatkkJkPFNA/ZTU8GO+uZ9da
	MqsvZLHL76JTcI6095phzEDg9voEDVWcedOMIDHGbDlcqOvDfAu0Vt6li6wMc71bofUdbSXMP6Q
	e
X-Google-Smtp-Source: AGHT+IGExRcKM0qvwgHDVqjtDMsDLJSPScIePSt6C7UjYgJA0AuwAZJilQwdl1liVp1HwcYUpQp+eg==
X-Received: by 2002:a17:902:e80d:b0:1f6:6bf5:5aef with SMTP id d9443c01a7336-1f66bf55dccmr83615725ad.29.1717516695304;
        Tue, 04 Jun 2024 08:58:15 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:c660])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dda63sm84876925ad.148.2024.06.04.08.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 08:58:15 -0700 (PDT)
Date: Tue, 4 Jun 2024 11:58:13 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: print-tree: do sanity checks for dir items
Message-ID: <20240604155813.GC3413@localhost.localdomain>
References: <0279bccaf02bbc09d6ac685b37e36aacb60bf9b0.1717476533.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0279bccaf02bbc09d6ac685b37e36aacb60bf9b0.1717476533.git.wqu@suse.com>

On Tue, Jun 04, 2024 at 02:19:08PM +0930, Qu Wenruo wrote:
> There is a bug report that with UBSAN enabled, fuzz/006 test case would
> crash.
> 
> It turns out that the image bko-154021-invalid-drop-level.raw has
> invalid dir items, that the name/data len is beyond the item.
> 
> And if we try to read beyond the eb boundary, UBSAN got triggered.
> 
> Normally in kernel tree-checker would reject such metadata in the first
> place, but in btrfs-progs we can not go that strict or we can not do a
> lot of repair.
> 
> So here just enhance print_dir_item() to do extra sanity checks for
> data/name len before reading the contents.
> 
> Issue: #805
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I'd rather not duplicate this check.

Is the print-tree coming from repair?  If that's the case then I'd manually call
check_leaf to make sure the pointers are all correct before calling print tree,
otherwise if it's from a different tool we need to make sure the strict checking
is happening for that tool, we should only be bypassing the strict checking for
repair.  Thanks,

Josef

