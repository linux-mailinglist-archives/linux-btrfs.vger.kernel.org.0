Return-Path: <linux-btrfs+bounces-2588-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67BC85BFC1
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 16:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FB97B20D03
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176DD762E6;
	Tue, 20 Feb 2024 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="3VTgjZ5z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E247602D
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Feb 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708442512; cv=none; b=DbACbtGnJOkM5K8KWVyxX2ByoaHWJPlGW1JF6Dtd3/YVabVsSc3H3m29RYwMgn6WgIL6KAvt5iAhXLX7iV66TzpFVJk3118V+iVRXVoBdd61+93Z0HJ3oKsmMx0W47sWHy4aqRWkY8sOvYRqn833Cc4sWVusCYeFXIwbZuBP3e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708442512; c=relaxed/simple;
	bh=VYxETW1balrgy7ypWTwY+Wlkm0B8+2bA0Y/Dh+JmAWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApfIXfvDfCyo7DCiySXx8SCOAtNRn+UM8cyR9FS6aOctZXvE+1Dm5FNBDYaQOuKzaodI0DO0E/xk8FoR/QI+Dh4t59Rjvpwd0rRxkISYY/NeriqD7uul1TZOTw4TVCk1g5IZ2oroWY643x6dFInr9uZkJXNeR76rIaCDh8026fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=3VTgjZ5z; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-607f94d0b7cso44794927b3.3
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Feb 2024 07:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1708442509; x=1709047309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gh9LM/O+eabBa1wtF0IrwrKudc8tsPO+XR6VFPcjt20=;
        b=3VTgjZ5zPf+cr7BepgEsjDYfOCzSAVifnVHbYsl0DcCuo3Ie5CIgxGXFK2C/oOGs/f
         3nqfV405iB3L+yHmOEw5KBY5o8QGGZhaxNTEXNK+SQE7r1RnKZCSEg0NbH7laooQV5WS
         D1TsW5VXeago+yw4M7LwOQSLp6IHS6BbC6UHohUulGILgdpY94YB3XD4asUIWN7EBu3E
         1zfHRfvUVeWfqio56YF3O116YCu5aRkjfFJAwYEtEWo1+LKG5NokE2TkWpWBzQKyNds7
         uVHZvOFYnSppbqEsjIXG+E95cDegqjcGVdPA0H/Abtj5BpxwtLt2YJDwa7QaKkTpGiOC
         rVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708442509; x=1709047309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gh9LM/O+eabBa1wtF0IrwrKudc8tsPO+XR6VFPcjt20=;
        b=hZDEWbS9EY8lulf8w1DcStMPnt6CQo2K1e/D0gN6Z1h4Rb+QPcSn0Tuk7lcuQ1Lt/p
         9zl0F4285Da1QCLwa5EjHEmrIDa0ewC+Hgjn/BNkb/L4C5bF0FTyhSvvoW2pAyRq1aXA
         dVzKeZSmP6CXD+eJyoxyWcfzaP13PXqrdGFiftADxH18uW+JCZVa5CCpd44SH48JrZiR
         mZtQ5dEIrB0A1N6HyFl+aaG4Bt4B2Zuy6LY4WKQGfZFV9rJckIL1HkDKJXoiEOfa+Lve
         9t5HA1aN8rX8XLkhs/+t5pHKCHIhLvy3Q1Qg9f6ZtGEoqyep6w82VgMP98lKD30wJQSC
         mjMg==
X-Gm-Message-State: AOJu0YxzuGTvo2EfcYQjbJ+DA1kYYFHpCywBer1aCtOO7VFt8J3g8tIV
	r9f0ql7NNTZ1p62UGu+YdWSK+ZxSgaz9Ts5aGaCxApFTI2u3DvdqWrH+s2mxIQ4=
X-Google-Smtp-Source: AGHT+IGPbiZF3tyNr1wL3RPtjUJu0zzaNEwRc0cSO9xBvTbcil6XPXqsJ7BhRMFNdm39F4fEC3NVDA==
X-Received: by 2002:a81:a193:0:b0:608:3797:5ac8 with SMTP id y141-20020a81a193000000b0060837975ac8mr6069460ywg.32.1708442508998;
        Tue, 20 Feb 2024 07:21:48 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id k124-20020a0dfa82000000b005ffff40c58csm2167680ywf.125.2024.02.20.07.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:21:48 -0800 (PST)
Date: Tue, 20 Feb 2024 10:21:47 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: some optimizations for send
Message-ID: <20240220152147.GA1021473@perftesting>
References: <cover.1708260967.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708260967.git.fdmanana@suse.com>

On Mon, Feb 19, 2024 at 11:59:29AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following are two optimizations for send, one to avoid sending
> unnecessary holes (writes full of zeros), which can waste a lot of space
> at the receiver and increase stream size for cases where sparse files are
> used, such as images of thin provisioned filesystems for example as
> recently reported by a user. The second is just a small optimization to
> avoid repeating a btree search. More details in the respective change logs.
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

