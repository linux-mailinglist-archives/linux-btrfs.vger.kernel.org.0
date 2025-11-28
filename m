Return-Path: <linux-btrfs+bounces-19388-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E89C90D20
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 05:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FF23A82AA
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 04:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C3E2E9EA1;
	Fri, 28 Nov 2025 04:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOa1UOKH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0DF2E7623
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Nov 2025 04:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764303127; cv=none; b=UvYzxWYwOxCYRN/OWrSgZvo9II4n55vBDsjDL/b+zLI9pUraAFzkEPxZdNOLIGqCk/tnRqD+gXNexkxI85FNA2k0JSKULECdZo/5Ne/pcdMzIC6mCtTqhlWRtDyECinQKPFQuZQuLMvA+1MeAAUO5fT0RbrPurg51Wc9oAxfmLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764303127; c=relaxed/simple;
	bh=1OkvqsnuHvvKMtxEdIDU0jBVTCmEE/rE0VnSDZkSX60=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LbDQwpDxB/s3SUV42mcoTsFUJ/KPgNwVCo9eEc5vK04YrDSev3BYkpZvzP6LVCmOpijkUo1qo3TgcS7V9BMk67i9WlUx/GcKHh6wnAl8l6VkHf2Knw6ebkNjntq/UpDJsarMl5iPckl7f3X39mx67kr4QdozAhzMmE/ibvfftIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOa1UOKH; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-297e2736308so1920445ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 20:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764303125; x=1764907925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zh2ZhVb3HKdajlhfDvy/KK05hekc0IF7Em5Uv94QADo=;
        b=QOa1UOKHPGiUKjc4S+1v0vplO0gDx9obBRuscQvMvZLRxkVBhCyrl8nar8Pjg0erM4
         Cf0Z/s0ueUpG8/YeLrnfmAEZXEvRFk3W8VLlBd9sg8fq5PzCFogX/hn9vg5gi9rJo9f+
         IgwpB/4gRKIa2C5Pa2IcWGS7/WJNgruTpZts/fgDZ+b472UNiL31HOBH6m5Mrnmbv12y
         ZyrKxiwCO1pcf5QAUSQTbNgunWCFJOJ0+a5U/jaAQD+IrctIJRtX2FibW1ddekSkakBb
         UqH3xGajciTfqdSdb61mz+InNI6P5zNwF82l/AFnhbuzZejKOURtUbTkuL9Ffo71pKXn
         L62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764303125; x=1764907925;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zh2ZhVb3HKdajlhfDvy/KK05hekc0IF7Em5Uv94QADo=;
        b=nyX2hn7ZsOb0CmyFyDIKuCQ3mC718aGwIzp7Yn/VMk+eWC2ydVhu1GxLVkiHxGGlSE
         T58tY2MNp0c0TFcDhMl2VMx3+HYTZyzQUIOB97C8Wpvixner0YQN8H6I2cq+toq90wrK
         VOYAKP4ZdXRL2JaUzsXeWwcJRzLuS6ORyHmXOXaCj5ekWueO6feQnFf8IO64c1vJMSCy
         etb9hnkC4uJwjsrM3SvjHX+scoMneeor5HlhM/X6KmowSjdvov8eSZ/kxKwjtbShTeTA
         N9hZjs9Vn6RSYhI2HAHu441QSchdfW5B5QSHt15L4AfFe9HBJul9sfyUrHNXwgAAe+kC
         9t0w==
X-Forwarded-Encrypted: i=1; AJvYcCU9ir/w7cx3eWJZcNJXolnX/0Az7rFfboDQ6J84KDHzKItdpn/D+R5INxMiejD5qvDRjC6r947lqaAqdg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6SeiI8Pviv0P3rBiJT3SEKkNIXuOHjWkMpTpYBmdbMcWXC4Ry
	WCSbUXiCgyJK+LRsV63JrF27zCS+CAoDc6CASimSNwGxpaUJXkfD1xRLJqz6MEgQSCEQCw==
X-Gm-Gg: ASbGncs7ybKgJUjVS2yinNWjL7rGVa/QwcurBtHfDCr2mOZU3+tUdUJfzvyycPlanqC
	8lumEZcDjWEy5mWmwmK1HS+4FQ00Peg0ke6M1FtCxsHOGb/zqf+Hev8VA6zTQjigC4jgRgShYKE
	rV1zilW2JtyC2XIzA38+I3zKSKzrPFiy/yoe+ZDYRU+JU8mzi9DNhnYVhSQR9yBNdUKR9rHeLaI
	IyutU0c4HfyJOAB7pk2teYhiBNzDRCqUFU+cvLj12MDyubyTLZt0PuOdXJQluse0Nq3pnzM687i
	SFdb+OXeEbZPum86Dwf7eaZiVeb1oAwNHmyh4hmGA44VDGmne39km97NCEWHRicSfRDxCzW6LYD
	WxphOWLCGUM28n7q2Qos06EPT6UBNyOHeKLOfpfkh7uSdwnZjjpTIl1KlWTCGnpFMpAJJlXPE85
	WR8hXEgwSoxqXh4651u53cvTis
X-Google-Smtp-Source: AGHT+IGz6a7BqLZK9rwwKjC8VIcpixC76pih5ajsSv8w8cggc9y//rlM6htS2MH52W2TF9bXc/KI2g==
X-Received: by 2002:a17:903:1b05:b0:295:70b1:edd6 with SMTP id d9443c01a7336-29b6beae519mr177542275ad.3.1764303125334;
        Thu, 27 Nov 2025 20:12:05 -0800 (PST)
Received: from [192.168.1.13] ([45.144.167.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce478762sm30721415ad.45.2025.11.27.20.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 20:12:05 -0800 (PST)
Message-ID: <4c96af12-cf44-4028-b3c4-4ce9314c4733@gmail.com>
Date: Fri, 28 Nov 2025 12:11:59 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sun Yangkai <sunk67188@gmail.com>
Subject: Re: [PATCH next] btrfs: tests: Fix double free in remove_extent_ref()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aSf6UHCbZrgZCQ1L@stanley.mountain>
Content-Language: en-US
In-Reply-To: <aSf6UHCbZrgZCQ1L@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks. My bad.

在 2025/11/27 15:14, Dan Carpenter 写道:
> We converted this code to use auto free cleanup.h magic but one old
> school free was accidentally left behind which leads to a double free
> bug.
> 
> Fixes: a320476ca8a3 ("btrfs: tests: do trivial BTRFS_PATH_AUTO_FREE conversions")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  fs/btrfs/tests/qgroup-tests.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
> index 05cfda8af422..e9124605974b 100644
> --- a/fs/btrfs/tests/qgroup-tests.c
> +++ b/fs/btrfs/tests/qgroup-tests.c
> @@ -187,7 +187,6 @@ static int remove_extent_ref(struct btrfs_root *root, u64 bytenr,
>  	ret = btrfs_search_slot(&trans, root, &key, path, -1, 1);
>  	if (ret) {
>  		test_err("couldn't find backref %d", ret);
> -		btrfs_free_path(path);
>  		return ret;
>  	}
>  	btrfs_del_item(&trans, root, path);



