Return-Path: <linux-btrfs+bounces-21677-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMvOJ1Tfj2m+UAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21677-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Feb 2026 03:35:00 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C0213ACA8
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Feb 2026 03:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 656C83032CEA
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Feb 2026 02:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E10F23815D;
	Sat, 14 Feb 2026 02:34:52 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from giraffe.ash.relay.mailchannels.net (giraffe.ash.relay.mailchannels.net [23.83.222.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A81A9F96
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Feb 2026 02:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771036491; cv=pass; b=D9jom0ao8h3x2CgGVhwiLvTHYjG9UomTkmIw04Npxaaj5D6PntkqlxpXi6pjTr86bufDYuIAlP1ptYasth1wZ1ApvvijzzHTjjCDESmO3ZMyIvZdy/2t8hUqm7jMyPWXUCptk1zYGj9TVuWvJ4yVl92NuKWvqrE2EBZTnEkpFf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771036491; c=relaxed/simple;
	bh=zrr2/ja0/1s3CLIP1QxBbOLmMxV0Nrru/OLl1PazJpY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XTJ6IRGRy4xFiWYPqaNHBofe/Dx1iGrHs6s0tI6iJn/z4wM2fl3J1gGuivk19rTXI+kBIjCxe7QNwPB2PqUhGCb0u+CSUd0eNShLTM6W0F3iz/GxKlOP4XtE5NANKv82UgpSSt9l8AlI/fkCrLDWskdE8Aq9fTl+R8qWWcHgp5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.222.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1AE37722298;
	Sat, 14 Feb 2026 02:18:56 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-101-116-111.trex-nlb.outbound.svc.cluster.local [100.101.116.111])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id D3EBD722416;
	Sat, 14 Feb 2026 02:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771035535;
	b=6tGiaaH1a2ebmGTym16HTR42D8+7k1CPIR3g4edQdb6CkRZmGkoQ/epeij1kyLUubnwtyI
	mBTgegVUlyU7Ym5OU+Qklp7mDZCYYG1aHgX2Tu6kByNRufc/a2j75SW6mLMOVfCHVmuo3n
	Nlulh+rujAtVMOm/WBH6mupzfDt/NS2Z4yyHfVS9THChJq1N08+9T5fMpU3P9o/kiVC1gW
	me8pwZFXDZmubpnP+ks4Iuogz1+rE//kw0ryk1lSoEfYoRBf7K27KIVuYl/M0Z41dEG9Wh
	egR/duQcyWSrVQBCrt3fR19fBlXD7SBC/+EcwMNYYSx3vsp+GCxqFZm9ad49PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771035535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrr2/ja0/1s3CLIP1QxBbOLmMxV0Nrru/OLl1PazJpY=;
	b=3n1UZiohXU7Z89Kq0bBsFQy3zT4yQuh9KNjb3PHCkQ5X/uzgOww9yw9xukd5a+6Ne9skWj
	tPSswHaFK15m+Ap+HEyNz31oRlpR7jaQQsapb0nMUwBUghDpuPQyeu+Cb8XmUuhuANle7g
	Xep+100qRMR2WUvuwJMvr7f6BFJTC62EzES9NB5ahEO8I9dwxWJFY8lXt6UEimoIDv8P9G
	7w6k7EwXcgALJNjnIhT/saqSuhohI0sv0M7rBBRpCfmHcSMDHl6e+UrEeGuBbqOyanroDL
	2Ye2daVm6VX9dPo3vYGVzg/Xkh68H9SdPJ4N02aB3Bg2NEJv1x9YtXKZprcYiA==
ARC-Authentication-Results: i=1;
	rspamd-845545c4df-5h7gf;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Absorbed-Descriptive: 6e5e92cc495a29ab_1771035535925_1537077566
X-MC-Loop-Signature: 1771035535925:317404253
X-MC-Ingress-Time: 1771035535925
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.116.111 (trex/7.1.3);
	Sat, 14 Feb 2026 02:18:55 +0000
Received: from p5b071a6f.dip0.t-ipconnect.de ([91.7.26.111]:59307 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <calestyo@scientia.org>)
	id 1vr5FH-0000000E9UD-0Uy7;
	Sat, 14 Feb 2026 02:18:53 +0000
Message-ID: <ced007c60ff226a2988f388c9389c240c8057843.camel@scientia.org>
Subject: Re: Btrfs progs release 6.19
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Date: Sat, 14 Feb 2026 03:18:51 +0100
In-Reply-To: <20260213185647.21966-1-dsterba@suse.com>
References: <20260213185647.21966-1-dsterba@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DMARC_NA(0.00)[scientia.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[scientia.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[calestyo@scientia.org,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-21677-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 02C0213ACA8
X-Rspamd-Action: no action

On Fri, 2026-02-13 at 19:56 +0100, David Sterba wrote:
> =C2=A0 * make block-group-tree default (support since linux 6.1), use -O
> ^bgt to
> =C2=A0=C2=A0=C2=A0 unset it for backward compatibility

I guess that also mean that this is now considered stable and has been
very well tested?

How about migrating an existing fs to use the block-group-tree (with
btrfstune --convert-to-block-group-tree)... has that also been well
tested and is considered safe to be used on filesystems with precious
data?


Thanks,
Chris.

