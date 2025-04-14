Return-Path: <linux-btrfs+bounces-12997-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C732FA8894C
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 19:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15DC178BE8
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 17:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FC0288C96;
	Mon, 14 Apr 2025 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJOJ5jhW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3EF1A29A
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650252; cv=none; b=CJd0zBtdsnKgXNdj+UkiG010gZlz4ACaejbgefJGyUlyxoTbIC8dxAGR2bvdJWTd9dDpeCpPUp/cvldp3qYeM8Gl8gKIDaLFoqUufLU1wcOKasgs/te/DFm0XTxBPwUaCpYhRrCK9g5HJkzYHN079Cnmer3b0ZqzRTLm1FQUlNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650252; c=relaxed/simple;
	bh=q5E37hsCi2w95y8ZyJvsMpoYdkMgGZ6/GnKBXsNWQ9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NfFJ+Zye/elX0A/RwCjfEs+zuovCGQe0heOI3lYCQ+Q5Ub1C911mq8uIkOeEAUk/04epklxfYfrS+yJRfKo+lCmU7aaAXUZvwhOZpfb6sDpLcxyFg3ITJtH04tRWU2Ue5sqGDjv1WjwPtK9vrDZft4C/4uVhILvmwBbKTnFEPg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJOJ5jhW; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so41553001fa.2
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744650249; x=1745255049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z8s0F1aVXr3hCGp9gCiAw+O68kk0LcpDR5KWXbzRqFg=;
        b=XJOJ5jhWQqMsxcOtRO6X3Si7onLqNd8wm28TjE7/n5eSIR/UjzP0Hqr6FMcu/sEmM/
         fitUhq10CiRww6qnb2p7Kl1YShzur058pcV68xnyURagJXz0xdvr1Q7UA+Byan6ueXNu
         xKy3BjZN2GMjcO/A52lSe5+t46YvGRK5qllTq2+Vhsh012rAHrPJ5kGH/TpnT0M0qsNS
         VBlzPvxO6EZ+JOX0a1ItFKXY9zFNVHk+JPevhkyTuTnKHzwENJxgbrxH0WVjhgN/5fVs
         u5vdwxApXa9MeVIiWQI7GRaAn5s2vPCcgPmzAekHtBruFCwCUmW7KQTtvBeUbG4eoqrG
         smrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744650249; x=1745255049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8s0F1aVXr3hCGp9gCiAw+O68kk0LcpDR5KWXbzRqFg=;
        b=tuehZId+i2ZBwBPNAlAKiJrGjPvxy+te9Acnr7YX+AhZZcOeIzdb71AoB+Vvc3zkJR
         mMwt2w9ic+8HaB4xmYzugWeV4LlAW2sNE9zoECQc0SZ/jD4HQXj+g0TYsu3hX+rSJSjU
         KXgICJJdZW34Np/NHre2LX0IWrtoBXeh3rVuKt+qZtmCxIC7FHpYoQqQLECaNu7A/tjo
         MyKNlFxkk6y7mT7lFoZqBypp2BpscpxOwtucC+VawnJ9QxBE5UMvPDa/ChRAj0f+NQIx
         oRJbGsV+8f5GWqT/AxE+6c5fnx1rUrdG+gWStbJnc8vnHe3UopmA0M+31enGhSRTTr5J
         Q95w==
X-Forwarded-Encrypted: i=1; AJvYcCVzZeCxP98txmguuGnUmdf3MAW0T9rAaCXOFCU+AzcS/L2qKDFsPiJlluqmyB8y/yX/YLciTeQUNf6PuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaQCIwj00HE5PJPvJ1bZ6+jGXV4fHtAukyMZZNRV+gy143M3pT
	V9rkuIbpHPsml7GvNZwzZbipgVK+YNMA3/LXumUbG/xHjE5/rt2zQIaUSw==
