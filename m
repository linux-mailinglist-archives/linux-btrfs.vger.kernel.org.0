Return-Path: <linux-btrfs+bounces-12004-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D68A4ED89
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Mar 2025 20:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BD117173C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Mar 2025 19:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849B61F5826;
	Tue,  4 Mar 2025 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dirtcellar.net header.i=@dirtcellar.net header.b="eTj+FPo1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10592E337C
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Mar 2025 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117049; cv=none; b=nyby3a3FSpof/8WxdW+5XD8zeMoZQI2C1AaOouV6tmmnTa4qhI+Lffg6nKEjT4cS1h38v51EwnTQkX++eKiXq0+JV5WUTGtq5NqmoHwUqiSsPcO2FhZuKi7978c38sGgMKtmGiTlKbNpT1+B4RbQ3mkzWCX6CLGY7Gb7DLZZVyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117049; c=relaxed/simple;
	bh=J0FuCYbdqgBjoyjdNCSg0XCqFKm4E5Vb/ksrO+gF9v4=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fTZdRGIe629jOWHONz134AH4RvulDj/mYz1Fvy/hYI9DF8bFhBtVmPqkHADyluPbDjZAtVpWqH5wyv8PPC/pmR/zs6BFNrsJYj8urIw1Zlpdm7Bw6cbz9gPvD2l6e7XnG9VhAgOiRh+AtkRvzhn/Zt+F58o8148+xWYDOP7sQW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dirtcellar.net; spf=pass smtp.mailfrom=dirtcellar.net; dkim=pass (2048-bit key) header.d=dirtcellar.net header.i=@dirtcellar.net header.b=eTj+FPo1; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dirtcellar.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dirtcellar.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=dirtcellar.net; s=ds202412; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
	From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=fCsr9OYlM76D0Tw621a4hZf3/UOhZ44gY0OMUprergY=; b=e
	Tj+FPo150wQGAtU+MbvFu38ZVZcBQ3+SyOabhzAV/SYovcwtsfcIUP9zEPSjB06QKY/EhUQQPiohV
	4o1HZ4okyUExPXWiw5LMZBI0RIzJS8pGIcGZxwmjjaBKOm9/JZXzrbq33HqD0+w//I2UVkSb8JUhC
	RZcJeLvrtgvRDzQ/tVjexajCajfvetoUH1u/QRdCYAkFeQ6x0aK+LnB3FRZo2M6sLowsHls9Ucndv
	8RFgZTKhFGstbn8ZpveQOWMf6UnHXNQonFx26VcWCnOJ5lqf8gEFv7wFL641R73qlObRKLkbHtLGZ
	v2VLXloHwNtDwFgIoFL4gP+k5mBt6Cb6g==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1tpY4z-009jxL-Pf;
	Tue, 04 Mar 2025 20:37:25 +0100
Reply-To: waxhead@dirtcellar.net
Subject: Re: Question about donating to Btrfs development.
To: Panos Polychronis <panospolychronis@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <CAEFpDz+R3rLW8iujSd2m4jHOCmHMCxe7OYDpohv16r=JJwbHSA@mail.gmail.com>
From: waxhead <waxhead@dirtcellar.net>
Message-ID: <46049dba-b56a-8906-b527-83616d1524d7@dirtcellar.net>
Date: Tue, 4 Mar 2025 20:37:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.20
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEFpDz+R3rLW8iujSd2m4jHOCmHMCxe7OYDpohv16r=JJwbHSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Panos Polychronis wrote:
> Hello Btrfs developers,
> 
> I am a long-time Btrfs user and greatly appreciate the work that has
> gone into making this filesystem robust and feature-rich.
> I would like to support Btrfs development financially, but I couldn’t
> find an official way to donate.
> Some projects accept donations via the Linux Foundation, SPI, or
> direct sponsorships. Are there any ways to contribute financially to
> Btrfs development?
> If not, would it be possible to set up a donation system to help fund
> specific improvements?
> Personally, I am particularly interested in improvements to RAID 5/6,
> native encryption (AES and ChaCha20), and general performance
> optimizations.
> Thanks for your time and all your work on Btrfs!
> 
> Best regards,
> Panos
> 
For what it is worth , I would like to donate a few pounds, doubloons, 
bucks or whatever myself.

Personally I would like to donate to support the following:
1. Per. subvolume storage profiles (if it ever happens)
2. "RAID"5/6 development
3. Any effort to change the RAID terminology to something more sane
4. Various read policies as SUBVOLUME properties for RAID1/1c3/1c4/10
5a. A drink of your choice (Hey, thanks all for a great filesystem!!!)
...or...
5b. A treat for your pet which deserves your attention more than I do!


