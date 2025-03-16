Return-Path: <linux-btrfs+bounces-12311-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D78A634BD
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Mar 2025 09:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DF11704AB
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Mar 2025 08:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A6A19CC37;
	Sun, 16 Mar 2025 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="FrU5Z/Ve"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2FA155C87
	for <linux-btrfs@vger.kernel.org>; Sun, 16 Mar 2025 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742115005; cv=none; b=U1hQS+DAZ0EpgVusEz2g+GHqQ29sM/C9mYMHAHbn21OJfgtbelSJkzKKaMC6YKpFg+HVnr6DcG9P7sKGw6u3r1d/UTzCRWSbZ9whdTPj30OHzA33n7962x78P/tQZU3/7ft8bksgH77scnG/1a4L8I3dh1eunlmENFb7sr8lhbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742115005; c=relaxed/simple;
	bh=MlPySl3ACm5OC8MT1lGjuC4BtV8C3P3CkbQqd9j9HqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnrt5iNz+Yg7qaZfr+/TkOesvNYVH4UA4m1X7tOnMVAsh9ZoE3nYpS6/cTBkEu6gGgInr9XBg9WrfUXLVUThdhT5HOQFpA6mr4c4YN6TOxB5pr5cHFb1nhdF5UDusp3kuJBv820mUn8IEWMWZ0Xp1t24HqqQV6GWyA1xKP0hfAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=FrU5Z/Ve; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2240b4de12bso10908945ad.2
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Mar 2025 01:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1742115002; x=1742719802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=soOsMjUDX0L3z68pN83CLYXGQKPqqXJHBRzUH/+iQu4=;
        b=FrU5Z/Ve4KI2EJ5dpYWsk+rRaYpNJii8NKRM/FOkVFL56m5v4V/LXT6hZ7Z/5jmH7b
         CqWGqqRIymLu+1lUIFkJ7+tkUm3maYzbsjN8VGcmxSFhWq5Y5LlRfN4/Pa2+emh3Bf2I
         6arc1LUM6ABEzHBev6naLyPISV3l4hqRXpM7uDLX3dvCwBrynGgihqc91EW5ImUR8kgf
         iM4Z4Rm5wsvGTm2ylupZjwKLcGZGoRNFfAZXaM7GVXIUFVD8mTAlW2y8mJ2QwsE26m8y
         cdOBkwN88PGyXHtHXjid/joZGEnLqiyUSFfs8sKHcwyRfUYHwnRKxP86PIoOEPWtvG4M
         LNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742115002; x=1742719802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soOsMjUDX0L3z68pN83CLYXGQKPqqXJHBRzUH/+iQu4=;
        b=LwPV4svOltLDcbR2rOgh6lUR33r232LrWdEFctuhZIrXjDG7oeWZP6Bf5REDmOcN9+
         PpvRfii9MRE4ijeTqrgTCavRlfDbpklLe7JZmN+wxksP4kuYzwxtflgKqDRNg2z59vEj
         KJ4MoYwlQZ1IStCqhuOhf0l/LkoaLJ7MVpRu5AeuNahPu6fPwnBq9MZEYaFu5ODmisyq
         zD5x5oLyiDqsavBeQxgubivyCJh6NFGgJlWK97PtgJpH+nR+niv3q/iRt2+ZFb7ckLBL
         nnVPlsWsafNesJ2WbNN5FkldikYhAd6VhP21u2Ork6B156ubpNq/nUdP2kwPNfmot0gw
         c1Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUskPoag+oI4uSwoS6k2Fuf/soz4Sav8cZYCASitK3jzVkH4sYMTT7NI1W2Q7Nx8C4SIQAyQsSxm/wdvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw04qfUDg5iwrSG5YUW70iV5O8ZoLIK31pHVeT5ED6UQNknO8cp
	UH+PIXNY4DwICU6IhgHrRjBHbFOBCBARDV4xqXsilNM3Ae/ZLMrUcqNjEezCk7o=
