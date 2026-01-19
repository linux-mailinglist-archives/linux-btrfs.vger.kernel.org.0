Return-Path: <linux-btrfs+bounces-20687-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 576D2D39FCA
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 08:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E76523026F35
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jan 2026 07:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771782F9C2C;
	Mon, 19 Jan 2026 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tr9Pp8b+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F322F7AA1
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Jan 2026 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768807778; cv=none; b=CNvO63Ts/X66cNC59NZFVwh1H9dvwmlJFR8nurO627l/rraiYX8ufu9KLlOpnhthovII0GPTnEjPIYAu4S90rBAniM1G3oyKFPcCVO5Oo3VHZXNXWEWgzgI/nAljUBESgrDTGqTmrefxYwNu68+F1wI10Sg0bmvZOJqGe5L9ncw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768807778; c=relaxed/simple;
	bh=ELKdBUiZqG263/3lZkDLMx0y4CP0vUOU4SIjdjAFa5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTsxzFR2waDGKDeAdannfa/tDSmAQq0ltBEBIQ0FEE33JMH3QK1z4+NRzOe9q25mbzhfUogtpdh5ep8MQD/rkcQu9qK5C3SL92FSVQ8e5bi/dDcC/5TeeKlhLu91kusG66QuN1FYsBmkFmXvbK75F7ljIty1fNMuc1l1WM5sF78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tr9Pp8b+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so3509881f8f.1
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 23:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768807775; x=1769412575; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ddflimAih1d9IJylDLhOmD5P0ocN9EdagogBb49LvO0=;
        b=tr9Pp8b+dbm6+rB+/w9YixX8zX9sksrXraJnJ0a2mqUvlhZojO/5+ppeRwQKR+o4wp
         ErVEJRJxqqbItTeTgNougwIipp7b1LaEE0jEp50qJlu7Qksr+a+b6plra8e0TabdYC3F
         TUkXk+MzC/vo0fuiF+BxW3FBbneKDlhQHbIhm+XPs6HsM0GTaL+vDix1RfnM6dZJtojD
         wmLI9p6ARYvUlk/J51e5MxTzrw7MXUpqJJJiukktsT9zD2WjKR2zRJgAq9QhbOnnGWA0
         hV4hwQBzm6SGrb3Ub6kn5qTcwa3fLo9ThtxjXe1P7U4nwfjT4xIRkJWPV2JI8RB8IRhK
         OlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768807775; x=1769412575;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddflimAih1d9IJylDLhOmD5P0ocN9EdagogBb49LvO0=;
        b=qW4jgaTVGeo5V9CDQhLkw5Gh91hPvLGhwDZ6U39EuUjYAgGuTsYqerBHVSZ4tKPbGJ
         zqsTqkuAx9h8+p4gLtPgKS4SPXTfMdAfBSwLx54lWj3tnHjVAZc3Gua7Cs4GFRBi4KpO
         vKxZQGwYoIkI5M3mPt44rbQrxwl1TV30TnxSDk8RnYiCJFUK4i7ljYLknojKtQXIawoq
         jESHqftXhkoMlaKWDtkx9eY4vyL1Iuqt/QQLguJ1rtVN8R5I0L+1Ava8t2lASrMqTNLa
         U2AR64HbxoVKbBajExclKzc9mjZMBygKdYOiQe69+7vOVU4+eo7YWVsnAokE2tAsIcvd
         CdOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8B+A2V2c4cdlZA8gmCpNGdLK3oc0tIBTVnPODisUnrnmNJHYugZ/l/2OiQpQYaisnohK0+3N58pbd0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmJA50+pv16bYmRkSEKX9di620Y5uN3Z6yXMTkr3t1ZAdZJ/Ti
	X29yIrExE8N9Wqg7YNl5kgqpgPF4yq+rt9C4EblKnKqVFIqaYSMdVbbDZa7wA0Aas+8=
