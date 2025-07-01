Return-Path: <linux-btrfs+bounces-15166-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE73AEFD76
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 17:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F19D483B71
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 14:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43197279329;
	Tue,  1 Jul 2025 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJo8wa7Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD88D27A47F
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381776; cv=none; b=g6Gz4G6MFdd2uvx139jgx12i9sLZsZigMfJ9cJvNBFJPrbjU6nxTgmJWlDvXfwXsxtMqX3HNFmbICswoXQZ1+o+hMWIdkyA0pC3ma8RAKqMGw2S2fhxk18OZOgYKU6+GSAk2XcCw1SkRGQwuObvFmoaItceBh/pCyf+WcTc6m/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381776; c=relaxed/simple;
	bh=jvuexJOYZveqFgLJvIMrTzr0AD/7v+WwKZtlFKufrEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvnenA7oRJsQX819YwHuBHF2njcoqVPf1Fy4wB98rw40FJ13LmNArkcZHFRMC9djKJcKnG1XvxluQgXXLI7Uh7hTG7v+2JcRV58/qcF1PvnW1B5S5ZhiHNl4EImcizi1f2ae253/kOZ9vaByENQbKqLYodhPceGxSTKszO+MLpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJo8wa7Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751381773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nXPDzUcvqq06M77VS5WtNkCRVrYbBSSbiWNXP2vd97c=;
	b=AJo8wa7ZrhVzmqoOjMB1ln2VnxL6neBO2PVMpbA7GQXGEvxbA5M5fPFnTiXT3nxyCa6Ac3
	xokOqhOtNWAz0UjHjPn2kBbEtHeoYFwgGLcIhPxRwbj8IuQ8jvmoOlfoIp9nyewkm6MeyD
	JJHgPa/iS5CgLwt9uaXUr8Jp6qM+mZE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-eALU1J-oPemP7rc6qaYQEw-1; Tue, 01 Jul 2025 10:56:12 -0400
X-MC-Unique: eALU1J-oPemP7rc6qaYQEw-1
X-Mimecast-MFC-AGG-ID: eALU1J-oPemP7rc6qaYQEw_1751381771
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b34abbcdcf3so4324382a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Jul 2025 07:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751381771; x=1751986571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXPDzUcvqq06M77VS5WtNkCRVrYbBSSbiWNXP2vd97c=;
        b=HSBB268ILJ7moHUKLusyUdoJQhDd8NCoHIngECW1cM+HxHG4BNbevlULnGR2aN4kfd
         TovWVbsRBtoq0jDYcjhQRaWAFfJnKG7V8jPvArWKHq1/qWk5c2Bduld9N+vF2Peefzrz
         sn6lyOME3+LrmJT+KxXgnpWLo5KaEhwkjKIGZoy+3/2fYzHTqrS4/x/MU+cccoDl09um
         tUycb6P8V0C6yJ3uUf+N4R4eps851ueJBLM8uJ3TOArAIT8UG87/M2DebmVgjgPqiyGz
         lQp/yHPcW07VfBlvYyQvTw4LpOSNAPLt5FBwLNe71Kh9htT1uCu7A+vmHj62IBysUXZO
         aXeA==
X-Gm-Message-State: AOJu0YyqtHHUuA6ic6btTwvurtd66DQhtmIBiiKCGxLRdRvcSwzgabHF
	CJhKR1MTG/u8z/VxXIrgsjwefMi6UTG7twV4wReRYRhPc9xsGciLriWspaC7QsmsVzj2xB86Kg0
	cYRzrK1Ev+wv5tmxiTMkCyqij+R2jNOxP9EDARjSlxNexCNAYkzjdC4nyx7eSx9lu
X-Gm-Gg: ASbGnctB+XpZbNJkjf1SzWQ3YucdrupOML84/Q2SCtOKTvTJxJQ50bMllZlBgm5tpbn
	hPW/Ss7y8jE2BWIagMTvWT6rtSz2I3yLEu/0/phHwHy2iNmd80rXa19LZ5aGi+wjIpm1cr3J34p
	LT5fbZv2FzWfXvrdmjaRfuRLEhuyOHZwqwKktEJlEu9WZ3afqQaJYwmCFznlTvOFCUwLZT5oe1+
	X0nyfgN1Aa8RAUc/IORVXGM4OSKHzQI4ZoNZu2+rdMpjZQzCPCzw+lKDAjFwk2X2Z0GTqyC8WrS
	39gozIbfA7AdFgH2/6rCYdkyYTlrSi1wjpw+Y5ZOb6ZHGLhaKWtjc02Bq4v+npk=
