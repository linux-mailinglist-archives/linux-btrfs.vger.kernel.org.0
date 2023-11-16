Return-Path: <linux-btrfs+bounces-162-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548CC7EE8C0
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 22:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8009B20C04
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 21:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E196928E15;
	Thu, 16 Nov 2023 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26D4194
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Nov 2023 13:25:20 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 01F4E140F7F;
	Thu, 16 Nov 2023 21:25:20 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id EE75914183E;
	Thu, 16 Nov 2023 21:25:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1700169919; a=rsa-sha256;
	cv=none;
	b=RgMR+IJjzxmC/3o2W+NvyLqQlWZZ5isd0r0CJw54zx7l38E4YoBodhZgtTz2eOzqunVYS8
	4nRYoP13Bqh4tv75akWNE/41/beR044gBbsqf8tS0OUaGCXs2Snkprs/UOzwsjkDlGD9W+
	+TBb8DE9nJkm9UmdOhw9S8dsuhFoOwEdNwhBfoNowbjbwjOGSwtWREYHppKQDY0K7NwDVp
	RNQqMc2OuND2nyAjTABlvsvdCOwoYuo5m+eFZkKN+zeHohadq8XnGg9NRPxnTGslD2k5UH
	nZP1fNe/rBAthloJiXoLlhNIyjc/hv7E+JA1wNA8UJBMJ8R3PDPfXi3c/7dX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1700169919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lkc4tVTRYU4mp5GES8ggV75S3IzGTDDt6OnOhJHExIk=;
	b=JswiQhlq3NkMco3UAlzaYZsnUoleT2B6XL8sGgKX5sd+JzlpfIA2mxAMjDagPirOgftT0V
	2eOD8Kut8T2P3RRNUfFIfE+8V2iJkDVtcKy+RQU2KFtspLmfmCTtL3JCpWBbIrlgxZvaLn
	E5HLZ6wWfhUg9WOODfSAhVQDz2zSeBsv1GsLDbViTP/tTkJhHC1q2pvhexZHrHy9K2mZPh
	59wCFZx2J/VvDj+9nnlzKYBCp07E1G33HxipwXG1s2cpUcFx22K1FvnBMbiYb1jC89dFuN
	ayS0wOLqBe8V7YkqHYBpGtCJNeikQ5KMgvkLflyL+IJ35TPpF3Dj7imONyBBuw==
ARC-Authentication-Results: i=1;
	rspamd-7f8878586f-ztkdz;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Chief-Robust: 46ac51e301b3b220_1700169919530_141280621
X-MC-Loop-Signature: 1700169919530:1348559542
X-MC-Ingress-Time: 1700169919530
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.110.238.199 (trex/6.9.2);
	Thu, 16 Nov 2023 21:25:19 +0000
Received: from p54b6da28.dip0.t-ipconnect.de ([84.182.218.40]:50750 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1r3jrO-0006Qi-2s;
	Thu, 16 Nov 2023 21:25:17 +0000
Message-ID: <15a0b5f85425163e39edb7f2c5d9878a847754e7.camel@scientia.org>
Subject: Re: checksum errors but files are readable and no disk errors
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: kreijack@inwind.it, linux-btrfs@vger.kernel.org
Date: Thu, 16 Nov 2023 22:25:12 +0100
In-Reply-To: <5e33baee-80ef-421c-9e88-d1d541461469@libero.it>
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
	 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
	 <47f08d62-3fa2-4baf-9425-17d1f119ef8d@datenkhaos.de>
	 <fa4814bc-6f59-46f8-bd1a-d79f4020a2fa@gmx.com>
	 <5f6ff1cd-dd64-b88d-e814-39ba3b23395a@georgianit.com>
	 <5e33baee-80ef-421c-9e88-d1d541461469@libero.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Thu, 2023-11-16 at 20:50 +0100, Goffredo Baroncelli wrote:
> nocow means nocsum, then the system cannot tell which is the good
> copy.

What I never understood:

When doing nowdatacow, then one cannot have data csums, because it
couldn't update both csum and data atomically, right?

But doesn't that only matter in case of a crash (and then one wouldn't
know whether it's the data or the csum that's good)?

And shouldn't it be possible to be made work properly in all cases
where no crash is involved?
So for all cases where corruptions might occur, except for the single
case of a crash, one could still have the benefits of checksumming.


If so, I don't quite get why it's not made possible for nodatacow. The
worst thing that - in my naive understanding - is, that on a crash I
wouldn't know whether the data or the csum is correct.
But that's that's anyway the case with nodatacow and a crash.

So one would only need a way, that, after a crash, allows people to
choose whether they want to ignore the csum and take the data as is, or
rather get an EIO if the csum doesn't match.


And again, naively thought: since we do have the generations...
couldn't such a tool, just work on all data that has a recent
generation, or if that doesn't work, on all data that is nodatasum?


At least the last time I've checked, most typical users of notdatasums
(VM images, DBs) either don't support their own checksumming at all,
don't have it enabled per default, or have only some level of
checksumming.



Cheers,
Chris.