X-Gm-Gg: ASbGncsUpgYB/t9lfFDGHiIDez8n8DBUBsJgFlh1mA9XLjl2Sy5BKQ8XkEWslTaNeJl
	FNmwF1UWbeSCg9MSUOOqNV1ntcnLeQMZfbhxKc0kL4DW2Q8vBfo2u5272fiJb+AfoA3gW2G8Urz
	OnhYuH2UmYpbm0kQvhbJxP6AUxoWlztnqM70LoMtlrcaw0p6Kr3HD8b2tvjqDaGXXwk185+IyLU
	CK2sMxAyrjbkXgaVeKgZywe29PmD95RY3Wvbc+eXZ+OFXHfytsaMGaGuLH4lg1qY9S3h5Vy15OQ
	qu0pXD06e+D5q+khRVyMj4LT7U0Vee/vOUQyNHUsxKR55aXIbuXz1MuVu4ooxdfw4SYVLRu1+h8
	K2X850A==
X-Google-Smtp-Source: AGHT+IEzVK5LsPCPJLOxGzZJMLs0Hpz7cAwlexEXo204aa6yKZYCWEHtDLdFcGmAFiv30Ov47TIhNg==
X-Received: by 2002:a17:902:f693:b0:21d:3bd7:afdd with SMTP id d9443c01a7336-225e0868050mr111601535ad.0.1742115001911;
        Sun, 16 Mar 2025 01:50:01 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301539ed069sm3896109a91.17.2025.03.16.01.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 01:50:01 -0700 (PDT)
Date: Sun, 16 Mar 2025 17:49:51 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/3] io-uring/cmd: add iou_vec field for
 io_uring_cmd
Message-ID: <Z9aQr9iUJecNdPQ4@sidongui-MacBookPro.local>
References: <20250315172319.16770-1-sidong.yang@furiosa.ai>
 <20250315172319.16770-2-sidong.yang@furiosa.ai>
 <da0445a9-1fb4-4b75-b939-b38ce976205f@gmail.com>
 <Z9aFgKTUmcx-YCMf@sidongui-MacBookPro.local>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9aFgKTUmcx-YCMf@sidongui-MacBookPro.local>

On Sun, Mar 16, 2025 at 05:02:19PM +0900, Sidong Yang wrote:
> On Sun, Mar 16, 2025 at 07:24:32AM +0000, Pavel Begunkov wrote:
> > On 3/15/25 17:23, Sidong Yang wrote:
> > > This patch adds iou_vec field for io_uring_cmd. Also it needs to be
> > > cleanup for cache. It could be used in uring cmd api that imports
> > > multiple fixed buffers.
> > 
> > Sidong, I think you accidentially erased my authorship over the
> > patch. The only difference I see is that you rebased it and dropped
> > prep patches by placing iou_vec into struct io_uring_cmd_data. And
> > the prep patch was mandatory, once something is exported there is
> > a good chance it gets [ab]used, and iou_vec is not ready for it.
> 
> Yes, First I thought it's not mandatory for this function. But it seems that
> it's needed. I see that your patch hides all fields in io_uring_cmd_data but
> op_data needed to be accessable for btrfs cmd. And I'll take a look for the
> code referencing sqes in io_uring_cmd_data. Let me add the commit for next
> version v4.

I've just realized that your commit don't need to be modified. It's okay to
cast async_data to io_uring_cmd_data. 

