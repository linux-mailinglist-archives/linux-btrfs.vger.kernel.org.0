Return-Path: <linux-btrfs+bounces-19445-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2805C99E72
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 03:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4208F3A5BB4
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 02:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD193273D9A;
	Tue,  2 Dec 2025 02:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpdfxE4j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7A718A6DB;
	Tue,  2 Dec 2025 02:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764643637; cv=none; b=d+X0ogW6dBKOzt9Eu+f8uX0wc4kTReAXEKU+qMUrfe9GL4NQq1FCIp8kzS/IkwnMwwm/g3Lz8YreS6YRSi+x1JlS20zGnI0/M//qBWoLemEvtMDciH1r86U0MIt2cGYLA4FsIyDI4r2yA3vtUSi6cMk1Rq00cr83w/TrfRsxMJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764643637; c=relaxed/simple;
	bh=ptZo5CdJibDzbm5KHwiJX7L6GU2pFUSsnTi65NDpqO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wrc7FM//kw15tBtUpAroF+AnzONAwyfz06urkU0eyQg9HqZAYcqkpGNyvbSLobk1epEPHAkLNhQvWdusKsn3i9CxB1BrcRHDlOwRWBm1kShPfsqsTVpNXgAxAk3Ckg/RMNDmXkP0p/A8vyWSzCv7GkFwcOUmhddc3XRXFwI90Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpdfxE4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B37C4CEF1;
	Tue,  2 Dec 2025 02:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764643637;
	bh=ptZo5CdJibDzbm5KHwiJX7L6GU2pFUSsnTi65NDpqO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TpdfxE4jYXfc/QxVnk9Tzr7OsffArfujjfARrZed7c3mGkfJjXODI4tO1fbL1L4eF
	 PlicYsc6d8qKghMWqOPUgbTUDpWqn9ja9h5FMPZeuO7P7l+GpHn1UV1HT7TmV4g6JV
	 eG04pOD3cRzSaO7B8EayYTd3yNl3nI/LjIMnSqGj3SllI7B/Vfxbl5RZuy/AN2zB1k
	 wS73bAsj4NUkPSJ60rn2qAesY25o+/4O4xXsWUvUNHEYrUpdfLfNnUf4YLN2mwK49y
	 ZE05C0n+d/Cb1L8EMX+8OcQzZ8nM1OxfY8DqftetRadpyyIDFLDz3I7Eva6McDJAcA
	 KVHcl3E2TJ1MA==
Date: Mon, 1 Dec 2025 19:47:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
	linux-raid@vger.kernel.org,
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
Message-ID: <aS5TM30PizKtz_hW@kbusch-mbp>
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
 <aSXDnfU_K0YxE07f@kbusch-mbp>
 <CAO9zADzUZYzM=xkvHPXepQP_+6V0f4__yroPNV6feyPB27Ju=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9zADzUZYzM=xkvHPXepQP_+6V0f4__yroPNV6feyPB27Ju=Q@mail.gmail.com>

On Mon, Dec 01, 2025 at 09:13:01AM -0500, Justin Piszcz wrote:
> Nice, I was not aware of this, thanks!  As this issue appears to
> affect different consumer-level NVME drives, any efforts to address
> the quirks in various NVME drives to restart the device while keeping
> the volume intact would be awesome if it is possible to- get that
> point in the future.

Various consumer NVMe's use 3rd party controllers, so maybe that's the
common denominator. There aren't very many to choose from.

Anyway, the suggestion won't fix random IO stalls when the situation
happens, but if it is successful, it should keep the volume in an
optimal state, albeit with exceptionally high latency during the
recovery window.

