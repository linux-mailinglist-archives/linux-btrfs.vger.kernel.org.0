Return-Path: <linux-btrfs+bounces-7542-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B34A8960034
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 06:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BB4283D43
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 04:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B217042AB5;
	Tue, 27 Aug 2024 04:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJOtGmpg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B7A210E9;
	Tue, 27 Aug 2024 04:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724731722; cv=none; b=XzaGS6vYZ9n15wbC/EXNEGnyDllGAWtMTfJCZJDdPycxlrgimz+yO6MBv52PY1HfVGKqQB695vCivh4sehK6wW2xB7FvufUXkp8Cs1s4oHkYLDH4AxWUx9bszLiX9vRlp98CIrev0msY9zxHIk3XTqgAIVZvhSoD9Wi0OEv0W4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724731722; c=relaxed/simple;
	bh=4k1Cqj8b4wr9XU9TIRB4ufdLXcPkYzakEKmtnc0SMs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ckewpo2KvtN495O3JYvv9PWo99iSZTCDENEca/iyRANgOAvOm7Nb4IJ8hWEkGqKYe3CWhrC5wfEF6Fp0GlqlfzJUAQS5NzOD3jEo0Skx2osFjV3ISvJHU1W7IJ9ydTv/BfbiGTxo7V3Z8QP3D4LcunogJQ1NBjpm2j8JlsapyFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJOtGmpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59789C8B7DB;
	Tue, 27 Aug 2024 04:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724731722;
	bh=4k1Cqj8b4wr9XU9TIRB4ufdLXcPkYzakEKmtnc0SMs0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aJOtGmpgXxIpxfXVUblfa1E8AlLPLvV3StT1cG3VBtEEhXLc/xRM/POSsa318QMQC
	 t09Y6RSk+dODiVKxyaobCI3V59bKDwVSCxLnnSbUa3i8StHp1fSjGIo08Z8I/YYoCD
	 x6BxwqsZm3BKDnjD9lzYf348Ppg1GtIBfJ29DAdhTL9Ou83juVacTCW9zZGsW0jeNP
	 E3WEPKrcnvyCHZeGzl4ehxoQ56H1mbLhxYQpqOGprrQ8O+LWmqpb+Gvd9CQgwk60yz
	 fKo8duKzTiDeexta9aplSweqimvZhRplxg5tzohmKSD9dMuSjk2xf9Mf9QXBYpX9Bl
	 W+KUUoXDTUyEQ==
Message-ID: <74581e8f-2eec-4cde-b828-4fc7d2925399@kernel.org>
Date: Tue, 27 Aug 2024 13:08:40 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] block: rework bio splitting
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Hans Holmberg <Hans.Holmberg@wdc.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20240826173820.1690925-1-hch@lst.de>
 <20240826173820.1690925-2-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240826173820.1690925-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/24 02:37, Christoph Hellwig wrote:
> The current setup with bio_may_exceed_limit and __bio_split_to_limits
> is a bit of a mess.
> 
> Change it so that __bio_split_to_limits does all the work and is just
> a variant of bio_split_to_limits that returns nr_segs.  This is done
> by inlining it and instead have the various bio_split_* helpers directly
> submit the potentially split bios.
> 
> To support btrfs, the rw version has a lower level helper split out
> that just returns the offset to split.  This turns out to nicely clean
> up the btrfs flow as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


