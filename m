Return-Path: <linux-btrfs+bounces-11764-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAB7A43DCA
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 12:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899A4189D935
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 11:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146514C80;
	Tue, 25 Feb 2025 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MtO4YEGc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3175C78F5F
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483493; cv=none; b=LWurmrb3Rk+R2fdT76JYRsfL4be2R8YJpe9Wx92fKJmzOULP80oQPN1IRi7uuFecTDKaVmx5klAEys/7NVuEo/MpsZzETVDCtf8cP9PVpZ2f25dYnx6LnuEEYUGkG9cIiXN85Gh6omzuOBuuToaNicZlOs2/2OmLMbykc3Xut8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483493; c=relaxed/simple;
	bh=obOBJ7bbiCdGNUQnNnbBzW6UnvHfkNWBV6csAyao88k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyTO0G+I+eHpFgKWW28cCAr5detF5wab5Kv8D3uDjgzcz9tU+RxEAJ+4dEad2uXiQ+efHkFOX5r3+m87J88aiMjrlf/apVbq9eEpkszFD90CUs4CwkafF5ya3LgLXMGEv9TREqIakOYpic/um+jHnscn6Tc+PPSds+0CRlzo2j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MtO4YEGc; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb7f539c35so1064568766b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 03:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740483489; x=1741088289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fgtNfMFmLVn76sRRrF7KTmL1MMQs+Bz3boAWwC1uDY8=;
        b=MtO4YEGc/NZJ2NdlVr9xy+2pyk2bfwv2qkRD20rG4Y4i9PK9c7cNFLV2kiA374pGLz
         1LF6j1VAwPliLw7SOZ/vi3KaWnvEON8jVILoUBXbPf/YzVE0O73SD6TctrlC5uMG3qCX
         IkHTuHK+xGOtg2n/y4FA5LZ6FvndUtVvV60byZVhrXjGFoDKY0xCFRwsRQIZSDeJfgfj
         6IXL61RcZscQE5qZcXyqZekhkyxFbhYpV2Gno0bKgnZknR+mSKtLgW/smuPTiuKG9+yM
         pvOSLsRDOTheGfhiiP5IuHli80sWgOtEqmFbaRZl+67iVFedVygoB2Avq1/vhywjRegd
         mr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740483489; x=1741088289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgtNfMFmLVn76sRRrF7KTmL1MMQs+Bz3boAWwC1uDY8=;
        b=FunFqY5nxRjmh9OaB1tH5aX0rmd3RKarSc7VOVpivlky9l3ssBdT1JQjYV53WM41i3
         jhxEkhQ993evRfFKtNVo5m6jj+IJtQTWCb3w+TKEzGEeyk4sxJrBYAhwS2u1Bm2+t4WL
         1VGrOK82wV0dX9Xe02svXjZ+xIQxO2jsysTXa6O35LDOXp0LApQMy60bMh+k/UQ92Y5O
         YYE7i5T2cJarcmYAAjesUlD7kxP6Y5Z/OtGmH//mmnmwZO3bNHg7feJb8417j9DkAwyV
         fHM+DSBcQdCFdSEmfvJ7NeNZzMIlY0IYQE5sekdzFcRVfIq2H1ZdJHDa0xR8jm4TVLvH
         j+4g==
X-Gm-Message-State: AOJu0YyV/zM8oE47Gi6w4bSJc5WOxjWBsDILsFo2OErVt1VMbzeINDQ2
	eJcWg7sN0bkO6eXa4YRhEeQl2k2LoOcGKfcJrkEKt2auA7Pj6RHTQV07CBOv4bf+F/LRWVd9/qL
	AB2hjODLk3G5sFVnp6Km5ldcdv2EPdjg4uDCE7rL0mo79ZW+T
X-Gm-Gg: ASbGncvRfCWwByVWa4+2WMcpErnFWLRNS/6CIReok4TIde2snvUE4vTbQ1lraTnN3hH
	RdvbbPIiEU+z/yBXWPuW1f0CZdT28KiZlAmddTS3Az18ATWh0gk0VOnAW6YLE0ULZ3noxfkgCgi
	2JyTGfEQ==
X-Google-Smtp-Source: AGHT+IHB6UlktQnR8Gi2LXjs9SIR3LffzBz1uUEtiqhu++Unsl9yyzDnNEo553kmcEB/RjMBhv0n78KYCqOOSTrCnOA=
X-Received: by 2002:a17:907:720a:b0:ab3:2b85:5d5 with SMTP id
 a640c23a62f3a-abed10700damr328027766b.49.1740483489498; Tue, 25 Feb 2025
 03:38:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740427964.git.fdmanana@suse.com>
In-Reply-To: <cover.1740427964.git.fdmanana@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 25 Feb 2025 12:37:57 +0100
X-Gm-Features: AWEUYZmKc9R2h0gIHZ9q-WUJEL5c1jqac-ism9JsZ7R_DqNXTu26p14ZaWb3CjI
Message-ID: <CAPjX3Fef=7GQxKc1oke5az043i9oea7ryH5W2hfCrKhtKfWCvQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] btrfs: some fixes around automatic block group reclaim
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 11:58, <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> Fix a couple races that should be mostly harmless but trigger KCSAN warnings
> and fix the accounting of reclaimed bytes. More details in the change logs.
>
> Filipe Manana (3):
>   btrfs: get zone unusable bytes while holding lock at btrfs_reclaim_bgs_work()
>   btrfs: get used bytes while holding lock at btrfs_reclaim_bgs_work()
>   btrfs: fix reclaimed bytes accounting after automatic block group reclaim

I'd say 2 and 3 would better be folded into one patch. The split is a
bit confusing.

>
>  fs/btrfs/block-group.c | 55 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 42 insertions(+), 13 deletions(-)
>
> --
> 2.45.2
>
>