X-Gm-Gg: AY/fxX5wXM0mriU/wl+GsYe+smnpMBfoC/PhcAsUBWYczkiqvalIWSgyZcBkpLwvyM8
	F9DVs7BnX+YCsJod4bPkdZjLFCB+tW9QzMen7qI9IiIvPUT26irDSImfA540kB4GlAqSbD0k3/i
	dDADd+wGNdY9+25nk0ENyALO/74N3VWNeVig10Z95aB9/VTMNfmW4RKoO62d+C2JOU4kJqFQbGq
	tNdgQHzOO0DMgfxqjFeDGixPiZloQrr9WSo8AYqvMmgVhCiMVV7BqIJ38fGaFg8NLTOh1MBTncf
	NLWcuurN+cl9LlwVPiL0No2ZwJqF+RvOctE3KXFrt6WE2hGDhpTQJkI+2vBIqBVm9xhYlQ1t0Qk
	LlTPXITVCkzQTaX/BJ90mJePfVqp8udTsk/Ia/XK7WBbKAFHs5xBKysZcW24cj5866OTF8Dpr5D
	s5S4lFz7S4/rPOmo5c
X-Received: by 2002:a05:6000:40e0:b0:431:2ff:1289 with SMTP id ffacd0b85a97d-43569998e7emr12469349f8f.16.1768807775396;
        Sun, 18 Jan 2026 23:29:35 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e79asm21425229f8f.33.2026.01.18.23.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 23:29:35 -0800 (PST)
Date: Mon, 19 Jan 2026 10:29:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "oe-kbuild@lists.linux.dev" <oe-kbuild@lists.linux.dev>,
	"fdmanana@kernel.org" <fdmanana@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"lkp@intel.com" <lkp@intel.com>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH] btrfs: use the btrfs_block_group_end() helper everywhere
Message-ID: <aW3dXIsPHSbg8i6l@stanley.mountain>
References: <202601170636.WsePMV5H-lkp@intel.com>
 <9398ca7c-f114-47f9-ac22-8fd8f67214a7@wdc.com>
 <aW3c_HzQw-dfQUeg@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aW3c_HzQw-dfQUeg@stanley.mountain>

On Mon, Jan 19, 2026 at 10:27:56AM +0300, Dan Carpenter wrote:
> On Mon, Jan 19, 2026 at 06:49:34AM +0000, Johannes Thumshirn wrote:
> > On 1/19/26 7:40 AM, Dan Carpenter wrote:
> > > d4452bc526c431 Chris Mason     2014-05-19  1202  	u64 start, extent_start, extent_end, len;
> > > 7fc5a6968403c7 Filipe Manana   2026-01-16 @1203  	const u64 block_group_end = btrfs_block_group_end(block_group);
> > >                                                                                                            ^^^^^^^^^^^^
> > > Dereferenced.
> > >
> > > d4452bc526c431 Chris Mason     2014-05-19  1204  	struct extent_io_tree *unpin = NULL;
> > > d4452bc526c431 Chris Mason     2014-05-19  1205  	int ret;
> > > 43be21462d8c26 Josef Bacik     2011-04-01  1206
> > > 5349d6c3ffead2 Miao Xie        2014-06-19 @1207  	if (!block_group)
> > >                                                               ^^^^^^^^^^^
> > > Too late.
> > 
> > I _think_ this check is bogus.
> > 
> > On one hand  write_pinned_extent_entries() gets called by 
> > __btrfs_write_out_cache(), which has the following comment at the top:
> > 
> > /*
> >   * Write out cached info to an inode.
> >   *
> >   * @inode:       freespace inode we are writing out
> >   * @ctl:         free space cache we are going to write out
> >   * @block_group: block_group for this cache if it belongs to a block_group
> > 
> > but then __btrfs_write_out_cache() is only called by 
> > btrfs_write_out_cache() which looks like this:
> > 
> >      ret = __btrfs_write_out_cache(inode, ctl, block_group,
> >                        &block_group->io_ctl, trans);
> > 
> > so iff block_group really is NULL, we'd have a NULL pointer dereference 
> > when accessing block_group::io_ctl.
> > 
> > 
> > Same for all the if (block_group) constructs in __btrfs_write_out_cache().
> > 
> 
> The zero day bot can't use cross function analysis because it doesn't
> scale to the number of trees which the bot tests...  Otherwise, sure,
> Smatch would silence this warning.
> 
> If we remove the NULL check here, should we also remove the NULL checking
> in __btrfs_write_out_cache()?  Otherwise there is still a potential that

s/__btrfs_write_out_cache/write_cache_extent_entries/

Sorry.

Anyway, you were too quick for me and have already done this.

regards,
dan carpenter

> something will complain about inconsistent NULL checking.
> 
> regards,
> dan carpenter
> 

