Return-Path: <linux-btrfs+bounces-9289-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0471F9B8AB3
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 06:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACFED1F22A25
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 05:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DE814A4E7;
	Fri,  1 Nov 2024 05:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alGugQxP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40443137745;
	Fri,  1 Nov 2024 05:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730439604; cv=none; b=GmTUk/BZXMb77nf5u9kejtpjt0ZE6UTdlD8850ds94WNNzVVXQ3/VCtkLuzQiMMTlPMzfO7jp5/Qrz3r+hY90irvZspC4FMmDg6SgerHay12HioO2zU2rKxMbLog/U9xwvZCcnBNwe85ZHVGJTt0n6QWFCVpdQQijjE9JlzsBE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730439604; c=relaxed/simple;
	bh=h/cm/oX6j/E/uJJWkP679TW4zln9IrAI+rrjXBZ0ddc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubz97n2LTlO/CRnSPXMNy1DqYu0ku9XeiEVKfXhV41mZaHpuajg2Z0J/GChQpkUFyb+zcEQACb9YDJp4lgCrsWZ9g/Kk5QQP2BK5wFehEhIAcJZb58iP1lfv0tFVPBfh6rm6zadPKhPhWVsgDk4BXEsaIDnqmNE/Gnt0RFUqAOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alGugQxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE229C4CECD;
	Fri,  1 Nov 2024 05:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730439603;
	bh=h/cm/oX6j/E/uJJWkP679TW4zln9IrAI+rrjXBZ0ddc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=alGugQxPyPK4FrMytYalUqz0qZ06LpJrrCyjp7bIroDiw4nvNCPIzgFQMMuPWmW9M
	 +eAY6fHy8/nJ7S6OAOthFenzoGIJswE0M8IGCd34xFQejYUcNJDoLiTZXIFkTSY+sW
	 tf/lhS63HCme1BC7rGE+it2HB9o9pFq71e9HL/mgTFNwCot7KgwaQGXJyWzqyPK6pf
	 HIJueE8FWBd3tyWDuVQIkffPpV+NX3A361Yo0frHEPA3kNOIP1xqKUnPTbK/sRGjdu
	 npKn4WlJClOLDzv9jos+ZoDkCTIaxZWN9gqG6e2Rvler+oCWFrDco+23QmYnWTKLJh
	 enm+uqwKZt3rw==
Message-ID: <2fdcddae-f68a-46d3-9cc2-dfdf273ebe28@kernel.org>
Date: Fri, 1 Nov 2024 14:40:01 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: split bios to the fs sector size boundary
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>
Cc: linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20241101052206.437530-1-hch@lst.de>
 <20241101052206.437530-5-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241101052206.437530-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/24 14:21, Christoph Hellwig wrote:
> Btrfs like other file systems can't really deal with I/O not aligned to
> it's internal block size (which strangely is called sector size in
> btrfs), but the block layer split helper doesn't even know about that.
> 
> Round down the split boundary so that all I/Os are aligned.
> 
> Fixes: d5e4377d5051 ("btrfs: split zone append bios in btrfs_submit_bio")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

