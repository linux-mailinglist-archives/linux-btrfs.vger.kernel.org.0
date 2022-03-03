Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383B94CB5DA
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Mar 2022 05:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiCCEVA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 2 Mar 2022 23:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiCCEU7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 23:20:59 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868F63BA62
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 20:20:14 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CA88C6C1428;
        Thu,  3 Mar 2022 04:20:13 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id D80EA6C1382;
        Thu,  3 Mar 2022 04:20:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1646281213; a=rsa-sha256;
        cv=none;
        b=SXSz/PAgfT84Aoht0TUQqaVpK1aU4kHAmZDjmAR0phCin+e1YMGoV4S1RYqXud+6kxb15Z
        LZgl0SGEEl8QBKQKgfw2dBi+5bZ73hv7xTksWokvQFtvBxJcPV6Dzy/jDqJ0goldZ+QKJ0
        ZAB6/T+bT2ktgAD5BZpHdjkPy3vl/Fg2qr+yUs8YQA1aI/LEMu55jNyiMkSIOpCLf0BRwo
        FbKYyDG53We4qjy/Rf7QqBK4uh9xqOo495ZMIgGulF0GNifN+ugbX6OxQ/e3PrD2sEoH8S
        V2RJ5PL1hyhVULQS1riarM7soYdM2rcMg4KXrrrBZup1OGBAbpp2lqPE1K7PhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1646281213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IL8dfiQBr3tzQf0qUSuv4fretwdXwTXl9dNSvK0fg3c=;
        b=HUtkHVDKUlzsPA06Z0Yl3EUD6MLZxx3atNrxwpNlYFSSXmqdvOBk4j8smlWt8jpean6Udu
        s06fSD23ueRX2Ej22mBGDkPak967nzWt5rRwCS2iPX6pzAD14JZIKR2BC97h4UmRxtGrrr
        g+KlFFQX9uMStEtdCNapR3mYtwb3i64zOstd1pLZpySAsfNUnPGVfh/yflQ9PxwA8+3NN+
        S+E9yOQ8m0XlYbBmO/ft531e85arvcunGj2mlL+SwXFMGl3rljya6bitmbrEooxo6bgqrZ
        LawDiKLxBw5I82G4Zt6FDwouPJ6a7Xaxw3bNfqtTFTikIMr1znb+FRC9NCoMzQ==
ARC-Authentication-Results: i=1;
        rspamd-c9cb649d9-9zrcq;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.114.196.222 (trex/6.5.3);
        Thu, 03 Mar 2022 04:20:13 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Wiry-Sponge: 410f0c5b337aeded_1646281213525_238422185
X-MC-Loop-Signature: 1646281213525:1919412731
X-MC-Ingress-Time: 1646281213524
Received: from p57b04c6d.dip0.t-ipconnect.de ([87.176.76.109]:51902 helo=heisenberg.scientia.net)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1nPcwi-0003zP-CS; Thu, 03 Mar 2022 04:20:11 +0000
Message-ID: <25aa23ab13bff4465d866631086e7310a8675cb1.camel@scientia.org>
Subject: Re: [PATCH] btrfs: verify the tranisd of the to-be-written dirty
 extent buffer
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Date:   Thu, 03 Mar 2022 05:20:05 +0100
In-Reply-To: <20220302185651.GU12643@twin.jikos.cz>
References: <1f011e6358e042e5ae1501e88377267a2a95c09d.1646183319.git.wqu@suse.com>
         <20220302185651.GU12643@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.43.2-2 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 2022-03-02 at 19:56 +0100, David Sterba wrote:
> Oh, quite. I think I've seen only bits flipped from 0 -> 1, this case
> is
> an interesting evidence.

I had actually both cases in that defective RAM module...

Cheers,
Chris.
