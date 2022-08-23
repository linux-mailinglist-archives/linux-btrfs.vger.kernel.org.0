Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914AB59ED1E
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 22:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiHWUJh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 16:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbiHWUJW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 16:09:22 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF776402
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 12:27:26 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CF17F2C27DC
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 19:21:05 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 261362C28B5
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 19:21:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661282465; a=rsa-sha256;
        cv=none;
        b=nXdZEY3rxTJe1PawlYRcqzn4dHdVmIJtoebSUZ/Aj+rgViqoEdG8NWLSlfz7CVbyIGpmTH
        mlMTfi3BIRcwn6ByLceuVZbzqndxlJ2z1DUJ4S2xo41eSvHpKlPLvtI+OPnalNswmPEPyr
        DIdpPs/dWGk/3EjWY9dgJ93KzG8+Au5Vcdhh7daqrDM9NY2REvsAWP1DOIrwIQwSNyFEL4
        DRnDn2Asqa9JcQJSKNaCyu+PUbKSsYOVVCMdrKGo+ZzspL5D2At96niVFmNOHCAFljfJNs
        A216hTGiWbQL0qQ1N65t0xOe9Ewj7Mf6fFl7jyamuayUg6iYA+Qejoa4O5UlzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661282465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eU0oKiPx4HEAze5AZD/RMx+Ney/M6CqTBbtNLNmY0sk=;
        b=pmgZscUFlocQQqTN+3yMjOar823R3rx9v/AGSs1Aue1/9PBwB7zq0pWvLAJR+oIt2DYlaf
        MxjKL3DL1k2h8Dnk5RvOoNPulWa9Id3jFNfgVRBgd8zE4Bhr5NWhdSE+di+Bg2Q9GrYDpm
        hZyLiwcJRLO/keCfDv3/DIVEaiEiYJlAmGMUdbyNJ1++u0OMP1B65JzM1zLSlITXmbelhH
        24yEc2el/giQZIsqTVRa8782l5++zOl8UZzAOhCI5oC5s/foPrSYHDnivh2SZBq0U4sk1E
        xmIjCrDcdI9z0D671s1pjvrlbHkZzt8o7K6cR0sS2V/TN3p88IaUsi61hINZQQ==
ARC-Authentication-Results: i=1;
        rspamd-647d8dd55-6swq2;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Dime-Stupid: 6684a16b2280d099_1661282465465_3725068063
X-MC-Loop-Signature: 1661282465465:1889333318
X-MC-Ingress-Time: 1661282465465
Received: from cpanel-007-fra.hostingww.com ([TEMPUNAVAIL]. [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.112.55.195 (trex/6.7.1);
        Tue, 23 Aug 2022 19:21:05 +0000
Received: from p3e9c2863.dip0.t-ipconnect.de ([62.156.40.99]:50230 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oQZSN-0001zk-IX;
        Tue, 23 Aug 2022 19:21:03 +0000
Message-ID: <93a3faed499875c9ef51cf1b0acc29b213dbf28a.camel@scientia.org>
Subject: Re: [PATCH 0/2] btrfs: fix filesystem corruption caused by space
 cache race
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Date:   Tue, 23 Aug 2022 21:20:57 +0200
In-Reply-To: <20220823172744.GK13489@twin.jikos.cz>
References: <cover.1660690698.git.osandov@fb.com>
         <20220823172744.GK13489@twin.jikos.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
User-Agent: Evolution 3.44.4-1+b1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Any chance to get this ASAP in the stable kernels?


Cheers,
Chris.
