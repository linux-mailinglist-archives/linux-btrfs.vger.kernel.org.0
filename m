Return-Path: <linux-btrfs+bounces-12499-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCD6A6CB27
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Mar 2025 16:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A394A1892DFD
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Mar 2025 15:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54A5230BDF;
	Sat, 22 Mar 2025 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="NBHLdxrQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0BF70809
	for <linux-btrfs@vger.kernel.org>; Sat, 22 Mar 2025 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742657011; cv=none; b=EEfjTCNyuuGtDuYxPdV4/tUHIwg/WSVGE8ZbDNRjpQXBrjHYIecfY0zYhfsdbEDQJRkIukiGiHagioT4l7ornu9OqBu9NUeM5tEX7qjX4McrW47papJui+HXaWjx2+XKWIpxiw6MGH/3CtCkoQUPKeDZ34HmaYlTSoCYyoHwdHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742657011; c=relaxed/simple;
	bh=ZOLy9kblT2spyGdVbM0xvXGE5iqNq/8rVxdRzpJrNm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh44Ceuvnajdt4n8XYOOLJ1lYc6dxC305q8z5oV0+PUCddBodwXK+FEn6M4TJtn5J6N1R6RENnuHzPtGWleqlRs+5vPzd2WdsPDBqXaNEaUDwARxgOO3+8/CXKpklDnS2I8E0sq7eTP/ce11gqOV8KAv6ygBdzyEEL29XpLS+SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=NBHLdxrQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223f4c06e9fso48196255ad.1
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Mar 2025 08:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742657009; x=1743261809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=61HK6RXVqW5ScgZIgBIAV/0zJZv4+R6BdiaVkC0uX+0=;
        b=NBHLdxrQSDA1veeJskmGFA4tnIn1VAvUeCf81NKxMAHrf9HIWSYcdOKWWozYwSUf8S
         PnRe2giNqjX1Tb/xdoF1qT3UOWYAHa8zHwh0HqztxuleA2EtXOfuvdKVCh+Xk2BIQ7Ri
         HRkk23CQGtBQGAIMOK1MYUh/68T/1hrjH7VmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742657009; x=1743261809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61HK6RXVqW5ScgZIgBIAV/0zJZv4+R6BdiaVkC0uX+0=;
        b=gGXy/35lGcNYEMEJnk785O0JgeWY3YZ32hCwevPlHpb362j6K6RhNWpbwfceFbX3QL
         r9Y4Hy2UrMJJ9oViQk1KHMqPGnrarKtrAUnWkmW5I6qVJ1Ku2JME+Rhwc5I5IBQIvZOQ
         Lp1d4/HhLKuFCsndwFKMjsBbM6RdZbU60pBRcLU4+M5dUJyai2vybaBl3X6rwu07M913
         E0TGI1FeEj3UCJkYbp0ouNEgwhvMqyAVaYd6dWA7060xbijnPP3L1eKDdXkyANECHC18
         06D50/X0cXZRnBgX5SzfgR0Bm06F4I5GLKEjOQP3sfTuknMOML3WBXwrWifvDgOed2id
         7zpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwjBW6pxNDB8M4fp6cazSv7VRs/GEIlCYTBNb9ap7phvzhB+BPIeLoYOSQTA65L0kIYL24f6+3nvfK6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzhBBwfDcOxTl8CvRkuYs+ctfAqBNnFhKZrQJo9La68ZzxW1xj
	cMh3NsNhtVRd/4sIIhMh7f4lMe758OWxuMAvWwpK9ba8ifakKkLufe6yVT0rjzLyJGF1Xdvimtb
	W
