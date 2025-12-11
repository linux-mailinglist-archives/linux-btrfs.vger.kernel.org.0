Return-Path: <linux-btrfs+bounces-19670-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57902CB6F59
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 19:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57DD4301501A
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 18:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105882D12EF;
	Thu, 11 Dec 2025 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="OkvqZHh4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W7Y3zt5z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04DB2797B5
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765479159; cv=none; b=cGSzFb+Dxis97cqL7y8DQnTlyKn0SiWrGtVHMrRr59eccfQqeGo0pabJbw/vNd+KAXxvbmV0ddDEW6czkUKGjuT8bCNPaioEaeJNAWqHOiE4cjD0fALqn3rVirO//pFpkk92NMaIfbyFZg4CNcn8TyB2YbSq6h9ATUP2CoM+ms0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765479159; c=relaxed/simple;
	bh=FVcqFUi6LV2F7Fb1ls52+ZpUEpqGs0a5vAsD8UzVg9Q=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oiKQRiYBc3XK26E8srdT0D02PLs5cG8evZzZsGbEscFVVHJ78iZLWPoXvbhHQUZA7MNwNlPr8Lfd8WRkLv/9hRC0ikBNvikFyEqHv5/AJz/ByZmCtQAAGgfHyFNfn6BWYmtNHh8wpMuHA0n4zUtbyL70F0+8xECceC/pMcadofI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=OkvqZHh4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W7Y3zt5z; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 84E3514001AE;
	Thu, 11 Dec 2025 13:52:36 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Thu, 11 Dec 2025 13:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1765479156; x=1765565556; bh=wtPk7k+kfmjQ0qdI8aoBc
	E8G8GJ0htJWO/4ergfBIrM=; b=OkvqZHh4ReHBmI6w6F/eC77OZPRkvnOu+ITVH
	oEQn3Y/mwXStR18eEWy/6lmLv5ZEcmzSkIqPbmf8UAwdRid6afoWXxQbaAV/2uCT
	arkX1ZVrDnd17QQPiGPHaj7mF7Wdh/o3C1Wd/L6zYiuSaYiZssRNC8NSO+O/EjBq
	u3MPQZau0VTQWBwZM6rVM36PL1p4M5+LNGd2C8L0GVfj3As4TYmb4nzweyq/vpv0
	M5hjjof3beDVvmqXiteUFCLYsz22CCscrqZvlP/SMuOLjH06Y7Btx8nVLijyGDbY
	bKEuqWpiIqI7gYAZu+0Nfuz4PMhMwVkeMCwAho8ho4sHTvnpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765479156; x=1765565556; bh=w
	tPk7k+kfmjQ0qdI8aoBcE8G8GJ0htJWO/4ergfBIrM=; b=W7Y3zt5z082eH8DE0
	hzVyiTm12M8YFBczLWuymttBxctbJjUlYFQQ9FRhrIXX6alkSVljSF0brIBPmJQc
	m+zyFzdvLWPskLWX0Z0dZdyi8FyGR2AwvGMQKdqXwieNMJcWPYYfXJLJY6xRkDp6
	uiYnD05PKoQ7O30G45uYuwSr+GXrnw+Hd5yKoeEMR1y6XFDV1NCz+bu6R4x86+C9
	u3zFYasLJFQeasnxm6sp+IXkYoVcbxVON07rfE93WtXkR4E4BDueA26+Dcx5rsw/
	oS5x8dJR9tcVBkYWQQAVgGttuOnErSLqhxQsLSgD6xGqrxUGEVkfzIN5SVZfCCYW
	AOZrQ==
X-ME-Sender: <xms:9BI7adHS0WWuR91jxVdK37f9RfLICwPQZFjSdH1GFIC3_ywrP1IyAA>
    <xme:9BI7adJc-U8_sZXuN6paS3lHOA4h8rHeGWqF5nPQkzJmKyPiu0T7URtLe0UtPzmIj
    gm2y1o8G9xINKn4tKQJZS1Tn7Z-nAkwPfR3tvT-M8rM6gDt11Tqp0Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhrhhishcu
    ofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeekieeujeekfffhvedvfeegfefflefflefgjeeiveetveelffeu
    uedvgffhudejhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmpdhnsggprhgtphht
    thhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifqhhusehsuhhsvgdrtg
    homhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:9BI7aTyQ6l9ceBqfZB3BufjN4_4tlakFhvaq8nVwgTkXkbWigWXHlA>
    <xmx:9BI7aZOan7v7AH_YmaJOxgAJLhxDUsvM0-xJtCxPFG6H_dAkDswRAg>
    <xmx:9BI7aU5gHytRIh6KotrgF6-jNeORoIQnGw4g_QECFxbrTSDVB9XaFQ>
    <xmx:9BI7aaMAYpbhNYmBChrBpiTaHJ58-On9hXd899DcFlFAevZCfsAQUQ>
    <xmx:9BI7aVGSxNlm0ZHUzwcv_3acjjKi-p0TEIrmW9hzawbwHT1840a3balX>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4769518C004E; Thu, 11 Dec 2025 13:52:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5g2OpuDMuvg
