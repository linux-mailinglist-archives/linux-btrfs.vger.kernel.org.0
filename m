Return-Path: <linux-btrfs+bounces-3499-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5F18860C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 19:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E39D0B21E9C
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 18:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA19133422;
	Thu, 21 Mar 2024 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="kJQSxOU8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CC48BE7
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Mar 2024 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711047099; cv=none; b=YJuPiVt3+/mRmJzH/5H7fiyvhFjOL01KyzU/IBmkvY4KiY+jygUiKFQO/ytDDcfDj/l1WqqUT5KWVJj1WX2TjGzNF8oLDLHftVErUD8qy6HE32Lw7n+sb1/x5VAGCMxHyfEVPZLrO/gzXTrzVvPnVuJJb3wafOr166G76POCOtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711047099; c=relaxed/simple;
	bh=1hckWhj6jtAM7+uzEq5Ywaf8BovHBZYXygLSPyxwcLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQoQcwU64vzeovbAmEVJOWBLMD7lNro33O7iQiGc38iNUWjS0ifWoM7QCkrF8N3D/WKsNnYojFMX8e5n5Ra7zyJ1EK4a4UGnTKVtr/ZG49mMhj1mlFM0GShusF1ye6xVUj58Sh4qqdmANdRfmRI7ryWJ9QfyvZ2Kd0H9PFz5zbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=kJQSxOU8; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-789e83637e0so85249085a.2
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Mar 2024 11:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1711047097; x=1711651897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qx08k88SVdbvBj44YvZhcEuvYWEa16k30j8vHsyU5jE=;
        b=kJQSxOU8N6jIhd733eTa7hkZrB63Jl3nxwp181Fyl2bQhUKVTeq4836AyBnNVBA5K2
         hCisuJYjL0y1Cv0u+iCHUOrrBHDIUQmP+4yEvEXjg8iPFTi7lPo0UVNd+wRXQEWxkO4/
         IBjIqGNm2zzs/IbiNFzdffLqdxJ8CoKyZ+1BUJUs+78yRaqPf75vbyYQGmCWSR5Dr6Jj
         vldlKC6BW/Rz0jz4pvV/8OvcVCZfDF058Gm8MTx4oYHKrAR8Dfdu9JWNj5zSoxUJj8oC
         M+h9ILcu/EBpffpwvPYgvgvzw16VSBNM2At5lFkbLMrSAKxqJxPXGtu+d8+VOGT5MOym
         51xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711047097; x=1711651897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qx08k88SVdbvBj44YvZhcEuvYWEa16k30j8vHsyU5jE=;
        b=gQ427GJirii0CHLMjf7tA/rXNq45c2E07co7CxIxe9AOybTc+hzME4xzf2BT9mnRZ+
         yCbiMLtcBm2uGd/JAMlUmvbHEkI3x7qSQx7iBeGSAkweY4NEeREDsAySYY0MrZbBeOnc
         sNQqrY3zv35dYPdd5Z5IPa1CoHpSoSKEAW0xToFuB1uT/Vlc2bhpQdmJaWDHdF2Zj/ZV
         wtF0mT2HWlXVF30oTZxnBamIrPtftHCYLQzBnnd7LbeJZxh4Bav0jMbNcW6RoK4F+xS3
         k8sQe8Si97OzTJ/0ePQJ1sqF0obpFlumi3bJLbY40Se9y+YcjS/G102YbEAac2uc2iYh
         rX4Q==
X-Gm-Message-State: AOJu0Yw27GsIAHH3K2DkA3XabIIS5c0QIGD+fLU5PEAM3UQXdFXXy6ws
	WLR6iTP+w5WrDsaZGHNgUROiERjyqMzP23xKHH07zqVaP7yrIpRArRvdH2KEdwAm7UQr+GHG/W4
	r
X-Google-Smtp-Source: AGHT+IFZ6YwLKqiWjPdhxFdtNzsyFs0Ektg46SNfGfon/SdMvNoSbApo+5id3BPuF0AYgC5jNblG+Q==
X-Received: by 2002:a05:620a:21d8:b0:78a:18d6:e4eb with SMTP id h24-20020a05620a21d800b0078a18d6e4ebmr41211qka.34.1711047096895;
        Thu, 21 Mar 2024 11:51:36 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i1-20020a05620a404100b00789ea5b08bcsm145309qko.23.2024.03.21.11.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 11:51:36 -0700 (PDT)
Date: Thu, 21 Mar 2024 14:51:35 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: reflink: disable cross-subvolume clone/dedupe
 for simple quota
Message-ID: <20240321185135.GB3186943@perftesting>
References: <74730c411b0fd87484c8d894878c5cd8bac1d434.1710992258.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74730c411b0fd87484c8d894878c5cd8bac1d434.1710992258.git.wqu@suse.com>

On Thu, Mar 21, 2024 at 02:09:38PM +1030, Qu Wenruo wrote:
> Unlike the full qgroup, simple quota no longer makes backref walk to
> properly make accurate accounting for each subvolume.
> 
> Instead it goes a much faster and much simpler way, anything modified by
> the subvolume would be accounted to that subvolume.
> 
> Although it brings some small accuracy problem, mostly related to shared
> extents between different subvolumes, the reduced overhead is more than
> good enough.
> 
> Considering there are only 2 ways to share extents between subvolumes:
> 
> - Snapshotting
> - Cross-subvolume clone/dedupe
> 
> And since snapshotting is the core functionality of btrfs, we will never
> disable that.
> 
> But on the other hand, cross-subvolume snapshotting is not so critical,
> and disabling that for simple quota would improve the accuracy of it,
> I'd say it's worthy to do that.
> 

We did this on purpose, and absolutely want to leave this functionality in
place.  Boris made sure to document this behavior explicitly, because we are
absolutely taking advantage of this internally by having the package management
subvolume managed under a different quota, and then reflinking those packages
into their containers volume.  This is the price of squotas, you aren't getting
full tracking, but you're getting limits and speed.  Thanks,

Josef

