Return-Path: <linux-btrfs+bounces-22214-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OtWOuXPp2kBkAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22214-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 07:23:33 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 627E31FB1C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 07:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD205304EEB4
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 06:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E5437FF5B;
	Wed,  4 Mar 2026 06:23:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from slateblue.cherry.relay.mailchannels.net (slateblue.cherry.relay.mailchannels.net [23.83.223.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E0D37FF49
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 06:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772605410; cv=pass; b=Up2vd12va+v+anvYyi7YADP/DIJtvRKmq/DzcVHKm42AbHermZOSNv5gQtCJtiAyAl6UK5FmJDbzImCzY/1U44Sjz+s+0BlX8mdaBuW1ZDZvCGelN9hICMqNRieNXzW0Z6saPDFNFyJqipxt2IXo4ymDzXfM5GQjjXrcgbEvFYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772605410; c=relaxed/simple;
	bh=B8Jhu+Lpal3/CrK/U+Munn1dlzBG5EYNzRSGSszzrIs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b+BZlMJY4Jbj2jvLBNNqohkdRCrTudS25v2qGgfYnKTuOhh7knWTUgMG9002m0d36uA9/BoUOUreLVod9e2ZrzAqujlbXoeTsdbO44/nWnbBTbco8egbIU0YKYgZk66CVcs1BKrxv4Zm4wjzwSRHJRhew0VFvHVjD6kuASMnpoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8FAE5461B0C
	for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2026 03:59:50 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-107-38-197.trex-nlb.outbound.svc.cluster.local [100.107.38.197])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id B371046199A
	for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2026 03:59:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1772596790;
	b=0RvB3bXLgyNhM8IUTCKa6hZ0STSy/6A9nAYVzkrGb5V6aKQz/HTGF8M7lqbqJsB4iV9Eat
	dvN/EUzmRGpzLOyJmNqDzlHkd6vxv/qfx1IBxyph6J39FFaYWGcH7wXhnYCu3Q5GXZNn4I
	w0eTTpCSXGHic6VdvBSgQIg/LxvjRF2lzeQD7HheClSK4ICDx8C/TmrHNmLN0blSeVnSNq
	T8Rz9rHNNJrljn2LzIP33+dkGIAtc86wyhtLBmqiKYnDKup+z+zNzMrCvsR/wCqKJ7zS4I
	d2oQtaqyCSAHfriF+HqxXB0+/CcqzEgdnBfpY+3ql69Jj6RCFb3pbMVG98hLRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1772596790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=du/uhIscP/qcLvf31xj0gmGMSSBHGoBNy2Yt7R4RzXM=;
	b=6ZdRYFGj4dc+7A2pcuZSIXbYZ3wKNIAwlthEAEoyRclFhuMb+4UPuJBSSH5IR3IX3N01+a
	EMtFDHsxqpjUff45GztsHmpdSvtbtKzo94HeCBO/McxN3gRaIyY5sx7Mo9vtNe+HEXhOnU
	rEWrpYhtRGyjUAD+c6//W2nX36/lieNisjRv35XWSOati5fprbGVri7HpCmrWaJjO8S87p
	jcR2309Dm/Xw4GRjf2TtZficV8tPEoZACUGbBDbXpWD9PM0zn7tXubLAwhIIincxZs9eHY
	jo0Badbyk2d8mKBhjBjuqYQq4zZ7XoRqeTI6Oon9q064eGQ83qBfHSyQuc1V1g==
ARC-Authentication-Results: i=1;
	rspamd-6fbd58c58b-69v5p;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Battle-Trouble: 6c89155306d1fa9c_1772596790452_3088575574
X-MC-Loop-Signature: 1772596790452:4159773700
X-MC-Ingress-Time: 1772596790451
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.38.197 (trex/7.1.3);
	Wed, 04 Mar 2026 03:59:50 +0000
Received: from [212.104.214.84] (port=7434 helo=[10.2.0.2])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <calestyo@scientia.org>)
	id 1vxdOn-0000000ByZz-1Q4x
	for linux-btrfs@vger.kernel.org;
	Wed, 04 Mar 2026 03:59:48 +0000
Message-ID: <69af62cb0ffa586b3171750f53cd4be38920e127.camel@scientia.org>
Subject: Re: space_info METADATA (sub-group id 0) has 691535872 free, is not
 full // open_ctree failed: -2
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Date: Wed, 04 Mar 2026 04:59:47 +0100
In-Reply-To: <f94503a645b3d3f20fb7d311268363cb4d67b061.camel@scientia.org>
References: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
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
			 <4aa883f597c4d12ddfb50912cc03349594d4fdd7.camel@scientia.org>
			 <c8fe54d5-d088-4326-a5ec-4c9687f89902@suse.com>
		 <1d7f6937ca045573661fb32334e4d18948cd97a8.camel@scientia.org>
	 <f94503a645b3d3f20fb7d311268363cb4d67b061.camel@scientia.org>
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
X-Rspamd-Queue-Id: 627E31FB1C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22214-lists,linux-btrfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[scientia.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCPT_COUNT_ONE(0.00)[1];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calestyo@scientia.org,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.205];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hey.

Anything new on this issue?

I thought it seemed rather critical if a regular operation like
  btrfs rescue clear-space-cache v2
or
  mount -o space_cache=3Dv2,clear_cache,rw

bricks a fs.

Cheers,
Chris.

