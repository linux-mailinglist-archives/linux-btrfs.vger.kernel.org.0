Return-Path: <linux-btrfs+bounces-8949-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 651A299FBF7
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 01:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6E11C25963
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 23:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5273B1FE0E0;
	Tue, 15 Oct 2024 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="eDzau4+w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kpq/zwtk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F031DBB24
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729033200; cv=none; b=Zm+x789E8bZK0PpnD/twuPG1wPwRaZcySuPNB9RpzL6Vy0Q0CVfnWYWH4rpVjcByc9x4ZqYjl6Cnt1FIzRRMjG4yNzIJWAYgyPIB9UGW8Ls5Asye9z1HKXyj8g5J3o+OPeV6w+gr7I8YcMzVHYzEmQZgI9Ee8o2Ybvfk7HoyFmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729033200; c=relaxed/simple;
	bh=Qf1mNBFjJMYi+c5ZYFdfEYOpsMBUR+wN01F72MYUoO0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Dpy8KwIL6mt2KaegYfnLfGE9JCB8HxNO8AsHZDyMRcmrzXdNpWA/J8mDheGytmUymPn5S9nyj5n1RXudZrsVFvHQ99BzBx6cRPldIsJz5PYxB/vU7gV+boZFHfnL37CJrq6hb5+YAOXus6eKHlrsUy7+gX3XIv0+LkpklgSQj2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=eDzau4+w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kpq/zwtk; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D9BE1380288
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 18:59:55 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-03.internal (MEProxy); Tue, 15 Oct 2024 18:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1729033195; x=1729119595; bh=7cIboP7e3LjeKR8m4Fl0Y
	+qoAcJpA7dB2g9YRrWm1F0=; b=eDzau4+wSWGQy/+58AQDyoapnqCWHA3ARqFPe
	sKjHtKOGPhGJ9U9hXdfY8RcZZwCYhu0DmlWKrS/tgEgMJCbVfA1O7DHgQblNt/M/
	7hF1YYlCMf/sMh5zOGpUa7uRb6IYAEawyPm/Ycux58eHcsLMMSEcGvFN5Z42LQ6r
	O6FVaGyKHz9dw1skq9BXvpUfdwo/7ogyi6N+Lsxe6d+dKexHpBXLx2mZ6WIQVdsH
	jVruEn2Ukyul+2cErjbrp4hpqhlZkm0aYyOW6Oz21ZKFMLGEo2Zm6Yqq/fj4FfWL
	jMZO6yN7cBgnK4bVWkIkvopcpZebqUKZMdKpvIYAEFQ1YBIXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729033195; x=
	1729119595; bh=7cIboP7e3LjeKR8m4Fl0Y+qoAcJpA7dB2g9YRrWm1F0=; b=K
	pq/zwtk8Fxla1Qetxf4oESbVqig08WJpQcdPviNcSmn2czUh9+cC4tBKrrs05z2c
	Sjgi1WyLT1lIlhdO81JZc7LTX8mJQiKXnlQftLaOQbtxVYZf6iHeMg6EwpFXv+uR
	0ACSA1aLwq5xNBhcKqMYMnqYDp5hIjPjttD+Cst2Hp88mrxl500Z3v6MYOjHZq/K
	5Wx0eSLekq8wn5qKOuTe2j2CW59STneRXNKPzT1zeQjH4SgHa8N8l7+qRk7KNU/v
	zF2sYamiVnTIjL+3QGHbkRB8+a8VJ0yy300WRJWL1SkBAxcU/nPHzXeXnBjXzhGw
	mXBO7UGs7SAclQB2Jxm/w==
X-ME-Sender: <xms:6_MOZ-lpuwtKOugGIJa2OegxaDxp0fdxZcQKUUkRp7fJjizRbz37uw>
    <xme:6_MOZ12KtVgu2DuStS7GzYDcLn4xg8dxc-jeH4uVx86i7aY3KSwNTJma3p6lfR94H
    18P8muv8DHTx8Ibeoo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegkedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdevhhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvg
    hmvgguihgvshdrtghomheqnecuggftrfgrthhtvghrnhepteefudehkeehgeekhfdvgefh
    jedvveeuhfdtgfejgfevieeviedvfedvhfevvdegnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgv
    shdrtghomhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6_MOZ8rPtwqFFeO8YRAP4g4CvX0SOG1gf246e0TDMh_SRY365cJu_w>
    <xmx:6_MOZylhDrQkBu3kYxDujWamwli21xbsmZ3Zh9a2YiWTo0fPH6DtRg>
    <xmx:6_MOZ834efF21IZh4PPWKddwZlVbkg4TiQJj1h_nVNYZmqHKKiGORg>
    <xmx:6_MOZ5u5WQpNMSwfCPzQ2N3_qzg-OzO26dJj7zChh5aoGVhL8LP-wQ>
    <xmx:6_MOZx9cPzKefERcTFgsYV5BVMWuJVD2OvHRaTL-tUj1sbgvzLxAjk4B>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 51D381C20067; Tue, 15 Oct 2024 18:59:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Oct 2024 18:59:35 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <88d5c6c9-61fc-4ebc-bf85-8dac1fb41ac2@app.fastmail.com>
In-Reply-To: <4717ca78-1d70-4aa7-bebb-d303c4ada4ca@app.fastmail.com>
References: <4717ca78-1d70-4aa7-bebb-d303c4ada4ca@app.fastmail.com>
Subject: Re: kernel 6.8.5, bad tree block start, couldn't read tree root, including any
 of the backup roots
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Oct 15, 2024, at 10:43 AM, Chris Murphy wrote:
> Fedora user report:
> kernel 6.8.5-301.fc40.x86_64
> btrfs-progs 6.8

Should be kernel 6.10 series

I reported the live USB booted versions. The installed version under which the problem occurred is probably 6.10.12.

-- 
Chris Murphy