Thanks,
Sidong
> 
> Thanks,
> Sidong
> 
> > 
> > 
> > > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > > ---
> > >   include/linux/io_uring/cmd.h |  1 +
> > >   io_uring/io_uring.c          |  2 +-
> > >   io_uring/opdef.c             |  1 +
> > >   io_uring/uring_cmd.c         | 20 ++++++++++++++++++++
> > >   io_uring/uring_cmd.h         |  3 +++
> > >   5 files changed, 26 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
> > > index 598cacda4aa3..74b9f0aec229 100644
> > > --- a/include/linux/io_uring/cmd.h
> > > +++ b/include/linux/io_uring/cmd.h
> > > @@ -22,6 +22,7 @@ struct io_uring_cmd {
> > >   struct io_uring_cmd_data {
> > >   	void			*op_data;
> > >   	struct io_uring_sqe	sqes[2];
> > > +	struct iou_vec		iou_vec;
> > >   };
> > >   static inline const void *io_uring_sqe_cmd(const struct io_uring_sqe *sqe)
> > > diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> > > index 5ff30a7092ed..55334fa53abf 100644
> > > --- a/io_uring/io_uring.c
> > > +++ b/io_uring/io_uring.c
> > > @@ -289,7 +289,7 @@ static void io_free_alloc_caches(struct io_ring_ctx *ctx)
> > >   	io_alloc_cache_free(&ctx->apoll_cache, kfree);
> > >   	io_alloc_cache_free(&ctx->netmsg_cache, io_netmsg_cache_free);
> > >   	io_alloc_cache_free(&ctx->rw_cache, io_rw_cache_free);
> > > -	io_alloc_cache_free(&ctx->uring_cache, kfree);
> > > +	io_alloc_cache_free(&ctx->uring_cache, io_cmd_cache_free);
> > >   	io_alloc_cache_free(&ctx->msg_cache, kfree);
> > >   	io_futex_cache_free(ctx);
> > >   	io_rsrc_cache_free(ctx);
> > > diff --git a/io_uring/opdef.c b/io_uring/opdef.c
> > > index 7fd173197b1e..e275180c2077 100644
> > > --- a/io_uring/opdef.c
> > > +++ b/io_uring/opdef.c
> > > @@ -755,6 +755,7 @@ const struct io_cold_def io_cold_defs[] = {
> > >   	},
> > >   	[IORING_OP_URING_CMD] = {
> > >   		.name			= "URING_CMD",
> > > +		.cleanup		= io_uring_cmd_cleanup,
> > >   	},
> > >   	[IORING_OP_SEND_ZC] = {
> > >   		.name			= "SEND_ZC",
> > > diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> > > index de39b602aa82..315c603cfdd4 100644
> > > --- a/io_uring/uring_cmd.c
> > > +++ b/io_uring/uring_cmd.c
> > > @@ -28,6 +28,13 @@ static void io_req_uring_cleanup(struct io_kiocb *req, unsigned int issue_flags)
> > >   	if (issue_flags & IO_URING_F_UNLOCKED)
> > >   		return;
> > > +
> > > +	req->flags &= ~REQ_F_NEED_CLEANUP;
> > > +
> > > +	io_alloc_cache_vec_kasan(&cache->iou_vec);
> > > +	if (cache->iou_vec.nr > IO_VEC_CACHE_SOFT_CAP)
> > > +		io_vec_free(&cache->iou_vec);
> > > +
> > >   	if (io_alloc_cache_put(&req->ctx->uring_cache, cache)) {
> > >   		ioucmd->sqe = NULL;
> > >   		req->async_data = NULL;
> > > @@ -35,6 +42,11 @@ static void io_req_uring_cleanup(struct io_kiocb *req, unsigned int issue_flags)
> > >   	}
> > >   }
> > > +void io_uring_cmd_cleanup(struct io_kiocb *req)
> > > +{
> > > +	io_req_uring_cleanup(req, 0);
> > > +}
> > > +
> > >   bool io_uring_try_cancel_uring_cmd(struct io_ring_ctx *ctx,
> > >   				   struct io_uring_task *tctx, bool cancel_all)
> > >   {
> > > @@ -339,3 +351,11 @@ int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
> > >   }
> > >   EXPORT_SYMBOL_GPL(io_uring_cmd_sock);
> > >   #endif
> > > +
> > > +void io_cmd_cache_free(const void *entry)
> > > +{
> > > +	struct io_uring_cmd_data *cache = (struct io_uring_cmd_data *)entry;
> > > +
> > > +	io_vec_free(&cache->iou_vec);
> > > +	kfree(cache);
> > > +}
> > > diff --git a/io_uring/uring_cmd.h b/io_uring/uring_cmd.h
> > > index f6837ee0955b..d2b9c1522e22 100644
> > > --- a/io_uring/uring_cmd.h
> > > +++ b/io_uring/uring_cmd.h
> > > @@ -1,7 +1,10 @@
> > >   // SPDX-License-Identifier: GPL-2.0
> > > +#include <linux/io_uring_types.h>
> > >   int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags);
> > >   int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
> > > +void io_uring_cmd_cleanup(struct io_kiocb *req);
> > >   bool io_uring_try_cancel_uring_cmd(struct io_ring_ctx *ctx,
> > >   				   struct io_uring_task *tctx, bool cancel_all);
> > > +void io_cmd_cache_free(const void *entry);
> > 
> > -- 
> > Pavel Begunkov
> > 

