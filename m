Return-Path: <linux-btrfs+bounces-18247-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A49FC04B90
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 09:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 622724E8376
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 07:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66942D6E58;
	Fri, 24 Oct 2025 07:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="SNMe80Px";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yBgvt55U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ED22D6612
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291007; cv=none; b=TDTPtRCZU8tNfw9zd3xIEIz6VFKs0CihvhD2Y7jrIpJq0Qete/XGcxats23lLDAJXmXT9GdbwjLZ5s1p2DBBVMo6EHFoVqz/SE2RPvc7t0KkyNFpnXU1rQvG2GWFsoHcjZDXzaAYxgf19sxgOimFJAS23jywH2XOwjVZ5YnEDSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291007; c=relaxed/simple;
	bh=P7FJs95KCk9UgGoHZrhDZTgGOfiG3mr1N9/oLHMz7QU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lKRkK+VJmNx6r1Pa1gLWuLVYlJq/V+bPvpkt7j5XwjYJRZyGBBncTCZoSu0GJKUJ+4jqWNGOTSKFPYOQeZNnhlJF/ZmdvSma5HRzQGcPtNtYPoZTR3uEiCUTb39NM59FSb+LHGFOpg9r+4Z/BZfLg1NGXB9lVyJq8hdtayMNb2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=SNMe80Px; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yBgvt55U; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0CFE0EC0278;
	Fri, 24 Oct 2025 03:30:05 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Fri, 24 Oct 2025 03:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761291005; x=1761377405; bh=wvGVR7WwIJ
	FdxM42OwiQLXBTpm6AL9thDTDon4wn/tA=; b=SNMe80Px1AjVvRo0Vi91aBQ7i1
	gD0GvmIJFLJLxdhSBJVzs/TV2gdTc5a5uy1g2hb1QlAQ9W3M0TYUdhGf1e8ACb4x
	9G5WvC/F1owFY5+/DDbFv02Tg++oejnUJpEedujoqG1OH26EQLSdial+QjmH2wSh
	ai/63cTcSEJUdlZPRp+l45yaqc4ExQD9NWV/DmoYQ3o4IwxFTaXXUPIJQKqQQnDp
	V/4XMC8zXDl3aJ7AWW+9bOHZv7ja+LX3l849AJUaeUbQPyh3m0rI9PjImP1g3lbH
	P0VpukQv3p3cR3SbJd14X0e24+TltutcfZ/veqVKz44dvvrP21HCuDTLTsJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761291005; x=
	1761377405; bh=wvGVR7WwIJFdxM42OwiQLXBTpm6AL9thDTDon4wn/tA=; b=y
	Bgvt55UlfPGqM4kZqSXLHPY+DkYXgePw7STM/PsSWE7pPqY6A/sIY7XIMoDIDHls
	4aT40KptdWXpSfXFJCEw3pVgeb3ZCADxfAvIqb//60/FtQsFChlxwolVp/m3nHIT
	ulthz6rNJ7vb66fv3ta4tTRjPeFo/7Nx+YvtkgDvmfduPgVBuDix26D6aK0ueWEI
	fD8WPOMlyOSGQQvDsAID10dEB4Q5ex2R7XO1LQmn8645l4ZP16gp1ewmwEuUYqPz
	LtGOtXdubPi5m3d40f/GKrTWs2eWA0Xax63Eqc+5p/Er4SUQC6ahg83bgixPw6eu
	2nrAwH6K8yMJmNrji33hg==
