Return-Path: <linux-btrfs+bounces-1763-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FE383B48D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 23:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304711F221E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CB6135418;
	Wed, 24 Jan 2024 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ED/lHMUX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78727132C15
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 22:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706134502; cv=none; b=ASu/f2CS0u+StOAxJtWDJZVymTPsjqrIpRvh0N2y/rmw2nWvSL54LSP5Rz6GghipEE0Xu8q/6ysiSbuWSbZsVY6prImRNaho3p65FI9+sFV+usTmj0XYlIpMpwM8av1cN67h3n78GV/LXrYW5sXNUpjE18WnkFnGew3cDLNTDoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706134502; c=relaxed/simple;
	bh=EY0qfLTfyTZTbR11i2Ijc1kgpIZOJeifsblRUEPIflI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gz1HsHy3/OucWZdywUr5MQ1RVWzaETKnNvE2kATeYuK/wfVki6IuXGCFraq4E2yzG5ViSWE9tYV1qJWdKYdjtTVa3XWm1gJbXlltXqVDo9fiGLA34/L69nTxnBxpKqpiFAnd/qFnyAjywzc59V187BCHKzVbF+BBGEMH7pFeM/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ED/lHMUX; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5ffa694d8e5so1469277b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 14:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706134499; x=1706739299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ka6DdDfvItQVurY8/n907XIQfJ6MHwUl8Z1zhD+roD8=;
        b=ED/lHMUXgjFXG7u9K8qj+NgUQ/WDrHuin3VuN4DaJroD1eBxfb/ieo/+Vz+EOyNFqe
         tv/S7ezJCO+RLRnOQ6jYKugZgbWHTZyXNGhXyPv9pdu+AQnHtll98kC9j0q0TKWYZyoX
         dl3PXOz8KRO/hRJUnfrWpT1Q5ZAdARW2YopntX5Dcy35YX/cBWTESJhx/eE0gjkIJgh2
         7+PZMqq8G8yZ866P2gMqpj+mipni8v4jo79g3MipQnaohmsXyZudEPwZAN9hkJsv2IqK
         //iZtSE46h6z1BL7+zceWivWw2puOSyovOl5KqKjHbkyG7s+YuUO0i9yeJ6rEL71158i
         M3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706134499; x=1706739299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ka6DdDfvItQVurY8/n907XIQfJ6MHwUl8Z1zhD+roD8=;
        b=iF9OjGM901vcUt4HtURjX5amat0szASW2vD2LoL8aXhhMoeB53/QOR63M7OO4Wh1Mq
         9xwpSxR+618JWiH2eeLXVGhNvzQG9kN5NfzLUhlqeqxM69woZNPsCRsFHllNioWzBGYF
         q1CygetHxz8JELRMa+kHID/6h4QzupiHGqw65GzGDErZ+crDuzUzgU7KQqYcYcRf8nfR
         X/kxRIEfedHExsORHUx0dWcIgvbVvcdX8CA2uMC7BK/8Ms13w2fKMAgWf1yn5MMLxfXN
         NL3NB6UZGCNBgcno2evu4PlyUwCFucenCIeFuyVTADov65OE22drKwYBYa8aRvxt0hCC
         wQ2A==
X-Gm-Message-State: AOJu0YxBYoK9mQjfJG1ssYBEB/WT+94AJqAM+F9jxMBYyEH/zcAR2yuR
	yI/8JvSZCWwhi838YgqIWrilErdU9s+SyVfCv16UWeNsusPLq9a5q/6AXCZP+zyhQW2mGlyHZXR
	h
X-Google-Smtp-Source: AGHT+IGrgP9PVCwS1bPM/nSiEoKRSozEdqCK/7DLucXtM+aE8CTjnJDcKZSCEyHk2pviWWr01nseGA==
X-Received: by 2002:a05:690c:887:b0:5ff:9d48:b021 with SMTP id cd7-20020a05690c088700b005ff9d48b021mr230506ywb.19.1706134499493;
        Wed, 24 Jan 2024 14:14:59 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id r124-20020a815d82000000b005ff846d1f1dsm225241ywb.134.2024.01.24.14.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:14:59 -0800 (PST)
Date: Wed, 24 Jan 2024 17:14:58 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/20] Error handling fixes
Message-ID: <20240124221458.GB1243606@perftesting>
References: <cover.1706130791.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1706130791.git.dsterba@suse.com>

On Wed, Jan 24, 2024 at 10:17:35PM +0100, David Sterba wrote:
> Get rid of some easy BUG_ONs, there are a few groups fixing the same
> pattern. At the end there are three patches that move transaction abort
> to the right place. I have tested it on my setups only, not the CI, but
> given the type of fix we'd never hit any of them without special
> instrumentation.
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

