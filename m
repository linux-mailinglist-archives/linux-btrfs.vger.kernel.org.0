Return-Path: <linux-btrfs+bounces-2882-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF2086BE67
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 02:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6EA1F2386F
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 01:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2188A2E83F;
	Thu, 29 Feb 2024 01:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="ftw2SfK8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE9C2E405
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 01:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.81.13.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709170888; cv=none; b=JySqiv4RRAXUl19fEPUDJazulMu2malEQLRojmuWRaPAPNjncazFCZT3O2EQluaKES7TDeEhyhRhO0wyWP2R4wop8pDgWPAS+8ekhWvpEIjFizN8/pQXKKCEy8araV7NMZJxWjleM9thEDkxAHr/4O7YYnbJgchS4tTcVCuSzTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709170888; c=relaxed/simple;
	bh=EDhdKdS3T6zaxNj0hn2E5Il4B7fzdSQPLWHERr2Vew8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJMqb0eSM0Q6bugSNgABicqrkxOf82a2mvcCRYjOdGsArG/oeO2nDXdo33TKJALzYOthOzMUY2v7m3mdEYfrr6hgQz9XFji7zkCEpMNUopNL9I1F4aENw1CEIlQ8n4qvNaq/nEyHXbKXLE5NY+ypoBf+rfdk8X/QDTZ0G3f5Cgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org; spf=pass smtp.mailfrom=merlins.org; dkim=fail (0-bit key) header.d=merlins.org header.i=@merlins.org header.b=ftw2SfK8 reason="key not found in DNS"; arc=none smtp.client-ip=209.81.13.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+EFhEfQN9St0RFBCgq92Z2kbrvWpA9dTBefYafA69tw=; b=ftw2SfK8SqxG79Aw5VPyKhicMD
	2/R/awC2/6iJl22ooPKWEeD6hao7cJcJTYkwkqOIpbkH6s/+bxSJeXoaKnrFlLfW78vLpIFRd/q/f
	5vjAN/sGlEPCePS1sB3aLzqiW+TegIpb1lG5LzrseW/ixXiI2GsdEItJJXfJPchyj4Zl92zNqSbgn
	4cJTAvTpUCfJIIUX6C+iU7hh35DDP0n+pXfuNOzw/90tvbFxKBS5B+JgTzLBICl4bp36Z/xmPiKJ5
	Z/CgrddcYI8N0t1vNOA6y30yGmWEOMWO9ekEYK5eE2m2XjeAespWyt9fH/t1rg+GzYR8m3I2VeLEk
	wJifZwEg==;
Received: from [205.220.129.25] (port=15787 helo=merlin.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1rfVQK-0006ky-Hu by authid <merlins.org> with srv_auth_plain; Wed, 28 Feb 2024 17:41:24 -0800
Received: from merlin by merlin.svh.merlins.org with local (Exim 4.96)
	(envelope-from <marc@merlins.org>)
	id 1rfVQD-005vKj-0K;
	Wed, 28 Feb 2024 17:41:17 -0800
Date: Wed, 28 Feb 2024 17:41:17 -0800
From: Marc MERLIN <marc@merlins.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: 6.4 and 6.9 btrfs blocked and btrfs_work_helper workqueue
 lockup, is it an IO bug/hang though?
Message-ID: <Zd_gvRXHIjtvN06N@merlins.org>
References: <ZdL0BJjuyhtS8vn1@merlins.org>
 <Zd5s1k8bFguE2NVl@merlins.org>
 <2020a7b4-b052-4144-8386-b05102a5465d@gmx.com>
 <671192d3-1331-480b-b00a-af3eaf794089@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <671192d3-1331-480b-b00a-af3eaf794089@gmx.com>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-SA-Exim-Connect-IP: 205.220.129.25
X-SA-Exim-Mail-From: marc@merlins.org

On Wed, Feb 28, 2024 at 06:54:48PM +1030, Qu Wenruo wrote:
> It looks like there are something wrong with the aacraid driver, without
> several hanging IOs.
> 
> That may be the cause.

This was what I thought, but was hoping for a confirmation, so thanks
for looking it over, and I guess aacraid hangs turn into btrfs hangs,
making it look like it's at fault, but really it's not.

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

