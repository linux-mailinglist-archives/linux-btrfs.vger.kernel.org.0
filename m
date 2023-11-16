Return-Path: <linux-btrfs+bounces-152-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0433E7EE2DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 15:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF73428157B
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 14:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E19934555;
	Thu, 16 Nov 2023 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b="lX6qwspy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yxgC9rZi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F6B187
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Nov 2023 06:31:04 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 0DC7D5C015B
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Nov 2023 09:31:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 16 Nov 2023 09:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1700145062; x=1700231462; bh=7sfmZ+4XGYj5O5ragY6Mw7yON4NqigBluxb
	72zFgEBI=; b=lX6qwspytfzYTQM94nfhrBBOymz8ZX9QqhN8Pq97IW6M7WZu/RG
	cReSkyJr/pwCIT4LaCOVZt8XoMay8kUFrDlCu/bXoYyed49ETiwke+Ob3xj3+ewA
	6LsZsQB5jgW2jtkZeopdHbiplizJt8YXzG2Wwf37ltg2sA2Koe/S8487JeiT4myl
	f+olM2lFQXoaCNmdgWEx813DjD18GRF+dq0zdQATVtAmFCYyPFiHBcLqECh8+1QB
	MabPW33b34NTNJzgDelxtyjO8rI8ZvH3YnmuEDFJTVH3vOun0sQ42DkTqARrvVky
	WOMQ63IJlS0aIL761uesdsOQoZV9FZ69FCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700145062; x=
	1700231462; bh=7sfmZ+4XGYj5O5ragY6Mw7yON4NqigBluxb72zFgEBI=; b=y
	xgC9rZizCkJ5wz9HcHprvgi/19UictqL/8VO3TjmP7ujtZMGG5Y/NEBS07KRCw+V
	ER7fIsSGYIiB/j41A59Mn6j27czKm6kLpjsmSodEtoen8w86j9bVgn1myaeXETbn
	peuS1+sAGXEyb+P6F2yRVbmBBJlWvE0bffiJo53zT4sSii/TivcA4S5AhHkO2+QN
	ZyuMj8D95Bfkfx8kgbNwKjl7l9rjZcr9BbJy37DP4EKXbHM1SchmWjjuubZmyWIv
	ngdh4FeFQIUPxOFZNtQvLMjbqoAPAf6kXIcSO0YLb9HeTIe1h1FWV+TaihXaemwZ
	sTgN8/8N6JTC1j5/eyerQ==
X-ME-Sender: <xms:pSdWZeX6beZwa2kd_C_iANYpAk-LyIbqCgONDVI6Md8llw8CeuYZ6A>
    <xme:pSdWZamtTxXBL28hYcVCQVW3XXxQfUqGlHd3X25BCXux1ZGaPxnkFQDwPbsQWNK48
    T9YX5qAJ2TslO8U8g>
X-ME-Received: <xmr:pSdWZSYfH0aZQqNOhg9z04a4r4vpGg0L0GUik4S-BuDOaEIKrmWBBHS2vBdZOPYRFUtDuYn_8aRjrut9dAyn001GbyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefkedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtje
    ertddtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecuggftrfgrthhtvghrnhephffgfeeutddtudfhudejkeejud
    evledtudeufffhhfeukeejkeekiedtfffhffeinecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:pSdWZVXTJ8Ft6w1NiT1uIl-LwLYOy9kZ6UG_D2opZ5HXl6QN2zBFxg>
    <xmx:pSdWZYkdc8o143h1uCNTrB7qCO4qX82_1w38iQg2uorZljNqTbB6Rw>
    <xmx:pSdWZadFvyhx8GA6Jv3H_Q4Dy9OdEcKYnV96PNKdboeYvx8QORK4Ug>
    <xmx:pidWZaSMUryuQwVi7tmrUqWgs3mQMbewxDV-P-ZFMdMepkwM2jf3Bw>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-btrfs@vger.kernel.org>; Thu, 16 Nov 2023 09:31:01 -0500 (EST)
Subject: Re: checksum errors but files are readable and no disk errors
To: linux-btrfs@vger.kernel.org
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
 <47f08d62-3fa2-4baf-9425-17d1f119ef8d@datenkhaos.de>
 <fa4814bc-6f59-46f8-bd1a-d79f4020a2fa@gmx.com>
From: Remi Gauvin <remi@georgianit.com>
Message-ID: <5f6ff1cd-dd64-b88d-e814-39ba3b23395a@georgianit.com>
Date: Thu, 16 Nov 2023 09:30:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <fa4814bc-6f59-46f8-bd1a-d79f4020a2fa@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US

On 2023-11-14 3:18 p.m., Qu Wenruo wrote:
>
> Disabling COW is recommended for those VM files, as it implies to
> disable csum, and reduce fragmentation. 


Doesn't disabling COW on BTRFS RAID1 Still result in inconsistent
mirrors with unclean shutdowns?


