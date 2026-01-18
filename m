Return-Path: <linux-btrfs+bounces-20662-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E6BD39859
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 18:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 838B03001BE1
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 17:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AF62248B0;
	Sun, 18 Jan 2026 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtUzjWNM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jXfjRUNs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC418027
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768756736; cv=none; b=RDjTrZyn2QTKtO2XzsfupzqRcrRg1/uJFD6t1v7PfCdj0TSK50N8x6mJJAQsYsJMSoe6uC6U+k52BaYUrYaQdEetTHy+kZV9Q/YWLjKcIoUABs7R+Z/uHadoaulS/KYWnNjGNA82W/uW9guQ/cQH2tB1LzL/9CnGLzJW3PhVveQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768756736; c=relaxed/simple;
	bh=79WwHjzXcHTApvbu86UG865ls2+qm8AFjVIGbrjMxfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ci0xhRHm1pQl3BxqXlP2P+m/VUAfeWVzV02ge/tdxWw6xYyMgJFdkHyOgucp27UbAHpy+1cHDS8FouAN9zjS62ED/QRRS7qqFpjNVXE66bFbv4ZMqx6E/5SwGL8L+yvYrrAiNy1zLi8k09bKeD88koxTA/ckVrLjIjIvUYDlbyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NtUzjWNM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jXfjRUNs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768756734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C9Sh3sO4hz7HhjVEAHMpRjjqKNJlWjD7ufyRMWnbcZs=;
	b=NtUzjWNMf+8+oEruieh6FLA8ZsBNj8BavT8DcgHc686fAlIxAxMEVKtOLm3ibM4/9hbYlN
	ApSlDn/94Y30/txrgmypMbPuWwcef04tzIUeRSMgfGb8WXCkKAEdJ12gg2KzaHTVwxqQAV
	zxQJoM4aRc5Z+acJbjzefTqAmvaWoIk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-8OWJK45fNl-3ZvRasN91yw-1; Sun, 18 Jan 2026 12:18:52 -0500
X-MC-Unique: 8OWJK45fNl-3ZvRasN91yw-1
X-Mimecast-MFC-AGG-ID: 8OWJK45fNl-3ZvRasN91yw_1768756732
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0e952f153so82536585ad.0
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 09:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768756731; x=1769361531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C9Sh3sO4hz7HhjVEAHMpRjjqKNJlWjD7ufyRMWnbcZs=;
        b=jXfjRUNsjaj7jZ1A8i6OgeTiKswoYu0KQzJSis0ZzQ8sqBS7dEYorR5S6VctALikj9
         0hTN4srkfI7VAg89SyPnoPaagNDG1hovmjLHSy6Zir5LDqRtC9967p8ETyiU/uWMUpYJ
         XDFzsGxsr301tgkyywwlFlAHr+9YTUu8H/o3kEOSXDcUxO+SQGF0PmYyuIo/e5P2khk1
         kIvIuUVb1to0u6nDzQjdLoXTDpBULehX8UJqF1x3sGW4Doa+P81kP53GKfld5n3xh6M7
         IzrYf5Jspb5IJeYF6CcywCcxhZEtaXatO6JcP0U5ltrjxPvYAnxpk7ZiZtTCPMN5K0pz
         0qKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768756731; x=1769361531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9Sh3sO4hz7HhjVEAHMpRjjqKNJlWjD7ufyRMWnbcZs=;
        b=Zanel0CrNwkhbbHigoGbCtXZ7L+9PGLHuFuAGxj0hJrCq3Q8xb1ApAAZO1K6k7zNOV
         0HrDOYlhZUCA/45F+vVvqgp561r5E8MreOHPUdBaDMkxWFx6iBCmnl4KXDhH+/d9U9od
         ELa4p2DrSU8e7c20r9kSGMM1j/LdtKgcf/d34GE1VexQc3h2l1vu/WEaFJe2REbfmYhb
         W2PdWCmQOXnWAIrp6iACrOHomYM10WOyVEIuuohB1/cB8oYg2oUPevYB4W00sQZ2xw+s
         EfoZi+ZoZ3YkiFfm9pseJhN+tdEZ91iGXBZXCuvadqgsvxcvg4LVs2QpOicsuLTfvl4y
         pnPg==
