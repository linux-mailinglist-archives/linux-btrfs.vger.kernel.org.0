Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDC546BF37
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 16:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbhLGP0F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 10:26:05 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:26604 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238401AbhLGP0F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Dec 2021 10:26:05 -0500
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0ED8A6C1C30;
        Tue,  7 Dec 2021 15:22:32 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id B0F486C18F5;
        Tue,  7 Dec 2021 15:22:28 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.97.65.145 (trex/6.4.3);
        Tue, 07 Dec 2021 15:22:31 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Tank-Lonely: 5348d10b5dd437e0_1638890550019_3265735716
X-MC-Loop-Signature: 1638890550019:1711411698
X-MC-Ingress-Time: 1638890550019
Received: from p57b045ec.dip0.t-ipconnect.de ([87.176.69.236]:57126 helo=heisenberg.scientia.net)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1mucIS-0000Oe-FF; Tue, 07 Dec 2021 15:22:26 +0000
Message-ID: <0bfa0a87bafcdc2256b3e917113edc8b5c26a623.camel@scientia.org>
Subject: Re: ENOSPC while df shows 826.93GiB free
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Jorge Bastos <jorge.mrbastos@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date:   Tue, 07 Dec 2021 16:22:20 +0100
In-Reply-To: <CAHzMYBRf63mcgVHiO-8o2UFffjB7Y+7FiOdnWRRb7RzfOBhi5Q@mail.gmail.com>
References: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
         <25d305e5-c75f-3d71-fc5a-c2019e49bed9@gmx.com>
         <c64be50bdc99b993b910a7ab019af8d552eeb0d4.camel@scientia.org>
         <b7b6a6a7-700e-f83d-dae6-581ed6befbef@gmx.com>
         <3239b2307fae4c7f9e8be9f194d5f3ef470ddb8c.camel@scientia.org>
         <20211207072128.GL17148@hungrycats.org>
         <CAHzMYBRf63mcgVHiO-8o2UFffjB7Y+7FiOdnWRRb7RzfOBhi5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey Jorge.

I've looked at your old mail thread... and the first case you've
showed:
btrfs fi usage /mnt/disk4
Overall:
    Device size:                   7.28TiB
    Device allocated:              7.28TiB
    Device unallocated:            1.04MiB
    Device missing:                  0.00B
    Used:                          7.24TiB
    Free (estimated):             34.55GiB      (min: 34.55GiB)
    Free (statfs, df):            34.55GiB
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,single: Size:7.26TiB, Used:7.22TiB (99.54%)
   /dev/md4        7.26TiB

Metadata,DUP: Size:9.50GiB, Used:8.45GiB (88.93%)
   /dev/md4       19.00GiB

System,DUP: Size:32.00MiB, Used:800.00KiB (2.44%)
   /dev/md4       64.00MiB

Unallocated:
   /dev/md4        1.04MiB


Seems similar to my problem... but far less extrem.... so that I
personally would say I could live with that.

Of data you "loose" 0.04 TB ... so 40 GiB... of metadata you "loose"
1.45 GiB


It's a bit strange IMO that you then get ENOSPC, when your metadata has
still 1GB free (thought it would reserve less?)

But still, out of 7.28 TiB, that's ~0,556%... not sooo much.


I in contrast have:
829,44 + 0,5 = 829,94 GiB "lost"
Which is out of 16.00TiB some ~5,066% lost... which seems pretty much.


Cheers,
Chris.
