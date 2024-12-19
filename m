Return-Path: <linux-btrfs+bounces-10609-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D6D9F7DB9
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 16:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1CF18845C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 15:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80480225784;
	Thu, 19 Dec 2024 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NfwU175g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337BB225788
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734621065; cv=none; b=SCVPz/QQe4N2T3Fa4B/LYTMOLslGu3wQl3qEDJacV8hANAIT6G+vm4ER2Py/aLsKlz8EXjb2XKwxFvymVY7GdDMX6grlzmHo3tvzm7P105uJGi3SHg9YEZTkpEUzaRSrml9Nop3rSkCobjWNHRlbtpuiemC4bQgcuQSTvN1EQP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734621065; c=relaxed/simple;
	bh=zxUwCM5sVQtWZUAPNomSOSSJKwXbR7V6Cjxc3p7Fj7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7JZwzC0FqEV48K5/V5CieOgQ1YYRPwIg0JUit6GcdCzYJjyRP7obXP6moWMMxdOZOHQ6O5hUBQyIpqn2abpzRPne9EB41XFn51Er76SKWpM879SEYZqMGXkVoVYi5n0w4G3grk6NiuCUjhi8sFv76FCtdi/ME/MXxrprtIAWUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NfwU175g; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa67333f7d2so152978166b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 07:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734621060; x=1735225860; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a8c0Ewl7BQkquEtJaiXqSJPyhaxk2Iz2kiqNEhnfoII=;
        b=NfwU175gEIgdOZJ93lMl60l1daXk25xWVwL+HEeLnt+w6hutwqe03oiaz8JV5DL/nL
         jqs3JZfSCpNrryc00/Fio8GstOq1DSwJIyTCRD+XPiH2X3qVU7zWC1/VLKJpOdKYG8dQ
         3K3KtGwHfvZLSJdRumCNGPkL5U3qSYPTpZgP/SGShbHKNHuWoXE5ZZGSkSmzmgK+j9IJ
         bJwPnVuniggnV94qH01D3L7SxX2WmEvce8QfSLR6xtxvZ72MkgvZKBRUTMHEFRGEEHqO
         OhWWQM4KfjUe3jfgfKMShrWFjLGDpRqOT4Sx6QwGRcDGPCCx0ZI0Qwmc4DL90WEjx41Y
         /EQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734621060; x=1735225860;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8c0Ewl7BQkquEtJaiXqSJPyhaxk2Iz2kiqNEhnfoII=;
        b=g+oR3OIHVkyQ8wimYOS8c30CsMrnvGe14DLL1K9H6xvxU1xBjj4nPfF13vN2W6GZM/
         cJ3OGAEehrsmz9GBrO3Nvv3aZQ0+CX83WXD50oLpBXMXIR+Y6scvceqfb/8stdwdKxXG
         4sf1wLhkstZny3OnMSsxNnKQzxIFDqoPeyQs2XRZloY/PbDnx6MTgTh5TEK9fv4C2yb1
         hDZ04UPhX1ef2vGh/cShUzZh0MJ1jqYg6o88AX1pjhGlvWZg1i8XBEaBjkwxS1/607sc
         RgjIjqH1WdG+4KFqM91oxWokdD+ddfrj8f7Mj5sAwAheRMeWP8xrTiwdLhUY4M9DwO/C
         TqoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwv3uQWgE59F9f0DGtA+acEDBDt3sa0sjRHQFDwjjWeDWU4zrZ+eJVGcCm0XanKyBynN2ZFoyh0g+guA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGSk+PvbfgrilWKCOA4lvXACgO79T36Tz8HnXzoqyhRjZupBW1
	EsDf/WfSK7nnoqk3Ze2HeWvwuEhRdFAoP7pwP5jX353lYiFvgZORiGbKKp0S4kU=
