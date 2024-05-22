Return-Path: <linux-btrfs+bounces-5211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D42A8CC400
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 17:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183202808DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C147CF39;
	Wed, 22 May 2024 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="iy5JIqvn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E93A824BF
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716391212; cv=none; b=pyp0fvd4uWU9rerhTQYgB06hTBj99ZvTCIX+OFVtBZ7WPBdtvt9dYkEDnzxaJhVFdLMEKZCBU2agg9734HAD4xo9PMfNI2diGerP6kzxt+uAp71nFrz9Mhhl8I7StxF3bA/m4GS1VfiMxPqwqRhkLl2xTRpSZDSsPsUAY9PUqH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716391212; c=relaxed/simple;
	bh=tc1QmlSRkSOsQIXBkAIkk+DpaMHPOmRRl6O6piLjwq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txA+D7cDSLzqJ/dCQRaGBOJw2TkY5D6H0zYHAUbcgs3RpQQnffMzrXTOHWtdoMPO+gFspGVTa7cIOjVKv1UvpwjtmqY6oOvtDj4cU/W1XSkeZ5AmpuHS4uUQNtREOignCiC5nm5HtF4fmxxvdfH2f3m3xN1nXgHlFGdv1k6Fzg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=iy5JIqvn; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43e06d21a06so8209891cf.3
        for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 08:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1716391209; x=1716996009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0BiCqQY3J0lZ2TmTrc3WRs78oxNRbQa/SgzQ60EOQgg=;
        b=iy5JIqvnMzVxML3Zx1+dvQWf4zlvYM380YWYveAflXV25ja2eLgeF7GSgcbzMC1NAW
         9qhG1z/DxoEfs0Wx2rRpRzAH22t4493f3XiD4pRiY9MISEeWlVbillUqQKE2q4u9cEpv
         mXVnVLS0e18O4ru8zHJ3JBoNGUYjjJR+i17V8O0SOlAiwfia35zoNpkR3Hm9RmSTcxc8
         vReYWUVDkNpWutqmhby5Mgf34wzCOu6EBhrO8M6OZuu23wqr4ycAD9rlIXJ1B6XKXa7R
         HZqPL5j+Hy8pZuzW/s9hXCtTxE7z6j1bwFmy9FF7e6RNa1uLgKC8Yd31VCNfVKNJtkpK
         O+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716391209; x=1716996009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BiCqQY3J0lZ2TmTrc3WRs78oxNRbQa/SgzQ60EOQgg=;
        b=iP1QB+typ7uDxnQ3GDlHSVbOy5lgBBVwZYOuO5uRvcJ1ZKoz3D9LEmQ9wSAomIRNz6
         nzrMjosNqP8veMVhKyo4oQj3We9JIg5GUjDBI4PiPf/DWZbfrUg66PEGJ7VDENDe6zqy
         4uDF0qJH5lqQOvm1MBrD9EphFpmcvd35lou6HAVOzvF+58LLr2nqczaSLqpYpn65GtxD
         yhFxN52PLb/cx9e0oLWFlHnweOs7GtWATHwVggXf2HqdOVpbgcYWq/V7xSOannuALTwT
         lmj5LU4YzVeN+6IVdVrhooBTa2rCr0wpOMeA8G6hVAALjAwOAAuU3ZtQYYu0VgouK88p
         DAfg==
X-Gm-Message-State: AOJu0Yzz3Rbia9wjiBPFYsYQ0BQHJKNZ2W28t6Xt0RvGyax9aU9e0oiZ
	7PKzaL2f5pJcUEM88EXh0XqEtFnPs0bX6haoq5MsHpnTGLguj5RfiGlfjNUjzQg=
X-Google-Smtp-Source: AGHT+IEbTRnZCFAFs3cT+tapikMhVx7jZhzikTDlZo9AIfmIUL1e9+g55zV9DY1gYMIj6TmIH316lg==
X-Received: by 2002:a05:622a:134e:b0:43e:e6e:21d7 with SMTP id d75a77b69052e-43f9e0c36bbmr22739601cf.26.1716391208899;
        Wed, 22 May 2024 08:20:08 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e2e4e1419sm105318001cf.51.2024.05.22.08.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 08:20:08 -0700 (PDT)
Date: Wed, 22 May 2024 11:20:07 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: move fiemap code from extent_io.c to inode.c
Message-ID: <20240522152007.GA1403601@perftesting>
References: <b686d5a9dbccf9fbfafc5d805bdf463083c1544c.1716388860.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b686d5a9dbccf9fbfafc5d805bdf463083c1544c.1716388860.git.fdmanana@suse.com>

On Wed, May 22, 2024 at 03:43:58PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently the core of the fiemap code lives in extent_io.c, which does
> not make any sense because it's not related to extent IO at all (and it
> was not as well before the big rewrite of fiemap I did some time ago).
> 
> Fiemap is an inode operation and its entry point is defined at inode.c,
> where it really belongs. So move all the fiemap code from extent_io.c
> into inode.c. This is a simple move without any other changes, only
> extent_fiemap() is made static after being moved to inode.c and its
> prototype declaration removed from extent_io.h.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Yes please,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

