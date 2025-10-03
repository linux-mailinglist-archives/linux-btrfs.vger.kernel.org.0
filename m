Return-Path: <linux-btrfs+bounces-17377-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B66BB67E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 03 Oct 2025 12:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5805A4202D6
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Oct 2025 10:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BA52EAD05;
	Fri,  3 Oct 2025 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rtaRcaeV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9582DC797
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Oct 2025 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759488833; cv=none; b=ZJIke6DpiQYiWb4xgzxRcP6hrzJ2OKAmhgk64xP2YAsq8FjZxxKzFlGzkPTyBaHWgwXHuMOTMijz4SpHmbBaqfnasCxSbuBGWoL+rkjbhO1LiMtWTeVbl15UYbyBQGd9PG2i3n5y9GaXdIZu7995vNZ6MVbfbD2E7jldnSVPnGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759488833; c=relaxed/simple;
	bh=UFcz23HgBO5hzJco7gPQTmR+kMORHGddodDKDlaocds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ms8j39DOHh080WOmEdjmXZqEFAPVz0VIq1n7V+F02+2TIaSFCHew9koOlbxfMSHQ3DNL6BnbJ7lep+LbRSHUjzRjSCL0TaiIEGgaM2ItP8LyzDsYjKYYGf9ePXls1Ynyijwfr5QDwJ7XpRuqTn/hFQvp6mbHj20v/HKfMipSY5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rtaRcaeV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso15188345e9.0
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Oct 2025 03:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759488830; x=1760093630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Jq1nFX8ssmKPjRdYEcACdaY/2lxp/Z6xx9OphjWlEk=;
        b=rtaRcaeV6ekO1duxXfQ2GIG7F9kv9GUUBRe/0e5h/tdwOiqZDqj403WnzfBC4rHbhn
         QZ38xII/5XhNJKh7speEEJmVzrYbphM2TAc3XWszPvSNpc17TMq+D/HsaVO8WerspSL5
         tl+eGfg+krqxPiIzwcU1gftADzo99jshl2YdKxFFa8/uOWF0kaLQBCymKSFcLEN7F4yK
         GKsVx+dofGG6s1UzT9Od4tXlorgLIfLr0tQpp68260eFPcAkoZhp5oMqillOMtfeUJke
         QiZdapIkXbwZlprLZYd9qQeGfWn+QQmnLwCpBlSyPvEgtCDsjQjQTmwJ7yvnhm2PzG+b
         LfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759488830; x=1760093630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Jq1nFX8ssmKPjRdYEcACdaY/2lxp/Z6xx9OphjWlEk=;
        b=rjxkxVSqr5b5mrqSVHsuwV3bPqy4J3W3v5YnaNDkTS8yYxqiSpkR8opPJh6dpfYqmj
         eKrnAn+Gh4DsAo1S3YXnGAETYPERrJh6ux8PLTAEHYdQSQUoUkC9tziqKvFRkMgzHZml
         WMW965gIvp6WP+kH1jK3lnA6OpIjohSqhwX3tQcVfE3zABbZ1iRzImh0bHpvnjIaknYi
         mUs0bWpZgoo2ysc146M/cNsqgLVSeqKHSd5yLBBFupmwAuQWR2X4jpnh9QhLqVrra/rp
         8fDpc0EwYEjBF0lghop4Hk34Bp7oupA9NTAkH4Ox5wWYPv7Amp0HP5iZPw9Q5Ia4RR5K
         iHUw==
X-Forwarded-Encrypted: i=1; AJvYcCVefEWS8IvJOr5XY7pWkmJ6BcgECAF0I5s5gPlj407cyclUMNIigZXOFLGh6z3rNgRXbzsKi5YoTlRo2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+eTRU1fNMXuh1/BxyWwgXfstjSNuXqUT9xeEmgrjwtQt4jwGb
	JZzV7+CjiYZdI9+y7UA1cONMWjZDg92Vw2ww7GSJ2g/YKDQXBBHBgd7RIrzxreRLSwM=
