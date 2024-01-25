Return-Path: <linux-btrfs+bounces-1809-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F8983CDE4
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 21:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 735D3B261BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 20:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BB61386BB;
	Thu, 25 Jan 2024 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="gXvrI1k4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E57C1339BD
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 20:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216237; cv=none; b=S6G1+a0V7uKDZJMcy35I6KC9YLglwm5gNT3Hxby/CN7E5rljly2r+5+fddHwDKsv68zO/EEIQRjXTnKYnbHY41Be994uTxODRr5HdCBdpr0rDDtYWkP1o4H5lcSiWj223t2iAwymBVAS4Ft50njc/8AOROv9lOH78AC+YE05EUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216237; c=relaxed/simple;
	bh=uhbz7SSQ4QJi/rOAYhv+a1XF2JWyZlehBYkY4HwY7O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDk7rp6mf/X3hB19Ra+fiBNXjofX+9c4cIIQylK7Ftm9Hq1JWj2hJIRKxh2g+/47h2ULXOWSN4J+Ay9itRpiSkEnbGC4vAQ6wib3KK3533rNS7U2TgyFCZmn4WMAUyh+oNhIFpzRDVMoVCZ3Hexr7YA7lrKoCoQisLkQqKvHPhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=gXvrI1k4; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ff7ec8772dso1494147b3.0
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 12:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706216235; x=1706821035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D9MVIrErY233YzqZQ/7zbticT/uY+20ZfUt8PaByiYE=;
        b=gXvrI1k4Kcf3QuHQxAnoWfl5RJaFEXs7e9VhcpjD7vtzOf38qRI06viR2NYRoALQG7
         JWh146OKknhq+okrGf95SFdmWUDaX2iaBCU6Q9cWorppkyVle76++sUxtZhzl0+naVgu
         dj5zlRXL6AoFpe/2HWucKYkarFL8esRxd72LUGnKvQ16ZKUoiVa7KjiFMp5D+c6sxsci
         JebeCsvdSb9NCfEo8NrBa5hBw/g2oQL6Hcy1qQTuUJloxBUkk+DlPlhl/rOKp7KKBoBv
         Jq0nvcwi5Mu9+rY2av/EHvyZ8HzISh71ZKAXKWJgpb8qcBTQMjQjcwPayQzRvaPpQIZT
         jSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706216235; x=1706821035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9MVIrErY233YzqZQ/7zbticT/uY+20ZfUt8PaByiYE=;
        b=I7HVG5eE607Dw+L9yh2amWWcCeVzWzUlS802kwSvNaxOIRr8pMHeEbJcFEhqw/Mx45
         1IyHWOQj75f0LTv+Kwk+S2QO5w9csA5iViHiKEApOHkhSoyuIWyf0toKIDu5Mf0/TdwG
         VOl6cysl9Aw8avJx7hli52uIGN+XUCf+uEBubPcm9vN+bXKXgGS8qEVTfj7UOk9oKRYO
         LDbgXgB8VdlPfRm93nExkc8G7f54J98vtyr9X+Eel5f1fCMNnmcEsv8rBfHzMHsruUfI
         zqVload6fzHE3j2NiyH1pcf3uUyAcCzYq8g5Mg6tucoQ7SNyeAtO9M9ltKGOx0UY0bLR
         HU4A==
X-Gm-Message-State: AOJu0YzjX5090IZmgQb4TE2yG/Od7MLwwkbSsSVPBk+0OwNzToH41K5i
	nLw2PfpT/AkRzKkvjaKDMr+Yia2yeMv9hQOq/lmAfjDqcjCvCe97uu6c5g1hRAs9QNCcFl37klH
	I
X-Google-Smtp-Source: AGHT+IHbW/6+Yobqgeh8WLjn9ibOuIKiqf9a4i10lK/kQPUrU0f6usgRrRP1nwQuXXVlf83rJSsesA==
X-Received: by 2002:a81:5296:0:b0:5f8:d50a:e6c7 with SMTP id g144-20020a815296000000b005f8d50ae6c7mr432387ywb.46.1706216234955;
        Thu, 25 Jan 2024 12:57:14 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i5-20020a815405000000b005de8c10f283sm891455ywb.102.2024.01.25.12.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:57:14 -0800 (PST)
Date: Thu, 25 Jan 2024 15:57:13 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs: some fixes around unused block deletion
Message-ID: <20240125205713.GB1509928@perftesting>
References: <cover.1706177914.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1706177914.git.fdmanana@suse.com>

On Thu, Jan 25, 2024 at 10:26:23AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> These fix a couple issues regarding block group deletion, either deleting
> an unused block group when it shouldn't be deleted due to outstanding
> reservations relying on the block group, or unused block groups never
> getting deleted since they were created due to pessimistic space
> reservation and ended up never being used. More details on the change
> logs of each patch.
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

