Return-Path: <linux-btrfs+bounces-12218-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C08A5D496
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 04:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399233B55CE
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 03:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2983198E8C;
	Wed, 12 Mar 2025 03:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="G1jxs9nR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DE012B93
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 03:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741748747; cv=none; b=evv60xwcGsT2dRK/eBFHQUWcJsWfG371FhZWFJ6Z0zfLLhh5Z2KFTrYKlRFOJ4nsYuLltV630muyQlpQ+4ooxcsu6/7ZWXRFzKU3bWjKhiapfFLUqCLCzAlfl++UfmZCchXbv7Qo28JzkdaZn2e/HLH+ohLk3CuAUsQFhnzIg3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741748747; c=relaxed/simple;
	bh=AZVGWwpSs6vVA7gZ8qiQaYBcWp/tS3lx7Jf9klKPgbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MB5GmLqV5zqPvsnVZNr7PUDZ+xlS3X1lccA4dcMnLry90fucTen9ZO5dCQ8zAF9A3wWJiPMXzkeAgAIublJprtf0ybU48DCwUdBm6jDFPckN+RKCAeFdPFDjODZoA7UT4m+SvUj1tcD2Tv73bTbUcPbIdLOWt9XZQVkDVqwUD+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=G1jxs9nR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22435603572so73711535ad.1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 20:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741748746; x=1742353546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxIJUbJst/FnriyNqJsBfUw8Y0pzbE0QuiyjoQaWCNg=;
        b=G1jxs9nR1wX916WyUOWmw+jdyfOl1AYHXHQSTF5BON4UULyyQTjqBj97bd1dKGmvFa
         71AVhzIrWlDDn+O7Wcyy9jb8EO25qS0v9zRbLz7UBiQetF4VoXPS0ACkZU3dL3XTDhi4
         USywb72AcbfjGBesV25Rj3NufF4FVoBBq1owVHpojE61f0nd9BYVBxcZnmHg28SYEPKr
         UU34v/t1rJ8XLwoqQdqj+oZ34dHLKOdUiZy+16HsPayu7/GtT7nwA1jGcOJihMQ/ncuI
         jcsC5tXZoaNzjN4d1SEWB29b8Kl3H/Gq/6QaDwRj7eL2FvQlWiccYm4IsZmrBRj+TPj4
         5bMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741748746; x=1742353546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxIJUbJst/FnriyNqJsBfUw8Y0pzbE0QuiyjoQaWCNg=;
        b=uJ07lbxKklNCMNV/fGS23d/xGt7A8o/gCCqirIbjmfKpnoDxHviJxSPq+BBV6A1EKE
         RY94aJt15ThQ32VXlxZxkNCo3WUwjJdQ5Lf35RbU0mDamoyoI7KeTUDBfTfaXNKbirnX
         tM1Ab+t8KGPBB1idHQYJZ0qpyNbb/UZ+NIfnSyF9nQ351bB8y1JlsFyF/xF3D5HLZaks
         uqTxUD/3aG3hQJRNa1byQe91U4YqaN3bI1edIuGp8EOj/yWC/1MgcdL6SPwEcdmi39tJ
         sMxhS49IuiQqqgLMqgWTwRFanqjr3viOrkqIm79sjiDeTf5bqWCIEEKIUoG9zE3x7H4a
         uzDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdSZrbV8Cc4CD2nD2t1WWhJIb9nSC8BilwyMg0pAO/qGscaRVbjw2x6HpGGhJPWiDZtL+CuMlYNcZ8vQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl8SDJDKMdx/VaAXxWPaqDE2tm9kPeggE3Pm7fXFS95PP2rpXl
	RZBVadiSx4f0v47u70uVami+VBn9DOtSSRJ9E6NRI+PNDoUIczHUr+a0bRzodKc=
X-Gm-Gg: ASbGncthtaKKA/o0MoTT+KQ4FkoW6k5f8k4FbtJbBmD6lEJjM6xXEPSupEje3BFVNKM
	MMsfODM+sA4yC2BwI8oR0Jne+pLuAe0uus3IVDAoR9rESe8EuAdnoJQp5nYiYGRRPYCBLPCV4do
	/a6HjhtLbIrIYrtZb9WgY1TNZ0roM1DJC168k4TANMEvefdDFZmxtXpIo8Qdc9yrBh0FadYLgL/
	4I8ZjFjJGGoLOmNGhRw9Jogxu78igo11auW4P2G7T0qhnl/8vDkYl00ROgiltayN78avJslgP+8
	t4VvQNReXc95QrLUSFn20nY0zxUT6amzXq+xhFhkYofv6XL9Aym+H4nv44OoTR0dHo0A99C3Rcr
	F
X-Google-Smtp-Source: AGHT+IEMHkbd6b0xTC0DUBVIL+QnQKlshOyaYInuo6Qt8/bg6Hart/Gd6hDiomd/nTFlnaC/tp1Mrw==
X-Received: by 2002:a05:6a00:174b:b0:736:5f75:4a3b with SMTP id d2e1a72fcca58-736aaa1cfaamr28287847b3a.7.1741748745637;
        Tue, 11 Mar 2025 20:05:45 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736bf9f1852sm7433158b3a.117.2025.03.11.20.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 20:05:45 -0700 (PDT)
Date: Wed, 12 Mar 2025 12:05:30 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] btrfs: ioctl: use registered buffer for
 IORING_URING_CMD_FIXED
Message-ID: <Z9D5-muwGmdVqSDl@sidongui-MacBookPro.local>
References: <20250311114053.216359-1-sidong.yang@furiosa.ai>
 <20250311114053.216359-3-sidong.yang@furiosa.ai>
 <58181ba7-dcb5-4faa-a03a-8ff88cbffc24@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58181ba7-dcb5-4faa-a03a-8ff88cbffc24@gmail.com>

On Tue, Mar 11, 2025 at 12:55:48PM +0000, Pavel Begunkov wrote:

Hi Pavel,

> On 3/11/25 11:40, Sidong Yang wrote:
> > This patch supports IORING_URING_CMD_FIXED flags in io-uring cmd. It
> > means that user provided buf_index in sqe that is registered before
> > submitting requests. In this patch, btrfs_uring_encoded_read() makes
> > iov_iter bvec type by checking the io-uring cmd flag. And there is
> > additional iou_vec field in btrfs_uring_priv for remaining bvecs
> > lifecycle.
> > 
> > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > ---
> >   fs/btrfs/ioctl.c | 26 +++++++++++++++++++++-----
> >   1 file changed, 21 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 6c18bad53cd3..586671eea622 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -4643,6 +4643,7 @@ struct btrfs_uring_priv {
> >   	struct page **pages;
> >   	unsigned long nr_pages;
> >   	struct kiocb iocb;
> > +	struct iou_vec iou_vec;
> 
> This structure should not be leaked out of core io_uring ...

Agreed, but this was needed that priv needs to have bvec than iovec.
Thinking about this, just adding bvec or make union with iov is
simple way to do this.

> 
> >   	struct iovec *iov;
> >   	struct iov_iter iter;
> >   	struct extent_state *cached_state;
> > @@ -4711,6 +4712,8 @@ static void btrfs_uring_read_finished(struct io_uring_cmd *cmd, unsigned int iss
> >   	kfree(priv->pages);
> >   	kfree(priv->iov);
> > +	if (priv->iou_vec.iovec)
> > +		kfree(priv->iou_vec.iovec);
> 
> ... exactly because if this. This line relies on details it
> shouldn't.

Yes, we don't need this.

Thanks,
Sidong

> 
> -- 
> Pavel Begunkov
> 

