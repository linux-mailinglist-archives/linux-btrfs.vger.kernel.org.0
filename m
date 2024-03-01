Return-Path: <linux-btrfs+bounces-2979-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC8786EAF1
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 22:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06FD81F24687
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 21:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA0456B9E;
	Fri,  1 Mar 2024 21:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Kc+SQZOi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ACF20DCD
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Mar 2024 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709327481; cv=none; b=tpPZy7QZSBjeXeFDGMXAk4j2ltKrEWV0MlaZVGklGyYRMWttQA99Ordtf+PzIQo3bkee1fR68xyTnCVx/u7UTf0soyTm+9dFcL5wTOI8ezaRKj1X8h4Bl/Y5EsB2cXAb58/KFpbvtxozDRzAWo5yBUkJZMHSsGgiaz+q0+LPJfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709327481; c=relaxed/simple;
	bh=oDNWfTUPk65V5sflkAMiIg46e2wTr8Y1QkqObx2GOJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4fr7C9/JGiGGMRkJJxHMFtnJf2Z1UQfZ/j/l3/dFEW55UpK/Lx8WBCL/xxBXftk++9nub3yonRv3eGRNbCaXLTWwdxt45bkAuVaX+IBWa60lnmrXcwrlrRqzYtmyesBSFLygCx1m0bymyv10HDv7+zhJxi01v8cXiEuNcm+eR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Kc+SQZOi; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso2944257276.3
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Mar 2024 13:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1709327479; x=1709932279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yyM7qElYLiu6TXxjnnNBRFVfnMJ8Tl5Q4NFFjjnsM3U=;
        b=Kc+SQZOi7DQHc/GNVOLhXdwFODWsPPDJBbxiOd+UkFpbLHGEl+Hcn32JED+bGfWAZS
         4/mUo+X/hxB+TeSNqWSwXQbafxD/7uEsld0AIE7Fch+EpUWxYNI6SPmJJMk6JnoZdos0
         E8PW+wDiv8iCx6aHz+SBuvdaQBQSTHuYUXyJ5sWcMXJxYkvRnVsh263EaW+IBK2hajlM
         5P96PbWB4MHmJsfYfuoXxeKhZxGtu9RtrZ5PUJr5TChY8XRMQcwLUQbRzfOKlGFvNKCv
         rctjWpLfBemps7fSN83hdQ1SBTCMIX8pwsYWonvtjRj3e+BuiE3LN4gsp3+CagTUnLdn
         Js1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709327479; x=1709932279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyM7qElYLiu6TXxjnnNBRFVfnMJ8Tl5Q4NFFjjnsM3U=;
        b=hv0C75pMc4pBMbOQVFSHHsdG0/ZA3+C7FXSxlXbToZnUFAS/EzWxuZfsxdU8muFp8P
         5dR/QcwKrLzE9wilSmj+4LHqMEzVTzHOpuM8y4tsZOOTw4ZbxofKL1iF1JEPLn/Iwo86
         iIpnnxijqPmGxTYRhD8mEd2bz0pDIR4Zu+x7fKipmZa5a5MG1V23aZ8I2/AdNwTKafF9
         dZ/Hd8UMnv5T+IISpHTabIFGu9Cv4pKGBV+z6qkxVnU30H/7UyUuGqrz7+3CNY32wJef
         5cAZ0Yj1mYTLbhNPu9AB+iLqecYOZD9j8GOFdIR5bXhzlQu72yPWHziowyxytEYddAYH
         JRkg==
X-Gm-Message-State: AOJu0YwiL/vu2Kpp6qgf3RmoRhgw5k8FCEExfmxZNAXtiZCl1LMlXH66
	5KWLFUEyJ3JLCDk85gVEypV8ErOnF1riS1wdti6wMn7esLupAvP7lyaU/0+e0EhCict7gZcQsLO
	e
X-Google-Smtp-Source: AGHT+IGSo92P5f0jw66ei/73+JN4YFUHRwiyZpsaQAn6tzQXPglpc+y3OctOtpea35tRjTaP8jLWiQ==
X-Received: by 2002:a5b:782:0:b0:dcc:a446:553 with SMTP id b2-20020a5b0782000000b00dcca4460553mr2267305ybq.57.1709327477439;
        Fri, 01 Mar 2024 13:11:17 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q14-20020a25820e000000b00dc6c58ae000sm948130ybk.16.2024.03.01.13.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 13:11:17 -0800 (PST)
Date: Fri, 1 Mar 2024 16:11:16 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix off-by-one chunk length calculation at
 contains_pending_extent()
Message-ID: <20240301211116.GB2112259@perftesting>
References: <daee5e8b14d706fe4dd96bd910fd46038512861b.1709203710.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daee5e8b14d706fe4dd96bd910fd46038512861b.1709203710.git.fdmanana@suse.com>

On Thu, Feb 29, 2024 at 10:50:03AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At contains_pending_extent() the value of the end offset of a chunk we
> found in the device's allocation state io tree is inclusive, so when
> we calculate the length we pass to the in_range() macro, we must sum
> 1 to the expression "physical_end - physical_offset".
> 
> In practice the wrong calculation should be harmless as chunks sizes
> are never 1 byte and we should never have 1 byte ranges of unallocated
> space. Nevertheless fix the wrong calculation.
> 
> Fixes: 1c11b63eff2a ("btrfs: replace pending/pinned chunks lists with io tree")
> Reported-by: Alex Lyakas <alex.lyakas@zadara.com>
> Link: https://lore.kernel.org/linux-btrfs/CAOcd+r30e-f4R-5x-S7sV22RJPe7+pgwherA6xqN2_qe7o4XTg@mail.gmail.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

