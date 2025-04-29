Return-Path: <linux-btrfs+bounces-13487-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC03AA03FF
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 09:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3417B4959
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 07:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF97275843;
	Tue, 29 Apr 2025 06:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5onSNP4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6BC27510D
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745909831; cv=none; b=cxz3AYH0KntpcRkxH996wfwB3G9CbtlOoKxkJgORopL4YJbmUlbJnqYXtD9CaCJGLw53RiUbpMtNi8a/xqXbAXuUsBrb0p0hYOV2Iersz4MIaEThAXzivnxHhYZ7L/cPMaX4VChFNgLWUGcF4LvWnkrMXwqj9tiIBBJyftCsNq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745909831; c=relaxed/simple;
	bh=7FJMJWbZyUceukFZ6GagnLKJi2z27PptiVkckthgshs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChHY8VJ1MlFuzKB+gqd9FC9GaqcTg7BLn0N+Zaats9EWKGTO8DaspW4TyEV2OfHpFItq81dMboFDYevlTe/K0EkO3ENX4JqsK4SNpO6jWp190pSryUnLRGxVuAsTycyldSJ9xuvvOQkwNsx6ltEV5QSNuHV14EQZWqHXuYAc4mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5onSNP4; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b078bb16607so625858a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 23:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745909829; x=1746514629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nR98NJIH3wsCirjMXoDkIluBdjSKRCvuqlFvW8/pupo=;
        b=C5onSNP4SQDX6nCoRwYzWLEZDxXVqgHkaCxhpmxTM4KfyY5E00CAnr+xPa76qDVpDp
         +q/oTxlf6kxgkHyvNoFX7jJ7RAMTTkQ5g4aQIlEPFgNjBXfbsTMpfpOqvo7JvbsxK9RA
         bAS3ENbNUaxsvERRlIbPI1cukr5annQk5SkXHBBdZo/OjP9vEvSAHFeoRxfnwvaHOSqy
         lUAxU1wfZA/QKPa9YRGPpzI8no2+Glaxx35ur5LnhnOO38fr0BLMDegj3WubhvaSfAdC
         B4hnZD3tJhIu9NxWc4udQ2ZrR5X652qWgVwvIhd/i3uBUsw7daHp7JZn/z5gFMGTuMNb
         E4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745909829; x=1746514629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nR98NJIH3wsCirjMXoDkIluBdjSKRCvuqlFvW8/pupo=;
        b=inQt1qd4/Hl1ih+TFAx9ViTKPxozCdag7TUwEJwW/DeWp/icTkG82Mv7q1P4rEcDeI
         NGXEzFRtzFPXDCkQFGMvm6BsgsoYdgqaIJwVNmmA0fCZKFlLZLknG5dYKgDBdQWU34I7
         46xd9/D7qKvk4Lxhz3F3z72+x3HtockN9RygH5ezDs/fmJBZqMG3xcXZnO6Ep1r3HQB3
         D3nKRX2U1oV8jyBqVwF54hDFxR2c/2QIDvkSJLGzSwEGUtDg9kJt6tcuiiC0UV74bOqy
         Va9h/Vj01XZ9NANufBZCIku9gkb0My12SZ8lQlGuecikP9pUsKGAU+AUs0+5vgdTs9Ya
         s7Pg==
X-Gm-Message-State: AOJu0YzGFu8qs3M0u8uuc55yp1xE4ipWy7wgZp36+T/P8bh7uwCJsWgJ
	T7EuLgggbAvJVgBUH8WAUzkhRwjMyM3dDMcguFpjCBAlBQSV7/zp9JorLUvdmi0=
X-Gm-Gg: ASbGncstsLJ5WKpHly/ULhfb2RF767h8PhWqCJ10fBRxgef5Faag/Oarc//eDLozBJZ
	keEbQ8n1AjrN+GsWKV44Fex2U7rBlyHYz/c1rsRreEXWxwzl6FScwGkCP7ytpTRhNeuBdA0oarN
	oMXDMj4A9e4xlN0KvJg1iTGwHWb5dzynaIaMKPLyy9ddRoWP/NGS1znXQm0cz52B9fdLuw5teSz
	KbrG78Yv17DBM6GSYeZfieLHjecd3Et4nDgqO1H/V0J1nYTyQIynBVf9TzVK+iLyKcWRabiY5sy
	rGlPI4DqXNcowyABhYHHO9eb7tUnpD7mcu1cxr0pL+EQhAv1f78=
X-Google-Smtp-Source: AGHT+IHokJxeX4aZ7LA2lpHLXMc/2iPRVKOeWE+AtCpRIoKFExphC9j9LMR3ICLa1cy6hzP+Qy4mHA==
X-Received: by 2002:a17:90b:3841:b0:306:b593:4551 with SMTP id 98e67ed59e1d1-30a220e00d6mr1258088a91.6.1745909829061;
        Mon, 28 Apr 2025 23:57:09 -0700 (PDT)
Received: from saltykitkat.localnet ([113.9.223.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f7765c88sm8507914a91.28.2025.04.28.23.57.07
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 23:57:08 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Subject:
 Re: [PATCH v2] btrfs: fix nonzero lowest level handling in
 btrfs_search_forward()
Date: Tue, 29 Apr 2025 14:57:02 +0800
Message-ID: <4649867.LvFx2qVVIh@saltykitkat>
In-Reply-To: <20250422125807.30218-1-sunk67188@gmail.com>
References: <20250422125807.30218-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi maintainers and community,

I'd like to request some feedback on this issue.

Is this behavior not considered a bug, or does it require further work?

Given that this issue never seems to be triggered in the current code base,
perhaps we could consider cleaning up and removing the lowest_level related 
logic altogether?




