Return-Path: <linux-btrfs+bounces-889-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AD98107D4
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 02:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 810DCB20ED3
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 01:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1711C186C;
	Wed, 13 Dec 2023 01:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b="WNINt7rn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ueJE4qIF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC35BCD
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 17:49:49 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id ACC6F3200B06;
	Tue, 12 Dec 2023 20:49:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 12 Dec 2023 20:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1702432186; x=1702518586; bh=1F0MyOETu9nS3lhUkxXgNTume9dJVstA
	n1Qq5zw5+2I=; b=WNINt7rnooFXM1+CfilsrRPputIpQ2Im7MrDrE1qB5ti1lQl
	ThUODeoaWrBvNomr5tcGgRhODHno7YUL1xtTqH3m+AuhehebUsnVDtdAixRKozTf
	230x8X/pZg/t7FIU3FPUrAcXG1L4AcWS/Gx1QtfdKxzLcJaqJPJ9bSTKkxsfAZRz
	VXPX8N95DBo2NBWIoGmk7I5pUxeEuMdvnae6fTe/v2ztmKCMlaYDcpIxFTYXXVi2
	BSNTGhij/FT+s9x/fo6X7g8o1cc3DkgU01NpFKnezpUKuWHBLcBRPhQtBeeJFb14
	TJnoBiVRl1NUmh+cS09E+KcAFkOGD5L8vf59MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702432186; x=
	1702518586; bh=1F0MyOETu9nS3lhUkxXgNTume9dJVstAn1Qq5zw5+2I=; b=u
	eJE4qIFKIh/qkzeDUC/JEuSPW2wa5sc6f+75cdxZ5Pe0sBbfEmmjX3jVmc2S6QjD
	PdzUbzQy2+fU+/cLnNGQHegymsz3RfjYFBIybKrDCFGIlB01THyTNaVLLSp2g4kd
	mSbz+oS3wl9zdPRU4AXbWJprHbzvOSCIj+36KNRxTG15yHME4u1rFb2Aj8VAgq18
	fOCAM1155yZUE2kzx4J1g8XIvBl0ua5fawQbiykdwXwopqK51G7ZW4Lgn6VIIesy
	KrkoyZrEgCvPQDJv97wvUWYHZix/FxBmWSYuQl6FrkuPE8v2muHI63qTIT2Q/hxL
	NTR/2dn+4mx2DV2lV7grw==
X-ME-Sender: <xms:uQ15Zff3x7kbqwBwecmtvXN7lsEy_FcfleFLkGXavvKxIX96STXxEg>
    <xme:uQ15ZVOaltS6RQij0E2QEj8Nwxi7gFEEf0UCss5v7QvQStAEKXtRlkxNLrrXvbYM_
    5fKgWxX_e0IDqbj6g>
X-ME-Received: <xmr:uQ15ZYifqgjoIoIezk5oQe0vaM9HdCjesUPzBULO5-d_SgR_ldxhdAK_hakJ0UV-1NRZD6mPAWtq_NKCZK7IQNqNveU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelhedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefvfhevhffukffffgggjggtgfesth
    hqredttdefjeenucfhrhhomheptfgvmhhiucfirghuvhhinhcuoehrvghmihesghgvohhr
    ghhirghnihhtrdgtohhmqeenucggtffrrghtthgvrhhnpeefudehjeelgfeikedvveetvd
    dttdelteetveeijeduvdehheevleeltdejfeevfeenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgtoh
    hm
X-ME-Proxy: <xmx:uQ15ZQ-JPUIiBLpy17XEXxkEgH7SFf5jtnT8Oz_ZtaJNE7T5V_ziqw>
    <xmx:uQ15ZbuZbhVstQ2T3H_eNGG904CWFVkxgxOF1gBZTOqfDemI23zcNw>
    <xmx:uQ15ZfESgOFALBUIOChO5FEe7wMkHyJORLKxVskFTLj7yQK0hN8pDw>
    <xmx:ug15ZZ0lCcZNAwM3O6v8JdMEa7IoV-a7loADxNS3F2FGhDpxh1pS6g>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 20:49:45 -0500 (EST)
To: Christoph Anton Mitterer <calestyo@scientia.org>
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
 <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
 <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
 <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com>
 <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
From: Remi Gauvin <remi@georgianit.com>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
Message-ID: <2d724024-4f6f-a8fa-ace9-61c9fa348b24@georgianit.com>
Date: Tue, 12 Dec 2023 20:49:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 2023-12-11 10:27 p.m., Christoph Anton Mitterer wrote:
>
> Well the manpage warns from using on large DB workloads... I mean
> Prometheus is not exactly like a DB, and I would have naively assumed
> that at least the chunks were written not as many small random
> writes... but apparently they are.
>
> Also, this a VM, so the storage volume is actually something Ceph
> backed, which the university's super computing centre provides us with.=

>
> I wonder if I do autodefrag on all that, if it doesn't just kill of our=

> performance even more?



On SSD, I like to use compress-forced option and a daily defrag with
target size 128k to eliminate space wasted by fragmentation.=C2=A0
(Compressed extents are max size 128KB)


However, compression will destroy sequential file read speed on spinning
disks, (presumably due to the small extent size, possibly not landing on
disk in order, I'm not really sure why read speed is badly affected when
write speed is not.)


If there are no snapshots or reflink copies, you can use defrag with
target size 128MB (at whatever frequency you need.) to eliminate wasted
space.



