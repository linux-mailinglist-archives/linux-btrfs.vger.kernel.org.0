Return-Path: <linux-btrfs+bounces-19153-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D51B7C6F569
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 15:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A1B573017A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B825364EB4;
	Wed, 19 Nov 2025 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="OUdXcjmJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2164337115
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562718; cv=none; b=lxY81nRzRNGf+Vv2+RQO7gy1sH8TTpSYpBWVVCJRO+mS8zYAaofgK44Q7zehc3M2uWmKFuMGfQqWa3WTbXKSRgRZHQO1WSUJZHz0yu8KzJt544elzLGA5UMRop8cWli8tvk0qAkGAQ3TsTsQwOqds/mqp8LiezblEJxvW6hOte8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562718; c=relaxed/simple;
	bh=WF0y30lOwJrQbZwsvajti8YzXQBgfRHEAa+SMc2rfQk=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=B4zEeCZ0BH2hplsu9XEPhcZSSicj4FAnkwrptqKv29qoHMhyGQz6FrV9KpWEX0iZMyy14QWw0UeyaHPZNNBx6J2eNmy3JOmMAZLNr5srTHJ3+RBd6zQf0NdoU1O4xvKAm0mOqEldGfVFs/YEjFmvVuDNAphseYVdg1WZ5IPuU4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=OUdXcjmJ; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 28466240101
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 15:31:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1763562714; bh=pNDZLDYfKasyS16Kii7eA4RGTn3v2m6FUjHxaBpFRcM=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=OUdXcjmJUpQKkX77Z2EG34NAdsNLS4s5QAogRsjjBAp/ec9GzugLNjbS5PZsGghPz
	 SOi3tlHuTlVH9X7tUq22CqDZhEiZyh72j/NAZsf95TFi3DoEoUbuYMrQlp1oSOGc2S
	 DqR6nyZ30ojUgV/Llr0Z2y5mwTL9M6js3QNxGUX2jOpTB0g4XDK9+4dIc4j22XpGZt
	 1obAiv+FCTNZb4MOGlytDAIfusSB5TIIOhWPKte2NYXbptL7kI4S5ywdUb8cWmBDgh
	 T70IHA5mbhSKLmsOY1LLPnX8BXC3yF2D96Kp4JIs6MQ/cJnxL9k6vqVr57s1aTp+Xa
	 vn2QJXJPLBWyg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dBP7Y6SCcz9rxL
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 15:31:53 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Nov 2025 14:31:53 +0000
From: BP25 <bp25@posteo.net>
To: linux-btrfs@vger.kernel.org
Subject: How to detect ram memory going =?UTF-8?Q?bad=3F?=
Message-ID: <665d612165e1f21e681d3b1229bcd40f@posteo.net>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hello I'm writing to this mailing list as suggested by the btrfs docs. I 
wanted to ask how to detect and mitigate ram memory going bad when using 
BTRFS? Because the 'Hardware Considerations' the BTRFS manual suggest in 
this scenario to run memtest; but this is probs more like right after 
installing new ram. Is there any BTRFS tool, perhaps to run 
periodically, that can help me detect bad ram hence mitigate the 
consequences? There is a webpage called 'Will ZFS and non-ECC RAM kill 
your data?' where it's suggested that ZFS scrub effectively detects bad 
ram (when at least two copies of the same file and/or metadata are 
stored, and I wonder if there are other assumptions here...), but I'm 
new to btrfs and I wonder if the reasoning can be applied to btrfs as 
well, and how effective of a mitigation it would actually provide. OS is 
GNU (Guix) and I think can't use ECC because I suspect my X200 
motherboards wouldn't support it?

Please CC: or BCC: me cause I'm not subscribed.

