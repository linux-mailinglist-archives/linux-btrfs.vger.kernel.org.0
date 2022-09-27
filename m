Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BFD5EC86E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Sep 2022 17:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiI0Prn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 27 Sep 2022 11:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiI0Pqz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Sep 2022 11:46:55 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2A54E611
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Sep 2022 08:45:20 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 325468C13E3
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Sep 2022 15:45:19 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 434978C2024
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Sep 2022 15:45:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1664293518; a=rsa-sha256;
        cv=none;
        b=yvd0hsyBek9VR7JT8put4WpxfVA/PRjHyHM6gmKbiHoztUSOrYVo8yb0WN5IG8SQNqcfvX
        HvFrzDNF05Ya7WxXCZb/QY6pv3cPJdGSj9D5OLLjqlQodJaf5NaombsFWMcstepxpfr6DF
        gXNkh7BBnJuFfdiwwiNo+agWBvDxFbpB1geVVj7QwU0/wluioh/TqSB7ai7eaRiDiVuRjE
        r4xvk5+6GhjokaWr2ZUXOFUs2X5rakU7gJzoEfnPDV29f8Dqv3aWNytbVD6h1Va+4Wexss
        BvMOD+dmQ8IasalLRUADkzgI9XN1Ehw2WL8Hk6Mzji/Em30q2S/3DtvHd3XHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1664293518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fh48/dwv5O26FAZ24w6k2208UvB31JX7/C2z4GqUe18=;
        b=iufuI4gMqTpnTVjQJlsJD6Ly5y08aHAgMWOGIpn0BY6s4WHJxTlTZRUUDreIDPATDLnDMA
        32FGF3tHmFVaFtmLRdZEFdB6ZgibSO/6tj0M8bPuoK2CYBr46oUQEE9SZdK0LKgXhC5RZI
        uvxZifEvKFzRvG/qw1BNdS/+lohFox895CpPgWkdiNo5TyfVXD5vwY8TYlje+0lKQX04Q/
        u3EMfA+RCgvc15Q50lPTFJvQNPSRlvwgnBbgNRxR58biX0lQ/Jky6yoYFAH3pe33rr6zRk
        Q5CIsqFltiHFobjEeo6V6ZPiBe4NqypT0x7dA7Q7sH9uN/mTo2d7M8mtR3S2/w==
ARC-Authentication-Results: i=1;
        rspamd-7c485dd8cf-7tvjb;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Trade-Stretch: 329bfdd6073bcfca_1664293518761_2213458746
X-MC-Loop-Signature: 1664293518761:2198436930
X-MC-Ingress-Time: 1664293518761
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.97.77.221 (trex/6.7.1);
        Tue, 27 Sep 2022 15:45:18 +0000
Received: from p54b6dffd.dip0.t-ipconnect.de ([84.182.223.253]:55904 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1odClk-0004M4-QJ
        for linux-btrfs@vger.kernel.org;
        Tue, 27 Sep 2022 15:45:16 +0000
Message-ID: <31660c315eeba4c461b6006b6d798355696d2155.camel@scientia.org>
Subject: btrfs and hibernation to swap file on it?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-btrfs@vger.kernel.org
Date:   Tue, 27 Sep 2022 17:45:11 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.0-2 
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

Maybe someone could help me with that question:

I'd like to set up hibernation, using a swapfile on btrfs (which itself
is on dm-crypt).

Now I'm aware of the section on swaptfiles in btrfs(5) and their
restrictions... and I think these should be fine for me.


What I don't quite get is:

a) Hibernate seems to want an offset parameter for the swapfile. How is
that used respectively why is it needed.

Does that mean that hibernation directly writes/reads to/from the block
device?
And wouldn't that be kind of fragile (if something internally moves in
the fs... or if it's split in several extents and not one big
contiguous space)?

Guess I would be kinda scared to get some corruptions if something
writes directly to the btrfs' block device - other than btrfs.

Are there any suggestions with respect to btrfs? Like not using a
swapfile for hibernation, or is it considered safe?


b) Internet resources say that for btrfs one cannot use filefrag to get
the offset.
I found Omar's tool, but wondered whether the same had been directly
integrated into btrfs-progs in the meantime?



Thanks,
Chris.
