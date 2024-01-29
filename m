Return-Path: <linux-btrfs+bounces-1913-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F82E8411F6
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 19:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314721F258F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 18:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C816F071;
	Mon, 29 Jan 2024 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b="FWg0JvO7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y9wVh8Tq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6C36F06A
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552655; cv=none; b=fVxW9nZwTnilQwjQFrgIiUVqlmanlb5PiEmNNaaK3lIANwu7gDR6H0CL/83WIV9JC6Y/mPCFrkiF1Z5ZZOpiVcgCrkbZVegvsfejO2IcIR8jxgnXY/4QFDdpAxl1OXrvruO8glqf5ewTn7bIti1/WR25ZRty782DKCSxXqwhbnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552655; c=relaxed/simple;
	bh=1srcmXP0BjKAsAhtOABYpLdDpFOp4bdCTrVCq+5FFbg=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=r5DEsxSfj82PwJnk8zqc3KftbH5kCcU5PASMzhB1WS3auVmQY01zyPxPy6/+vOONkxmUsWfUgj0M2z1wrcoi+iVXKUXztw6QBLSeOY5L1/Y1pyfGriwSlSvbZL2TBqzB7YDWPNXp8gJPGGzrdfw/IIF74XR1EzsVEhiNVG+Ld0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=georgianit.com; spf=pass smtp.mailfrom=georgianit.com; dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b=FWg0JvO7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y9wVh8Tq; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=georgianit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=georgianit.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 1D4363200A7E;
	Mon, 29 Jan 2024 13:24:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 29 Jan 2024 13:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1706552651;
	 x=1706639051; bh=KVR/efRGwkfC8gM1YCg/+/ImouRXe8/5iQqW2y0A0lo=; b=
	FWg0JvO7ixWRzOm2R5Nar0OoiXxu8a5fjz1Lo2Kf1kCvc8UnIPqIVjpuYnU7ZOX8
	6+fB6tt0Ik0Th/SjelS0EewTCM0DwCBdBhLD3JrdRRpMgeFqW2nDPZDeyRUWw+fF
	NNaV7cH1QCb6Q8KdT5ZrvwHmUrLqOOVU8MmOGGo6TCARTQUTAGKNSFXRuFWxp1mt
	Ln6cxtm50DLaOFbwiaIurntw2Q4g9zReHbjftOEZNgLWnFdPtddxIxZMtt6glA48
	HU49CcORRjDsf5C6S60fzpyfEvV8s7kR8CccWxGj/IVRJQoaplM96EmApuZkv5sP
	Adno/39UvEmwA1+qLQVivg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706552651; x=
	1706639051; bh=KVR/efRGwkfC8gM1YCg/+/ImouRXe8/5iQqW2y0A0lo=; b=Y
	9wVh8Tqzqf86ythhkDQ0naGVEY8ThWpk0PR0a0TnY07a8XVF2ymUeS9EbE0OjsII
	79QBAR3Rfw7CJn1yPa2d8990hJU0WgIzK5Xkn19jE9IT9zvnl5hx7yFDhTMYGtQU
	YMLFq3s2ibCdk7VMn/RKg5KC42SOGjVnsWq399mhlxw5a0j3dDuyrzW6sq+W5edq
	DQ60bkk7lznsPgsgZMbl34J+MLWAdfkeTs9BkzBw/VVW3E/1AY328h8ckGDlQtOa
	rqipshN/5Js/qf9sXio7XVk1r+PobeV9nlcNVudG2iN4sK3SKlzXk9RIKpgEDA+L
	ZcIiKPGJwdofrQfGZO31g==
X-ME-Sender: <xms:S-23ZaYb1xgqe7PCMMJVrwA_TQu6rmaQGyddHlwseawZMXLypnFUcA>
    <xme:S-23ZdYFbI_MpYNjDpgjLEp3R8FuOZWflVCI6NSQZgyncWVPila0AUwsEZIfb9Grr
    SpI0i0g1OhRB3XvoQ>
X-ME-Received: <xmr:S-23ZU8Y5Qo5x6OsMYtRHtXKrPrFiFFoBiqMGuc_jzBJwhX6FRCRDYxw846wwV058BsJoi7dErkiosCK7RLdLpt88TU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeftvghm
    ihcuifgruhhvihhnuceorhgvmhhisehgvghorhhgihgrnhhithdrtghomheqnecuggftrf
    grthhtvghrnhephfdtueehgeevheettdehjeffgfetffeuudethefhveffteevhfdvffdu
    udduiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:S-23Zcq_Gac7wudv6M60PPOYsJaiyA7f1a6jzYF1d_SIVSEPkf8wrA>
    <xmx:S-23ZVrpwX4PQ9CY6QT8lTO2-39pAx8Utd7bplyh9ZT0JWui3eN_7Q>
    <xmx:S-23ZaTTFdwhu0l9-0gBfP2SGQ1v8xMbTXhAJLi5IzPZ3tHhTDCi8A>
    <xmx:S-23ZURQWW61wYrSFEsIAn_xoZ6wYVdCc7kdjWXO5bAd5rXgJuyBkw>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 13:24:11 -0500 (EST)
Subject: Re: One missing device = fs not detected; upgrade things first?
To: Andy Smith <andy@strugglers.net>, linux-btrfs@vger.kernel.org
References: <ZbfkaXaX0Wmef0VW@mail.bitfolk.com>
From: Remi Gauvin <remi@georgianit.com>
Message-ID: <3f3dcc01-6d23-4490-7b8d-98eff520bc85@georgianit.com>
Date: Mon, 29 Jan 2024 13:24:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZbfkaXaX0Wmef0VW@mail.bitfolk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US

On 2024-01-29 12:46 p.m., Andy Smith wrote:
>
> Here's lsblk:
>
> # lsblk
> NAME                  MAJ:MIN RM   SIZE RO TYPE   MOUNTPOINT
> sde                     8:64   0 931.5G  0 disk   
> sdf                     8:80   0   1.8T  0 disk   
> sdg                     8:96   0   1.8T  0 disk   
> sdh                     8:112  0 931.5G  0 disk   
> sdi                     8:128  0   1.8T  0 disk   
> sdj                     8:144  0   2.7T  0 disk   
>
>
> The btrfs fs is directly on those drives so it is expected that
> lsblk shows no partitions, but it is not expected that it doesn't
> show an fs.

That is what lsblk output looks like to me.  There is no filesystem
information in the output.  Are you confusing lsblk and blkid?

> Should I build new btrfs-progs and then a new kernel and just boot
> with those to see what happens, and then try the check --repair? Or
> should I just build the new kernel and see what that makes of the
> devices first, then build new btrfs-tools if I am still to run
> check?

I would suggest the output of btrfs filesystem show, as well as the
exact mount command and any dmesg output when mount command is run.


