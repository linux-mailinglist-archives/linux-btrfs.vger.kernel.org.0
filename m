Return-Path: <linux-btrfs+bounces-12465-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8DDA6AAE9
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 17:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589193BB107
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 16:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C2C2144C9;
	Thu, 20 Mar 2025 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="AqttIiog"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAEF1B81DC
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487581; cv=none; b=YRnhJ/yUFTMOaqdLg7Pyot86TjcIp+kMFKEajZ1tfA11iA4WkSFsNMDx5XEI91v/fzoDduEdOlSEVStOQF8NElJdudlTr8aryNpZ/MJyYF0yG/H/emvqyvehoPRzKAf6KkLz1TJSdlb7Tgz1aogNF/6faWTq2D3wrikpQD3eiNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487581; c=relaxed/simple;
	bh=qBJxg1shh5xIWb/EGEp/yZw666gWV1SYFdnG1TDjCyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQclUhGaMCiENkMVezUToCrZD5Y+2fWMFT9jiurgmoDcfsmmJn6hc3oSjJlTThpo8TOHVvRETCMvAwydNWFDGnqFWbiBRkRKSVCOSzzfAGvSL0P6s68LMtTMZLEStuCf8L/RxmHSPaD/mrYJ5dTLGzOIDlR79CPc3oxRR69o7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=AqttIiog; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223fd89d036so20306025ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 09:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742487579; x=1743092379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E1EkxBQfCDmnx+n40Vp0lQXT3U/EpuuEwT1O/tsDLy8=;
        b=AqttIiogKzRrEVtvUGN2K9Xsux6kBQ2eXR67MVBG4b3bnlxxH0x9ujI7g+xf0dDygc
         /77HOQjrRowrjmnxrsM31rVDKtp8XbnQuZXKey0UadV+fSD9oIs2KIBVncoerm3xuqUA
         JMMuYK4WfcieUGuLUPB3PYzowcUH0cB7ZzNwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742487579; x=1743092379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1EkxBQfCDmnx+n40Vp0lQXT3U/EpuuEwT1O/tsDLy8=;
        b=LCtkzMKFw4haSUwWiNfqllHFd6e8wYFa1c5xU1wY6t9FazA2Q3UVDTcqDlwmNimn+T
         bk+IwqoyOm4m91VrDbaJA8vfa8m5cizGLCbGWZdysudy+EG+vn1+adsBcUau6KRYLISn
         jReIk2IigzwV9/C0YDIXwmzF3V+mxY1Qyw7PXEOOgimBtXBJDWBO4xIVajJL6eT9vD4K
         Z4GBgVPisARESpvxZT1YQ7w7GHqOdMPDrFiwqKSU4qI1J7WTt5iyhuj0m7vzPMTmRcy7
         AY5jW4FsudmhSdtza3skuvZMmLxNxxTDB2RoTgRia0RqcLb7m/UNWyOTx/Vpe60VrGnP
         4bJg==
X-Forwarded-Encrypted: i=1; AJvYcCXLlLU+UeZWdbQF7Cp6GSHVQ4EJtEcVbWtMDME4tcSLnkNYt+V9pCa7Im80hittQNgfAkXZ5WlTVP5RMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx45to/Ij2faTO2tRWDHtfWzM0Sj5LmPZUqCcpe0m2hc/oITW5D
	9xMAiBfCebGLcIrLugLskGg+6WMtBC5tl0K0RwJ1VoKT3lfM8VwWMMoU4CUTbCh39+eJj9MdjfM
	1
X-Gm-Gg: ASbGnctGbl5mrbmE1rfsYaFrfjO1rVbmIzd3O3OUK0ZyLAaEZU/ibGHi6NupzprRNzN
	Wka+ThbEZjnFkpslifyrcv9Yc+OI2eStR/ve9rxuDheslvVLuSd1O0mWwBQDcDD6oQWj2x6/9On
	f+bM04zz5cg7EVXjN2hmViJaInEiyXV2spmPCcY9R2ajuZJ16DEmxrrXPxACwXNs+h6TxL95ciI
	xU3leaZS/X/rP85XgfoYOtmGL9XT0QpnE/k3MpinH8nJ1OLvwPWen67ghaHAIU4MQjzge/uaaJP
	HsKo49e1jhmPd3lcVCEKQrhR9rWiHkDHvhSdZiz7iKI9kP9U7iOA7JAba4yL3QXH61NJ4Pq5R/7
	u
