Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEF924AC04
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 02:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgHTAST (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 20:18:19 -0400
Received: from azure.uno.uk.net ([95.172.254.11]:47066 "EHLO azure.uno.uk.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgHTASQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 20:18:16 -0400
X-Greylist: delayed 3685 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Aug 2020 20:18:15 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sabi.unospace.net; s=default; h=From:References:In-Reply-To:Subject:To:Date
        :Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=s6g6cIvV71faqCDyNALOfjpx8UPS+VaWpdzgXZNwGxU=; b=cwVUwnR732C77DTBU/fFSgDUNz
        lG+KxgGvF2GDExY5dyjsBTzQFAwSdS6/y/OOgdSzvqlKbFp5TjnKevxJ9eBuXKv3N//xoV4YjbWQ8
        S2TYz+Xxm0dZb1kFnDRLmcolpNbDZZq/LoCbUPAU8eLK2htnOzI7UyFhbFcg7ORQ5lV6bptzv9aVe
        F4tGoPKkyfXGhV+8c/FOY9DWyRWvdffBC0SVE7rKTO6qfFBhvQZIHIlD7peatD0nGRv9DdRFug0eN
        3w2WPPX+T9oU68c2xb65aI66VhdLrp00H7cNw2mKSAE64vU+tFjKoGP4cJDmBnnEEF5EcwZVWiEuD
        m6zXbJDA==;
Received: from [95.172.224.50] (port=38846 helo=ty.sabi.co.UK)
        by azure.uno.uk.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <postmaster@root.t00.sabi.co.uk>)
        id 1k8XK5-0006pP-9Y
        for linux-btrfs@vger.kernel.org; Thu, 20 Aug 2020 00:16:49 +0100
Received: from from [127.0.0.1] (helo=cyme.ty.sabi.co.uk)
        by ty.sabi.co.UK with esmtps(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)(Exim 4.93 5)
        id 1k8XFH-00BlEo-Eo
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 00:11:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <24381.45493.238720.540436@cyme.ty.sabi.co.uk>
Date:   Thu, 20 Aug 2020 00:11:49 +0100
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Linux RAID with btrfs stuck and consume 100 % CPU
In-Reply-To: <CAJCQCtTQN60V=DEkNvDedq+usfmFB+SQP2SBezUaSeUjjY46nA@mail.gmail.com>
References: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz>
        <CAJCQCtSfz+b38fW3zdcHwMMtO1LfXSq+0xgg_DaKShmAumuCWQ@mail.gmail.com>
        <29509e08-e373-b352-d696-fcb9f507a545@xmyslivec.cz>
        <CAJCQCtRx7NJP=-rX5g_n5ZL7ypX-5z_L6d6sk120+4Avs6rJUw@mail.gmail.com>
        <695936b4-67a2-c862-9cb6-5545b4ab3c42@xmyslivec.cz>
        <CAJCQCtQWNSd123OJ_Rp8NO0=upY2Mn+SE7pdMqmyizJP028Yow@mail.gmail.com>
        <2f2f1c21-c81b-55aa-6f77-e2d3f32d32cb@xmyslivec.cz>
        <CAJCQCtTQN60V=DEkNvDedq+usfmFB+SQP2SBezUaSeUjjY46nA@mail.gmail.com>
X-Mailer: VM 8.2.0b under 26.3 (x86_64-pc-linux-gnu)
From:   pg@mdraid.list.sabi.co.UK (Peter Grandi)
X-Disclaimer: This message contains only personal opinions
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - azure.uno.uk.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - root.t00.sabi.co.uk
X-Get-Message-Sender-Via: azure.uno.uk.net: authenticated_id: sabity@sabi.unospace.net
X-Authenticated-Sender: azure.uno.uk.net: sabity@sabi.unospace.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[...]

> But I do see in the sysrq+w evidence of a Btrfs snapshot
> happening,

There is a known "limitation" with Btrfs and subvolumes and high
CPU usage, especially when there are many (more than a few
dozen) snapshots:

https://btrfs.wiki.kernel.org/index.php/Gotchas#Having_many_subvolumes_can_be_very_slow

> which will result in a flush of the file system. Since the
> mdadm raid journal is on two SSDs which should be fast enough

Are those SSDs expensive "enterprise" class models with
supercapacitor power backup?

> to accept the metadata changes before actually doing the
> flush.

Each metadata change is am "sync" point too.
