Return-Path: <linux-btrfs+bounces-1839-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECD783E8E5
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 02:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A3A0B23369
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 01:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA41D53A4;
	Sat, 27 Jan 2024 01:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K0OuoE8Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C1028FE;
	Sat, 27 Jan 2024 01:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706318114; cv=none; b=lX8l+ZIIMAcVq4BQ669M3PIsBgGb1xmFk5w2eL4CNYbCwWwIobgl0hnpEDS3w4ivCwIt/GfgEq51f3OTm35fs0ZbFZ1HBjY0DkzA5ixL3CHJ66dm+tH6rO0GrKgUrQMZzJPxb/VzEoi0VprMmsUZDyT1TDQqTBY5rmOzyd5pyeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706318114; c=relaxed/simple;
	bh=hvNL3+3gmCRCxeDiC9Qaj9JXzgcVmqQG8vnCOqv+v9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHHOg0dTL3OWt+69P4UwrI1AlRq6+ej3J1OuaUghsbgJLD+CLS41b8x6MP2vttPpJWE5TcC5eOnZg4ZINYhXL3X8tRjWQ/r0c5lZ9Mk1e+QjC66pnrfa9n0vuU5ba0M3emud9gyMXDZgPF94F7VRwKxG7/iCdn/7id7/F5fCXwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K0OuoE8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755DAC433C7;
	Sat, 27 Jan 2024 01:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706318113;
	bh=hvNL3+3gmCRCxeDiC9Qaj9JXzgcVmqQG8vnCOqv+v9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K0OuoE8YPhaVdEeQ0DmxZjIuPcHa69FidzngPRYZxOv+24TLMrwrWY1JEYF6vdSYp
	 EEZdnM5h2na0/18Z+SgbXeRLomNGUNUZHKNX1YDVTU2goxi/r7n0hbrsCtf2kNpPbu
	 xRTWGyERrpY+xWckNLxq7WzsH35qrMcloYYgteaI=
Date: Fri, 26 Jan 2024 17:15:11 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org, erosca@de.adit-jv.com,
	Maksim.Paimushkin@se.bosch.com, Matthias.Thomae@de.bosch.com,
	Sebastian.Unger@bosch.com, Dirk.Behme@de.bosch.com,
	Eugeniu.Rosca@bosch.com, wqu@suse.com, dsterba@suse.com,
	stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 0/4 for 5.15 stable] btrfs: some directory fixes for
 stable 5.15
Message-ID: <2024012633-retold-avid-8113@gregkh>
References: <cover.1706183427.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1706183427.git.fdmanana@suse.com>

On Thu, Jan 25, 2024 at 11:59:34AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Here follows the backport of some directory related fixes for the stable
> 5.15 tree. I tested these on top of 5.15.147.

As these are not also in 6.1.y, we can't take these as you do not want
to upgrade and have regressions, right?

If you can provide a working set of 6.1.y changes for these, we will be
glad to queue them all up, thanks.

greg k-h

