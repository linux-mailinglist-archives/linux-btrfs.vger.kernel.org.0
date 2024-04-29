Return-Path: <linux-btrfs+bounces-4619-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 980DC8B5AA3
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0941F225E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC4B7580B;
	Mon, 29 Apr 2024 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="UX7II4Yu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C6F745C3
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399008; cv=none; b=PxAmAevN/Ta45wA/DBQ8Pks2+uTgriYagX89WwSQqJ2VLjTz681dmX43LhojM+nRXt21sIYg0UM3zv4wJ/DRYUmVZOlxaPqIrKzbtazORVTe34bqQeCYMRpqYuNw6CUihnwt8GDIPPl172PAUGjx88hlAPH+44EtGKmHsTWOxww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399008; c=relaxed/simple;
	bh=920U7DhlCUqfILbwgxP5ucHFht1rUv0oUKZBQeo6VjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnPYGxwI2KjCiNVZkD+mFF137lNIhNuko+yH5UQ3ct9g+ORFYZ2KT+DADtAR/xTgN+OuV+mblss/DUUtXD2IOXF+sIRPXpYgBpGaTd3CAlsuSgalDIhj9OOMyhkdIeIxEK8uk/xdv6IfNVQEY6Ks2/RI2+IKcWrdpcUQd/Xg6Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=UX7II4Yu; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ac90ad396dso2557620eaf.3
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 06:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1714399006; x=1715003806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01lzr/lJoBv5oeL/0n6BTxidXs2hC7B3SVPcnUULo6Q=;
        b=UX7II4YuOOj1K8GuVk1GP6p7nUgH3JjbiwuP+KiFC1LA9Z7a9fWUOg9OMtdhKY6zi0
         9jjlT59lytMlnjM94ax5sDz+Rl7uSTxDgamhGw7SocNuivIIugOx43iZeLIZ2DhiiWzt
         QbWqBnBMfR0jVNUFDi4dcn40SpaSN3YytblB56RSDFuFCbjQChs/q3IKQ8SN3BQd26+Q
         6kdGqFsebFe7oizShjA8fZbGwKsELip336ITj2sUrQMsjV+zk2ML8/KIPl71bOpSRBdP
         zeAKaAum20S5nGswB3/MJ5bsHeJqbqhrmGrmXKXIVq72qSlBc46BAjpRG3kzt7zPPt/E
         z6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714399006; x=1715003806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01lzr/lJoBv5oeL/0n6BTxidXs2hC7B3SVPcnUULo6Q=;
        b=ujze03ZJSDzYKBQji2x9rT/5atYNrxBlQP9VZ6oK1jhrNcvRV6d50mmWHPhCe+AntP
         y7pXKVb8efjK1eacBT15+9zLmrFastYGCuR67qHVDmJQqNMrNJwlRoJ8uTbY09Ycuyeq
         0CgpaeRjDBJHVEFaOrGICpkhKA5XyfNtxqRRaXO77vDdrxeoc0dEEFZ6PR9FyQfaubnt
         5RuG7JR72kUQX392FU3Bq7vr4TAyF36qfnQjRhyPd0dR2SkTyH/SVtprwIhsqis2NiKk
         nUlEg/7rA6MYbG+RYdy3mpcUrEynaX1CPlKxZ/uJTF6YHciPzhqa59gC8L7buTph2W6E
         tIZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcR6AUfgXN9+6koOdAuUaGazns8iPYeMz/2G3dAVGB5xRK3mK2i7r50OMjpv1ZRckYHcNtLCSrq2UO3RPGW+Jg3w84UDMZmaG+GCw=
X-Gm-Message-State: AOJu0YyzlP3TLKPqqgeDGn9fj0N7kK2dmM0+aFfuv7NwnQIl5AjoKiS1
	JMzY0ycZRoXlhKsvmawF1RY1dQdPFxKcV4MXTpRDyKM3oiaYmr1AAyeGoXuJTCM=
X-Google-Smtp-Source: AGHT+IHFswP9YLF7kJvji6Bbbwogyc9U87rpzzJb7rOAbKzxBNSwQGoVCVl1Xu5B202uCqgqohN8xQ==
X-Received: by 2002:a05:6358:3913:b0:18b:9051:3cc with SMTP id y19-20020a056358391300b0018b905103ccmr10614669rwd.17.1714399006341;
        Mon, 29 Apr 2024 06:56:46 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id k4-20020a056214024400b006a0d057073bsm800256qvt.58.2024.04.29.06.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:56:45 -0700 (PDT)
Date: Mon, 29 Apr 2024 09:56:45 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: clm@fb.com, dsterba@suse.com, herbert@gondor.apana.org.au,
	linux-btrfs@vger.kernel.org, linux-crypto@vger.kernel.org,
	qat-linux@intel.com, embg@meta.com, cyan@meta.com,
	brian.will@intel.com, weigang.li@intel.com
Subject: Re: [RFC PATCH 6/6] btrfs: zlib: add support for zlib-deflate
 through acomp
Message-ID: <20240429135645.GA3288472@perftesting>
References: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
 <20240426110941.5456-7-giovanni.cabiddu@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426110941.5456-7-giovanni.cabiddu@intel.com>

On Fri, Apr 26, 2024 at 11:54:29AM +0100, Giovanni Cabiddu wrote:
> From: Weigang Li <weigang.li@intel.com>
> 
> Add support for zlib compression and decompression through the acomp
> APIs.
> Input pages are added to an sg-list and sent to acomp in one request.
> Since acomp is asynchronous, the thread is put to sleep and then the CPU
> is freed up. Once compression is done, the acomp callback is triggered
> and the thread is woke up.
> 
> This patch doesn't change the BTRFS disk format, this means that files
> compressed by hardware engines can be de-compressed by the zlib software
> library, and vice versa.
> 
> Limitations:
>   * The implementation tries always to use an acomp even if only
>     zlib-deflate-scomp is present
>   * Acomp does not provide a way to support compression levels

That's a non-starter.  We can't just lie to the user about the compression level
that is being used.  If the user just does "-o compress=zlib" then you need to
update btrfs_compress_set_level() to figure out the compression level that acomp
is going to use and set that appropriately, so we can report to the user what is
actually being used.

Additionally if a user specifies a compression level you need to make sure we
don't do acomp if it doesn't match what acomp is going to do.

Finally, for the normal code review, there's a bunch of things that need to be
fixed up before I take a closer look

- We don't use pr_(), we have btrfs specific printk helpers, please use those.
- We do 1 variable per line, fix up the variable declarations in your functions.

Thanks,

Josef

