Return-Path: <linux-btrfs+bounces-8976-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A0A9A11C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 20:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBFDFB22731
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 18:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955CB2144D2;
	Wed, 16 Oct 2024 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="YFKqXjjO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pYxx8HNX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAB52141D9
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103829; cv=none; b=AeJzgOQTcZtW9bTcs2KfLlHd8/508hvGcicoMkHlJg/IErsTz3A5azYHLqNnMaQsV375N20UroJxCFOfwJ/SOhJ2xVhqmyJ3n+lVZDNSWCY/Ea7e259cZrqmTrZfVo7puF5odbO/mZynJ7YcYLUtpg9Wl8ep1D/wAiZlUxRc1pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103829; c=relaxed/simple;
	bh=ZgYjWrvRtRi+/7sjNvNJ5l//LugVEaWbZyDkTLPWL/k=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lRfs1+PDQhjUhUVuUhIHi7bJH6zuOiKQZ61tEQOlxSBXvkkhkQ3x/taVV4kPao31As5FSphk42AP3/CMlQ7YxsacF6hK0RslydBS7AgL0Iwd1Nlg6SWELZ4+b4Si1gp8skjEeSHm9KGqKwSkB3txbrVR9sAXVmnrFuN1oH6XND0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=YFKqXjjO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pYxx8HNX; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B94EC1380265;
	Wed, 16 Oct 2024 14:37:05 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-03.internal (MEProxy); Wed, 16 Oct 2024 14:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1729103825; x=1729190225; bh=0maLY+63mdFE1jimRU3xM
	Owsr4lfan/snJWFtnbrIcY=; b=YFKqXjjOfJy5M1T2OJwIMJ02jqJIyQe+wSUBI
	zs2rhg2iumV4iOa6WY0pvBKt1FesVh6hW8dEjhZL3dpK99lxOWljGW+/9o92qiUU
	7ZD6Vz+ZsVvfg/m1tWIkCdseDXbXcCrCsH4xEqUJQa85rtsXNWwikXu0My5MPiE7
	0PbYA6dtzTXZdw5YYo3rprd36EuzPRuD7MC553V/YkRbq5em5pe4D7EblMhryz2p
	rLwjpSxZphdxevAdXU1cjIRLDpUdIPJqoLWIx+EKUXNspyl9hQ+5PHCS8mY3XQ96
	LWFTDpL0LUQ9h4Zi3KRddM4ppWvxZ2lMsoguSJ8cKVwvY334Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729103825; x=
	1729190225; bh=0maLY+63mdFE1jimRU3xMOwsr4lfan/snJWFtnbrIcY=; b=p
	Yxx8HNXgfecVsLmIVkATJecYQ7ado7wFWCHlR1q++ACPm+wiL0TxhHJ2/Kv83Dkz
	z/CzC6MTyyJOrYBq5AEHM07hmzyZ/MoY2MedcwbHnFzcSPQ9TeDpS9kAv4nG6AJx
	HQroludPmDS8qGGQqwW+lCDPWGiQLxpJbJnG3Y5cnUKq1RQEJPh9NerXW7hw+id9
	ei+kS0SxhGjsK6naYEOW6F8JjyuSc16nAagnI4xWDLvvHQsVOChAM/rlHGJLJuXn
	w+F3RFKTxP/nnmaWPzIRrsUuPc41Y75E/0/6daOOXLEN/YxBCKLsSqFWcLmOBsyf
	r2fqv9h5l1fFEmzM5rWnw==
X-ME-Sender: <xms:0QcQZynk4acyBMAb_7JqMPqpfb8dOXQwJXr3zvTsOKoYQfWlwvt1qw>
    <xme:0QcQZ50X7ZmQaAocwuYoqvupErDbVWKYey0QzEIlfo6LFoRnhEaSPXaVlj1xXwKar
    hxAvUGoJjXxlrN9vbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfvehhrhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrh
    gvmhgvughivghsrdgtohhmqeenucggtffrrghtthgvrhhnpeeuleehhefgtdehkeeltdei
    ueevvedtgeekiefggeejheduvdfhueelieelleelhfenucffohhmrghinhepghhithhhuh
    gsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghpthhtoh
    epvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrhhgrrhhmshhtohhnvges
    mhgvthgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0QcQZwp0Rm9FZwDSfXMl9NjXGTOiLxWKNLGln4TGWkThKFkhMjVr6Q>
    <xmx:0QcQZ2nQW5dfD7bMW7nMqTkajjx1luI0izQGfv62F98E5Tin3mYOnQ>
    <xmx:0QcQZw3XZVpgN45NGd3XWwk36osyQumf28HVuefmeMQF5eGnmwh91g>
    <xmx:0QcQZ9vadAMbqMx_-08hzjIN0S4bO8VJ6hiidTrVrlT7HW-BEt2HCg>
    <xmx:0QcQZ98fy_pLyTPh_6wFu9GTAb67RFFkw6PqxSbE2CNbYujz5Z2N4wO8>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 71CA41C20066; Wed, 16 Oct 2024 14:37:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 16 Oct 2024 14:36:45 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Mark Harmstone" <maharmstone@meta.com>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <9519ed54-7453-48a6-8862-07472eb99ba3@app.fastmail.com>
In-Reply-To: <6a648270-bf74-443a-bdf2-02026b97d927@meta.com>
References: <4717ca78-1d70-4aa7-bebb-d303c4ada4ca@app.fastmail.com>
 <6a648270-bf74-443a-bdf2-02026b97d927@meta.com>
Subject: Re: kernel 6.8.5, bad tree block start, couldn't read tree root, including any
 of the backup roots
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Oct 16, 2024, at 6:41 AM, Mark Harmstone wrote:
> This looks like a disk error to me.
>
> This was interesting though:
>  > checksum verify failed on 808009728 wanted 0x00000000 found 0xca72d647
>  > checksum verify failed on 808009728 wanted 0x780fa0fd found 0x2ce4b8af
>
> Why would btrfs check be reporting two different "found" values for the 
> same block?

I'm assuming DUP metadata, hence mirror 1 and mirror 2. Both copies are bad, but they are different badness.

User used ddrescue on the Btrfs partition so we still have a copy of it for now.

The user then used blkdiscard to wipe the drive, reformatted it Btrfs, and tested with f3 [1] - there were no errors. And then clean installed Fedora to get back to work again - so I guess we'll see if the issue happens again or not. But it doesn't appear that the drive has failed.

I'm suspicious of a suspend related bug, but this is a lot more blocks being corrupted than what we usually see with drives that don't honor flush/FUA followed by a crash or power failure.

[1] https://github.com/AltraMayor/f3

-- 
Chris Murphy

