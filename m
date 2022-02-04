Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721A44A9C17
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 16:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359750AbiBDPje (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 10:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353177AbiBDPje (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 10:39:34 -0500
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Feb 2022 07:39:33 PST
Received: from smtp4.epfl.ch (smtp4.epfl.ch [IPv6:2001:620:618:1e0:1:80b2:e059:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6891C06173D
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 07:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1643988771;
      h=From:To:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
      bh=XQNlXozYnmHcLs/6cDFwQ+IebQcVTfKAo0R1vSMgCq0=;
      b=YNTPc++RXkb2Dn9ngjy3PDMmFyoKQNC6/uf/xPkcMKh36pAyaHzxrsonub2TcCybo
        lmBhKWcKkaV6i0wB4d/nF0AtY1kbNTwgq3fnWy0+yrRmr9Uxz6AG7NDEukx1kdmCW
        /RjYoJzQ8E3StWdTWIjhpZ9P8UzyGaRwPS240HVBQ=
Received: (qmail 52803 invoked by uid 107); 4 Feb 2022 15:32:51 -0000
Received: from ax-snat-224-170.epfl.ch (HELO ewa04.intranet.epfl.ch) (192.168.224.170) (TLS, AES256-GCM-SHA384 cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Fri, 04 Feb 2022 16:32:51 +0100
X-EPFL-Auth: SPHUEW8nrxthjr92E6JqU6NNYRyf11JpgVY+pZtCY4qPkSh00Qw=
Received: from ewa07.intranet.epfl.ch (128.178.224.178) by
 ewa04.intranet.epfl.ch (128.178.224.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 4 Feb 2022 16:32:48 +0100
Received: from ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a]) by
 ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a%4]) with mapi id
 15.01.2308.020; Fri, 4 Feb 2022 16:32:48 +0100
From:   Lyu Tao <tao.lyu@epfl.ch>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Questions about inode locks in btrfs sync and fsync.
Thread-Topic: Questions about inode locks in btrfs sync and fsync.
Thread-Index: AQHYGduVVizadrOgAku5U0T7Ovhz9Q==
Date:   Fri, 4 Feb 2022 15:32:48 +0000
Message-ID: <855e98d825934272b2938255e0c8973c@epfl.ch>
Accept-Language: en-US, fr-CH
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [178.199.230.7]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I'm new to btrfs and sorry to ask a naive question about the sync and fsync=
 in btrfs.

I browsed kernel code and found btrfs uses inode_lock in fsync() but not in=
 sync(). Is that right? If yes,  why not use inode_lock in sync() and does =
that mean when synchronizing a inode, other process can still write to the =
inode?

Looking forward to the answers.

Best,
Tao=
