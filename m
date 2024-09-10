Return-Path: <linux-btrfs+bounces-7909-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32181973C1A
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 17:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02B21F274B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 15:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F30199FD7;
	Tue, 10 Sep 2024 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="NpPsdmBL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DEB4204D
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982568; cv=none; b=BppsT54pLgJyA1t0GjzUp+UDa2TOvnCS7RMY7m8uZwQBjlsWcQsatNb1WlA/dp76Sda/CJS4sbP6tMHVv+9CWtv2mqDEB7DtosZp3l7uSrnUgr7n4R1rq8IpNArK15P2QE1IpuNNwXBOHXMts6msA3WtLhYDQdjwnRwiPrmEfeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982568; c=relaxed/simple;
	bh=R0zCdaEs6eQ7C5oatD0KOUvHXJnmDAA2o/Dgzc85/9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXI9O73Qg68JznzcR7SepqUzWSK9t4UZO6ioZ89qO4OkDQ4eahYGmFgcQfwg6hNb4F5aZJOOr6mtszVCwBKWjGAiFFaX8cSB8i+JZmzitTBkrNCWQLVmZ0u95u+WezedlYrzXaLTzd0kttYITGW0n7tlr6hnCbD9ABmeoY81mQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=NpPsdmBL; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4582face04dso19945501cf.1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 08:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725982561; x=1726587361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=47s/oRLZMOJLIhdwPl69xivEuKEr5oCTJ1/3hSW5TLE=;
        b=NpPsdmBLXBOc/vzN2qGwTAOCtR/UKEuvQoHwOGd871T/0JjMCEVA4zrcprkITJaDno
         LOIcPD9PcQvQhkthTlY5SsLQytzkKXMjWJCdVrE8Zguz+XFXg5ZkpPQMrX7uLd7RFA2v
         qEmk4iF9//L4+bxAh++hIIDArkN3GW3/WyrOvFv7fMH82+SydOgQ6PXetcEXe2uSExwc
         VkXo8qci956ur2+oM9R1BSfxT4ghYdff/xqGU7KqA7e1gv6tw5+1cMtBcGPjWoGVzgU0
         8QxqkzWadhwWQM1hXBd/5sNZ3NrRoKxYz5FzJzKNLGUyTAkhKGd5PGuEXlw+keGygL6W
         kwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725982561; x=1726587361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47s/oRLZMOJLIhdwPl69xivEuKEr5oCTJ1/3hSW5TLE=;
        b=Bs8zLdiD98Y1RDnOvpzBjkQbknkLA22Wi3si6HJtyy7Hvt3dFohmXSHLZJ2Ge5F28/
         CgNkL3gnLf08ZDLbOlciqqZ4ekgx5gi3XMX6fO7VTAydtzM3sGmDmfLvjDwLksc+9G2t
         Aj81dDFAMlIwGPBLJe+8F0WdrZi2BYkVpx6ZDtMH+dRvVX83JoKBBXLvGV9MmTkAMwUK
         o+40PiuT5wVaCyfZFRxr3mqhEKNXzILy/8D+95vSDiFal5bJHkL5/OBcBbNH/tZPMWYP
         AXXytR+qOka5bhJBRY5avcKI2CpNH4/J9XG4sZcZ+s1TkOyb8qQPZSX2QbbGgK67AzX0
         prUA==
X-Gm-Message-State: AOJu0Ywbl/TJBOawwXkpXqGEWLPbneyLvOm44iimOGIMGl7x2LinW0WK
	3jdXg6BWz40bfeL8en2y8IUEdDmPJLaUG3dAZtWY2qNjce4Rr9edG+O1q7TPIPJGrWJXg9nArh9
	J
X-Google-Smtp-Source: AGHT+IF3qILfQ/I4Ev4B4iK42r6BySP3aes7UaL9wyJDbf6TU9y4BD/gRKMSSIQBFTqrcKewpNLmdQ==
X-Received: by 2002:a05:622a:cb:b0:458:3bc0:f938 with SMTP id d75a77b69052e-4583c7006d9mr61206791cf.1.1725982561329;
        Tue, 10 Sep 2024 08:36:01 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822f6a988sm30424631cf.77.2024.09.10.08.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 08:36:00 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:35:59 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix race setting file private on concurrent lseek
 using same fd
Message-ID: <20240910153559.GA3943310@perftesting>
References: <a351fd3b0397b6fe8d94f11a6744e1655349d687.1725356877.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a351fd3b0397b6fe8d94f11a6744e1655349d687.1725356877.git.fdmanana@suse.com>

On Tue, Sep 03, 2024 at 10:55:36AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When doing concurrent lseek(2) system calls against the same file
> descriptor, using multiple threads belonging to the same process, we have
> a short time window where a race happens and can result in a memory leak.
> 
> The race happens like this:
> 
> 1) A program opens a file descriptor for a file and then spawns two
>    threads (with the pthreads library for example), lets call them
>    task A and task B;
> 
> 2) Task A calls lseek with SEEK_DATA or SEEK_HOLE and ends up at
>    file.c:find_desired_extent() while holding a read lock on the inode;
> 
> 3) At the start of find_desired_extent(), it extracts the file's
>    private_data pointer into a local variable named 'private', which has
>    a value of NULL;
> 
> 4) Task B also calls lseek with SEEK_DATA or SEEK_HOLE, locks the inode
>    in shared mode and enters file.c:find_desired_extent(), where it also
>    extracts file->private_data into its local variable 'private', which
>    has a NULL value;
> 
> 5) Because it saw a NULL file private, task A allocates a private
>    structure and assigns to the file structure;
> 
> 6) Task B also saw a NULL file private so it also allocates its own file
>    private and then assigns it to the same file structure, since both
>    tasks are using the same file descriptor.
> 
>    At this point we leak the private structure allocated by task A.
> 
> Besides the memory leak, there's also the detail that both tasks end up
> using the same cached state record in the private structure (struct
> btrfs_file_private::llseek_cached_state), which can result in a
> use-after-free problem since one task can free it while the other is
> still using it (only one task took a reference count on it). Also, sharing
> the cached state is not a good idea since it could result in incorrect
> results in the future - right now it should not be a problem because it
> end ups being used only in extent-io-tree.c:count_range_bits() where we do
> range validation before using the cached state.
> 
> Fix this by protecting the private assignment and check of a file while
> holding the inode's spinlock and keep track of the task that allocated
> the private, so that it's used only by that task in order to prevent
> user-after-free issues with the cached state record as well as potentially
> using it incorrectly in the future.
> 
> Fixes: 3c32c7212f16 ("btrfs: use cached state when looking for delalloc ranges with lseek")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

We should maybe re-look at our useage of btrfs_file_private and see if we can
come up with a better solution for this style of problem.  I think the directory
readdir stuff does the same sort of thing and we might end up with a similar
issue if we have two tasks using the same fd to do readdir.

But these are just random other thoughts for future work, for this you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

