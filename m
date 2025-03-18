Return-Path: <linux-btrfs+bounces-12363-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695EBA66D18
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 09:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD73167550
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 07:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC0A1EF379;
	Tue, 18 Mar 2025 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="k1kq3hUL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCE61C860C
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284706; cv=none; b=mc+Gth05CDvoDhnPayv/J8NfPP0o3ZEc+/J+s0+1QxrpBOvgLUix2XdtVzbesItAtOWdHNHC/Qc7jjh7r90So+ppKGj3NQG22CIgIVXY3XcHYOwCgCvNz496MxWiKmAtDWtyTZxvo79i/mfjH106GD2GhIE6LHHVLjZ4Q5Tjp6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284706; c=relaxed/simple;
	bh=al49eM+1tgW5ACzH7lMAhrHbpJE/ZKJWrX8DKNsNMbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4LANlKsWIKtjNVAznHhF+CDJtXvlJABxmwaK+QaOWTfyY50q7jK2s7iaM+sOym47/ET4e29oAoZuC7zBJ3hSnG8dArW9gRZr/fVPqjEvGxKg2uVTSxFZMhEDrgYQSSXl4rRg/GYGksVqS57AQgs/eNxXvei0PpYnWOYkaNmvbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=k1kq3hUL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2243803b776so60728515ad.0
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 00:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742284704; x=1742889504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JjqSNVE0Cph4A/90eA+y7Se4Hin9uKNNKIYlFXcRpQc=;
        b=k1kq3hULFaIoP60zLinyPlm/oWo3dzLfE6C/8xathyU6CcfVrKNNf72Z4uGsMSV3un
         IGt3+dLehqa64pOQym5tZIbF3jNhvBUH3jfrAemiyfFa+bYlDuS1F/8jLMYg2MlEmo44
         y+AwC5WMR5BmSw6/XcqJtnAH1RblIEvmWx3mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742284704; x=1742889504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjqSNVE0Cph4A/90eA+y7Se4Hin9uKNNKIYlFXcRpQc=;
        b=VpDnS7O1YVgKyymxq2X6S/wsDRSfx/+PYxQJr439Er1OEj2FYFqPNn2hq1f9ooT90F
         If99HJ9VR/NAZflhkkAdFMFP7yuzjpcMTvW0gJLICTvsQ6p+n9tRF4n03RedMIz8sCW6
         /6PSkSyYpaWOp4IyEE03oyYPgtSIs/tF5nIvuQCzJrMVosf0iK0H6xnoz03D11GnWHFx
         FBqN/W+2Ap7Y61Go/txC/8W8a7IER/xR0vUPlzHR63q0zXiQLZ/mrZYFgEU0vv0WHZNR
         YHnYOD/IgBaqmONTBOVqhg3FqEmo+5RDWJRzhzOHMP7/FRvHrLqDHSVEUGU8kd7Iys5N
         fhHw==
X-Forwarded-Encrypted: i=1; AJvYcCXWMx/V81am4zut0PZ6t5pqod2O5xM+gOIp86cBilflQk+xMUcyFX3hTVMrzg7Pe6k1Id35CyZVtrOeHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7vef5p9+Fb3CJXEYbJSZkTCHFBD8IqhmvU+H+6FLBjkn3OjcR
	d9r6QiMTiWE7WQg/DCPpmSWzB1vgolxo4hK2+Rtqn+ubTKRMAYpsPWapR5bx+5o=
X-Gm-Gg: ASbGncsesU2WJLLJkgPPmcZ0KFQk4/ZQbRKWsCKe5m9VAbFIus0AfPAYplRk6sP5qcc
	FTMNF6TRcO/CNs21GCMSdzz6g+QzmuMa8dE3oh0/4VhHfK6mTqQ1+I6qGy2uHaFn9wAikbJl/Ds
	QPKo0dG/EvZu58lLZXBVpAgpvwait/3JIX9C8Idr/EXE4dA3szNcQV4EFp9tAEOcdNzkbetAlLI
	9wiOnXnldS3FMQ6G3lAsPnLk4Ari3jGyWQyuZZ3e/BKRyXDvr8m+mP80GYTmS8aLWTp0VJ809TI
	XywI4g1Ucjplopm8kI/vE9FcgqHh9oFywpoIrtWsA/y24ifAf5YBW4PgOdV6boyxBJuohJrb+sp
	/
X-Google-Smtp-Source: AGHT+IFoYIbKKLN/4JYODjVS6d9sUEzicBL53lbs5mcV9y8CEd9goF6jVujShbqHMNdGwaaPjoahMQ==
X-Received: by 2002:a17:902:f711:b0:224:b60:3ce0 with SMTP id d9443c01a7336-2262c515130mr30785105ad.5.1742284704551;
        Tue, 18 Mar 2025 00:58:24 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([221.148.76.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6889eeesm88219725ad.29.2025.03.18.00.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 00:58:24 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:58:20 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
	Mark Harmstone <maharmstone@meta.com>
Subject: Re: [RFC PATCH v4 5/5] btrfs: ioctl: don't free iov when -EAGAIN in
 uring encoded read
Message-ID: <Z9knnGBRQVdFh6nO@sidongui-MacBookPro.local>
References: <20250317135742.4331-1-sidong.yang@furiosa.ai>
 <20250317135742.4331-6-sidong.yang@furiosa.ai>
 <849ce82d-d87a-428a-be79-abdeb53a1a99@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <849ce82d-d87a-428a-be79-abdeb53a1a99@gmail.com>

On Tue, Mar 18, 2025 at 07:21:00AM +0000, Pavel Begunkov wrote:
> On 3/17/25 13:57, Sidong Yang wrote:
> > This patch fixes a bug on encoded_read. In btrfs_uring_encoded_read(),
> > btrfs_encoded_read could return -EAGAIN when receiving requests concurrently.
> > And data->iov goes to out_free and it freed and return -EAGAIN. io-uring
> > subsystem would call it again and it doesn't reset data. And data->iov
> > freed and iov_iter reference it. iov_iter would be used in
> > btrfs_uring_read_finished() and could be raise memory bug.
> 
> Fixes should go first. Please send it separately, and CC Mark.
> A "Fixes" tag would also be good to have.

Okay, I'll remove this from patch series.

Thanks,
Sidong

> 
> > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > ---
> >   fs/btrfs/ioctl.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index a7b52fd99059..02fa8dd1a3ce 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -4922,6 +4922,9 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
> >   	ret = btrfs_encoded_read(&kiocb, &data->iter, &data->args, &cached_state,
> >   				 &disk_bytenr, &disk_io_size);
> > +
> > +	if (ret == -EAGAIN)
> > +		goto out_acct;
> >   	if (ret < 0 && ret != -EIOCBQUEUED)
> >   		goto out_free;
> 
> -- 
> Pavel Begunkov
> 

