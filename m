Return-Path: <linux-btrfs+bounces-53-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 396E77E5F1C
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 21:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96358281658
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 20:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA5337179;
	Wed,  8 Nov 2023 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="BbC9HjwQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D00D30FAF
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 20:25:53 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A04213A
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 12:25:52 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7789cc5c8ccso13212785a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Nov 2023 12:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699475152; x=1700079952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jK1nJO3A2bdbcDtSiZJ/FINWoUSICdNOK+5Z8W44+94=;
        b=BbC9HjwQaAVk9OOyefV64MqE3CXM2OKa/EYeIoB4Ddz7qDPssDQkBXkdpMe3DgdUMe
         DUQ7QX0/01T2dMsCKd1sGD0DdLkI6oy4h8NF8/8JRCA/AIzjiwCMnTkg4+mQhIwii4lJ
         9RRgHkJBkS/9CODuA+dprCwWZ8rd6ckh+uQPBNGWCTMTkrXb4MbiJtalpCpHYoFOIeBd
         HqS3pi3CBe4Rue5ikiGnrcZr3RkOMAI6/RT8k5Ff4Hpc5YtOsvoIiZrOWybaTGk7cflJ
         DX3vgcAL/XeynWmixdrBx3+eizZ95gS6S2w1gsBpfsV8PsGusjHV6wZp5HWXBUK2gYIQ
         cKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699475152; x=1700079952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK1nJO3A2bdbcDtSiZJ/FINWoUSICdNOK+5Z8W44+94=;
        b=WpVn5SnpNRMMLWFqetzsbOkZFauoSdf8kmkrtyGBmdkCwOcBzQX/vVW6kKgLN3kYqR
         YyU4wwMzGweQXcyAq+OEBQxAh05dZogjadXmEXolZ5RVj+HHDSn7I+oKmj7ZOozbE9eZ
         rPU6J+m8GqZejK7YFamapqXPMcGiTh21eZWyBjqCIWZN44SX9jT8/2aR48hxhfwM6X1T
         +ep9vle08a98cg76W1WX1ps6l2rTsGFSL2l1bQ7hWsjZ6ZF9mtRw3fOmQhu1tykcvIwy
         9+7vB2lFjxTYak/txiZNir6q+Q9viORvQedQ8TbQv9Qpb9OIvWcQhFywSLfMJ0r22J04
         oYNA==
X-Gm-Message-State: AOJu0Yz//kuvjYGx05P/A8WncLXZmSN2AsjDwtpp6XZjPUz6y1BVMMlj
	8WgnsfGZSmoZJaKXMMAz71p17YHhYnldsGETmNH9+Q==
X-Google-Smtp-Source: AGHT+IEIJIogXASMFwyMazJN0/00lMzSLQnx6+b8+pjRO0r+W1pyhri4FzCdaCazZdXs5hi6d9s/xQ==
X-Received: by 2002:a05:620a:40c6:b0:775:92ac:a3d6 with SMTP id g6-20020a05620a40c600b0077592aca3d6mr4285567qko.14.1699475151873;
        Wed, 08 Nov 2023 12:25:51 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id vq25-20020a05620a559900b007756c0853a5sm1395858qkn.58.2023.11.08.12.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 12:25:51 -0800 (PST)
Date: Wed, 8 Nov 2023 15:25:50 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/12] fstests: split generic/580 into two tests
Message-ID: <20231108202550.GA548237@perftesting>
References: <cover.1696969376.git.josef@toxicpanda.com>
 <ecf95cca70aa11c64455893ea823ec8de0249cf5.1696969376.git.josef@toxicpanda.com>
 <7cba2927-5636-4039-9e76-f01a5b86c108@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cba2927-5636-4039-9e76-f01a5b86c108@oracle.com>

On Thu, Nov 02, 2023 at 07:42:50PM +0800, Anand Jain wrote:
> On 10/11/23 04:26, Josef Bacik wrote:
> > generic/580 tests both v1 and v2 encryption policies, however btrfs only
> > supports v2 policies.  Split this into two tests so that we can get the
> > v2 coverage for btrfs.
> 
> Instead of duplicating the test cases for v1 and v2 encryption policies,
> can we check the supported version and run them accordingly within a
> single test case?
> 
> The same applies 10 and 11/12 patches as well.

This will be awkward for file systems that support both, hence the split.  I
don't love suddenly generating a bunch of new tests, but this seems like the
better option since btrfs is the only file system that only supports v2, and
everybody else supports everything.  Thanks,

Josef

