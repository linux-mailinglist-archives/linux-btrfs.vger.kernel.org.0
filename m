Return-Path: <linux-btrfs+bounces-13248-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974CBA971BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 17:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CD617F759
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E3D28FFE9;
	Tue, 22 Apr 2025 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="iAoGAWE8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DBE19ABB6
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337406; cv=none; b=XzCfPW8XDb+IomwafIA6MyVkDNTkAC9zhVLvjFOI2YKcsoBG8c4ihOjOAe3t5twYMPrbbvUsBleMHZgwyPOC64EK39obqZtPB3WseYqF7eqv/G4Nhe6baBtgK3gO0C5SFoQLD97y8qjukY+8qMPfVaLQlU9I3zI/BJZrdJ6Tjug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337406; c=relaxed/simple;
	bh=YzbW6YmwLGxAGAwTfuFxnztEoc9iq66tR3gHscveKYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXPSWxrktgfudzELTJnN8/K+ODMldnatqrO4hRZ0SQQQyDaTCXn1iJvVwl9gJVACT+bRXmkVOttg9bW62ex+94ZIoIXtrSKyMu5NU/zi7ZNGR3xr27LPU/cWZ9vr5I0uO8CeehebRhkuPdLeiI2betmqeAruNDbV/tBaUy31EDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=iAoGAWE8; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e461015fbd4so4361654276.2
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1745337404; x=1745942204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ud0elHOnGc7hP9hnXKYDw9mCfGJKR0aC5uZ6ImIK2S0=;
        b=iAoGAWE8lNloIU9hl8Ncnm/5fR5NLd/6uELd/MWp6ydgE+Ct/6oGEM5UnbzSpD3e0z
         baLMCR50P3IfS7Img3OuiqQhH/5vicmDL0hg0gCGUtrQvqiJutnyewxLg/iNudGdSTPR
         AUDeKLHVYrVTH0ad2a7zPN9SG96KABTXDlunIdujm8BlE6snvqWnz7vb/dfGhh4aCyrm
         2tVdX+MEaozGW9s2JwdQB/GtzHtZSNVaMMZ5GJLr8gQPjHoref88d0z4HxsVXVZhe7Dl
         u8eZh4ZbWyy4S809acLdAceFUy+hsU9wd12/ZLDlF2Oey6zndl3GRHQ/CFC4henlXHWz
         qzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745337404; x=1745942204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ud0elHOnGc7hP9hnXKYDw9mCfGJKR0aC5uZ6ImIK2S0=;
        b=OeSGzzRFkZBNyyyuY5Xar+1RYXuEJVH7yo4OJKEDZGE0U2S7VfQN8Cahb2IYCqrsD0
         j9aR22FKzUQzZBwSt+TgAewCIxJr9he0LyO0bYCESb2KqfnKeRRSk1WZX50YX05REM7S
         f/qES8wUmYwjC9WQrBxVNjd0k4yEONl1pnt42+muGzjsUBiNJ8zmyAIeEqtjPNDTVnll
         GXR+wsr4/6qti6W1fImkUSNj/T7S8kMj6RpxqQTGtlIqzneUNDi+UkK1YDWG+Ikjqeiz
         /Wqd5e6pidY0I+u5XqJHZni+cIwwyjUvEA+lvSwGSVgGOe+cUaLbQndDiDbUob3XHiWG
         865A==
X-Forwarded-Encrypted: i=1; AJvYcCUJJ24DUyFipWmoEANUIk+0pKBgMCSFInlrcHXM9R0VO4NGjF2e/ICQHD42ufoaXZzsp5bPWlQoKCx1eA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5dBFr5upcv7roG39Y1mx7KeZIi/Y3d1UpwrZRAJjnI6vNAjdH
	YsXTTQLiQlnrdgWEPTZDiyr1n+u896nffEy0tsGAAc/74Xl8IHbg1jixjfZJ228=
X-Gm-Gg: ASbGnctxyNIUpKLqgjX8I+/pSiq4rHXRSWUiQIArpYuiVzNuwflclMCuhCvNb6vB3Vo
	DbeS2a3/zFE1SWQ7TZwq6Tht9GMGy9FmSU/dclyGV4s+syiP1Vcm7mSfhVjrZyBK0AAzHGLP6rd
	B1YP+8NVQh83dmAo7Eoxumn7DO8lXQ53jw1XVTVA70W8PlQI9xxGddPqLzKISrRbjrfuk9KHPIr
	x+ljSa/Hwo/k9g0UZYKzlCZzmn0Z2tE/z7SJnI0nwFPooYhMGqsSpNT5798/bHOWLxeJ7YuriP/
	oufS9CiAa8aG6d7Xk/XkNuRCyW0LMnQdxNs2J3juHDhJf+qMB2FlqtR1DvF9hT3Os+/17bN0etr
	FPA==
X-Google-Smtp-Source: AGHT+IEVuPY/rK8JO2Vk49NdcNgfrjqZx5Fv7Hn4PhE64NkJ4mffngGAbhnWdxGX8THzU67W/mWEGw==
X-Received: by 2002:a05:6902:4484:b0:e72:b231:7b6d with SMTP id 3f1490d57ef6-e72b2317c4dmr12766694276.34.1745337403998;
        Tue, 22 Apr 2025 08:56:43 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e72959e0fd5sm2440290276.55.2025.04.22.08.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 08:56:43 -0700 (PDT)
Date: Tue, 22 Apr 2025 11:56:42 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: common/btrfs: add _ prefix to temp fsid helper
 functions
Message-ID: <20250422153220.GA258462@perftesting>
References: <6097a2fd8b587ccc5982106142421f472861e949.1744892813.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6097a2fd8b587ccc5982106142421f472861e949.1744892813.git.anand.jain@oracle.com>

On Thu, Apr 17, 2025 at 08:27:22PM +0800, Anand Jain wrote:
> Just adding a _ prefix to the two temp fsid helper functions and
> a rename in common/btrfs to keep the coding style consistent.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

