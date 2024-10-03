Return-Path: <linux-btrfs+bounces-8513-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4B998F50B
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 19:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8125B21A6D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 17:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1EB1A76D1;
	Thu,  3 Oct 2024 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b="FxsogXzx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UC5Qm63N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D390119F46D
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976419; cv=none; b=cFpdSSeobxT9+M6crpH6TrA+q7j/RfhFEyL8ZDIm6UrSy2MJYkwyxjLIP8N0j/e7cp+MM5chOPtB+Vns7wDFrxKUzszIsqM8HxpTOyLfgKjoeowUA7z6WdyRNdfOcs4ci2vIghEftUYEMbNSKAK2+1pOpD7F62dqi53a8KccbDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976419; c=relaxed/simple;
	bh=k8wXV3VKFIDHF1HGVYVXf6SEDblRf1T3LpUAm0inzNA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=U8twNvO+7nBmhW7gguuH/S+slQZMCuIXIh8gbeH10fFAMJvos82PVlbSdo0M88GodR/oNQdbAHWiK8vOGULfuKj9M3KY5jfHIao34IHDPcjerQETu7vBDMscIu/YPFX5i6gnPoW/TFMTo9BO1STNFfF1tbSBL+B5vtHjowGSOxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=georgianit.com; spf=pass smtp.mailfrom=georgianit.com; dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b=FxsogXzx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UC5Qm63N; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=georgianit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=georgianit.com
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id D94F11380128;
	Thu,  3 Oct 2024 13:26:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 03 Oct 2024 13:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1727976415; x=1728062815; bh=k8wXV3VKFIDHF1HGVYVXf6SEDblRf1T3
	LpUAm0inzNA=; b=FxsogXzx21v3MHUzHm9OXxXTbd88I7bMWHuRZp6INUfwv61K
	jZhLBz812LAw1DKDA9eZwUmWN0FvI9A0a3uMCWXt5i6qfsNJ1OVj+BiJHugaT2nV
	Bqct8DJpl7esQgus/OqJQkg9owcFONZsfFGUC6UOlkchXBI6ANeTfte0c0syYBOl
	6IBZGUnN6c8wkZtcB8aO79WfT8PgRNuy+Edc1KLmZTnoZplR56kB5HGz6XcTv54d
	k0p0jacrHjFi4ELhaBpbEAhFdBsuceCquPU9dH9M0ykTq7FlCPIhqHaBEuCsxOzV
	3z3IE+hE1rlIDjtGXP+iimGlyo+eWRsuKKm/7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727976415; x=
	1728062815; bh=k8wXV3VKFIDHF1HGVYVXf6SEDblRf1T3LpUAm0inzNA=; b=U
	C5Qm63NQaXmyIhhLYSHoXFCwMLVcd1REjgS76Byn/49d2oaQ/8rtsA7MqMZGUU1m
	/3ICEoqpy2uJXgAPU52LkZlJw1jW8EcKA07+0fNenoFEORv3hgUkXnoPLGAf5cha
	scxi6gAYJ48iS0WN2oYqcZ+4hc/lSdGzN0dnN8OZNtVi5USd0qrhRujjT1McnKYg
	DZZjUHcGBfp9n/ukTtaTUrpqc2dX3/WjR7rYbE+XwNdUIR4Zbd9hA+6p+N0Sdsj0
	FDZcj4/d2tBcOu6hy7zsaBAj4H2aE6whZvwkgucL2tWlQzhbNzKyy07ukIECOto2
	KvwGbSTNINGUo0STXZfvA==
X-ME-Sender: <xms:39P-Zv9_ZoVpIBaukaMGR_fWQW4VIc1lKz6H8SLDFlSoUoXdySIIEQ>
    <xme:39P-Zru1rUxqLNuSsvV5ja8qwNeKDfWQFrq0asuwufmaF_suFHPGCbzDnUkONeEeI
    2rmWyvoNTGjNthRMA>
X-ME-Received: <xmr:39P-ZtC6AGF2WmBrRnQBvNA_0orU0ovYR16y8hunT11YiJwPlv9i5cWd3tCJK9CWY4RyWN5MxWWcDUjRK9du0qCnkd7-6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefuvfevfhfhkffffgggjggtgfesthekredttdef
    jeenucfhrhhomheptfgvmhhiucfirghuvhhinhcuoehrvghmihesghgvohhrghhirghnih
    htrdgtohhmqeenucggtffrrghtthgvrhhnpedvvddvfedvieffgfeugeeitedujedtudfh
    heehfeetfeeggfdtvdelheehveduteenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgtohhmpdhnsggp
    rhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    gsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrvghijhgr
    tghksehinhifihhnugdrihht
X-ME-Proxy: <xmx:39P-ZrfWydGbWxgcSNpCilR7lEqk0fV2p-jDtoyhlRyoZFwgvwvBIQ>
    <xmx:39P-ZkOa0IhoVHTv_aR3E6MPPO2xXGY-hGVwWe7M9AzzFAT6KYcACg>
    <xmx:39P-Ztl8FHxaeuQYllKV_EbLB6KOLMDNip4lQRhsozqG1VbLXG2IRg>
    <xmx:39P-ZuuvjfXdhCv0DOnc2PIncw9kuqwyJ22bAjANvCJv-r9ofrndYA>
    <xmx:39P-ZtaMLdjrLlAD3n6IkoTY9TYDXB42PDTOTohLGch-x3zmQP2tkq5a>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 13:26:55 -0400 (EDT)
Subject: Re: BTRFS list of grievances
To: kreijack@inwind.it
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <aebe9671-6f44-9d20-f077-b19e09fa1fcd@dirtcellar.net>
 <4f672a82-28d8-490e-bdce-e794748d41fd@libero.it>
 <401088cf-85c0-4ea2-bc4c-b34138eae5e9@libero.it>
From: Remi Gauvin <remi@georgianit.com>
Message-ID: <8236a191-88d5-b2bb-2048-87b49539a8a3@georgianit.com>
Date: Thu, 3 Oct 2024 13:26:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <401088cf-85c0-4ea2-bc4c-b34138eae5e9@libero.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US

On 2024-10-03 1:10 p.m., Goffredo Baroncelli wrote:
>
> $ sudo ./btrfs dev stat -T /mnt/btrfs-raid1/
> Id Path      Write errors Read errors Flush errors Corruption errors
> Generation errors
> -- --------- ------------ ----------- ------------ -----------------
> -----------------
>  1 /dev/sda2            0           0            0              
> 763                 0
>  2 /dev/sdb2            0           0            0             
> 3504                 0
>  3 /dev/sdd2           13           0            0             
> 6218                 0
>

I hope that's a made up sample and not actual output of your
filesystem.  Otherwise, you have a problem...


