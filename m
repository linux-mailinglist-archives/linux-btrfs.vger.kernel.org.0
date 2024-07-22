Return-Path: <linux-btrfs+bounces-6636-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C65938A17
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 09:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6981F218DB
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2024 07:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743D713F454;
	Mon, 22 Jul 2024 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fcAWYtPl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E3212E1D9
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633528; cv=none; b=kbYog0IFtRLLlyOSQi65NfVzIDhYQHhPFzBVBUsQRNmJcqNppt8KIX3IELR/lftU9OkTT9BhZbz+eraHGwxARaPiJcV8n/UGMkoPICvC+lGRo+TuVxGPdcnlf8nncZx0fS+9MhDOO5nuXOcJ09RBY0UoIzMEKeTR4oOgzFw4cK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633528; c=relaxed/simple;
	bh=9fnJ6v+YyNQwaM8n9wXBkkYyNikINA6Tmc4uhZIyutU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADnF53FkXrWd/NmaxN+brU751ycjHfD4py2XW8pMVHzneJeFZsRZmXc8Osurn2k1TUeZFU7/WMWoOoyO5ciH7phJU8uihhG8V7MtAo5e+fMyNaVHW/vD48mgCHJUdkjPzauaxUM2CZazqBXm3+Xk4oAYUHKh2xurIRNoBmhZnCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fcAWYtPl; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a1fcb611baso3054094a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2024 00:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721633524; x=1722238324; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i269Kc+JDPQ/TyuE2xQA6LopPQVgugZnDypSMxWIn04=;
        b=fcAWYtPlIMPoZcqUWlDV2X64SU0WaopRhV5BCX5/mYosHYnaMX0TRPm2ej/Q5SazGZ
         63Cjiyvz9i5CWS9Ed6nlFcPesTm1O4B5qmKF21wZ/NwQt9oQ4wiZGADfl2SFAM664hYf
         scToTRW8aJ0GAWK7T7hbnmXQi/plcupRIOZHbQ7nIi+ohb0OKnEHkyW8jM1sF/UoeYtq
         7UduLx/oel5IPk3K53sy5ja/DF5JPz0kzajxShCaFH8Ey+4N9VDyXRijDPMX8XmUwLL1
         B2B6Ock9SIYVRMHIMfOq9MeI0nXa3Yi7k1fHpuPD44HSm3Qhppq4pQmXgSeU+TQml2eX
         uTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721633524; x=1722238324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i269Kc+JDPQ/TyuE2xQA6LopPQVgugZnDypSMxWIn04=;
        b=s4vCPEg95q9jv5ABN5mAiI7fesTuJ4QPhGRyMt84v1e7dKI49MUF482yN00ylQ+umP
         fFJZ60RQGBmXmUCoYhYhvuVwGJgeD/GSLJRlqrp1LQsbi07RERy2LPKNzwc0viusnrvt
         qAbHXv0+iBJHwDlcr7FarFqffM5mpE6Y55xV4qYasbmI3SGxkallJJXLvBPHvm5nz4kE
         VKb6IwAlVr5PKEuxAz8fut0L7RY0bW7bXCUqVK/sU9bUSD6J9tcLIKUZHDIael8fnFrh
         QuNdTMbg45SNjX4umebUdLzlbJVSzmJpmtlCEgXPR1UvtPYHRBNjgS01NY23Jmxhejep
         +Qrw==
X-Forwarded-Encrypted: i=1; AJvYcCUQeCe3SXaCEvrvpwJcOYR13aXint4m2DlfvmajAdsYNtAj776iwa5ECiaS7U/AN5ASsnTmlkiTOcGxFqwzI991Y7A4fjTJqUl3yGw=
X-Gm-Message-State: AOJu0YwvwKmf7f0frcukiGGB2Wphfb/3ybiL3e4FgSpGKpoFl60v+/oL
	uv2YD1kcO8p+WA/tzScfYTd1ptiRFWv0s/nLaVVWO4JbI8y4M5UorN1A+HHw2cU=
X-Google-Smtp-Source: AGHT+IGfYvZSQdoNDjDfGgqoYMTf2sBhdVIo02uRK/M2b/n1L8OwC9uMVh0ZyAHuCVCP+3HC+bl+Dw==
X-Received: by 2002:a17:907:9489:b0:a77:e31e:b5c2 with SMTP id a640c23a62f3a-a7a4c42a78bmr290459766b.62.1721633523779;
        Mon, 22 Jul 2024 00:32:03 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c9511e0sm383129866b.202.2024.07.22.00.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 00:32:03 -0700 (PDT)
Date: Mon, 22 Jul 2024 09:32:02 +0200
From: Michal Hocko <mhocko@suse.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	hannes@cmpxchg.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 1/3] memcontrol: define root_mem_cgroup for
 CONFIG_MEMCG=n cases
Message-ID: <Zp4K8rUvrh1Wbizq@tiehlicka>
References: <cover.1721384771.git.wqu@suse.com>
 <2050f8a1bc181a9aaf01e0866e230e23216000f4.1721384771.git.wqu@suse.com>
 <ZppKZJKMcPF4OGVc@tiehlicka>
 <54b7d944-37eb-4c3f-a994-13212aa3ed13@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54b7d944-37eb-4c3f-a994-13212aa3ed13@gmx.com>

On Sat 20-07-24 07:28:45, Qu Wenruo wrote:
> 
> 
> 在 2024/7/19 20:43, Michal Hocko 写道:
> > On Fri 19-07-24 19:58:39, Qu Wenruo wrote:
> > > There is an incoming btrfs patchset, which will use @root_mem_cgroup as
> > > the active cgroup to attach metadata folios to its internal btree
> > > inode, so that btrfs can skip the possibly costly charge for the
> > > internal inode which is only accessible by btrfs itself.
> > > 
> > > However @root_mem_cgroup is not always defined (not defined for
> > > CONFIG_MEMCG=n case), thus all such callers need to do the extra
> > > handling for different CONFIG_MEMCG settings.
> > > 
> > > So here we add a special macro definition of root_mem_cgroup, making it
> > > to always be NULL.
> > 
> > Isn't just a declaration sufficient? Nothing should really dereference
> > the pointer anyway.
> > 
> That can pass the compile, but waste the extra bytes for the pointer in
> the data section, even if no one is utilizing that pointer.

Are you sure that the mere declaration will be defined in the data section?
-- 
Michal Hocko
SUSE Labs

