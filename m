Return-Path: <linux-btrfs+bounces-2527-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B481485ABC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 20:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 504CEB2166F
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 19:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC324BABE;
	Mon, 19 Feb 2024 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="K7rWX3Uf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72341A82
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708369645; cv=none; b=kXhE7wstkcw+ZP3Z8UkKQM8ekhR7zZKqXOKptOynJXzrAjU7OjFMv9wFcp0H+4+GRh9puI4yxEpEZeHUMrJtykEn07p3dl7JlU2FxeoFYOOFzKyhcUf/fk2eNcCv0qj5riTd4bT1GEQDf4WdPPAwqefbd8vKM3GrJmdfP5bytes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708369645; c=relaxed/simple;
	bh=0PZFoDpgMk/2WU5pGwHLz9Ci4bxC5APke/QbCGbt1WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PVQ9tBbk84mi3/WXes+6LdfClWiwGN0pq91ZiMt3xWCi5vK7dDiSI5ITF5ffFqNYZAIrbT5ywrVY7Hrn6CFHlEP1eeu5dwd7wUcrfi9t7F9PqNe0ga1svyqQPQ0AHLtnYiCKzq0PyvLr+f6ua362jWwM+wTSLuVFulGtVA8LGUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=K7rWX3Uf; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id C2E99827D9;
	Mon, 19 Feb 2024 14:00:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1708369202; bh=0PZFoDpgMk/2WU5pGwHLz9Ci4bxC5APke/QbCGbt1WE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=K7rWX3UfOUXp73mxetk5GDK8jnmna6u8BmrGpzmOZ2WGQqH+UOaE98pl4VW0WqeeB
	 pj6tTdFciJxehw/+PV8+PaQA1v0hKOfTE6CjrMg9gZdlKEUREFObBAEgbJ59Pce620
	 UA/d8a3xRwDkT2mSvm7Cl+j1gReZ3GyZB9owZVK0IPhVpmGwwqqrSBfjrYp/8+bopI
	 PijTkbanUAF90qIi3EVNpUPrhQJgsP5yHSXCsI99VGqqYQRLjPD94C1jP4aK4qtrol
	 4T1MJkvyq22WcQZdyLay2WW2vlwm3Y3RZSCCF4+yilpPN+Mvo4js4h2Xxv5KCPGCey
	 E5oYJCU1cvL6A==
Message-ID: <9e08b071-63af-4ad1-975a-7fe68902ca7c@dorminy.me>
Date: Mon, 19 Feb 2024 14:00:00 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] btrfs: some optimizations for send
Content-Language: en-US
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1708260967.git.fdmanana@suse.com>
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1708260967.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/19/24 06:59, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following are two optimizations for send, one to avoid sending
> unnecessary holes (writes full of zeros), which can waste a lot of space
> at the receiver and increase stream size for cases where sparse files are
> used, such as images of thin provisioned filesystems for example as
> recently reported by a user. The second is just a small optimization to
> avoid repeating a btree search. More details in the respective change logs.
> 
> Filipe Manana (2):
>    btrfs: send: don't issue unnecessary zero writes for trailing hole
>    btrfs: send: avoid duplicated search for last extent when sending hole
> 
>   fs/btrfs/send.c | 44 +++++++++++++++++++++++++-------------------
>   1 file changed, 25 insertions(+), 19 deletions(-)
> 

For both:
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

