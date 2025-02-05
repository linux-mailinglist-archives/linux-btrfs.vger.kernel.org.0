Return-Path: <linux-btrfs+bounces-11305-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8B9A29BC6
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 22:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE820163F20
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 21:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057C6214A99;
	Wed,  5 Feb 2025 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="DMS1dzGE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B346F2144A5
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738790389; cv=none; b=lexJcoeFeLvcaiViP9PkX0yVx+AeZnUvsIXyccW4u3N2Az4+yfi+E16BFiB/RjRhxn4QZatKveSnc8WEjXjfz1uKjm1lD/QD4lghkaiH5FC9xvqNBEVHEaibK5SBkGPcLn9lGegn7L3cf5wp8MoOE8Bt7cmBwtySyOYrCGVyJg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738790389; c=relaxed/simple;
	bh=P1ZpNDU8csXSCjRXyIThDMc2wgU5d0Wr/CkZdrCAw80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjnLw3rzMM1KTiAVhlfyMKc/kUidX7MDsK6QiU5wNjCgUUYg27q8mmD3r0vOUtMWdyq9dFQBzNyke7ouQ/9r+lZAh5XokdUiTg+bBmCJcE0a7SiE7fPOsoxOQ3z93zhpGVL1DAS6C4KbbULYR3hikR7VIeiuhF5+sKYVibxM0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=DMS1dzGE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f05693a27so3733375ad.2
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Feb 2025 13:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738790387; x=1739395187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g/pVDuWjBwETpqMInJTuTHe9Fe51snjk7jG37C1nIjk=;
        b=DMS1dzGEvN/wZZvzsThIMpXC1JLhg7Y5fCM75/XmXKF7g3dcB+Zjot0joDaApB5j8G
         3xNU/kCwZIcUOdZjYfw7gJ9Hlno9+KlLg6pDuHMkRVbNEjYOhuLtZkCBD0VmMWzRbRkM
         RYeCCFJuuEPn+BeGjR6PNLkAttiGj2aF15tE3BLHYRxfycqivOZqpqO+yNXQHK8SdHc0
         rriS9Rz5lBaQf13nFnSdD88VMYEFNtCgcnxMooTtFXmqOUtax81edHVBnCXksdBAv7a+
         lfV9mg1VfF7X0B77ZsMwRCEhJZbr4YopBsOhx8E1IsUFateQpphD/h80Vd4wPgDFDMS9
         RFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738790387; x=1739395187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/pVDuWjBwETpqMInJTuTHe9Fe51snjk7jG37C1nIjk=;
        b=MkOkZjMo6XXMYxdrMa3K1ov/cEe+KAjPctVDJtQMaLcfPMaMaKFqq1X4/7zi5HRxPY
         GoMayUXthYSsTkimFqpEQWLzL9OZb2YlSv5E35pCArUfVGiNk22r/njew/yKLWY6QgU2
         +T2XjysGQ1usYT7eqSg1tyjxhKb06BBWTGOK4R0f8iWfm81lRFaP1v5pSGhXDMxDx2w4
         pY8X56InxnPEXjEHJPk0VpD/Pkzqd8R3squqC+cirfKicLgzdVkaRl9t4NGbhAEjzSUE
         hP0oXPieYH4+gfQCdDczwhpQ8QnzgSFaafRoAGQdgG2FFbkBC6qHqSO3UpZLYCo/pSXk
         OXaw==
X-Forwarded-Encrypted: i=1; AJvYcCVK1tpb++PHqQ0xF6ZQWC82/HumKFxuwzM3BHV3Zp9VcoKbDfu3ID48TvxHEpOXIBH6YaVWJ+Qhxg1VkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyL9vDO2WD+Lll8PfZEdkU+JFMyPb8fI8dVa7LopWRZNDHjwr4g
	WCJGa9+SVpzhbl5+32ymRS+nNNZwjkxHBBgY7NjFNhMh8ElV9OtjlwbQO+8zcz4=
X-Gm-Gg: ASbGncv/RbOHrmy/ubvQWJijkdhEuMunle13humj2HHH58/pxnckiV5SbFrVKQrvmvh
	631zjlwm3Zri13QIbKuB2737lrNVS+uuo3we/wJpzn9GWkB71ohNKxrLcl6TlUB7s+ZxpcbaObP
	L8CDHHiTwgQsvxM6h76fvY8IlTGu5LhYWedJgbSICgeVeKS0/8yw/4A9NggrZzaCNIpSK76R2lN
	JfWFoPqOwMagX6MCf0zbVpN4SzcdZMlvKY0RKXRlxj9DfbEEsq+IniRieQi1XQI4jGdUQY1GAh6
	dieSQBpLMjeo1Yt/0OYrpIT2me9o+BwERWqyUWPl8ASIgwL0E97GeK17
X-Google-Smtp-Source: AGHT+IHKr/jk+gmRxkD9y+arz/7q0dCEgcTTIYJ0tkdvep+6xV2PLpXlXYBeRMgW3wQGQGheTrdPZA==
X-Received: by 2002:a17:902:cf12:b0:21f:134f:22ad with SMTP id d9443c01a7336-21f17eba99cmr79494745ad.38.1738790386889;
        Wed, 05 Feb 2025 13:19:46 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32eba6fsm118599565ad.107.2025.02.05.13.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:19:46 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfmoB-0000000F5vT-3NJW;
	Thu, 06 Feb 2025 08:19:43 +1100
Date: Thu, 6 Feb 2025 08:19:43 +1100
From: Dave Chinner <david@fromorbit.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/5] fstests: common/rc: add sysfs argument
 verification helpers
Message-ID: <Z6PV7_WKzNJvbUCm@dread.disaster.area>
References: <cover.1738752716.git.anand.jain@oracle.com>
 <f11ddafa2622d364b099b68ffbe4aaf4100e6042.1738752716.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f11ddafa2622d364b099b68ffbe4aaf4100e6042.1738752716.git.anand.jain@oracle.com>

On Wed, Feb 05, 2025 at 07:06:38PM +0800, Anand Jain wrote:
> Introduce `verify_sysfs_syntax()` and `_require_fs_sysfs_attr_policy()` to verify
> whether a sysfs attribute rejects invalid input arguments during writes.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/rc | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 136 insertions(+)

Can we move all this sysfs specific stuff to a new common/sysfs
file? common/rc is already too large and there's more than enough
sysfs specific code here to justify it's own file...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

