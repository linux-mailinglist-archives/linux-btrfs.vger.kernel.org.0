Return-Path: <linux-btrfs+bounces-1246-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 230BF824695
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 17:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76E0287DB2
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 16:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777BF2511F;
	Thu,  4 Jan 2024 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=friedels.name header.i=@friedels.name header.b="UPmK455U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sm-r-001-dus.org-dns.com (sm-r-001-dus.org-dns.com [89.107.70.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAE5250F7
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jan 2024 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=friedels.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=friedels.name
Received: from smarthost-dus.org-dns.com (localhost [127.0.0.1])
	by smarthost-dus.org-dns.com (Postfix) with ESMTP id 52243A0F08
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jan 2024 17:42:58 +0100 (CET)
Received: by smarthost-dus.org-dns.com (Postfix, from userid 1001)
	id 463E1A0F4E; Thu,  4 Jan 2024 17:42:58 +0100 (CET)
Received: from ha01s030.org-dns.com (ha01s030.org-dns.com [62.108.32.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smarthost-dus.org-dns.com (Postfix) with ESMTPS id 9E578A0F08
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jan 2024 17:42:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=friedels.name;
	s=default; t=1704386586;
	bh=jAHQLaSlFB/jkpg9ZUs/d8hXsDklkt56TofAc4Zh6xM=; h=From:To:Subject;
	b=UPmK455U9x24aMx/+kr18GI5RcI9751wa1OW9XuITje6NcXFx6VwUJNbu3GFeEMii
	 jF2mufF1AuI6HqQTw0TYqPhj+spnSS0Gu3knu2Fv1L4PCYeF1olo3mMLDMqfrtSTTP
	 kTJ+42AEZ3R6WuUEgfavX8P9bJjqM1kIFqPl86h0=
Authentication-Results: ha01s030.org-dns.com;
        spf=pass (sender IP is 92.72.45.242) smtp.mailfrom=hendrik@friedels.name smtp.helo=[192.168.177.41]
Received-SPF: pass (ha01s030.org-dns.com: connection is authenticated)
From: "Hendrik Friedel" <hendrik@friedels.name>
To: linux-btrfs@vger.kernel.org
Subject: How did that file get deleted?
Date: Thu, 04 Jan 2024 16:43:00 +0000
Message-Id: <emc4f98612-9258-4bf1-ae89-82f516287140@a7723c3b.com>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: <170438658625.8145.3995530586806846325@ha01s030.org-dns.com>
X-PPP-Vhost: friedels.name
X-POWERED-BY: wint.global - AV:CLEAN SPAM:OK

Hello,

my system got unresponsive (it responded very slowly), so I rebooted it.
After that, a VM Image was gone.

I find that very odd... I searched syslog for reasons for the hang, but=20
did not find any.
grep -i btrfs syslog revealed a successful scrub the day before=20
yesterday and no issues today.

Grepping my history, I found a rm filename.qcow2old. But that was=20
intentional. I kept and wanted to keep the filename.qcow2 (without old).

undelete-btrfs was not successful finding the file (but it did find the=20
folder).

Questions:
Do you have any Idea, how the file could have disappeared?
Do you have any Idea, how to recover (I have a two day old backup, so it=20
should be ok without..)

Greetings,
Hendrik

