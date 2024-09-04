Return-Path: <linux-btrfs+bounces-7810-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0085C96B82A
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 12:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5936CB23AF8
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 10:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569151CF28E;
	Wed,  4 Sep 2024 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="DD+/3kTh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C03F14658C
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Sep 2024 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445251; cv=none; b=LxCrM75opKSF0E1f2JQrQc3NQajVUpCOo3j+gjFZIwm0W+1vTO+QDQa6/QW1cCBp5/be7DqOHbEZM948rETiDyQFfaVBjqQOA0iD7WfqcxR4/uKXDr3kUpXP8I69oaujYQVi2sb+7slRhy53F0nwR6I9TDJh+fdKw0BL2dR65OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445251; c=relaxed/simple;
	bh=b4ExwQzQBqM6eyF7FoW3tCmyTPgZBTzAq6TrB2SFfCY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQ/Sf0ru+yJWXZbJdB9eybU6deRFXSIweiPXTZg6XobX/wGCbjoW7MgA9p5TQwJ+XbpovZb+FVRq2PKljJFqwiUgAMA+aAZSBqAUWz51+jOsnAZFtN2qGt+siy4YEPxQ7H7mkK9Q13t6jmcfBOiWRd7UG6C25VK7tyjg8XBRWK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=DD+/3kTh; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id 2984260D6A
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Sep 2024 12:10:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1725444641; x=1727183442; bh=b4ExwQzQBq
	M6eyF7FoW3tCmyTPgZBTzAq6TrB2SFfCY=; b=DD+/3kTh76cjvzkDjZdiO5ok5O
	skpo3zdsG3wOMWC7I3haf9Er88WU4tqeBWJEKFaaN4P1qM+Dvf4f1Pbota88RY2A
	v3BdfzaPN07aw66UGneVo4MrWkY9BLSTo2pirqagIHmlSjGlY5HLZeSqlPGket7h
	Yw2GU+Zc/OAezLv+TPoghU9rGNRkZwCV2AtJRuRFSrJjc2Y5DXfyRkjgmvfp3heA
	IhnwQkGjfm0MGaJaqc3jRfgrvmnh3XAKF34sgH0qj46F/OuGx3+hoNqZ68Avf8TT
	44v8+08/iaURA/Ox1r0mNVDJNDVw+RF7UZPv3Q3/snpYoiq7lqlBI6PnpNPA==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id aW7AHGl3xLYm for <linux-btrfs@vger.kernel.org>;
 Wed,  4 Sep 2024 12:10:41 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Wed, 4 Sep 2024 12:10:40 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: how to delete a (hidden) snapshot from timeshift?
Message-ID: <20240904101040.GA35246@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20240903132316.GA20488@tik.uni-stuttgart.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903132316.GA20488@tik.uni-stuttgart.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729

On Tue 2024-09-03 (15:23), Ulli Horlacher wrote:
> 
> I have upgraded Mint 21 to Mint 22 with "mintupgrade" (Ubuntu 22 based).
> This calls timeshift and creates a btrfs snapshot which I wanted to delete
> afterwards:
> 
> root@mux21:~# btrfs subvolume list /
> ID 256 gen 102469 top level 5 path @
> ID 257 gen 102467 top level 5 path @home
> ID 367 gen 102260 top level 256 path local/home
> ID 667 gen 102466 top level 256 path tmp
> ID 682 gen 102445 top level 5 path timeshift-btrfs/snapshots/2024-09-03_13-00-02/@
> 
> root@mux21:~# btrfs subvolume del timeshift-btrfs/snapshots/2024-09-03_13-00-02/@
> ERROR: Could not statfs: No such file or directory
> 
> root@mux21:~# btrfs subvolume del -i 682 timeshift-btrfs/snapshots/2024-09-03_13-00-02/@
> ERROR: Could not open: No such file or directory

Found my mistake. Correct is:

btrfs subvolume del -i 682 /


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20240903132316.GA20488@tik.uni-stuttgart.de>

