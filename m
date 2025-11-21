Return-Path: <linux-btrfs+bounces-19241-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADB1C77ABC
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 08:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CD1634B597
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 07:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DC132FA2B;
	Fri, 21 Nov 2025 07:20:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C339323C4E9
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763709606; cv=pass; b=q5BvphYgacSTgjdtFc/+WfXpcYjWcAT3wUNyhp+ExRJhByx2SHG1T0Z11C+xVVtoC8lsHqwzezYxnc1lvVSYid7uGyOwKfYNH/mnyIo5HPynOTYPv2/GA73bBZNn+fuC5/yZ1KZB1huypNHDQtx7Rc0sEYsQ2864jha/QxbpWpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763709606; c=relaxed/simple;
	bh=SNRQ4vekwpLQ2zBbt5HutrvAzdJ8J/JDACHZURIqn9g=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WfRNee24R8k/P+CXmKwOL0IxM/0fhvJ6Sw4qZ+FtKJ09cyaRz7PPj5tNxpf0huCDOrKkpObU189ofk1vhBl88rYIf9HwS1S6VMa69Q6wyS7cyfZueDU2dezVEkhGbPMo7oiibFl+7AzgckkYEQfVOxV+Hntvjw06zuFMz9X2dlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 31C5F121824;
	Fri, 21 Nov 2025 06:03:02 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-green-7.trex.outbound.svc.cluster.local [100.96.173.27])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 43D88120EF2;
	Fri, 21 Nov 2025 06:03:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1763704981;
	b=puToyTEqNkyktFmQ92s7RgRzgmoEc45ahpML31qPuqTSZvGV9+LO5SIjLqP15xjmhzzix7
	PAAhncHX7UvuHdnz5Sh8vKmeYoBtC7NiNisz9QWhLK3hEB0medFMOPteNEPy9fhQ16n3Cn
	OzyWDsrIioMvN5eaN7tDBJqnI/mT3YqyrmUmj9EsD0wYV5kViUJymuj8a2Imta0oWvd++P
	INOgoHvVeGUivCor/RYG2BPelIJUbvcKr+vnk8vEhR8pBNpcudGRODAmA7SG1AA3qvAF4f
	a6WKavvUW3E0DAUsDighUdKlt5n101aZ8/pQYcJDk7So9RyA8FwrsPMBFQDfrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1763704981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GS5FJkRc/7Gd3+H5UUL4EnvLJsjvVox+7+h/arpHmVI=;
	b=KY0M1f+8EBC4LVfiioAQwwOcKoNPfq84bJHxO/r6O0tzi0OGPRN5oPb71cfiBVsl87O4ft
	TYQsOWk768H+ybsIzW/BcXT7Vlm77v6RUHmyLfU1guJD0qP0y3GKJ8zbANg8Z8zewBA0MI
	IGIRD+bbFu21lmSFhqi/ZlwunyUeu5LuyOUV9fVuSu9yXay+RsJ/b/LAFbgJU0YOGoHvw7
	r3Gh9yvHV+6MNHB2PMzrstaH1svBl0UONzKQ+zFE4v2CRaNx3m2rnZXyEl81R39SqQsumC
	nbmhyg18gOpA7wEm3KzqCKx6m6M8NUZw4JXuo/0WwnBOvDqXySlJclRkr3tvjQ==
ARC-Authentication-Results: i=1;
	rspamd-7b65966669-4vrmn;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Drop-Turn: 42d244d828b3cd9e_1763704982022_2386429032
X-MC-Loop-Signature: 1763704982022:1359612385
X-MC-Ingress-Time: 1763704982022
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.173.27 (trex/7.1.3);
	Fri, 21 Nov 2025 06:03:02 +0000
Received: from p5090fa32.dip0.t-ipconnect.de ([80.144.250.50]:60271 helo=ehlo.thunderbird.net)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <calestyo@scientia.org>)
	id 1vMKEX-0000000Bw91-1xPI;
	Fri, 21 Nov 2025 06:02:59 +0000
Date: Fri, 21 Nov 2025 07:02:58 +0100
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_btrfs-progs=3A_docs=3A_add_?=
 =?US-ASCII?Q?warning_for_btrfs_checksum_features?=
In-Reply-To: <bc5249ba-9c39-42b1-903d-e50375a433d2@suse.com>
References: <7458cde1f481c8d8af2786ee64d2bffde5f0386c.1763700989.git.wqu@suse.com> <9523838F-B99E-4CC5-8434-B34B105FD08B@scientia.org> <bc5249ba-9c39-42b1-903d-e50375a433d2@suse.com>
Message-ID: <3C200394-F95B-4D1C-9256-3718E331ED34@scientia.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-AuthUser: calestyo@scientia.org



On November 21, 2025 6:24:26 AM GMT+01:00, Qu Wenruo <wqu@suse=2Ecom> wrot=
e:
>=E5=9C=A8 2025/11/21 15:47, Christoph Anton Mitterer =E5=86=99=E9=81=93:
>> Is that even the case when the wohle btrfs itself is encrypted, like in=
 dm-crypt (without AEAD or verity, but only a normal cipher like aes-xts-pl=
ain64)?
>> Wouldn't an attacker then neet to know how he can forge the right encry=
pted checksum?
>
>In that case the attacker won't even know it's a btrfs or not=2E

I wouldn't be so sure about that, at least not depending on the threat mod=
el=2E
First, there's always the case of leaking meta data,=2E=2E=2E like people =
observing the list or my access to Debian's packages archives (btrfs-progs)=
 would e=2Eg=2E know that there's a good chance I'm using btrfs=2E

Also, an attacker might be able to make snapshots of the offline device an=
d see write patterns that may be typical for btrfs=2E
Even with only a single snapshot being made, with the empty device not ran=
domised in advance, it might be clear which fs is used=2E


But all that's anyway not the main point=2E

Even if an attacker doesn't know what's in it,  he could try to silently c=
orrupt data or replace (encrypted)  blocks with such from an older snapshot=
=2E=2E=2E which would then perhaps decrypt to something non-gibberish=2E

The question IMO is, whether a (dm-crypt) encrypted btrfs that uses a stro=
ng hash function for btrfs (i=2Ee=2E like hash-then-encrypt) would be effec=
tively integrity protected=2E
I never really found a definitive answer on that (as in properly analysed =
by some professional cryptographer)=2E

If so, keeling SHA256/etc=2E would make sense for that use case=2E

Cheers,=20
Chris=2E 

