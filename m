Return-Path: <linux-btrfs+bounces-18943-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5466C572AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 12:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25F7034EFEF
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 11:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D35933B979;
	Thu, 13 Nov 2025 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OkEq++gD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A852E0B68
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033088; cv=none; b=D2FcVm/+mH2tQCyUrsBepanBaC5/vh85Zg4z7TlSzFS4u6MhvYTCAOMTosmdpG8WlLjQ69Qv7EWzARjsUiS4+9wOIVQroGB98shC4CmCJnv3hociyH7VCY1nR6BNQV3uRKD+mdU9OTwOQa3X6DYJCTLfAajJeC0dERH0EKK8+64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033088; c=relaxed/simple;
	bh=PSPeh3wIcHSK2lCrRAT8IVLYiPh8UFuCtOYhIQ7zdLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WcNL65XY68DUVBGWJDNtjltVG4OtlnmwXtxeXjcYXRpbxk6KtA/OcB5SIhQ4RShre6gylA/Yz/IsLKDDHLopp6yG8Le4G8DO7rBdGSsvxAxJvntDVWoBQM9miEMjwm8bkxFfNQvm0Ia9r7NiI6B2ygrqXllOzoiUb1LWCyme+wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OkEq++gD; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so367503f8f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 03:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763033085; x=1763637885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ShGcGGjDK9hCzjBRmmgiQv/i+2mv2XlZVsZhuFOFv9s=;
        b=OkEq++gD8TwQIONHqhKqkYHXPP9CqnUl6/OVV4qpYXuz+yhdTBr4oA+f7SF4/MleQw
         /CJ/RvGxVkLHn0ZGa0IPW+CbhNNDWdDi80tJStoDI0M+3qEUoqVZ+Uw/SF8G/mciXeTN
         ob3UcxlVwVz67kB3rZVAEgvci7Mt/6dcEJNeciWIWuZReFARmwD/n2gOlR+YtTlWtOq9
         l+70HdN+fqACE7I8ndBOZiK2nWAoTkGnMhsHCELLi3e1bJalsZqLZoJ27NDBTs4Aq/Ta
         oMha3YEV7g8bqmLrdp05qSqdHdwWSwgpoJixPR7duav41/aNXvgeFxk66kLQ4tDrAtpz
         1YJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763033085; x=1763637885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShGcGGjDK9hCzjBRmmgiQv/i+2mv2XlZVsZhuFOFv9s=;
        b=fUHnGp9RV+cJo6GbwZwDliIwph3F28pxE0/5665KPXxuoaGzJhpfofhi/rDWpdNf+u
         Z9/RAPcRD4L7gn5iaAUpui8atkOlMgtfk8qer/K4GnoKhoyEp1xu71yLBol6jnSkH/e+
         elzODDo4aNM/bLx+iIl/xADBXqhIH3m9+FEYR6qVhs1uxm7HSyC/yPcTwI0eGqbGlFI9
         CuMUi1fLkMo37ZM6+kgz9F8kquxiLxOY0NyRlj8h8a/6cU5S0awgp54KPKA+yeWTbRE0
         8wAZK9/U1rKNeUM8N0H68K71UnRXb8ndkVWdKoigyoFvsjECBmzUx2YjrByDzh4oa4JR
         XS/g==
X-Forwarded-Encrypted: i=1; AJvYcCXFlskHqdzgDgXyw7zERmU3cb70RskyZ29n+n+nKlyjRAy6G8rxBqQPAM1x8fILtoBu6N/8poRyCbIn9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVQ5Zm/iDvk+7Jmi3F6sbtPSMPVcO93u2xptGRtzar5ZsMhIcy
	9PU3AiVyCSEPcyVJ/L2DOa0sAIKYUfxZs8+qmKjLjb15HKw/e098kXsElaNrvuQQIeAsmk1AjDF
	Vh2vlmYclJYfY9aa+d8CWfxBHVC1a6Vw4pBFFlHxqHQ==
X-Gm-Gg: ASbGncuklqL8A2CF85kyoc5iLiRYeMWAyH5l2pORaPtw2GOcpL1h7iDgc26Y+KGeXJz
	tACvTK1ZmWex5Wb5634EgQ6s9RK4iI8eS2kdS0oUhIMAiNspgMqwve2AQ95GwuZNYJZwjRyC3L3
	KpVpwD4Y+4AfOw9rYMLl725/5x8LkrTql+GmBszeFWAhc1RqbvyBAyCoOd2Mts7DQsz6yGHUCAN
	zmL1u/IfEWOqr9OIo6doWOZpuNCSI6kTYYIqqp2kgcPaFCIr9N6YIGmCFB54TRd9lFlmE4f5s4P
	+rkBZyHDpB+ugxpJmFtfvgNAdEd0ZNUrNHx/KccJIhFUgMGMQaxATPviVA==
X-Google-Smtp-Source: AGHT+IHtVYz4LqadYZlp+1/zWjmgNJwOOQpfT1yxfPxnbAKTCR7N/JuFC3EKr9Al+1qLKBr7Y1H+obuI4feFMMBooGU=
X-Received: by 2002:a05:6000:2509:b0:3fb:aca3:d5d9 with SMTP id
 ffacd0b85a97d-42b4bb8ed31mr5500146f8f.1.1763033084756; Thu, 13 Nov 2025
 03:24:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112193611.2536093-1-neelx@suse.com> <20251112193611.2536093-9-neelx@suse.com>
 <20251113103222.GL13846@twin.jikos.cz>
In-Reply-To: <20251113103222.GL13846@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 13 Nov 2025 12:24:33 +0100
X-Gm-Features: AWmQ_bnfQFUVW-y-RmFk3GZ2Vr1w_xjlhKecERK9P0qT8l38FW-u28yL9A5nmCo
Message-ID: <CAPjX3FcKLCB877RZr=NdGK62i01ufGJvfJzGQ-v2+i-kfzEnBg@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] btrfs: set the appropriate free space settings in reconfigure
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Nov 2025 at 11:32, David Sterba <dsterba@suse.cz> wrote:
> On Wed, Nov 12, 2025 at 08:36:08PM +0100, Daniel Vacek wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > btrfs/330 uncovered a problem where we were accidentally turning off the
> > free space tree when we do the transition from ro->rw.  This happens
> > because we don't update
>
> Missing text.

Hmm, this patch is new to v5. It doesn't even look encryption related.
I have no idea what Josef really means here.

The whole idea seems to be to call
btrfs_set_free_space_cache_settings() from btrfs_reconfigure() and to
update the ctx->mount_opt instead of fs_info->mount_opt while
remounting.

And btrfs/330 is not failing even with the full patchset applied
without this patch. I'm wondering if it is still needed after those
years?

