Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B2F68B4DB
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 05:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBFEbj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 5 Feb 2023 23:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjBFEbi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Feb 2023 23:31:38 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D894C11EA7
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Feb 2023 20:31:36 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 00C4B261450;
        Mon,  6 Feb 2023 04:31:36 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id D0F6426170A;
        Mon,  6 Feb 2023 04:31:34 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1675657895; a=rsa-sha256;
        cv=none;
        b=RlfGU1qUhsCJrCQF6mFOHJvrTDBqqRrHaCBiQ1EwRTWaIfBJpAw+4AJaVp4vyelOq6DaDJ
        4DQPFCWFBLAgEXhniMzvpiTj38OkwO+F0r8M0LKOS80aSfx2lbq7hEzKl24sCpjEFzde6N
        kaysJ4JjFXstTZU4kE0+IKS8lmbi34JF3JHch7EG5i41NKO47KfmV7byPlWTONEFbf9Td7
        1NbtDKcAjda2MHE2Gj54jJqUXXTdZO1oI6q+hlyH3a6BTZaUBFoy2aOJdaIY1pxe7Bdq6+
        YOT4dS5b9EasO2/crElB1NBKt92J5LCfhrtNA5FtubocLxa9vLqXLINykhgUVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1675657895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uqe5p0UYaO6SUYRUtIbjGW0YY52+gFTeQ1S7eoXI/T0=;
        b=2PiHiOHmMV8kTCDdYbHYtUO6zSmRB1P2h93awUJk56Drg3udncZMDH9zqg3UA948TsHVT3
        dC3HvvylpAjb+G3BI/avTD5+OyGNSi2jzw4ZjD215Rq7Lp3n2HXinqVsv2rXttq9Qkz+8a
        GKv2bkCNqmrubTVMbfCWDceGWJ7hZtFIrMeI9LqzJlfSHEMDzjPkdka8FLbMDzqlO3lbMQ
        Syc8Oohu/QUOhIpgyvw1LUGKe05XYF73SNmMAnqybYgsmdikrjhqkgNNMZij5YcnsiADEx
        LLx/Hq7n8mjdXnwROp6pr4TiVKi9EmR6dKd8ihfPFFZc9CjtcIFrNE43w+pYuQ==
ARC-Authentication-Results: i=1;
        rspamd-544f66f495-7cmhb;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Stupid-Suffer: 416f79b93b49fbd4_1675657895488_3053424072
X-MC-Loop-Signature: 1675657895488:3123680331
X-MC-Ingress-Time: 1675657895487
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.103.24.28 (trex/6.7.1);
        Mon, 06 Feb 2023 04:31:35 +0000
Received: from p54b6d414.dip0.t-ipconnect.de ([84.182.212.20]:35402 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1pOtAA-0005Bl-2h;
        Mon, 06 Feb 2023 04:31:33 +0000
Message-ID: <bcb9bfe78715e98ea758df3723daa8f9afb2f20a.camel@scientia.org>
Subject: Re: back&forth send/receiving?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Date:   Mon, 06 Feb 2023 05:31:28 +0100
In-Reply-To: <a134a22a-80f2-91a5-f0a1-21145c487118@gmail.com>
References: <10fd619ccbe568df4344b6b1d93f061bc493d396.camel@scientia.org>
         <9a49ccb8-9728-029f-be0e-75ccb8e211d0@gmail.com>
         <3c77c6306ece13559de514940074ac70b4fc882a.camel@scientia.org>
         <a134a22a-80f2-91a5-f0a1-21145c487118@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 2023-02-06 at 07:16 +0300, Andrei Borzenkov wrote:
> You stated that copies are on different media which means there is no
> previous snapshot to apply changes to. If I misunderstood you, then
> you 
> need to explain what "all being on different mediums" means.

There are 4 HDDs:
master
copy1
copy2
copy3

- Files are added/removed/modified on master.
- Once new backups shall be made:
  - a new ro-snapshot from the actual data-subvolume on master
    is made, e.g. with the name of the current date
  - that snapshot is then send|receive(d) to each of the copyN HDDs
    - for the first time, this will obviously be non-incremental
    - subsequently, the most recent common parent subvol on copyN and
      master will be used with -p
    - eventually, older subvols will be removed on all the HDDs;
      on master of course only, if the respective subvol is no longer
      needed for updating any of the copyN HDDs

Figured that's a pretty plain and common backup cycle using btrfs, so I
didn't explain it any further in my original post.


At a certain point in time, the scenario I've described in the original
post occurs and e.g. master breaks or shall simply be replaced with a
new HDD.
Thus, a new master is needed, either the new HDD, or maybe one of copyN
(just as described in the OP).

But at that point, at least that was my understanding from the
discussion some months ago, I cannot just e.g.:
- send|receive from copy1 to new-master, continue there (on new-master)
  to add/remove/edit data, make a new snapshot and then *incrementally*
  send|receive back to the copyN HDDs.
or alternatively:
- send|receive incrementally from copy1 (which would then be the "new"
  master) to copy2 and copy3.

Being able to do so, would be the request of this post ;-)


I mean the data should all be there, isn't it?


Cheers,
Chris.
