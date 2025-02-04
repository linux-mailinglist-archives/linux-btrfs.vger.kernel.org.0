Return-Path: <linux-btrfs+bounces-11269-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FC1A26FB7
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 12:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2559E7A1CDF
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 10:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9E220B20E;
	Tue,  4 Feb 2025 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b="t5YozzXx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E0A20B1F9
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Feb 2025 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738666814; cv=none; b=i1MRI6mSDSERweJ9t000CVuCb2bJ6/d+e5EO/0LTDbCkeqtWyDEKENxzObsduQbU61Y7jwSAcHG09O+aIjo3VH6YJpneU5yLLtr81h9x87brCW5iUnBpdt+Od43PwZYU2fQH68oVbdeIkNhTVXCdfey0kb9EH7ssol6OE6kPIGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738666814; c=relaxed/simple;
	bh=v5HoW2CzmtaDUWZZNq+HKnataL6hOnsol34heiueg44=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=C70v4DYAdTcgMNKDDvNuPexyBJukIrZXDOwilarPs3Ct2mUEsyoKJB9Uh5RRAnFosmTJ8Wpa0UJdmctIN77W43dgC9suUXr6gacdn36qnTnaZpbKrgASv+E1BWopot5FUtNSBNR+DVRHd70Wq7vsF6pKC0G2mMRBpMKZp2IsqzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=massimo.b@gmx.net header.b=t5YozzXx; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738666809; x=1739271609; i=massimo.b@gmx.net;
	bh=v5HoW2CzmtaDUWZZNq+HKnataL6hOnsol34heiueg44=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=t5YozzXxp68N5AzVxGepXV7GYCKOTYZiG15iu0NTXYW+GBnMc6RqT4EUDyqNecD4
	 Tff1QtDj73hlJTQt9jjERQ8igJyhhiQAC1hdY/0LjLMTMStFG2D6mLOur+hwRcf3M
	 U3sa/0zC46wa1Jr1vlWVrMTYHIcT4BrrbWePduBYCGh6ayrJbSXgEoCyTrhYmJzBZ
	 gkTi3igwhAKjP+P7x/m3HHyMy2p0qE2vyjllphDLCzWgDsy8yioSinmhaUfFPFcJF
	 FNaDKBm3ghKBpdWct1RWwFu5PLTIrDXeIZOOu6KFgf9ABByk6zpebZDdn8KDaNtuF
	 9EF1D95gEIUNvk8P+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from gmb ([176.1.11.187]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEV3I-1tdZYZ0YB8-002Gvn; Tue, 04
 Feb 2025 12:00:09 +0100
Message-ID: <a9984709a2cb53366688e924a30037fa39b5c707.camel@gmx.net>
Subject: Re: Infinite --repair super bytes used mismatches actual used
From: "Massimo B." <massimo.b@gmx.net>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
In-Reply-To: <427384fb-0e23-4220-8a91-b94c3b99a6a9@gmx.com>
References: <aff8355c64d68b4995cca0a132d35af527e160b3.camel@gmx.net>
	 <427384fb-0e23-4220-8a91-b94c3b99a6a9@gmx.com>
Face:
 iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Feb 2025 11:55:08 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.52.4 
X-Provags-ID: V03:K1:5fwXD3/7XqZH+rCakfOhQOGrbhPkF8SYGMUSB7CU+tunbSkZPv/
 eGnUZQChf+Me+mSuqTx/Zt79nZsStAGKFi37aA2hMcNoyqcMB7nkcCuiLNXzXegC3HCsRd2
 om7dD2rzEy/JHGdZPxV+g6Wf3ehhsKR8LZNhT2VLXHCDZtGjfg7H8qdoZo2GXetFm5U24Z4
 UeAsPm2daz9a49UPkpYnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xY7pZG5Gp8c=;xTdM5aTLdA+nVFkVpLl6KlDJA8m
 ndOb7XfW0nPRLiPkM2T1GDOaZyI97M8/1ZFmADHBX8bE4f3/uZWZgNaWlkeil96+YPSBkneTu
 CwSxh8SMM1tEB6cYaDEX5uqvUoW1dLy4SDI6Y3ZbKQHxm4uw/H/D2ztorioUaBSGOzAdS7WFm
 ZPTWa6Lw0DujXHHP7FGUaXTV2yB2bFlkZQUZzs5mwilQtr9gy8/Y+4FvZ+4JVeUZNCDI7opnE
 MUqKSPK+oKJcHJ95U+YAESxju63Zt3rqE5ev9YwxRkeIjPMSzpe8lpvgz/x0gYsDG7A3eTNBl
 mqawR6289NksmREvwXSiytHw/cJ874Xp7hIuhZPA+6QM0eXc3/g8DyLhkANRj5tunhIAu69WA
 9JSC9wThcu/0YRhmT2P+lH3ifb8RCkSPNdgoSc/g4b7fgEMn6e3/hCC3T/7IN9fF6PpTk7lVn
 hkOJukd6QLPGoG2frnR9H8aN5N452E0THx6FGdw8Vb7TusZ6GgJHYJbMGvrbn9VYOOwwTrvWp
 mlLgNA28KJGP0512k1rBZtkeAyIvcb8B6cxjsIEysY1Rr6lkNeCvM1U7KpaCdHp1W9YaE9zaY
 sIMob3wqq7+4uVAvPHhXCiDevgiTId+xVO8DfmlIJ+JeR0Ssbyjpuv8aaHBoAVcQR85URFs1r
 k7GIDlc1LQ/xyncTEjqx9rwgQqmVHx4JERVoB3aMHWPY+oj373WzfjPLRr4q7hK0ZkadIkDHv
 ZMVrs+z/9NTmjnun0reGPDM0hjei2Geg3/XiulTC+eeytguMu6dBHYakx2esSpyEwLqxGBO6Q
 myKkxXLhYgvy9DhU+fZ50QLrmjjML0k2hluX2+f4LBqVdzSUrElJ8cw7AbT/A7NssqU5QTJCy
 IRdnQVHa+66VMkvIGeanvDzw2aH4p1kxW4j33HupM9c/GEPg4yHPXYGjc46poeGT0/9TT9oea
 SI4k8Tv97wPoEKCjINAcRVrdhf38YfKUuYNUSYHzu4A+a08dl9TCpuaBubMkIxhIjSXQdGJeK
 WVGhr6jfUIxwmA7ohNu6FEV+UWaNTSgs9UM7iNcTM/JiXJkpbid9VVvlFXGrb+Klxtn2vH3Li
 PtE8sWuEyBIHNemTFyemnJwnrrLcpxyRgTWCWWQBmizvQXfF7EAgkS3iVIh0y7FBWWUlDlfOO
 6kTAVGDlsF5VhZqG3yBQbnuAE6hcqT6XXwvHO/Kt9OO5/31Y/w482KrXWf0auana7IechELhS
 2ZILCr4EacHcaAGS4DXtLII+pDtNAOumyjGKKQi86adLMvDyN2taT9CMG5kXwnFH65IOZBTuq
 T0b3dmbjHKscTUYeA0Zqqanq49a5N933lcoefaq3O7rFlA=

On Tue, 2025-02-04 at 19:48 +1030, Qu Wenruo wrote:

> > Balancing failed like this:

> > # btrfs-balance-least-used -u 80 /mnt/local/data/
> > Loading block group objects with used_pct <=3D 80 ... found 62
> > Balance block group vaddr 1303708893184 used_pct 1 ... duration 17 sec =
total 655
> > Balance block group vaddr 555222040576 used_pct 32 ...Error during bala=
ncing, there may be more info in dmesg: ENOENT, state none

> Can you provide the full dmesg, not just grepping btrfs for that failed
> ENOENT balance?

I did the btrfs-balance-least-used again.
After the btrfs-balance-least-used, new lines in dmesg don't contain anythi=
ng
about btrfs.

> Do you have any "btrfs check --readonly" result before running --repair?

No, I have not. Does it help to show that now?

~Massimo