X-Gm-Gg: ASbGncsujTNasmV9HnE7JVxYsnUPf1hhA8pq0xSY9gx7+wR/fq14r0ZePwvoeh5VwQ9
	UUsuWD8N0g07scPT9LETgMLVgXWW4zDVqoWvSnEnolQ1yIms5RxEsTFKMmh2XTjsIo+bf+IBhmd
	BgBAXjSHf/qSgLRuX6RL3MbK2OKLfTwdaAMtuHNftIy08IKI8mNYLg7NdmTTRYxEzKNJufwyC1m
	SHnF98GN7VMMvhix/lGXz+qF6SQ4lflGB5kaMMho2ne/p/3gbMdAWm6Y1BCsdxCD1Av+e3KPkLX
	dAIM8DgFaviHoiE2aj41bJYk0Vpgo7HpbglLJi0K69LgptwaB5oVkyP2+xqphtKlR2x2FgYJqP6
	tyT/pKw7HgcDS3pk1y71xnHQ1CFlXBLaTyl9Y1At4SdfgbR9lC22HmXTUQfL7pntqz1c=
X-Google-Smtp-Source: AGHT+IFKI8vo6YXEW6ISLFO/Qw8pm8IzIzu23bQ7h92y6EJ7m/68WLpBHtBfd+86xhRULF05lq2UJA==
X-Received: by 2002:a05:600c:4f08:b0:46d:d949:daba with SMTP id 5b1f17b1804b1-46e7608b683mr4836045e9.4.1759488829930;
        Fri, 03 Oct 2025 03:53:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8f017esm7511774f8f.47.2025.10.03.03.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 03:53:49 -0700 (PDT)
Date: Fri, 3 Oct 2025 13:53:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: oe-kbuild@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/4] btrfs: make btrfs_repair_io_failure() handle bs > ps
 cases without large folios
Message-ID: <aN-rOq9boL0hXZ3R@stanley.mountain>
References: <202510030550.mqFoO0Dw-lkp@intel.com>
 <234df03b-e6fc-44c8-a28f-aa51305d87a0@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <234df03b-e6fc-44c8-a28f-aa51305d87a0@gmx.com>

On Fri, Oct 03, 2025 at 06:47:11PM +0930, Qu Wenruo wrote:
> > cc53bd2085c8fa David Sterba      2025-09-17  885  	if (unlikely(!smap.dev->bdev ||
> > cc53bd2085c8fa David Sterba      2025-09-17  886  		     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &smap.dev->dev_state))) {
> > bacf60e5158629 Christoph Hellwig 2022-11-15  887  		ret = -EIO;
> > bacf60e5158629 Christoph Hellwig 2022-11-15  888  		goto out_counter_dec;
> > bacf60e5158629 Christoph Hellwig 2022-11-15  889  	}
> > bacf60e5158629 Christoph Hellwig 2022-11-15  890
> > 2d65a91734a195 Qu Wenruo         2025-10-01  891  	bio = bio_alloc(smap.dev->bdev, nr_steps, REQ_OP_WRITE | REQ_SYNC, GFP_NOFS);
> > 2d65a91734a195 Qu Wenruo         2025-10-01  892  	/* Backed by fs_bio_set, shouldn't fail. */
> > 2d65a91734a195 Qu Wenruo         2025-10-01  893  	ASSERT(bio);
> > 2d65a91734a195 Qu Wenruo         2025-10-01 @894  	bio->bi_iter.bi_sector = smap.physical >> SECTOR_SHIFT;
> 
> I have no idea how to make smatch happy.

I would just delete the unnecessary NULL check, but an equally valid
thing is to just ignore the warning.  In the kernel, all old warnings
are false positives.  I'm never aiming for being completely free from
static checker warnings because that means we have to be less ambitious
about what we check for.

regards,
dan carpenter



