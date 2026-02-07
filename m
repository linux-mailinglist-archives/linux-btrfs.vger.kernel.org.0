Return-Path: <linux-btrfs+bounces-21457-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2XiZIWK/hmlLQgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21457-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 05:28:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8283104E75
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 05:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA5AF3019128
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Feb 2026 04:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8D22DCC04;
	Sat,  7 Feb 2026 04:28:10 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from cheetah.ash.relay.mailchannels.net (cheetah.ash.relay.mailchannels.net [23.83.222.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10201482E8
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Feb 2026 04:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770438490; cv=pass; b=Bfv8GfgUuoBn5b1pbI1EsrKyBCzM6ScBFs17QDF/ejjhnpCkAMoP4cqg4tBvUvrx0N1SjsNlJRC328cAOnFJ1rbdBwLw8BbVW+feHgubcNcuR77q9U4Vpw3LAftmAZRYlkrSgKJSuz1JdbPvdoXWWBY/7cI2GW5dd87tKNTmB5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770438490; c=relaxed/simple;
	bh=uuVqxeOjSx4ZGb4B/RQJc18ZDMO6Yl1bEpd79wsIMYU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CnSJgRbpCvYllEksLBev2Zk9wd7LIsqopWhMLqF7AoGlIDrntHBfKr0w62QyBOOtgjVIM/EGKgO4hlDrXufBObl8XxxAXO1FgN5Q3SvgCAZQyfunho5FYRw8xG9iMuVnjbgsMf9Inkte4kd2Or55RntrAobJviIoYqjC5s4R2PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.222.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id ADDF38C009F;
	Sat, 07 Feb 2026 01:28:02 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-green-0.trex.outbound.svc.cluster.local [100.96.77.52])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id D53EA8C26F7;
	Sat, 07 Feb 2026 01:28:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1770427682;
	b=Q76LvCTIt5xASiN5TMypt/AUx9F8A8dsZVaZSxDCm8oQBCmMW3oy8THMaRl1PKenP/a3zF
	rSgQhimYFf9uKRv5dfGFFso6g2BZ31ZR7RWTY5Mz+5mpgYacnbJ+qFmFKtDLPk4CdM15BB
	Koniu/v7QZMM0m/3Vj8zB2mL3Poc4qXDQ/QPCrE4udxZSl/8fJGXUn+Xr6k73ZTiYryC6d
	5WvER89FmhNV08IXpinb9xa9ubVrZmiT+qlZgHezfjKW8+JwngRBRv8qIG1DrdMdvvGv8U
	Bdq59FIEByjTAwHh22TBV9/kRt3HWnIr5VIMKSrVSbQYyH7IfpmRO4WtoTB1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1770427682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5eicBYGp5GfEIGwb9VR2vaD7Cr1hi4wD+/T/Nkcxnd4=;
	b=Hip7TBuSz0pzi9oxXJwHfT75rWVEy6OI0vGB7Myj1QeEWPEjsy8pQ6oPuHz0fbyaDZemJQ
	aRAlwZjv0HNjKKWnK8D1Rx7ww3fEwQ4ymr61eI1NROIV+b2c+wRrOc1P3qj2ACecZcTlBQ
	Smo4hPPAAEvyk0QcmF2q7VT4Q7Tx46hNXTMshJLmBMpKecYsqxMPUXxUnwkSfi1G5Z52jo
	fcuhxxIEeOVJuk2Hkenjjb6A9WqwgjzZqUISYmESEMdv3+mzDNIbCws2NwKpJ9hDBZqlyj
	MagBCuKV9Ht+oedzYYjvvvdwNbo45HgpwicsXHdcyw8D7rdRsfP6mrATDGo1gQ==
ARC-Authentication-Results: i=1;
	rspamd-845545c4df-nxw5v;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Continue-Lettuce: 1a22994e1a081438_1770427682592_533619037
X-MC-Loop-Signature: 1770427682592:3315925643
X-MC-Ingress-Time: 1770427682592
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.77.52 (trex/7.1.3);
	Sat, 07 Feb 2026 01:28:02 +0000
Received: from [212.104.214.84] (port=10942 helo=[10.2.0.2])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <calestyo@scientia.org>)
	id 1voX7B-00000009a4r-2W4W;
	Sat, 07 Feb 2026 01:28:00 +0000
Message-ID: <f094ddbb70cabd2e329615269519b1844f786629.camel@scientia.org>
Subject: Re: We have a space info key for a block group that doesn't exist
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Date: Sat, 07 Feb 2026 02:27:58 +0100
In-Reply-To: <52c813cf8dffe11325ce291d3f3bd41bcce21936.camel@scientia.org>
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
	TAGGED_FROM(0.00)[bounces-21457-lists,linux-btrfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.879];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,scientia.org:mid]
X-Rspamd-Queue-Id: E8283104E75
X-Rspamd-Action: no action

Hey.

I think I might have found the reason... and I guess it's a mix of me
being an imbecile and perhaps not detailed enough
documentation/messages:


When I did e.g.:
  mount -o space_cache=3Dv2,clear_cache
I actually used my fstab entries and did e.g.:
  mount -o space_cache=3Dv2,clear_cache /data/e

but my fstab is has ro set as option for all these data devices.


So I'd guess ro here not only means no "normal" IO. but also no fs
internal IO (like rebuilding/clearing the tree).

Would also explain why it worked with btrfs check.

If I now mount it explicitly e.g:
 # mount -o space_cache=3Dv2,clear_cache /dev/mapper/data-e /mnt/

I get:
Feb 07 02:20:33 heisenberg kernel: BTRFS: device label data-e devid 1 trans=
id 12267 /dev/mapper/data-e (253:1) scanned by mount (21114)
Feb 07 02:20:33 heisenberg kernel: BTRFS info (device dm-1): first mount of=
 filesystem 1f346f85-af92-4025-8647-6d1ecb962bc1
Feb 07 02:20:33 heisenberg kernel: BTRFS info (device dm-1): using crc32c (=
crc32c-lib) checksum algorithm
Feb 07 02:20:48 heisenberg kernel: BTRFS info (device dm-1): creating free =
space tree
Feb 07 02:23:41 heisenberg kernel: BTRFS info (device dm-1): setting compat=
-ro feature flag for FREE_SPACE_TREE (0x1)
Feb 07 02:23:41 heisenberg kernel: BTRFS info (device dm-1): setting compat=
-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
Feb 07 02:23:41 heisenberg kernel: BTRFS info (device dm-1): checking UUID =
tree
Feb 07 02:23:41 heisenberg kernel: BTRFS info (device dm-1): enabling free =
space tree
Feb 07 02:23:41 heisenberg kernel: BTRFS info (device dm-1): force clearing=
 of disk cache


Not sure what one should do to prevent this trap?
Nothing a all? A kernel message that xxx isn't done because the fs is
mounted ro?
Documenting all these cases (this probably not just space cache
related?) in the manpage?


Cheers,
Chris.