X-Gm-Gg: ASbGncskSKp0zz4DJ1Cr4Ktxdg3UYZJ3ssUohEVL8y3TpJsRDNbCK04bpiRbFcYRdT5
	YJjNJSXaEyKNNw1iuuChqAWOk01rxNzdTkaILvCi7G17IZ6AT8nW3TRJlnIT7ITTA6pgZhmZhD4
	gyE4WtEG9iIBx1uEpCDArbXS5eVkFmFF4QbpXbTeCGsupPYQyZ0+ZisDcWJL5rTN3LQqbqqd0hG
	D4eswZgTv8HZ9m+n7jMbJ+xtuU/NJ7TdKRR1Poj+4A9NbTsOnzXe1HnccEImA==
X-Google-Smtp-Source: AGHT+IEpIUPQqVgupeRzlOrpnAifiL/wITich3F10TXkppCOZb1lR3IE5oC8DUkcXCbnI2ox83X/9w==
X-Received: by 2002:a17:906:3092:b0:aa6:b5e0:8c59 with SMTP id a640c23a62f3a-aabf47f6a50mr576895266b.35.1734621060458;
        Thu, 19 Dec 2024 07:11:00 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e8301bdsm74864266b.31.2024.12.19.07.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 07:10:59 -0800 (PST)
Date: Thu, 19 Dec 2024 18:10:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, qemu-devel@nongnu.org,
	open list <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
	Linux btrfs <linux-btrfs@vger.kernel.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: qemu-arm64: CONFIG_ARM64_64K_PAGES=y kernel crash on qemu-arm64
 with Linux next-20241210 and above
Message-ID: <a3406049-7ab5-45b9-80bf-46f73ef73a4f@stanley.mountain>
References: <CA+G9fYvf0YQw4EY4gsHdQ1gCtSgQLPYo8RGnkbo=_XnAe7ORhw@mail.gmail.com>
 <CA+G9fYv7_fMKOxA8DB8aUnsDjQ9TX8OQtHVRcRQkFGqdD0vjNQ@mail.gmail.com>
 <ac1e1168-d3af-43c5-9df7-4ef5a1dbd698@gmx.com>
 <feecfdc2-4df6-47cf-8f96-5044858dc881@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <feecfdc2-4df6-47cf-8f96-5044858dc881@gmx.com>

On Thu, Dec 19, 2024 at 10:44:12AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/12/19 06:37, Qu Wenruo 写道:
> > 
> > 
> > 在 2024/12/19 02:22, Naresh Kamboju 写道:
> > > On Wed, 18 Dec 2024 at 17:33, Naresh Kamboju
> > > <naresh.kamboju@linaro.org> wrote:
> > > > 
> > > > The following kernel crash noticed on qemu-arm64 while running the
> > > > Linux next-20241210 tag (to next-20241218) kernel built with
> > > >   - CONFIG_ARM64_64K_PAGES=y
> > > >   - CONFIG_ARM64_16K_PAGES=y
> > > > and running LTP smoke tests.
> > > > 
> > > > First seen on Linux next-20241210.
> > > >    Good: next-20241209
> > > >    Bad:  next-20241210 and next-20241218
> > > > 
> > > > qemu-arm64: 9.1.2
> > > > 
> > > > Anyone noticed this ?
> > > > 
> > > 
> > > Anders bisected this reported regression and found,
> > > # first bad commit:
> > >    [9c1d66793b6faa00106ae4c866359578bfc012d2]
> > >    btrfs: validate system chunk array at btrfs_validate_super()
> > 
> > Weird, I run daily fstests with 64K page sized aarch64 VM.
> > 
> > But never hit a crash on this.
> > 
> > And the original crash call trace only points back to ext4, not btrfs.
> > 

Yeah.  But it's in the memory allocator so it looks like memory
corruption.  After the ext4 crash then random other stuff starts
crashing as well when it allocates memory.

> > Mind to test it with KASAN enabled?
> 

Anders is going to try that later and report back.

> Another thing is, how do you enable both 16K and 64K page size at the
> same time?
> 
> The Kconfig should only select one page size IIRC.

Right.  We tested 4k, 16k and 64k.  4k pages worked.

> 
> And for the bisection, does it focus on the test failure or the crash?
> 

The crash.

regards,
dan carpenter


