Return-Path: <linux-btrfs+bounces-21390-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LG3MIyuhGk14QMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21390-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 15:51:56 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDA2F4412
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 15:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28A6C305147B
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Feb 2026 14:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FCF41C30A;
	Thu,  5 Feb 2026 14:49:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bonobo.aspen.relay.mailchannels.net (bonobo.aspen.relay.mailchannels.net [23.83.221.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6338836E472
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Feb 2026 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.221.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770302940; cv=pass; b=c91iUpdYVP1wUI90AyLacv9DI0rSKYCdAPwgUSYCZpau0luJDVtwQAgisSvLPY9C0rmV9y2OkUFis+9vDiIMSSVB1eWeQGxxYGTRxZ6SxgFFnCowrlgHHHIH/kr6I/yRZ16YMPNKYLBLo8Uv+t+2tBEnfG+Vm7XGa30C0iYOB5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770302940; c=relaxed/simple;
	bh=ybgbOwmZ247hqExeMRmUT80OkrQL+ftDIxp2rBLWT9U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MIzx16rXL+pcE2xqgQYmKm5tfYwbGkzpANF8aTGegNeIGAj3KvPpYpPE3v/0qKdizXY9DOczsOsPL109I97lYo3kxsMxObIWsvRLHKyRA3BZyTD0la/O2bUqPiUtYsF2JxwtY4WSrWrh0ZodjEoq32bVd2FVFe2IzLP1SPHE8ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.221.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5D3B25828E8;
	Thu, 05 Feb 2026 14:48:53 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-96-81-148.trex-nlb.outbound.svc.cluster.local [100.96.81.148])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id BC8E8582B4D;
	Thu, 05 Feb 2026 14:48:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1770302932;
	b=atSgPES+686coenaQ427W0TPUrZe4eN3mRe+cfI9eRUuRZgTNaJvJlIS0sfIEnM4OyqRaD
	XosEG4BVIfdp7ARNjGZoqOH4VjvbC9bF91c1IzOgmYmc1euuHpkAXpCIMjYNHVpi5EBkV2
	pUT9uczfhqPCOVDnKYdoNX/XnKqetYF+4olr5+RMMHKgdAOdGW9oCIoxDg46qjbKdDXajI
	yWJjVWIjpaPpoMKqub1ROkz+LqF44SKFQCIfltqNmWEN3y3QbLKx9EXZ0lbI7Neoj94zFP
	FC9Bz+xy2JAlWxQmcnnDqSUhASTssHb2S7hXb+XXY+edY1qPpoV1kxPXcIIwIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1770302932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ybgbOwmZ247hqExeMRmUT80OkrQL+ftDIxp2rBLWT9U=;
	b=fh18RdQ0YR/4f+EhddE4FGuohQ8YFLbSK2OtscbZ7nAvHU6O7T18H22nsRqJC84JKirN7Z
	1CT3lEJB51VI8LdfrZgtLb7/h2kwjbVfYGlCEMiWEf37e/eZ979Jl275kzyJPj6O1yzunb
	Lb9R1TYBzsYv3iC9SrtjOJTOJa50Q/82hgAYg+v8kVpqV7/PAzLqAodDPkAt8sDdwjcbua
	TRmusKYXBIRWvAGGTj2wMlnKfOMHYI+hSFzs/F2Rag/BRcA9cpLxT73xuo13Ceta5IeC7N
	TguCgyJ0vJkFw5o7vkRcWFRbQBa7QjaYd8kYNXibTJyl8e/PziYrAlyngOFoVQ==
ARC-Authentication-Results: i=1;
	rspamd-5b69cfdcb9-xf6n5;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Junk
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Arithmetic-Bored: 2302309e26a29870_1770302933160_3461350385
X-MC-Loop-Signature: 1770302933160:2699377222
X-MC-Ingress-Time: 1770302933160
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.81.148 (trex/7.1.3);
	Thu, 05 Feb 2026 14:48:53 +0000
Received: from [212.104.214.84] (port=21848 helo=[10.2.0.2])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <calestyo@scientia.org>)
	id 1vo0ez-0000000FcxP-2IOB;
	Thu, 05 Feb 2026 14:48:45 +0000
Message-ID: <a75537dc77e5b6fac922a97409ca4636805147dc.camel@scientia.org>
Subject: Re: We have a space info key for a block group that doesn't exist
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Date: Thu, 05 Feb 2026 15:48:43 +0100
In-Reply-To: <914a6a60-6bb6-4255-a8cc-ea6f28e7a9cf@suse.com>
References: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
	 <c07b6fde-03a3-4c97-9f59-866c81e78b85@suse.com>
	 <31615495f428dbe499ae5f5a109cc6c74c8979ca.camel@scientia.org>
	 <fc2f1d31-7f2c-493f-be42-2cb8c1fd5a17@gmx.com>
	 <84b22b2cc7534be60eb423973336101c9e9b9ad3.camel@scientia.org>
	 <b681834e-7b0f-4606-8c52-f2b4dafba246@suse.com>
	 <4e6ad7ef198de72edaf890a2257bf63864984197.camel@scientia.org>
	 <cca8b4ea-97ef-433e-9db9-4eca67b89576@suse.com>
	 <f1aaada378adad0da020bd679531c7f503ad6f93.camel@scientia.org>
	 <914a6a60-6bb6-4255-a8cc-ea6f28e7a9cf@suse.com>
Content-Type: multipart/mixed; boundary="=-NwIdyHMlsuN8bHekn7+P"
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	MIME_UNKNOWN(0.10)[application/x-xz-compressed-tar];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_FROM(0.00)[bounces-21390-lists,linux-btrfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	DMARC_NA(0.00)[scientia.org];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calestyo@scientia.org,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6EDA2F4412
X-Rspamd-Action: no action

--=-NwIdyHMlsuN8bHekn7+P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-02-05 at 15:23 +1030, Qu Wenruo wrote:
> According to the code of v6.18, it's really the option parsing.

Seems a bit ambiguous then?


> > And would it now cause any issues if I have the cache cleared but
> > no
> > new one was rebuilt?
>=20
> Unless there is something wrong about the fs that has a free space
> tree=20
> but without the proper compat_ro flag.

Can you tell that from the attached dumps?

That=E2=80=99s my main data archive, and while I do have various backups of=
 it,
all but one are also using btrfs... so if there=E2=80=99s even a remote cha=
nce
that this might have caused some corruption ... I=E2=80=99d rather know now=
, so
that I can still act :-)



> Mind to dump the super block of the involved fses, and may be the
> root=20
> tree too?
>=20
> # btrfs ins dump-super <dev>
> # btrfs ins dump-tree -t root <dev>

Sure... see attached archive :-)


Thanks,
Chris.

--=-NwIdyHMlsuN8bHekn7+P
Content-Type: application/x-xz-compressed-tar; name="dumps.tar.xz"
Content-Disposition: attachment; filename="dumps.tar.xz"
Content-Transfer-Encoding: base64

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
2jWxxGf7AgAAAAAEWVo=


--=-NwIdyHMlsuN8bHekn7+P--

