Return-Path: <linux-btrfs+bounces-18133-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52C3BF9121
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 00:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C1A3BEF65
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 22:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730542BE03D;
	Tue, 21 Oct 2025 22:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQgmgnzf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFC92877FC
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761086410; cv=none; b=sMYIYCs8vhDTTiycrXSfe9mVW+nD8EgvpRwt6HVWPCVwFczseMa4YvX3QblN59sNZXriA30TTfXaphtX/Nhu2Fr7wckRmvtyRdCwgwGtrmoTcK4zcYTXdJxcxd9oH+fMNjX/pff1ODzlaXYxYXRGZvMev/pnRIWyZMQigbXEDIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761086410; c=relaxed/simple;
	bh=BQIRCKkRmMDTyKu4G+C+rXgOyvC7ZnozbOB4Mt5HFnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVzFDlPalemrmpo/blhCHDHY4Z2CypKwa+f0jYXctSNNPwy6ycZ5ZQ0fHOBa+AG8oSo5PRg8nR/BdjZVxtyTG3JLvTgavFRkxTLhCDzkPasPwLtU0IcS48Gmv5Ab2F/VZ8ltKhy0hT+1Z/I1xrSEOUxZxLJqtElBMQpjaVu5VHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQgmgnzf; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7836853a0d6so7910697b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 15:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761086408; x=1761691208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyrBy3TR3Upr8cOvAAOrpla5/1r2k/BxHHXGuc/dI3M=;
        b=LQgmgnzfEetU4gDVqlxzVomfDUNVxribeBr72I7k7xezN+VDeLGh1JEATPBMIzsYmk
         dII7hqEi4i5LIyjj35HRs2EAG9lVInQTbtyJSBoL6eyonC0CydBVyIMen5ucsWorKX3U
         ZGTlfE8Ah9+ZawaH5gDlRlgW5Y8tk8FSbxrmGIcZyQ9a+jd3xxmnVdz4pM9qQQkWmazN
         QUo+/JBbMVmTIgqatSobx5vWV9aJOuzvY0lvspWK0ZoI0Op9+EHCtb8gTPppbfK3v665
         QCTBymP/3fpQPDvBkhyoiBWemgk9vviI5cKTLB5/blOyJqAFPLuRV34tE2BAheMJtwjm
         KgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761086408; x=1761691208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyrBy3TR3Upr8cOvAAOrpla5/1r2k/BxHHXGuc/dI3M=;
        b=KStnYG4RFBy1g1HTktMqAq2/HS+adUegD7rx0M+jn/yXMQPuQSODOlvGMry3h+SUrl
         dLwlwHZwOPdJ9y14Iv2kRvoZuWDtwlYzYQedt5/LWStwqYqoyT3AwECZcl4Avcph/HVx
         ScrofGgqv7xOKXJqk3EWnnyx5IRmE0xg9YHYq4Lzip+1ZnoPuM28tf3/3WJoj1b+MHFW
         tdJ7KUi0KVQv4b2EAcOb6HyZ9vLN/OYZkXrV3J/a2/XuEY9+uxRHNZVCo9DEDvTdDVEV
         ehw8NMnY4aF4BA/xmnOR7ITJ57rrHVqpaumo7nWE7bjCw4aZS/SZmeh+XLh6x33WjhS5
         89Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVoqyN0dgx40MWaF4d97gl+8wOTWCDVznnBEzGDE4QHObOAmFdt9gQ6KWqGWRJV/qFz22qjAZsproVVbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyC8Njo85iJxf29CMNWUUI6FkGgJbN4AUqRtVyWVDvtTncQrkd7
	Zg57mRpaBE++oTk3xd0nZ3DO0TebMIvqQIHtHt9v375INs0vJD6y3jU2CQvuD4w9
