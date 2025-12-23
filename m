Return-Path: <linux-btrfs+bounces-19973-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4AACD798F
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 01:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29C3A3004531
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 00:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE1131355E;
	Tue, 23 Dec 2025 00:43:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF2031327D
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 00:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766450615; cv=none; b=hh9TN65wiOgrXjIseNu+wmWpmyBE6U7SQ7QbPEs8Tf/Y5KaIKh7Ont3bUrhmcYiJlkvsnOwJOTCBw2DNqqeE1C5G/wsiPZkQdwpCeBRvfQ1fLxBz2sw0ZLe5TawFPDbFo2aGfFEx26hGK9KPSNfnRLm/0Ee5iL6X8PS12tss7s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766450615; c=relaxed/simple;
	bh=rmyDNXCRko/oESeqlZsVEKkG5xMGWxYxsMt7IKc1dSk=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=Vn+oqVPNL2Qk12Pt+gkbI+2ijydZoC17vrwCznnHmg2cleyJj9NjtOzwllO39sd1TK7Lozj3DBMvcH77Oq89aEox72kOqVKXME+4+M0wfprJfa0KimEh0iJr96IqeYpvRrK0/zE23NesbzHTE81aEZvlpYsPpsfYd8nGUYn3+Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4975E240101
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 01:43:25 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dZx7w67scz6tm8;
	Tue, 23 Dec 2025 01:43:24 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Dec 2025 00:43:25 +0000
From: BP25 <bp25@posteo.net>
To: Linux btrfs <linux-btrfs@vger.kernel.org>
Subject: Snapshots of individual files
Reply-To: BP25 <bp25@riseup.net>
Mail-Reply-To: BP25 <bp25@riseup.net>
Message-ID: <79ae6c26545c107010719ee389947c1c@posteo.net>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hello,
Can any of you guys help me understand why it hasn't been made possible 
to snapshot individual files? Because technically it's trivial to 
implement therefore I suspect there must be some abstract reason... The 
only thing I can think of is the case where some file which was 
snapshotted is then deleted hence there is no way to 'select such file' 
and ask btrfs for the snapshotted versions... but even in this case I 
see no problem: either the convention is that when you delete a file 
then all snapshots of such individual file are also deleted, or better 
there is a command that shows all files who have been deleted but have 
have been snapshotted in the past.
Any ideas?
Please CC or BCC me cause I'm not subscribed.

