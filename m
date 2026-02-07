Return-Path: <linux-btrfs+bounces-21460-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id I344BaLIhmlhQwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21460-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 06:07:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C7A104FBF
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 06:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 348F0302A040
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Feb 2026 05:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15102E091B;
	Sat,  7 Feb 2026 05:07:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B51D2E413
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Feb 2026 05:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770440856; cv=pass; b=Q9aSMAwRrwKLjQd60RyvLJgBZhoPMqc5LoSHqSydgGJWdaTRj4xEMLQCBwbNiYr3+otTzKXDZX21LxH1yQ32NskbUPJlzCb0lKChXBr8LHL9hGz+/zNS5faouA2P3Nr8piF39+ThbxMnUXYL1D+7rDimz3o0I2Zc6bSu2FAAAGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770440856; c=relaxed/simple;
	bh=0X4Ff7kLrKJVztv50wF4xIZRo2yKF5pOiJRBMBWJNd0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RtK4WYv+6IlIg4brFPeRWQSESSj4k0doVGs2oE8KJAniHJ70ybn02iFDNrRWMqz5LpX4PJde02va6Qx1aD7PU2Fh5GsWnlb5Xjk0vfzK1yRHbc5sOXNoqxwVnNRIrNCz/biACu+w66NOxyQT3Ym+EOGQNTse4GYkQMMWAl8ybX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2076F722B71;
	Sat, 07 Feb 2026 05:00:24 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-green-2.trex.outbound.svc.cluster.local [100.96.84.203])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 14A31722B8F;
	Sat, 07 Feb 2026 05:00:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1770440423;
	b=a7UrYfvIz+dZb2lBUtTWT/nLy1nYA0efew9mPqIg51Jiv83wpYwzqTEqQ6JXeClxjyQ1bI
	Jea67+qKkLL8NChWW6ez9MvizuPa4FfKUBGV+V2XePY4I1A9/2CJp8nv9BoBMb8NduNEAw
	2wpOXMfkGhYehrEUIiWOYo6KSXjUQNfpiKrXVLm1ybtlhOUkHdhEbz81QW7g7vlywHw6hZ
	ca7fSX87njWp4HfsbN/m5DpAWDA/ELb9SwEnUCMc87DHlwAspNk5pUU8EWQDUINJbuh4ux
	f9euPsarhCrePSWYNcLzkwnRl5pcMleJpBq7etaf/ZFdWjjIo5tO9XrZRzNFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1770440423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0X4Ff7kLrKJVztv50wF4xIZRo2yKF5pOiJRBMBWJNd0=;
	b=7c3lB1jLl+UbMWQ7DeKIm5+Lvf8Yu5SiDVLtUxL1LEstsY2iN0h8UgXbeqVoQycDMzF3pW
	r3OAY86F5Q8kumEKv9pSgezAKnJufqSjQUJ5mzMo5IxC3O1JWnDYG82mLnqVueOK/d9f5e
	PLOBY+NNj8gQEcvNg0JfPyK8oABxW9EZqzrWWpsAxfaMRB0VNurq4+AmcKn2JrTJsoSnUs
	PYCyd5usE2lEmrQVbbzIN1xXB4DILe5gxum/vnHk2vcZeVsJBPgKNPd7euk06s9xViErva
	fuw5+8g6+6ums1QrQG4tzDN/NWa9hP9mXgGqwscABjCYK4D0o50S6YfNwWd6RQ==
ARC-Authentication-Results: i=1;
	rspamd-845545c4df-d6lbc;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Towering-Daffy: 12c405ec3671df37_1770440423975_3214778546
X-MC-Loop-Signature: 1770440423974:3034199569
X-MC-Ingress-Time: 1770440423974
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.84.203 (trex/7.1.3);
	Sat, 07 Feb 2026 05:00:23 +0000
Received: from p5b071a6f.dip0.t-ipconnect.de ([91.7.26.111]:64656 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <calestyo@scientia.org>)
	id 1voaQh-0000000AZo0-1AUU;
	Sat, 07 Feb 2026 05:00:21 +0000
Message-ID: <05e63d59951cfb8612c876d5bc7fdb76b272b01c.camel@scientia.org>
Subject: Re: We have a space info key for a block group that doesn't exist
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Date: Sat, 07 Feb 2026 06:00:19 +0100
In-Reply-To: <a6d825eb-3e8c-404f-90f6-6b4e5621479d@suse.com>
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
	 <18a87dd4f3155bb1d9c9884f39dbf53c802a10cd.camel@scientia.org>
	 <572f0ac4-90f6-4c56-aa4c-2a64e365d526@suse.com>
	 <52c813cf8dffe11325ce291d3f3bd41bcce21936.camel@scientia.org>
	 <f094ddbb70cabd2e329615269519b1844f786629.camel@scientia.org>
	 <a6d825eb-3e8c-404f-90f6-6b4e5621479d@suse.com>
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21460-lists,linux-btrfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[scientia.org];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calestyo@scientia.org,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.878];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[scientia.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3C7A104FBF
X-Rspamd-Action: no action

On Sat, 2026-02-07 at 13:04 +1030, Qu Wenruo wrote:
> Not really, read-only mount can still write, the most common one is
> the=20
> log replay.

Well I knew about the log replay case... which was also why it never
really occurred to me that it might disallow its own fs tree
deletion/creation.


> But other than that, we follow RO pretty well.

I see ;-)



>=20
> I prefer nothing, if we really want to dig into the situation, I
> should=20
> have asked about your mount command, but I haven't and that's my
> fault.

Well... people may still fall for that "trap" off-list.

I've seen your patch for the docs from just before... I think what
would be even better (maybe additionally) was a warning at the kernel
log for ever mount option that is effectively ignored because the fs
being ro.


> So nothing unexpected expect the fstab usage.

Sorry again O:-)


Thanks,
Chris.

