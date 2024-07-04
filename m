Return-Path: <linux-btrfs+bounces-6197-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1829B927769
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 15:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6AE1C21806
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 13:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7854C1AED3A;
	Thu,  4 Jul 2024 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIYD2mAp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C81822E2;
	Thu,  4 Jul 2024 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720100844; cv=none; b=I5QJko6UdXL0mW2BPmxMtpLb4zr6YjP462oFZgbX+f+avcEkBBPF74sGyF0nnIJ+xMzcoOrVw84uy/moBdzSQFgl4GjNA6utDVUJFUWU49NOefcX1d9UJQkmNC6EKPQNcl3U5iEpA3wrU3XCfawmerawxn0jjZ0J+v4cC2wUIGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720100844; c=relaxed/simple;
	bh=UI3dF8OYMSUWU9X9suKWJKp7BkGBDJB8qJBGh0o1NCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2EbjMRQfBqG/Acictv8BkKgGMER85/PNQbdDAZ7dX4lkq0E9oF1a3iPLOXyauOApipFExGJKMRBXI5KGubIsw6Qgya/WtMpdOYvgkr9sHaIr78lD9K8f66L//nwNhcWsZk7hfP9348LiPPGe5W1xG7+2ma357Zzp40YigpoBTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIYD2mAp; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-64b5617ba47so6238197b3.3;
        Thu, 04 Jul 2024 06:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720100842; x=1720705642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UI3dF8OYMSUWU9X9suKWJKp7BkGBDJB8qJBGh0o1NCQ=;
        b=jIYD2mApLnki36+FRFCLpRPx1VHiiADPsjE4quJXRR2SDQPIza12/Hrp/A4t1bWIpN
         UEGRTAdnT3oO+SsB9eaKzEtCp16fIIK930POvSTJVTCrfnYytQ3rUroAbMURcuyz+lru
         g7GZSd0RziVPNYztI1iYh2RThuRv+4o10wppCMIQhj06SroO2mGsthhl6tawZZUBdVPW
         3xx+2U3dfOk+ERLvFJvgGZ8D+FVB3l+fI6LH1f78zxwthPKYdgqxiDThHo05u3UIZczd
         M31Dpzpq1IbKF9u4p5SDdTnpBf0fN4VCTtEW9qM10+GlOnuJ6UBZLXTRc22g5vna9SeY
         efOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720100842; x=1720705642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UI3dF8OYMSUWU9X9suKWJKp7BkGBDJB8qJBGh0o1NCQ=;
        b=fj6+T/rxdqJLaltx0v6u932HvWkN78HtN2K+GH9unqiCJE1nZdvjak+8ZW71JXWR6m
         VZWa/KbtgICYER60BgjibjjUgbSObhStjzOex7f2ZIJZ4+Gvi9IJBJZWWBbxp965kCA5
         dedU72hDswbLXE311arOZShVitfnl9XMhA0BFenq1gs6X6y0T/V6AGVrotdA0VN42/cI
         9vtXjbTVpGt0KUqK6QTdxiStbjE8KjCN3xxpBFVMVlciklzzDmscpFW6fQqMHTvMMfHx
         UFWcbXDTx6KF78JUkLrgqV+lwM8Yizf37eHh7BpdksKN8scs1Nb9RxbOL4qrBj7hoCuw
         X9zw==
X-Forwarded-Encrypted: i=1; AJvYcCXUxTLJibev4aH8gGJnFb2RpSeGVgemUqRe+oWUQO7i49pwYy5mhX95LP0TF4ilKySIMVMLdkVbXqAJHTq3KVl5251/c7NBSpSqd1U/RqrwEHd2ygYpaScg8CAb/eb+EFVNGjgaJiEjuLw=
X-Gm-Message-State: AOJu0YweFxB8X7AG/1NdQQg0BVMGPRm8tQsPz+YVB8gythBs9znP8oAg
	jQdrs9cAoFqzx6Nv0KQ0mw1RJhd8vlNXYXOhLexSLqOfpO4RSMohCMTt98O+cEfpLm3DsxMhjSU
	Pvq9IcS6Ax9dBPceBuNo3r6f+X4Y=
X-Google-Smtp-Source: AGHT+IH6YM6GLafKg9XBe0axWFXO3AhGkvxdQYhJOJum9ZzTHvtWe5dJcPzvzcyam1htB/hWj7nXRx0+wUWo96dItps=
X-Received: by 2002:a81:ab52:0:b0:62c:c65d:8d1c with SMTP id
 00721157ae682-652d8636094mr15666627b3.52.1720100842308; Thu, 04 Jul 2024
 06:47:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com>
 <CAL3q7H4yBx7EAwTWWRboK78nhCbzy1YnXGYVsazWs+VxNYDBmA@mail.gmail.com>
 <CABXGCsMWYaxZry+VDCgP=UM7c9do+JYSKdHAbCcx5=xEwXjE6Q@mail.gmail.com>
 <CAL3q7H7Xb9FQx-5PMQtK_-reMq-cbfysCx6s-ZOWL1FUPSm8sA@mail.gmail.com>
 <CABXGCsP9tSwgR4dN-k97maqHB1KOtykakmHNz78SYbAuHydUTQ@mail.gmail.com>
 <CAL3q7H6vG6PEKjcsXtSuq=yks_g-MczAz_-V96QSZCs9ezRZpg@mail.gmail.com>
 <CAL3q7H5RC6dinsA2KLtus07jxDuY1PecPXbhYOWtW+nVyzXwuA@mail.gmail.com>
 <CAL3q7H4MiarsqxSMc0OzY2TNRk8J7Lg+89MaPHY2+NPO-EcDgQ@mail.gmail.com>
 <CAK-xaQYYx6SPQaOVwL+ardB0y5LzYJw9a_hfWWtVEZ=y1rXq5w@mail.gmail.com>
 <CAL3q7H74jpSoMvvkSvmrtB_VGiscz8zN5aHnApWuYU+hpKe+rA@mail.gmail.com>
 <CAL3q7H6V9M0B4jmW79keUtTdjWsabyWZeU5g4KEN5_-a+wEHVQ@mail.gmail.com> <CAK-xaQZ=c7aociwZ5YQreTmT+sBLGdH0rkTKmFzt4i_mrXBmgg@mail.gmail.com>
In-Reply-To: <CAK-xaQZ=c7aociwZ5YQreTmT+sBLGdH0rkTKmFzt4i_mrXBmgg@mail.gmail.com>
From: Andrea Gelmini <andrea.gelmini@gmail.com>
Date: Thu, 4 Jul 2024 15:47:06 +0200
Message-ID: <CAK-xaQb2OrgNOKKXp8d_43kqMNyuHxS1V8jSDL6PdNZPTv79+g@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Filipe Manana <fdmanana@kernel.org>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"

Il giorno gio 4 lug 2024 alle ore 15:33 Andrea Gelmini
<andrea.gelmini@gmail.com> ha scritto:
> Well, I have the nighlty snapshot (well, it's not on every subvolume
> of the fs). I ran tar on that, and we see.

Well, using the laptop for daily work and running tar on snapshots,
recreate the issue.
I am collecting the htop output and bfptrace.

I send you everything when I collect enough data.