X-Gm-Gg: ASbGncuUUWxz3K/WTATgxU+nFMgFn8R83RMd+9a+re9EqfnYW9DXxceZaXDoyVFsZ1y
	vZmTKy8KXO64bfWVDR6uFjIX2jVnZ/h8Txho8AAu5z3LDJzmFsddqVIswGu5AjbKb99jELERMGy
	LV3DsPt3d2s0urzv4n+hjltM75t92rAFfFP9rcUsibp2+y+l8UglJ0TPwpXtJ0kVg0VQFrivF6G
	4v6Qyoci7EGz4Eghim0xXX2oXy5WHIMF0NO2G7QuYMAItlnd//08QFyTaMEX7ndpzlCp8Igpwtk
	JzFhN9GzZqgRnWJ6SPN3Q79PDc+pQ0Xlrlcxfh4FuloRoyY7KS83lKqbPCewRIIXYM8m6l6T0QH
	3
X-Google-Smtp-Source: AGHT+IEAFSoC4sIeZaO2AHNlHse9aa5cT0YNBzdKy6xktGy4qrSSxCmk5pb4vRu9mOnEB+PXHQLSYg==
X-Received: by 2002:a17:902:ef4f:b0:21f:1348:10e6 with SMTP id d9443c01a7336-227806cfff4mr130234545ad.13.1742657008693;
        Sat, 22 Mar 2025 08:23:28 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f459c4sm36996635ad.82.2025.03.22.08.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 08:23:28 -0700 (PDT)
Date: Sun, 23 Mar 2025 00:23:13 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v5 5/5] btrfs: ioctl: introduce
 btrfs_uring_import_iovec()
Message-ID: <Z97V4cIKINX58r6s@sidongui-MacBookPro.local>
References: <20250319061251.21452-1-sidong.yang@furiosa.ai>
 <20250319061251.21452-6-sidong.yang@furiosa.ai>
 <14f5b4bc-e189-4b18-9fe6-a98c91e96d3d@gmail.com>
 <Z9xAFpS-9CNF3Jiv@sidongui-MacBookPro.local>
 <c9a3c5bb-06ca-48ee-9c04-d4de07eb5860@gmail.com>
 <812ae44c-28e9-40a8-a6f0-b9517c55e513@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <812ae44c-28e9-40a8-a6f0-b9517c55e513@kernel.dk>

On Fri, Mar 21, 2025 at 05:17:15AM -0600, Jens Axboe wrote:
> On 3/21/25 4:28 AM, Pavel Begunkov wrote:
> > On 3/20/25 16:19, Sidong Yang wrote:
> >> On Thu, Mar 20, 2025 at 12:01:42PM +0000, Pavel Begunkov wrote:
> >>> On 3/19/25 06:12, Sidong Yang wrote:
> >>>> This patch introduces btrfs_uring_import_iovec(). In encoded read/write
> >>>> with uring cmd, it uses import_iovec without supporting fixed buffer.
> >>>> btrfs_using_import_iovec() could use fixed buffer if cmd flags has
> >>>> IORING_URING_CMD_FIXED.
> >>>
> >>> Looks fine to me. The only comment, it appears btrfs silently ignored
> >>> IORING_URING_CMD_FIXED before, so theoretically it changes the uapi.
> >>> It should be fine, but maybe we should sneak in and backport a patch
> >>> refusing the flag for older kernels?
> >>
> >> I think it's okay to leave the old version as it is. Making it to refuse
> >> the flag could break user application.
> > 
> > Just as this patch breaks it. The cmd is new and quite specific, likely
> > nobody would notice the change. As it currently stands, the fixed buffer
> > version of the cmd is going to succeed in 99% of cases on older kernels
> > because we're still passing an iovec in, but that's only until someone
> > plays remapping games after a registration and gets bizarre results.
> > 
> > It's up to btrfs folks how they want to handle that, either try to fix
> > it now, or have a chance someone will be surprised in the future. My
> > recommendation would be the former one.
> 
> I'd strongly recommend that the btrfs side check for valid flags and
> error it. It's a new enough addition that this should not be a concern,
> and silently ignoring (currently) unsupported flags rather than erroring
> them is a mistake.
> 
> Sidong, please do send a patch for that so it can go into 6.13 stable
> and 6.14 to avoid any confusion in this area in the future.

Agreed, It could be seen as a bug that the flag is dismissed silently.
I'll write a patch for this.

Thanks,
Sidong

> 
> -- 
> Jens Axboe

