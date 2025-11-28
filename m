Return-Path: <linux-btrfs+bounces-19389-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7299C90D23
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 05:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CED7D4E42EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 04:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1054E2E972B;
	Fri, 28 Nov 2025 04:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lalhiAb8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E931B2D6E44
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Nov 2025 04:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764303206; cv=none; b=K2w1e24xJOIjoqgnfTZXF5RISStpXgD9bipMlZrqdbvZbi0vwDjV7JpiONMJq67FVXy5UCB5PNosHBtEJWAhHHPY0RpXBQTobn7uIiuz0a6tix+cCqZmcoSSD49CmW3cGR6SbPguzSLpOpgugkWQVf7LchFWWDowc1sf/d4mz5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764303206; c=relaxed/simple;
	bh=UvGCPof2YhB9z9XhmUUs+yccnO5WB+0XgzBGNKMzOzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YyjNsGMzNAkzrUEYWsDUzCiTKU/WRhrg5HeyWOgH7PkdMfb+1cjTxQFtGBRjYIpPljS44jzW3zWfUEk233BUiGgkoUMnQnsSH4pMxPcqGabzGs/e6o9y3Po4uFCglWNSFZgQ6UXUC0TEgKMfUQxZ5QxJRM5p7qdGQPlgtYNNzu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lalhiAb8; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-297f2c718a8so2372485ad.3
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 20:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764303204; x=1764908004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xt6nLjL7GdcasdCo+VncKfmyjy5vLSkR3QqMx3lnmSY=;
        b=lalhiAb8O0KMcSoe+hHfN/JgKhnJ5hIPI6bhY33Uv+kt1+QUxqLf1N/Z8+FvJ6sUdT
         hGeYEV0yshpQ/2BFikdRZwYVkeH6aMJTv4dvPTMrTU/cxggxLwM3fbM97XOJ6VjDe+qV
         GAc+8BL56HiAYglO5UeAPjwUJWdF/CzqtTwOgnmfGukOd1uWwSwuuJs5LttksfDCobd7
         D2wiFQDxdvG7rPAbgGg5iBKXkcWSpZCwgMyEfmPlLBaetVhzlH/itV5S77jXqjU0wPI6
         UJYDt7ijRA8gXkmj/GD1NxnDI4yG6wE2rgqh4dILKmIRDOXwB7D6qwrBja1UAU3z+6AV
         +x8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764303204; x=1764908004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xt6nLjL7GdcasdCo+VncKfmyjy5vLSkR3QqMx3lnmSY=;
        b=hMLE2HFOyPZc0Yui1rRoND3TMJhJKC++jGW20/bTxp6Eg2L8WLbH0DNKaU9bXnhC6h
         mHyDpM07DQTkFTPwfra2U2L/c3oUg3Oax1z+HeIvWEJIGflvc//qilZTLntBjb1V+Vtp
         wfvtOuzTszWanHkgs47wBEnuM8WvRDRDUEO8t5KSHFw1MwowNeNrj9eE90jlkXHgpXn2
         5osjUy6lyqqMr9eiZLnTi4AZ7G1f6DFFXq/gUg8XtVUFEeA9NRbYHNhI1Po/kjVQm6YV
         IN7UVc4tTa0XXq9m9e7EyEtecvomrDfq7thbpPvKJV+FkrpROUclTn3UUnpnVr/sLTNT
         YQmQ==
X-Gm-Message-State: AOJu0YwS9lftnJBeUwz6AW0O5Dm/AA1GEL5w26M0VKQi1MQo3LIDeQMc
	g6ycm0H2ByQZvnTrKtkrIX+xHZ5FgLDl58vhu5jyZPowT7N/7IUcCzVI
X-Gm-Gg: ASbGncvFPnbLbLkxgd0yjzCgu/+eQ+HnMLb+GwQ/d8Z4pif39HkHAmyHE1h9I3cUiM0
	FF6wS8PF9FzlIzxHV3Y1PtRapEBzCbfoSyv/v5hbCipywdhTb1mwjwGCrOcWjBr0bjK6l6CpSuR
	rPm6S7pCif2W6rtyYbWUZZjO3EN1lZzcmKgSWt+YXGhFvA7deyDMWG8o1nLDq2bnu7nRL0UVYeQ
	YEkQm/YMXGyc0S8m0sg6xr4qsWurWTPjPwpjrtFK5+Jr7x6OcrNBW1FjbWRFPLGkJA1sGNNpcqq
	ZLi5rnHck3YDQtDoeLvvg2AbqY6ZDVrfbyj9wFmoReXu+qCnA2SvmJyQPktXeJxOiQpdD94OYsk
	ohlnNyfjlWWeZEKn9sTQfuB4iaKo9stlFfTrw6dJ78TwlxFjgrGYBJ1fM7il9WSOqjmVIf/tp6C
	Bx7u0ezEK1nfJZr4tFFy6U25DV
X-Google-Smtp-Source: AGHT+IFalsEdkroGJ7s2lCLhJLdyAXIoc6gMkxvxB+2kowuuJ0wt8vdUdi0RjZ+j9QAvKhD7O51fcw==
X-Received: by 2002:a17:903:2385:b0:297:ecde:770f with SMTP id d9443c01a7336-29b6ff7bf00mr153692005ad.2.1764303203987;
        Thu, 27 Nov 2025 20:13:23 -0800 (PST)
Received: from [192.168.1.13] ([45.144.167.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40ab42sm30970125ad.5.2025.11.27.20.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 20:13:23 -0800 (PST)
Message-ID: <c5b937fa-f18e-480a-9ff3-bd1fdda7f98a@gmail.com>
Date: Fri, 28 Nov 2025 12:13:18 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] btrfs: use true/false for boolean parameters in
 btrfs_{inc,dec}_ref
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <20251122063516.4516-2-sunk67188@gmail.com>
 <20251122063516.4516-3-sunk67188@gmail.com>
 <20251125164603.GZ13846@twin.jikos.cz>
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <20251125164603.GZ13846@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Got it. Thanks.

在 2025/11/26 00:46, David Sterba 写道:
> On Sat, Nov 22, 2025 at 02:00:43PM +0800, Sun YangKai wrote:
>> Replace integer literals 0/1 with true/false when calling
>> btrfs_inc_ref() and btrfs_dec_ref() to make the code self-documenting
>> and avoid mixing bool/integer types.
>>
>> No functional change intended.
> 
> You don't need to write this sentence to the changelog, in this case
> it's obvious it's a simple change, and complicated changes would be
> explained in full.


