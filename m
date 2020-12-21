Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F056D2E015F
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Dec 2020 21:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgLUUC1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Dec 2020 15:02:27 -0500
Received: from mx.exactcode.de ([144.76.154.42]:53250 "EHLO mx.exactcode.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgLUUC0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Dec 2020 15:02:26 -0500
X-Greylist: delayed 944 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Dec 2020 15:02:25 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de; s=x;
        h=To:Date:Message-Id:Subject:Mime-Version:Content-Transfer-Encoding:Content-Type:From; bh=zXZ0qK8Sw0kWK1CpnF7kTAQNMHqfcAXTprD1qHpWo2I=;
        b=DeHfXkj6lwh/7nxaa5BN1KMynPqUFRToS6X4kkhBmXeX1Gbvj+pscmcflXp9mlypZoXAWkkSffB+NdarE1x7I7Eokk28oevak8Py0sdgkqILgFEVODc7lqXCcWDXwzBW89QJl99DuMjaFuXOQ+7TVG1uWZodKGiQMP1b9uWJEDc=;
Received: from exactco.de ([90.187.5.221])
        by mx.exactcode.de with esmtp (Exim 4.82)
        (envelope-from <rene@exactcode.de>)
        id 1krR8g-00078p-Lv
        for linux-btrfs@vger.kernel.org; Mon, 21 Dec 2020 19:46:38 +0000
Received: from ip5f5af287.dynamic.kabel-deutschland.de ([95.90.242.135] helo=[192.168.0.15])
        by exactco.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.86_2)
        (envelope-from <rene@exactcode.de>)
        id 1krQxi-0001Gr-KH
        for linux-btrfs@vger.kernel.org; Mon, 21 Dec 2020 19:35:19 +0000
From:   =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [BUG] 500-2000% performance regression w/ 5.10
Message-Id: <B4BB2DCB-C438-4871-9DDD-D6FB0E6E4F1B@exactcode.de>
Date:   Mon, 21 Dec 2020 20:45:50 +0100
To:     linux-btrfs@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Spam-Score: -0.8 (/)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey there,

as a long time btrfs user I noticed some some things became very slow
w/ Linux kernel 5.10. I found a very simple test case, namely extracting
a huge tarball like:

  tar xf /usr/src/t2-clean/download/mirror/f/firefox-84.0.source.tar.zst

Why my external, USB3 road-warrior SSD on a Ryzen 5950x this
went from ~15 seconds w/ 5.9 to nearly 5 minutes in 5.10, or 2000%

To rule out USB, I also tested a brand new PCIe 4.0 SSD, with
a similar, albeit not as shocking regression from 5.2 seconds
to ~34 seconds or=E2=88=AB~650%.

Somehow testing that in a VM did over virtio did not produce
as different results, although it was already 35 seconds slow
with 5.9.

# first bad commit: [38d715f494f2f1dddbf3d0c6e50aefff49519232]
  btrfs: use btrfs_start_delalloc_roots in shrink_delalloc

Now just this single commit does obviously not revert cleanly,
and I did not have the time today to look into the rather more
complex code today.

I hope this helps improve this for the next release, maybe you
want to test on bare metal, too.

Greetings,
	Ren=C3=A9	https://youtu.be/NhUMdvLyKJc

--=20
 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin, =
https://exactcode.com
 https://exactscan.com | https://ocrkit.com | https://t2sde.org | =
https://rene.rebe.de

