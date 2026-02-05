Return-Path: <linux-btrfs+bounces-21402-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iK7tKywyhWlV9wMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21402-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 06 Feb 2026 01:13:32 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C44EF8854
	for <lists+linux-btrfs@lfdr.de>; Fri, 06 Feb 2026 01:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEE57302834B
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Feb 2026 00:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2F2136E3F;
	Fri,  6 Feb 2026 00:13:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from crocodile.elm.relay.mailchannels.net (crocodile.elm.relay.mailchannels.net [23.83.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41F36A8D2
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Feb 2026 00:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770336805; cv=pass; b=JfaGNYhBh/MjQwuxn3BCSqsWsZVuBiz0gE7EefEIU988QnlJCanDKzlsC9sAHEne/+IZE6o15h3C5wjZp/1ftjkjbX1fQq8fRxYHZnSm5lWYmXvhc37ffNGp+VimCdt4OtI+SKeg1I7Hy/wLTZN80ecBeGS/EnBwX2S/yagVGZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770336805; c=relaxed/simple;
	bh=UWlG8NpSHt1uSo+1ffX85lHhtGDANZYzI3mFhw6rDc4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WW/QcdihsgK+DC+xD6936TLldWfRu6ChFCeBKLmSVnB7kIeHD1q0zYhRkPszDPL68b0OHuWiqsyCjqNuF8+6/VXOll+oVZPxz89k2L2w/MhGrNaBFjR0IPnh9hDpacvw+1HTIdziOAA6l3EDg9XAw0sx9LyCe0ykP3CfTXx8icA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 42FA6160876;
	Thu, 05 Feb 2026 23:56:28 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-96-80-213.trex-nlb.outbound.svc.cluster.local [100.96.80.213])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6298B162A31;
	Thu, 05 Feb 2026 23:56:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1770335787;
	b=uDPcXuYbZv6d/UnzV8l/27YaIZ0UUUJmPSp7tZOi07MwLzNS8BS+EG3q/WKCJzRbSbBfvM
	smTTyfdceyDrimmasMNO8ZAsgoDTTmYij48McWN+sicnBn/SX9YGyYhcSKXF8n7mD9oJ1F
	54C568mxDHGSV0SGNRH7ZPBD+aCSNbQ2eBejKZlIEKKYkfZ/7zBqYPmK78ciet27fFRk/b
	5A2T1TANik63mksmKx579yNfWPuCAzmLxm8ZZXZk1ARa6mlAaax4HhTP27+h50l/jRrySH
	E96nb/n870KzjZA3A6rT9uaARPnbFyMFtERDaV20FnzTZH0vLI3UIKNIzAPfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1770335787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWlG8NpSHt1uSo+1ffX85lHhtGDANZYzI3mFhw6rDc4=;
	b=96u6mVI4/pcLyCwa4kqasqppkX0DDSiFkyv8dH3LuUKCxaJeZandfnHa9zaPvDwhgLHO2q
	VVbRglhSvJcBszRax4RiPpJPCvrMDMos6etUxO12WJWoOqI+T6U3Vy4EZf96xww2+Jyuz+
	/y0Kyd4ySVs+m1k3svPekAyw/UDk2KgCAJ3A6ZBG7f/C1WpH94vtZx+gfVA28hSZBlwZ+v
	EC2cE1XvVnrnUrEZEXd8ej4jPFzkUxCpDEx0+U+gwrnnr4p6Ful/NICp6Lx6FwXPGtw6C8
	MVXAZO1mXdWoqkUtOi7AnbuXJ6bPMOedm7z93LPwZn7VtXf0MTfq5Ttiyej/OA==
ARC-Authentication-Results: i=1;
	rspamd-845545c4df-6qgk2;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Celery-Plucky: 2cb7aa0e331ff75f_1770335788092_83588400
X-MC-Loop-Signature: 1770335788092:889217597
X-MC-Ingress-Time: 1770335788092
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.80.213 (trex/7.1.3);
	Thu, 05 Feb 2026 23:56:28 +0000
Received: from [212.104.214.84] (port=34332 helo=[10.2.0.2])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <calestyo@scientia.org>)
	id 1vo9Cy-00000000TZ1-2oOR;
	Thu, 05 Feb 2026 23:56:24 +0000
Message-ID: <18a87dd4f3155bb1d9c9884f39dbf53c802a10cd.camel@scientia.org>
Subject: Re: We have a space info key for a block group that doesn't exist
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Date: Fri, 06 Feb 2026 00:56:22 +0100
In-Reply-To: <fff60222-0b9f-4f09-b3a6-d415aa64b6d7@gmx.com>
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
	 <a75537dc77e5b6fac922a97409ca4636805147dc.camel@scientia.org>
	 <fff60222-0b9f-4f09-b3a6-d415aa64b6d7@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21402-lists,linux-btrfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[scientia.org];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calestyo@scientia.org,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C44EF8854
X-Rspamd-Action: no action

On Fri, 2026-02-06 at 07:18 +1030, Qu Wenruo wrote:
> The only explanation I can come up with is some downstream patches
> from=20
> Debian. Would appreciate if you can test with an vanilla upstream
> kernel.

Uhm... that=E2=80=99s at least a bit of an effort (not because of the
compilation itself, but rather because I=E2=80=99m rather security consciou=
s
and have no trust path to the upstream kernel sources)...


Before doing that, would you consider the following as enough
"checking"?

I=E2=80=99ve downloaded the (Debian) source package for my kernel:
$ apt-get source linux

Debian puts all distro-specific patches in ./debian/patches (and
applies them to the original upstream tarball when extracting the
source package.

Looking at these patches, only two contain btrfs at all:
$ grep -Ril btrfs linux-6.18.8/debian/patches/
linux-6.18.8/debian/patches/bugfix/all/fs-add-module_softdep-declarations-f=
or-hard-coded-cr.patch
linux-6.18.8/debian/patches/debian/btrfs-warn-about-raid5-6-being-experimen=
tal-at-mount.patch
linux-6.18.8/debian/patches/series

I=E2=80=99d say none of them touches anything that could explain the above
behaviour, but you can look up these patches yourself:
https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/patc=
hes/bugfix/all/fs-add-module_softdep-declarations-for-hard-coded-cr.patch?r=
ef_type=3Dheads
https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/patc=
hes/debian/btrfs-warn-about-raid5-6-being-experimental-at-mount.patch?ref_t=
ype=3Dheads


If that=E2=80=99s not enough, tell me and I=E2=80=99ll compile it myself.


Cheers,
Chris.

