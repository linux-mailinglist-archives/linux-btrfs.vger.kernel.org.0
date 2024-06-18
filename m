Return-Path: <linux-btrfs+bounces-5778-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD6E90C3CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 08:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728C61C221A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 06:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B34F60B96;
	Tue, 18 Jun 2024 06:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oi4sJ/aS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B4A219F6
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 06:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718692908; cv=none; b=D0KRvQRDzRce1HHsonCBp7HPhGRglMbABwjB21UVVFZ+jttEbiUagAYfNlx5p7dqChwy4pNZ3lrWdnvHUipsUZwSDAtZ1VBm0hRpvvN6iGI7xeTodzUg8MnKJBnRsMot1Mw68ZbRcIem2B3Igjk3uaIK0KpcYByAV2kI4O6QGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718692908; c=relaxed/simple;
	bh=ZGU7g6G2sxkGfCO2TwyKxd9McInYXn25R3Ia0b4bhI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLqz9rYHF66bg1RMj9j68Iq5QJ/cDFSqEFjjQ7qiVQPl7jHSu80QrdS4XVkIinlbXbnrFufhaJEgoNeCutqwKIIKefoJPw7PdAgZ41gOEcFASPRezdZ/7akYNGWVvzDhh9hHpvQhkMS8CiAOU1B+lzkqN8BXlJD0J6ILajM1DSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oi4sJ/aS; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35f1c490c13so5531907f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 23:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718692905; x=1719297705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hjhLMzTLsZyC5AOHWdmSp7e+rFg7WCkxZNjf0rg09DY=;
        b=oi4sJ/aS1lp9HPyKbnNqa2Fg4yoFP4fjIiW2BrjNamlFZ1E35raaXNRvBYtlZ2q8HU
         byxupZvTP2QMBOnQrgNsq7UBNMRbizUAGrfWvWF5/eLEVEPL1EQxItrYbrd3kY3No1VG
         4ORFuQZmg35PO+YckdgxmNehRoHBBI661ZlTjWIE4xs4ysD4Tbdu9s1Q2iLZ1WI9Y91D
         EnDnVlVdRXx3/lPBN/CTjsiDP5jud+9iHaGZaV8zTLmQ0WBgLt8UFm2cLsUw4MFzn6//
         ZcTSHykZTPaFHbNq9HeyDjg1jMmRou5+RAzgMVxqX0tqwgthFp+u7kXP9QfZ9oEV54Va
         9Fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718692905; x=1719297705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjhLMzTLsZyC5AOHWdmSp7e+rFg7WCkxZNjf0rg09DY=;
        b=uxKe2sfzWJO3KCBRsNtULlis1IVHTOy/n/edTxqfJxKKXMRohBGowa62SWpRjmUK27
         Ony/FUYJ65jpNzDyL18S0mhWfCzxoBmqdMDEMXatrorNRg4p/MGKOaYrs1VsiPKUwED9
         +sRQhAX4MgX82HnOBzaGrNwwswxtTe2gFMSYgjvIkwSL5kgwmTp9YdOXIyxE/hYixWA9
         yXFaguhadtFPZxaFIUjFZ3f/zW0xsHIxfhMRsMjckIGKY4/7cqz+yNSFFb/M9s43GRgM
         KHNptlwI45Q/wzJ7g/qR3f+FjwLrFBlwkRyNkCfsmo1hwocelD5gqbLPFO0E1V07gtBj
         AGPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvilMvkgeuz3ibMPZSm2lTCG6GLN/qSLbIb760RHr19v4iBr4dQFAM82YHOeuQzHV/PqAT/ErQdAeaV56WGHRCnGIdhuX7WgXpdcU=
X-Gm-Message-State: AOJu0YwULwv5dfL2J/pqYoPeB1aGEQ36MnwtddS6gRQJ4GPSM9CxivxB
	XML8ERenygiBVV5njeIRGrOw0brbKlxnKLMGRq14lPVXsMhUNvD+FaQNrv8K09k=
X-Google-Smtp-Source: AGHT+IHvHWQfwaRBEke1qAKNFh2hIpH7TG/MeNOD3KCNqDbZeyCGFXF7rFT4EentVnyb89plwd8/jQ==
X-Received: by 2002:a5d:4bd0:0:b0:360:712e:3610 with SMTP id ffacd0b85a97d-3607a7687ccmr9956903f8f.38.1718692904516;
        Mon, 17 Jun 2024 23:41:44 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750acd7csm13458244f8f.52.2024.06.17.23.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 23:41:44 -0700 (PDT)
Date: Tue, 18 Jun 2024 09:41:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Shumsky <alexthreed@gmail.com>
Cc: u-boot@lists.denx.de, Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Qu Wenruo <wqu@suse.com>, Tom Rini <trini@konsulko.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fs: btrfs: fix out of bounds write
Message-ID: <5898a17d-8fcf-47ae-bdb2-c647eca9997d@moroto.mountain>
References: <20240617194947.1928008-1-alexthreed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617194947.1928008-1-alexthreed@gmail.com>

On Mon, Jun 17, 2024 at 10:49:47PM +0300, Alex Shumsky wrote:
> Fix btrfs_read/read_and_truncate_page write out of bounds of destination
> buffer. Old behavior break bootstd malloc'd buffers of exact file size.
> Previously this OOB write have not been noticed because distroboot usually
> read files into huge static memory areas.
> 
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>

Could you add a Fixes tag?

regards,
dan carpenter


