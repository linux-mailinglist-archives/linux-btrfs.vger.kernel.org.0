Return-Path: <linux-btrfs+bounces-12746-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE645A78779
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 07:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EA43AFA8D
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 05:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1243D1EA7E6;
	Wed,  2 Apr 2025 05:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="f29dMXy+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDD72AF10
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 05:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743570094; cv=none; b=RqEAEl/Lwg5dUks6/ZZd+n9TsORWSTKdlwvBtVUOHj5Etvg1CvxLA/08cAPDzX9raIR/GWVv9+2siU0fQpnWCcuLQlWjJce2KCvTuwNVOCpTceKgm/S3O/xRmJiTVANXAeZjR/4KFjZ2nPjLa2em0jbmsyBMjeSxjf9RbYar2p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743570094; c=relaxed/simple;
	bh=F6fyUlD5KdP/I6+FimWyrYeTajfoXzNi8whVtXuY0UY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lszywra1MyFp0n9jZZ8n9J3gO7ae6SQUIKOTDd8KjO+yDIB/p8C5snHJjx7m1cImLdswpRHXe0drvgO7SSRMZf4IINE933jGXv9S1JBFkiWXkFP8rp5NDQPa5lUIArw8mn6UYQeI/BkDD9WgPhQR+5E2xSVJEODDBcOTBOAuYOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=f29dMXy+; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1743570089;
	bh=O9+CeghJl5zcXr2kmV2iJI6uHKeWogYkRNMCMQV76oc=; l=351;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f29dMXy+QkbHRVF6hV9CkXVAP1xYeOem72MN2Jf1AcK9XA+VYFVChug6M/nCVmcaH
	 bVfadirzKrwB4W/jGvmGrv73mvJu8Imc73zSjH69BUClYFkjn580Gq8RRNbGH1jZkE
	 lMuqLyrl+ZjIJk4RWv7EHeDO+l76ahpzVfBKu4ms=
Received: from liv.coker.com.au (n175-33-160-16.sun22.vic.optusnet.com.au [175.33.160.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: russell@coker.com.au)
	by smtp.sws.net.au (Postfix) with ESMTPSA id 84864F0EA;
	Wed,  2 Apr 2025 16:01:28 +1100 (AEDT)
From: Russell Coker <russell@coker.com.au>
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
 Chris Murphy <lists@colorremedies.com>
Subject: Re: BTRFS error count 754 after reboot on Debian kernel 6.12.17
Date: Wed, 02 Apr 2025 16:01:22 +1100
Message-ID: <3727332.yKVeVyVuyW@cupcakke>
In-Reply-To: <70f5d224-f302-4664-8018-d37c06c9048b@app.fastmail.com>
References:
 <3349404.aeNJFYEL58@xev> <873501505.0ifERbkFSE@cupcakke>
 <70f5d224-f302-4664-8018-d37c06c9048b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Wednesday, 2 April 2025 13:42:32 AEDT Chris Murphy wrote:
> What happens if you use `btrfs dev stats -z $MNT` and then reboot?

I didn't try that and after I accidentally removed a different device the 
problem stopped recurring so I can't try that now.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/




