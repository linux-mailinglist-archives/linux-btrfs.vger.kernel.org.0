Return-Path: <linux-btrfs+bounces-10910-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A366A09B9D
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 20:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2A616AADC
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 19:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE60A20DD43;
	Fri, 10 Jan 2025 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZQzdOc5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4961724B221
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736536225; cv=none; b=bhHhk+vthY6S5D0lv8Vr78i5anjBtnbUxnYeuMXEjCdngQOBMWo6taYAiotP/TT0U88Twh3kDh7PX6MCbBc0B7pCmE1clM7b7XCeApArV6vKR0VSDXp55J2MrZcbLymj8rK2aCwCkSf8+Sle2jS02cBXxwwqd10G6hhRIdQGNFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736536225; c=relaxed/simple;
	bh=jXxiXru38suC2Xu5hw4JU52533qfEhAWaeiZ8fVLtoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPDIrr3TEpNHuyR9DPV2qNagsXERoBqW6c9Lh6DD7eehpPCKWOjohYkqD3w940tHsvO000pSHN4WPlFkvdaok+Rz1SRl9LFts+ODS272pv6MFjsUpjpzN0nySgvjTvvHBGlxo80vRwKSvY3ub65FoDNf7D9t1d5YcgYFx02rzlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZQzdOc5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736536222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BJGJZBSAqSvlN1DAry3+tYU71nLGvuo3THiydV/lU4s=;
	b=JZQzdOc5sTIElUWxnXKFTJItmet5Wb87ga4NGMYfsbzvrE73zc0+rsDZm+xpOLV/hea1Dv
	VGTLyfjZ+gY9mUkEpn/SQbvfVrXjtClw7E1jz0Lpf+ADlhllv3s0OlydtyqWd0Ycl9Xxym
	OStMrJiR7D8/ECo5zoIdSjhuXjskuxg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-GzpPc99LNk22b8a3NBtsPA-1; Fri, 10 Jan 2025 14:10:20 -0500
X-MC-Unique: GzpPc99LNk22b8a3NBtsPA-1
X-Mimecast-MFC-AGG-ID: GzpPc99LNk22b8a3NBtsPA
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21655569152so45253445ad.2
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 11:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736536219; x=1737141019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJGJZBSAqSvlN1DAry3+tYU71nLGvuo3THiydV/lU4s=;
        b=Wpnv8E2Zad4w+Bt8/EuVhbCGk4z6ZBaaz7/edqv99UsFHJaqAnOda9uhHaGCOBkVeT
         Re+oRjZm0VP38n9260VGbaeBngPG3VyUKW2mrp/Qb/mDPiXbbDTRilvJE8KzaT8V0lVP
         2pgt/FRr1JVfQE7xj1XPWM979lPt6ReDW0eINejnxu/zksdSuGG43OY7CMD/Amyq/zhJ
         RWFdCQFV7Fpkqypz1GwProUCRt826d+bu7Rl8hr78gbg4F3RM39ElCvTwe5yhmqOcUQf
         veU4nMeWbgKNbRZ53hWAcu9HGGhKawHllTzwhgevFp8j7y+sr6jJQtZn4qQjyhB1GxKU
         fqyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLuhsD1mDqBlA9IaY2l5jVxe4Oy8cGydTKYK45YavcIZELe293gT9W5355X4a4lkGJI4Kb1QrGNkGaWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyG3YzOKeKMyaezSBdLuChBFJQcXkRljhtEXaGojOtcswF0eXm8
	g7GRmp+fNcCfXaLjggbHilSlIYi+XmEUyDs+DQdp8CxTLGOSlEN9qUo393Orlo9TIHjVO3T+T2c
	AOfNhCUyra516XgrnVGBNgmBk+phUUnv6SuBn7tzZ1jOhU/pSGYFZNexO/jaqWAfd6GNVVyI=
