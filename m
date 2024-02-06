Return-Path: <linux-btrfs+bounces-2167-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5655984BE1A
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 20:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FD71F2550A
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 19:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B732317579;
	Tue,  6 Feb 2024 19:29:50 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60322171AD
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707247790; cv=none; b=lstBULqboRcLsHe3nxwZ98rczjLjCd9PLjspWSDXMZE2G57rFg/kL+LyNGLMrohSwWx/bj46Cuf5aeuirUYTfHNuWH//kT4O/fOUf6BHKYXNmQkI6JFTkWDsM1DD6mGby0JhFhlpWuazpFnRDPa+1NsxXhyRX4a92AxfMWOmGTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707247790; c=relaxed/simple;
	bh=WrFhaN8JOO+aKKYzQi8yMOZTldn2Dem+utQ5qPVOpC0=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fJqtscINHyyDfPvdasO9D7CcFOgTPwvAg3dS6Yd4fC70vKtzNNQ0+E66fmaFrlxEBEZkdQAtmg3aGQq6vGFhTTxMM3yOg/J0XTqbXAS/I6aMwdVCBJ5ZipUF+p/Li2PYiZKpwmCVg5A0fIiA6C9dXyOiLXyGwsI4SdpT4ooRL0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b2e8fde.dip0.t-ipconnect.de [91.46.143.222])
	by mail.itouring.de (Postfix) with ESMTPSA id F19EC103702;
	Tue,  6 Feb 2024 20:29:37 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id AB7C8F01605;
	Tue,  6 Feb 2024 20:29:37 +0100 (CET)
Subject: Re: How to delete/rewrite a corrupted file in a read only snapshot?
To: Marc MERLIN <marc@merlins.org>, linux-btrfs@vger.kernel.org
References: <ZcKEoftmxxp3SOiB@merlins.org>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <62904255-4169-c126-2e6f-4323b02ebace@applied-asynchrony.com>
Date: Tue, 6 Feb 2024 20:29:37 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZcKEoftmxxp3SOiB@merlins.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2024-02-06 20:12, Marc MERLIN wrote:
> howdy,
> 
> I'm seeing this during a background check:
> [374402.156920] BTRFS warning (device dm-18): checksum error at logical 4401320624128 on dev /dev/dm-18, physical 2939697954816, root 63534, inode 595460, offset 1506283520, length 4096, links 1 (path: nobck/file2)
> 
> this is in a read only btrfs send snapshot, so I can't just delete the
> file or the snspshot (I have 20 historical ones all with the same broken
> fine).
> 
> can I either
> 1) force delete it with some admin tool
> 2) even better force/overwrite it with the correct file from source?

You can flip subvolumes between read-only and read-write:

   $btrfs prop set yoursubvolume ro false

See "man btrfs-property" for details.

This should allow you to delete the broken file or replace it.

Good luck!
Holger

