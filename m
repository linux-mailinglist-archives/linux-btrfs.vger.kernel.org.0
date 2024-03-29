Return-Path: <linux-btrfs+bounces-3745-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD1D891870
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2202B23035
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 12:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E66085658;
	Fri, 29 Mar 2024 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lRfXlYqi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3586F85633;
	Fri, 29 Mar 2024 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711714485; cv=none; b=Tj+mClBdpnsTjjrBbUPaaCh6H3DCf4/xHe5TnCQjfYIlzHW5kCdVhL0jf6GuoNnmfCgObWxxhYhVwbXZI1Mk+M7TOtKyBpRuxLh+ogWaZZogWTzjZj6F9f23SAjIusqnBMC7vJvIeQp1yBRRIFGHQn8eeyDf3X1FR2dXItE88VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711714485; c=relaxed/simple;
	bh=1Ep7I3IKmnTvKAaO7liwTmgVaOaRxR0+qXCKLBbGliU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkgUix06WfW0NqRLcGn7pHzkYf7B3KAVLtC/JYHR6hoOEwYyoWgT9jlSudw0hO9NXYAO0nAfLBL5Majgw91neSpDVT+fl3lSfCiItb8tfVXFE81GCGTZC7aG0CtsC/kO4m7/l/qB7z0OEC825carB6VEd/zYBt/L7YhgQ8Fiax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lRfXlYqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAD2C433F1;
	Fri, 29 Mar 2024 12:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711714484;
	bh=1Ep7I3IKmnTvKAaO7liwTmgVaOaRxR0+qXCKLBbGliU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRfXlYqi0mBwBT5QaBcVOVxmOf6AcyhnOIISvhdkCBAjO2r8G1wSO/SC9UnSqiSwP
	 spiaTeoxaJ9F8Emg5XIdf+ZORoZXkQPLplliAadVmcu0JEcZugGgZGWiMYKmIbcTRy
	 THdlHEmrbcSm4mDhM7VGEx0/R4F4BglKtssiUdZA=
Date: Fri, 29 Mar 2024 13:14:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: David Sterba <dsterba@suse.cz>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	anand.jain@oracle.com, Alex Romosan <aromosan@gmail.com>,
	CHECK_1234543212345@protonmail.com, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "btrfs: do not skip re-registration for the
 mounted device" failed to apply to 6.8-stable tree
Message-ID: <2024032934-wish-unpack-7d99@gregkh>
References: <20240327120640.2824671-1-sashal@kernel.org>
 <20240327213751.GW14596@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327213751.GW14596@twin.jikos.cz>

On Wed, Mar 27, 2024 at 10:37:51PM +0100, David Sterba wrote:
> On Wed, Mar 27, 2024 at 08:06:40AM -0400, Sasha Levin wrote:
> > The patch below does not apply to the 6.8-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Please use the version below, applies cleanly on 6.7.x and 6.8.x.

Now queued up, thanks.

greg k-h

