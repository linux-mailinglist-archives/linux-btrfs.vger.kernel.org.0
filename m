Return-Path: <linux-btrfs+bounces-20431-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BC4D168ED
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 04:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06CA5301E6F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 03:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C1C2FFDCB;
	Tue, 13 Jan 2026 03:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Akl9pHHW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01482D320E
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 03:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768276138; cv=none; b=PzRcIic8tzZKgVT/j0eT4a4q/7Splur6OthnFmemycSntecqBCdnU6Olm9MfKKw9ulPeWZYtP689cuxk6NRMpC5VhFpMREzK+ZXLlO9SgWqvxbTk7KYTw4uDA3fusYNfxv3w+dUizgTpx2ewfqtkvMFI30pkp23XUWRiEb7tvHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768276138; c=relaxed/simple;
	bh=W/u8bSmbWE6ujbFLcqGIcNzdR59O9B5U/yeOjmmeDJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SILRdKplBs3zesFLxzwCnQgGFY0kVwZGyYy1yGJGgZJyyoOuu4KR6sZUeKUGBfMdjVYRzjtbxGCS03cpRlOYSZj3MTSz3C1OuDzv3iCTQl8gTagckT1mQ2weCYaZW0TtBtygXCfU0ybF7TqpvgFTqolcEKIK+UZWJfUS3mDDq0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Akl9pHHW; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-644722d0b23so946077d50.0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 19:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768276136; x=1768880936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WWW22ef9KJsO0fqq5l3A96YHH5PL57XBv1sMDxJJA6A=;
        b=Akl9pHHWVLCNP7aKhte6/IjahFfLYLnpRgaMKGgzJYxUOC3KFio5Kyeu288XHZgTcR
         mc8WH/FG0GL1pivqG7pEyZQ7HiX/L5d+uAiOSQhc9CyMGvNmMVGA26y49D+FVQ4JQKU1
         zFGoC2TqHkCB2RXSAIXBQ6Gv4lUyBkW/ftXt+ROsgzEopHV9drUSFDZpQliMZTvi78lM
         PDReTYpvXjp0uEWloh/f4f9NbojOiBBzC/aQ2kqLTIBs9+KRV8+3azRYu/9Xf42qVRtR
         SngosLZHxOiOBNxKQFdlws6+sTYGC+iwzSy3LbjyZilWeoCkhcZoNL1XyKbLyuLPLkJo
         dp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768276136; x=1768880936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWW22ef9KJsO0fqq5l3A96YHH5PL57XBv1sMDxJJA6A=;
        b=PUfvx62lWVg1Oy8/mUuQn0cchKSbVGRUZong0BKCUaJ3bjHDesDaeWshdUuHMPqgeb
         G5IJwLdiIQM4GIMKO17Casll44eRIn892+NSgBjYD7D4R6JKRyLkRGV2TnwY6oYP5TQZ
         SsXd9KSSaZTASBUpcLwG/8wQTXf1wDAKM1rukvsZRqufj/4WMwZCG8CQf5X/mvgkZ9IG
         imC//CgK5+tzv7Jvroq9fsHqjT4EefELgslQu5X+JZvE9+LytOPukgKBbEGKzxwhygR1
         7DuEZ5JExcBPMLpszxoEaxJ3U093syyAn/HxCyTNvVJ5PNhdR7FaZrLyHE/lFCvIc4vG
         sqag==
X-Forwarded-Encrypted: i=1; AJvYcCVaSzGfUw5DthGpSXnCGQhf0Npu/bW+BvaQ+yc4h9N4nfVX2fD6JyOCRrKhttAZ4Orcn51cOVVb7LiSnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqb4XBvB7iBIQK7pPAQjETT3xYTBAx7DVbcgC7wap4aZNp69d9
	3iWqxxR8iFidouxShf/D9Wq2zRSzo7fc/KdqmeopRPBLZ5xVH7euNuFR
X-Gm-Gg: AY/fxX6iYy8qkuk1QvUojTPKT2yWBaNFehPT0NTTgIHli9/JExO/kWhiPUvzPlxEe6R
	Z3iwba8fyPxD4W1nOsf+ocOx37F0nU+VGw8Zt6eZu90lkkN15OYMXmkGGVUmaImOTbY47C6Vn3K
	DUd7IXMfy3BtWTZoN0i2tEPYUwuCnwKHaztPO8s0Ftl6aU/lVkG/lx64/2eQSBmkMWzH2giBcMQ
	o+JAtJ82M5Qr2r2/LfO4PXn1T6fO3t0X0hwrQye+Dco6nc3neSw/N0p2s7MMxGTNcwR6tNkSROK
	nYbwaBF5pFTqzIxanYlMqjHFK3c/3rH+BLqjFlXpWUBy+yb5f8VbJ3VOlSVjzDl/t/S/BEMgQs9
	HOFlKoh6XHpGrwFWT911xZTk18DKy+d7rCzSK6aueU0bMyGorQ9f+Hm4NDmgEe5lDLCe/LIQpN0
	//mWmp2cDJk5xGDkFTHM418d1P2A==
X-Google-Smtp-Source: AGHT+IGZosHvmMP0UYYLTiNq5pAI/A9xHj6mtGGbRC4AgslH+PC9icGrtGhcKaiBWzhKjD1cq0Pa7Q==
X-Received: by 2002:a05:690c:6893:b0:790:63c1:da73 with SMTP id 00721157ae682-790b568c4d5mr138340867b3.2.1768276136517;
        Mon, 12 Jan 2026 19:48:56 -0800 (PST)
Received: from [192.168.1.13] ([103.173.155.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa553160sm76895257b3.2.2026.01.12.19.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 19:48:56 -0800 (PST)
Message-ID: <fc1111df-bb59-4aaa-8140-28d75c4bc7e3@gmail.com>
Date: Tue, 13 Jan 2026 11:48:52 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] btrfs: Introduce fast path for checking if a block
 group is done
To: Martin Raiber <martin@urbackup.org>, linux-btrfs@vger.kernel.org
References: <20260112161549.2786827-1-martin@urbackup.org>
 <0102019bb2ff5d8d-eb7c72aa-7327-4cab-af21-38a804adf477-000000@eu-west-1.amazonses.com>
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <0102019bb2ff5d8d-eb7c72aa-7327-4cab-af21-38a804adf477-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

在 2026/1/13 00:17, Martin Raiber 写道:
> A block group cannot switch away from BTRFS_CACHE_FINISHED
> once it enters that state. Therefore we can introduce
> a fast path that checks for the likely case
> that the block group is already cached, avoiding
> a full memory barrier in the likely fast path.
> 
> Signed-off-by: Martin Raiber <martin@urbackup.org>
> ---
>  fs/btrfs/block-group.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index cf877747fd56..73bdf7091d49 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -380,6 +380,9 @@ static inline u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info)
>  
>  static inline int btrfs_block_group_done(const struct btrfs_block_group *cache)
>  {
> +	if (likely(cache->cached == BTRFS_CACHE_FINISHED))
> +		return 1;
> +
>  	smp_mb();
>  	return cache->cached == BTRFS_CACHE_FINISHED ||
>  		cache->cached == BTRFS_CACHE_ERROR;

This function returns bool so maybe we can also fix its return type here.

Thanks,
Sun YangKai

