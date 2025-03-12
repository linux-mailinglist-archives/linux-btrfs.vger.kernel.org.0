Return-Path: <linux-btrfs+bounces-12219-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DE1A5D4A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 04:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC7E77A667A
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 03:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF6019ADA4;
	Wed, 12 Mar 2025 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="DRt8hGco"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36878258A
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 03:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741748922; cv=none; b=j7Kl5x5B8tNiTJijqYdAJPbObG2d9yyzS5mOrgbjDPwsSmFH6c0/c6PivWahlXhxBn+KAptUN+zCw1dgX0crfwvsnkKX8t9tHPrvQNomqoEfwepucLV4EtCDUr/agf+YK1nSAuSjDPnc+VmNmvccUWygYWQlmbpbCRd2S2+psv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741748922; c=relaxed/simple;
	bh=CY++IkvGD9mzlNgjcURWiROXcjv3axhLujm4MpeGf3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKTcvbmNH8rODTzhbRs5ZYZ7sVZQU2Fi88m8H/9lS8KAv600BDHk25IGXyQpX0DtU34OjTSLkuRzGFy4RqmV+nEhAvefn8eR69BaEYqw9KJySutaWb4pcyC17VzcH8C2WNWxnqu/J7qsZs9prRHfEtUyES3qbT+ZkAL9ggpGAQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=DRt8hGco; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff80290e44so10462681a91.0
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 20:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741748920; x=1742353720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8qaaDT8d5dt68njAAVWgepNAkATZGX5grpaRU87Pye8=;
        b=DRt8hGcoQ2jw5YhG9jGErR0bDB9ZzGU4sYwoiys6xc8jCoZLbd0/wpa1kd6hvZ17bW
         AofF7mQ1WzEDiCPkW7tWL70Lpwzzw8B43k1QuhB8yahb73/mw1NlfA8tsiRwM5yFYxMy
         HmANzeXH6t7qNAfnWbKfHXD/Hv9AJWxhmT6K+GPNbdC3Lis04Dr76xGXJga2Sr3KJMLJ
         oPFlkQ3qRs1A5HriQJWBh2yqeCIw2njRTVThpzzIynpVO0EF1r643zDUf1pONvySpUEE
         2e8n+nPNPn5UzpCOB8Ao3kHZqxeYpQ9sbKf4XZwI3E00kJ48+QzgFlm5M5kIdE8mwS84
         B+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741748920; x=1742353720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qaaDT8d5dt68njAAVWgepNAkATZGX5grpaRU87Pye8=;
        b=aEuY3mR5hmtDwS71HHKMyhSytc+GGjo0GTzOfqUE5efeqla7tAXpnDrG6thLADchPO
         CLiHAbV58hSn62QvQjzGu4NqqmnRqDYNFmsUMkOE99iUpmMbKQ6wS0QyZfUQy0ixdvcE
         4JVaGsSmhZxGr5wbyMJoCpfY334Kso9j2Xh2jJBUxkmQ10bY60pzdupdCpXNPpWcXIsz
         D8FMmtuTNL+whg3gUfGnWzjr0vwNIfUAcri2PfwB/IHL3cQjlU/h/OxrhTRiOWimOqhh
         O0YqkTwU0w0yIAEC3pfhQu7C1KbxeOGbgLZ+0TyhPjvSFDHk+eHpiBjaL0wCd2TdhIbZ
         aQPg==
X-Forwarded-Encrypted: i=1; AJvYcCVTTpCq6R3v96krnSJLEApm9Xq8C/DquoB6EF0ZTHWm9HNt0lTf0RaKh6JE3r1KLiTi9S5aRX3MAfiPSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1icsFuz2gBOdoU1YiQDuDW/3qa/IwDKBOhevVQ6VMId0H92ns
	6meaJayKUCt3tpwM0BBkEkBZKk+YuUdq9sc5Ro3HvwO1mwT7SSbUNOPCOf22zhs=
X-Gm-Gg: ASbGnctuTjx+/HRe+tGjyRZHWfK8Xul22jOk1Ldti1oSu7ZQdxmlRxfLHw45r7d91/M
	4Zt8CI+duqr/llf4UNO0cTJM6wmIR+Xp15CqQh5m3srZZAdAXmhBwWkQl0xgAccDSA8KFLYbFma
	4IVdSKYnk/AhX6ri3RLDW1nXLSekG2ovwR1VyriMWFrNIBPch0m7eXAcaB0x3mo+7PtdW6MLh5Y
	1Vm1a+XIGw3IKVrgXjh3xOe7V7zmTmmPs1BHDCoK1vwAkLf5s45m8zZCdsG82jwT7ihgC85ROfD
	PhlpEeXwHBp6zYUcFGlU3kSxV/NbbyF70Yh25vT6LO2OF7rXUsO1xFs6c5085C8MZJHx07UUyJ+
	K
