Return-Path: <linux-btrfs+bounces-18373-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13482C1225C
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 01:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F6E19C177A
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 00:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A19176ADE;
	Tue, 28 Oct 2025 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxaaZHxe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6671531C8
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Oct 2025 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761610212; cv=none; b=gf+FupRJkXBJRdMkXMUGunsZ/lAiW1tDNK5BY6WqiePc4x1r0faGBdpzkbbWwVqNlTEYmZG1GRh+ujAQiPRzgPp7VX3eKrJ7GXYppn7BgbcHZdn/jx4dIbGBJ3o9s4BRtXcUqIXJxJr1yLpjQtFzI7M5nIwc6EqKM7IR6litnww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761610212; c=relaxed/simple;
	bh=gkU3kHClteexEwJVha+mekEyuBvMJVJAtdgB2babS5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ON3YZaBcoAd8w/nJNP+nClxkj9zhqKfzqLgj7wXkshJ2cScBgVWv0BaIHFrUCZY89HuFrr1zDPBu/e1P7mJgy++mNpFOPEaNwyS9cYBjw2fNfRHu1R+qnUADLCP31D9gxxtqs8pW1JTH5huNLYMkmgmY8GWubvC5Rna1EWSXO4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxaaZHxe; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b550a522a49so4415652a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Oct 2025 17:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761610207; x=1762215007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CTGohy2B7ZQJuFT8GOyysRTnqdBKTrqleBmozqj7fU0=;
        b=FxaaZHxelZV49zPWj3NYFgN1rq91w5gyqxq1OI3Gh03JKJRfX/SybCJpP9rS1B+6ET
         Ca8svy0IMCyyuF5puwGZTNpl5B1iFMeNf9RHLIK7WcfQEjZBW7Fg9LkWZtbcB2UuLDjB
         Cfn5WK/TByu6rSUXmck+XGjjLfe2rakZrw23OrfTXplt0R1WTDqtNVt4feMB3TVJ641o
         14e0lMYM8rPxrFRZchuwP7Gi9qrarLt3kdu53vTRmw5EKPHb8fxhYZOFss5U29/d4UAx
         /nZUQ/qKOapMqFR5FvuVVMYEpwGtk2HfLECsFrhjLzNKqo01uMPX0kiVAuY0/P3rLiWY
         0jRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761610207; x=1762215007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTGohy2B7ZQJuFT8GOyysRTnqdBKTrqleBmozqj7fU0=;
        b=ueoROzFJttBrml2tnoaY0rWSAI2SiyJIDxhER8BspW8LDLLtFF3WXFMwD3dNFPufA2
         7QLnX2wmWAiQKK7+s6kBLcUHWFoQKhrllstdAhc+AFQEass6dGxuDAq808PARJU0jJkD
         s0mOHgv8hQNJsmMQOPJ1gmYMSOyrmmF1SUcJ8sVsJ4uSXJUDWmarn61J3109Eqt+vhOl
         9WeceSyuIhTi2kkkrI9gWLpIvwGc1AFA6SkvZxh0xN0NmriGuSfzIB2eNfTAfmaeZa3N
         hXNPg14xHtJsHPXS8trvkiAuwTpeEE+0aC0lPWiTPahnP9JVIvdzWP7yy7kjlkmTQIhl
         HvpA==
X-Forwarded-Encrypted: i=1; AJvYcCV0cRFZ38jzlkztGyDoloIvf3QK4732pJKXuGhhLUORydQ1cg7urQeX/GFEycdxB1x+ol0xazXuwg2b8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YydQKisLk8xSq79xNSvsW8d8QZN9YDtreOu9ZMznKzyB8+XtA1U
	v7//GwshAK2VUGjiCiPr7n9C1oIWKz0+BGyHl8yMPmd6ZqWn7k/f2hYs
