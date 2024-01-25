Return-Path: <linux-btrfs+bounces-1808-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A5683CDD7
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 21:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62C62B23EF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 20:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED55A1386B6;
	Thu, 25 Jan 2024 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="eDSPmRNQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C50C13A24B
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216105; cv=none; b=GyOj7bFIrGCbdgXXfxOWfRIXLkF2p9NN7biye+LCklctoNEEhxQi6Wh1fjElFUmBSaBPFCABKt9m/gn2n2VOa9ee1U5JEVpMIfdTahQGwmBMPYh9dXfyk9DbB4J+JpIKBP2Zm9DLOBbcS/EQk7SZnYHIjiriR7/2iL1L8lq9Oyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216105; c=relaxed/simple;
	bh=O2faIgq+HvzbuK/UzBc3Ci/4aaqe4AOEprF05goxqsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpO7qHGww2lFKkR1jTyEUVKvuf31CwJNBvoRkyh8wxniroscgnC5xLMWDYRZJvAI/K08EnVvi+BqU1fpsJMz4nSBp47ceqJtEHEioEYJbjqHN8H6veuYrqCHoEJ3RZSSXxjVuZyb4ZM8GUmOUtrQv6/DjSsr1RW493IRlCua2IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=eDSPmRNQ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-602c8a0cdb1so405267b3.3
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 12:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706216101; x=1706820901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VGSgC/3FplHwTHfG8WWlFnCoXGUsYYi/fzr8KFy6dvQ=;
        b=eDSPmRNQHsqe87etIi5tC1YNsYBq/AjETRYV1lB59wgYFaf6Xd6UjZDBJRJW97BeT1
         +gF+h4hHeHrnabQRB0Luzor9r8aq6f1E0Q8yqhKGI++Hd828ZuDJFdJYXz4LOWLzb44I
         5GZt2jdjr1yY+9jU18MFcklJM6JfD8n+06EIOokno7PT/v7fUDpjITk2dN6nvAV75CX0
         I6OaandkbM9yYA73KvFBQo/+JQV5iQSJNQtDmb+gYQo3oU2FBRjqryzG0ddswbo11+bq
         NidY2C4hk8W4A4YtHONmuUvgGopflZs9U5mBEIIyBJujjtVzf7UTcmB1G27bwqK/Zsx9
         pm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706216101; x=1706820901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGSgC/3FplHwTHfG8WWlFnCoXGUsYYi/fzr8KFy6dvQ=;
        b=E2+gnH6mDgokg8ooE4Aa541NuyPZSgwWvLuiMJ3N3XtjCfuEX0bthLxqcTET6V92AH
         gmEINtAY52x6rWdisqS1XnR7w6dIpTXMxtGOFnsqWSZYVkieAwG63WkiJSkW12SpG4K9
         /fMtMXiwl3xdaP47bUBGlE5w+Fzzo2HPJ/j6Mj4F/Pcs6CiLtsyu7Ns2cHMB98XjEAfC
         N9JEn3JX1oaqG59wMIWP5d9r4s5kaTFao8VS1D00MdNEygvQnPicrR0NriO/e7pt3v9K
         8uNctDPqKvJprdoB4x+Og0DTjD4ttvLdq0juagiZc507EBF6YrpkB79FUgrlis+OoA+f
         NPkg==
X-Gm-Message-State: AOJu0YyagvEGLL16jxc8GTysNmt3J1td2wIlgU8WEoAmkG8EsJWR00/l
	QsuecOVotjbnMdk++zU6oWzQUOum9YKakaYHYxzcsCzB6Gjys9JglIMggMxbm98CQxQEY2geX96
	v
X-Google-Smtp-Source: AGHT+IGYqd87PifZeYoiiq6725pDlRurvaBdJP+nIB1enV3vFDM/mm+K/UHrA7RhLAraxBLnoXLjOg==
X-Received: by 2002:a81:a889:0:b0:5ff:6173:e98e with SMTP id f131-20020a81a889000000b005ff6173e98emr397419ywh.63.1706216101480;
        Thu, 25 Jan 2024 12:55:01 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ey1-20020a05690c300100b005ffcb4765c9sm884716ywb.28.2024.01.25.12.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:55:01 -0800 (PST)
Date: Thu, 25 Jan 2024 15:55:00 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove unused included headers
Message-ID: <20240125205500.GA1509928@perftesting>
References: <20240125164448.18552-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125164448.18552-1-dsterba@suse.com>

On Thu, Jan 25, 2024 at 05:44:47PM +0100, David Sterba wrote:
> With help of neovim, LSP and clangd we can identify header files that
> are not actually needed to be included in the .c files. This is focused
> only on removal (with minor fixups), further cleanups are possible but
> will require doing the header files properly with forward declarations,
> minimized includes and include-what-you-use care.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

