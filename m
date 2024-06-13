Return-Path: <linux-btrfs+bounces-5713-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026CC9075CD
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 16:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BB01C22683
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAE1146594;
	Thu, 13 Jun 2024 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="s8/nfMRT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E048C145A05
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290579; cv=none; b=WVgtiT1EnLHu0nFiQHp0QgYDtDSwXuq+Mw8qBOG4bnm1xj53mlVci80GYSUPzTVKK67p9joGy6SnsrsWw8lybQXasTmI2RmEAFQBoipYk1abqCVy84oYpgom5CL1+NId2Jtv9koZCaACQh8hcpw/0aeN0s+IkLOcUN3ZdZ/AMvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290579; c=relaxed/simple;
	bh=tSHIdxuKDRWMjPKm8MILqHNYSvZPuHlMW20hVnePrLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKR2v8GpiroT7m7ps4bXe1d1rU+fYnYlXisS6F3qdUVNURBCx1yz11L0ttcq2DS+QG53c3SYuo8DYMVEWXh7NzCBSF9x+stdBTOxnDPpEzpvi/u10nxqiqoJvyA7vA1wtuc1afrH+ZG3PRWRTOkWY/fPoB1pAxoiMioYyjdpCJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=s8/nfMRT; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-627e3368394so12658367b3.2
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1718290577; x=1718895377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TrYLY14s3WeMQysVjstGRG029lUvsKQ3iEMwH+TvdEU=;
        b=s8/nfMRTPiSal6JRrxhh8RC0+GgFUfnl+J3ExpCCK0J2c4fuyhtx8Ap0DVpqJWJUFM
         D8c5zDnGy2YyHPZlsq92B6TF2aS1BymGp9ObUq+pggUih0Pt1nSIiFppoXGzD9qBXp53
         MiyxvLLASokcKh9oDxDUQQbZg1hEPX95H3UBA8gGNpcNl5gU+FJ9K1V7TqTcrnoON44v
         n1aTvwdrD7JNxWiWLYp2ZSMcKaH2AlhH6XxuTlgEZt/6JyNl+c6WWl2C71ZfkNvZfXay
         50iH7ZxaUcYTlv8hjAv3vVWwhZInBWeTd4xS+yxBj5wVxfVmN3TesvjF86a/khHUZmyE
         3oQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718290577; x=1718895377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrYLY14s3WeMQysVjstGRG029lUvsKQ3iEMwH+TvdEU=;
        b=T4xyiJDzTOmdDRQfe/049Znuk5IxDbUVSWR5ABnQJUAJBgATITuxqDEBVB29wJWdhr
         YNUH/cQxdhPvSban8ri+qgu840Dt6t+bkgfgA7TIf5GM889lROZpjWUfEaNYLj3uS0Rc
         fAtUerEmQzVwlghQZbQC7UIS5TvOmVb9E0UVwkglz9ngyHDh32W3orFcuym/0ADZW5QU
         bgfKvYDcmbjrM0zXUaoVBWywpnNl2KQICm9JpTNJHirlkLWx+LkKNJkpfVQgYCPRa6Xb
         AhR1XMediDBOkmawUSUKd/rSnxTyaNBZ0E7Yg9GdSFflK+rX//bAHeY7eZmlMFAfIBGd
         nkEA==
X-Gm-Message-State: AOJu0YyFW+A8/HM9Gxnx/5Y8uNwxk0lKFHtIsNJsXEwoIDE1PLZb3KIy
	E0hOTeM9Ci0gVuubeQeyCrWjGhqHXciDXHb54kQ2KxYrDVGdXUJNm3gmmCnxVnI=
X-Google-Smtp-Source: AGHT+IHQpEmqcl3+MfJqzlN2xfDV2ReC+GloG7ttwfwYgSQ/VD+qNv5+NeO9cI0vSua7xbdwWeoz8Q==
X-Received: by 2002:a0d:fa44:0:b0:617:c578:332c with SMTP id 00721157ae682-62fb7ea5711mr46203987b3.4.1718290576579;
        Thu, 13 Jun 2024 07:56:16 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-63115aa15a8sm1965907b3.0.2024.06.13.07.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 07:56:16 -0700 (PDT)
Date: Thu, 13 Jun 2024 10:56:15 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: fix a deadlock with reclaim during
 logging/log replay
Message-ID: <20240613145615.GA694476@perftesting>
References: <cover.1718276261.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718276261.git.fdmanana@suse.com>

On Thu, Jun 13, 2024 at 12:05:24PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Fix a deadlock when opening an inode during inode logging and log replay
> due to a GFP_KERNEL allocation, reported by syzbot. The rest is just some
> trivial cleanups. Details in the change logs.
> 
> Filipe Manana (4):
>   btrfs: use NOFS context when getting inodes during logging and log replay
>   btrfs: remove super block argument from btrfs_iget()
>   btrfs: remove super block argument from btrfs_iget_path()
>   btrfs: remove super block argument from btrfs_iget_locked()
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

