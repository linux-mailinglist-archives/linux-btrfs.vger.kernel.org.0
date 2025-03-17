Return-Path: <linux-btrfs+bounces-12342-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F066A65608
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 16:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBB1F7AA598
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 15:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8133B248885;
	Mon, 17 Mar 2025 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kFiRhRgN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778A12459D9
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226011; cv=none; b=n7zlXXACQGm/jthAyYwg3r0B0yKRFXwF/vEYgtfl6R/gZMpQjKP1jJski0V3wcqwkVH+RGvvd235vJphM9ppja0ksaWrVZ2vyI7CTE18HIoY42ielFPGQOs4ciAramoaB8VUkjTZ+AMPtFoglpiNEGS0tOabSDXAlT6MRjK+jgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226011; c=relaxed/simple;
	bh=Zk5t2sU0aCBaBnN0KQfk+cU/1BqX9as35kPCVJMUe5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OrGs76Nd8L4sWKGOJp0hYBI89+8Z9PW1YSv3azrTgljMLWQC0ffSMoEgANhpZ1W9fQQ8YBmaYj8xIOLrRWhm28jrCDLyVdg2T5PIWOkGtmKozd/Tgp2v2TVUOr13wVOQX53M1vtvot6lkGt/2qBbhwa3XKe7CyS1GUre5YQms6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kFiRhRgN; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85b3f92c866so76172639f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 08:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742226007; x=1742830807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ShUy4m+vJwdS4QZv6PMnZsGbPGN8eu9awNnNG2yKLpU=;
        b=kFiRhRgNzlYLXTFW1ajt0pNhz9DF+aQlzqgUJJjkeLYlB/rikTzxYpiZKNtEsxGtAz
         uyaR8emXzgd7zLspKEn3Es3Cf5mhLu/I8Ifb7CQjYaho2geyPgnm2LbF9Se/st9lPZmU
         FplAekpsAhMQ1cZlS/IjZUho+xjDmibMaUNMs+x/Kusx9LMdSU5Kd/KrH8u+BHiorLfj
         5QpZX4R2NcbbcKD43iuvOD+d6CEl8ykn8MzAYLIJkOGkIJWqaFLaQrYNEvH2mVZhjrVr
         pZlF/dBmRQKS3BrRsKk232JZmtJW+SQ3c4rpSnkkl1ax7cvGCHzFiVQhSL6oKPqtsIe3
         uw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226007; x=1742830807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ShUy4m+vJwdS4QZv6PMnZsGbPGN8eu9awNnNG2yKLpU=;
        b=ZJrtwgaGEGptP9BGRuUrFUOAXltBf9WZ5PX7zIMS+3YUTkQHu7ZevSktTOTQ8qxMvK
         hjytj0S6PirJy+egYU5PT+9O4xZz0BkVbkKYvQ4cxYezCiCYXmKcuvNMTf2de5t7oZXY
         6bCKbYB6FZfZ9pgnUjzSJGgUQaUTW7gmkuByowPFPyagH8u/isUR9PaJ42Ny3HpIcr4D
         dEX/YqzMTwLQwSj8cfAVOyzV5U7r6yRhq+JWb2ib7yjkN+3boE9mSmPmh/pz/An+jaM7
         0JI36/U5DHQXlXxu+dH77YYm/HkfOrLEtYyF09a6oL3lkpgcbcgtX9EMov7hM0crtzzE
         ckzw==
X-Gm-Message-State: AOJu0YwQoWRul3x0AldGNAsqh6a684Sh765YMilozAzc7Gsz/DLB2rbT
	TO4l9pgybne7gPFVWJ28Yrv0sDyEpn6e1hh9Ep9oS2syu9B2CVUGEEC6eE4mJ/Y=
X-Gm-Gg: ASbGnctlCHzCsIuwagqealNQDEuoPchbJlylr3s8GJKxOuO88lY3kSLLXG1ZHcvTiBY
	Y1P4hFpjDLGqRvoF1hlH2Irz9aeTtQMBjS9QKGXS40aTfdcjSFfRwpDIAxO4CgwmL6ILZvR+b7U
	RbIZXodv0LKWXXb9f3vg4mYY5XitgkkMq9Fz3W5fUEdMFr6669Ji/z+zGcxH3ape+neReSEmnE4
	hcpxRwh5FpFODpM8QR3eLab4WqrkZ1y5VK9UzFy4/f3if1A/xswH21i2+QdACh8a75ewNAKxkoZ
	2za3Y/iO6XoEea+6mpHqNMJrTbsLrdPJL5Z5URDypyC6JoEgqFk=
X-Google-Smtp-Source: AGHT+IHvdkWe+7JRGqXk+mUfmTZQ49tXHQzvD62kUaQdqYU4vxNYPeTNSe4s+5gD3xqVGJ1qX4dzzg==
X-Received: by 2002:a05:6602:4147:b0:85b:505a:7e01 with SMTP id ca18e2360f4ac-85dc479224dmr1541106539f.5.1742226007242;
        Mon, 17 Mar 2025 08:40:07 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2637031basm2315060173.2.2025.03.17.08.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 08:40:06 -0700 (PDT)
Message-ID: <3a883e1e-d822-4c89-a7b0-f8802b8cc261@kernel.dk>
Date: Mon, 17 Mar 2025 09:40:05 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 4/5] btrfs: ioctl: introduce
 btrfs_uring_import_iovec()
To: Sidong Yang <sidong.yang@furiosa.ai>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20250317135742.4331-1-sidong.yang@furiosa.ai>
 <20250317135742.4331-5-sidong.yang@furiosa.ai>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250317135742.4331-5-sidong.yang@furiosa.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/25 7:57 AM, Sidong Yang wrote:
> This patch introduces btrfs_uring_import_iovec(). In encoded read/write
> with uring cmd, it uses import_iovec without supporting fixed buffer.
> btrfs_using_import_iovec() could use fixed buffer if cmd flags has
> IORING_URING_CMD_FIXED.
> 
> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> ---
>  fs/btrfs/ioctl.c | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 6c18bad53cd3..a7b52fd99059 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4802,6 +4802,28 @@ struct btrfs_uring_encoded_data {
>  	struct iov_iter iter;
>  };
>  
> +static int btrfs_uring_import_iovec(struct io_uring_cmd *cmd,
> +				    unsigned int issue_flags, int rw)
> +{
> +	struct btrfs_uring_encoded_data *data =
> +		io_uring_cmd_get_async_data(cmd)->op_data;
> +	int ret;
> +
> +	if (cmd && (cmd->flags & IORING_URING_CMD_FIXED)) {
> +		data->iov = NULL;
> +		ret = io_uring_cmd_import_fixed_vec(cmd, data->args.iov,
> +						    data->args.iovcnt,
> +						    ITER_DEST, issue_flags,
> +						    &data->iter);
> +	} else {
> +		data->iov = data->iovstack;
> +		ret = import_iovec(rw, data->args.iov, data->args.iovcnt,
> +				   ARRAY_SIZE(data->iovstack), &data->iov,
> +				   &data->iter);
> +	}
> +	return ret;
> +}

How can 'cmd' be NULL here?


-- 
Jens Axboe