X-Received: by 2002:a17:902:e78f:b0:235:e8da:8d1 with SMTP id d9443c01a7336-23ac2d8635cmr261455955ad.8.1751381771331;
        Tue, 01 Jul 2025 07:56:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLkmB1wAhsIlceWu1ONxBQU/fOi/8NgTjc2Er0ditpvgRC51YYj9gFkUkUu5tHV8iAgrVRCQ==
X-Received: by 2002:a17:902:e78f:b0:235:e8da:8d1 with SMTP id d9443c01a7336-23ac2d8635cmr261455725ad.8.1751381770920;
        Tue, 01 Jul 2025 07:56:10 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3d11b4sm109306405ad.254.2025.07.01.07.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:56:10 -0700 (PDT)
Date: Tue, 1 Jul 2025 22:56:06 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] common: add proper btrfs log tree detection to
 _has_metadata_journaling
Message-ID: <20250701145606.2mxdnldtcp7hcur2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250630010253.30075-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630010253.30075-1-wqu@suse.com>

On Mon, Jun 30, 2025 at 10:32:53AM +0930, Qu Wenruo wrote:
> [BUG]
> With the incoming btrfs shutdown ioctl/remove_bdev callback support,
> btrfs can be tested with the shutdown group.
> 
> But test case generic/050 still fails on btrfs with shutdown support:
> 
> generic/050 1s ... - output mismatch (see /home/adam/xfstests/results//generic/050.out.bad)
>     --- tests/generic/050.out	2022-05-11 11:25:30.763333331 +0930
>     +++ /home/adam/xfstests/results//generic/050.out.bad	2025-06-30 10:22:21.752068622 +0930
>     @@ -13,9 +13,7 @@
>      setting device read-only
>      mounting filesystem that needs recovery on a read-only device:
>      mount: device write-protected, mounting read-only
>     -mount: cannot mount device read-only
>      unmounting read-only filesystem
>     -umount: SCRATCH_DEV: not mounted
>      mounting filesystem with -o norecovery on a read-only device:
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/generic/050.out /home/adam/xfstests/results//generic/050.out.bad'  to see the entire diff)
> Ran: generic/050
> 
> [CAUSE]
> The test case generic/050 has several different golden output depending
> on the fs features.
> 
> For fses which requires data write (e.g. replay the journal) during
> mount, mounting a read-only block device should fail.
> And that is the default golden output.
> 
> However there are cases that the fs doesn't need to write anything, e.g.
> the fs has no metadata journal support at all, or the fs has no dirty
> journal to replay.
> 
> In that case, there is the generic/050.nojournal golden output.
> 
> The test case is using the helper _has_metadata_journaling() to
> determine the feature.
> 
> Unfortunately that helper doesn't support btrfs, thus the default
> behavior is to assume the fs has journal to replay, thus for btrfs it
> always assume there is a journal to replay and results the wrong golden
> output to be used.
> 
> [FIX]
> Add btrfs specific log tree check into _has_metadata_journaling(), so
> that if there is no log tree to replay, expose the "nojournal" feature
> correctly to pass generic/050.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/rc | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 2d8e7167..a78b779a 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4283,6 +4283,14 @@ _has_metadata_journaling()
>  			return 1
>  		fi
>  		;;
> +	btrfs)
> +		_require_btrfs_command inspect-internal dump-super
> +		if "$BTRFS_UTIL_PROG" inspect-internal dump-super $dev | \
> +		   grep -q "log_root\s\+0" ; then
> +			echo "$FSTYPE on $dev has empty log tree"
                               ^^^^^^
                               FSTYP




> +			return 1
> +		fi
> +		;;
>  	*)
>  		# by default we pass; if you need to, add your fs above!
>  		;;
> -- 
> 2.50.0
> 
> 


