Return-Path: <linux-btrfs+bounces-12971-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74351A874F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 02:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79C316FC64
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 00:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880994C6C;
	Mon, 14 Apr 2025 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxIVPrh7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE464D;
	Mon, 14 Apr 2025 00:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744589515; cv=none; b=nNLOL+FTFpRAsUSH95ifljMT7OSJxJWH8Ed5pBsQgI5XwVbRd1mAF+5JBVXrlY/UOXS4MslgmTiXAhw959lxVFqugJkHL+6Pd+/guo34LHLSUKT9ObqoMm4oGiqaT2pxewD9NkbjzV99Z0hr2JJVUsXWDAYTH6KBfxkglZEvMpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744589515; c=relaxed/simple;
	bh=VCN2F59ZCkIWnRcQK6xkMYDWXTnlfwOUkEdgVge3kn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6E6oRQx0gf11Pk86En8pLoDola+WImkrO5bX46yrRHq5HKikBSI+0/thWwKFoqgCQMSJkCzal/Uk5lHJklTlfBHdF/R315SBriBKrs7EM89AkNVVMm2KQ/LtwVEIRCQ0O6HYkI96x6+8AJC2BoWJNf9r9zyNmflrrWOcu/5d/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxIVPrh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B48C4CEDD;
	Mon, 14 Apr 2025 00:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744589515;
	bh=VCN2F59ZCkIWnRcQK6xkMYDWXTnlfwOUkEdgVge3kn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JxIVPrh7VjVrZnNYYuNfmVttsL5hghqQl9qr9TqGCIesL0l4i8ioRqoNNEr8MY6u5
	 Q2jttOTuSCEjg6MjAJArueQG8Ogy+yulHAQByc1u4rqx9p1RsbLEAzJs13WB+MQ3t4
	 /QWel27wQALLesgMpKR/ydNURmJK58ff5uUl8wEOy9J/98TzlzK2rMLgrm4M4tShTe
	 bPj75jKgVH1vQ+xffe1C7WtxobsMwQ4kF8U2sgYUex7CGETA+kPeug2viDjUHEcjyD
	 U9KiOS8AGl4DK+gU7WoTibMjt+h5/eL5mHp6qnYlhpErbFSDFHs5k/4juQgYscJ521
	 /b8Ae2VxLpEcg==
Date: Sun, 13 Apr 2025 20:11:53 -0400
From: Sasha Levin <sashal@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
	clm@fb.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.14 40/54] btrfs: reject out-of-band dirty
 folios during writeback
Message-ID: <Z_xSyaMfIt8z_CYk@lappy>
References: <20250403190209.2675485-1-sashal@kernel.org>
 <20250403190209.2675485-40-sashal@kernel.org>
 <20250403193717.GS32661@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250403193717.GS32661@suse.cz>

On Thu, Apr 03, 2025 at 09:37:17PM +0200, David Sterba wrote:
>On Thu, Apr 03, 2025 at 03:01:55PM -0400, Sasha Levin wrote:
>> From: Qu Wenruo <wqu@suse.com>
>>
>> [ Upstream commit 7ca3e84980ef6484a5c6f004aa180b61ce0c37d9 ]
>
>Please drop this commit from all stable branches, it's relevant only for
>testing.

Will do, thanks!

-- 
Thanks,
Sasha

