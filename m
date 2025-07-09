Return-Path: <linux-btrfs+bounces-15391-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAA3AFE842
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 13:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5588B16D5F7
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 11:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D772D780E;
	Wed,  9 Jul 2025 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="huGLxA29"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29662BD5BC
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061977; cv=none; b=P/MNKhpVDbZGXu6ku0zoKNuDubz+0LXRO641WZPYKDO092rh0d4ricEaS7S+wuVk4xQrmNQwpUkXM70HSJE/j9xwma02h1sfKD8tBi7AyqQLnSl6RvsjOjxNH044DQ1GrpUV+yg9J2/nSZTJLKQUhXaEzonJQoUsVxzpnhmz/0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061977; c=relaxed/simple;
	bh=uBmoW7y0bsf21quwFzBnezyiXZ2xbyEppFPj7yCBmtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X01YqOtJEiyhhYmmkH4d2iGGwZSdrd892qBctgxD4dqrnUTvGlFkoEoDiPBqy+uHen+Anac2yp93L5551DmZwarhI7cWQGwBRWkbjkN1OVTB9SC+gQKSaxl/bXlFuxlCRFOFfgzxXM7t8185f/dRHHY5g8IKNSs8A7XChN06XZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=huGLxA29; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 188B4284199;
	Wed,  9 Jul 2025 13:52:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1752061968; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=x3C1zbTpr3A6bNR6MqxfJdqBlpqxhKviLrW1HOG+O9Q=;
	b=huGLxA29KzHbYS9OCU9pX6iZYvJn76P+mO54BiABNzS/IhFH0Nn1AS+DKm9giZkbjnIQnq
	+jIXjTvtNG260NkDoA9fJRMN2fSjvMzgTOXj9t+bvpY+Uos8zqeghg4rKd7P4jIexCXh+c
	uFTs0qDGI3mOSQd1GE3KR5NR//5l5k2mbJC+vLgCmDC0ol5G69X3xBGARt4lvWk5Y6imrS
	gVHduEKx50m4SQZGn4YWkq5oOIKwOaSIziYqhk/7ShLSi1ITj4Veb0IBqi1Czzka+MSVEh
	wf+C08UIUy42AZs+/rH4PidtqaAvLwRVtA9FB5yNq6o7me6LXRYtSiOwOwOvRA==
Message-ID: <d7a85208-51e1-4d16-93ac-5c2765462b7e@cachyos.org>
Date: Wed, 9 Jul 2025 13:52:44 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Increased reports since 6.15.3 of corruption within the log tree
To: Chris Murphy <lists@colorremedies.com>, Qu Wenruo
 <quwenruo.btrfs@gmx.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
 dave@jikos.cz, Greg KH <gregkh@linuxfoundation.org>
Cc: dnaim@cachyos.org
References: <fce139db-4458-4788-bb97-c29acf6cb1df@cachyos.org>
 <a6f03aff-c9fc-4e7f-b1fb-42d6a4cd770a@gmx.com>
 <f6d53293-3d55-4ccd-a213-c877dc22935a@cachyos.org>
 <d0863ae6-5c0f-46ff-8cea-b5b3d1c43005@app.fastmail.com>
Content-Language: en-US
From: Peter Jung <ptr1337@cachyos.org>
Organization: CachyOS
In-Reply-To: <d0863ae6-5c0f-46ff-8cea-b5b3d1c43005@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

There has been now logs available on the redhat bugzilla, which is the 
same issue.

https://bugzilla.redhat.com/show_bug.cgi?id=2374607
https://bugzilla.redhat.com/attachment.cgi?id=2094982

Best,

Peter

On 7/8/25 05:01, Chris Murphy wrote:
> 
> On Mon, Jul 7, 2025, at 7:12 AM, Peter Jung wrote:
> 
>> Thanks for your answer - but how it would work saving the logs in the
>> emergency shell, specially if the root partitions can not be mounted?
> You can mount a USB stick or even the EFI system partition to `/sysroot` and then copy the logs there.
> 
> Also for Qu et al, we have a couple reports in Fedora of log tree replay issues with 6.15 series too. I've requested dmesg, but at least one of the users already followed advice to zero the log tree. Hopefully we get one to report dmesg soon.
> 
> -- Chris Murphy


