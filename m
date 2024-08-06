Return-Path: <linux-btrfs+bounces-7001-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352B4948D6D
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 13:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47C61F21A6A
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 11:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7E71C232B;
	Tue,  6 Aug 2024 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7+d3oo0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E2143C4B
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722942362; cv=none; b=m4Wg1i3Sy1Q5yK9F7xxmUeEoupjhSMyn4hbXTTtyGVgi4R9DeTquMiH+mZcKB17OPr2gDQNvqWwdf/qPg7O9A6vP4OvcLmNnTrsxi495VS/VHPK3jnG552lrGG+GFH1nTCwgqDSdsCEzX4xHnmR1LwlgrBs9CER8dxJgzrjvmNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722942362; c=relaxed/simple;
	bh=GpdkBybw5bULQyceTGVy/qN6ZnYjY5xaiYik72shuNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WRvcMbwKn1MDimU8erjcO26imlNfYfLs5QoVtSiv9oPJ9ZSxIwmfJKrwlFMeNc2hAuQqwLskc8o9BSPKeskxqEaXYZCd/bEIDjTuk20QqLbzYIRSGMPR7QAjkZ5k05I0FRc/STPKYCr1vu+xpAzLDddGwh8s5YE99J3BgKRD6Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7+d3oo0; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52efdf02d13so800695e87.2
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2024 04:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722942359; x=1723547159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:mime-version:date:message-id:sender:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eFjfLcoKvlAz+bpZr7J2UBx9WM5tpdjA1iEf1BUvNJU=;
        b=L7+d3oo0bATlswHD1auYEGirVjLowG6bNM49ToEy17JPMlexX+eNh+RDImPC7oQSiW
         qSpygAkJBwBY5NlDuhAl8wOsR2G1/Sn58aEwBMdrKR/tXKfyHG9Cg/QSDbj2SkgYKhVT
         iyAC28QdvOo/eao0oH2haCGbt+q5ObJ1S/xYn8TvNznyl/5ufX2bwj3LK61KFOHifOxj
         x7T7A3F/br71Qq51VXZKJY4oorAftE+Bh5wm0mJLwTZ2/YFHsW3jBXUc+lh3k4l/XMDT
         +j26qJjJ9HG+YcV2tW9qn/pJKVIrJ6k5IZUJyAbVJCcKppy3TwFEgxbRLCUkSoJqiQll
         YjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722942359; x=1723547159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eFjfLcoKvlAz+bpZr7J2UBx9WM5tpdjA1iEf1BUvNJU=;
        b=rX81EysiwdcIfEA4qx6qpli+g4JSHbzdHKlU845d1hLz/a9iIdz0VnwzbZQNu5r/sz
         EEX0wVJZRHDw0IUtQJQQlKoLgI4cKOVn5UGcG4ZiqfoAqcYsn3+NEBqc4DR1ywscSLnI
         VEwfP9gN26KxPB9nm5tGfMW/hrhXjE+p6Cc1tRChuF5v21zJ0P+stMMM9BV1xfk2qLbO
         +2sjWIPgBJrkV6xCyssb789u9gbhPJEhdgKJguyJqABI/3iWGIDejngpyNFXDYcqlIJC
         Cyiwu99bCoPvv6vvOFaYhfwWQZuRcMHrhxQC7sKCh6tCVqqk6Du+KhHDtowTAEHJX0ZL
         ubtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtA/DVz1LnsAWBshYZm6FkL5+SOtT3n/IyNxmG0HIRodI6c2NeEWHHMDDYGdGACl2x2UZTiQN68I+0lX+9Ue23IGDcaZ1wx0JnL18=
X-Gm-Message-State: AOJu0YwcOOZx1q3xkyFZ3BUmCNgKYqqqOJLkg/DgctfrKxANxuKNxyQt
	f/rhhLQg3jszkBTomAI6qzUS3I9ZQCPEnpePHsSHoJ0z8LevqvyzTl6VPw==
X-Google-Smtp-Source: AGHT+IEUnOfOlSGHzJUy7G4Gm3W0HlBnm/YA7hsU4jvsK8bKfp4t5zhrkN5kHSInbiBDHapgui/myQ==
X-Received: by 2002:a05:6512:1110:b0:52f:cd03:a823 with SMTP id 2adb3069b0e04-530bb3b46cfmr13247589e87.45.1722942358831;
        Tue, 06 Aug 2024 04:05:58 -0700 (PDT)
Received: from 127.0.0.1 ([94.41.86.134])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba3cc3fsm1427671e87.241.2024.08.06.04.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 04:05:58 -0700 (PDT)
Sender: <irecca.kun@gmail.com>
Message-ID: <ef164317-6472-4808-83cf-acaa2b8ab758@gmail.com>
Date: Tue, 6 Aug 2024 11:05:57 +0000
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
 <90dab7d5-0ab8-48fe-8993-f821aa8a0db8@gmail.com>
 <0f6cc8e0-ab32-4792-863e-0ef795258051@gmx.com>
 <837fb96f-989c-4b56-8bd4-6f8fb5e60e7d@gmail.com>
 <bbec0e87-8469-488b-9008-f7d85d5ee34c@gmx.com>
 <62433c69-5d07-4781-bf2f-6558d7e79134@gmail.com>
 <e72e1aed-4493-4d03-81cd-a88abcda5051@gmx.com>
Content-Language: en-US
From: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
In-Reply-To: <e72e1aed-4493-4d03-81cd-a88abcda5051@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/24 10:42, Qu Wenruo wrote:

> Too low values means kernel will trigger dirty writeback aggressively, I
> believe for all extent based file systems (ext4/xfs/btrfs etc), it would
> cause a huge waste of metadata, due to the huge amount of small extents.
> 
> So yes, that setting is the cause, although it will reduce the memory
> used by page cache (it still counts as memory pressure), but the cost is
> more fragmented extents and overall worse fs performance and possibly
> more wear on NAND based storage.

Thanks for explanation. I'm aware of low dirty page cache performance tradeoffs, I prefer more reliability in case of system failure / power outage.
But that rises questions anyway.

1. Why are files ok initially regardless of page cache size? It only blows up with explicit run of the defragment command. And I didn't face anything similar with other filesystems either.

2. How I get my space back without deleting the files? Even if I crank up the page cache amount and then defragment "properly", it doesn't reclaim the actual space back.

# btrfs filesystem defragment mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst

# compsize mingw-w64-gcc-13.1.0-1-x86_64.pkg.tar.zst
Processed 1 file, 3 regular extents (3 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      449M         449M         224M
none       100%      449M         449M         224M

There are 3 extents, it's defenitely not a metadata overhead.

3. Regardless of settings, what if users do end up in low memory conditions for some reason? It's not an uncommon scenario.
You end up with Btrfs borking your disk space. In my opinion it looks like a bug and should not happen.


