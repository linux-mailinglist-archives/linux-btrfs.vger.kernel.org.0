Return-Path: <linux-btrfs+bounces-284-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD597F4886
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 15:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8392B21014
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 14:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DDA4C3A5;
	Wed, 22 Nov 2023 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="AMXn34xe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA033197
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 06:07:17 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5ac376d311aso71950237b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 06:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700662037; x=1701266837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8++4lViNma3RJHOIDGYVy8A20Z60l8vKvG63SA/z04k=;
        b=AMXn34xeGbdt27u5qPWx7MEZuBektce0fSlaX+PtjqDafs9eguqALTV+GVdG9ksek0
         6VFdQsjXolZkfIrcXgEjPrjJUU9gitnqsbJaLn6XkXmomerysW58DpJubBHULcvaMQUm
         PHqwoop3Aehjw1oMa9wnEQyhOUUENc5Jltmpjx1p5lI5nCAK/jj+4ivolvdzJSFxoqra
         jMXs5Xb1IIWvbFH1Jf3y7kRjtSzDnddjwduiPdjnTnKSE2/90LB9HeGC93lOA3jwOuKY
         K+6y5gS1JBLk4Xc/s8HecDogg5lyulFJWmd3UjJm4FhwwJy55AUtrInOOFsQ5gVmPtm5
         FzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662037; x=1701266837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8++4lViNma3RJHOIDGYVy8A20Z60l8vKvG63SA/z04k=;
        b=BzsK69maN6lw1hJBmwMVm8YGvhOUhwMdvLT1DIOEETKwOx1n8VIkiR+jvJKLBYJKeZ
         zo3iwUNPlodZzc4oM0Zy0oQluOhlJTebA+6ocbNA38TRruVg9XnimrFbVvUDZJzUPKt3
         2GYR19WSL6u/GzIIW1vs/ggi+UPinWd48DEkh5KuumhsMfJAU6hvenkDoGtNM3+ppHB/
         6CPusdn0IRNg2WX+HmCLFVeiB7p7fzTkyaM9O3dw8d6K3MFom2A7FTNV42qI/37kMirL
         xEK3Opp6RD3XMWBBS4kmDxofjq7WXwUzO1qQi2uFaYiHslyldwtb7uUhdPHJ3B1zkYAC
         +vhQ==
X-Gm-Message-State: AOJu0YwgzAstjsSHSlfKEwsLKAaAPF1F7NFvrumss6U05ofwpnlmGR9/
	6hLuSXwBjATj6nL0GTLeUpE9tw==
X-Google-Smtp-Source: AGHT+IG1Y2tl1j2y7t0PxPbcfrAcUD4ydsMVfe1KO1cC4y2RxUyxU8BbPYVfghOtc7+3tJn89DS7lQ==
X-Received: by 2002:a0d:ca90:0:b0:5ca:7a21:7e22 with SMTP id m138-20020a0dca90000000b005ca7a217e22mr2544381ywd.9.1700662036744;
        Wed, 22 Nov 2023 06:07:16 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u3-20020a81cf03000000b005cb7fccffe2sm1173392ywi.126.2023.11.22.06.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:07:16 -0800 (PST)
Date: Wed, 22 Nov 2023 09:07:15 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] tests/btrfs: add tests to the remount group
Message-ID: <20231122140715.GC1733890@perftesting>
References: <a8732c1d8994cced3560d4e35fd82c1b0ec4968d.1700643177.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8732c1d8994cced3560d4e35fd82c1b0ec4968d.1700643177.git.anand.jain@oracle.com>

On Wed, Nov 22, 2023 at 04:55:44PM +0800, Anand Jain wrote:
> Several test cases under tests/btrfs are missing from the remount
> group. This patch adds the test cases that use -o remount to the remount
> group.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

