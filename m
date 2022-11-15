Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FD2629F29
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiKOQhq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 15 Nov 2022 11:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiKOQhp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:37:45 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7BDBE25
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:37:42 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1DC2F201442;
        Tue, 15 Nov 2022 16:37:33 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1E8532011CE;
        Tue, 15 Nov 2022 16:37:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668530252; a=rsa-sha256;
        cv=none;
        b=dX4UZRjcqMPo1zFUAC/1h8aa2JcUriyxRQC7c/fSJ4zuQ2O0Lv1z2KzhE5W9kniPh1PHEc
        IFdY8aPj40mVUvZ3h584Es/qsUaN/QzWHrUTtZrM1n7myGVLzFugcukDNGYkKTzpQG5yIm
        WlEyjnyThA9q6CSBdl9v06NwoiqcLra+UwUSTIhdA3ubGikRkA2EOetvhZ4J9p2e7KOUyC
        E5J8wKQOm+SqHeJoAMnaJx+JC9im+DRa9s/tMgJl9p8F1OGjUOCmCVgZzcFAs1GALsI6YE
        HsA4RloV4AUSY6MXv9KxHInHMtuaNr6IdnNceTnPd6hFNs866zxiwHGtFnwzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668530252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RERuhfZkgSGA04hdQflbzHiSSewypoXgEc/x0SNjySs=;
        b=icwhzKooMHPFAV5LTGOkfU8+MDP0a1j0gmAIqD8NQzTYy0YIZspsG37NOH5Alj+6Hjhaem
        uR3e15utpadaGJj1j6zflucYB6i2Zy9zeFBpYgIBsF+2GQB3pgRc614szoIc8MnIV6beRK
        9N9QJgeP7qx4Ic5nTRRn0JOcfLvmYW46Siw6A0sO9rwJMBR36I+McnYgeIUb3LVqyODiL0
        oXXBxJNVQqVdJizudX77D7wvEr9RDDSneKzcXQTt8uDZfwKrNZxsOARsIaFQsoLfrAtSrM
        yy/ImHQg3sCCyzB3PJj193pnRn+b/BtTHoQknAJHUuELu7FaWe+GaoLtq2U9Dg==
ARC-Authentication-Results: i=1;
        rspamd-7f9bbcf788-xlmnm;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Shade-Attack: 27aa4e9505b65b64_1668530252754_402017564
X-MC-Loop-Signature: 1668530252754:1431635422
X-MC-Ingress-Time: 1668530252754
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.99.229.23 (trex/6.7.1);
        Tue, 15 Nov 2022 16:37:32 +0000
Received: from ppp-46-244-242-174.dynamic.mnet-online.de ([46.244.242.174]:59530 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1ouywB-0001TS-Sn;
        Tue, 15 Nov 2022 16:37:30 +0000
Message-ID: <6e601151e5d290a6a6288928e9d8737aca82ed7b.camel@scientia.org>
Subject: Re: [PATCH 0/3] btrfs-progs: receive: fix a silent data loss bug
 with encoded writes
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Date:   Tue, 15 Nov 2022 17:37:25 +0100
In-Reply-To: <cover.1668529099.git.fdmanana@suse.com>
References: <cover.1668529099.git.fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1-1 
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

Hey.

I recently sent | received a lot of previous data, thus asking:

What exactly does encoded write mean? Is one *only* affected when ones
used compression - respectively if one DID NOT do any filesystem
compression (i.e. compress mount option)... can one be sure to be safe?

Thanks,
Chris.


[0] https://lore.kernel.org/linux-btrfs/cover.1660690698.git.osandov@fb.com/
