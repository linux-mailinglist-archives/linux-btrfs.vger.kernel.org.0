Return-Path: <linux-btrfs+bounces-825-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702B680DF97
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 00:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AFFA2826CC
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 23:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C125676D;
	Mon, 11 Dec 2023 23:39:11 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from weasel.tulip.relay.mailchannels.net (weasel.tulip.relay.mailchannels.net [23.83.218.247])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BFACB
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 15:39:07 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D77BE6C306D;
	Mon, 11 Dec 2023 23:39:06 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2BA3E6C308D;
	Mon, 11 Dec 2023 23:39:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1702337946; a=rsa-sha256;
	cv=none;
	b=9FUVgogr+EK6JI9a7Rt35kJRii7CNU85rH96iwtRvhCZ9Fmc4ePTyhqaWVwVccKb4uKxgj
	clZkXnmT5v/HKaJxR9d1zygbfq8hLNw0OYiAQ+rKaU7bZ/XUWXokJsuMztaOytsOD0x6iY
	aOPka0a58Dc+aKyuaQyS5eKZQoqbGgON/1yTBlR+IFcI2IPU/dnTFCbZfSyArBF/vs2WCr
	1BdBEoDXz78oGorVQ/6NtS5Y61nY7EOaV0a8mcSzIKMPKhhQWneS+slP+Zn6RLT/dIDumt
	zZdYhPnQg1B2m/JgxzOOopmihS3U7UC2omQNMcAJfRyAWZ58Sduy3PcX5/Xpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1702337946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PInXTlpdITNp9mbQruN3c9QPpSGUIt98/ndc8remXKM=;
	b=KmqualCcdefgO4fWNg7XDDTNaMDUca6BqtrL5HKNbTkfpP/Mkj5lV6tSnCRYWcTxaCfFPG
	x2rJobZZYE3MwVtcILlhpuFA3r3i3DlcMLMATACkvzEs30PMn3E7kH/E8r548Z8aifT2sq
	RfRwnLc8UUE8hmc+hGQWZrIev4o+uzQfB/y3mWG6Df/oI5NUU2WZFV3lVdpYGQ+Wx7bDJ/
	9vKNtYLHQHa+oxFm31hakIe65XNUJsedNlsKiIxdTZufJdYK9zz0e5IJ4heOHhcPzkNgOm
	BX+WvbbUxf62G13NwWtNwNhp1AZZMSVyEl/Em8U6daADL1MUUonEfqTrzQWSwA==
ARC-Authentication-Results: i=1;
	rspamd-6cb9686b59-c2whh;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Power-White: 2172dc5c00006f70_1702337946695_1287367073
X-MC-Loop-Signature: 1702337946695:31613761
X-MC-Ingress-Time: 1702337946695
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.127.7.218 (trex/6.9.2);
	Mon, 11 Dec 2023 23:39:06 +0000
Received: from p5090f0e4.dip0.t-ipconnect.de ([80.144.240.228]:47168 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rCprZ-0007Wi-0B;
	Mon, 11 Dec 2023 23:39:04 +0000
Message-ID: <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date: Tue, 12 Dec 2023 00:38:59 +0100
In-Reply-To: <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
	 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
	 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
	 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
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

On Tue, 2023-12-12 at 09:50 +1030, Qu Wenruo wrote:
> Shows exactly which subvolumes uses how many bytes, including orphan
> ones which is pending for deletion.

Well... here we go:
# btrfs qgroup show .
Qgroupid    Referenced    Exclusive   Path=20
--------    ----------    ---------   ----=20
0/5           16.00KiB     16.00KiB   <toplevel>
0/257         39.48GiB     39.48GiB   data
0/258         16.00KiB     16.00KiB   <stale>
0/259         16.00KiB     16.00KiB   a
0/260         16.00KiB     16.00KiB   b
1/100         32.00KiB     32.00KiB   <0 member qgroups>
1/101            0.00B        0.00B   <0 member qgroups>

I've just created a and b to get qgroup (somehow? ^^) working.


Nevertheless:
I'm 100% sure, that before, there were never any subvolumes on that fs
other than the toplevel and data, unless btrfs somehow creates/deletes
them automatically.


But the above output, AFAIU, still shows that "everything" is in data,
while counting the bytes of files there, still yields a much lower
number.


And other ideas what I could test?


Thanks,
Chris.