X-Gm-Gg: ASbGncuVLSEuuQa0bEIDhlrWbg6dUSO+dktD8n6cRkCZBbInN7mAdaw/wLoY8W16fkb
	yRgygoYzyafgWIz+ToIDkTI5Kw9BwLHGUGiTU8jwb+h5p9vgsHbNZM+da/8XDUfnpT6uNh6GnFZ
	Ql8jaZbMgnsi4pqneOkxU6FLwsg+x6UyrJzwdNnvuTWtQLr94L6xiHslPU7D0WC9O+uYHv4dVLP
	SkTzt5kHuODgPNxEGUBuD75pGCDaQaCduZwjQfZ9eeMBSkJf/7mxCdLFI05QWmJmZ9hCP8zRVQ7
	xbjuAg0zFISJi+JBbm2Q8VY7pf9wwu59YzE5f+9vsHBi3IlV4mO37MM8CbggoDNuvJq1fxsisII
	iZRWHxcvqSombFvpxZbgzSNe5cRMgDwuWLLmQOv2CZ5nzrp3Ka0mBIM+wPQ9VriHdG+69PACQD+
	+tBgqmx1fPZhx2bbaRvvegW+EC9/VnhoWGhmzEwoVGDxy8+pw=
X-Google-Smtp-Source: AGHT+IELo2lvqijrOfeBeCqC7ctRfZOwa0XT3BVcFP/NeXcmA+SQRcJAbb1Y30HcrF2TDCALENHnxg==
X-Received: by 2002:a17:902:e750:b0:26d:d860:3dae with SMTP id d9443c01a7336-294cb36c08cmr21818585ad.3.1761610206690;
        Mon, 27 Oct 2025 17:10:06 -0700 (PDT)
Received: from [192.168.50.87] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3b64sm97582155ad.3.2025.10.27.17.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 17:10:06 -0700 (PDT)
Message-ID: <dc376ee0-c2ea-43a6-a1d2-0d0fae395011@gmail.com>
Date: Tue, 28 Oct 2025 08:10:04 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs fragmentation
To: Ross Boylan <rossboylan@stanfordalumni.org>, linux-btrfs@vger.kernel.org
References: <CAK3NTRCBV0jTPrHb_tmWzdrLqx9xnvKpcqA7-_Cxm9TfJAGGSQ@mail.gmail.com>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <CAK3NTRCBV0jTPrHb_tmWzdrLqx9xnvKpcqA7-_Cxm9TfJAGGSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/10/25 06:40, Ross Boylan wrote:
> When recording over-the-air television the results are typically very
> fragmented when saved to btrfs, e.g., several thousand segments for
> 6GB.
> This occurred even on a large, nearly empty, filesystem of 5.5TB.
> Automatic defragmentation doesn't seem to make much difference,
> although manual defragmentation does.
> 
> I first noticed the fragmentation when I started getting messages that
> the writes were taking a long time, although I have not seen those
> recently.
> 
> It seems this application (the one recording the TV) may not be a good
> fit for btrfs.  The developers recommend xfs, but it would be nice to
> have the
> more flexible volume management of btrfs.
> 
> I'm curious if anyone here has any thoughts or advice on this.
> I'd appreciate cc on replies.
> 
> DETAILS
> New partition on Seagate Exos x18 (spinning disk).
> btrfs --version -> 5.10
> uname -a -> Linux barley 5.10.0-36-amd64 #1 SMP Debian 5.10.244-1
> (2025-09-29) x86_64 GNU/Linux
> under Debian 11/bullseye, (current stable release is 13.1, so a bit old)

  The kernel probably needs an update; it looks like it's still using 
space_cache=v1.

> The entire btrfs filesystem is based on a single partition: no RAID,
> no compression, no snapshots, no subvolumes.

  Most importantly, could you please try disabling CoW for sequential 
writes using -o nodatacow if that hasn't been done yet.


Thanks, Anand

> The recordings are done by mythtv 31.0, which I believe basically
> takes the video stream and dumps it to disk.  The developers say it
> writes "continuously".
> 
> I speculate that what is going on is that it is writing small chunks
> to disk and each chunk causes the entire underlying segment to be
> rewritten.
> However, I've noticed that even when I cp a complete file to btrfs it
> ends up pretty fragmented, albeit the target filesystem in that case
> was very full.
> 
> Thanks.
> Ross Boylan


