Return-Path: <linux-btrfs+bounces-11175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCC3A22A5D
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 10:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228901885E81
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 09:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB761A725C;
	Thu, 30 Jan 2025 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YxwGX0eu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E55215C0
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2025 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738229616; cv=none; b=utb23jzdAEVgLQNtlZcAr4UPXUCMP2iD8JH5Bqe+RDIqpuTPwDAHne4vKVubBDhy8SSIMtklqsd51WwF1MzLLXCQasYw3euKxNTOWRjFgDPJ1F08SngYmJv9YSIGYSTMyO6BGyOiBuz9VAt3ALUwIJrp9dyv90DD0rW9+HDJRKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738229616; c=relaxed/simple;
	bh=1qRPeWJwUk6jecZQ1Nqw+IItMRbgIk71h7Wtu9diJXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qy6UE3lxCli6OxGEQY6TZjxhBeJ5k/QlTeE8oSb/zJppargewMtZqlXo5OlOzpD9pISIDAxK04FG+n4flM9PelB8ozKhMsREBAjaw9LsdF+63SajMOhWt+zvFFP1I+Yl4TlTVm1dPXWpmwxQwfqhZiJbf0ZrguyUmw0fJE1C1Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YxwGX0eu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso113686966b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2025 01:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738229613; x=1738834413; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F9k/wWuFWC0oHLWmpXMLdDIuyNfRyphVbzDKs9dwH0E=;
        b=YxwGX0eu9HjMWqrtTE0YNbkwulzknUL2z8jej+4saqNW4aQchWlGkhuUxvF/zy43/j
         E1yPtBNld1F9MDn/ow8he0lSbfFT2uDvpIsnV+LjJxzM3qQ0cnr2Hwkm0FARxc0Bo5IW
         64NMNdSce+hReZcJuCjTfYBr3EYQpb92EY56oETs1KwPT5nPD+e+BHZn5GY2Nt5GspL0
         5pTm8NchbYxRIHYcDwdzG39nXcbuiNfPXArlaRaoDmmkRED+Ku9qPUB2MFoTdo+JbFpF
         8idRQ/e0EO5J9NHiwFbTCUFN1V+YSXZEkUDuFrrWSIsJ5CUeCtkZb3L0lTrZFFeR/hpy
         PHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738229613; x=1738834413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9k/wWuFWC0oHLWmpXMLdDIuyNfRyphVbzDKs9dwH0E=;
        b=TrXomdJknMu/6p5JRKbeAK/5SPHm/ditKVQ0+MveDFJeiFvGKjalxocJISYZ4fmuZA
         UGneqaGxC5qO2UPfjcHLeVP2byVOHka2fifz65VrqxX/3Na92wM52pQ8fMqyrJh678gx
         RcNPEFfGDYv0an92xOD2aZ5k4YoMrX+beJnNh84baelReohTGrQ7jsf/A1G3mTbloJLX
         MQC2JdqXCGErbCwI1dU16NnTbRXhONxKa2T/BFIrZ427afRnqHBkFuWKVuk10Ycxaezj
         Pu8somctgWunCls9MUW+OefeggJsFWYqFrYedkXFBsAjpfu24uY6+sFAT8VkjmbYrIFO
         kMwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH/VE2O7v5W3OcgEhIrh4QBBACc+0VxHeh/1imKXEuEwjlRnGNfy68Joz/X1CQmhgszNoXAFAlSNgAKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa30i6iTQlTsKlAK7CYBkvtskmoWWZTxYRFCxfhyRbUj3OJRma
	Pqgwqpe3YNvR4W63v9su41q4cZISGiVtWe7KR9Wbr+fIvLhxssSldGhuK9CIcOAVd6RjcialyIW
	Di8R0OL/Dv85fON2hkd8sIOzIHOxZCz7NcowShw==
X-Gm-Gg: ASbGncs04OPWVvWTob1H4jq61KWYb74xrhgKM+1Bakh5hNUPCrmtdhr2t8v9P2lpEpX
	RLb5Kt8ZvHnXT0pjEqz7mQZOtCIfLJxXf0n/TmenidVlDgo+FJjpLkDDk0qRB5mi/oI4IenE=
X-Google-Smtp-Source: AGHT+IFLid2+WkSj6gu0lJi8p/7/70xJkyZVifghUCgkxBo7ETqsM3r+bLCKK8Tr5GjCVEb2p1okzGL2E2nx5E81PMQ=
X-Received: by 2002:a17:907:6d0e:b0:aa6:ac9b:6822 with SMTP id
 a640c23a62f3a-ab6cfcb3a5dmr652262466b.12.1738229612883; Thu, 30 Jan 2025
 01:33:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
 <20250129140207.22718-1-joshi.k@samsung.com> <83b8c701-7719-4e90-b435-6398e132b921@libero.it>
In-Reply-To: <83b8c701-7719-4e90-b435-6398e132b921@libero.it>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 30 Jan 2025 10:33:22 +0100
X-Gm-Features: AWEUYZkybIerZJOKdDh3HY5vqE9uTDjGlhoRTLZknshJLSkWQTdvtODbWIPUCHU
Message-ID: <CAPjX3Fd3NXe-U5G3kW+TCfBYoguW9rCAtnNCRqN84dsimGR5iA@mail.gmail.com>
Subject: Re: [RFC 0/3] Btrfs checksum offload
To: kreijack@inwind.it
Cc: Kanchan Joshi <joshi.k@samsung.com>, josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, 
	axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jan 2025 at 20:04, Goffredo Baroncelli <kreijack@libero.it> wrote:
>
> On 29/01/2025 15.02, Kanchan Joshi wrote:
> > TL;DR first: this makes Btrfs chuck its checksum tree and leverage NVMe
> > SSD for data checksumming.
> >
> > Now, the longer version for why/how.
> >
> > End-to-end data protection (E2EDP)-capable drives require the transfer
> > of integrity metadata (PI).
> > This is currently handled by the block layer, without filesystem
> > involvement/awareness.
> > The block layer attaches the metadata buffer, generates the checksum
> > (and reftag) for write I/O, and verifies it during read I/O.
> >
> May be this is a stupid question, but if we can (will) avoid storing the checksum
> in the FS, which is the advantage of having a COW filesystem ?

I was wondering the same. My understanding is the checksums are there
primarily to protect against untrusted devices or data transfers over
the line. And now suddenly we're going to trust them? What's even the
point then?

Is there any other advantage of having these checksums that I may be missing?
Perhaps logic code bugs accidentally corrupting the data? Is the
stored payload even ever touched? That would not be wanted, right?
Or perhaps data mangled on the storage by an attacker?

> My understand is that a COW filesystem is needed mainly to synchronize
> csum and data. Am I wrong ?
>
> [...]
>
> BR
>
> --
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>

