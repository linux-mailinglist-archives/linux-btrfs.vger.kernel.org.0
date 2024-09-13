Return-Path: <linux-btrfs+bounces-8012-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19E9978B91
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Sep 2024 00:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BB81F25C45
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 22:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0B917920C;
	Fri, 13 Sep 2024 22:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="orMhjJFa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B595E3FE4
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 22:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726268306; cv=none; b=KafRHjPklweQgWl2zcZIrgS2kWu3m4zAi8jkJJdsAvglfPgOB9RXwfP9wkmQvIBmD87NCyTk5qv6HWU1McywQ/QwOQruxzBAcpJIjq9lKQuJo4ThrkH67rIG+eN9KGSaDGu+W0fIXsSJNt2wWTEAG0aGW+dZokHDO6UR0M1I4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726268306; c=relaxed/simple;
	bh=MgN34+cWL97Qcuj0KGwgeOsnvgRi4jPBZYLjUge/3BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPuHBF8Ccxud/Jccmtp4o9y9yUxhC6V1HeK9iL222hPCrGgx39rmXOZRYuQHKEE920TgyGopSrkO11m8vdGI6O3cwFCgLA0ZQZJLNo+AooNXJCfsPux+NuRtqWABwp1TDOAhd1LZKvZjJLuY7SMtHeRg7A379HdeeVx6V5KlQhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=orMhjJFa; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-718e0421143so540270b3a.0
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 15:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1726268304; x=1726873104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EQ7pn753vAetgV8Hbc/lQtTpIGzRgeLKdXCHE3oc6WE=;
        b=orMhjJFaNDve0Y2+1Q797QYrPDGnjnJDHHcwem+hK3sNhTx+6Cnk4x8wh+MvoL7L9x
         2BKmMhUe0eJrrb0kM3O0PQoRd1vfD2PfBpnc3MdAB2wWPh3+8XyjkL8Ef2WnYN2IfzFa
         YJ3pTpDTT8zaKOexae8OqiE0nDtHmWI1VKcKmopC9C3pgMrLkLzdkrw6UDWtoO2NwtcM
         MKLBPA4rRXODvjMl8u16VrPCkvjwWkeQYNjH0t+oR0YijFfuRzbWq0put5PTeVnEMV3F
         leJOLnvoslfTH7v55YRyhZ5LhjO8SKXCNZZirVnRvskLmwZMCEXxFqtOtlI3X2/YCzxU
         zccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726268304; x=1726873104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ7pn753vAetgV8Hbc/lQtTpIGzRgeLKdXCHE3oc6WE=;
        b=SUkH8uHRQWymLM8kAZfDchcJmp7V+seHkBb051DgQu8j+7XuBglyFIM+1kF98vorMJ
         34a4OybU2rbuhE7JxuALnc7cyBwJC/QxATt20EhgwqnhZVmH5+yAGhINeLNuewGy/zOK
         7pXx4zQXKFwJ4gWtUBEz6P5qUL9zDqdXL9B+R4XRvHC1DuRG8AxNkyu8WsfVVeAD/q+N
         J6G41YTPJ+vHdeWhIF2OVqHHxoMGmUrDEiLYzRgQ+19x2KC0hiif89FVFqa18Sq3LDpS
         +0F0MXbEI5FH3I5QPt6kkQSa+SW64OtVQtNNMOL9VHa4WTeq5aLp/uCMTQq2wN2b5OLQ
         GQlw==
X-Gm-Message-State: AOJu0Yy1QRWW6Q0iwxhQy3z62zRYxOxI2FzU4mBOHdBvHN4ki2iVl/cg
	Y8gSLG63Akm1ldXL24GmRuB46hX98Ta1i8UGb7QteocOf5rdNWOOg05LO2XvGf4=
X-Google-Smtp-Source: AGHT+IFwukdpLSiT4L1fSlLKR05SfUBLpMsbuJg7l8RXji+uFHGTOVJJyREgn5NPEiu41AMv35rTjw==
X-Received: by 2002:a17:90b:78e:b0:2db:60b:366a with SMTP id 98e67ed59e1d1-2dba007f424mr3758362a91.9.1726268303557;
        Fri, 13 Sep 2024 15:58:23 -0700 (PDT)
Received: from telecaster.dhcp.thefacebook.com ([2620:10d:c090:500::6:7584])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9c8ca84sm2375936a91.19.2024.09.13.15.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 15:58:23 -0700 (PDT)
Date: Fri, 13 Sep 2024 15:58:21 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: set flag to message when ratelimited
Message-ID: <ZuTDjX9DDd7fMXby@telecaster.dhcp.thefacebook.com>
References: <0628fc55984c3507c5365d4e1d5ed96d28693939.1726261774.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0628fc55984c3507c5365d4e1d5ed96d28693939.1726261774.git.loemra.dev@gmail.com>

On Fri, Sep 13, 2024 at 02:26:06PM -0700, Leo Martins wrote:
> Set RATELIMIT_MSG_ON_RELEASE flag to send a message when being
> ratelimited. During some recent debugging not realizing that
> logs were being ratelimited caused some confusion so making
> sure there is a warning seems prudent.
> 
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>

Reviewed-by: Omar Sandoval <osandov@fb.com>

