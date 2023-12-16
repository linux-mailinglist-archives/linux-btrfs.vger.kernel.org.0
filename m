Return-Path: <linux-btrfs+bounces-993-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC87815C2F
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Dec 2023 23:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598E9283A2E
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Dec 2023 22:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4639536B13;
	Sat, 16 Dec 2023 22:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="wiD+IHD9";
	dkim=pass (1024-bit key) header.d=mail.ch header.i=@mail.ch header.b="cm6T0Pev"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shout01.mail.de (shout01.mail.de [62.201.172.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECE61DFFA
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Dec 2023 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ch
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
	by shout01.mail.de (Postfix) with ESMTP id 01265240CE5
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Dec 2023 23:55:30 +0100 (CET)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
	by postfix01.mail.de (Postfix) with ESMTP id DD7A48029D
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Dec 2023 23:55:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1702767329;
	bh=litpp4pir4HV4cWjkq4bKz1pzcGuHobbK0IhU/k+2EI=;
	h=Message-ID:Date:Subject:To:From:From:To:CC:Subject:Reply-To;
	b=wiD+IHD9666dCzaz6x6Vz4vLEpK1Tz9Hn0kWXpSIvIx04ZXLvGnJHfZcMmYcStzF+
	 TXPTwgw8VprfoBOM9m5dwI8ytP4Ls4H7XIm97vUVUpJwhfOpLKSCk1PgH95TfclZnr
	 P8mwjQ8H9P7lR3wmWbTBvJDrueNMxcn00LKCMJrNMm25yOor9Hqzht3xl2/PvfMv69
	 K84qIupUWRzTpH3GfrpDvA6C/nsNWi6KM2HuuxT3OgV00VP+S1crUcM4pLxPedJoZi
	 PCN93kxtwdGdOKHJoSOIOymKG2KyXx4Eajc78660N0jTJYLYYoZPBZ+OMya/jIwojq
	 fJ/AGoxMcKq8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.ch;
	s=mailch201610; t=1702767329;
	bh=litpp4pir4HV4cWjkq4bKz1pzcGuHobbK0IhU/k+2EI=;
	h=Message-ID:Date:Subject:To:From:From:To:CC:Subject:Reply-To;
	b=cm6T0Pev0rVRALXKhN6XCDuwW4FSmxUHXwkMaybYkBacK9BXxIrwVgXeFTrywByFb
	 J2yt0im0RqE/soKsokvOc0CT9J8mFrjXyISRhvsN8cyRw6QTD79yGkYY2FSf7ijGaP
	 RK7OvpRLswGvw6p5lANVjlUfuCVAa+T7WurDUHSw=
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.ch (Postfix) with ESMTPSA id 9F603240055
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Dec 2023 23:55:29 +0100 (CET)
Message-ID: <2a28f019-bd63-4679-a076-892740aa4283@mail.ch>
Date: Sat, 16 Dec 2023 23:55:28 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: btrfs send subvolume from read-only mount with missing ro=true
 flag?
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
References: <a41a77e3-95aa-450f-9712-c5681f8a8912@mail.ch>
 <a5699aee-0e36-4c4c-96b3-aaa04e6b74ea@gmail.com>
From: thomas <thomas85@mail.ch>
Disposition-Notification-To: thomas <thomas85@mail.ch>
In-Reply-To: <a5699aee-0e36-4c4c-96b3-aaa04e6b74ea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 739
X-purgate-ID: 154282::1702767329-46DB8670-D993FFE9/0/0


Thank you for your reply Andrei!

Well yes of course when I can't use btrfs send+receive I have to use 
file based copying instead.
I'd prefer btrfs send+receive, because it's faster easier and feels 
safer to get an exact copy.
With file based tools you always have to think about what options to use 
so you don't miss any important metadata and when I'm already copying 
older snapshots using btrfs send+receive it's a bit annoying to have to 
come up with an alternative method to copy the last non-snapshot version 
which must logically delete and rewrite data that got moved since the 
last snapshot, using extra storage-space it wouldn't have needed if I 
could have used btrfs send+receive.

Kind regards,
Thomas

