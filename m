Return-Path: <linux-btrfs+bounces-1279-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2710825E38
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jan 2024 05:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B3D1C23BFA
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jan 2024 04:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976371FDF;
	Sat,  6 Jan 2024 04:47:50 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C399D1FAB
	for <linux-btrfs@vger.kernel.org>; Sat,  6 Jan 2024 04:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 155816C0EDF;
	Sat,  6 Jan 2024 00:42:50 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id E4C896C0E9D;
	Sat,  6 Jan 2024 00:42:48 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1704501769; a=rsa-sha256;
	cv=none;
	b=EUYaA+aDiF61E1AXs0ft3v4E8y+torcM6IByNO4ECj01IhpesCim7NGfy30D+RRk80QQ7q
	YPE3hNPcSNtiTJHVQXen0lkbXFeh2wg6Skrbm+PbcqiNhj6U1aPRil1g47U+ol/zxYQIz3
	6ndj+D3XDUqABBjcKWWAM+4fHu0VCi3kfXT4DKRKJxd3iG9RYEJbRoVLTNXpJADN0WVqXy
	RzvN9aa08gdJ0q/j+nMlRBUh1EEaEE9PYw0vMxGoQ6GsWiTJEwoUyXOKN6kKhi+9tLHvaG
	RW/ZQOdoMWjewaAhC0pjqozujPBlxg2+ZeWk8Vj8lAA+EhbbAanxSHSmUa5ngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1704501769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+R/87Qapfcz0n8ojtJ1fbEBzYMcsAlvwVw5etR+89k=;
	b=g3OyWxr8hSsHC88Q+Ds1VBgd4n9QDpva1+KgK9JB9gRz29uAROj3axOI9/mzJG3CUZpNO0
	MR4A0d/ELEz96GEDAFZ1bHlEzL6LyRuBOorRLklnhiiOhLnM0jIJqL4OdbrbGVSlJHpUzU
	7WMzCZheqd6qELpRvfzdNV1ddCo4/FstO9RyUWMDhVB5sGuHcvBNsonshFs7znsQ3zEnwB
	3hzGNhfLJqbRDsqEdgiZzlR7juBu7JDLUQmg+3TBl/Mwo1GA7F6nx8jR+9cKGoUjp6Oz3C
	bCSSDQeiwg5uK8kDEVddYxwaAoyvhKiNnAPLKGD9Qz/Qret/pYGQxvcMm48ZfQ==
ARC-Authentication-Results: i=1;
	rspamd-b89458897-5bxrh;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Invention-Left: 58371af30e5fbf34_1704501769562_3215942464
X-MC-Loop-Signature: 1704501769562:2050352099
X-MC-Ingress-Time: 1704501769562
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.115.153.170 (trex/6.9.2);
	Sat, 06 Jan 2024 00:42:49 +0000
Received: from p5090f461.dip0.t-ipconnect.de ([80.144.244.97]:45350 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rLuly-00046c-0l;
	Sat, 06 Jan 2024 00:42:47 +0000
Message-ID: <156b27d5ea42ed4afa6d73dec8e2f479d346786d.camel@scientia.org>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Date: Sat, 06 Jan 2024 01:42:42 +0100
In-Reply-To: <494daef3-c180-4529-befb-325a46a3eeeb@gmx.com>
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
	 <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
	 <9ce30564e238d1be0deafb8cab8968f800a8deaa.camel@scientia.org>
	 <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com>
	 <62e9ad23d4829f30600ea6e611d2cd4636f080cc.camel@scientia.org>
	 <7acc8ea1-079d-42bb-8880-dbd9bbfa100b@libero.it>
	 <fecad7ce2cea1ff125a842d8c53f1fbfe4f1d231.camel@scientia.org>
	 <CAA91j0VNf9UQTYOn688eboGB_bw4YeKOXnKAt1uAYRZwYA3UPg@mail.gmail.com>
	 <b47ed92f14edde7db5c1037a75b38652afa6c1c1.camel@scientia.org>
	 <e6ef9ab3-06ab-4360-b205-3a7559b6b388@gmx.com>
	 <979fd68a4a766f823366797eab1060e5c515a776.camel@scientia.org>
	 <ba9556f9-4784-4bf8-8fa1-49b17df6d31e@gmx.com>
	 <c085dabb449f8088156d906062db0b9fa0f7fe32.camel@scientia.org>
	 <aa69e84f-d466-457d-9b29-47043c2aef53@suse.com>
	 <bf5726d2a30996d06204b17d05daec9c77b7d769.camel@scientia.org>
	 <57a0f910-a100-4f31-ad22-762e8c0ecb39@gmx.com>
	 <513dfa2b00cf496e6f682508037616b6165fcc53.camel@scientia.org>
	 <494daef3-c180-4529-befb-325a46a3eeeb@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Fri, 2024-01-05 at 17:37 +1030, Qu Wenruo wrote:
> but pretty hard to find a
> good way to improve:

I guess it would not be an alternative to do the work on truncate (i.e.
check whether a lot is wasted and if so, create a new extent with just
the right size), because that would need a full re-write of the
extent... or would it?

Also, a while ago in one of my mails I saw that:
$ cat affected-file > new-file
would also cause new-file to be affected... which I found pretty
strange.

Any idea why that happens?



> My previous guess is totally wrong, it has nothing to do with
> NODATACOW/PREALLOC flags at all.
>=20
> It's a defrag only problem.

Sure, but I meant, if a file is NODATACOW and would be prealloced to a
large size and then truncated - would it also loose the extra space?


And do you think that other CoW fs would be affected, too? IIRC XFS is
also about to get CoW features... so may it's simply an IO pattern that
developers need to avoid with modern filesystems.


Cheers,
Chris-

