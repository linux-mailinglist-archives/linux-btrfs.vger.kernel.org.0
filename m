Return-Path: <linux-btrfs+bounces-9794-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C639D408E
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 17:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7222828D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 16:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A13A1547C6;
	Wed, 20 Nov 2024 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uvII7Grk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F32E14A098
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2024 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732121585; cv=none; b=ATXLXdfAh6MT+bnzDsbq1AnTvB89/BlnmyQpBAWgo1eBOIhXF5CzJn6XPzjGxB7SP5QT1H0yKDbVeqpp1CtBnwZCB1Jym8nEuN41BVKkzIUSNoVHZeroAwt5wIlvIp/wcS7KLXkinSRxqy/GNAKHQ0SiSm+CdPU9zYRFoHzXbHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732121585; c=relaxed/simple;
	bh=ebP22XcP2eX4OYsj2BLJ9Ad1VKGHvy8XJeDHumy0Mzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SaAiH2k08oeyl/pbgzCFp89tGGoFm35Q30jLnCi0u2VktejvdJuf6wsERmT8TBUpWBhPDkRCkUZGawSqVfJdAPDkyQeRZzek5T3mGkmH8EhVr0iwILQuVLYmL6iLnZBFEgdjr/Grk57AabsbV+mbnCs3oY1ktYIPUZaV+QofqaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uvII7Grk; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e5fef69f2eso3149231b6e.3
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2024 08:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732121582; x=1732726382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fsm4sQGgxD1ZdQmkv8kfCFgg1gaZuY7Ug/f5xLlAUHQ=;
        b=uvII7GrkILopg7HAhenCQscKqA9Gfatb1rX+RnMsMzs/4aZIXCs2/chWs+EVm9HCEW
         SHEdj3q3cCzORlRPDljyTcquhN7ASWaM9PJub3j3l47y+/gwkvfbu0qRdVxvwNjoaBWo
         3u1MFxwvp0stvQvE5TXjiGQAXzEjVq+ylFkwKiH+XellIgtozqn+XNZBk0sc4irc727s
         dvQZPK7m0j8X/ehm2aYnJ9NBs/+cH6+rFca9INbUhOW5m6ZvOWRm6b5vfa+tMkJnqN4J
         GX72dp00xzh0oCzroxM5jm532qRBdkAbeYHimdQZEd6unnnrELfPob0aiBddvfonxg0X
         oXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732121582; x=1732726382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fsm4sQGgxD1ZdQmkv8kfCFgg1gaZuY7Ug/f5xLlAUHQ=;
        b=BODFKIOAnVKfx8mFfIuWaQxmgTDpi3rzJ0ZCJ7lBl9hvBDTh74455vC7qTvBMHFvcx
         JVm6YFbCnuBIDe3ETtdwNn+MRxBBuEHbfpIwjfv0hC3Iq041/iFzhPgIbhal55oxoV/g
         VUbQ/8+8QJxZEtmx5xyVB8fXN7wRt1ma4bK2HB6CVp79qYvtBabNdV0lYWhEXCvKYZFK
         kvzjnI3JOOfulq4X0OQ2CvTG5tw3eIVdHLqdywaqieOSg4Nk0GEWIz5GOFiLp1oDWzmk
         JPn6lgWPLpsMu6TFp34yHy8Uxd4tfqd/uW35jyJJoGS7+Duj4foUf9rJQb0IIY3kyixl
         qQaA==
X-Forwarded-Encrypted: i=1; AJvYcCUYeYEj1RQY20NZRyRzZErrA2hwho+ANQSubrROwvGRUKTHDZUs1nBlmGIAzTc2IQ1S7a0pi5h+4m2MUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYD4Gyu6qVGOKrx2GQBZaRh8xMMT3zARRCxEg7oe96T4OsBagF
	oI6Aj3BW0Elk+ZyafHVrDX5p8VDuWXLfNmgVTGemMoVmtYgK6pddYy+NZHTpa7Y=
X-Google-Smtp-Source: AGHT+IHkavY08KUyna0ZZHrkcUUD/F5RPMkYj+xI8ErCsc39SywNVME1+r+2PALypqd6ZvwrOtwNFg==
X-Received: by 2002:a05:6808:1b9a:b0:3e6:6546:9142 with SMTP id 5614622812f47-3e7eb6b1d72mr3546772b6e.4.1732121582477;
        Wed, 20 Nov 2024 08:53:02 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7bcc3876dsm4305135b6e.0.2024.11.20.08.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 08:53:01 -0800 (PST)
Message-ID: <4fc23dcd-bfa8-40f4-9409-8817f6b7d4fa@kernel.dk>
Date: Wed, 20 Nov 2024 09:53:01 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: don't read from userspace twice in
 btrfs_uring_encoded_read()
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20241120160231.1106844-1-maharmstone@fb.com>
 <20241120160231.1106844-4-maharmstone@fb.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241120160231.1106844-4-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 9:02 AM, Mark Harmstone wrote:
> If we return -EAGAIN the first time because we need to block,
> btrfs_uring_encoded_read() will get called twice. Take a copy of args
> the first time, to prevent userspace from messing around with it.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  fs/btrfs/ioctl.c | 74 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 49 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 488dcd022dea..97f7812cbf7c 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4873,7 +4873,7 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
>  {
>  	size_t copy_end_kernel = offsetofend(struct btrfs_ioctl_encoded_io_args, flags);
>  	size_t copy_end;
> -	struct btrfs_ioctl_encoded_io_args args = { 0 };
> +	struct btrfs_ioctl_encoded_io_args *args;
>  	int ret;
>  	u64 disk_bytenr, disk_io_size;
>  	struct file *file;
> @@ -4888,6 +4888,9 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
>  	struct extent_state *cached_state = NULL;
>  	u64 start, lockend;
>  	void __user *sqe_addr;
> +	struct io_kiocb *req = cmd_to_io_kiocb(cmd);
> +	struct io_uring_cmd_data *data = req->async_data;
> +	bool need_copy = false;
>  
>  	if (!capable(CAP_SYS_ADMIN)) {
>  		ret = -EPERM;
> @@ -4899,34 +4902,55 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
>  	io_tree = &inode->io_tree;
>  	sqe_addr = u64_to_user_ptr(READ_ONCE(cmd->sqe->addr));
>  
> +	if (!data->op_data) {
> +		data->op_data = kzalloc(sizeof(*args), GFP_NOFS);
> +		if (!data->op_data) {
> +			ret = -ENOMEM;
> +			goto out_acct;
> +		}
> +
> +		need_copy = true;
> +	}

I'd probably get rid of this need_copy variable and just do the copy
here? Might look cleaner with an btrfs_alloc_copy_foo() helper, as you
could just do:

ret = btrfs_alloc_copy_foo(...);
if (unlikely(ret))
	return ret;

and hide all that ugly compat business outside the meat of this
function.

More of a style thing, the change itself looks fine.

-- 
Jens Axboe

