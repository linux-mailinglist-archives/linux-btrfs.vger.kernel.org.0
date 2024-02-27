Return-Path: <linux-btrfs+bounces-2841-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F88869182
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 14:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA461F266BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6194213B2A7;
	Tue, 27 Feb 2024 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OcpeZ/ox"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD82013B289
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 13:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039709; cv=none; b=L6IiVNJ7+fEHZNUhlbu488Kn41alZDKerfCcvvKBUphXDUio6QvottEDCl26eurOW8S1co/VUyHhw3RNM8y7UpspT8YadnQ8oLck3uu+wW9KrqfnL+w7e1dhC7IcPczUwvHzsCiD8c/2TKBuQyJJ1pEz1ZnUfuJ8W179k4pFOPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039709; c=relaxed/simple;
	bh=RdoEZdnKeMwHhIufQgp4wD6pluHZy4XXTgVN0yUnGUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGVslbn7mLHAUaZfrsGlf8NTl1aIxuomQZPnZohTBvJNczGIavD4hhkuaATCEtNMMeBixMZsLma1sU+ybWTq8SFw9epE4Zasb64Ms+Qx9HSo5iq+NyiHNNPZOXRVVCMbUE4hy5PsMdauyyC/qRNtmiJBk5q73WEM9t9XILZ7jZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OcpeZ/ox; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709039706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T9T4qxEfQQkvSyKLRfkGUn8zmmW0fCrKdZvbzLLoJxY=;
	b=OcpeZ/oxVKWUyw4LwvgrsiIlzTws+ttmTctSX+W0moC0/xwnZC7bCd4mcrxU/rYl0nc9EF
	l+bkvsT7PtbUfv+/c6oJaWsWdTXmyz6qgdDKlc8gNZEKLTlTz8uM8gX4XD3t88GsyNH5HE
	K6HS8lPrCAtSqq+itCN2STS3C1Cq/XQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-UIf134cYNQOz9N1tzC_jFw-1; Tue, 27 Feb 2024 08:15:04 -0500
X-MC-Unique: UIf134cYNQOz9N1tzC_jFw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-299c12daea5so2932052a91.1
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 05:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039703; x=1709644503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9T4qxEfQQkvSyKLRfkGUn8zmmW0fCrKdZvbzLLoJxY=;
        b=Eq6drNNqTnIfyMnzOrWBtcKQyd5chGAqMzDQjTA19pRYWWNSvSyNrOFVycKkQ7c3l5
         OZB8ppOvN4WmtMeV0UdujVproPfe6/ueeeaGvSh6fyONeCwdRZJJf1kZjg8FRA7lpOdl
         UQZ2FqAYSH/Nh8F4C6MGYkmnEG7XUnv6JMoxyC4TbyRRZsSDJa2MF+AEaKUUbXSKHlE0
         WsH59nq6iOnlpx//eZmJExVSE4wyzw+K9Y4wOkSs+jjM1sM8vDsjH/7SWxh5xBm0afwk
         x/rOgVwXCgZGxVZ+fb6sRHC6OvUxhfWn+EB45q3qiPfrFhdLPUcZh66/GO4m1GRZzn8i
         SnpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh7rC69zFqnKkDKtBLi2WqLLYheqtDYep6T5i7IyrpoQn2wR53jCV+CXRuQrn1UL0hgl9Ed2aKtIxwn424yiG62ctEQyun8skbpBM=
X-Gm-Message-State: AOJu0Yy5LzZIzeMvj3GxqP7N/CS4/ufJ6RANr1Gazux6be+RgNk2UOC/
	MdVneqAc7EvdXeN5J6793mEGT7dSzGPzRJcO5P4BBNODTNHz+NCz4CcAxi3HNZJRJlKWvaPcacT
	ovoNdx0htRq7pcsnD2aBm/XhdWGbHZYcOWM/v1KqOWfHf4vAbMX+LPUGN+7GH
X-Received: by 2002:a17:90a:6581:b0:299:a5a7:7579 with SMTP id k1-20020a17090a658100b00299a5a77579mr13130337pjj.10.1709039703682;
        Tue, 27 Feb 2024 05:15:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGO3ubgAsXdpCQuwb7JVy+YhkjlQr/tcNGQCR2qWazznV/vQpwgX9UJwdvsoV1Iduq4JLjqhA==
X-Received: by 2002:a17:90a:6581:b0:299:a5a7:7579 with SMTP id k1-20020a17090a658100b00299a5a77579mr13130313pjj.10.1709039703363;
        Tue, 27 Feb 2024 05:15:03 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g16-20020aa78750000000b006e45daf9e8bsm5874881pfo.153.2024.02.27.05.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:15:03 -0800 (PST)
Date: Tue, 27 Feb 2024 21:14:59 +0800
From: Zorro Lang <zlang@redhat.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org, fdmanana@suse.com
Subject: Re: [PATCH v3 0/3] fstests: btrfs: add test for zoned balance
 profile conversion bug
Message-ID: <20240227131459.soq3af64vffgj3n2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240215-balance-fix-v3-0-79df5d5a940f@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215-balance-fix-v3-0-79df5d5a940f@wdc.com>

On Thu, Feb 15, 2024 at 03:47:03AM -0800, Johannes Thumshirn wrote:
> Recently we had a report, that a zoned filesystem can be converted to a
> RAID although the RAID stripe tree feature was not enabled.
> 
> Add a regression test for the fix commit.
> 
> ---
> Johannes Thumshirn (3):
>       filter.brtfs: add filter for conversion
>       filter.btrfs: add filter for btrfs device add

Actually these two filters are added for the 3rd patch, so these 3 patches
can be in one patch, don't need one patch one helper. Anyway 3 patches are
good to me too, if you prefer that.

Thanks,
Zorro

>       fstests: btrfs: check conversion of zoned fileystems
> 
>  common/filter.btrfs | 15 ++++++++++++
>  tests/btrfs/310     | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/310.out | 12 ++++++++++
>  3 files changed, 94 insertions(+)
> ---
> base-commit: 5d761594fc5832d6d940f113b811157e332e14af
> change-id: 20240215-balance-fix-6bd7998efad0
> 
> Best regards,
> -- 
> Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 


