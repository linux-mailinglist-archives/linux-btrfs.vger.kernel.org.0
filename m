Return-Path: <linux-btrfs+bounces-2453-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBCC857D7D
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 14:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550601F252F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 13:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6807F129A73;
	Fri, 16 Feb 2024 13:17:00 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-108-mta200.mxroute.com (mail-108-mta200.mxroute.com [136.175.108.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8851E4A0
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089420; cv=none; b=qeWVJV5wmFLKp2SASLg8GolMLzjn5qtx96Vh9z+jFP78sYdYsEHha3lyKpLluzImtDT568cwHgyKe7P3V0Jh6F/699EGSUT830to3PDG464DKZDU5azFr9V7oU3FqH+dL5N00jVR7AxyPYnmL9TaE/tEAGBbrq7f0ZpIpIoKjX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089420; c=relaxed/simple;
	bh=ZqYUC5x+3LbFZ/hwYsYAxj3D6AKVen8ilufKMCA5pJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6zghPScjWq01KyTbLz/ZCcCRdMifD8CkFvwxzjuN2Sn24RCFs/L4NPeK00wBQl17H2huZb4npafjmuFPyfXCwVISlUhP6kQFLOEd6htqWKONkfazWtUHbfd6LpDZ5XDs3jBFB0caPquSvS6D89i8JlNZ7ocJvq4fG0cplxqUS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=136.175.108.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta200.mxroute.com (ZoneMTA) with ESMTPSA id 18db20b4b020000466.003
 for <linux-btrfs@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 16 Feb 2024 13:11:41 +0000
X-Zone-Loop: 7b71da3fbfe350f4d4988056588628cfca4b37d08540
Date: Fri, 16 Feb 2024 18:11:31 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Dorai Ashok S A <dash.btrfs@inix.me>, linux-btrfs@vger.kernel.org
Subject: Re: incremental stream after fstrim on thinly provisioned disk file
Message-ID: <20240216181131.464f7c36@nvm>
In-Reply-To: <CAL3q7H6tvCTdwrCXZ0tgOfkHhF=VWEW05_u3vr_rVv0u_PvvXg@mail.gmail.com>
References: <c0bf7818-9c45-46a8-b3d3-513230d0c86e@inix.me>
	<CAL3q7H6tvCTdwrCXZ0tgOfkHhF=VWEW05_u3vr_rVv0u_PvvXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: rm@romanrm.net

On Fri, 16 Feb 2024 12:37:10 +0000
Filipe Manana <fdmanana@kernel.org> wrote:

> cd thin-mount/

If I'm not mistaken the OP does not cd into the thin-mount, and snapshots/send
are made on the outer Btrfs containing the image file.

-- 
With respect,
Roman

