Return-Path: <linux-btrfs+bounces-15005-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F114AEA144
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 16:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E923B319B
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 14:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015802EACF4;
	Thu, 26 Jun 2025 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KXWOOvhn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A312EACE3
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949199; cv=none; b=CkTRqLaLdBlx+J86rUXJ6lgVC5mnAx3jeAwSU1FvOzAjpy9hEwyQD86dM2aaQ8Tkyo87aUrB1sElc7N5Fbg5Ra6Dx03bYlZUULcP2jB/0h4ZtsF47jjj4tKGnUohkg47OnZxFhk3P09kqJD8L3f9kvQydmQq3e+uORHBW8R7bkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949199; c=relaxed/simple;
	bh=noOikzxRJUl14Ub0sClioFuEstMIhfUeZLMzieYlkBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfIf9+THixbUHVOGyNtjpJNXd3NDqpDo1oRoAmO2rN6F4QszWtfMGoaM5LB4NdjahIaRo1WytUXa5jzY9TtnDfRiTTjKB/pNHlLURP/1/hzN+MzR5lWiNjmh5hUOqS6+66PAScJmAQ/4hUgtmBC6KMFPU9vTNL+6WbMIbSpLxkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KXWOOvhn; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so96613966b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 07:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750949195; x=1751553995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LzQA/XwUwP5a0XPEORRBVwjJdl63AtKA/a2VZ1wcXmU=;
        b=KXWOOvhnQCXi/3+pERW2P32hWtYBcyMrVFnbx23bMhazO77kKjoV9qF7eICdhR2X5h
         83Zv7ZZj3yZZsLy2sVROxaNazmOYkrZ4WinvVo9fme+igWuKIu8Gn/lroITydHt09109
         bWWTiZPZ5SpAHp9KOuf6xhFW8qBJTlOl+FdCH1zwaaISIsnsGXirhaTwCfBGLQZIBq8R
         wrYWvWe0kfq2IBZAyoviKRXys7TNiwWRzHooCmfidus5k1HuNF/7Fj9XmDc+aIUN69u7
         tSl54NdSv7AZyk38RGoO4jrdLNH4ImiytBmyjy0AA0MoAcMsZUp6skB0kVf0qsD6s3Vv
         mV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750949195; x=1751553995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LzQA/XwUwP5a0XPEORRBVwjJdl63AtKA/a2VZ1wcXmU=;
        b=lbwqhtsG8X37LVuQK009gTD5bwfANeeVftk9UL7azXpuE4xTTsPiZMSpl7EOCFAcX8
         yCpSZl8sAJoAuT/lh+9mo+VkxTHcjg2TZxmfjmOTUmXR65/hwOrS72WRgIdV1yo6bmir
         AbxueUBo1cJ6MwnvslYsUrhSHucvPZuPLlu1MdcbmOH7jXGH+HDvS5o2Tm/rY0k8PthP
         Oej5FKd25+MM3B5U8pNdLr5nLUBzKkYUmwXt98DtL2PmX83o2FDzos+3c3czFhyNvmHG
         upLSs+hu1StVAhqmZTQma5/D6w5l/e8lhTpCxvjSbWlUh/hNe0rfYnvNmvYFcuniPWO0
         CPvA==
X-Gm-Message-State: AOJu0Ywf9p/BpjHPLAzO339io+f1PKsJJlfwGjxJLawVt//Jfa4c4qNK
	ArH7rbI2sxxhIvRShO1XYQ/bc+wmrCI9oHBUvD2CIkB176L00WQRyeCOjiC1BXad4TcHVrWXCdR
	IyfyqlCgNqMqCfuid7r4UP2Hu9R/X2SCt11pZAXfQ0en/8ACsay9ji5g=
X-Gm-Gg: ASbGncsWPdwTAp1pNXMzBFOKJXu8A6vCSkgB//ciUvDZFpE1xoqSc0z/4hs79g++wJY
	zQScxFvh1601EMWhtUdhrN4EwrAt9S1rIZfti9tJS1TBxLQq5VZGIMQw98iJPd4A1ahFk36ctM/
	QmHy4go0+GDIz0Hw5pdpnb2CBlJS7nFukyADK/tOptAw==
X-Google-Smtp-Source: AGHT+IHZwBLHyH93XS3cCn+9LC1aOiC2tJd3EjGjUxzQln3Has2srf3+2oodNE76JW4RX0vDtDkvvOn1UKB8pfu2iik=
X-Received: by 2002:a17:906:f10c:b0:ae0:afad:2031 with SMTP id
 a640c23a62f3a-ae0bef3a0abmr638774166b.49.1750949195281; Thu, 26 Jun 2025
 07:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750858539.git.dsterba@suse.com>
In-Reply-To: <cover.1750858539.git.dsterba@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 26 Jun 2025 16:46:24 +0200
X-Gm-Features: Ac12FXxmN5SVMzS8YnZJUrTX4e05Rgpf71kb3avVH2dFaRJvBa5EwAVHRnp46zo
Message-ID: <CAPjX3FcZSo7GBMED3p3CnTbnjPEZLvSjKWQisGDTSzuLnqvogw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Device name and RCU string
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Jun 2025 at 15:37, David Sterba <dsterba@suse.com> wrote:
>
> v2:
> - drop patch adding RCU protection around update_dev_time(), there's a
>   sleeping allocation inside; after revisiting the RCU requirements, I
>   don't think it's needed and we can access the raw string (the same way
>   it was done with rcu_string), the time update is called from scratch
>   superblocks and after the ->dev_list hook is removed, so there's no
>   chance it can be reached from device_list_add

Right, I missed that.

> After recent simplifications of the RCU usage in messages, this patchset
> implements the RCU protection directly without the RCU string so this
> API can be removed completely as we don't have nor plan anything else to
> use it for.
>
> David Sterba (2):
>   btrfs: open code RCU for device name
>   btrfs: remove struct rcu_string

The rest still looks good.
Reviewed-by: Daniel Vacek <neelx@suse.com>

>  fs/btrfs/rcu-string.h | 40 ----------------------------------------
>  fs/btrfs/volumes.c    | 29 +++++++++++++++++------------
>  fs/btrfs/volumes.h    |  6 +++---
>  fs/btrfs/zoned.c      | 23 +++++++++++------------
>  4 files changed, 31 insertions(+), 67 deletions(-)
>  delete mode 100644 fs/btrfs/rcu-string.h
>
> --
> 2.49.0
>
>

