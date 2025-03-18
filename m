Return-Path: <linux-btrfs+bounces-12351-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7617A665E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 03:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3986D1884798
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 01:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A8417A319;
	Tue, 18 Mar 2025 01:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="DDEOx4oT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5DF1494DF
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 01:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742263145; cv=none; b=ttlGurShsCbtnjq1qlpVO8z/ZcQsx2dl57ZfKZ6NQvAexGvb1cmYHLFCfMcIC5yk6rY4I+5T5jD3nlcaEwBT0AlgBgWoDKKOEOzx36nUWgvp4Fp+VLv3IfD1s8kSjE23zXsxMWdz52vEdYexqeEy6ArRkfSrPEEvLKmu+XelE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742263145; c=relaxed/simple;
	bh=L1Ne+QTLuSdegNnkSjDRJuIzUEEggu+Dwn3f9jsYy+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXfUG2DDNO2jsLkd3MkiGoE5WizbXaqbg/rJqTBW3wNRRRMLtIhhL5jfege9dCTCUUa6ieA/5VpEq9dKMKIW3uPLa4bgrZAwuzItE1lRl4H8a7SkXmAeRUdSesg9A10NFB7kyXj0RD5tDnf4lGi+ePjWYhS28BVJFFaeWj4guxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=DDEOx4oT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2243803b776so55550015ad.0
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 18:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742263142; x=1742867942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yOwruOmPjgZz22CNw0HJ3t+DF5i9C0EpnBm3V/TK2zc=;
        b=DDEOx4oTrDtwtJdbXQOiMaw/Xiledcg/Op42tkWZvxSEDTTvnI7HKFRHD0vz9JmZe9
         5rRDFh1n2N8RDaXMucjfPw6CEkGKVpxgNZuAQrMEW/ls85HUWi6B5/V6FRJYYNImxGIy
         G6zI2hErgZq3i1v6ygEA41/dZw5P8AcIfec9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742263142; x=1742867942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOwruOmPjgZz22CNw0HJ3t+DF5i9C0EpnBm3V/TK2zc=;
        b=u3FN+XHQMN6Y19eIDlaesjqVMvLN4Mo5HYVXnqwBUzc2ZHRi4A8JiOfTPhNJyYr1pm
         Zs/lUHobixG5pK7SseAozD+rng3qrgP8/99hlHUKeouNKR4IuYFEtu4hFH0hAEFIa5qI
         ldsRW1Gg0VKpesZLDWWY1hzykVl/zmBLC+Zvu/WwIetX5xFcuFKY6pbD4K7wBlrqQrR0
         D7YM0gAEkRykNqRA1xEoGew1qBmbmZtmpYAnU55n2AEksrP2hBjINAw5c2Q531cpRpJp
         dJedTAt32X/I6U8cpsRVSgmaYsw7WmvTywEoWqKsdt1WiHROHjODbrxW+t4yFO7SawQ4
         gjmA==
X-Forwarded-Encrypted: i=1; AJvYcCVBF48YehAvZC4HC1VdonGypT7ZWe0vsG2+BBQOYeHJuHTBUZZiIKiRfHJ0n9qxwY4SEZq7YXFPTjH0hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSfoIDI10UEWF/QnZ1Kx9SQR15c6AtMNC2e1gytxKf2q1rsHFo
	h0NqA0BQbSbPauwqpdZ8h10eOzWOhz/RdTrrjzBEB2L6MATBvjf0LgzZpii1IXY=
X-Gm-Gg: ASbGncv3jYpYlyO+aUwdJrGIexJk8pEkxuesayL5/XEPFvYcIeM/NekfwpBa9lCgwpd
	pKekH6MDYwVemZJjnRlHZDWSawO7dV4vJsNSpBeY151XhnczPW7s6L9QGfuiYEWkMeV8injXtW7
	X/S+B0/QdAHzFVr1ll0g5XXNmDcKNMYN8e51C7qQpV2wlE4C1m7iqf7+yIg9x3fdS6Fl/9CNv2G
	Qed+yY72Xh0HLCrXtFum5mo+HqsVfnqbXywA/2jSjWCPc6YRVyHRjvcsxL5+tnlG6uz+5/PyJYP
	IoXVg6b9jHduHJNbK4F9qh9dMg2x/yrPKr39i2SRmjBIuI0KVPMFaVnYP+Bzg8Tufr0WetTXATm
	I6y0D8g==
X-Google-Smtp-Source: AGHT+IHqhx0/CqW3BpT7+MPNBrTrcJBjwwRUne8O/7u2qtvmr8uSD5puhwybpej9PasKSNdyCQO0rg==
X-Received: by 2002:a05:6a00:3d55:b0:736:ab48:18f0 with SMTP id d2e1a72fcca58-73757205e9cmr1957081b3a.1.1742263142384;
        Mon, 17 Mar 2025 18:59:02 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([221.148.76.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711695b88sm8296766b3a.152.2025.03.17.18.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 18:59:01 -0700 (PDT)
Date: Tue, 18 Mar 2025 10:58:57 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v4 4/5] btrfs: ioctl: introduce
 btrfs_uring_import_iovec()
Message-ID: <Z9jTYWAvcWJNyaIN@sidongui-MacBookPro.local>
References: <20250317135742.4331-1-sidong.yang@furiosa.ai>
 <20250317135742.4331-5-sidong.yang@furiosa.ai>
 <3a883e1e-d822-4c89-a7b0-f8802b8cc261@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a883e1e-d822-4c89-a7b0-f8802b8cc261@kernel.dk>

On Mon, Mar 17, 2025 at 09:40:05AM -0600, Jens Axboe wrote:
> On 3/17/25 7:57 AM, Sidong Yang wrote:
> > This patch introduces btrfs_uring_import_iovec(). In encoded read/write
> > with uring cmd, it uses import_iovec without supporting fixed buffer.
> > btrfs_using_import_iovec() could use fixed buffer if cmd flags has
> > IORING_URING_CMD_FIXED.
> > 
> > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > ---
> >  fs/btrfs/ioctl.c | 32 ++++++++++++++++++++++++--------
> >  1 file changed, 24 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 6c18bad53cd3..a7b52fd99059 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -4802,6 +4802,28 @@ struct btrfs_uring_encoded_data {
> >  	struct iov_iter iter;
> >  };
> >  
> > +static int btrfs_uring_import_iovec(struct io_uring_cmd *cmd,
> > +				    unsigned int issue_flags, int rw)
> > +{
> > +	struct btrfs_uring_encoded_data *data =
> > +		io_uring_cmd_get_async_data(cmd)->op_data;
> > +	int ret;
> > +
> > +	if (cmd && (cmd->flags & IORING_URING_CMD_FIXED)) {
> > +		data->iov = NULL;
> > +		ret = io_uring_cmd_import_fixed_vec(cmd, data->args.iov,
> > +						    data->args.iovcnt,
> > +						    ITER_DEST, issue_flags,
> > +						    &data->iter);
> > +	} else {
> > +		data->iov = data->iovstack;
> > +		ret = import_iovec(rw, data->args.iov, data->args.iovcnt,
> > +				   ARRAY_SIZE(data->iovstack), &data->iov,
> > +				   &data->iter);
> > +	}
> > +	return ret;
> > +}
> 
> How can 'cmd' be NULL here?

It seems that there is no checkes for 'cmd' before and it works same as before.
But I think it's better to add a check in function start for safety.

> 
> 
> -- 
> Jens Axboe
> 

