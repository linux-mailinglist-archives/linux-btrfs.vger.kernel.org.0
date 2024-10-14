Return-Path: <linux-btrfs+bounces-8920-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED37E99D9AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 00:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1351F23692
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 22:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669611D432F;
	Mon, 14 Oct 2024 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fs94FVND"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B284143722
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943952; cv=none; b=L6nI4Ei+/3AyOZMfABt/NGJzcAZ86w/m/a/+CZgKAArmmCenZYocWqQfOHGgdWyiwZJvkiQaXxSOGUQ56LrC/PRE5Jm4/toK7Ijaz06yQj29en/TNRnBlX+r7efz5rbebSjeEj6+t/VrzuVZZTm6gHt5IWaxDgLKZVok+Dd9TuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943952; c=relaxed/simple;
	bh=CiRkgDwSmyAjE3IthEt1BIyb/50rE3ZhWj5R4qVzhZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KYGH3tG3mV5o3mQFILnubd4DS5v2yOnf+lRJ9mLE68TA3tvV1I4VHYIkDX5zv7/5QVggr8fZGEKJabpuXVdCBMB1swHWnVyNRrEXhsqhlRcFMx6xwtuzuLmpOm0uG5o6FHHOM8ILO0MZD5nFZhai+qtueLQDKGrLaL1KQICo3xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fs94FVND; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea8ecacf16so661493a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 15:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728943949; x=1729548749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aOnb4fmTrZjtto+yykHB48JoHJrPt+fLQEUfS9yjta0=;
        b=fs94FVNDkLNu0fTT4tujCKzCxkJdZAtjHhmaT/03e0WtjAC9bQo/nErDUypHZxk9K9
         SX+b9ygwoLYGbNBFYA1zzxhQ1BoPjkqHALfnUQrXm92saeam8jQBIMchxInwD0ch9UFU
         TaHLFpF6b5EnrA0Po4o+j+SOkRUyBdt0onwX84IgLASikv/RXhC9ZYm6KskPMye3lgLS
         ZzWRx1PvqCOqtDeQeLjvjUK+0nGC2OmlexcegVvUvCaBhFKRSMwcpnq/igM5wr6vG0gb
         Wypw+oa4x9vZAy1mkHd8Joa7Q1IF3vaQ4iXbtXahmkx0aaJ2hxuwbrhuWQFhI36EwPy0
         X75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728943949; x=1729548749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOnb4fmTrZjtto+yykHB48JoHJrPt+fLQEUfS9yjta0=;
        b=ft6xHtAfegyw29OOkCRCafATPV2pkPcmNbiw9SY4zK1/Eb7y3sfzPLVRtSAmefEXF8
         t59Eo+vo7jI9h5ajeeIB2iADX2W35jcrKy55Djx5+PbY7lqh9NpSWknC5DcQ6QZcj2E4
         NKUh1SUUgqbH3oBhxv8gc40dxSMPY5q3KOm2QT09tz1dkc8ugvPjLYPZcdm1N8jvzN1T
         BQivwuVNYWBDjHh/2ki0Z+i3HoirD+CFcOmW3y8R4jGn2CK4OWZFgLslifDD9l+gNC0B
         lYWhtQL7r7sLiri1rKb99TAfl8Ec24czriyHCfwOBRIBh99oOkU44Vvl4KTGUZ60u1HB
         6lDA==
X-Forwarded-Encrypted: i=1; AJvYcCUTKKAyvK0Y/rGI4nUW9g9GIzn6ScA/r/7Ks6LCMYniMKXR5MgKGhicmJLkxRHl7N2j9rYkNcnMlizw8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzPXyu3TQ9HtSxN4dAij+ujUHu8xQQ5kcuBoeDodNquhsxm4R3
	q4e3FPMxKNuKf+apdA01x2w2jo4Hs5aZPXgCOpz0DFzf+p89jeD+Vp4UToJecCc=
X-Google-Smtp-Source: AGHT+IHQFimetw4/EUxd/x/xM+nGK5AjJurlknmpU+NqmPtkaHofrhHXlRDW8vJl8sJ4og3QB0iecw==
X-Received: by 2002:a05:6a21:3a4b:b0:1c8:b849:c605 with SMTP id adf61e73a8af0-1d8c96c2d21mr14492662637.44.1728943949499;
        Mon, 14 Oct 2024 15:12:29 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774ccea9sm15242b3a.150.2024.10.14.15.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 15:12:28 -0700 (PDT)
Message-ID: <1299ba1d-e422-4ec7-af2a-aedca08df705@kernel.dk>
Date: Mon, 14 Oct 2024 16:12:27 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] btrfs: add nowait parameter to btrfs_encoded_read
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20241014171838.304953-1-maharmstone@fb.com>
 <20241014171838.304953-5-maharmstone@fb.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241014171838.304953-5-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/24 11:18 AM, Mark Harmstone wrote:
> Adds a nowait parameter to btrfs_encoded_read, which if it is true
> causes the function to return -EAGAIN rather than sleeping.

Can't we just rely on kiocb->ki_flags & IOCB_NOWAIT for this?
Doesn't really change the patch much, but you do avoid that extra
parameter.

-- 
Jens Axboe


