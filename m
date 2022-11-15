Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981F8629FA0
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiKOQxS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 15 Nov 2022 11:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiKOQxR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:53:17 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7B260C1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:53:15 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9165E8C1780;
        Tue, 15 Nov 2022 16:53:13 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id BA4E48C16D6;
        Tue, 15 Nov 2022 16:53:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668531193; a=rsa-sha256;
        cv=none;
        b=DZpFBj4S8fO1CpJfjP9CYmPZJiHBKYg+DK4Do7XaWaPoIG4Db4BRU2JzVBlyW+a+IP9r5t
        ilwHiRq+25vQclWS+2zjDoPuYRUO46nvVRLt6pFgkqjO4e3T91wcXZV2BRlWBpT+pq7euP
        5aw0OA8WnuqjyJMcafr7p0PyCrIgmUmbSboeLCQy+XtSbo50mTgLCw96X66ikXu5ibSbwM
        ZnATrgQ8n7cVFuXMknSKuwpj22BGkV9KMyBH4CA8gzKjsA4FFwf/KrqlMYQiP1tA12y9Xc
        3Wr79/Mbj0jKnCvsXGNhu5VYP77UrmZsrzJA0PgG51l1U7v38BcY1b2UJ18cSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668531193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PVdVHJcGfSKvGW+1ivoxv37twKkAJYcoMQ/aby3zJQg=;
        b=8xFJiw4RYFj/RoX9ycxOSLAdheyJ16RRmnr6kyOSi0Ew0ZAXQQnwL6Ie8IZYwjjSIWaYCm
        m4UedBh6Qp3TjFQesK0NCLGCtYOeUdGNFg87nFwzOSkPURyvHsjx1QU2ln9jcLW7kTlFSg
        6zk5dstLi/gPuNRebzy7uq/e00cGjkKcie0g5rmrfu5SfclzBvKAbwdZwYPGlZsleFqoBF
        j9MMxoUxhbanWbe8q7SvpAI7HN89Nfo4RJSAzohNgmd2gb38EfqiQGD+3iMsSaiNXqFE+6
        +eXOHQxdKa1LoHkDAkalSvUQvLxDrZ1bsGZGDoeDNYuT7rYyLBhfiMfZxx8phA==
ARC-Authentication-Results: i=1;
        rspamd-7f9bbcf788-jtzbj;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Abiding-Industry: 30ed509d0e80fbe7_1668531193395_1018114025
X-MC-Loop-Signature: 1668531193394:2018813892
X-MC-Ingress-Time: 1668531193394
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.97.48.93 (trex/6.7.1);
        Tue, 15 Nov 2022 16:53:13 +0000
Received: from ppp-46-244-242-174.dynamic.mnet-online.de ([46.244.242.174]:42532 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1ouzBL-0007fW-Jv;
        Tue, 15 Nov 2022 16:53:10 +0000
Message-ID: <f2ccd7455a18b17b72846c61581db0fda5347829.camel@scientia.org>
Subject: Re: [PATCH 0/3] btrfs-progs: receive: fix a silent data loss bug
 with encoded writes
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
Date:   Tue, 15 Nov 2022 17:53:05 +0100
In-Reply-To: <CAL3q7H5VJM6GY5GN9zjOj3qPhPxRSZhtq8smZkBd4TVJ_vy7Nw@mail.gmail.com>
References: <cover.1668529099.git.fdmanana@suse.com>
         <6e601151e5d290a6a6288928e9d8737aca82ed7b.camel@scientia.org>
         <CAL3q7H5VJM6GY5GN9zjOj3qPhPxRSZhtq8smZkBd4TVJ_vy7Nw@mail.gmail.com>
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

On Tue, 2022-11-15 at 16:47 +0000, Filipe Manana wrote:
> > Is one *only* affected when ones
> > used compression - respectively if one DID NOT do any filesystem
> > compression (i.e. compress mount option)... can one be sure to be
> > safe?
> 
> If you haven't used 'btrfs send' with the --compressed-data option or
> you are sure you don't have any compressed files, then you're fine.

Thanks a lot... so all good for me. :-)

But still, as I wrote in the other mail,... other people might be
affected... and it would be reeeeally nice if there was some good way
for them to get alerted about such cases.


Thanks,
Chris.
