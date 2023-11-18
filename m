Return-Path: <linux-btrfs+bounces-180-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC3B7F0127
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Nov 2023 17:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28C48B20AC2
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Nov 2023 16:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534DF4F886;
	Sat, 18 Nov 2023 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b="0jww+iFV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bHMXw+iV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A319E1
	for <linux-btrfs@vger.kernel.org>; Sat, 18 Nov 2023 08:34:37 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id E42545C01C4;
	Sat, 18 Nov 2023 11:34:33 -0500 (EST)
Received: from imap45 ([10.202.2.95])
  by compute2.internal (MEProxy); Sat, 18 Nov 2023 11:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
	 h=cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1700325273; x=1700411673; bh=ju
	Ar1v2JCDycVo7/OBi7lOoa0iau35ar8waEf3Xp8bY=; b=0jww+iFVemUQbJhC/k
	eVbA6eImPUZDay5rCYdktwd+YLXWn9yYTWzNdyABTkisgpQffoHIEp1rxnc/9eKt
	gvWufr88oMW5EQFQY3ewT+cVeaf2RvZ0Zf/YmklKD48yXrg0gdvd4y3pBngd4XEp
	2YmNw+EzhDpXP5dt1XmvipV7bOzP6/o7Oa/ZQLHq1g5qkdZoe6//91N3D8ySL1DY
	Oda6qFSdumc+hVmNTr2o1ehx//TJgZ1k66veB7SGJQ5bMqfjVmZG8lhelZvwcQdw
	xW1fh/1yMKGndsxgyXd3O4reRfA1LUT0mU1qLi7104q6ycZt8SI5zZ9JzlkOLu/m
	7Kaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700325273; x=1700411673; bh=juAr1v2JCDycV
	o7/OBi7lOoa0iau35ar8waEf3Xp8bY=; b=bHMXw+iV9I7j9ylMlZ/llPE6nummX
	hBkBdiFn6Qe7dFZyRE9dJ0zZVRgcZf3JYjcVrrztTQZwYRWdWarzFG7+hrSzoKys
	W/36OlX0YNtDViucq9ehR3DqZfbSaeF56ytptDr35XRuZ+xmCpRrv/Gx+epa3Cs5
	mY8ZSJIeHPQ/bYMg+NSVD7hI5x53TV2DFur4KxzPwcfS00+9vXhvo4zE9RwjUlI1
	hVI7B62MoFWQuqKI1tFd6cPyQuzkYYAhSzlSJFnDZoXoKcxfeJuk7e2GMap4sLrT
	OgV1ttBgBhlJ5Ebop4p+BeHTlajd1TUeqw2pOQgPmnCbH9O+Ih8PXEN0A==
X-ME-Sender: <xms:medYZTK3Ck0xioOxMJWRKYRKTe0eP3ZN0P0OekmEld-82pqAE_O2EQ>
    <xme:medYZXIINfRQ_F60fA6PhlN_8K4Yg-jrCJ6SfyCBpAtp2KeYfmJbxvpgAgvE3FylC
    arHenskY73LzfB4mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegvddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomheprhgvmhhi
    sehgvghorhhgihgrnhhithdrtghomhenucggtffrrghtthgvrhhnpeeugfefvefgudffke
    duhfelvdeifeeflefgkeegleffvdekledvkefgvddujeffgeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnih
    htrdgtohhm
X-ME-Proxy: <xmx:medYZbtcozzXZOee1E7iKjwYtrobXe0EBASKAXJuJr0nGauHJ4oj6w>
    <xmx:medYZcbpJYLoX4aWJ7dwpGabvsi0ioNWdId788JeSFo3yjwqmuKvfA>
    <xmx:medYZaYx-OzXAT2U1l1_1LyDVCryxNLpLCdFUBMvjdxkNdGK7iQV9Q>
    <xmx:medYZY0XU-HpbuSw8cTlHnuBDfF2lKJaE5bnB-ZiM0DPKgWheDVPpQ>
Feedback-ID: i10c840cd:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8A63D272007B; Sat, 18 Nov 2023 11:34:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <60fb34fb-ebfe-408b-b787-c62c6a1b5cd9@app.fastmail.com>
In-Reply-To: <95096727-a472-4c0b-a16d-de53b0f66ff6@libero.it>
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
 <47f08d62-3fa2-4baf-9425-17d1f119ef8d@datenkhaos.de>
 <fa4814bc-6f59-46f8-bd1a-d79f4020a2fa@gmx.com>
 <5f6ff1cd-dd64-b88d-e814-39ba3b23395a@georgianit.com>
 <5e33baee-80ef-421c-9e88-d1d541461469@libero.it>
 <59b6ad3e-c16e-4a29-abd4-4d6f57047155@libero.it>
 <65b3acc5-0aff-a7e8-142b-4ad40c60f3dd@georgianit.com>
 <4bf1d0d4-6fc3-434f-8166-7a628d48d52f@libero.it>
 <9f955c4a-82be-98cc-6f61-ee5469c32ba2@georgianit.com>
 <cecd43db-da2c-4558-b343-4faabacdf0d8@inwind.it>
 <CA+H1V9xqZT7L0tj3JTyJscXLKw-tpSE0qNULbg4hn0wYq4fhxw@mail.gmail.com>
 <CA+H1V9xA8_3-BYkhR2ip0v1_-bKxWY1hHW1kRwoxhaCNu88PYQ@mail.gmail.com>
 <95096727-a472-4c0b-a16d-de53b0f66ff6@libero.it>
Date: Sat, 18 Nov 2023 11:33:59 -0500
From: remi@georgianit.com
To: kreijack@inwind.it, "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: checksum errors but files are readable and no disk errors
Content-Type: text/plain



On Sat, Nov 18, 2023, at 3:22 AM, Goffredo Baroncelli wrote:

>
> dm-integrity+dm-raid is not different from the default BTRFS config
> (COW+CSUM). The point is how bad it performs.
>
> It is not a binary evaluation, it is a trade off between reliability
> and performance.

But this thread wasn't about performance.  It was about BTRFS CSUM being in such bad state, turning it off (at least for some files) is the only suggestion for preventing spurious errors.

