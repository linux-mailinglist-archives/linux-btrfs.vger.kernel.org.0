Return-Path: <linux-btrfs+bounces-19337-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16060C8591D
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 15:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B2F54EF5F0
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 14:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9953532694D;
	Tue, 25 Nov 2025 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="VrW9Tby6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC8713AD05;
	Tue, 25 Nov 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082123; cv=none; b=fUz+m4O/XzQ+mAxG3/szltii1lzV//jzTuHu2LJ9Vn9egI5df5BQ4unq7W040Tn6EVhjedKRHfBBJWc3szsW6oXwnK0zXlmLbhzS8XaJ0jU2sMZThTq9CCsHK0YWndFyMudwhbCJ2yZcMypQWklyhB1S1h9rKWIFMHnwSs3nZDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082123; c=relaxed/simple;
	bh=2mWS+t8jOxaWxXwQWCegwYCFJbVWbjozqq8CUVChLfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiHyyCBS2vcsxi076kRyrFgf3TGWRIKj07Wih2LWzky2e4J7QMKmKXgcxQgXwOEj5H3f7/O9x/F/lXBW2z7onhpQPrG9HQYBShQZ6LVYZ2vB+ezK2RC+BHw0sQaEXK9/s07Rc3zvh64I33pkAqeP7HUqcD208hIbO6+EEMhpctw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=VrW9Tby6; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=aw2Y8oEh6bqWW/XcaZH0GXs/SY0LKo1OAbKDADmPqRk=; b=VrW9Tby6fAKdyw36
	XXoTlnwIuhMRA3VyJik4syM3ynqaTP/N5Ynsnmshbcqd7asNr9Qq87mfhP1cLrqldVUdCxhhC01xX
	1V6bWN3Od/pZx9BZubJoVBfJFOMSW0xEnvx52VZMNHONSL4n+BOK6v9sR/tcJXR/6bVPejA6xkpBU
	7b7bft8tTJaGESY34YtAUjc3TISjztmh7AhwCj6JZ7o/1OhY8BWVbH+CuTBtCyGvFnzsiW00tor9m
	8NbBqgac6AGWrmk6I7cS6qS3jQiUetGHqLKsAR+yf6ZRduZyXQ7PZg9WMmZV1WNW9w9nhqNYZD5QB
	USVnlmJGaF1p3WNFQg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
	(envelope-from <dg@treblig.org>)
	id 1vNuLI-00000006PlQ-3QJY;
	Tue, 25 Nov 2025 14:48:32 +0000
Date: Tue, 25 Nov 2025 14:48:32 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
	linux-raid@vger.kernel.org,
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
Message-ID: <aSXBwBoBZp9t890U@gallifrey>
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 14:45:30 up 29 days, 14:21,  2 users,  load average: 0.03, 0.02,
 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)

* Justin Piszcz (jpiszcz@lucidpixels.com) wrote:
> Hello,
> 
> Issue/Summary:
> 1. Usually once a month, a random WD Red SN700 4TB NVME drive will
> drop out of a NAS array, after power cycling the device, it rebuilds
> successfully.
> 
> Questions:

> 3. Are there any debug options that can be enabled that could help to
> pinpoint the root cause?

Have you tried using the 'nvme' command to see if the drives have
anything in their smart or error logs?

(I don't know any more than suggesting looking at those logs to see
if the drive is showing errors or what it says during the timeouts,
so I'll leave it to others to dig deeper).

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