X-Gm-Gg: ASbGnctlqmv5IPKHF11SC4yw8GT/kLB3Jhww17/8Z3zeyS/yjTOdTehcYVCb2ykYVNB
	C0dOzNHbYtS39On/z7NLhpyLeqtNAqpseDTUd/Kveq/U48SFr1z03JjRijX2Ln2jlLl3ssUL4Qu
	iCYp+hBnkdwyUfw4BACcVWdF7lterjXsEGTRMJa+SIFNzesmEP9C4NbxQou7IrEOvvkxLnk60DD
	h+07ZrquDInkUeXktK3zuRMlcLifNPtEu6oMeQwzVg1XKxB3YBmMw1WJu+fDydCwoony/G3Msxa
	oL42P7Tw62Dj3E6d1q/zHyL67nLTaiu6xeiJxUB4+M2Ol0BPpqXyPYnef0WQfpbcNrHDUnyC4mN
	Mb7Uivo3016NJHFXgfYxG8OGpQWUhu+MVIpVi7ILM5N2+Di5Nd597sNRrb73cVu0xInH1H+dV/3
	o9rPi34PfHuf7cRwqZ
X-Google-Smtp-Source: AGHT+IF51HK8eGsqC39pQGI6tuoHCzd7R2+z0aN0iZNr5/5fM6LJjkbaJ93pog4Y9/bA5FC1gyrT6A==
X-Received: by 2002:a53:ccce:0:b0:63e:1e1b:d6fa with SMTP id 956f58d0204a3-63f2832659fmr869256d50.30.1761086408024;
        Tue, 21 Oct 2025 15:40:08 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-784674f2681sm32351537b3.47.2025.10.21.15.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 15:40:07 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: "Chris Murphy" <lists@colorremedies.com>
Cc: "Boris Burkov" <boris@bur.io>,
	kernel-team@fb.com,
	"Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: make periodic dynamic reclaim the default for data
Date: Tue, 21 Oct 2025 15:39:56 -0700
Message-ID: <20251021224005.1087028-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <4c595af2-f06e-4957-9f08-67a78609901c@app.fastmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 Oct 2025 14:52:31 -0400 "Chris Murphy" <lists@colorremedies.com> wrote:

> >Tue, 15 Jul 2025 11:58:24 -0700
> https://lore.kernel.org/linux-btrfs/52b863849f0dd63b3d25a29c8a830a09c748d86b.1752605888.git.boris@bur.io/
> 
> Fedora is interested in this enhancement. Any idea when it could be merged or if there are any outstanding concerns?
> 
> In particular, I like the lack of knobs. It's either on or off. And it has no effect until unallocated space drops below 10G means it's super lightweight, affecting only users likely to end up in related corner cases.
> 
> Fedora isn't installing btrfsmaintenance by default. We do see infrequent cases of premature or misallocation out of space. It would be nice to have this "it does nothing until" type solution enabled by default, if it's ready.
> 
> Thanks,
> 
> --
> Chris Murphy

Wanted to provide some data from the Meta rollout to give more context on the
decision to enable dynamic+periodic reclaim by default for data. All the before
numbers are with bg_reclaim_threshold set to 30.

Enabling dynamic+periodic reclaim for data block groups dramatically decreases
number of reclaims per host, going from 150/day to just 5/day (p99), and from
6/day to 0/day (p50). The trade-offs are increases in fragmentation, and a
slight uptick in enospcs.

I currently don't have direct fragmentation metrics, though that is a
work in progress, but I'm tracking FP as a proxy for fragmentation.

FP = (allocated - used) / allocated
So if there are 100G allocated for data and 80G are used, FP = (100 - 80) / 100 = 20%.

FP has increased from 30% to 45% (p99), and from 5% to 7% (p50).
Enospc rates have gone from around 0.5/day to 1/day per 100k hosts.
This is a doubling in rate, but still a very small absolute number
of enospcs. The unallocated space on disk decreases by ~15G (p99)
and ~5G (p50) after rollout.

Though fragmentation increases and unallocated space decreases the
very small increase in enospcs suggests that this is a worthwhile
tradeoff.

One concern I still have is that replacing the aggressive
bg_reclaim_threshold for the conservative dynamic+periodic reclaim
will lead filesystems to slowly trend toward an "unhealthy" state of
high fragmentation and dynamic+periodic reclaim will only do enough
to keep the filesystem alive, but not enough to make it "healthy" again.
So far, the data indicates these concerns are unfounded as
FP and unallocated space seem to stabilize after their initial changes,
but I'll follow up if anything changes.

That being said I don't think bg_reclaim_threshold is enabled by default,
and I am comfortable saying dynamic+periodic reclaim is better than no
automatic reclaim!

Thanks,
Leo Martins.

