Return-Path: <linux-btrfs+bounces-21523-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QUswAJdkiWnr8AQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21523-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 05:37:43 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1545D10B94B
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 05:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 741813001CF8
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 04:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D1225B311;
	Mon,  9 Feb 2026 04:37:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A48A1C7012
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 04:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770611855; cv=pass; b=mayuv8o5zFJIadvJkSEWqoycF8VvjRMg7dzW9+uQ29109RbGnzF1u/mXuLfeiG7yfV06y7D6vxN4fhLcMWW5CA3QMZ20DLWPrqTyRLHw/bCCtWaWV8rV+xyoPBKLI1c0wpDQ1XQR0Yln0qjLZp7ZXSS6Iys9X0YZ9nOOEU9KWbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770611855; c=relaxed/simple;
	bh=7rgSobQH/J6mvfmDSJvUjQZX325KrZQY4ByHn7AxiSM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DHirVkqfhjj6nEaoAW1HufbC+M6fRoiVjXzwLEHDcg2vjHgM6LCya9vL/VgReRP9rL3ayFLKBDhHmZMmebY4knngY6voO0D0fEXICwqFxxxYVmNrw1PgEWLxSiCbGNdzBSRcgCGlcqoclIRx0RYdD8pyS26OHrE7TzjVElknFRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 28AD8800A23;
	Mon, 09 Feb 2026 03:58:22 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-97-7-35.trex-nlb.outbound.svc.cluster.local [100.97.7.35])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 18682801509;
	Mon, 09 Feb 2026 03:58:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1770609501;
	b=yIFrxdoMf2PDbiYDdn6xQu5gmqGVM9nyDgzDSs9Te9HtdH/0f2Pt6KtOLNVzLbRJ0pZ5Fv
	5U+dP1H2s7RrE18ZXpOynJSLRspH6zhMY45Fiz3InEYe6aldLnHYRKumUuq2BcKwsPOkvW
	Iu7FStf23ghr+Uz0NqvHlrjKg0XEVShow4ua32JASvmrpf1lStFEWUZbVg5diKBDf4zT6Q
	eIr6/R3bFakVIR+vr0pI9+seuqJ6Y+ski6M1eh3vi/2+hshtEdmKTm4PLnKDJuiosAlzlU
	MbObzmKqmeCACaOdzVf1Aetn+hFypwQ/a9JnyMF6fm0rF3H6joNuB63BntsvQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1770609501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7rgSobQH/J6mvfmDSJvUjQZX325KrZQY4ByHn7AxiSM=;
	b=RRagktqadjTC0aLgrXwP+Zb+xbn0eAQ4VMyngm1c3k0Gzd0c/z529HP3e9yHDj4dYc958i
	ZoOHAVt5b7IC7rexw7XE3fevTk4FPU83hASrAOAI+fjoFU10gER5w+obfFt52MuPvj2gH0
	y39uYDvoA4z5mvjv0q1azaLxDscl9D76z/N8Du17hirZjRfZvq9pYxl/M6/cz+RrVn3wxL
	OVYrC1+DyU/jJqEl9YMt9rJCcZ3bKzxZ9UI4iKU7v7YdefwdL89sXxFeF3TiTA93kEi6uN
	LBROGSxTVNlxRLf1DDtJNyPSDGs4hAEhtJD4DcteItFxg4iCCUY1UEDdWsTUzg==
ARC-Authentication-Results: i=1;
	rspamd-845545c4df-9vhkv;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Wiry-Stupid: 0e4a41df2ffc891f_1770609501968_2562544661
X-MC-Loop-Signature: 1770609501968:1683419736
X-MC-Ingress-Time: 1770609501967
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.7.35 (trex/7.1.3);
	Mon, 09 Feb 2026 03:58:21 +0000
Received: from p5b071a6f.dip0.t-ipconnect.de ([91.7.26.111]:65162 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <calestyo@scientia.org>)
	id 1vpIPi-00000007lpT-0oC1;
	Mon, 09 Feb 2026 03:58:19 +0000
Message-ID: <4aa883f597c4d12ddfb50912cc03349594d4fdd7.camel@scientia.org>
Subject: Re: space_info METADATA (sub-group id 0) has 691535872 free, is not
 full // open_ctree failed: -2
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Date: Mon, 09 Feb 2026 04:58:17 +0100
In-Reply-To: <54b7e6a4-7a08-434c-b7e0-849d3f961de3@suse.com>
References: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
	 <b681834e-7b0f-4606-8c52-f2b4dafba246@suse.com>
	 <4e6ad7ef198de72edaf890a2257bf63864984197.camel@scientia.org>
	 <cca8b4ea-97ef-433e-9db9-4eca67b89576@suse.com>
	 <f1aaada378adad0da020bd679531c7f503ad6f93.camel@scientia.org>
	 <914a6a60-6bb6-4255-a8cc-ea6f28e7a9cf@suse.com>
	 <a75537dc77e5b6fac922a97409ca4636805147dc.camel@scientia.org>
	 <fff60222-0b9f-4f09-b3a6-d415aa64b6d7@gmx.com>
	 <18a87dd4f3155bb1d9c9884f39dbf53c802a10cd.camel@scientia.org>
	 <572f0ac4-90f6-4c56-aa4c-2a64e365d526@suse.com>
	 <52c813cf8dffe11325ce291d3f3bd41bcce21936.camel@scientia.org>
	 <f094ddbb70cabd2e329615269519b1844f786629.camel@scientia.org>
	 <a6d825eb-3e8c-404f-90f6-6b4e5621479d@suse.com>
	 <05e63d59951cfb8612c876d5bc7fdb76b272b01c.camel@scientia.org>
	 <89188b7b8b5a1f9bb64af37777aec906134ad75c.camel@scientia.org>
	 <9b05f9a3-5efe-4e57-9585-a3886bb419fa@suse.com>
	 <3137a2417287037a2ed52ded55fab35181254009.camel@scientia.org>
	 <54b7e6a4-7a08-434c-b7e0-849d3f961de3@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21523-lists,linux-btrfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[scientia.org];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calestyo@scientia.org,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.877];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[scientia.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1545D10B94B
X-Rspamd-Action: no action

On Mon, 2026-02-09 at 14:18 +1030, Qu Wenruo wrote:
> I don't think the key point is the context.
>=20
> I believe the key point here is the size of the fs, which should be
> very=20
> large, so that rebuild itself will take over 30s.

That fs (where it failed) is on an 8 TB HDD (and I think it's at best
half full)...

I did the same procedure on a significantly larger fs (20 TB HDD, ~16
TB used)... and it worked.

Or what do you mean by size? Size in terms of bytes or in terms of
number of files?



> With that said, feel free to clear v2 cache and let the kernel to re-
> create.
>=20
> When we want to test later, you can just go the same=20
> clear_cache,space_cache=3Dv2 mount option, as long as you didn't=20
> significantly reduce the (used) size of the fs.

Okay.


Thanks,
Chris.

