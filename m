Return-Path: <linux-btrfs+bounces-19035-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4B9C60C1B
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Nov 2025 23:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93883B8CAB
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Nov 2025 22:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4979F23AE66;
	Sat, 15 Nov 2025 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stanfordalumni.org header.i=@stanfordalumni.org header.b="jo6z7Ty5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8279E3594F
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Nov 2025 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763245847; cv=none; b=RJC4bMXd59LTij7ZUd4/Xnp0IablScY6ipP1YXYCNim5pgxlIc9triVIdsyAJvRKkjfWX6i7aOa0HiKIgM6i62BebSggy9j/xzQkajwi0+Zek9fiMcI/BK+I8/1wLHRjOcAIsPUEsB6Cgp1V8yy99fn2nT97krc5VSOrDOhQmcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763245847; c=relaxed/simple;
	bh=t4XiGsz9GYGPF/qgwjrA7/6vrD0ZS2Zv8cEumtlufx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCFmhMqWisM1y09DPG32k5P1n96jKa3esksxPCnAl4ffVAUOFQvc989ZGa2zCmJhZAPhhrOcq7uwnP0ZwYRAqpUr3C2H499CTtq9BOcbqE0tJ1NPvW0ILNLkFlGs5AtmpXIRVq2oXQ2XylDD2VAJdgN9hhy1vW93vkXpyY2ZfyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stanfordalumni.org; spf=pass smtp.mailfrom=alumni.stanford.edu; dkim=pass (1024-bit key) header.d=stanfordalumni.org header.i=@stanfordalumni.org header.b=jo6z7Ty5; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stanfordalumni.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alumni.stanford.edu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ee1b13a0a5so7941cf.2
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Nov 2025 14:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stanfordalumni.org; s=google; t=1763245844; x=1763850644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XujytQUrZ40RvC43EbRrUC1kYG7IcthtnnSfrMM6aZM=;
        b=jo6z7Ty55qQARYi7A4IQ3MgGE2ZD0a0x7jsf6BuNBDpfG8T1fGB2t0zcjGVLLqPdGk
         LVsTGahc6/37I2AYcqzR3qs1J7H+4WTGO+A5h2ryEkaZoWM23Zg6My6m4NQ3sjcDWupR
         FRmjULRMb4YtB3xnjQzdui/sV7YM8EIB3rMoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763245844; x=1763850644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XujytQUrZ40RvC43EbRrUC1kYG7IcthtnnSfrMM6aZM=;
        b=lCxcJFgFY/V+OiqVPyazOM2kX6Rrp3qeUz9hMrRHq3Xz+VefW/Uf7EaaMFQ5WLeoBH
         dEudQW4yd6vxR1E9pu22XQjycEl0PS+ZpcH0hhYZrsAxRcenw3smRuiZFm7HeJHVvvq0
         iKwZNtTM6xdt782cOgPYZBEpvLf/b5XyAiRIsQMpauUs0ZpTWqfewUKvZok3lobsRfVF
         kr3USIX5DOyohRnSVfl79ANExt0g0admvL6X+PcrPbuF5xfHWXC+ypwxnXtNjfGNI+NN
         x07LAMxKUIkfzH1BJGTlzxlpOEulMCvM89AgMUKHRCugZhsOPcG/vPOVVYJNUgii6DqM
         eONw==
X-Forwarded-Encrypted: i=1; AJvYcCXRErqKshaIIpg9FK+7jMSC18BvxXGyWqvBKbBXvYd+rIx3FLhzEOuagPkSqrNtI84z75Yv7RYiPF+gsg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/tCNVXFyg59CIQ4XgSQJVJD4MMLCLLVvWXTDN3ecFLlADB9KJ
	FlsD7vcelu33eSADTaSMb6mXq4tMx5s94wMScSxTqAKtETeY9B2y0/1hDMVWFEoeZHPAIBCFi1Q
	eWClScKbiCTuRXUWWk+WWvbLPFkVvXh+gEKdg0GTP
X-Gm-Gg: ASbGnctBIvDYwdJopor7iTGgvQDNLNT8qVkfEIQdXXxf0kMZq9bMrj7EFvj4yT2uNkx
	OzRzIjc7f5iWQCJrAqL6+367t9CfMIWjUNAbX8L9bFLg5+nM4eL9aLJ6q5MIo+s3sQEYK2zENj9
	NLqPZhKj9wqUoLKb8S9txOuIN6FJIfeQptLIWUtFgWBfAd0sTZXUl6RR0PI5jdWypmkZ2v0bujA
	IiKv6/gmYJFp7P54ISVFIKeAdWDjfxSo22FZwE6oT1IIS8/hVpMXI8UmR4y3iFYjg9b6g==
