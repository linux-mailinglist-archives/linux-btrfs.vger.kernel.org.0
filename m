Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244C6629F92
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiKOQug convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 15 Nov 2022 11:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiKOQuf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:50:35 -0500
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E34810B4F
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:50:32 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CF6D79217FA
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 16:50:28 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 08E58921017
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 16:50:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668531028; a=rsa-sha256;
        cv=none;
        b=YbzFymRAcFoYsPZNEmRxBMsXiA91nrmyoqOccKb3Cg2BVCKxgHI6WCKePDDJLQXP0hyrpV
        sffsY08tx8ftIQXtqmmKsyD83AkuOIAEkl1RRXy+ONsaXzfwka7Xwf29qPYsPzwwRT13XB
        2Z4Ok5uubtnHi78+/7+5PmNyRxJQ92wu8vpnZ9h7EWl53gErh7U6KB7GPBMpGTQOjag4km
        gR2icrnpOA8Ia1BOy/M0eRQgnaFTysmipKxZMk+zSj9cf/55yvpf1k62dTsLX/TNtskKaj
        7D6WTAIwCohnaw2Mqv6+CAAgdfORjX30pfT/3310TGWbCRDZFvwW5CK15m829Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668531028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sNbEFUBrX3sQfu3w+jQ2A9OFdhBVlKnIRbM+zl1ejL4=;
        b=YpVVu+yFtvr4+XIVSR/A7lzJINutLFZuzvNi1P8tp12cw+/PJZJrwCPlxAup1qU74n23+J
        bX4UQ8EQPidYOWaBgpIb7qji1VvmEUyawA3EL9C1LhXqsUfU4nsqi3DDBb3BauQOtA/ly6
        g4v+eiQ4FnERQxZZcNkKJUTxqlikVEFDy+hmByAPKJb+WT9vCIHN1g40b26P+8N+m30LTH
        92gbzae4V4jdXqgVJkbrs6eOOhwLIofkEywfUfxUhJMKn3rqOckDBJVAOsIRbcLrTh7eNH
        +pX2hLkuRHYs1v4tpaMVzrbffd/kb0H8hcoUmsuxGkj/C1NNdEl2aFeafDo0Lw==
ARC-Authentication-Results: i=1;
        rspamd-7f9bbcf788-dnzdn;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Chemical-Invention: 399ceb262414b52c_1668531028513_3872322075
X-MC-Loop-Signature: 1668531028513:4063823163
X-MC-Ingress-Time: 1668531028513
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.123.200.113 (trex/6.7.1);
        Tue, 15 Nov 2022 16:50:28 +0000
Received: from ppp-46-244-242-174.dynamic.mnet-online.de ([46.244.242.174]:42616 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1ouz8h-00042g-FE
        for linux-btrfs@vger.kernel.org;
        Tue, 15 Nov 2022 16:50:26 +0000
Message-ID: <e6a3dcab6f85158ce43bb6c531e6e86c3e5b6caf.camel@scientia.org>
Subject: there should be some better way to inform interested people about
 data corruption issues
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-btrfs@vger.kernel.org
Date:   Tue, 15 Nov 2022 17:50:21 +0100
In-Reply-To: <cover.1668529099.git.fdmanana@suse.com>
References: <cover.1668529099.git.fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey again.

Something more general:


Just as with the most recent (at least as far as I've noticed) possible
silent data corruption[0], it's IMO really most unfortunate and a
structural problem, that there is no useful way for (interested) end
users to take notice them.


If I weren't following the list a bit - and even there only by chance
and depending on an alerting commit summary - I'd probably never ever
hear about it... yet I might still suffer from it without realising
immediately.

Right now people may still have backups respectively the sources they
btrfs-sent from... but perhaps not so in a year when they possibly
notice the corruption (if at all).


This is really no criticism that such bugs do happen - btrfs is quite
actively developed, so I fully understand that such bugs show up.

But for end users its really awful, if especially for silent corruption
issues there is no alerting mechanism.

And yes I know, other filesystems don't have one either - doesn't make
it better though.



I'd say a simple corruptions announcement mailing list would do:

No other announcements like "new btrfs progs version" (unless that
would fix a data corruption issue). Also usually no announcement for
issues that were 100% user-visible (like general crash when btrfs tries
to mount a fs) OR which have no impact on data consistency (e.g. if a
bug would prevent the "compress" mount option to be considered at all).

Only really serious things that could cause data loss (perhaps
including confidentiality issues, like with fscrypt).

Per issue, one announcement mail with description on what it is, how
likely it happened, if/how one can find out whether one was affected,
how one can fix (or if checks against / recovery from backups are
needed).


Perhaps other filesystems would even want to join in, then mails should
be prefixed with "btrfs: ", "xfs:", "ext4", etc.:



Regards,
Chris.
