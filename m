Return-Path: <linux-btrfs+bounces-9558-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6BB9C64D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 00:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEED0B2D6D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 21:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C61219E5C;
	Tue, 12 Nov 2024 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tryes9sD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2361C6A3
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731445310; cv=none; b=chXniIpgWNoH/UhYn4MjwAtWZt9YutmSrL3o2BrX/KeuaQkZYU9rNLUHgOgP9VSlxoXcJnX4puD/rlwPs9rhJ6fJeS8nbPPn8It/Fp+p8q4qZ6a5SlvLiZsxPocpxTthheLV0IIG9pQ6ci5AJ/8sWOEloaBZ68rEuz8ymxZzqLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731445310; c=relaxed/simple;
	bh=gUH9Y2Zef2BV69DYyusifleNA8LeI9Zk6pCmVpcnhBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DKKK3qyjE3HCLEdmTAA0pKUldJXqHb4mw9YXcHWEX/YoXGpWHN5RdIGLRVDwFPLAf4Grz+mJria69IjFyFnj+tmMwEEWUpO+6VCOBWyU8C/DPttVT1CHIVl3rHDGxJhDZd5BpwpTTuCOYivdGCZMgvTlrcJ5QcTgNo4Xitzqvt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tryes9sD; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7180dc76075so3187689a34.3
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 13:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731445306; x=1732050106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Np2HS7VErQnH5FMWosVxy32s+aW8SW2AAxd4PD5Sltw=;
        b=tryes9sDzFe7B68pVz4fLlmP2Ul6ol15jTeTVzRW5x8DNxSE6uXcu4/hVFwpw1kaXs
         ePSOZpbapcE5SrV0ZR5NNFDcXpmhihmcQAeyy7ziZmsrMBCDHnW7O0MoujTXefosnIDp
         b1ac5suBdmHXAaltjfomdrbWIS/wegkEuwe5BpJdFD/im+9IXsWqrV5U2GvK9SMGD+QM
         I7zP2RL7yMmViXm2WEM0/LI6P+Eof158G7WUl67q7VHxZAd/AY9V5T15fM2uR5AX/xdA
         i2hwr9xLT36V/juO362xg3EfjFjGtymkTuVEX1q60hCoco64EPbJNNtrAHEqX9aIo+Hr
         XtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731445306; x=1732050106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Np2HS7VErQnH5FMWosVxy32s+aW8SW2AAxd4PD5Sltw=;
        b=MmDoKurd1TV4IE5xTh0KYcLyd0TTylh3momQXfLfiTi1ysMrhJuRIZS/J/8r9ehTQZ
         KKUOSAUyyYnyFq92P+VsnN8z+HuDgLwuHVILOjdRCIXjUnAPOu5J9gduH1HlR/zVk0rM
         gc5AZaDclayiz7ITGjJDiWGoF9J+lAvXfCEPXv8TW9gFQ8XiM5CSuo+NP8aiSUp8uBl2
         C0uqD3ue3MSaFnc66E3Pwffkrdy+FFBkn0nQjY/DDP0rH8z0iQUyAh8NPPN3hYBPZIc8
         6OHHry6fRmPsHtx5ZSmsKAaoHOdODIT62Qz5ptwl+Nv8iiDmARY2jwxRj8bDCYhkBsC2
         Rdeg==
X-Forwarded-Encrypted: i=1; AJvYcCXq7UljH9g1Hi1C+5fk6+2ee9kLe3luDpA0bUTOpl+NXClGUkWWMZo5H3i8+nW0MEGxQ8rSa/xEEmIf4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMm32cuhE96NdoyjM07pX+/sspL9XDIUl5ELdQJPbsB7mz0c8J
	RmOvmL9uyH1TUnZcH4CruMNsK7HjlR5vkZrG2K8hoj4xxh9eyG32dWc56YXa5yw=
X-Google-Smtp-Source: AGHT+IFzxC4sB9nk/tkKaqdvCQcLDCZqKij1mjEGG0+SaUye9b/bg8UgXHWZa6oX8SqEW2vIp+6UkQ==
X-Received: by 2002:a05:6870:6126:b0:289:ae2:b573 with SMTP id 586e51a60fabf-2955fca3e6bmr15337213fac.0.1731445306588;
        Tue, 12 Nov 2024 13:01:46 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-295e9337712sm80552fac.48.2024.11.12.13.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 13:01:45 -0800 (PST)