X-ME-Sender: <xms:_Cr7aO0dSHwT44u0C2seu2gH6y4x8UudQ5nu1xBafe7t0TCtxrFfGQ>
    <xme:_Cr7aL5_oq2I5v_RkiodemNh9UkN2gLZFeOGihIYaNEJ3B5rnH90mKiFzSnL0-h2V
    eD09VOQrKEMWjEfztRBEH8OmzNtAybIHSN9Rm2gHyPe5usQSp8IlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhrhhi
    shcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqe
    enucggtffrrghtthgvrhhnpeekhedtieejleeuleetvefgvefgtedvhfegtdejieffhffg
    tdeutdeljeevgfdvueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeduudduiedtieejse
    gsuhhgshdruggvsghirghnrdhorhhgpdhrtghpthhtoheptggrrhhnihhlseguvggsihgr
    nhdrohhrghdprhgtphhtthhopehprhhonhhoihgrtgesghhmrghilhdrtghomhdprhgtph
    htthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_Cr7aP_no3crise4E7Fcw8K3xcdHrgiyZOhjqOg8n3hwA5R31egtDA>
    <xmx:_Cr7aHIv44J0tQyjsA6z1zAnSDpBgXeEDZUz9UQHyYiFQoCm79iHOA>
    <xmx:_Cr7aAizXvjVpqQeqJI7MDWnnI7HUU1swnAqroRjMgZPRHLRppF_Dw>
    <xmx:_Cr7aP5QuOugYbdk60z81dYjrHW-l0qO2LMcoQ5tFSipzhW2e-GArA>
    <xmx:_Sr7aHJSpXR1iqR35Yxz_f99inItVD28_iBtFNLtHJ3MpKBiex79Spv2>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A154418C0066; Fri, 24 Oct 2025 03:30:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AX6pIN6RInZo
Date: Fri, 24 Oct 2025 03:29:43 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "james young" <pronoiac@gmail.com>,
 "Salvatore Bonaccorso" <carnil@debian.org>
Cc: 1116067@bugs.debian.org, "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <24e2e3dc-6082-4789-bd0c-9fbad164fb97@app.fastmail.com>
In-Reply-To: 
 <CABaPp_j8VZyLUtiKjnTksKqEzpaYj6vw=TEM_=CkMUvA+O3sfw@mail.gmail.com>
References: <175865066509.3489281.5792211607743744274.reportbug@ruoska>
 <aNLr-GKpufof8HME@eldamar.lan>
 <CABaPp_jAFwsobgdk38Qhigqn+Tgb1UQK9RDJF3sCFT1_KH3SQg@mail.gmail.com>
 <CABaPp_j21HxgXFT5JZkKW1QeZmAtxYPAgWKo-nm15mWMvj-7BA@mail.gmail.com>
 <CABaPp_j8VZyLUtiKjnTksKqEzpaYj6vw=TEM_=CkMUvA+O3sfw@mail.gmail.com>
Subject: Re: Bug#1116067: linux-image-6.1.0-32-amd64: btrfs compression quietly stopped
 around 60TB in
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, Oct 14, 2025, at 10:05 PM, james young wrote:

> I started btrfs check with the progress option; within two hours, it
> had gotten to =E2=80=9C[2/7] checking extents, 82 items checked=E2=80=9D.
> I confused the extents with the compressed chunk length - 128KiB - so
> that seemed woefully low on progress.
> Over a week later, it=E2=80=99s still "82 items checked".
> It=E2=80=99s still taking CPU (3% right now) and gigs of memory; it=E2=
=80=99s doing
> something, though slowly.
>
> So, a question:
> * is this business as usual for a btrfs check?
> * is this a clue about what happened?
> * is this a symptom?

I think it's understood fsck doesn't scale with storage, for any file sy=
stem.

The very idea of btrfs originally was to be always consistent and not ne=
ed fsck *if* the storage stack is honoring flush and fua. So then it's u=
nderstood sometimes there are write time bugs, hence newer kernels have =
read time and write time tree checkers to check for the common issues.

On xfs they've implemented an online file system repair capability. Agai=
n, it just takes too much offline time to run traditional fsck on big fi=
le systems.

I have no idea how long 151G of metadata will take for btrfs check. It's=
 very memory dependent. There is a lowmem mode for btrfs check but it is=
 even slower. I'd say it's not worth it to run the btrfs check at all if=
 this is also a 6.1 version btrfs-progs. Too many changes have happened =
since then. But in any case, it's such a big file system, I'm not sure i=
t's worth it anyway if it still mounts.

I'm having a hard time understanding which file system actually broke or=
 if they both did. And there isn't a complete dmesg.=20

Also, I'm not a btrfs developer. I think it would help improve the chanc=
es for a response to have a simpler reproducer of the problem with  curr=
ent stable kernel at the oldest, but ideally mainline. Pretty sure Debia=
n offers them in unstable backports or something like that.



--=20
Chris Murphy