X-Google-Smtp-Source: AGHT+IENprePcWsemWeIXgHonDbBjqib+1bQlILAPTl2/dRe+tA10ABZ1bJnVdraKWWf4qVn4F1s/V4Az4mqt5P/rpI=
X-Received: by 2002:a05:622a:244:b0:4e8:85ae:5841 with SMTP id
 d75a77b69052e-4edf206a998mr82388451cf.5.1763245844240; Sat, 15 Nov 2025
 14:30:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3NTRCBV0jTPrHb_tmWzdrLqx9xnvKpcqA7-_Cxm9TfJAGGSQ@mail.gmail.com>
 <20251028001329.GA3148826@zen.localdomain> <CAK3NTRAhxaHU4Mh3vz9VWnonDS7dFjVvC0fnYhz0kH5Lrqorfg@mail.gmail.com>
 <875xbc5uk2.fsf@vps.thesusis.net>
In-Reply-To: <875xbc5uk2.fsf@vps.thesusis.net>
From: Ross Boylan <rossboylan@stanfordalumni.org>
Date: Sat, 15 Nov 2025 14:30:32 -0800
X-Gm-Features: AWmQ_bl5ky8lcpQd-Icqvu0wFBjxqHvNy4E5NcU8JcsFGKzhsV_IqTYgxn5YdmI
Message-ID: <CAK3NTRBdBkg-n5zu7DQhcLme+sJT5=+452haChcapKZLz3nmAw@mail.gmail.com>
Subject: Re: btrfs fragmentation
To: phill@thesusis.net, linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>, Ross Boylan <rossboylan@stanfordalumni.org>
Content-Type: text/plain; charset="UTF-8"

phill wrote
> I'm guessing the problem is from writing the file slowly.  Check
> /proc/sys/vm/dirty_writeback_centisecs.  It defaults to flushing dirty
> pages to disk after 5 seconds, wich may not be giving enough time to
> buffer up much data.

Thanks for your help.

/proc/sys/vm/dirty_writeback_centisecs does show  500.

I tried an experiment, shown at the bottom, which differed from the
previous one in 2 ways:
1. 80MB, 10x previous amount
2. 2 recordings going to the same partition at the same time.

Together, the 2 recordings are running about 7.5Mbit/s; neither one is
at as high a rate as the one that produced the big recordings I've
been focusing on.  For me, this is a pretty high load, and if the
writes are grabbing space as they go I would expect the multiple
streams of writes to produce fragmentation within streams.  For a real
server, though, I would expect things could get much more demanding.

The test did take a surprising amount of time, almost 2 minutes (1:49
more exactly) which is 22 5s intervals.
The result was less fragmented, 10 fragments, than either a naive view
based on time (22 5s intervals -> 22 fragments) or extrapolation
from the previous results (8MB with 3 fragments suggests 80MB would have 30).

Extrapolating the result for the 80GB file to a fairly typical 5.6GB
recording suggests 700 fragments, which is better than I usually
achieve.
Of course, the recordings do not use dd.

phill wrote
> I don't know if btrfs tries to reserve some space after a file to have
> room to continue to append to it without having to allocate space that
> isn't contiguous.

There might be 2 different issues here, within blocks and across blocks.
The first refers to whether the file system will fill in a single
extent all the way, or allocate multiple extents as it fills it.
The second issue is whether, as it writes to multiple blocks, they are
adjacent to each other.

A file of 5,600,000,000 bytes (5.6GB) needs 1,367,188 blocks of 4,096
bytes; since even the highly fragmented files are nowhere near that
many fragments, the filesystem is clearly managing to clump many of
them together.

Transcript:
root@barley:/usr/local/myth26/media26# date; time dd
if=10501_20251031045900.ts of=test.tst bs=8 count=10000000
Sat 15 Nov 2025 01:18:41 PM PST
10000000+0 records in
10000000+0 records out
80000000 bytes (80 MB, 76 MiB) copied, 109.449 s, 731 kB/s

real    1m49.452s
user    0m13.898s
sys    1m34.968s

root@barley:/usr/local/myth26/media26# compsize test.tst
Processed 1 file, 10 regular extents (10 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%       76M          76M          76M
none       100%       76M          76M          76M
root@barley:/usr/local/myth26/media26# filefrag !$
filefrag test.tst
test.tst: 9 extents found

Ross

