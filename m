Return-Path: <linux-btrfs+bounces-8522-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE5D98F857
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 22:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A692834BB
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 20:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CD71B85DB;
	Thu,  3 Oct 2024 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="3EgjLInr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC711B85CF
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989142; cv=none; b=MOt9anvtRdWxqWGoP+0ouoosd4iAkhyA3QMsxS2O+4SipmaYWH9xWQ/DmcFIrbwydGy92qYXthGrjItl1QOkihSSw4Ly8gYD/E3saIrj/mFFnY4TB3lAaJ7OfmSb6xwRW/jrLikagESi0WLwH9tQ0hQYUkwAwZEj+ZKDchG3iX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989142; c=relaxed/simple;
	bh=I0hJoQ1R2pHWQTrO2YiCpMRzVU+NIPw0xryCiD5S6uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPrxT8VtFk+lo9nVKJGLEJGAopuhbgfWGohc4hoJJkegsJtIZE1871pNto+p4W9ZB4UZNaq1oJrn13b9PHX4mwMN7reP/RZS+tEuvo3ECXxtcKGzufuXXC28MNVIakIEZfYtKzuujuL4ewUCvLRJm5gu3IqYfrvuFNlWPsuCW0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=3EgjLInr; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4581e0ed0f2so20437091cf.1
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 13:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727989139; x=1728593939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZXaVNUtp3cv0TgMLyzMW85dnq8vyvRLsPNscaJNJ0M=;
        b=3EgjLInr9hdQGuxng1NiWszhu/HYCsho0VR2SgbJ/RrMu7v8Cwl0vpQa6wfgQ4hK92
         un2tk7/szIF9ldClxeJtSZrnPgfI3XJH/JJgScKnbrkoIX8YTMErCaOBZq7C02s5A27G
         40NlswQJZYqSbcg8tzFDrnD9iEo0OVDWYgaDWtv/oZqNRU2S/pxINw5Ig325iAHyGmVS
         9NVJQ01p+eguJsCZ3zOFE3LYjUM0Y2IlUdnU47wsIby/dg3d3Ept7bDXzRRKtk9o+9K1
         4eTUDYgWnmlaIUW5C0K7hk6MpjapKkXRccGcU+Y6XqKR9eFg6BN/e/HM3HfffRbLwKjw
         dHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989139; x=1728593939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZXaVNUtp3cv0TgMLyzMW85dnq8vyvRLsPNscaJNJ0M=;
        b=lcGq/zpkzzJtuTvxijzDO2O7/TAUiOhQiilOeEfIHs+5RZ1D4N7AbTWCYmoH18S7ax
         13zlLbYkeVMhZp/j/YrW9PRj5IvRNZorG3RR4vaKlkJ9ejxnrEHbvpeUcOuHrSaAqvC9
         IL3q87vnPAUApVf6sJCTQTHmRJJKJPPubgRSVpr97guAeCVNO9WhEkavWdwk4Vvmlad0
         UYeh8LxWPG/p22tTR952krenq874VniDRz2afZ6aOuW9hGpeyo4GYICmj8QS5wEIJW22
         k/0DzKf6tuH78JEIbeaNBM0XufQ/A2G/Off43YCNrKyJN5onDQyMOfq0M67JE/RPQ8rz
         FJHw==
X-Forwarded-Encrypted: i=1; AJvYcCV7+KbjENZu6mxV8jLn05H92mPK9DhR+88q4raYqg/eVlxItMheADGtGiJq3QCDlSsZNrbLkp/rj6FXoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpdVCWNBx3aHelkMFBrgAcdybUZimO+4UAj+u95UmfBr3OHrkH
	EQt2yvf7MT8E7zIEHCS8TnVpoH9kllpaXcoo/P9qM1z9ZOz/xb6uuFrIxol15y0=
X-Google-Smtp-Source: AGHT+IFqZ3x3cdla1H4iADfwUbzy6NusyZ9jKFzj4CVsZRkDX6hRtbokMiNISp3XuUegPDtMOl49DQ==
X-Received: by 2002:ac8:7f83:0:b0:45d:7eba:af80 with SMTP id d75a77b69052e-45d9bb1008amr8753561cf.25.1727989138824;
        Thu, 03 Oct 2024 13:58:58 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45d92e0fd0fsm8674721cf.24.2024.10.03.13.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 13:58:58 -0700 (PDT)
Date: Thu, 3 Oct 2024 16:58:53 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: [PATCH] btrfs: root memcgroup for metadata filemap_add_folio()
Message-ID: <20241003205853.GA1658449@cmpxchg.org>
References: <b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com>
 <Zvu-n6NFL8wo4cOA@infradead.org>
 <5d3f4dca-f7f3-4228-8645-ad92c7a1e5ac@gmx.com>
 <Zvz5KfmB8J90TLmO@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvz5KfmB8J90TLmO@infradead.org>

On Wed, Oct 02, 2024 at 12:41:29AM -0700, Christoph Hellwig wrote:
> > > This looks pretty ugly.  What speaks against a version of
> > > filemap_add_folio that doesn't charge the memcg?
> 
> What I'd propose is something like the patch below, plus proper
> documentation.

I like this much better as well.

> Note that this now does the uncharge on the unlocked folio in the
> error case.  From a quick look that should be fine, but someone who
> actually knows the code needs to confirm that.

That's fine. For the same reason the non-atomic __folio_clear_locked()
is fine in that case. The folio just has to be exclusive.