X-Google-Smtp-Source: AGHT+IHkoC8+a/PI1OgLEI6QOhiYG1kobquqNfEOAiiqzCU00hktNWB4i+b5NArdRabJhomNAfkeIg==
X-Received: by 2002:a17:903:2301:b0:220:f151:b668 with SMTP id d9443c01a7336-22780d9597dmr51485ad.20.1742487579151;
        Thu, 20 Mar 2025 09:19:39 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe766sm137642715ad.184.2025.03.20.09.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 09:19:38 -0700 (PDT)
Date: Fri, 21 Mar 2025 01:19:34 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v5 5/5] btrfs: ioctl: introduce
 btrfs_uring_import_iovec()
Message-ID: <Z9xAFpS-9CNF3Jiv@sidongui-MacBookPro.local>
References: <20250319061251.21452-1-sidong.yang@furiosa.ai>
 <20250319061251.21452-6-sidong.yang@furiosa.ai>
 <14f5b4bc-e189-4b18-9fe6-a98c91e96d3d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14f5b4bc-e189-4b18-9fe6-a98c91e96d3d@gmail.com>

On Thu, Mar 20, 2025 at 12:01:42PM +0000, Pavel Begunkov wrote:
> On 3/19/25 06:12, Sidong Yang wrote:
> > This patch introduces btrfs_uring_import_iovec(). In encoded read/write
> > with uring cmd, it uses import_iovec without supporting fixed buffer.
> > btrfs_using_import_iovec() could use fixed buffer if cmd flags has
> > IORING_URING_CMD_FIXED.
> 
> Looks fine to me. The only comment, it appears btrfs silently ignored
> IORING_URING_CMD_FIXED before, so theoretically it changes the uapi.
> It should be fine, but maybe we should sneak in and backport a patch
> refusing the flag for older kernels?

I think it's okay to leave the old version as it is. Making it to refuse
the flag could break user application.

Thanks,
Sidong

> 
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> > 
> > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > ---
> >   fs/btrfs/ioctl.c | 34 +++++++++++++++++++++++++---------
> >   1 file changed, 25 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 6c18bad53cd3..e5b4af41ca6b 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -4802,7 +4802,29 @@ struct btrfs_uring_encoded_data {
> >   	struct iov_iter iter;
> >   };
> > -static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue_flags)
> > +static int btrfs_uring_import_iovec(struct io_uring_cmd *cmd,
> > +				    unsigned int issue_flags, int rw)
> > +{
> > +	struct btrfs_uring_encoded_data *data =
> > +		io_uring_cmd_get_async_data(cmd)->op_data;
> > +	int ret;
> > +
> > +	if (cmd->flags & IORING_URING_CMD_FIXED) {
> > +		data->iov = NULL;
> > +		ret = io_uring_cmd_import_fixed_vec(cmd, data->args.iov,
> > +						    data->args.iovcnt, rw,
> > +						    &data->iter, issue_flags);
> > +	} else {
> > +		data->iov = data->iovstack;
> > +		ret = import_iovec(rw, data->args.iov, data->args.iovcnt,
> > +				   ARRAY_SIZE(data->iovstack), &data->iov,
> > +				   &data->iter);
> > +	}
> > +	return ret;
> > +}
> > +
> > +static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd,
> > +				    unsigned int issue_flags)
> >   {
> >   	size_t copy_end_kernel = offsetofend(struct btrfs_ioctl_encoded_io_args, flags);
> >   	size_t copy_end;
> > @@ -4874,10 +4896,7 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
> >   			goto out_acct;
> >   		}
> > -		data->iov = data->iovstack;
> > -		ret = import_iovec(ITER_DEST, data->args.iov, data->args.iovcnt,
> > -				   ARRAY_SIZE(data->iovstack), &data->iov,
> > -				   &data->iter);
> > +		ret = btrfs_uring_import_iovec(cmd, issue_flags, ITER_DEST);
> >   		if (ret < 0)
> >   			goto out_acct;
> > @@ -5022,10 +5041,7 @@ static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issu
> >   		if (data->args.len > data->args.unencoded_len - data->args.unencoded_offset)
> >   			goto out_acct;
> > -		data->iov = data->iovstack;
> > -		ret = import_iovec(ITER_SOURCE, data->args.iov, data->args.iovcnt,
> > -				   ARRAY_SIZE(data->iovstack), &data->iov,
> > -				   &data->iter);
> > +		ret = btrfs_uring_import_iovec(cmd, issue_flags, ITER_SOURCE);
> >   		if (ret < 0)
> >   			goto out_acct;
> 
> -- 
> Pavel Begunkov
> 

