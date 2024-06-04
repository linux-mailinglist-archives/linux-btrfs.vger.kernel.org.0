Return-Path: <linux-btrfs+bounces-5446-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A18458FB82D
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 17:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37DC1C24C9C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 15:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B601482FD;
	Tue,  4 Jun 2024 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RL3qsSnH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF27412B17A
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516525; cv=none; b=EeVF4LQJON1xiGW9t3zyRm+W/nC6nX4dCtwLdfAKqzSY+cB2gtCQoxNiDy0qShaOv2Ez9Srbmrs8m0fjRJpcNdCLbj+pw+Bz4T/+FdsURpSBW/xvg8LwaUvA6RfeY4XwqHI/F4B3c91FUX38BfHQA93OZp5fWNBgJKWkHBR3wj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516525; c=relaxed/simple;
	bh=MwzgtpxDko1UcA23TvNOF54C5hM1jBZ1gDyiGINXchM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4Z9QNNcMzm0MAutMSr2Hqo4R+1tLpegSt+ERCkEbU7X1hgIoBdNm/N2JZ7s9Sl+d1NW6UeBJKPc7hiySdP5vIugTAqxxJplLllZpe5JoJXHWc94jlwh5ijzBnQnnkrh2blIXF+1Wl1AZKwdBfXCJUN6lV6WggE+z1fz5HvvQQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RL3qsSnH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f8ec7e054dso3984313b3a.2
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Jun 2024 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717516523; x=1718121323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i9whgU3xawaH6rqTDLwWemjUlfN9o/Mso6He7v1pWCw=;
        b=RL3qsSnH1AaMrqGEsp1MnmcZ9isHfIjzadmV1oNM8sVVRH0a29IJAO+C/2hNWfogcy
         H6wk1yCWn6B4T+PEu2Inp7E/4YBYXVC+BV2+Yp2wPShL83vE1XfM1CLWlhQcyFl/t1pc
         w2C/6UnWChxL1zfYF1mtXDMgRRW7Tm5pGYSPD7ViKHa9TJoF97zh9JJBCCpmk5k5mIAD
         Wa8MY8ma7vY6uyOeykNKAwVsPzbSdceKziGC9agxRwDdr2An2LQBcCFTKsEI8uhjXSad
         BOLMoqzn/DW/xMf691oEa1wr38CUrKQZFJ0Vz9Qif/7zvFA8dyH/tCcWj3cRalzNfTjT
         dVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516523; x=1718121323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9whgU3xawaH6rqTDLwWemjUlfN9o/Mso6He7v1pWCw=;
        b=QoaoTEjlEyvEnMIh3jWy7+VnAz3s2/ybRFJs7G49yhpF0Np1zsYidZBMlBou+J9uzL
         xivcRqRWxX75yLJzc7+JCS/IPT+hkCjNv4skeKvxznsbXDxwe1zaxW80+8EaJDgMTJ/8
         FJo+V3cC3xhInGnzueSdk/386TLOeCSXwOIYGGrQvsoi/P4rQhe6ie9z0vCR+znOiC/0
         +b5UMDejbIHJCfOnYmDhEoTtraBVyVaDv9Ue4wg5kK8hvKjGgnH+5PKL5syxCvHUxge7
         b0Kunf8BjrWfXU3JDlEmVOF0V1r2f3QC3ecZJcltZXOp76RQjl6t+P9HLoLKgI4ZxHMM
         9EIw==
X-Gm-Message-State: AOJu0YxhwRXprKtUNDvCOHdr3+mONeZKVZs3XMePFi09GMHaxv1sqDhL
	DdraaEXieuLu1acrAmQbnnMEBt7kFy7zeBw/7agAlgpsDy5uciwRH4mBymLkuWA=
X-Google-Smtp-Source: AGHT+IFvBHAgINcTnsujF1Q4Wosa0G5WE4KwBhlyIIzPTUShdHHiaUr8foHl3hgLsdoyC9zRoStunA==
X-Received: by 2002:a05:6a00:2e07:b0:6ea:b073:c10c with SMTP id d2e1a72fcca58-702477bd93dmr16398371b3a.6.1717516523147;
        Tue, 04 Jun 2024 08:55:23 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:20d6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c3598487d9sm7155687a12.70.2024.06.04.08.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 08:55:22 -0700 (PDT)
Date: Tue, 4 Jun 2024 11:55:21 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: corrupt-block: fix memory leak in
 debug_corrupt_sector()
Message-ID: <20240604155521.GB3413@localhost.localdomain>
References: <ebd4d57790941a9c1edef52e09ce0bb4838ab27d.1717474840.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebd4d57790941a9c1edef52e09ce0bb4838ab27d.1717474840.git.wqu@suse.com>

On Tue, Jun 04, 2024 at 01:51:33PM +0930, Qu Wenruo wrote:
> ASAN build (make D=asan) would cause memory leak for
> btrfs-corrupt-block inside debug_corrupt_sector().
> 
> This can be reproduced by fsck/013 test case.
> 
> The cause is pretty simple, we just malloc a sector and forgot to free
> it.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

