Return-Path: <linux-btrfs+bounces-8313-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF199890E9
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Sep 2024 19:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E2C281E7C
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Sep 2024 17:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A52C1494B1;
	Sat, 28 Sep 2024 17:51:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38381DDC9
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Sep 2024 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.199.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727545885; cv=none; b=aUtlaOBdSDGKRFDNPi7QVHQt6eHfLRJAdsT+RLMEKlftBb8SiciICxK2dUFVETZ34MPFMALypeZck7oO4P8Aq+iPQDRkIsGRZi2yq7mF/Fu0X1HSK7n7QhMX0sFuc7w+Dm+Ukhyy+28B7UfGLbzYGLuazPAoKBA1RZHZsgcmPFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727545885; c=relaxed/simple;
	bh=4d2JxFsnWZORYrzMMa44watkRgXCiyy6mPim/erprdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaU3ysIfp7yBBFGjqfIa7P03E3AJHqOi3hidqSl0Fu8OXeBF6FAsHC6toRcNzTZ6Ff3OiyOrmURGm6IPtmoReGEmCBhehgNyST5kvwWmyUIqbX2USaJMLhGvF5ZPxF/VKE0/fz6maraIaq2ETLBpXYVFy1ffxFrPo/XCQrkOdf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=146.185.199.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.39.romanrm.net [IPv6:fd39:a9b3:4fb1:1ccb:7900:fcd:12a3:6181])
	by shin.romanrm.net (Postfix) with SMTP id EBB693F207;
	Sat, 28 Sep 2024 17:51:11 +0000 (UTC)
Date: Sat, 28 Sep 2024 22:51:10 +0500
From: Roman Mamedov <rm@romanrm.net>
To: waxhead <waxhead@dirtcellar.net>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS list of grievances
Message-ID: <20240928225110.515c6b39@nvm>
In-Reply-To: <20240927212755.5b24ecd4@nvm>
References: <aebe9671-6f44-9d20-f077-b19e09fa1fcd@dirtcellar.net>
	<20240927212755.5b24ecd4@nvm>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Sep 2024 21:27:55 +0500
Roman Mamedov <rm@romanrm.net> wrote:

> "parent transid mismatch errors" right away with Btrfs, after this.

Speaking of which, another annoyance is that a "parent transid verify failed"
still seems to be a game over for any Btrfs filesystem (salvage data, reformat
and restore from backups), even with a low number of the transid difference.

There is no option to forcibly restore FS consistency in exchange of losing
some of the stored data.

And it still happens sometimes, in conjunction with things like USB enclosures,
faulty cables or power cuts.

-- 
With respect,
Roman

