Return-Path: <linux-btrfs+bounces-11161-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92750A2245E
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 20:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5CF168194
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 19:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC9B1E2607;
	Wed, 29 Jan 2025 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="0MAc0AgZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E903A1DFE06
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 19:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738177485; cv=none; b=ktDTasH2maS6dof/k8Pvfzm3BdACdL3JNnC4/NRB7xYWTamyvXBEMXwlXY+lrz+EX3D2pEJvyppfHQT56vCwBagGL4d03Jh4NGaMN6oAQPSxmCd2sBvCQn8mg08txMPExdXtDIHq5A3c6tc5AGn7xOSNkmQtQbFSLkDAYPkyXaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738177485; c=relaxed/simple;
	bh=uOK5tHtdBFtQ+uuB75hCUqyEXqtRgqopYCaGI+Ype1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/eBhXULVfpx5kfpxRuMlDVhcfEVDq82EEENik+qxhWPROSWaDwgFMt93/vriqN/Y1UHGRMEkrdmSB0LTeQYWk4uVbF5kGtcB0n63AC/sntP/3dohGhyy/dVVXhhHbCEEQAIvJrQ6OrA7eGa1TAasFYFEX3a0VlA1patJsrj2B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=0MAc0AgZ; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id dDK7tLmCk5LVidDK7tuU5X; Wed, 29 Jan 2025 20:02:05 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1738177325; bh=Dm3Wthh3Fmw7cWLh7JvtK6wWvuTAS9Lb+ZHNQ12VKL4=;
	h=From;
	b=0MAc0AgZm4XiO2Nn39YPgHGN17LqnPhayTPKt0H7Aav6UnK576K4ZBd3Lafz66IfR
	 Ncf3Ql69XaTXL+5gec8nMaehgPMqfYy2KGWASIwo/vRKR4q3JLI1QhoOTh5KiInxjV
	 OHXBZqcDh2+tMN/n6Yu7/IUWNQvh4tioq/m4AVEwYXBNFYoUi+Z5K2BIPsnFVhlr4l
	 Gvqg42Um9TjXMjLkn3t1ZecUIfxTsmOeO5rt+BDE742+ffC4t5tCsQYcdjM3DbrCJc
	 cLaezrDtn99Rld8xDx5kHEWqY5MfcgaHJ7/njf0gvnd4JOdt5nDDTS5oKFTNjLLHMW
	 9GQVrXy4TJ3NA==
X-CNFS-Analysis: v=2.4 cv=StRb6+O0 c=1 sm=1 tr=0 ts=679a7b2d cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=WJyTCbUXE8ZVV855lvUA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
Message-ID: <83b8c701-7719-4e90-b435-6398e132b921@libero.it>
Date: Wed, 29 Jan 2025 20:02:03 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [RFC 0/3] Btrfs checksum offload
To: Kanchan Joshi <joshi.k@samsung.com>, josef@toxicpanda.com,
 dsterba@suse.com, clm@fb.com, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de
Cc: linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
 <20250129140207.22718-1-joshi.k@samsung.com>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <20250129140207.22718-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCkU6Ctt9veVANLcmm22pdNQVNMnyeTYb76F8RfeZVZ3cJzJxfW4tBqUf0X9NE0G0rWGDopElgxfXFLpDuRX8cHTOV8x3cuFVK7pHjUmwE+jN60QTOdw
 JUW8PVie0x7Nr2hdmbucatzt5s5YAjK2o2+3li7rWcI8gyTikJNfL8DeJiEst2OfqmVZ7xr1zDffrAt0ugX2kVkpf5F5IqsM4dwrEzKA6HcRtmSyhTb/v5NB
 Y5BPOaXiSOOGw5nn7PsIadJPJ8XyqrJ4L0lKOXKJJf+ZmTuC+hCDzywmOwJlJUJYa1MErFxAxmYr0iXmHFVkkv91CRGDlfr4CaNq9Pf3iRitQBdW+3IE9c42
 qMNWp0M8cLvbYJx7+5gGFAl4yBVwg8xJQqT4tkUhIVnssL4dfvXzhxAbJG1ozkp7EfEdE2htwEgMJVfbj4/mWb6XXcjZo2jWyLpkeuyeFqIdedyMFXNNHnqB
 CUpc6nhX65L7Mh4ZuX8prDmvqGNgLumGE0kcbQ==

On 29/01/2025 15.02, Kanchan Joshi wrote:
> TL;DR first: this makes Btrfs chuck its checksum tree and leverage NVMe
> SSD for data checksumming.
> 
> Now, the longer version for why/how.
> 
> End-to-end data protection (E2EDP)-capable drives require the transfer
> of integrity metadata (PI).
> This is currently handled by the block layer, without filesystem
> involvement/awareness.
> The block layer attaches the metadata buffer, generates the checksum
> (and reftag) for write I/O, and verifies it during read I/O.
> 
May be this is a stupid question, but if we can (will) avoid storing the checksum
in the FS, which is the advantage of having a COW filesystem ?

My understand is that a COW filesystem is needed mainly to synchronize
csum and data. Am I wrong ?

[...]

BR

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

