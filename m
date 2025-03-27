Return-Path: <linux-btrfs+bounces-12605-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56615A7352C
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 16:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783AC3A5BB4
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 14:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CC7218AC3;
	Thu, 27 Mar 2025 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiimHST+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E58121885D;
	Thu, 27 Mar 2025 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743087447; cv=none; b=etN7dxt+J9fhSI7Z1Qx3pkMKTe4/bt8K8XqxEUyGaTxeR+GpKYHPcHnL+qr3shq5GIA+59HLSaGDrpjHq5/iuUNr1DqRssK6akB6lVBKJ9Rtfap3dBe6j9KvrOOu9nx93W+sT2BZDcn7/kiWJTehkPJGU05ZHiCqkNKYY9dWrog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743087447; c=relaxed/simple;
	bh=3ca1jXJVG2mOl67Hy3N9jGGUUJEjCNX9S7Ae/wsyZTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBgCNpoOTp3tgmbRxorQeMqwSVAbasK/WeAhzxdiaY3hyi+l2datcVTRnahX+jy077gAJkRYBNh9mTLvsCeG5DicGIvp3J9QtG/dv9L3EJaYEGIHYhmKYxnUk6xbbSs+Lrk8DFLlAkvQ7uTnT+DD3DsMCm5GULiQlJMPReE49Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiimHST+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2963dc379so169649166b.2;
        Thu, 27 Mar 2025 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743087444; x=1743692244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LrtcrjXP+vqYsnJ6jTIyiKrk1d4PGceYFyFEdcX84c8=;
        b=jiimHST+ojNztLiuH5zyn91YHE4Ob1mfYkf5BJ7TrTV0bm/GdTNstFpq6bT0L1SOeQ
         nTf60CirZ50NI/CIqzVPEfMxZshPXdjPCgiGlYZIR31DreW0WieB/SM0Ma3UIiIQ9PEL
         EedTIo2g7fGKKwBthgQy3U0l2cRGih3KTzXdDf9YoSQQ7fd/NXN26Cp3l4b58ywr07aR
         SH5eDeyPijsrSMvIzt3VqbkPI/GJ7sqX0epL4170MdcHzr785jNIIaHuoDULuv6xB52y
         ZmDb4MIZY0Fr5X5wVETI+myjDrtbfsSZac4KV6Rt3BmPCHSYWJGG0u7IjqInuVV6PVO8
         8j9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743087444; x=1743692244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LrtcrjXP+vqYsnJ6jTIyiKrk1d4PGceYFyFEdcX84c8=;
        b=WVXIpNcSoMlPDzX5kbjbZQLF6tDqz8r+R2aZgKpln3tAskxl3vN2nuBWuIMBpCD9Cj
         45Dr45fQ8piteh6SPBnjwLswbuaYRrOrfgF7z8lQUBUvYSScMoRs16ncPiK+d4ZeG6XW
         6oznHd/knTNNqWGnxe8TCAVgJ0NUyw1kuYzS7yPjFRKXkcovz2YLKMOJIBvVpn9tT43Z
         wxJZXBL7IG71eZKizSGjL5uplkWRhSinD31SaE1gFmkXFZ4/9mGGmUdrMZnkqqdoxIi1
         HIVgR+azjJ0BBsmXUVMg5d1hFbaGjpAmSB7ejpWYRFEuqSaay8BC2p2diB3yELtYy3dq
         Y70w==
X-Forwarded-Encrypted: i=1; AJvYcCWk2FHr6L4M9seHCa3zya5g5/llKDFFGGLcT4Gudq0fSMqLOvN2wGStALUolWs7n/zI2HPtsuwa3skbMxg=@vger.kernel.org, AJvYcCXDRCsy54z2D2WUm+n3hsZXfOXREpuSxRQ3u/qqtFEjDZ6CWvxx3sPkU8gnQpCGi+k/b8VpkkeJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxDgzWr2x4CtCC79Os9ih//o/kGgeZmFFeTxjVe2OJ7vEc2K7dS
	xyLObJr5dajOAZyi+53Q1GXO5VcvyIciLwUPkyBsOJ5XbAEYsHAV
X-Gm-Gg: ASbGncsL3nu69BdI/ijXJp6TVWhiCAzG1QMn1qfrhDR4JL1xEP/47xoYYLhb7H0asjC
	4R5Uc2XHK6XVYuXdL928znpZCUL5Hrkux3O6Gqocq1d0QnltiRGyxeRUZDxlG+3wcWtncEPlrBq
	CeGM9p5M4a10DrAkeuhsVdPuadsHgY39nAnhuD8NIbVz2NPJEgQ6i4VW5GTRo+ZKYohHkZ+d8ZS
	WENTmPE4GxKR1TASR392xPL4BcMuYvdSW4scD9qXGA77mn0W2i2cfHn/P4f06qtKyNkO53BTnrd
	xgHVVRt13bgeXhdKKpC4VX6g/WWbPNYk7ivbnRXbPCxRE2RgXmRMrOzerw==
X-Google-Smtp-Source: AGHT+IFCE4MB8d+lfSyRNEmD5p+UBSxa7j4waVFjpL5DlULNguo61UAXaCJyUw9RvzVXpNfogE4XHg==
X-Received: by 2002:a17:907:2da9:b0:ac3:ef11:8787 with SMTP id a640c23a62f3a-ac6fb1a7559mr318885566b.54.1743087443561;
        Thu, 27 Mar 2025 07:57:23 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::191? ([2620:10d:c092:600::1:8902])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71922ba88sm5308466b.16.2025.03.27.07.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 07:57:22 -0700 (PDT)
Message-ID: <411a996d-8e47-4b30-8782-4418cf701f69@gmail.com>
Date: Thu, 27 Mar 2025 14:58:11 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14] btrfs: ioctl: error on fixed buffer flag for
 io-uring cmd
To: Sidong Yang <sidong.yang@furiosa.ai>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20250326155736.611445-1-sidong.yang@furiosa.ai>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250326155736.611445-1-sidong.yang@furiosa.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/25 15:57, Sidong Yang wrote:
> Currently, the io-uring fixed buffer cmd flag is silently dismissed,
> even though it does not work. This patch returns an error when the flag
> is set, making it clear that operation is not supported.

IIRC, the feature where you use the flag hasn't been merged
yet and is targeting 6.16. In this case you need to send this
patch for 6.15, and once merged stable will try to pick it up
from there.

> Fixes: 34310c442e17 ("btrfs: add io_uring command for encoded reads (ENCODED_READ ioctl)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> ---
>   fs/btrfs/ioctl.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 6c18bad53cd3..62bb9e11e8d6 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4823,6 +4823,12 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
>   		ret = -EPERM;
>   		goto out_acct;
>   	}
> +
> +	if (cmd->flags & IORING_URING_CMD_FIXED) {
> +		ret = -EOPNOTSUPP;
> +		goto out_acct;
> +	}
> +
>   	file = cmd->file;
>   	inode = BTRFS_I(file->f_inode);
>   	fs_info = inode->root->fs_info;
> @@ -4959,6 +4965,11 @@ static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issu
>   		goto out_acct;
>   	}
>   
> +	if (cmd->flags & IORING_URING_CMD_FIXED) {
> +		ret = -EOPNOTSUPP;
> +		goto out_acct;
> +	}
> +
>   	file = cmd->file;
>   	sqe_addr = u64_to_user_ptr(READ_ONCE(cmd->sqe->addr));
>   

-- 
Pavel Begunkov


