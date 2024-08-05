Return-Path: <linux-btrfs+bounces-6993-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69939948178
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 20:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDEDAB22854
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1810115F3F8;
	Mon,  5 Aug 2024 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULrlOSin"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1A5770F5
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2024 18:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722881787; cv=none; b=f3kFw5K5FXWIQ3CE6xzH+wdWOUCG0QrJml9j+iCVy3JG1u3G6QyTFuulKy8gZSANP/ES+/BAnX6ZBiwW0FeMP287RYKq4B7aPqbo165IxW7mXWCRkJqJay5KxIPCfwzZf7nmZL3Xqt7FsZjbEd3BsqI4kCaan8sFAl2mcKvhmak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722881787; c=relaxed/simple;
	bh=m/pQ15fdgZQY6d3TpYyPDSTK8BmYx/AM5y33c3guv84=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C1Sp42JwDCQK3ewLwWQlm1tjQ3ilLEgP6YJC3xzadTM/G7BIqG4ku3bJ4EShdLFrdcixcCfFjv/isbzra6mHsL5Zpldrxm/UYGeEWcSKGUyabMngl81ljsE3pCZqdlScfmVJt00X0m4cjzi8OW69jntYYMneG39oP8dveAFWg7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULrlOSin; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efc89dbedso12846260e87.3
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Aug 2024 11:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722881783; x=1723486583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:mime-version:date:message-id:sender:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7IPDbgw5WXD+z/UBkOPLPM6q/MiQZjCgU7H4KOdYD4A=;
        b=ULrlOSinpqaI07nbLyRG6xUHcz92z2D0HvCyjLdk/ju/UcEiokKhfHEJ7se6P5NjzW
         nTkdOrlLUzQsnIlb5Fhyu7t84L6B7Z4k8WBOPCuhGgc+F9zMw+gdhpKKYf8XTGsa20ME
         nknmL0htz3zC9xl52FNuImhiDZOYB73IHM0pGvJ1C7TV66h5KkAZ+iUK5HfQ1WQl86ro
         8R/+3DkRwDqV9w/OXrkfHovvuk/sQi4KD71uZ6xj9Iqfd3vsPzfHzvKV2hfJ7UC50ewv
         xB7/N6unlXEGVkEmlB408j4fL0BnVSCp8uHcZl7OnYKT8V+P2y2m54OSltN1c68TriLY
         3dvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722881783; x=1723486583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7IPDbgw5WXD+z/UBkOPLPM6q/MiQZjCgU7H4KOdYD4A=;
        b=WhhxdTaXALs3SfttFg4ENdlz0rjuUeFpFEHrZ3EgJwJilwCME7ilrepqNpCEWIO1mD
         TMiLO4gr/rHlcbHPYxG9YUznQp1+a3RN8TnX/bG0aQZqWO13rBhKqH2L+YYMOfpw2zpE
         uiNDVsX34iEVlNcSsgh2wIhTVcLmupZUCwC+Sz/vDb+t+pFXYncXGS9u7Yrr0c+twnXI
         E2SWfhpLw1fkVbewsDRx5X88AlX/ZqD5p9YAMd0xfxlTq7CpxELMcE9z0I/wYVjJo/Vz
         g3Y3nH3lkwqcinWeQvzqpG31q3IHKCgFEK2GZUuRBlK0tfzzrWmWEQ7x7ZjCUonCSMpE
         zdGA==
X-Forwarded-Encrypted: i=1; AJvYcCX5iEA0Wkp8chTHOFDasoDEKa53ZXGIRHikiluOEyNqUZi/oUyueC5LRW9d6iv7kDFDYXlgRNTzo/WKQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhfVKEnR8CZjGozAjlQ/j84XWs5+HcTF5bt4xuv74hmCw7pUra
	N3vCYPG0igycNfP77mKG9/K6hU1DpuEpaz9+3DvNu5sX9ZqSSupw
X-Google-Smtp-Source: AGHT+IHlqRkJwtJAB/iGjMgENveeXOojjCRxHcpAxYyO/GjvB7PNE9y6lInr/0wDu+la4XD8VvE7aQ==
X-Received: by 2002:a05:6512:398a:b0:530:ba4b:f65d with SMTP id 2adb3069b0e04-530bb3814abmr8290041e87.28.1722881782211;
        Mon, 05 Aug 2024 11:16:22 -0700 (PDT)
Received: from 127.0.0.1 ([94.41.86.134])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba07e90sm1225842e87.55.2024.08.05.11.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 11:16:21 -0700 (PDT)
Sender: <irecca.kun@gmail.com>
Message-ID: <90dab7d5-0ab8-48fe-8993-f821aa8a0db8@gmail.com>
Date: Mon, 5 Aug 2024 18:16:21 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: 'btrfs filesystem defragment' makes files explode in size,
 especially fallocated ones
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <d190ad2e-26d5-4113-ab43-f39010b3896e@gmail.com>
 <7a85ea4e-814f-4940-bd3e-13299197530f@gmx.com>
Content-Language: en-US
From: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
In-Reply-To: <7a85ea4e-814f-4940-bd3e-13299197530f@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/24 22:19, Qu Wenruo wrote:
> Mind to dump the filemap output (xfs_io -c "fiemap -v") before and after the defrag?
> 
> Thanks,
> Qu

Sure.

# compsize mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
Processed 1 file, 1 regular extents (1 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      224M         224M         224M
none       100%      224M         224M         224M

# xfs_io -c "fiemap -v" mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst:
  EXT: FILE-OFFSET      BLOCK-RANGE           TOTAL FLAGS
    0: [0..460303]:     545974648..546434951 460304   0x1

# btrfs filesystem defragment -t 1G mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst

# compsize mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
Processed 1 file, 8 regular extents (8 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      420M         420M         224M
none       100%      420M         420M         224M

# xfs_io -c "fiemap -v" mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst:
  EXT: FILE-OFFSET      BLOCK-RANGE           TOTAL FLAGS
    0: [0..511]:        15754800..15755311      512   0x0
    1: [512..2559]:     22070192..22072239     2048   0x0
    2: [2560..6655]:    22632216..22636311     4096   0x0
    3: [6656..14335]:   22072240..22079919     7680   0x0
    4: [14336..385023]: 546434952..546805639 370688   0x0
    5: [385024..400383]: 44592672..44608031    15360   0x0
    6: [400384..460303]: 546375032..546434951  59920   0x1


