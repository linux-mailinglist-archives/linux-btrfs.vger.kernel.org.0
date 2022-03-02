Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E094C9A7F
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 02:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238918AbiCBBjY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 1 Mar 2022 20:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiCBBjU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Mar 2022 20:39:20 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D4E59A51
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Mar 2022 17:38:37 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5BE14800D02;
        Wed,  2 Mar 2022 01:38:36 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 64252800E21;
        Wed,  2 Mar 2022 01:38:35 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1646185115; a=rsa-sha256;
        cv=none;
        b=izuDKGaWkxtMyzdR7mWzmdmYMXDEhwJsj2nJ86Y5LifD6n1J126579T9y3QeokMdjmsQwB
        1hf4snFRPkGcnwfA1Th5OKEm+h/rilLAWdk/R6oiwbUSFhs2mb9U5po5uifxQdZ+XHeSsC
        lq4LKJygr0BDHjjj7eIzEhQu3KRdVhMC7RZaavkDIc8Opd0lLV6RGN5KAkgApuPZwMCjbv
        vGd8qUEH9TegdYwYBZpQylcje29mAJhvVyH32515UXc/ndzaS3rJ2ALM86wvvs+hWc9O+B
        KAT9T85hTui4kSmQ6GS2Wt9s5KyAu8M/za+EPt0vCQomgvJxCFw8mYUzSjkMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1646185115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NhoLpNUNNfz5L6eprvFcS7q4wr1jC8fu5bgGXGbSzyU=;
        b=hFfZ/WlFxkFQa6DybMYzo3+CbjetsqGmiVZd6+m5AkA9xP3cHIqiIhGrbm7u+PoPMdnjU4
        nY4ka9GnV+lrmhXSWnugjyvcO8llSsZvMn+D2zacu6Kxy+gZ+z5z1zb3PI/W16D+N49vgQ
        v3OA/PmZfFCnMPGe+ldB2nOuFirWr1n80lo3mELwv7a69ZyczFQr99n82z00Z3C0y/ZfNz
        +MRYEGK0K4ejouCGPv/aV/U1AHIlbqUe9OZbR1gbGq42SR+IfwKbItL+fjRhyq//GVV3JY
        nFEl/ZmDUeiVxfC+gna+Cr88h+aowvG098dU8R8Izmk0t3xeQ7dsa/6/CHQ1Ew==
ARC-Authentication-Results: i=1;
        rspamd-56df6fd94d-z6hcc;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.115.218.60 (trex/6.5.3);
        Wed, 02 Mar 2022 01:38:36 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Exultant-Turn: 3015621f7c35fa15_1646185116156_688167471
X-MC-Loop-Signature: 1646185116156:2216318965
X-MC-Ingress-Time: 1646185116156
Received: from ppp-88-217-35-91.dynamic.mnet-online.de ([88.217.35.91]:55150 helo=PSS.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1nPDwj-0001PO-LB; Wed, 02 Mar 2022 01:38:33 +0000
Message-ID: <9d4f9c353ffe8a5b0fec426df7bf056904ddf712.camel@scientia.org>
Subject: Re: BTRFS error (device dm-0): parent transid verify failed on
 1382301696 wanted 262166 found 22
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date:   Wed, 02 Mar 2022 02:38:27 +0100
In-Reply-To: <66d31354-a6d1-01a0-3674-c4976bd7d557@suse.com>
References: <2dfcbc130c55cc6fd067b93752e90bd2b079baca.camel@scientia.org>
         <5eb2e0c2-307b-0361-2b64-631254cf936c@gmx.com>
         <f7270877b2f8503291d5517f22068a2f3829c959.camel@scientia.org>
         <ff871fa3-901f-1c30-c579-2546299482da@gmx.com>
         <22f7f0a5c02599c42748c82b990153bf49263512.camel@scientia.org>
         <edefb747-0033-717d-5383-f8c2f22efc8f@gmx.com>
         <74ccc4a0bbd181dd547c06b32be2b071612aeb85.camel@scientia.org>
         <d408c15d-60e2-0701-f1f1-e35087539ab3@gmx.com>
         <9049B0C3-5A30-4824-BCED-61AA9AC128E5@scientia.org>
         <66d31354-a6d1-01a0-3674-c4976bd7d557@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.43.2-2 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-0.5
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 2022-03-01 at 10:30 +0800, Qu Wenruo wrote:
> In that case we should do a tree search and locate that tree block.

... and ...

> Anyway, I need more investigate to be sure on how this happened
> without 
> triggering scrub, and find a way to make btrfs a more robust
> memtester :)

... still anything needed to do from my side here? Or is that something
you just meant for your todo list? Cause then I'd recreate the fs in
the next days.


btw: I tried:
# btrfs inspect-internal logical-resolve -P 1382301696 /
ERROR: logical ino ioctl: No such file or directory

but that fails.


Cheers,
Chris
