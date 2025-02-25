Return-Path: <linux-btrfs+bounces-11758-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69850A43986
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 10:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32E216F063
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 09:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07AE25A2CD;
	Tue, 25 Feb 2025 09:32:03 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from nt.romanrm.net (nt.romanrm.net [185.213.174.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E53B25A2D4
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.213.174.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475923; cv=none; b=umCup4mv1ogWNz43lF29fZ4GTTCMQzzD7TmhbVcVEcrO9CNjXRM76p7GDLYVKCWOrVIlUNfhFeIyd9JgeqGinM/ZuwtFEL2bciCcaYtIN+fT83wBqZVVRpLsZMYSSyp/fZNN+DXpi3O52QPGiqkC2100vzS914IE/+SyI6FhhpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475923; c=relaxed/simple;
	bh=H3RwkjgI0zxL3/7qSi0N8hz10o3o+4kKzNlA4BV2FBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrs6NM4IX2APN0OtKwkirwJJbemIsg3+VRn+BmwobRUQcQHi0n5Z0k+ClCerzUrRRMwjtFPQc+O8I5eVso0BajRbvrMiyRphlhly81t/W+gvOQLxYD/Qnk//+J2Jeh6f6nbBk2miUdcYu9BxtnXX6O4Mjkiyv0UKE26O+3o3yn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=185.213.174.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.2.romanrm.net [IPv6:fd39:a37d:999f:7e35:7900:fcd:12a3:6181])
	by nt.romanrm.net (Postfix) with SMTP id 99F2A43416;
	Tue, 25 Feb 2025 09:25:05 +0000 (UTC)
Date: Tue, 25 Feb 2025 14:25:05 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Marc MERLIN <marc@merlins.org>
Cc: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>, Josef Bacik
 <josef@toxicpanda.com>, Chris Murphy <lists@colorremedies.com>, Zygo
 Blaxell <ce3g8jdj@umail.furryterror.org>, Su Yue <suy.fnst@cn.fujitsu.com>
Subject: Re: BTRFS error (device dm-4): failed to run delayed ref for
 logical 350223581184 num_bytes 16384 type 176 action 1 ref_mod 1: -117
 (kernel 6.11.2)
Message-ID: <20250225142505.276af40f@nvm>
In-Reply-To: <Z72LAZDq8IegQoua@merlins.org>
References: <Z6TsUwR7tyKJrZ7w@merlins.org>
	<Z71yICVikAzKxisq@merlins.org>
	<018d16aa-24b2-43ae-826c-7f717e0d05ee@gmx.com>
	<Z71_TednCt9KzR45@merlins.org>
	<d973b4b7-0d98-4310-bb7e-50f87c374762@suse.com>
	<Z72LAZDq8IegQoua@merlins.org>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 01:18:57 -0800
Marc MERLIN <marc@merlins.org> wrote:

> I do not have the system with me right now and I think memtest cannot be
> run from inside linux, correct?
> If so, I can do this when I get home and can reboot the system.
> 
> Or is there a version I can run from inside linux?

There is memtester: https://pyropus.ca./software/memtester/
But it can't test 100% of the RAM, only the free userspace area that it can
allocate. You should close down most apps and then give it (as a parameter) as
high amount as possible, without it getting killed by OOM. It could catch very
obvious faults, and it is a good "something to do" for now :) but for the
complete rigorous test you'll need the baremetal memtest86+.

-- 
With respect,
Roman

