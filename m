Return-Path: <linux-btrfs+bounces-2806-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2C2867DAE
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 18:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901EC28A399
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 17:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F1C133280;
	Mon, 26 Feb 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VggPpwKm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD7012CD83
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966731; cv=none; b=X8gS2WKVBxj3+oWXyr5Q1Y+vsP3eLZYAKDm9wYdX/b+bx8JHMRaz/dEzi6sBiN++oCJuVRI5QlMv+DwU9Rzcm7Br7xZXDb2kuOVCe+A4Sc16NfgjLyYxLtzOvhKaUu/AmSMzqafFkSw4ecUzJBhtswLi3O3fG6gFdEmSDnktZso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966731; c=relaxed/simple;
	bh=s1KA89STndV+GcVnBDRmleZTA6QVA4y+0zSZGRVnKK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjeviXjdoDRpXewPqhYt/Ke6aMuhExcqPMlrGAAPW2Oqa7Ku6g45fYfuvEZ2LhwBI3ifQc/pTnx9DvwyxcS1T6uU6pLUWlxVqi9GBtyqkRqbeHpRKwroz+Enjb3UjYKrVIfMv9u8rapXpEOCBmaMtz9i/WQIqcaJBn+fU07SAfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=VggPpwKm; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-608ed07bdc5so13380627b3.3
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 08:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1708966728; x=1709571528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6jzW2vDs6IWlaGB4GA8QpNXRwioM02rF6pmsTdkcdFo=;
        b=VggPpwKm2vpyEfJWUdEDUxfolXAtYfOgD6bzZIecY8J6F8Ff8RgXPafv7AP8yXoKYp
         2wgtK4WCDQkgTr/qyqweXj1cMxa9AQcpSsbnfUycp3bJ6QfwQCD509xbVHXqUt9GmpZV
         tSDqiZWxr+k0qkXmqAfcwXMM23Yl7izfx+jGNqq2ha0o2tFlKyNMaaW2G439OwbeJKs2
         Sq2+P8tivLMMj8X9OrOzdWoLHE7fWX066xP6EZ+raW6Ol4nVWcZ6qIub8wbwBnjT776n
         YA62WwUbD43nzxDIFUm6OaKtGwH4yRqbqiP2NLDUPtnEeTTEKsi0WZZ9WxfOtJTIdBWM
         ZaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708966728; x=1709571528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jzW2vDs6IWlaGB4GA8QpNXRwioM02rF6pmsTdkcdFo=;
        b=AN3eIJhcKJFukw+a9tI70sLSo/92QS8RBY7jkucUbQ2yFC53x3htIkgn08cukemB/+
         LVudt/yF59diwVdnQ3dWoc2fHEakGOH8T/TG+kabaBthTYGpZpumrW/Ni93pll9eC+6+
         lCD3adpuUzCWorkhdOLFPANYocmlKIZ0sGqD05KMYQZPhhe5rgYnR1/zggAKHNPZFfbD
         0X+esGmdtAejYL1KH/ZfJ1harCxKx2XFKWTViv0IxOWd930pbTuj2VTOrlY0Hzl3DvHC
         u1SFom7i5db7T397xjNOLuL0KooND5BS44/Y4iduUs4BLCrXtBtzs9rSuBva7By1PpkD
         c5qw==
X-Gm-Message-State: AOJu0Yxaj3+6kHh1XxrGg+o52X+it2+DN0EFLF1mj9OIowFmm7XqvjfS
	1aMW5sUuOvsRCd2HcFFSphg9ww3p8XyFFfJ+dZM0Qt5Ifk2LpiHXYs/7BLgs2U0YyLphT8T6Vdf
	y
X-Google-Smtp-Source: AGHT+IExPV8vpS+yjz2MFxQIPNWhLtKDvYxlfEQIErNDnonIOqdxmky0+nENX1j7BG7ESqz7Md8n2g==
X-Received: by 2002:a81:9a41:0:b0:604:eb7f:30f4 with SMTP id r62-20020a819a41000000b00604eb7f30f4mr6306046ywg.31.1708966728087;
        Mon, 26 Feb 2024 08:58:48 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x3-20020a05620a0b4300b00787a1c74595sm2643519qkg.105.2024.02.26.08.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 08:58:47 -0800 (PST)
Date: Mon, 26 Feb 2024 11:58:46 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/2] btrfs: some fiemap fixes
Message-ID: <20240226165846.GA1390440@perftesting>
References: <cover.1708635463.git.fdmanana@suse.com>
 <cover.1708797432.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708797432.git.fdmanana@suse.com>

On Sun, Feb 25, 2024 at 07:51:23PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's a recent regression with fiemap due to a fix for a deadlock between
> fiemap and memory mapped writes when the fiemap buffer is memory mapped to
> the same file range, which leads to a race triggering a warning and making
> fiemap fail. Plus one more long standing race when using FIEMAP_FLAG_SYNC.
> Details in the change logs.
> 
> V4: Updated patch 1/2, added a lot more comments about that's going on,
>     how each case is dealt with and why, added a missing handling for
>     a delalloc case that could result in emmiting overlapping ranges.
> 
> V3: Deal with the case where offset == cache->offset which is also
>     possible if we had delalloc in the range of a hole or prealloc extent.
> 
> V2: Updated patch 1/2 to deal with the case of a hole/prealloc extent
>     with multiple delalloc ranges inside it.
> 
> Filipe Manana (2):
>   btrfs: fix race between ordered extent completion and fiemap
>   btrfs: ensure fiemap doesn't race with writes when FIEMAP_FLAG_SYNC is given
> 

Eesh sorry about that, I must have missed the other test failure when I ran my
fix through CI.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