X-Forwarded-Encrypted: i=1; AJvYcCV7ZL6CTe4n+bHEt0yMLO38GWuFjXq5FwXAtsshin+RkEVlXXvt76Otx5HlzXLsQr1ZNRfF5MCHWAxe9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMTXNGUMoGEWh+E04o4/LIJT5FEoBXLRWa0vlkTIk7+R/peuxL
	8di7sMTpuYu0AP299KUYVADWdkxAWNskTvC/KaxPNDMTHd/5idiFOn1FxQF8HeaGl4QcE7AIH/j
	IcpDH+i/uM3DnuswrFOi0THUFGVXBLtM/bZgNcyl8rrBtU+3KP3efbXS2X+8r+1EY
X-Gm-Gg: AY/fxX7dC9uFlFYSi3tsSM2IvrZLJwgHjPEDDr1/Qm8ygU1h42lSoFt8v5UuZTUNS/K
	cKwvWW/txYf1229otFZSMOnZ92Id+KsIuz/9WwZ5QSH+IYiP56IVvS5rUgAZhWU8W63ncaGLe3c
	ZuUGbfCxiDJj8kGKxdy9THywI1MenSc/xVncLXOi/2+PQr11JfoDieGe/gXtGjm42V/zHwmZQqA
	NGMVy8TbpLvXKuGvr59kUOVNrFQzeP4GrriPd86SB9rkCk60JWAYxbIuXjeFOhIVsp2gCA+SJcE
	Bn2XTQu1G9RjCS6Jyrc+0MEyIRDDjODvLa8Jzu2nRZd/6FsRyfZ6jqKEtfI1+AQmbdSOTM6C9+n
	pLajEnK1tmpRKJgcC6yd8HICOux0K5GPupIgTAhDgkShaP+ZaLw==
X-Received: by 2002:a17:903:124f:b0:2a0:c84f:4124 with SMTP id d9443c01a7336-2a7177e2b6fmr79213445ad.52.1768756731584;
        Sun, 18 Jan 2026 09:18:51 -0800 (PST)
X-Received: by 2002:a17:903:124f:b0:2a0:c84f:4124 with SMTP id d9443c01a7336-2a7177e2b6fmr79213285ad.52.1768756731034;
        Sun, 18 Jan 2026 09:18:51 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193decfcsm71452475ad.60.2026.01.18.09.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 09:18:50 -0800 (PST)
Date: Mon, 19 Jan 2026 01:18:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fsx: add missing -T option to getopt_long()
Message-ID: <20260118171846.n5nxfoofpyi2od7i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <dcbecbe996375e0f04962aa2e1a97ade927ecf74.1768225429.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcbecbe996375e0f04962aa2e1a97ade927ecf74.1768225429.git.fdmanana@suse.com>

On Mon, Jan 12, 2026 at 01:44:09PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently fsx fails with an invalid argument error when we pass the -T
> option (do not use dontcache IO) to it because it's not listed in the
> gepopt_long() call.
> 
> Fix this and add T to the getopt_long() call.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Wow, so no one used this option before :) I just tried to search in xfstests,
I didn't find any test cases or common helpers use the -T option of fsx, that's
why we didn't find this issue before. I think you might test with FSX_AVOID="-T"
or run fsx with -T manually. Anyway, thanks for finding and fixing this issue!

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

>  ltp/fsx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 626976dd..8626662b 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -3160,7 +3160,7 @@ main(int argc, char **argv)
>  	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
>  
>  	while ((ch = getopt_long(argc, argv,
> -				 "0ab:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> +				 "0ab:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:TOP:RS:UWXZ",
>  				 longopts, NULL)) != EOF)
>  		switch (ch) {
>  		case 'a':
> -- 
> 2.47.2
> 
> 


