Return-Path: <linux-btrfs+bounces-18588-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5402C2D1B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 17:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C02F1884792
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 16:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC07316191;
	Mon,  3 Nov 2025 16:24:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from savella.carfax.org.uk (savella.carfax.org.uk [85.119.84.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3ED2E7F1A
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Nov 2025 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.119.84.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187054; cv=none; b=DiMmYGOCVRmVO7l/n8LW4/FT3YzEz0ZANi5nIlXZBWLaaED7gQMtPbW4Ji3O92FH/cs8yKswXBPq2hRcc5zQtCIcqYM6ikz6gxYekUp/tFly3ATuexRXFusCqiRC5rK0NWL0lGYtfYvrCwkxvZo89rBI/Ll+9sTy5dVb8fVrLa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187054; c=relaxed/simple;
	bh=jLHKYLXh3s6ggVLYaTEvQGuRScTebA/bRLHTfiTuTkE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5XzucNy2v4SRf51daZzjZeeenYg6Hizg3cgPNvcJaB8MPLw8B1QELpjQxZGJkPV0ftRODuqBNOXgtEoDrBRTyR5Eh21V7W2nftARh1dsPTyecNFun9+SQ3y/CtMQ/PzNH6wPmjSRDDlE4p6tsfOsluOoupOTmqzuiQM538XWAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carfax.org.uk; spf=pass smtp.mailfrom=savella.carfax.org.uk; arc=none smtp.client-ip=85.119.84.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carfax.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savella.carfax.org.uk
Received: from hrm by savella.carfax.org.uk with local (Exim 4.98.2)
	(envelope-from <hrm@savella.carfax.org.uk>)
	id 1vFxLm-00000003KQe-3lrd
	for linux-btrfs@vger.kernel.org;
	Mon, 03 Nov 2025 16:24:10 +0000
Date: Mon, 3 Nov 2025 16:24:10 +0000
From: Hugo Mills <hugo@carfax.org.uk>
To: linux-btrfs@vger.kernel.org
Subject: Re: Kernel backtrace and hang while replacing dead drive
Message-ID: <aQjXKmuW7FUjAIu5@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
	linux-btrfs@vger.kernel.org
References: <aQjVnfVTSjtOtosd@savella.carfax.org.uk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQjVnfVTSjtOtosd@savella.carfax.org.uk>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing

   Wait... I just noticed the kernel version on this thing. I don't
know why it's so old. Ignore this.

   Hugo.

> Nov  3 15:56:16 s_src@amelia kernel: CPU: 5 PID: 1939101 Comm: kworker/u16:8 Not tainted 5.19.0-2-amd64 #1  Debian 5.19.11-1

-- 
Hugo Mills             | But somewhere along the line, it seems
hugo@... carfax.org.uk | That pimp became cool, and punk mainstream.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                              Machinae Supremacy, Rise

