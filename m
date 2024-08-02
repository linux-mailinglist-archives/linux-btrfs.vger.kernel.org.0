Return-Path: <linux-btrfs+bounces-6962-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACEC9460E1
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 17:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DC01F22218
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 15:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD34814EC57;
	Fri,  2 Aug 2024 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="evpX67Qg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D613175D3A
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2024 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614082; cv=none; b=PU/2ct6ANYo3j4ceek+yUwd+oqHfI/GU6S1ACbFZFUOXXr6AOW7qqxeIl8m2Wdhf5uvzla7Kh5MxUNeGBlys7pz0nj6j9yp4SqURMzEa2lExZp5+bUHG0bMHuGqq9C0itvC/jJV60SOXTy+/m27HA8XNuHpzu0wMWjKcCcK3Zgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614082; c=relaxed/simple;
	bh=MDXtXCnHHFIqJ5Tw3MKoy8wRnAA4UZUwynFWHLlRinI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOGeBcIkrAtZAm5fy8C3BbKOqJ1ojfsjBY0fBXyH/n73h4JdwD3l8qyGgS13SFavdw8PaH9YcidHsRFWwSbqONci9U1Ynt5Ew0Ys1BLJa7jmCo9wd0TvKeaWA6CGy2RbCff8Rg3EW15csT2HuFvwPbNwRv6HFqmh6K+uzJDsVMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=evpX67Qg; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-66526e430e0so70416747b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Aug 2024 08:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722614080; x=1723218880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nbq9BF2sgWBBG82nWovwNNGze17FHmfsnfFZbulUZf4=;
        b=evpX67Qg6IcsC7T1d2YWfSGzODS65yF+c9yVUcAfF8oF6NA29SY1nEn6WKnii8lEK8
         RTlTacOkYzjiK3qlv3YJSb312qzEJOR/DKtlIw7I/uT8E+uTHkmaXiXdKSCr8r5STJIx
         6TmlQEVu9eLQvrFUoxaiTzRU7UTnEue78j+b0bjqEj83SjNZKU73t38Jj6QEFR8EgiCW
         nCHBTIjaxn2RcMa0elw+ZUScfxI8RiTmKGC9fdgfAsvTRz/Mm06XB/V3kmCc2jxSEfHE
         4lRjPXJVXuCx1Dl3XaAtL6B7sraJOjzOD5YMZO9KsJCL/33Kz6ikSKvtlFAHHy6uRpg3
         o8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722614080; x=1723218880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbq9BF2sgWBBG82nWovwNNGze17FHmfsnfFZbulUZf4=;
        b=oziNz9j6d8wLpVHTn8fgGedefVv+hT0XqQSy2wx2vIJKlttIGiXclJakPpgdmqIyV1
         clkPmf+wzmj7rEJog0n6+piONoE1+fV7XtjhWBQfC8xKElZcR0U25TDwwK2frFPFhfuQ
         KhQSoqlDtid7mbyDSfCIpgOdpGjHL20IANSSld+GLFe0mgNrT/OI7TYn9GPBTZeR/Krw
         M6UaZojA/zs4k3QDz4/zaEQx5swTHeuwFedDLio1D3oFSVicSzDs8pv9jAHNYSRlAqD1
         SbbvbZ+ouCuqJLVECz4weUZjTbOdLDf6S/8ZeLBOnEUnklVwKRLcxdn+DjlWn8C/acDs
         EkEA==
X-Gm-Message-State: AOJu0YymjoiiC17P5xwkrc9MipRVu0O5jTtTHXYR41+oevKhedTSOrvB
	2C0sn6eA6pqSrgg+7b04QF8XBbfs+NeOZmIAy9a9yVsOr1Nqk/kPtuzPvJH4l9k=
X-Google-Smtp-Source: AGHT+IHObZ8hARNkf40dY5DI8Fkf5Fpm+7b/hhNror/uIYmoWLHKIeklStbTZwOzccIWgPO0ms7iEA==
X-Received: by 2002:a0d:e947:0:b0:61b:1f0e:10 with SMTP id 00721157ae682-6895f9ec050mr45926557b3.4.1722614079921;
        Fri, 02 Aug 2024 08:54:39 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a12d13909sm2927317b3.75.2024.08.02.08.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 08:54:39 -0700 (PDT)
Date: Fri, 2 Aug 2024 11:54:38 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix double inode unlock for direct IO sync writes
Message-ID: <20240802155438.GA6306@perftesting>
References: <7aa71067c2946ea3a7165f26899324e0df7d772e.1722588255.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aa71067c2946ea3a7165f26899324e0df7d772e.1722588255.git.fdmanana@suse.com>

On Fri, Aug 02, 2024 at 09:44:52AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we do a direct IO sync write, at btrfs_sync_file(), and we need to skip
> inode logging or we get an error starting a transaction or an error when
> flushing delalloc, we end up unlocking the inode when we shouldn't under
> the 'out_release_extents' label.
> 
> Fix that by checking if we have to skip inode locking/unlocking under
> that label.
> 
> Reported-by: syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/000000000000dfd631061eaeb4bc@google.com/
> Fixes: 939b656bc8ab ("btrfs: fix corruption after buffer fault in during direct IO append write")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Heh I just saw this syzbot thing and came to the list to see if you fixed it,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

