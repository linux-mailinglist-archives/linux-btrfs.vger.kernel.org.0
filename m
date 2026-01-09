Return-Path: <linux-btrfs+bounces-20327-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F49D08DBC
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 12:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D302308A40C
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 11:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E598D334374;
	Fri,  9 Jan 2026 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b="N5h5rWct"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4247231CA50
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767957528; cv=none; b=OCeGj2pH8LnLHn5N7tgU4FMUnpcDX5qgmitPRAg3OSckLcam/5drkKzblUBlzAF0egsAWI2MlExLTXEP7T09slQ0pytUgX+xfA4v4BHUktlyrmGznROgbVziOJOs+TwGBal+26jD+3GlIHuxrLUIG614QLVCUmCXMZXYJp+e3y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767957528; c=relaxed/simple;
	bh=nbAedbJNoldUHaaq2qC39l4MDxvlzV5+2A8GM6NlJsw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fxUcHZKtQjb/wD4CDve8de++foe5xGm8e1iNmIcCRzs+M4YJHLRP4/Il4PeQzQvUFmvXHJIOAKRFRRjTlG2zCSylGDM3nVuF9qAZ7hkbmrdbTOP1IdAatLLlDZCA8HCNtqZugOZ8iyITKhNdR4NbcjR8mkEQpVUBM7inKY0IB7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b=N5h5rWct; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1767957524; x=1768562324; i=jimis@gmx.net;
	bh=nbAedbJNoldUHaaq2qC39l4MDxvlzV5+2A8GM6NlJsw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=N5h5rWcthgaxjhWd1WoscAceqHfplF88UQq7whKrulKc2wP12PcmOTg3S8gQgORp
	 dP4CdOsxfnAertiVjajV1dXUc8AEvMdsqeGhV+eSoenFZjl1fPni8fhUdX5xOMdCT
	 QAP1W2Ps7HOBNJFtVjgcpyDShEOlfkot3/ZkDvwa+pSs8UMKrbl31tEv8C9cB7tOX
	 Bl62u/dgkZcr2K11kI4O5Nj7rVDms7HmEvePQ+Id+MGTKgKZvR7DH2wCKW+8Q/KMg
	 S6LkmtQg3pOXJN6pGfomkU6efnsxfxocD38Svfy7uBnubi5NpDu6az5MfY4QiB/EC
	 Zr7cXVtOmvS905o9iA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.66] ([185.55.106.54]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDkm-1w2Bg41I2S-00x16s; Fri, 09
 Jan 2026 12:18:44 +0100
Date: Fri, 9 Jan 2026 12:18:43 +0100 (CET)
From: Dimitrios Apostolou <jimis@gmx.net>
To: Boris Burkov <boris@bur.io>
cc: linux-btrfs@vger.kernel.org
Subject: Re: error in btrfs_create_pending_block_groups:2788: errno=-17 Object
 already exists
In-Reply-To: <20260108225254.GA2633085@zen.localdomain>
Message-ID: <s7rn1057-p146-7p9n-17s2-oq0r2n642756@tzk.arg>
References: <q7760374-q1p4-029o-5149-26p28421s468@tzk.arg> <20260108225254.GA2633085@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Provags-ID: V03:K1:7FwmxQ4OptuHunlAY5FRORmc6NtUNJiHURjJ2/rRXZ+zY8vN1Z4
 d3A4tWjMZEwOtqpqZ/FMVPTu/V8HIGBIs4XaCLbCjHWn8HqdR9Li3ivgXpzE3nYTHhGzyP8
 Fjq56bUy5+Oax+IQCi7Y7iX0Cy5veBd9and231tJ26b2Cur8VjcCMdyURoIBhseBsBdkUkr
 KraTc9b8IezWItlNkYzkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L5RbD3sQyAs=;rqR1/XA3qO/2GO/wPz4hJ2nz5q9
 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
Content-Transfer-Encoding: quoted-printable

On Thursday 2026-01-08 23:52, Boris Burkov wrote:

> Are you able to reproduce it or did it happen just once?

It only happened once. I didn't try to recover the fs, was worried about=
=20
future data integrity.

So I decided to follow a different strategy, copying the block device=20
containing the btrfs instead of cp'ing the contents to a new btrfs.

If I see it again, are there any debug operations to get more info?


Dimitris


