Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CDA689F7F
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Feb 2023 17:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjBCQmU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 3 Feb 2023 11:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjBCQmR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Feb 2023 11:42:17 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140B71E5C8
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Feb 2023 08:42:10 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 149AE8210D9
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Feb 2023 16:42:10 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 132A1820C73
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Feb 2023 16:42:08 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1675442529; a=rsa-sha256;
        cv=none;
        b=j7ZFLYen3Ty8QHxx995rgjRir3hCH/FWY4YGst3l6Np3fFAdx0ft+dPqAok9RG6IPiEGzr
        PuVeKjFxO7+Ltppfi1bYhuvB/hxCsxImm2L8vpziZKzMYR4xEOo/cI8dqxPUC6bNmFpfRI
        cMbRunLqdbma6EbjKfK0cUme2qAOIjXl+o2ilS5/S+SOOhgI+cFmCAm5E5K6i+lbFwIRwl
        bd0iLUM/3UXH8KDDegYu2E04xa6JNalkvUh9foyq2aTr8cKCPOpcjRSlMbeFouZV1SLw0D
        3paB/I+RZmbMiHKKYwC0x/A8z9CMdKkIllLp1XOI9syvM2SA24XcQyU0RW712w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1675442529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0A18oe/prORsVDQpA85SRyMKpWM+EwkqQfyS9PnHmWY=;
        b=JKWkBqkTHO5e7htjtO2etVSm6kFYjldK6IWetkhsVWX/BeLqLDT+ms5pzWzpapqdtzGkfT
        s4r70mj7SPudYX3VHEiW3Dzy6OJ/McL4xoNg9oAsvJuz6U+hp4sgbxdNreUynVpY0SgfUt
        dr0yFAPaOHy0H/KUiDEhJjgV9S0aZe9UwlTW2u8npzSqDOoBF+3Q33kjKe2m+ObGdqZ8hn
        fh/hNhjVOstc6HJViA9kWbV/uvH2VPmXX1n5eN8X2raNvuJiHed0bz3fzQFDw7YF5UcApD
        /W8+4ZT/5FoDH0vzadfxc8h3lVkLO6etyF41XBewn9yvkHVqiHgC6TNPhmYQjg==
ARC-Authentication-Results: i=1;
        rspamd-5fb8f68d88-m8d78;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Belong-Eyes: 66c99ae8782f7fcd_1675442529558_206761308
X-MC-Loop-Signature: 1675442529558:1527224075
X-MC-Ingress-Time: 1675442529557
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.99.229.28 (trex/6.7.1);
        Fri, 03 Feb 2023 16:42:09 +0000
Received: from p5b071f3f.dip0.t-ipconnect.de ([91.7.31.63]:57610 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1pNz8Y-0000UH-AL
        for linux-btrfs@vger.kernel.org;
        Fri, 03 Feb 2023 16:42:07 +0000
Message-ID: <10fd619ccbe568df4344b6b1d93f061bc493d396.camel@scientia.org>
Subject: back&forth send/receiving?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-btrfs@vger.kernel.org
Date:   Fri, 03 Feb 2023 17:42:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        HAS_X_OUTGOING_SPAM_STAT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

I've had asked[0] this a while ago already and back then the conclusion
seems to have been that it wasn't (yet) possible but could in principle
be done.

The idea was that one main usage of btrfs' send/receive is probably
making incremental backups.

So one might have a setup, where a master is send/received to multiple
copies of that like in:

master-+-> copy1
       |-> copy2
       \-> copy3

with those all being different storage mediums.

At some point, master's HDD may e.g. break or at least reach an age
where one wants to replace it with a new one.
So either one would make e.g. copy1 the new master, or buy new HDD for
that, while keeping all the other copyN.

Problem is now, how to best continue with the above schema?

Either one just uses dd and copy over the old master to the new one
(keeping the very same btrfs).
This of course doesn't work if the old master really broke. And even if
it didn't it may be impractical (consider e.g. a 20 TB HDD which is
only half filled - why copying 10TB of empty space).


What one would IMO want is, that send/receive also works like that:
a) copy1/new-master-+-> copy2
                    |-> copy3
                    \-> copy4 (new)

b) once:
   copy1 ---> new-master

   following that: 
   new-master-+-> copy1
              |-> copy2
              \-> copy3


Did anything change with respect to v2 send/receive? Or would it be
possible to get such feature sooner or later? :-)


Thanks,
Chris.



[0] https://lore.kernel.org/linux-btrfs/157ed91bb66820d1fef89eb05d00e65c25607938.camel@scientia.net/
