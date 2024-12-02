Return-Path: <linux-btrfs+bounces-10001-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E339E0082
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 12:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D72FB3074C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 11:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123C81FF611;
	Mon,  2 Dec 2024 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="omS7o3JW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D771FDE11;
	Mon,  2 Dec 2024 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138158; cv=none; b=FfLyKr2+iP3bvkz/At8O6oNm9v+x2Q9zis/Ll+Kaybk97U6ctv2yzHHLXoFYNvmHmMc7csYBaDGa29AiUvCrZOR3ay3+hCvop305UBmp6rXPej6qpihrE7C8AxHv4AYvY+3MaMLp6lGH/G931pb3GsrmdwN6TGBCU4pe5GM15+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138158; c=relaxed/simple;
	bh=+3o8VZcSOSYHSzMw7XPS/675FGXYgfrh1MvHYwk8GIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/PWvYbD0ShciuDXk6YLeY8IF1RVpcNEvuu8U2pSt87Zdw2I4206QL4W6si5DBct53oXELNniM7DFYIY1EpvXyo2NVJHvXCZcqOJbl77lg56mOz8zbWGTLvx9bBdMtXWgUjGcA9KOiuXLqEJ1YrDlBdJJ4XGccZ3g3L9FwFMNR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=omS7o3JW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394A9C4CED1;
	Mon,  2 Dec 2024 11:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733138157;
	bh=+3o8VZcSOSYHSzMw7XPS/675FGXYgfrh1MvHYwk8GIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=omS7o3JWcbt+hGCYaDCnY0qIOSlOEMBYrH1qNUASVmrXQRy3iOSoDvdoCSQr7uNoK
	 MRIEKTzIQec5LxJJ31XVc8aQPlfOFUIL3Owd3gy5+S2TVGwtdMGPAd01s+dQiVOyJf
	 isNTAt39olxPCP3SKR+E1a9OdsLs2XO6a84FQBeU=
Date: Mon, 2 Dec 2024 12:15:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: David Sterba <dsterba@suse.com>
Cc: stable@vger.kernel.org, linux-btrfs@vger.kernel.org, git@atemu.net,
	Luca Stefani <luca.stefani.ge1@gmail.com>
Subject: Re: [PATCH 6.6.x] btrfs: add cancellation points to trim loops
Message-ID: <2024120245-molar-antidote-e93a@gregkh>
References: <20241125180729.13148-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125180729.13148-1-dsterba@suse.com>

On Mon, Nov 25, 2024 at 07:07:28PM +0100, David Sterba wrote:
> From: Luca Stefani <luca.stefani.ge1@gmail.com>
> 
> There are reports that system cannot suspend due to running trim because
> the task responsible for trimming the device isn't able to finish in
> time, especially since we have a free extent discarding phase, which can
> trim a lot of unallocated space. There are no limits on the trim size
> (unlike the block group part).
> 
> Since trime isn't a critical call it can be interrupted at any time,
> in such cases we stop the trim, report the amount of discarded bytes and
> return an error.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---

No git id?  :(

