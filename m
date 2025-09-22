Return-Path: <linux-btrfs+bounces-17046-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB3EB8FA75
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 10:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB03189C888
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 08:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E162836B0;
	Mon, 22 Sep 2025 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="CY647rqY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [129.69.192.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3A5280033
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 08:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531036; cv=none; b=HDyoYF+eaYBd13JNHRlClEXL431qbbQVLCfBZU7lf9bIrlX4UAJKW0vl515i1IWK+QyJT0uDtLyv+qreMqtG7s2/ZZAch1REbttssBPHLsSd7M9yW+tFY/SH9z8g5GZ5V1YzPxWS/VbZjQxZdNjg41/D7WzlyKKlmqIrEcftbmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531036; c=relaxed/simple;
	bh=ZeRbf4IHBsSEyHoS6nwCI5agMehaN61+Pf5McR71dq8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mq05DFyahp8wMf5cIylIBY9KxsSPv3onJuCgsBVoXK7JOrm1lS7jp7Z7i/3lHMqZ+5Sy5raFfXhTeyhXBuaU7CauLjtGDg+rDE0SlleUslknhZr9BqISFpi8rVVYyZ62wFoqRCXM1t2x3rk5zagPYUm4i83uSfyqy2M1ekE2IIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=CY647rqY; arc=none smtp.client-ip=129.69.192.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id 681A860DD2
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 10:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1758531029; x=1760269830; bh=ZeRbf4IHBs
	SEyHoS6nwCI5agMehaN61+Pf5McR71dq8=; b=CY647rqYsMtrnGGNCs7JP7FGla
	5waQfyODzfgl95iCBWV3q32u3FfrAW8bd/kPhG1fb+3q4d3mYdePRgC9sHJ5r6sf
	NWeS85T2ra7PsvJxOfGLa5jcPkN2v3/S93OFC94JMjTOE+HCCCAy6kqtlt4zULeO
	0cv9dfCW5v7KqaW1iYYrc0LNP0Nbo1AUd5/osPP1ai2F1KkM083C+1roc+rMBfU9
	L/o3mvFeT9gUkbD2QAha6uW+IqZ+uVFBaJ9fEg1QghsFAxDUPOVQIcYqJZObjFoG
	Xz1mhIFRQ8YZhz4SWdTlkreoeNAm40RpFyjl5a/yPsKnLdR9LZ5XgczsZrqw==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id QD5aSMskIJbp for <linux-btrfs@vger.kernel.org>;
 Mon, 22 Sep 2025 10:50:29 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Mon, 22 Sep 2025 10:50:29 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: btrfs RAID5 or btrfs on md RAID5?
Message-ID: <20250922085029.GE2624931@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20250922070956.GA2624931@tik.uni-stuttgart.de>
 <20250922100715.7f847dc0@penguin>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922100715.7f847dc0@penguin>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729

On Mon 2025-09-22 (10:07), Lukas Straub wrote:

> md RAID5 with Partial Parity Log is perfect for btrfs:
> https://www.kernel.org/doc/html/latest/driver-api/md/raid5-ppl.html

I already have another system with btrfs on top of md RAID5 (4 x 1.6 TB
SSD):

root@juhu:~# uname -a
Linux juhu 6.8.0-83-generic #83~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Tue Sep  9 18:19:47 UTC 2 x86_64 x86_64 x86_64 GNU/Linux

root@juhu:~# mount | grep local
/dev/md127 on /local type btrfs (rw,relatime,space_cache,user_subvol_rm_allowed,subvolid=5,subvol=/)

root@juhu:~# mdadm --detail /dev/md127
/dev/md127:
           Version : 1.2
     Creation Time : Thu Feb 10 09:38:22 2022
        Raid Level : raid5
        Array Size : 4285387776 (3.99 TiB 4.39 TB)
     Used Dev Size : 1428462592 (1362.29 GiB 1462.75 GB)
      Raid Devices : 4
     Total Devices : 4
       Persistence : Superblock is persistent

     Intent Bitmap : Internal

       Update Time : Mon Sep 22 10:43:43 2025
             State : clean
    Active Devices : 4
   Working Devices : 4
    Failed Devices : 0
     Spare Devices : 0

            Layout : left-symmetric
        Chunk Size : 512K

Consistency Policy : bitmap

              Name : mux:nts1
              UUID : 74388db3:3c3b30c3:e1295cc5:46f23ff7
            Events : 23359

    Number   Major   Minor   RaidDevice State
       0       8       20        0      active sync   /dev/sdb4
       1       8        4        1      active sync   /dev/sda4
       2       8       52        2      active sync   /dev/sdd4
       4       8       36        3      active sync   /dev/sdc4


Shall I enable PPL there with mdadm --consistency-policy=ppl /dev/md127 ?

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20250922100715.7f847dc0@penguin>

