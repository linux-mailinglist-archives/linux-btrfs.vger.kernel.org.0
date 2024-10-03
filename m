Return-Path: <linux-btrfs+bounces-8511-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B3C98F4DA
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 19:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383511F237FD
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 17:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7345C1A76C4;
	Thu,  3 Oct 2024 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="eQ0ANPeT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1D31A7250
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975364; cv=none; b=PPlDJ4luaYWCn6bLHJ5yLNEsfSuDUFtaicHVzXm4b16ribzBPCdXyU5ccy37lYP9ezjFeopn6/qn89jWY2hm5xOMZErigCFuUuf8bL8H9rWLGhvS583qb/XgDyl9AojH1vQoiLdXkp/2KflaPsmss5BjzZM7ECvR1m538RKn2Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975364; c=relaxed/simple;
	bh=veZob2f6f+jF2aoHyYukXoVPX5HhWe0/4HygDAWChU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fACPns2rLnShOYb8V1eGO188v63phUUU1vVoghpxUpv70q5f3HCokJI0+H8nOyEr1HwyDhRDSkATflmQTnigDYJ/khP5KZS9bMVCy/YXHvT31BI3znlWQTm9I+98K1IFT2uSGVofD2OlnD/EH57QfEAME16guaYyZPdv8HecUPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=eQ0ANPeT; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a99fdf2e1aso144842585a.2
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 10:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727975362; x=1728580162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lv6+V5DD1q+EbvJERytZupM7GavIklndcKQm84ak25U=;
        b=eQ0ANPeTYr8J7l35leuTWmevYYkn3K9uaDc2xiHwiHkiLe3SJ+5kibIXt7agq4PFDA
         JQeUfRsW08ZF3ba3BvlcmILg9PRosdgOwcoWZ610B9g29P9PX8fWgVVh9fqSJrT88H/P
         JqNHnzjsVMK8ESNdiSz1gSOgah2yixAcfEi5aXNaUFOBKEKyBJwaFtjtZCoSuHMHpLoY
         dzU2ZZ0ItUGWtzbdHoDRBlvR8C0YHbuhPLB81Is+wNq9pgJ08W/T017eQLZ7VGm3fG8z
         wuUzmqxV6scwPswbdeJUiaSFdUZYanVxkelJwG+RVL3CIF/01tKvZL0HKohFo0pr2syG
         wg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727975362; x=1728580162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lv6+V5DD1q+EbvJERytZupM7GavIklndcKQm84ak25U=;
        b=DenqzehHih9T2cUXX7GAPZolc6XbxXaWKqeQK3kKevXaB9LoISM0/uVCe2sogSAHj2
         aL9mXbZTatxCK8jXh1uJJuLwgdQKgg4XuFlsxT3IPAouG+rYCawsROAMcmZ22jxVHxd7
         lYmDwLG4PJKMyPNoRB5uftMx5ysayeQ9imu0JLfmANacELbxCEcIlzz0VET470tcUU/C
         ySc1GzT0ThlGny8FO3ciPRx8tpexDP/KkEFO7M3sQO6Uwvg0Qua2pPfbSJP5rRahxi7W
         z1PGtEnZTFzGMn3ikw17f2QLTNSBSQqIMXvpVm3teLBhHc+SX6Sq+5sTAyskY6vbifge
         WeCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFI+vhJN4WJKYrZ9PGXfVxiOaYASYzmS3zBO27lHABX7QSTLmUS7jMglkBC6ozWuJq+9kWYHH7umyuFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxP60I9bd1kCS21LKqXy+63wJowy5axEHnEni5CnfBhjWoiSata
	I1d8DBobcyyKkIExmcHbNMJoUUCgLxUc1BgQUrWsdJdEDWgVJl3NWwCOszM5XUw=
X-Google-Smtp-Source: AGHT+IEkPpCAXCAtA9gfAP3eyJpKVnJ4NiXCYXXWlVAcJ8PH9XCm1z/O2+YTyJX5Rf/ppniNPbZCyg==
X-Received: by 2002:a05:6214:5547:b0:6cb:3d8c:994a with SMTP id 6a1803df08f44-6cb81a955femr111164996d6.32.1727975361783;
        Thu, 03 Oct 2024 10:09:21 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb937f478fsm8082636d6.121.2024.10.03.10.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:09:20 -0700 (PDT)
Date: Thu, 3 Oct 2024 13:09:19 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/6] btrfs: Switch from using the private_2 flag to
 owner_2
Message-ID: <20241003170919.GA1652670@perftesting>
References: <20241002040111.1023018-1-willy@infradead.org>
 <20241002040111.1023018-5-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002040111.1023018-5-willy@infradead.org>

On Wed, Oct 02, 2024 at 05:01:06AM +0100, Matthew Wilcox (Oracle) wrote:
> We are close to removing the private_2 flag, so switch btrfs to using
> owner_2 for its ordered flag.  This is mostly used by buffer head
> filesystems, so btrfs can use it because it doesn't use buffer heads.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

