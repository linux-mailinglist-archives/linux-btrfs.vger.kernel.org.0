Return-Path: <linux-btrfs+bounces-13427-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13E7A9CD6A
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 17:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0BD14C3DBD
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 15:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA7628A1CF;
	Fri, 25 Apr 2025 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="bxdLIZYt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FDE218ADE
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745595881; cv=none; b=K0XK9+XZUN4KnNLMDUwe4v2xJ0GP4CE8L8KvkUggnEd0FeF+S5k41mm5eWVkZS/VMhdD61LfxuTHhRmKswofNawsDhk68vHTKXVn72ZoEAccaACDNL/qSJwi9FmelynuOzqXdXOgL8A0+Taby4lne/RCRHrZ4UxgZKmAMGh+XbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745595881; c=relaxed/simple;
	bh=K6niAjcWrnftzFRdxzqPViozJE/Dac82pKGDHqSykHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJgxINy7Xs0HsuvLWWshcam13hn269VKWExG4xqUa3Cx9VmlbAvjAZXX2XrGTUBE4+Vl0O9mYghwNZKj5AvwigIk0doZVVjT95ZmTVQBcYrKGh8Dk9t0k10bj4qsKoR7jrTTtelQM2KHg0aeWEAo25kjz6ektUYw7MJZY7QsnOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=bxdLIZYt; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47698757053so33099471cf.0
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 08:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1745595878; x=1746200678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bTibNShvFWcLhS0Lj/n0GplKlkMTupLkHBEm1fiYNWs=;
        b=bxdLIZYtiQj+LUxCGyW68RTw0Td85pkGiO9gtsMaBpy96l5SE8DMvbUOGz+jbqKR7D
         FQwx+InVRQj8K8g8P4E3/Rcx8CJoJHX+0jICNFvhvd+DU6vfNiFDTnG+zvaj3Ga5dTvi
         47b+CpE//LfJRaE/b+c7PFbTr8sDVEJxPW/YQFlbxQA4Kk2u/KP+G79I4xoOhZ3pU+QR
         bEKs12ribpxlkoSRZYJh0bYgZPkavBmGwTPZO09MMVok5746BB9jO5vK7XNrpPTJgvDU
         lP98oJEweGw0iOgLQpJvqmUBSDeG6PpSzX6DY0lGErvKjtGxh8KaBgIk7xfiYfrv7I+Q
         5H7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745595878; x=1746200678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTibNShvFWcLhS0Lj/n0GplKlkMTupLkHBEm1fiYNWs=;
        b=lquCkijiL4d5RIyJlGq5h2X/N8ypjLVnVrZGq/+HOxmGUllxJ/+veC4H6ZzrWFB3qs
         Rh1mW6nM4KlRgaSDQVcYUVK/9+GgpiEcWn+QLXWDaWKNHgthTedW0Svhu2CXGJR65dwp
         CUzZgOFpAcNPtTXIBTtHrX9bEMQ7hp8g77etfoqVOLSA0LNwr5Bj9QvxP22887+Ot9TT
         0Fpdy5+iM8xgO3YEJBuvgn6vLvddXdofGPIIliELLLd+FunyqyGbW2S3IU0GfzdsUmUk
         c3DNAyNP9Ku+Eixvq6X2tcxwsyT7Udyz3aZqGpJMr+pvngfiXGdpKGGuxJmRN8CsORYo
         QUvA==
X-Forwarded-Encrypted: i=1; AJvYcCWwcH/pbvpE4UcnwptCNTkp0LOodtXFFNZr4jlJ1CcQCdHBHy0adSEOAONt+nUmKAvfh/ZP8GSrdgLTwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/d4fVaoYyl196AuyxBRGD5ajI/yw7eaKy6gbBwmWkbbMgII7Y
	xi7ke+yIxoXL07oItpCbozxt1HoHxsiJY1z+inhMfAc8roXE90L+nTLy578INnrXC4XcMehqynL
	m64XzKxFN
X-Gm-Gg: ASbGncvNTtj865ZI/UngrtasMMEwAEiY9cLtxlsXDuW8Ezw/n9agDpsJvE1QVBjwK3o
	t0fRlnv3GK0xTFbFb6jSKuqPjcrW9Rp6L/vbCDBD4xXKbUIvu0RwPuCUYBevIzb5nZB6hHlpjEE
	kWzS6z/5I9FKv7fJN44Mm+pyfigVZmKd52GtKw0SeMiI2N816wE3bAFAb8kEyvyY6JNVmum8bSZ
	qMOvJKOy40Gy7zA7sOs0CkkrFaBPTRvOqhKbDOJwRHmn0TdOttASncoALsxt43NwC3Axfc4VZ7F
	h4k/xGQ4xdIJmox5zaJkKUOKXyCtCLXL6Ehm0dxbJZIevSHyXKQyfMfFARG6j1b8qagNudKw4a9
	uCw==
X-Google-Smtp-Source: AGHT+IFB54oJffD/LygrRHBpNDHUkvFFygnhSwIDFKFA6DJlZskKJ3G9lJyMK/qUADFNE3jJwVbKSA==
X-Received: by 2002:ac8:5896:0:b0:476:a823:50cf with SMTP id d75a77b69052e-4801c3bb74emr47010221cf.2.1745595878138;
        Fri, 25 Apr 2025 08:44:38 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f0d21a2sm27086681cf.27.2025.04.25.08.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 08:44:37 -0700 (PDT)
Date: Fri, 25 Apr 2025 11:44:34 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v3 1/3] btrfs: convert the buffer_radix to an xarray
Message-ID: <20250425154434.GA494636@perftesting>
References: <cover.1744984487.git.josef@toxicpanda.com>
 <bb6d4199948b4822a837fd2b9716fbb660e2ada6.1744984487.git.josef@toxicpanda.com>
 <CAL3q7H4Y0r7rLbNEv-QdN7_tCHh4grh2XJez=qD2nO-DTFs4ug@mail.gmail.com>
 <20250424154719.GA311510@perftesting>
 <CAL3q7H6Nbar_o0GVGuTr5BVmCRsDUgAJfnOz-hSi5OEi86jejg@mail.gmail.com>
 <aAuPr5r1AT-uT4B5@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAuPr5r1AT-uT4B5@infradead.org>

On Fri, Apr 25, 2025 at 06:35:43AM -0700, Christoph Hellwig wrote:
> On Thu, Apr 24, 2025 at 05:07:29PM +0100, Filipe Manana wrote:
> > > Because we have to do the atomic_inc_not_zero() under the rcu_lock(), so we have
> > > have to open code the retry logic.
> > 
> > Sure, but xa_load() can still be called while we are under the rcu
> > read section, can't it?
> 
> Yes, and that's the usual pattern.  The double rcu critical section
> still irks me, but willy correctly says that it can't really matter
> for performance given how cheap it is.
> 

This was my concern as well, but it looks like only me and hch are annoyed by
it, so I'll fix it to just have the double locking.  Thanks,

Josef