X-Gm-Gg: ASbGncvQ3eAAJeyQxJqEbqFL3DHauu+GdQwAsGfw9tY+6SLpMQvXTBVs1PMRAwBamZt
	qpJ1lKdLujL/96GE5zf0WF25FTS8EW8YwP3xodlZT6dJU22TZAeHSSmJwcQeH5SctzqZAFxPufc
	+1sDCGSZBnRaPTsp4LKsXsu8rAmwfYdCNT0KDZV6Xwcp2FlZrVbYtjLbj3HJW9GrNkrNo/nONoH
	AZIvGA1G+APIejgOiD3ofZF9ljEYythKyat8W9V5xXpuOZrL7RZLyByo2l6KN0nAZMatbXJhZXs
	Kti0BtC8fJhxON4bioZayw==
X-Received: by 2002:a05:6a20:9150:b0:1e1:6ec8:fc63 with SMTP id adf61e73a8af0-1e88d0e1718mr18549018637.11.1736536218995;
        Fri, 10 Jan 2025 11:10:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiX8W3b+TafT191JHTpyViWF9Yc0NMljdIJ5iTudUfN0kVN0RYpTdveM4ujtc6w7gKQZZxVg==
X-Received: by 2002:a05:6a20:9150:b0:1e1:6ec8:fc63 with SMTP id adf61e73a8af0-1e88d0e1718mr18548992637.11.1736536218702;
        Fri, 10 Jan 2025 11:10:18 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a935csm1896956b3a.179.2025.01.10.11.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 11:10:18 -0800 (PST)
Date: Sat, 11 Jan 2025 03:10:13 +0800
From: Zorro Lang <zlang@redhat.com>
To: Mark Harmstone <maharmstone@meta.com>
Cc: Anand Jain <anand.jain@oracle.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"zlang@kernel.org" <zlang@kernel.org>,
	"neelx@suse.com" <neelx@suse.com>,
	"Johannes.Thumschirn@wdc.com" <Johannes.Thumschirn@wdc.com>
Subject: Re: [PATCH v4 2/2] btrfs: add test for encoded reads
Message-ID: <20250110191013.o2jieeflghev2bej@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250106140142.3140103-1-maharmstone@fb.com>
 <20250106140142.3140103-2-maharmstone@fb.com>
 <b085669a-3684-4031-9e0d-3275289e86b6@oracle.com>
 <92429a09-4ee9-4561-8c0b-4e8abdc78f57@meta.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92429a09-4ee9-4561-8c0b-4e8abdc78f57@meta.com>

On Fri, Jan 10, 2025 at 04:39:29PM +0000, Mark Harmstone wrote:
> On 8/1/25 06:33, Anand Jain wrote:
> > > 
> > On 6/1/25 19:31, Mark Harmstone wrote:
> >> Add btrfs/333 and its helper programs btrfs_encoded_read and
> >> btrfs_encoded_write, in order to test encoded reads.
> >>
> >> We use the BTRFS_IOC_ENCODED_WRITE ioctl to write random data into a
> >> compressed extent, then use the BTRFS_IOC_ENCODED_READ ioctl to check
> >> that it matches what we've written. If the new io_uring interface for
> >> encoded reads is supported, we also check that that matches the ioctl.
> >>
> >> Note that what we write isn't valid compressed data, so any non-encoded
> >> reads on these files will fail.
> >>
> >> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> >> ---
> > 
> > 
> > Looks good. Add to the group io_uring and ioctl.
> > 
> > Reviewed-by: Anand Jain <anand.jain@oracle.com>
> > 
> > Thx.
> 
> Thanks Anand.
> 
> Zorro, can you please add io_uring and ioctl to the _begin_fstest line? 
> Or do you want me to resubmit?

It's been added by Anand, I've merged it. Also I'd like to remove below lines:

  . ./common/filter
  . ./common/btrfs

  _supported_fs btrfs

Thanks,
Zorro

> 
> Thanks
> 
> Mark
> 