X-Google-Smtp-Source: AGHT+IGTTCfJTEC2v4WnJsJwRKxs0QJmhoql3RTNGhVrIBaPATqhYsGs2lZika80jl4UZPlO/JOJHg==
X-Received: by 2002:a05:6a21:3989:b0:1f5:6680:82b6 with SMTP id adf61e73a8af0-1f56681a9dfmr22689470637.38.1741748920474;
        Tue, 11 Mar 2025 20:08:40 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736a336010dsm10712509b3a.59.2025.03.11.20.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 20:08:40 -0700 (PDT)
Date: Wed, 12 Mar 2025 12:08:36 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] io_uring: cmd: introduce
 io_uring_cmd_import_fixed_vec
Message-ID: <Z9D6tDJPLxApNESZ@sidongui-MacBookPro.local>
References: <20250311114053.216359-1-sidong.yang@furiosa.ai>
 <20250311114053.216359-2-sidong.yang@furiosa.ai>
 <8b5cd4f9-5c45-4ffb-be9a-d8dd6d0baf53@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b5cd4f9-5c45-4ffb-be9a-d8dd6d0baf53@gmail.com>

On Tue, Mar 11, 2025 at 01:08:14PM +0000, Pavel Begunkov wrote:
> On 3/11/25 11:40, Sidong Yang wrote:
> > io_uring_cmd_import_fixed_vec() could be used for using multiple
> > fixed buffer in uring_cmd callback.
> > 
> > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > ---
> >   include/linux/io_uring/cmd.h | 14 ++++++++++++++
> >   io_uring/uring_cmd.c         | 29 +++++++++++++++++++++++++++++
> >   2 files changed, 43 insertions(+)
> > 
> > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
> > index 598cacda4aa3..75cf25c1e730 100644
> > --- a/include/linux/io_uring/cmd.h
> > +++ b/include/linux/io_uring/cmd.h
> > @@ -44,6 +44,13 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
> >   			      struct io_uring_cmd *ioucmd,
> >   			      unsigned int issue_flags);
> > +int io_uring_cmd_import_fixed_vec(const struct iovec __user *uiovec,
> > +				  unsigned long nr_segs, int rw,
> > +				  struct iov_iter *iter,
> > +				  struct io_uring_cmd *ioucmd,
> 
> nit: it's better to be the first arg

Thanks for tip.
> 
> > +				  struct iou_vec *iou_vec, bool compat,
> 
> Same comment, iou_vec should not be exposed. And why do we
> need to pass compat here? Instead of io_is_compat() inside
> the helper.

Actually I don't know about io_is_compat(). Thanks.

> 
> > +				  unsigned int issue_flags);
> > +
> >   /*
> >    * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
> >    * and the corresponding io_uring request.
> > @@ -76,6 +83,13 @@ io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
> >   {
> >   	return -EOPNOTSUPP;
> >   }
> > +int io_uring_cmd_import_fixed_vec(int rw, struct iov_iter *iter,
> > +				  struct io_uring_cmd *ioucmd,
> > +				  struct iou_vec *vec, unsigned nr_iovs,
> > +				  unsigned iovec_off, unsigned int issue_flags)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> >   static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
> >   		u64 ret2, unsigned issue_flags)
> >   {
> > diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> > index de39b602aa82..58e2932f29e7 100644
> > --- a/io_uring/uring_cmd.c
> > +++ b/io_uring/uring_cmd.c
> > @@ -255,6 +255,35 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
> >   }
> >   EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
> > +int io_uring_cmd_import_fixed_vec(const struct iovec __user *uiovec,
> > +				  unsigned long nr_segs, int rw,
> > +				  struct iov_iter *iter,
> > +				  struct io_uring_cmd *ioucmd,
> > +				  struct iou_vec *iou_vec, bool compat,
> > +				  unsigned int issue_flags)
> > +{
> > +	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
> > +	struct iovec *iov;
> > +	int ret;
> > +
> > +	iov = iovec_from_user(uiovec, nr_segs, 0, NULL, compat);
> > +	if (IS_ERR(iov))
> > +		return PTR_ERR(iov);
> 
> That's one allocation
> 
> > +
> > +	ret = io_vec_realloc(iou_vec, nr_segs);
> 
> That's a second one
> 
> > +	if (ret) {
> > +		kfree(iov);
> > +		return ret;
> > +	}
> > +	memcpy(iou_vec->iovec, iov, sizeof(*iov) * nr_segs);
> > +	kfree(iov);
> > +
> > +	ret = io_import_reg_vec(rw, iter, req, iou_vec, iou_vec->nr, 0,
> 
> It's slightly out of date, the import side should use io_prep_reg_iovec(),
> it abstracts from iovec placement questions.
> 
> > +				issue_flags);
> 
> And there will likely be a 3rd one. That's pretty likely why
> performance is not up to expectations, unlike the rw/net
> side which cache it to eventually 0 realloctions.
> 
> The first one can be easily removed, but it'll need better
> abstractions for cmds not to expose iou_vec. Let me think
> what would be a good approach here.

Totally agreed, There is too many allocation for this. It should be done
allocation.

Thanks,
Sidong
> 
> -- 
> Pavel Begunkov
> 