Date: Thu, 11 Dec 2025 11:52:16 -0700
From: "Chris Murphy" <lists@colorremedies.com>
To: "Qu WenRuo" <wqu@suse.com>, "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <91284ff1-bb1c-4f20-83a6-c1499d45a0e9@app.fastmail.com>
In-Reply-To: <651e259c-ac24-49d0-8eba-4d9c7c9f11c8@app.fastmail.com>
References: <e2095d93-fa47-46b2-b894-0918b6ce348c@app.fastmail.com>
 <d9ab1004-a7ff-4939-9692-0c8f32df27a9@suse.com>
 <651e259c-ac24-49d0-8eba-4d9c7c9f11c8@app.fastmail.com>
Subject: Re: kernel 6.17 and 6.18, WARNING: CPU: 5 PID: 7181 at fs/btrfs/inode.c:4297
 __btrfs_unlink_inode, forced readonly
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Thu, Dec 11, 2025, at 11:01 AM, Chris Murphy wrote:
> On Wed, Dec 10, 2025, at 6:55 PM, Qu Wenruo wrote:
>> =E5=9C=A8 2025/12/11 11:58, Chris Murphy =E5=86=99=E9=81=93:
>>> User reports root file system going read-only at some point after st=
artup. Seems to be when a Firefox cache file is accessed.
>>>=20
>>> Initial report is kernel 6.17.8-300.fc43.x86_64, but the problem als=
o happens with 6.18.0-65.fc44.x86_64.
>>>=20
>>> User previously discovered bad RAM and has replaced it, so I guess i=
t's possible we have a bad write that made it to disk despite write time=
 tree checker (?) and now can't handle the issue when reading the file. =
But I haven't seen this kind of error or call trace before, so I'm not s=
ure what to recommend next. If --repair can fix it.
>>
>> This looks like a previous memory corruption caused on-disk metadata=20
>> corruption.
>>
>> Tree-checker is not a memtest tool, it can only detect very obvious=20
>> problems, it can not do cross-reference, and unfortunately this is ex=
act=20
>> cross-reference case.
>>
>> For this particular one, I'd recommend to do a "btrfs check --repair"=20
>> then "btrfs check" to verify.
>
> Looks like --repair changed from "errors 4" to "errors 6"
>
>
> [1/8] checking log
> [2/8] checking root items
> [3/8] checking extents
> [4/8] checking free space tree
> [5/8] checking fs roots
> 	unresolved ref dir 1924 index 0 namelen 40 name=20
> AC1E6A9C763DC6BC77494D6E8DE724C240D36C9E filetype 1 errors 6, no dir=20
> index, no inode ref
> ERROR: errors found in fs roots
> Opening filesystem to check...
> Checking filesystem on /dev/sda3
> UUID: afdbb979-0b91-499b-976c-0244ba2ed38f
> found 140964491264 bytes used, error(s) found
> total csum bytes: 136339904
> total tree bytes: 969474048
> total fs tree bytes: 751108096
> total extent tree bytes: 62439424
> btree space waste bytes: 178561905
> file data blocks allocated: 490371264512
>  referenced 162984435712
>
> End user has btrfs-image before and after repair if that's useful. But=20
> additional --repair attempts do not appear to fix the "errors 6"=20
> message - and the kernel still produces a warning and goes read-only i=
f=20
> the file is accessed.


Looks like inode 730455 is found in more than one leaf. I'm kinda wonder=
ing if there is a way to compel btrfs to delete the affected leafs, thus=
 fixing the file system. Backups are done so none of the files in any of=
 the leafs need saving. So if I were to have the user delete all the fil=
es in all the suspect leaves - is it possible Btrfs would just drop the =
leaf without hitting the splat?

--=20
Chris Murphy

