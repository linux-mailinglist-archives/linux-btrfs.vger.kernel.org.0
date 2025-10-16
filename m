Return-Path: <linux-btrfs+bounces-17905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E9ABE5A7A
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 00:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A7F5850BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 22:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BDE2C234E;
	Thu, 16 Oct 2025 22:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="h5OqIdOT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="csMPfqVY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF34118A921
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 22:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760652955; cv=none; b=K3avrO/bZNMW5IjxQUeEMLxzXlRH8wDTK7qei8txY8p7Xj59bw+LvqK+jTDaIY1ZhZpzL1PBhi5JufmPM8OBCIrdKypT9+FUgzf3/iTzy2DdfofBuL/DXAakAQ0HhP4I7ZakdbnPE+J0rlelnKAKpG3AAHyFxd4yzbbmKaH6pLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760652955; c=relaxed/simple;
	bh=heeN1EtBwkjWg2V0+i0K9bun/MLjkDyVUEuKrLWwkX0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Gr7MByprZtf7I4u0sbrtu+w9hFWpINC3PUL5b3rvgftg1i7CeO0LnXcsRnSxheZVrgIDK6YDUMZEWJLb8tPD8ZcXQMJKWbKLyJAmCDVqDbuULIe+KN0ztVMTDSWc7iIjJsD5NsNl9DeUZiiWN0aOW77lfNHa5R/436bf2e7CiHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=h5OqIdOT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=csMPfqVY; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B42CE7A00FC;
	Thu, 16 Oct 2025 18:15:51 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Thu, 16 Oct 2025 18:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1760652951; x=1760739351; bh=z6fc0fzHnc
	ZiOmpuq7opTLcy85k+rSPrC2YEdtIHnHM=; b=h5OqIdOT5tOtMyDiHjTSf2yAA5
	loRT2yyICD7Lngws5v+8URJD+v4AnDaN1RMmsKgyyH7WKoj3eFZw3rKT5mYeb0iN
	RIWqBL5pLD3r8jqtq/vHkwWAXbomrHCZVQWRVx9bNw+XqHyJD++0+zSJx3tUm/g7
	YF7M5Gl0+EFe3mvJ8i1bR+57YmyHPx9QztrxS2Wpcn78FK+PD1bLf8xxPSIRe3yD
	fQ2oeg+9K5pZBmfR6ZpxLfWjWVi4UJk2nenc3Ne6YzV9CKaRNm0xQLUdOIeOHLy+
	r/lQTLfmt7+sdl1mXnuYhhHJVeFKHdxkfPNpkiw2iInCHFue55Ps/I4wsRqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760652951; x=
	1760739351; bh=z6fc0fzHncZiOmpuq7opTLcy85k+rSPrC2YEdtIHnHM=; b=c
	sMPfqVY9l/NUXFDOKFcdhBAaIkV34YBeBTkEI8w5sbFjTZZLf/TXZuX+F6Vmd2lS
	Yz961aodnlOISNX2uKF3aE9r0BWh+D5gFBDKkjqi0IE1ZrFhVRXrJR7bdtcEbPR1
	MQlgtwDQ0TjVoPrBtribFsYpEJDEA9JKyfnq7saZLDt/dVaykwfcxCsAeNwT8PLP
	x2Rtpqi9rag0dheA8f0A09/djyRmoG7Ir6x9woSJxhGTO2pKUaHE10uPBdw3O4KY
	N/4RuFQT6u3O3/nAWUNhsACX/awh/3MUIft6X8s3eP6MjSpYnjTYPvQ4llikTsBM
	007uygMyX5n/xqoRHckng==
X-ME-Sender: <xms:l27xaEGbEL9RckLDq8LfW3Ls19z2fDOK8RITy9XYcl2-ot0ormlDCA>
    <xme:l27xaIJUCZ-anqgnip-g-ZbztVL2i8FTuqNvLUVlzwJVzYdq9tW4AueGDEzRooJb_
    SKWDxYZ8LwH0glWpKjRp1ZQZyO0F8g6c6E2JylP4kk2pdMarXNmk9s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhrhhi
    shcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqe
    enucggtffrrghtthgvrhhnpedugedvfffgfefhueetiedvkeetjeehieekieeljefhfefh
    feelffekleeutefgteenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshestgholhho
    rhhrvghmvgguihgvshdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepshgrfhhinhgrshhkrghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:l27xaKxULFnha7mCHVgwSFnW2-O-IpssxRvSbswgThT9dI6s0dH8HQ>
    <xmx:l27xaEPeXCpDBTxfRVPBKP33FROo7zTsDTkELpwd69R1qfavUxgnyQ>
    <xmx:l27xaD5SxWLGPkqLqNWwuV1LB7d3ipVm5aBf_aDw8qJ4rV7spK5TXg>
    <xmx:l27xaNOjp4h5b9JGEpy6RYDiA9pxQYUEEEdSxMjUdx-HeugKYVTGZQ>
    <xmx:l27xaE4LY21TXq7JK3bfT3a5x444qwZWaDSvxvS46XFHqMmaPT6CVHqN>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5760718C0066; Thu, 16 Oct 2025 18:15:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYAte_pFYg7k
Date: Thu, 16 Oct 2025 18:15:32 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Askar Safin" <safinaskar@gmail.com>
Cc: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <30c367f1-f65d-4ba5-a4a3-776bb308a682@app.fastmail.com>
In-Reply-To: <19dd908b-12df-45ad-bde4-ab7281557608@app.fastmail.com>
References: <d93b2a2d-6ad9-4c49-809f-11d769a6f30a@app.fastmail.com>
 <20251012085256.8628-1-safinaskar@gmail.com>
 <19dd908b-12df-45ad-bde4-ab7281557608@app.fastmail.com>
Subject: Re: 6.17rc5: btrfs scrub, Freezing user space processes failed
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sun, Oct 12, 2025, at 6:10 PM, Chris Murphy wrote:
> On Sun, Oct 12, 2025, at 4:52 AM, Askar Safin wrote:
>> "Chris Murphy" <lists@colorremedies.com>:
>>> Scrub initiated, walked away,  and when I come back it appears hung with a black screen unresponsive
>>
>> I suspect here is interplay between two issues.
>> First is btrfs kernel bug Qu Wenruo is talking about.
>> Second is systemd issue, which amplifies this kernel bug.
>>
>> Systemd bug turns simple "suspend doesn't work, but system continues to
>> operate normally" to "reboot is needed".
>>
>> I wrote about this here: https://github.com/systemd/systemd/issues/38337 .
>>
>> The bug is fixed in mainline and stable versions of systemd.
>
> Thanks for the response.
>
>  I've since moved to Fedora 43 (pre-release) which has 
> systemd-258-1.fc43.x86_64.
>
> Fedora 42 still has systemd-257.9-2.fc42 which is what I was running at 
> the time of the problem.

I'm told the fix is already in the systemd I had when Inran into the problem. Fix is in 257.8 and I had 257.9-2.


-- 
Chris Murphy

