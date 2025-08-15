Return-Path: <linux-btrfs+bounces-16083-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91558B27CEE
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 11:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053991D07C5B
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 09:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD542989A4;
	Fri, 15 Aug 2025 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EO/xVUPx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BF9272813
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249201; cv=none; b=kv3ouT7mwv1ZlEl+SWwCDBbwPPoZR9SAPDx3XnxoAwQaojdYnR7AIwEQEvUdPHRY5l+uooPVsHPVCWloiHnuWxymtNg6p88R9B/ZtiGrFRoqhTfLuRBEIAlFky93jAgKYPDYsGN5NMqhyOjj3DelNnXZtdahLM1Kp1OxsHlU7a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249201; c=relaxed/simple;
	bh=R1ChGoOiLWXPCnytpCVLCvDMw2jJbP5bOxcuNmV/5o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7cycphtUjIyJGPZk1v2T/ldcFZAevFSi8jiiRt+OmVLtN9zZCrTcjy6L3StVfdftKKDNyXdtu23y9XN21Daf3YDOk+c60ybI7og7SXT41Bj5t/zw7DqEvKdAW9DihrfGAAuu5fJRwbkvKV+ooBx2matPzz0RAq4jjXJwhkCwkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EO/xVUPx; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b9a342e8ffso1269496f8f.0
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 02:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755249198; x=1755853998; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ftw2ZfoUFvGBlklurn4IZdlca9Rx+oE47CzR8v2kWZw=;
        b=EO/xVUPxggom3ayaFdfVrZpkOazUjTyNXa2yhkMMxifPBOJIEl/VR4zzWrtrT+QNpu
         /GoAYtFDWSGcV4ll9if1xnyiIPb28EYTWysB6s/hwBfGaeMpoY+p1u7MGi+Ua2DTLxe7
         hdXXhB2k+bzTsO/2UKjDThtj0zfdFmfr5deIhgjOt3z9AGOoeSXSYx08mwyeUmrp5WR4
         DSkdxOEOYRTKlxQOjP/YY5ieJOw6I9sijO4xnnXEfpXYVAMRFMAQHXOmaIiohvEPArud
         DBGku106JC2PaUk7Bvwkewj1Gg3Us4hvCmwaYiRaTA41zNHrTWvJPlOCNoU0YKy3b0IU
         AKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755249198; x=1755853998;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftw2ZfoUFvGBlklurn4IZdlca9Rx+oE47CzR8v2kWZw=;
        b=Z8ZWheqtYftPjS0fWEkFIOmSGzwIcjMGmlnCnhP1PKNpmLiimWgnhTOu6DoMZR0kuU
         oyXB7SQRvOXx30PxUTJ2a9QTQ2AQayN2blwTJDwUmmpPyTREhA7bdjNKtHr8zxYYS346
         KvgVpdvmtIXZ+Ze5ju55TXq+2CaKl709qK0g3fqEJlHN5utKl1P0+C75zwVkhN7Ljc83
         n5R/297FlOv0VlOXs6ZwpFvC74u6H0/EXJ/9gQFmvIeJc75v+vQlaPQsmtnPB/KIAHgh
         qiPgF7v0BFqgOKXZiFuq2X7/bOhkXUCcgC4kAtSqjh6OkKozKlVPt4mndf/vAkc+wfIN
         ohtA==
X-Forwarded-Encrypted: i=1; AJvYcCWw9iBTalR8jejFW4BxvyixIgboXjiG6LxZWRBS9+FDY5umYt54trJOLJys5O+ygsKrIRQf0oneNtg7qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQHWFsicJWVbBKgS7t2q+JlZ9YJovmXBcBqvYY4mAQnFtDpJpq
	vZzhdS204cdjfZ9jY0q+GlFlvW56GCuu4UhuahtB2sCUfTvYq0Qk1yiJXxIsPxWy9wY=
X-Gm-Gg: ASbGncvIBLBKRMQ9ka2Yd+ucZrMIa6CURKIAveQdzMsckMvUrJzGXFQ8qz/Mn9Qd557
	p8udaC4z0jH/dmerHqxwsTl6kWgK/+uHcgirp/vxAjJqYd+wYxl94Z4kqKX1E+r0/auShG4gGSs
	ZDqoB0Q6zg2l61gcMrmpMmjvfQgXYJxEO94NUA6kAI9Vv3OnQ1s4pinIJ/gw5B3kFEw6qEUhoKh
	+kZsG7GNXlJlBaI12JANVOzNOjAID41eOcFNFl4bfAZJVn1u/a3oGCSeyDrcGTFif6iE5ll8UC6
	Z+/PdQ/2D7H9vus7jinntHhIMWeWnEAl/U3sWEvzs8EfDsMSukWYy2ilT9thB4MgRZvMNS8SXfI
	U688eIkKr6j3PVeVv9YwmFfiY14Ppla3XK4baq8Tytp8=
X-Google-Smtp-Source: AGHT+IGeNwN1NyLOt3iH637ptOqB9Y2vA35yxNTjFi6nt+WndRakdYXgdd6cR4AP+i+PrRRlGnyzyg==
X-Received: by 2002:a5d:64cd:0:b0:3a4:f7dd:6fad with SMTP id ffacd0b85a97d-3bb4c5b7fb0mr1380255f8f.14.1755249197741;
        Fri, 15 Aug 2025 02:13:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3bb656dbec5sm1203508f8f.31.2025.08.15.02.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 02:13:17 -0700 (PDT)
Date: Fri, 15 Aug 2025 12:13:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [bug report] btrfs: abort transaction in the
 process_one_buffer() log tree walk callback
Message-ID: <aJ76KSPQYnatNCAd@stanley.mountain>
References: <aJ7YkIlcNnv1YKeh@stanley.mountain>
 <CAL3q7H60EKQbXUm_cfEY+bsv+SpnYV0uLuVSGNKkgMnHKCkiGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H60EKQbXUm_cfEY+bsv+SpnYV0uLuVSGNKkgMnHKCkiGg@mail.gmail.com>

On Fri, Aug 15, 2025 at 09:28:34AM +0100, Filipe Manana wrote:
> On Fri, Aug 15, 2025 at 7:50 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > Hello Filipe Manana,
> >
> > This is a semi-automatic email about new static checker warnings.
> >
> > Commit f6f79221b128 ("btrfs: abort transaction in the
> > process_one_buffer() log tree walk callback") from Jul 16, 2025,
> > leads to the following Smatch complaint:
> >
> > fs/btrfs/tree-log.c:377 process_one_buffer() warn: variable dereferenced before check 'trans' (see line 375)
> > fs/btrfs/tree-log.c:388 process_one_buffer() warn: variable dereferenced before check 'trans' (see line 375)
> >
> > fs/btrfs/tree-log.c
> >    374          if (wc->pin) {
> >    375                  ret = btrfs_pin_extent_for_log_replay(trans, eb);
> >                                                               ^^^^^
> > The patch adds a dereference
> 
> False alarm. This already happened before that patch, we didn't check
> if wc->trans was NULL before calling
> btrfs_pin_extent_for_log_replay(), and that's fine because if wc->pin
> is true then trans is not NULL.
> 

To be honest, the deleting the NULL check is the most common way to fix
a "pointless NULL check after a dereference" warning...

regards,
dan carpenter


