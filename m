Return-Path: <linux-btrfs+bounces-19781-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CC6CC1A05
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 09:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0931303CF4D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 08:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9977732C951;
	Tue, 16 Dec 2025 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fy5qbIw1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQx2whWG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B85C2C0F7D
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765874525; cv=none; b=GIyYT/IY0IcJLS+LEo6hGaaiV6IOLXY1wvll+jS19BO+tRuHThnFhMrmcxdnyp5RmSmaU8k9iAgUO5V2WD4hdl7+vzXAfjoJKkgibBKsaqPd//oIenatjenbOVALB663H1q93o3VSbRZroVE7tcOvlJt1i4XRqyfZlU/fCJsuuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765874525; c=relaxed/simple;
	bh=LeSPLdw8CyUvLD+Wsks/a84DYfWD8ihFZCgPW/k/oKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVKea4GCWai5kx0ZhfMrPQbC7hBIKzylfMZKK8//xkYkf5UUi+lT0woP24Jixo4RfRY3HEF1yIfWkVfK59fzQw2IuudYcXpR6Rsb4CxlFmNFmwXkqyVMX0RGY1q9rZXDzYsCq99u38frVu/2FWSKv/Kuis+CCl34jsrV0DHVoyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fy5qbIw1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQx2whWG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765874522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bedoI72M4dzcfCaw0bozxUr5koxef0u+N35NgEwFoMY=;
	b=fy5qbIw1alUUbM/YYniIOuT7YA70oy/gyNnI76x26iHVwvPjoPKoSs1xfqd9+l9Lfu4ILf
	CwGeGXhg5Zw00oyFICAglt8D4guJll3wNqM43IQJRVDZ23ZLA7iDt05XehcWdT9ZUY9GST
	9WLGqapYsEEAAKseUW3im9AhlOZz8ow=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-9-EHQMV_OSGSDWwsKgOwIQ-1; Tue, 16 Dec 2025 03:42:01 -0500
X-MC-Unique: 9-EHQMV_OSGSDWwsKgOwIQ-1
X-Mimecast-MFC-AGG-ID: 9-EHQMV_OSGSDWwsKgOwIQ_1765874521
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-64651279fbdso706755d50.0
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 00:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765874521; x=1766479321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bedoI72M4dzcfCaw0bozxUr5koxef0u+N35NgEwFoMY=;
        b=bQx2whWGC7/zTs/T2taZQ2SwQ3sakREVj/mczAXJf6or4kz4UIjWV/oNhg0zGhWj3v
         KypdbgOP2xq1nMAKubDDT1siuotr2dc8rusCHUa7yS8PGPBDd995LZvMQQObPaKmLB/Q
         nQBJBE+FN8Wd0fJuYhOw1E1eWJcmCIdlKnCir5FbILdQt3KTi452ES1minrzUioHQfYA
         RVUEKq8n4ei11Vts3aI2jnWql8uqcI9SlwrTZC4gb5SqFu4n818CNXv5Ziljxrnpwfo5
         9RI5S/wmuHmLvtfO04JzEEKdgiHfei0mZKzQQiVmOhhkmudtm+a1SQW/M6BvojVOwIaQ
         AlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765874521; x=1766479321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bedoI72M4dzcfCaw0bozxUr5koxef0u+N35NgEwFoMY=;
        b=wDLpgukSN6H9nx+KYU4kpl5I4HC7FwRG4OeHJlPHeWMPimMmK5BlmNFNJB7DYbawV4
         x7bmRsGKF3DS8c8LV93LkdI1c4+gVZTOFOGu47jxI5gR3d7/Vs1kgL+b0bdeT6B/kujh
         alVw1tWdemVHQUlCiiMzaPmEQ9Sp+uZty1qr8CbA6Ki1raiVkgcn9jFuglsVyd6pgbsU
         ZR9Sx+JyGQBGBQ4qU2A6ds1ie5ABBoBFH9N1pe7SJz7SWXPNTB3V+dwn70nVt6ccub+H
         w3vIYGdf//y9vpDWtI1vh1sGi2vx/FcgUB2o4o4FNL3mfsYUbFd9F/Lkah3ED/2eCFhw
         +miQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY2MsUvek1EMpWjqUFBbjTvtnKhXqzAEeb8urw26TlC6ep8L+RmR22ITuBbJ0VA/Xn1dWaX0VK/b1Vsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ0pACAHxqskBVzvEEtk3g/WUjdEb/pmUrRzU6oWmodd52F2dr
	5PMjnrqGHk2MMox8vHXgtNmGDE1ZOpQDZ4p3mZMPd9dTR/TSOXe56HGxFDgdSWPnzraKj4ZSQvf
	2Bv1J82ac3uO0zTfnx6syudjdvUT/oylsgjmExiILSVRfuGvmCSDnG3hBAY+h8Im5atCVIBsYAc
	/eXBERE8/uYnnsj5aILY1ETE2CE56/QiIzLeNx4UWNWI/9ii4=
X-Gm-Gg: AY/fxX4pfF2yEJTlK86CCoOW+bqFRNuRTHRIZrHCgjgw0pgPO1HWp/mTAiWayhJPmID
	jc0VzXC+BMkzL/mbIWkktdK+yZmGX4VgvRGhwYpMFoo/dzKLnhN+4Exdq2GNs+2MZRORNAKMcmt
	AROHUs4eBZT5AnYo+LbCY96M8sIqSbBdBTfgfNn/Vy4+rVPqPfnlPqqvg2wWQJa1q6
X-Received: by 2002:a05:690e:130c:b0:641:f5bc:699c with SMTP id 956f58d0204a3-64555664965mr11300523d50.74.1765874520966;
        Tue, 16 Dec 2025 00:42:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsdXWnoFL9I7pAq/MaIAVAy9awQVMPdeIdCZyZ8gA28f/XjQGXPGkhfCfGI1rJgvn170eyS00H/OkJzbKACvU=
X-Received: by 2002:a05:690e:130c:b0:641:f5bc:699c with SMTP id
 956f58d0204a3-64555664965mr11300511d50.74.1765874520647; Tue, 16 Dec 2025
 00:42:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208121020.1780402-1-agruenba@redhat.com> <20251208121020.1780402-7-agruenba@redhat.com>
 <aUERRp7S1A5YXCm4@infradead.org>
In-Reply-To: <aUERRp7S1A5YXCm4@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 16 Dec 2025 09:41:49 +0100
X-Gm-Features: AQt7F2oWOgXF4BWLyQhRHkpji9S9Pl-ufTycpWlGBJkrm01TM2UaID084bN-gCY
Message-ID: <CAHc6FU6QCfqTM9zCREdp3o0UzFX99q2QqXgOiNkN8OtnhWYZVQ@mail.gmail.com>
Subject: Re: [RFC 06/12] bio: don't check target->bi_status on error
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-raid@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 8:59=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
> On Mon, Dec 08, 2025 at 12:10:13PM +0000, Andreas Gruenbacher wrote:
> > In a few places, target->bi_status is set to source->bi_status only if
> > source->bi_status is not 0 and target->bi_status is (still) 0.  Here,
> > checking the value of target->bi_status before setting it is an
> > unnecessary micro optimization because we are already on an error path.
>
> What is source and target here?  I have a hard time trying to follow
> what this is trying to do.

Not sure, what would you suggest instead?

Thanks,
Andreas


