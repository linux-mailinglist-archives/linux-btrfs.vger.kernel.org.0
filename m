Return-Path: <linux-btrfs+bounces-8590-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 759CA993071
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 17:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7ECB1C22F76
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 15:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C46A1D8A05;
	Mon,  7 Oct 2024 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="a3rbHLsg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0A61D89F0
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313344; cv=none; b=fW3LO9CTtM3TOEjendoH7N5qfEYWnN87yPJ4XsQPQG4Kztz1RgWW5kkW1JZ3nUtu2VkfPk36721J2o30ueheRTTzGKGaO1oiEGe6P6N5Y7wtPjhDyF+vBSQkrq7MqzGvG0b78n040fRSb+U8gjSv7ZJKDQbpoQ3MXXXsGlSCM5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313344; c=relaxed/simple;
	bh=HUF0vw0tWNFgXx+QQcN/F/V+Ir8e6dY8xxNJxawG4I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdFaq/5fyX8dSwuE+KywEIk5OU0+MwSRtNA8THnSHLXNMpHSRzR1jDOVmQXfLAvtC43fbH/luDcQZexnQMG3iAYuodXb4vKJ1c/M52w8KggFskNe6WHfAuZ7XebBqsXz0CinR0568TcjRGVOPiwHVlc0KNtkPNFUaUWEW/30exE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=a3rbHLsg; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-45821ebb4e6so41503871cf.2
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2024 08:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1728313342; x=1728918142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P3ubTv6P+LTUgk8v2otQ1m0MbDwdMjkITxttzGThPsQ=;
        b=a3rbHLsgCLaODXp+hHiqo3P8tLDNJvW7Ha+V3JZDFqu3fM2op4DQfTFXByGl7awFYH
         1sPWsNSPgPk2tqahDyWF78OWd97COzqg1CHBWfnLIC6jhbjzAtpgpMZneyszTtNDr8r+
         aLJ5DBaokuoDTdm5nadPmkZBL3oNzNaim7Y/0dGpCza0eVw0jm8ZYH37/LXmqRf0bxSV
         xr1aCKkdeQWOd5FH+0mUHN+2TXfDKonqc0jN/akB6scGt8qoA36FzDTxoDq+mJXGaIt6
         jaXpaD2PKwxxbbT0vaBIEwJOeEiCxpuTt1zP2Vn8+v1yZIRKHsqqfyOLvDlV/+MoaRl7
         a4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728313342; x=1728918142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3ubTv6P+LTUgk8v2otQ1m0MbDwdMjkITxttzGThPsQ=;
        b=U3iQHGlNvHPfVJyiGniqVD8ozpVz8FUFbySe6/IpD4rBxX4glPJuzlUc3sWENGjeZU
         qj27Ig1NB7CsL+PgHy0XshvgN2XHlIPd8ihWRaQcRRbsWYz3Ks3p6tYXEv06qHxumaoc
         Sxf821urLCqny2WYsynCPGjAc8kydr28e1Lf0+mx8Stucu/9gsC98tIUVJP4DNTzgcJT
         edIJcdAf+QaZ9j2DqdxXFFR9xpArLbWOU6JuY2CaeJtGCipK+n+PL/FDRo+RRAfmjxc1
         lazEF/mkjJEkUi4BcC7+7IguNURGCzo3YP32BL2M9UiM8D9XV2gKDbgxilwpQEOdr7ay
         jEPw==
X-Forwarded-Encrypted: i=1; AJvYcCUmGE7OEGKX7J9kvWjTE0Y8qY2pOeunwGev4jc6vgbmjfZU79hBoMxXCF2eBFeqHjfj2Sn3JK70fIv/Ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjdD4z6M1jsKmIcWyKGv3cOwpWB3YzZ0OLnTPGdaOo2H5q5Xbr
	pH9eRu3jrtPJGuGNLfFU+L738dpv1pkKiXvlx7g1SjBs8+byU6Od9bQk9vAX4ik=
X-Google-Smtp-Source: AGHT+IFeC2KbsY8ejVVBU0Vm2DBvvopClVYWPtBe1daUyfPnt8RR6P/3sLVatrhdMADVgYKJZPROuQ==
X-Received: by 2002:a05:6214:540f:b0:6cb:7ce7:c076 with SMTP id 6a1803df08f44-6cb9a2f58c9mr179133906d6.18.1728313341510;
        Mon, 07 Oct 2024 08:02:21 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba46cced5sm26476696d6.7.2024.10.07.08.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:02:21 -0700 (PDT)
Date: Mon, 7 Oct 2024 11:02:20 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
	linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 0/2] btrfs: RST scrub fixes for prealloc
Message-ID: <20241007150220.GB1898642@perftesting>
References: <20241007115248.16434-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007115248.16434-1-jth@kernel.org>

On Mon, Oct 07, 2024 at 01:52:46PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> When scrubbing a non-zoned RAID stripe tree filesystem, the RST specific scrub
> code finds false positives becuase preallocated extents are not backed by the
> stripe-tree and so the lookup failes.
> 
> These patches address the issue by a) changing RST lookup failures from
> ENOENT to ENODATA and b) skipping ENODATA on RST mapping errors from the scrub
> side.
> 
> This aproach was suggested by Josef in 
> https://lore.kernel.org/linux-btrfs/20240923152705.GB159452@perftesting/
> 
> Johannes Thumshirn (2):
>   btrfs: return ENODATA in case RST lookup fails
>   btrfs: scrub: skip initial RAID stripe-tree lookup errors
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

