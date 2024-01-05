Return-Path: <linux-btrfs+bounces-1264-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AB9824E4A
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 06:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FBE286001
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 05:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3537E610E;
	Fri,  5 Jan 2024 05:52:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C346566E
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jan 2024 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 03F5E8432CD;
	Fri,  5 Jan 2024 03:30:41 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id BC340841F44;
	Fri,  5 Jan 2024 03:30:39 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1704425440; a=rsa-sha256;
	cv=none;
	b=2ofxQ5cW1e7qdO4EXU7kMsECMdNgihLuOJn00ArlEQED7UiX+rx6VH16SDCWHWYUtFJyFe
	l/RJ/s7pFYHWnHSj8V/HCtN8WrKIYaZW7izjjPIUU+mJAco+xb1QFcdb6MxKaZQiCgM6+H
	4CNY/buCvMDNhkotlakW6X1HShmKx+Cq5pe7F/qxcpsb7moY25jwkUdpTTtV/UVWiOHa/B
	STv2/xiE2LT33xZF7BTfrMpRuuqiSBW/Wmdfj8ey7A1Cn/+VeR6QDGBQu78oDuQ3A1fIeH
	l7zdmm+VLAAY3ftnGFWZD+5k3s1Cjkf53ygqUk86SjoQKvXfWBbEVlRc9deNUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1704425440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rySMi6BtJsyka161CnrLOEiS6YwQAVTrLDqoVNmAwg=;
	b=RK11zIZHo7/iYcA08lHA+bDB/6g1xXmIkqz1ROEMGF9xwI6Ok2z1dc4X5Knmlgoz5pkHVL
	L70j8FM3kGpR9mpR+HYWJwkHE6cNdJ/9inqPseUMsEqdN8qU+OdADy6da26n7gKWLBp9It
	RjPL+CPbuq5LOGgPBqDw4wjnS6r2hlczKLbZ1oc0TP7I8uvBLKkM1DLxmzR9z4U20FQqbz
	lFpy2dEN3I/Hp9ZlnbuomRZlk8jhw1EFUgYZGBNKPQ3owaCvr5PEjVEYHbyE2DXUf/SgyX
	XVL/aBahadMvBs0Cp4uJpMcjHyiCu4+xnKPA8SDhpCvscu+kc02K5L7zyHus1Q==
ARC-Authentication-Results: i=1;
	rspamd-b89458897-qp4r5;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Society-Chief: 4609ead234f7024a_1704425440399_1175336222
X-MC-Loop-Signature: 1704425440399:961303175
X-MC-Ingress-Time: 1704425440399
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.100.10.103 (trex/6.9.2);
	Fri, 05 Jan 2024 03:30:40 +0000
Received: from p5b07194d.dip0.t-ipconnect.de ([91.7.25.77]:55560 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rLaup-0000je-2u;
	Fri, 05 Jan 2024 03:30:38 +0000
Message-ID: <513dfa2b00cf496e6f682508037616b6165fcc53.camel@scientia.org>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Date: Fri, 05 Jan 2024 04:30:22 +0100
In-Reply-To: <57a0f910-a100-4f31-ad22-762e8c0ecb39@gmx.com>
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
	 <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
	 <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com>
	 <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
	 <9ce30564e238d1be0deafb8cab8968f800a8deaa.camel@scientia.org>
	 <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com>
	 <62e9ad23d4829f30600ea6e611d2cd4636f080cc.camel@scientia.org>
	 <7acc8ea1-079d-42bb-8880-dbd9bbfa100b@libero.it>
	 <fecad7ce2cea1ff125a842d8c53f1fbfe4f1d231.camel@scientia.org>
	 <CAA91j0VNf9UQTYOn688eboGB_bw4YeKOXnKAt1uAYRZwYA3UPg@mail.gmail.com>
	 <b47ed92f14edde7db5c1037a75b38652afa6c1c1.camel@scientia.org>
	 <e6ef9ab3-06ab-4360-b205-3a7559b6b388@gmx.com>
	 <979fd68a4a766f823366797eab1060e5c515a776.camel@scientia.org>
	 <ba9556f9-4784-4bf8-8fa1-49b17df6d31e@gmx.com>
	 <c085dabb449f8088156d906062db0b9fa0f7fe32.camel@scientia.org>
	 <aa69e84f-d466-457d-9b29-47043c2aef53@suse.com>
	 <bf5726d2a30996d06204b17d05daec9c77b7d769.camel@scientia.org>
	 <57a0f910-a100-4f31-ad22-762e8c0ecb39@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey there.

On Fri, 2023-12-22 at 11:43 +1030, Qu Wenruo wrote:
> That's not a big deal, because before sending that reply, I have
> already
> reproduced the problem using 6.6 kernel, so it's a long existing
> problem.
> Just like the whole PREALLOC and compression problem.


Just wondered whether there's anything new on this or whether the best
for now would be to switch the fs?

Also, do you think that NODATACOW would also be affected by the
underlying "issue"?

Cheers.
Chris