X-Gm-Gg: ASbGncs57mqaG8StheiY61CmnKx4b28PKaPrXHd+ToknjYktL8pPQupkctFPpF9DnjJ
	ivgwEAMCOwH5AqYmNYB+dgVR12NRoc2jb9o04cmaMJxw4ishtmF/GA7DTB/K1lrSa78XkO/8NdT
	WeqhksDSnlq1BMp11aYLfkZLWmAFWdaBzsDsZ0Y20z1KcCrnqWbDQ/cITejHX5bKThgC3d0H8e4
	fQjoy3YrOluxfPX5YOewt0ESbEPXq4VmUbdMt94Y9W2ibQvPjuu19PNTboVya7JzBci2qndsm55
	GBVImhdp4ZDv244DiAxcedvAb8ipK/Enz9++fgLsSa78AIIdj7CDpa9EQsJ6GKL9WP6B1csWsLq
	bgvtAHCLEvhx68cAvO+C3ww==
X-Google-Smtp-Source: AGHT+IEn4qUNv3nsHei8oKJWEnH94mFTnpietj164kenlUSbslK1ApFk7U9uDFri2ItG0vzmXxGLyg==
X-Received: by 2002:a2e:a813:0:b0:30c:7fe:9c70 with SMTP id 38308e7fff4ca-310499fb02bmr39080711fa.15.1744650248682;
        Mon, 14 Apr 2025 10:04:08 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:5524:1cff:ae8:cb7b:eb2c? ([2a00:1370:8180:5524:1cff:ae8:cb7b:eb2c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f465d48adsm17891041fa.74.2025.04.14.10.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 10:04:07 -0700 (PDT)
Message-ID: <5e154a2d-819f-4efb-b29b-b57a63371a18@gmail.com>
Date: Mon, 14 Apr 2025 20:04:06 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Odd snapshot subvolume
To: "Brian J. Murrell" <brian@interlinx.bc.ca>, linux-btrfs@vger.kernel.org
References: <dea3861ab4b85f2dffc5bbc9864b290f03c430f4.camel@interlinx.bc.ca>
Content-Language: en-US, ru-RU
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <dea3861ab4b85f2dffc5bbc9864b290f03c430f4.camel@interlinx.bc.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

14.04.2025 17:34, Brian J. Murrell wrote:
> On my Fedora system I have the following:
> 
> $ sudo btrfs subvolume show /
> fedora_root
> 	Name: 			fedora_root
> 	UUID: 			c08a988c-ddd5-164e-b01e-51ac26bf018b
> 	Parent UUID: 		-
> 	Received UUID: 		-
> 	Creation time: 		2021-08-10 18:30:03 -0400
> 	Subvolume ID: 		258
> 	Generation: 		5029586
> 	Gen at creation: 	10
> 	Parent ID: 		5
> 	Top level ID: 		5
> 	Flags: 			-
> 	Send transid: 		0
> 	Send time: 		2021-08-10 18:30:03 -0400
> 	Receive transid: 	0
> 	Receive time: 		-
> 	Snapshot(s):
> 				fedora_root/previous-releases/f38_root
> 				fedora_root/previous-releases/f39_root
> 				fedora_root/previous-releases/f40_root.old
> 				fedora_root/previous-releases/f41_root
> 				previous-releases/f33_root
> 	Quota group:		n/a
> 
> All of the fedora_root/previous_releases/* snapshot subvolumes make
> sense to me.  There are all accessible at:
> 
> $ ls -l /previous-releases/
> total 0
> dr-xr-xr-x. 1 root root 378 May 31  2023 f38_root
> drwxr-xr-x. 1 root root 194 May 31  2023 f38_var
> dr-xr-xr-x. 1 root root 378 Nov 11  2023 f39_root
> drwxr-xr-x. 1 root root 194 Apr  1  2024 f39_var
> dr-xr-xr-x. 1 root root 362 Jun 15  2024 f40_root.old
> drwxr-xr-x. 1 root root 194 May 15  2024 f40_var.old
> dr-xr-xr-x. 1 root root 362 Jun 15  2024 f41_root
> drwxr-xr-x. 1 root root 194 May 15  2024 f41_var
> 
> But then there is that odd-duck snapshot "previous-releases/f33_root"
> not under "fedora_root" and not showing under /previous-releases in the
> filesystem's namespace.
> 
> How can I access that "previous-releases/f33_root" snapshot or even
> just remove it?
> 

mount -o subvol=/ /dev/whatever /mnt
ls /mnt/previous-releases

