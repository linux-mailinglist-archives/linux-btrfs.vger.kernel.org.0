Return-Path: <linux-btrfs+bounces-359-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FE07F9149
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Nov 2023 05:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05402813EA
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Nov 2023 04:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC13B23CE;
	Sun, 26 Nov 2023 04:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E37110
	for <linux-btrfs@vger.kernel.org>; Sat, 25 Nov 2023 20:35:41 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F3CF4C1AF5
	for <linux-btrfs@vger.kernel.org>; Sun, 26 Nov 2023 04:35:40 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3B4FEC0D2C
	for <linux-btrfs@vger.kernel.org>; Sun, 26 Nov 2023 04:35:40 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Bitter-Hysterical: 1e3ff4bd5d6001dd_1700973340535_3791320556
X-MC-Loop-Signature: 1700973340535:3901665380
X-MC-Ingress-Time: 1700973340535
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.111.127.24 (trex/6.9.2);
	Sun, 26 Nov 2023 04:35:40 +0000
Received: from p5b0ed26e.dip0.t-ipconnect.de ([91.14.210.110]:52736 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1r76rm-00041M-0n
	for linux-btrfs@vger.kernel.org;
	Sun, 26 Nov 2023 04:35:38 +0000
Message-ID: <6f340d377c584239a1b8d4236d404d708e61d968.camel@scientia.org>
Subject: backgrounding send|receive causes: ERROR: crc32 mismatch in command
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: linux-btrfs@vger.kernel.org
Date: Sun, 26 Nov 2023 05:35:33 +0100
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

Hey.

I have experienced this myself already some years ago and apparently
others[0], too.

When stopping a send|receive pipeline (both on the same host, i.e. no
ssh or so involved), and continuing it again, the whole thing dies
immediately with an:
   ERROR: crc32 mismatch in command


Which is particularly annoying when one wanted to make a backup of 9TB
and was nearly finished and had forgotten that this breaks. ;-)


Any way to have that fixed?


Cheers,
Chris.

PS: kernel 6.5.10


[0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D888858