Message-ID: <5ecbdce7-d143-4cee-b771-bf94a08f801a@kernel.dk>
Date: Tue, 12 Nov 2024 14:01:45 -0700
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add io_uring interface for encoded writes
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20241112163021.1948119-1-maharmstone@fb.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241112163021.1948119-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 9:29 AM, Mark Harmstone wrote:
> Add an io_uring interface for encoded writes, with the same parameters
> as the BTRFS_IOC_ENCODED_WRITE ioctl.
> 
> As with the encoded reads code, there's a test program for this at
> https://github.com/maharmstone/io_uring-encoded, and I'll get this
> worked into an fstest.
> 
> How io_uring works is that it initially calls btrfs_uring_cmd with the
> IO_URING_F_NONBLOCK flag set, and if we return -EAGAIN it tries again in
> a kthread with the flag cleared.
    ^^^^^^^^

Not a kernel thread, it's an io worker. The distinction may seem
irrelevant, but it's really not - io workers inherit all the properties
of the original task.

> Ideally we'd honour this and call try_lock etc., but there's still a lot
> of work to be done to create non-blocking versions of all the functions
> in our write path. Instead, just validate the input in
> btrfs_uring_encoded_write() on the first pass and return -EAGAIN, with a
> view to properly optimizing the happy path later on.

But you need to ensure stable state after the first issue, regardless of
how you handle it. I don't have the other patches handy, but whatever
you copy from userspace before you return -EAGAIN, you should not be
copying again. By the time you get the 2nd invocation from io-wq, no
copying should be taking place, you should be using the state you
already ensured was stable for the non-blocking issue.

Maybe this is all handled by the caller of btrfs_uring_encoded_write()
already? As far as looking at the code below, it just looks like it
copies everything, then returns -EAGAIN, then copies it again later? Yes
uring_cmd will make the sqe itself stable, but:

	sqe_addr = u64_to_user_ptr(READ_ONCE(cmd->sqe->addr));

the userspace btrfs_ioctl_encoded_io_args that sqe->addr points too
should remain stable as well. If not, consider userspace doing:

some_func()
{
	struct btrfs_ioctl_encoded_io_args args;

	fill_in_args(&args);
	sqe = io_uring_get_sqe(ring);
	sqe->addr = &args;
	io_uring_submit();		<- initial invocation here
}

main_func()
{
	some_func();
				- io-wq invocation perhaps here
	wait_on_cqes();
}

where io-wq will be reading garbage as args went out of scope, unless
some_func() used a stable/heap struct that isn't freed until completion.
some_func() can obviously wait on the cqe, but at that point you'd be
using it as a sync interface, and there's little point.

This is why io_kiocb->async_data exists. uring_cmd is already using that
for the sqe, I think you'd want to add a 2nd "void *op_data" or
something in there, and have the uring_cmd alloc cache get clear that to
NULL and have uring_cmd alloc cache put kfree() it if it's non-NULL.

We'd also need to move the uring_cache struct into
include/linux/io_uring_types.h so that btrfs can get to it (and probably
rename it to something saner, uring_cmd_async_data for example).

static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issue_flags)
{
	struct io_kiocb *req = cmd_to_io_kiocb(cmd);
	struct uring_cmd_async_data *data = req->async_data;
	struct btrfs_ioctl_encoded_io_args *args;

	if (!data->op_data) {
		data->op_data = kmalloc(sizeof(*args), GFP_NOIO);
		if (!data->op_data)
			return -ENOMEM;
		if (copy_from_user(data->op_data, sqe_addr, sizeof(*args))
			return -EFAULT;
	}
	...
}

and have it be stable, then moving your copying into a helper rather
than inline in btrfs_uring_encoded_write() (it probably should be
regardless). Ignored the compat above, it's just pseudo code.

Anyway, hope that helps. I'll be happy to do the uring_cmd bit for you,
but it really should be pretty straight forward.

I'm also pondering if the encoded read side suffers from the same issue?

-- 
Jens Axboe

