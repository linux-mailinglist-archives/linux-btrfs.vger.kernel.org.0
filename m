Return-Path: <linux-btrfs+bounces-5448-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFD28FB83B
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 17:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443D6287FA0
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 15:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0263145B09;
	Tue,  4 Jun 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="P4ngIq95"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8823236
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516735; cv=none; b=iIkCdyBpx7KuNpLb/8jNfvcrw1P/AZSAMejyr9zRVZyWkNhoHgVLy/OW1RYPPaHws8SQ7nb0nVpNEchBD9kls5uVmAKF0L+daCEdG0nGEQeUo+oMlHpZJl5lLf5O9Ax6YDexVzZpnMpEBYMxLVmNkv4Hdkc6DJR2tr6GCmsONO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516735; c=relaxed/simple;
	bh=YUJGq7fJSRqVHL9t3aVPdpC5Ix6vfAbwuRgpQP5XflM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYmwmCht4wFwObv2F2OB5RR8owbx0VDG7qLgyj8s8Cl0d/INnCTioHcaj7PzgtzpQkV5MO4dSoTNnVzuq2gF1oJi8yKP98j/s6fYB17P/QTLKYxVJ91h7cmwTQVdhhqWMUgnwL/YJrUXf8jkvy3WbHI/TpnmUj7u6VKmU24MUsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=P4ngIq95; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f63642ab8aso34369745ad.3
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Jun 2024 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717516733; x=1718121533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y9Ycd2kUnCBrRBojUHRZm/RvOIhJz7s9qMsELyxw4S0=;
        b=P4ngIq95CKhwWi+GQ1/Y27JPBHBSVUIcmw98XLlGNM8VXdN4wdulIIzwekRxOsUNEM
         2HjaAMj/XE1Wjhmr34O9Y9rzbY1T5QE5IvrtNojun5+FM21QIHLwYdWwGpnPiTVcCYN4
         QA7ZwiFWA3QnokLm3IiDZmqASIAsAnb/dTq3fuLH6QuTniX9z+tjgKJRvRjnKMjl0ZAm
         L5pgv0jCXQAYFm3R2u4JqsrU/1B3umSMXtOyKmNGxHb0bhw4znylDT89fuITeGfY2rK9
         3hfmv1dMTrvlopIuOQ8eAiTpW11uq1CJ5ZAPC+Z4SgzMaEeoTm9W6jbFDZB2+IMBzQtW
         wmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516733; x=1718121533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9Ycd2kUnCBrRBojUHRZm/RvOIhJz7s9qMsELyxw4S0=;
        b=sDXfrtih3gHMR++mKTfI4Vf8IaM6lhZgluCrBGi1fMJBm+2OArwhPQAz+S4lomoJqH
         IK0MtOIYqjIbg42DKSc/pv/VWv4bARrQbIlB5jRagv0eoThKEt2cTxBuN/RCXxfBXGek
         uYiXznQqDCLpx/yX+r2NAnWOCJAJO2n5aRppZ04TelHoAvQe/2sJiSsu53DJtQ3wBOVn
         emG+aNNz6chPcTy/JIv0EeIwmTax8v7wwVpjcr+LzPSiMeQPu0g3YX6Liyoj0/jGBbP+
         RuCZsH0goPzuww+dUVZYz6rd03FRCDoiYR7f+wY5aAjwYTrg4EM1cIKMmlwzBYDNNhfc
         S4mg==
X-Gm-Message-State: AOJu0YxLS7FPmOjNDDFOSRUsQyart2UmUdd/picuneGh3M1C9pZRXP5L
	IUv3hl/Sci6mGdd+fyOe04GphUTkS7/xu9a6WbHO9tgG1KZ8ke3HqPz/gBRemndUg/sw/MLm1Ju
	M
X-Google-Smtp-Source: AGHT+IEejGGF1I5wJSjWtGFhiinLXUFAzqHEjQbKz4il7vDgERFnFoYO3mhBdTTu0THJObU9Gml6rQ==
X-Received: by 2002:a17:903:2306:b0:1f6:343f:dc36 with SMTP id d9443c01a7336-1f636ff4c6emr146132625ad.5.1717516732950;
        Tue, 04 Jun 2024 08:58:52 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:b1eb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd9dcsm84924715ad.126.2024.06.04.08.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 08:58:52 -0700 (PDT)
Date: Tue, 4 Jun 2024 11:58:51 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: error out immediately if an unknown backref
 type is hit
Message-ID: <20240604155851.GD3413@localhost.localdomain>
References: <a8cb7544a9369a309212cf648facc4cf51199616.1717479367.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8cb7544a9369a309212cf648facc4cf51199616.1717479367.git.wqu@suse.com>

On Tue, Jun 04, 2024 at 03:06:22PM +0930, Qu Wenruo wrote:
> There is a bug report that for fuzzed image
> bko-155621-bad-block-group-offset.raw, "btrfs check --mode=lowmem
> --repair" would lead to a deadloop.
> 
> Unlike original mode, lowmem mode relies on the backref walk to properly
> go through each root, but unfortunately inside __add_inline_refs() we
> doesn't handle unknown backref types correctly, causing it never moving
> forward thus deadloop.
> 
> Fix it by erroring out to prevent deadloop.
> 
> Issue: #788
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

