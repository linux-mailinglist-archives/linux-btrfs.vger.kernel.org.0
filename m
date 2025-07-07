Return-Path: <linux-btrfs+bounces-15276-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8878BAFAA40
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 05:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5503A93EC
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 03:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38A8259CAB;
	Mon,  7 Jul 2025 03:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAqYT3Ou"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243A412B94
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751859106; cv=none; b=kaszTYX3xD+ccE0ynrTY17RFIN8ps8zv4HlEbV6ZAgfT8/ZPWOV/3SzKFEF4l/mHLXnuu9OdN4X5kFpYTbscshg4KAvskKympKboGetk6jD6dwz2pn2HSJc4ofxpCzz+avpOM5iWAjdOHSk/JmZgxrvQqTjOgivL/YmVpR95y7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751859106; c=relaxed/simple;
	bh=eyuri4pfmxzAT/zqzz6jGovFgRNc8XFUBhAACQcbt/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SOLbazDYC4EqhlTmRq2aHfwyXLZtRQuVc6798jHJGK7Em0dy2YJkqePA7t/daFhl8t7wAyqBCPR6aRvJdOjaeu5Q6JaT/pDXkWOcRrJHCeJwovnwYxm8sn55SYVRQmkenpCStY4mZdUmlvTqMQgacN4XnjTeDXVbvF+VlPk176o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAqYT3Ou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C30C4CEE3;
	Mon,  7 Jul 2025 03:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751859105;
	bh=eyuri4pfmxzAT/zqzz6jGovFgRNc8XFUBhAACQcbt/0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=RAqYT3OuyE8pxFQhfN4+348HIOQerh8vEqU3LMFyTwuxUovKOZKJSQ58WFs08j7qT
	 hTAuD0UxjowyeZvYgaFAokC9sF8wq89nN3nrRcYMuCTS+qaVMTj3Jmv7jAsyDGgjfu
	 JKA/TgkWGbiF3udggLvHhOF/D6FdCnGKEuIhQa9mPIjvo33uhop4KTeqYv+6050dIt
	 i6y9guhcP7ibGPTaiYY5uxOMac3h25QkreqEyBMwrxsU7Yb4A3Eq3cQYA52/Z/QU3W
	 nKFpy5Pfn3TSgSybZdCJpnlr1WdUQSisq8+PFxCGSeySvqcBPGi5oQElZuBcsu27Fd
	 aj38qF0D5+3/Q==
Message-ID: <3acf6cab-7798-4c32-ae95-c921adc8c8ac@kernel.org>
Date: Mon, 7 Jul 2025 12:29:35 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: zoned: do not select metadata BG as finish
 target
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <cover.1751611657.git.naohiro.aota@wdc.com>
 <91e1b6f06906a4737b9d7b3e1083bd8fec040041.1751611657.git.naohiro.aota@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <91e1b6f06906a4737b9d7b3e1083bd8fec040041.1751611657.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/25 11:44 AM, Naohiro Aota wrote:
> We call btrfs_zone_finish_one_bg() to zone finish one block group and make
> a room to activate another block group. Currently, we can choose a metadata

Nit: make a room -> make room

> block group as a target. But, as we reserve an active metadata block group,
> we no longer want to select a metadata block group. So, skip it in the
> loop.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

