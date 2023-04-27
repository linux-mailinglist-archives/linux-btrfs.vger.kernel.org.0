Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE1E6F0F2C
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 01:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344359AbjD0XmQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 27 Apr 2023 19:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344277AbjD0XmP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 19:42:15 -0400
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8327412B
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 16:42:11 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 711D35C1702;
        Thu, 27 Apr 2023 23:42:08 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 558A35C169B;
        Thu, 27 Apr 2023 23:42:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682638927; a=rsa-sha256;
        cv=none;
        b=G4acj6KyIwJqbB0apypsjVNOvfx4vQvFRsIEaurNhIlXoFh13Nl6OnY4K9yJH3h23xrlxv
        YiFCzkgle3TSmeBx1SIqTeEEwDbRKKzME9BHbZC5ZNg0AqwTtDeu3AfiinRgFLx/UZcSNE
        r6EmKEFVnX5rLgX0XxOGgUcJO+LNbI5IzUV3q4H+QJuzBW6VGOdlQlyAwsbHBV+lu7OF35
        7H1V1HzZt3iU8ORJdR3cjdij3dKBv7RwSxXze16r8t0oEanvPsoovA2haVdbkSm6sHGzss
        QLGOgtkn+vmoYEmiHcP5VOm2dyBGcWMIHjWZNemcIhmNWBQfsFroRRUwFlfv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682638927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UPTMUH5f8o3YKSyzK7PNEKZQr8tv+yDOR2cQ4Vcljcw=;
        b=B0v3EwGNBzZcSkP8jgWDoil9odPnWRrzJ5WfkkYsR5e763Ke+qB/Yp9AFLTnkdW5/EhvUT
        pVWuoowQbdwgD9u33+QZtk/OfueHTvFttzYa4I1bpY/kGo4l3xtH8AWn7JeLL3f8y4IXgr
        sOtcwn6rgIcm5B1UXyP8BYkAlvmq3k+15955JXFMuihrR9C7ArT2OwfTaaOS3fztNdkIyB
        Yw6vPH7w0axcFGkT28ilNWKc2Aoj8vmHHKbU74PCkWuE5dE/JAV1/F1oPWkyiwcOVTx7Ez
        R5ZffBpB2pFseoGkgS1sTZ1kSVl6e8ktzL40sl1J6l6wTTr6eQxzIw7Xosw+GA==
ARC-Authentication-Results: i=1;
        rspamd-548d6c8f77-2ctqb;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Cooperative-Spot: 29e11f9d1f2fc032_1682638928117_1069133541
X-MC-Loop-Signature: 1682638928117:1964666434
X-MC-Ingress-Time: 1682638928117
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.104.253.244 (trex/6.7.2);
        Thu, 27 Apr 2023 23:42:08 +0000
Received: from p5b0ed426.dip0.t-ipconnect.de ([91.14.212.38]:55250 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <calestyo@scientia.org>)
        id 1psBFS-000nYV-2F;
        Thu, 27 Apr 2023 23:42:05 +0000
Message-ID: <b7827fcee415d416d3a7a07bac0964cdf4fd003d.camel@scientia.org>
Subject: Re: [PATCH] btrfs: properly reject clear_cache and v1 cache for
 block-group-tree
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
Date:   Fri, 28 Apr 2023 01:41:59 +0200
In-Reply-To: <de1a63db-2f30-5969-bc28-a53faaed1608@gmx.com>
References: <832315ce8d970a393a2948e4cc21690a1d9e1cac.1682559926.git.wqu@suse.com>
         <20230427233229.GK19619@twin.jikos.cz>
         <de1a63db-2f30-5969-bc28-a53faaed1608@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 2023-04-28 at 07:37 +0800, Qu Wenruo wrote:
> On the clear cache behavior, I'm working on making it independent
> from 
> the current cache version.
> E.g. on v2 cache, clear_cache would just clear the cache, without 
> (temporarily) falling back to v1.

If you make any such changes, please be sure to also adapt the docs...
or tell me how it (then) works and I may help you out with some doc
PRs.

Cheers,
Chris.
