Return-Path: <linux-btrfs+bounces-3200-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF50A8789B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 21:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6535E1F2239D
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 20:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808F254FA9;
	Mon, 11 Mar 2024 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dcG1ZRBQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E743AAC
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Mar 2024 20:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710190266; cv=none; b=p6HE/iiPCnDTbQaPLeBxwzX12v/8nk/SD7YlE8e7wTqpRpGMZmb8WHzMuGmNQFWS7IeVjZpY5MuhnEX3kRLBXZwdkIeg/RsAFwOL2Mali2gZHafsMz9b+vBOxLQfIiT3czlIyaUvkAWxKKYZkostAqxQEra0PwBn/afS6XSG1sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710190266; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kGryc+JeWsp6xtK5Kh4/8vPz3vlY1Q1Oqye+K80tq/RnCiEA8HyhKccfr1Efy0Y9T7+urSkuGLc3Z9C4IT/W/96s/oX9rxfmA85oK94ndbe1Ta1XpJJnW1UDKTMLayvfwDGP35kV3Tqky3EqRuH0b2cevZjL1B3E8IByWeLA+UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dcG1ZRBQ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 11 Mar 2024 16:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710190260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=dcG1ZRBQcLZmT76Th3z0ZDHaO1VoWS8kwtes+UHuJK/R1U8ImYDMfBK3WUqPfH8QFMlyPi
	C5oSChnMfXPE+U6FcA51V1Z2jg6syjAd1ZxdH8wUGwNG1VVDPzk0sWMSbkBbbl+GfTc3AP
	Vl0PvO5lKkZ72p62Lav6zjgd3+hdI0E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org
Subject: more on subvolumes
Message-ID: <76j2jzc7zwuvfl4nlyycoufp75nkwwngho67rwz6ipg26lnge6@66olqpcffwa5>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT



