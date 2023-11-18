Return-Path: <linux-btrfs+bounces-185-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 196D87F038C
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Nov 2023 00:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73EA280F6B
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Nov 2023 23:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7295F2031D;
	Sat, 18 Nov 2023 23:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A76B6
	for <linux-btrfs@vger.kernel.org>; Sat, 18 Nov 2023 15:16:45 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9DF0980C88;
	Sat, 18 Nov 2023 23:16:44 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id E6E5C8249E;
	Sat, 18 Nov 2023 23:16:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1700349404; a=rsa-sha256;
	cv=none;
	b=gfhjz4wZ/Az9HzvQAJ6cG1CwKhg10f/s4sXW4jSayS4+u/6dNtpXeVa1uY5OR5VEolWSjZ
	oM2tsGhnxWgw43+9s7JpDPDlJ4IHx9op5oDSzy9avUIKYPO+XziwXCMpvbE/ghPSCv864M
	GcyPe7HJ4dXOz/PLhRLjkSe+4dAjO/u5O2Z4s9Q4sGO+BH3dNj41seO2kUwHKx25BDI5Zn
	3Xf4JVU/1wljHzahaylzn/XHDlaH915XkZ9DVeT6NE9jsXPxt4N6wLC06QfV6cP9MUlaLd
	XEhD2Oh4qvPgxOVcv6ZcMo55AqflAjIEwKACVJeEHBt/i5EsO9wKwEYj/rO4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1700349404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4vwd+o84aeSiGoh6Bt78uPagJMd2PbmpKo2PzGvhZ8=;
	b=EaIKmIZ6IQzvXMCRtc/pGyhWUbalhQBITnNNDBNHAoot7C+BtptzfazCQdgl1mPeMc85a0
	Gwc7xrkAEZlD2hSGKZ8JfOUEuO43N/VO7H7DMjny6/CCOBbuFa5FPin2qGMe5wfkVyTslS
	/cE8vb36VFAI6TZMB7Iw0FJWSRqyF13+6gmzS4hlEVeFRS0/jaSzRq4Hs3oyxKW5rh/G38
	I1ds7DMMccBOkUbVCUD9mjXrkyMwkAeGPYTuMgRrRYMa6s9gRstzasiA5W/opvj2A5ogoP
	9uJh0yHNdYJqyu6BXuaqDB/5FwdjXBo6ExTuirRZrHCkvRHELo7cgHuv7IHLYw==
ARC-Authentication-Results: i=1;
	rspamd-55bcb54c45-zzrns;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Power-Language: 2160c98a7fc98850_1700349404459_3916543011
X-MC-Loop-Signature: 1700349404459:3435357110
X-MC-Ingress-Time: 1700349404459
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.117.100.100 (trex/6.9.2);
	Sat, 18 Nov 2023 23:16:44 +0000
Received: from p5b0ed26e.dip0.t-ipconnect.de ([91.14.210.110]:47750 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1r4UYK-0008FE-1o;
	Sat, 18 Nov 2023 23:16:42 +0000
Message-ID: <e713409c7a72e0b2f8ccca5a99b71115df0a694b.camel@scientia.org>
Subject: Re: checksum errors but files are readable and no disk errors
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: kreijack@inwind.it, linux-btrfs@vger.kernel.org
Date: Sun, 19 Nov 2023 00:16:36 +0100
In-Reply-To: <31ab3d6b-5a15-4cec-8ad8-b928c6502b9c@inwind.it>
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
	 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
	 <47f08d62-3fa2-4baf-9425-17d1f119ef8d@datenkhaos.de>
	 <fa4814bc-6f59-46f8-bd1a-d79f4020a2fa@gmx.com>
	 <5f6ff1cd-dd64-b88d-e814-39ba3b23395a@georgianit.com>
	 <5e33baee-80ef-421c-9e88-d1d541461469@libero.it>
	 <15a0b5f85425163e39edb7f2c5d9878a847754e7.camel@scientia.org>
	 <31ab3d6b-5a15-4cec-8ad8-b928c6502b9c@inwind.it>
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

On Fri, 2023-11-17 at 20:10 +0100, Goffredo Baroncelli wrote:
> I am not sure to fully understand what you wrote. However:
>=20
> - COW has bad performance when there are small writes + sync

Clear.


> - CSUM need COW

Not clear.

Why can't we e.g. calculate the csum, write it and write the data (or
vice versa)?

Yes, it won't be atomic, ... but isn't that only a problem in case of
crash where one is already written but not the other?
(Maybe that's the point where I misunderstand things)

And in such crash scenario (with nodatacow and the current no csum) we
won't be anyway sure whether that particular data block would be
completely old, completely new, or anything in between.

So the only case where we'd loose something is, when the data was
actually written, but the csum was not (and we'd get a false positive).
Yet, we'd get the csum protection for all other cases (bit rot, cosmic
rays, etc.).

If that's the case, I'd rather be able to have a notdatacow+csum mode,
where I live with the fact that things may be uncertain in the case of
a crash (with I on my systems experience typically very rarely).

What would however be needed is a way to manually recover from
data/csum difference. That could be a scrub (which allows one to choose
whether to simply re-calculate the data or consider such data damaged),
could be a mount option, etc..



So I guess my main point/question is:

Why can't we have nodatacow + csum, other than for the case of a crash.

And if that's the only case that would pose problems, is that really
worth it or shouldn't it be users choice.


Cheers,
Chris.

