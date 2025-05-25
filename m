Return-Path: <linux-btrfs+bounces-14226-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A93AC3416
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 May 2025 13:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314B13B4BF2
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 May 2025 11:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A881C1F099A;
	Sun, 25 May 2025 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoolPRNm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3FD2A1C9
	for <linux-btrfs@vger.kernel.org>; Sun, 25 May 2025 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748171712; cv=none; b=exuacrUEh53Ot3s0KwRwsZJ5xjfsYoiZTUUlKkGNZ5A8HDJAlPviAzcCCgaKIcx9BnvXSzWbkt5feSFjRIYgONyh6zesOqwyrh178AyIQUuzsfYYLsFS96gTVZf0Yanm+51IjBwtWm5nMOSdu9fKyzhmxJCUMT+0sjlRwKxF0UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748171712; c=relaxed/simple;
	bh=8K8gGumro8YNQNSBEm58E6Q9/5tBTHwHBKUpB1fJ76I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f81B5sZDnJEgDpF//+3Kt+Un+WOEQEhp2S6goXntj63YNnuuvEi6wQtlTTD/2JWEtmBBf/nJtB4b2pJl+3ncmNfS8lDCHupTGdMZLA1hvKBiKK+P3wSE9i6HBPCcEyWihRIaUPkqDLqKjHen6mZyBVuHlOGsAofk2N2M8StiRqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PoolPRNm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748171708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AE1YaJMOHLhTRnb9U6H2SlT+l2tAdPIWHRyi8gGw+fI=;
	b=PoolPRNmVBAscE5ZA/K24At494b+YVzrQzeHdIf1ayYRm3cZO772Q8QYkv6BQ2VH5go3rf
	EwVPkvXh9U3kTPCise1Al12HOrj1zhzDRN+dAH+K2whrj25spUYMAPkfQX06NCsAG7WPZa
	0LreXaT0uIILb6YgBAnkUWBK79bXBn0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-wavtAhm9OuuEw4MXLXFJeQ-1; Sun, 25 May 2025 07:15:05 -0400
X-MC-Unique: wavtAhm9OuuEw4MXLXFJeQ-1
X-Mimecast-MFC-AGG-ID: wavtAhm9OuuEw4MXLXFJeQ_1748171704
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b115fb801bcso1530744a12.3
        for <linux-btrfs@vger.kernel.org>; Sun, 25 May 2025 04:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748171704; x=1748776504;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AE1YaJMOHLhTRnb9U6H2SlT+l2tAdPIWHRyi8gGw+fI=;
        b=KGrL52ETTEEPMed+Ox4hBDZI8NUCoy2pwESEbI0q+4SCjJ8kbbCQfZB75NU2iru8sx
         hrM++/PeEzGipB5vNpJfPUWR1TbWZ//dLNYdOjKwBwI+5bNMnlezQ2cMoNDbofibgbvf
         zv8yfJQQAdMh16pvgWKykmcedhvMDS4/9TbFwiRfc+mCjp0e3r6cpdJ22WBofgonlqGp
         UCIiIO993GhADRvOAi4bW1hQWf8C6xGfCbEK2v/h4TTfsST8m6n3l+ttrhAoT7qDfKwe
         t2zzEMHNCO3VzDZY/JX4oLgh/+ZTu63eMMqL1oZsNz2eMfoT+8P/Jqa1ZK67bK/DaAp6
         XFug==
X-Forwarded-Encrypted: i=1; AJvYcCXVd3XDqEJsp2BpOBC1wOuOsWkcFcQFbWyklCDqO0GR18eXY1/0Ib9BPF8A5eQz+fo2P+0rtKD9q5GCVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxanLtSY9eZnguXAbK4c1pLL2d554vMvjYjKJL2yIbRGWtjI+rE
	/0cj1aiQ3aveAx2TFB2gOoHU/BGNMba0z+Ty6Iz4LeDDaXE5qL4o66D9gAXv4WDKq2rQE2fiklb
	Z3ku7Dp5k0oCIwoPp21iqu7/ZXeGFHf6/GwqgDDDtWnf4RjmL78AcGmO1I/9iO9r7
X-Gm-Gg: ASbGncsufYDtiG2g3cMxYyzyMQ6BZPndiBw7ZU0ML84XyZKRmIaKuT81v2vt7YoU2sm
	7gE0iEFSg0PtrZCATrN5D6nH0/u8KqVIsjzlODUvfWBv0vd1gHtU6bvalwo2yfINSBrUo9/w7w9
	DYzLWaGv6Whb+QAoI5ILmElOWvj3M/OPbMSRHZ+zGMbhj1+qjA8gDz9wTxx1QaR479RRWnTcr4o
	wIKOdWUDgtu1Y3HzS3hkdt6n68T+SOzEfCWLBzx+Nrc10KNoRWSFR4LKusmg9N7EMcqhQXwPZqx
	Vd9uoPs8pd9VMevdYqa2QyMSxoHny7WTvm/FPK8mCQi4XxcHL49g
X-Received: by 2002:a17:902:e807:b0:224:910:23f0 with SMTP id d9443c01a7336-23415001067mr84073075ad.49.1748171704176;
        Sun, 25 May 2025 04:15:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd3GxDPBxapVEFODlhqwF9sebuCoxsLJ4BYELDs+USvDS59FKieVbbrxysnqNHK33DMzaQjg==
X-Received: by 2002:a17:902:e807:b0:224:910:23f0 with SMTP id d9443c01a7336-23415001067mr84072875ad.49.1748171703816;
        Sun, 25 May 2025 04:15:03 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-310f86909ccsm3592360a91.29.2025.05.25.04.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 04:15:03 -0700 (PDT)
Date: Sun, 25 May 2025 19:14:59 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next staged-20250523
Message-ID: <20250525111459.bpi6zisqetjpxxd4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250524040850.832087-1-anand.jain@oracle.com>
 <26d4ea00-3ea0-469d-b6e1-a58f717f4013@gmx.com>
 <b8e4f687-809c-47d6-8534-e2ffe0e85596@gmx.com>
 <20250524065222.v5ivpxkh5q57ke2v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <f4c2b83f-cc13-45f3-9f16-03095b56e175@oracle.com>
 <20250525052802.pwujhzxdyj3on6l3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <97d6425e-dd3d-4949-b63e-a53a6e210069@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97d6425e-dd3d-4949-b63e-a53a6e210069@oracle.com>

On Sun, May 25, 2025 at 01:41:11PM +0800, Anand Jain wrote:
> On 25/5/25 13:28, Zorro Lang wrote:
> > On Sat, May 24, 2025 at 03:52:54PM +0800, Anand Jain wrote:
> > > 
> > > >     3bbdf4241 fstests: btrfs: a new test case to verify scrub and rescue=idatacsums
> > > 
> > > There’s an additional fix on top of this patch that doesn’t have
> > > an R-b yet, so I haven’t included it.
> > > 
> > > https://www.spinics.net/lists/fstests/msg29195.html
> > 
> > I saw you talked about it with Qu, not sure if you've reached a
> > consensus or will send a v2 :)
> 
> 3bbdf4241 above has a bug, which the patch in the link also fixes.

Oh, you tried to fix a bug of an un-pushed patch. Why not review and fix
it in the patch itself? As you've prepared a seperated patch for that, I
suppose we can merge the previous patch at first, is that good to you?

> Others need to comment for the RB. IMO, we should have the error
> code in the golden output to make sure we're not breaking the KABI.
> 
> 


