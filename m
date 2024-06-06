Return-Path: <linux-btrfs+bounces-5506-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DB28FF30E
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 18:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A38291B7A
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 16:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27A8198E84;
	Thu,  6 Jun 2024 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Y+UiuEJa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9206A17BC9
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692932; cv=none; b=sAw/IyoTUcxbDMfvFB/BO0tSrzskpv/cYeY6QnYZGLBaP9Rcb77Qdinj4j/jOBiECV29Cy5jqpvyXsbEzuZFLAD+RzL8ACn+gmhykn+rZXwYMsC/Vbh1ov5Q4XpdfcGGO6rijcFBdaJlsRhNjXKymGZY7MTdsg0XsMVmujebVuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692932; c=relaxed/simple;
	bh=KTrUqKBUpH0Mm1aODNcIi8wBFSmZg+Y2PeTVu9TDt5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4qsKtDEP8k4DVNCs1fTg+8r/PhUQ/pBnAPiJS1tv2ubvDXjuDoyZZ7oHjPr5/qAE08D0fHfHe3u7KpAbqkAY1fvs9RLdBmxv8gIIWaB3jzwvBN/H3ktW304s70DL82LQV6OGxzY2B3rGz+vd1WeYKESxympMe1ItEVpnpl3cKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Y+UiuEJa; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-80ac54220ceso353405241.3
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jun 2024 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717692928; x=1718297728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xUPZxIInBjcxKQlBtN09Qd7ziC4/bG6TE0zIAPn/5Rk=;
        b=Y+UiuEJaCYFaEToMP+XPr3WruoQ4Eoywa2E9lk4QIF16otloJun4HgQlUhYJkyd5uI
         5wdGFCMV4mf+mW+/8RwwFe3Y8t35wJv1BOKMK1AW/Ck1mCSnjUAEJfDEuLfHYjexsZjs
         t28cm2xR22WmMXlmNM1HvRkzm+HenAmf7NuAb0QtZSCTB9CF8CFQLvnBQxVQ72f0tIyV
         OENPau/TbMWiSCqUoe6Jh2mBB0FjsHz5u/RUSgv4zwruGD5PQgdCvsYUkYqx19s8BwR3
         ANZICZFS8xIPVbxKrBB3h2nkXjLy3HJC6ft/EkGF9v9cX87egvRNZXogXc8n3Xp1mSYb
         cToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717692928; x=1718297728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUPZxIInBjcxKQlBtN09Qd7ziC4/bG6TE0zIAPn/5Rk=;
        b=Fgb86H9lTGh6AHFL0Fg2zIkp40f7NB7pz7KZrxyRpOpiZdmDNIAF0DEjjrtNvcRBkM
         hvTRAbnmJ2VjwpPv8G/moDbyJDp4gQVwc9v7LEc0aSvvRyzALUq1czbwjJVkiBqVlLQY
         qasj71bscOA9fjbpoqD+tRAhwhddXJf5UhZdGAjWGiELKHauatDpT8Kh60w/ZqgWuq1/
         MBI/zihKP1jdEJDtjdOJK8b4BFpGB5PHaW4KXecav9tTzQUKDE05S3zuKHzkv8zbDmgz
         ou7EtKT8js5+i8BeJRaI6vnUIydn1ezxW7tsUrSePTYA3KRr+JU1IwS06UEOO9B/h1Po
         GigQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhDHLtg6sOTo0yUPkA1+wOjtxUfwjD1wX9XmFvjNqgB5F3i+4rSIHk0Bh2gzqhTHt3ovve9R1q+1F7Tp4FZp9482PFgZQre7XqHS8=
X-Gm-Message-State: AOJu0YzfmcplDJdu3sHBMbM0oc3OKV1ya4d/JNSsjJPCAx4AJUC6serg
	OdBfyuw8meOdubuxLiG6S68xex3d3rC7OFN0uqVKKkJumauFu+0N4xuQ6fxS9Gk=
X-Google-Smtp-Source: AGHT+IGBx3EHtBbeQj5AhyQMHzXZnYKlgnkwCjKTZpsx3juTah/BT8rtvkai98tYmjAh+9vzT2aVhg==
X-Received: by 2002:a67:e316:0:b0:48b:9bf8:9d3d with SMTP id ada2fe7eead31-48c0493d5d4mr6413320137.22.1717692928437;
        Thu, 06 Jun 2024 09:55:28 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795331d37f4sm76383285a.121.2024.06.06.09.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:55:28 -0700 (PDT)
Date: Thu, 6 Jun 2024 12:55:27 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 6/6] btrfs: pass reloc_control to
 setup_relocation_extent_mapping
Message-ID: <20240606165527.GD2529118@perftesting>
References: <20240606-reloc-cleanups-v2-0-5172a6926f62@kernel.org>
 <20240606-reloc-cleanups-v2-6-5172a6926f62@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-reloc-cleanups-v2-6-5172a6926f62@kernel.org>

On Thu, Jun 06, 2024 at 10:35:04AM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> All parameters passed into setup_relocation_extent_mapping() can be
> derived from 'struct reloc_control', so only pass in a 'struct
> reloc_control'.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

