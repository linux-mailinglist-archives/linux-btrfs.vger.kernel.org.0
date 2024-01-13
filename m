Return-Path: <linux-btrfs+bounces-1423-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D20482C94F
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 04:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A820BB24935
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 03:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460971D530;
	Sat, 13 Jan 2024 03:57:49 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from aye.elm.relay.mailchannels.net (aye.elm.relay.mailchannels.net [23.83.212.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5551D52A
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 03:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8B5666C15A9;
	Sat, 13 Jan 2024 03:48:06 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 18B116C1583;
	Sat, 13 Jan 2024 03:48:04 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1705117685; a=rsa-sha256;
	cv=none;
	b=msVcBgVSvRMpdBk1bIpthglIllLrFobNlURsQ4Mkl75PL/JR1YbZ9bdH79GQfouvIPg9Av
	xKoA7fZ5GwmhXCf5mUXXbkbMel6dmDUB5c+L3G/x9nCNGvDwJk8qXQb3X2zMMjejcIqKbv
	hhr3wYamdnfyLRbJWqO21LWvFLuGppmAomy+aFMYKixzpVYPqPQWTNOHaJxTeTAF+ztHGI
	M2SUO2OivLg/GbWQFf4Agj/+tbVf4k/ZHDfKD6cdVxjykaYI5Z/AbsmyvlVJHzBFf544UC
	JXZAB5hvutDNYNHihrnZmkG6dOAZ3tQ83XCvDs3fn87KEHP6YHo25HYSGQ1bGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1705117685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=frPb07bboEoMbpMUSg7PMGxsNfkAz19kFY51IF47AnQ=;
	b=9kvw8nrdk1s+y/WHpXC34BuU4ua9rmfj+IS6Ctg+tUKCvGvXWwgNeaC+rw6cIuPOACjO+l
	wmDzl2WgcVT4FIaMvauhNA7AueLcr05G0wCsLdloTg3t19f9ipFs8uDwkeuItJTUeBQqq8
	aQ9zLVWlAeIeOMTGZLHsiqDqaYrR1T7O8Y4KdlUSpC9/HOJ2jLwWsGaxAJ9oKdzSCYm8wo
	qM+zYaOlFJROpZX1DsDijHBklGHjP1nKoxtAEsOw2d/Q6oyS39AQQG6Ey9rWdS2orYDfYx
	z5BifAnmd3M0NbRjnpYpFRWMwnAn2Y9lvkLP63MbbUKt/Dx6IJewoiWeD2PL2Q==
ARC-Authentication-Results: i=1;
	rspamd-568947cb6c-bcfmp;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Cooperative-Print: 3d94ec8b4c4da97e_1705117685888_2234459595
X-MC-Loop-Signature: 1705117685888:2875850659
X-MC-Ingress-Time: 1705117685887
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.103.118.39 (trex/6.9.2);
	Sat, 13 Jan 2024 03:48:05 +0000
Received: from p5b071bfc.dip0.t-ipconnect.de ([91.7.27.252]:52954 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rOV05-0005Ah-2S;
	Sat, 13 Jan 2024 03:48:03 +0000
Message-ID: <17f726a997187b71331b9dd232321bbecbe56038.camel@scientia.org>
Subject: Re: [PATCH] btrfs: defrag: add under utilized extent to defrag
 target list
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Date: Sat, 13 Jan 2024 04:47:57 +0100
In-Reply-To: <20240112155806.GS31555@twin.jikos.cz>
References: 
	<2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
	 <20240110170941.GA31555@twin.jikos.cz>
	 <a033550b-9300-42bd-9ec2-74f9ee15cad3@suse.com>
	 <20240112155806.GS31555@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Fri, 2024-01-12 at 16:58 +0100, David Sterba wrote:
> I'm not sure how would it affect send/receive, read-only subvolumes
> should not be touched.

This of course means, that if the IO pattern that causes this issues
happens, and if snapshots are used on such fs, the supposed cure would
make the problem even worse.

Guess either some documentation should then be added somewhere,
describing the whole thing... or perhaps it should be (re-)considered
whether one could do something so that the wasted parts get
automatically freed upon truncation. Maybe some attribute that can be
set on a directory and files/dirs created beneath that get the special
treatment.


Cheers,
Chris.

