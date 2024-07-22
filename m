Return-Path: <linux-btrfs+bounces-6637-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7F2938A22
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 09:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1457B21039
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 07:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D4013D512;
	Mon, 22 Jul 2024 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N1XcTg8q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDD245023
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633698; cv=none; b=rhivLZtPBiKUHh60tDu5zr6Wse6NVD6Jn+KGA7fHkjo+ci2251dTa5QxNJTW/Y0nKCxChhDtT4TEYyoWp9z36oOnON14dMzG8JUHfx0lbhAHxcmD8Rr7MT20vqWTUvWeMxk3roZ3qKA0vxltfA/IYwHSJR+Fwnz+QIZet/0ViQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633698; c=relaxed/simple;
	bh=5I00kJ1IC/ju/fEuCiFmfghY0goYro6giF/Jc1eniek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fy1h/tUxF/TMC//elU72p58ywLHrnzV1DIlYQz5sqt066+2BBOl9Mb/qKXAON5vF4g19kLl18RE6dlv7smfLKNXeZgJ0aywRIMb4hKAPyYLsHPrIfMHv2ybUJfX7HmJ0ZwYNZwjOajfjgTljExsSYB/3xG9HQCw1Er8G4ilFGXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N1XcTg8q; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77b60cafecso411072066b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 00:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721633695; x=1722238495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LsvUE0o57OouoC7fjzRG0Fp0z7u/TQO/RaOGGl1k+XY=;
        b=N1XcTg8qKqLxBPl4sQSqBCCgBTTU5kbnOqQQaNlfv97AGdCdT9bVj4CHWghoOlRql8
         OXgwuxOTvQm5b8yykLh21aeLTM+2JEJIar0/8bjcHwvcuSiA9X+/g431rMa1EtSXIYl2
         wkR1/znkHM4e5cu9JEAPSX646W2OfWw4AhDCUy062WTpqn94stONf+nKNOEgmDvH4HO6
         XkK6x/w/bNeFNzAjzG0L9nK6baMCS6IxrVFjdAMRRPikxEMLGt/+5c1vVQDGI0RjRU1t
         jH5m1RnDN+Jv/ywJxNUhD7XIVqkxDJNalHEPu+iKB12VZ+XmOMdWw1OJoshaKNpm5DyL
         Ydjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721633695; x=1722238495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsvUE0o57OouoC7fjzRG0Fp0z7u/TQO/RaOGGl1k+XY=;
        b=O3uHKpG/yR58XZUkCBuQ9Ofk9Iks9CQ/C3TP8ECxViByEMp/V1MZebcMf/VYesLaMI
         /19ubKZiDZnghYG5IwBrdYdI7mP1aMm120OeMmDzwCUBe7ME6axqtBIxAmNrgsm7CC6g
         OXaMR4w1ljcxyjgGkAZWQZYqPMNeeshMIuegFc/DJ/ioiTMSFNwCndqIA7i19SSZekDB
         G8+mXNYy0ENJnsm760zQM+mWF71swbDbVv9uXlKcIQJ8+qyOUBQHnmYp8syW+rp7m3ms
         HPB0BHB4PttjOCGjbeFEdXvGLcpl1d9+RoH8JlIRTPaP/rSo99DxzsqniHH+3olLTOE3
         9+/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPP0D8IC+ASQ8CcJf2xl9RqoLDzzgNNbO2d66e7QPrJ1bq5izuDIXZVT6dWQ7EmPSZoJ1N8JSfbIID2Tc2NetBhVIOdsGY7DGXwz0=
X-Gm-Message-State: AOJu0YxwZve4qcgu0yHYp33hORY0TO2uhecWqRiRRO2LjO8Vhr1uD9TZ
	VHTj3r+TgdjwVnPU1ZPGwNm+xjDzS+SOI/Eizz0mgBMQTJfogHYgKR+MA/BJCD0=
X-Google-Smtp-Source: AGHT+IEmWXROwHA87dq+wBT3GDAicPjakH0kJc74UbfmBRFfMAtxkJmSTHsiP8RgLPulsbfgFkyeVQ==
X-Received: by 2002:a17:906:c142:b0:a77:dd5c:d7f4 with SMTP id a640c23a62f3a-a7a4bf39ab2mr351235466b.15.1721633694678;
        Mon, 22 Jul 2024 00:34:54 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c91e052sm384748366b.153.2024.07.22.00.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 00:34:54 -0700 (PDT)
Date: Mon, 22 Jul 2024 09:34:53 +0200
From: Michal Hocko <mhocko@suse.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v7 2/3] btrfs: always uses root memcgroup for
 filemap_add_folio()
Message-ID: <Zp4LnZS3MSqzM08J@tiehlicka>
References: <cover.1721384771.git.wqu@suse.com>
 <6a9ba2c8e70c7b5c4316404612f281a031f847da.1721384771.git.wqu@suse.com>
 <20240719170206.GA3242034@cmpxchg.org>
 <Zpqs0HdfPCy2hfDh@tiehlicka>
 <9202429f-e933-4212-a513-e065ba02517a@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9202429f-e933-4212-a513-e065ba02517a@gmx.com>

On Sat 20-07-24 07:41:19, Qu Wenruo wrote:
[...]
> So according to the trend, I'm pretty sure VFS people will reject such
> new interface just to skip accounting.

I would just give it a try with your usecase described. If this is a
nogo then the root cgroup workaround is still available.

> Thus the GFP_NO_ACCOUNT solution looks more feasible.

So we have GFP_ACCOUNT to opt in for accounting and now we should be
adding GFP_NO_ACCOUNT to override it? This doesn't sound like a good use
of gfp flags (which we do not have infinitely) and it is also quite
confusing TBH.
-- 
Michal Hocko
SUSE Labs

