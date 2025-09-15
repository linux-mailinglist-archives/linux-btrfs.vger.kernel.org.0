Return-Path: <linux-btrfs+bounces-16846-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F258EB5889F
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 01:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7248203E1D
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 23:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD222DC32D;
	Mon, 15 Sep 2025 23:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="EO7heUzd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yk8itekp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81AE2DAFA7
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980341; cv=none; b=dnHM9TwiAZdgjzSH65Rw3Rhl94dxa0E6ZFYqgO95AS0eMUy/EzXTglN9fVGLB2Speyy0k2LdfeR7N9LrMqQejycfF0L4VvTF1pD99fn0lmzpOoKNBe4trJRfgm9QqTDNo0g7mKL4V6PNW7lA2fE35a1KJpzX5UT7mPCB8cWXIqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980341; c=relaxed/simple;
	bh=jBS592c2olCHRILLqnufs/EgF0Rv9Ui1GmcYlUM0MFU=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=K+46AkWBkupAVZuKGIta2wB1oohAD+UI1Q58/AEwRHzC8Fb3tUJOJrPk3VpxLC3Uojn9GgKNtZ9zfe7o3hNq6JsMrpSCUc9IPgWp1Sj4IsRydCl5r7ZO6lnqqX3m0eB/jyATAWRd3H1oGUfWXCjA3odW1V9K2b5HgK9xuNUvySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=EO7heUzd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yk8itekp; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DAF667A00B3;
	Mon, 15 Sep 2025 19:52:18 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Mon, 15 Sep 2025 19:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1757980338; x=1758066738; bh=wlLnAyvXzFjlms2m16+WF
	pCBM71AAUFMjiNZyRKP5jk=; b=EO7heUzdfFgLgMFRFf6Vo3Y/jAeefU7lzhwxs
	6KGTm8ptoEBO51LX/gyZsdNntSeEt3o/E0CoXMEm6TlBuSnTrQGoP1wpP6qvG5OZ
	qZbFOLbVqbUaoL3RGZSCHSELYh+r9nlim+BzuVUUu4NeVgBrndX0iL9MniLuQwWI
	ljl6RvqYZyvWNTxumMAQFCQZrzDquG5J4d3dNmbT0jTaUH/6hFY4oU9f21oQTrhl
	CJy5DWtDCDC2Hai3bvSGEGfcmzAPhLa9HvQNH2Ig7MUmd5rz8CHruPLUhW7Gyjbe
	jXMY97uQBUGRuYKwJl+QQ/hryy5ZKu3LwXIXHyD9CzgD1XCZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757980338; x=1758066738; bh=w
	lLnAyvXzFjlms2m16+WFpCBM71AAUFMjiNZyRKP5jk=; b=Yk8itekpVXGjyqb43
	1mMsVh0fbdOB2EnHqbpqwXBwJI1ZeuM7LCWf9cbxD7MPlQC9LO+aGCFdmtaMGhTp
	kSkHS7N6TPll17EPBAhMqw7WVifYHseoVMW/ljbu7srtNalFIBntUxXki3utaclI
	XweH3mlJEUQQKoRH3M1lOeU5nwULSdgrIK5ZWJx1OnPugkov9sOpMZ9fms3PwOMP
	otpxxSGEjpZwubGfWyxxQAaPmK9KeXA+OnRDpXHS2ikNGSI4/Tdf5NZsNPsmwN7E
	XfeLP3PzA1VSe73SwCTaV+3xZ1lU2xFdV7vNN/GcA+YP9WqtMf2xKRPNSw1GczyI
	8Fjmg==
X-ME-Sender: <xms:sqbIaHzhR1HlSvbKb0pGLIKZG557madjtg13pla6eebWYeUGwuFh1A>
    <xme:sqbIaPSFdt55k_jsofhvkRwufHbj8IwgGixP-IM4iy8oETId87t6RW5kZQITuU56N
    zXXjxdnT5E0EWLUxWE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefledtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhrhhishcu
    ofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeekjeejfeetgfefkeegkeetkeehveejjedtvdekleekhfetjeej
    hfdutedtleehheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhr
    vghmvgguihgvshdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidq
    sghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sqbIaL2doIo0chj4-VwYhShrlK9IHzG1_FHW1b-6Qjtrtf_dU_vg9w>
    <xmx:sqbIaDB1HY6wFXwgv7SVAc4pctX2QEQ3mtP046H33k7F-XdYsLMkgA>
    <xmx:sqbIaN3wqz8qJSTNPk_Ik9pfshFhN0N3FOQhagF3QS-zFumCm-o3cQ>
    <xmx:sqbIaNvO7CN668WyZHjXx23i6sIFwW_8XkRaagVyJTVQcwKgMHvqEw>
    <xmx:sqbIaH5DXUBrMKKkjWh1FmyvoBf4-CWiRAl9SECDEZDRm2XL5XqiIKMi>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 58FF218C0068; Mon, 15 Sep 2025 19:52:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYAte_pFYg7k
Date: Mon, 15 Sep 2025 19:51:58 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Qu WenRuo" <wqu@suse.com>, "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <db99be47-16f2-4872-8942-720c5c2fb956@app.fastmail.com>
In-Reply-To: <3e4242b6-7348-44d6-9346-e95095a3a070@suse.com>
References: <d93b2a2d-6ad9-4c49-809f-11d769a6f30a@app.fastmail.com>
 <dcb5d446-adaa-4a6c-b212-619d286d01ad@app.fastmail.com>
 <3e4242b6-7348-44d6-9346-e95095a3a070@suse.com>
Subject: Re: 6.17rc5: btrfs scrub, Freezing user space processes failed
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Mon, Sep 15, 2025, at 7:37 PM, Qu Wenruo wrote:
> =E5=9C=A8 2025/9/16 08:46, Chris Murphy =E5=86=99=E9=81=93:
>> The storage stack may be relevant: USB flash drive -> dm-crypt -> Btr=
fs
>
> And for your original report of no response, the problem is since btrf=
s=20
> is blocking the suspension, there should be no extra reason why the=20
> system hangs.
>
> Unless there are other corner cases like the USB device is powered off.

I am able to successfully sleep the laptop with the same USB stick inser=
ted and file system mounted, if a scrub is not occurring.


> If you can reproduce the bug, please catch the dying message using=20
> something like netconsole.

Difficult. No wired ethernet for the two computers I have available. And=
 previously, trying  to get netconsole to work with WiFi defeated me.


> Yes, that's already a known problem and both David and I were working =
on=20
> this in the past:
>
> https://lore.kernel.org/linux-btrfs/9606fae20bff6c1fbe14dc7b067f3b333c=
2a955b.1751847905.git.wqu@suse.com/
>
> https://lore.kernel.org/linux-btrfs/20250708132540.28285-1-dsterba@sus=
e.com/
>
>
> My solution is to cancel scrub which is the simplest solution.
> David's solution is pause scrub/balance using extra callbacks and a mo=
re=20
> complex mechanism.

They need to become aware the scrub/balance was interrupted or cancelled=
. In any case, they have to manually intervene. So I'm not sure there's =
a big advantage for pause over cancel.

Also, for read-write scrub, is it appropriate for the /var/lib/btrfs tra=
cking file information to be located in e.g. dev tree on the device bein=
g scrubbed or balanced?



--=20
Chris Murphy

