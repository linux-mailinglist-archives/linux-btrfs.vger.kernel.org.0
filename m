Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D535873A5A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 18:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjFVQKI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 22 Jun 2023 12:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjFVQKG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jun 2023 12:10:06 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6FF1BD4
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 09:09:56 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B7A25500C2E
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 16:09:55 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3332B5014D1
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 16:09:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1687450194; a=rsa-sha256;
        cv=none;
        b=k7d5pb9Z0cZx0fP0u75jdm0dTjGz8A9P9CO+8JmK7nqksKnx7OGv6IU9wXTqfmCMAjPvkz
        u644WC9Y+b6y0kkplfc0zgFaIKQ2yI3F/TPlnhwn8vSJF9gTiQDuMK0SnMyt/Gm7UwvM/o
        fRK3tenqfueaDV8X/lvWmgTUwVm18Jn2PWHU5KzFBW1JsKtwlqWXGR0+Qnbg9m9jJ6RRMk
        Xevg0I/vGPrNpTe09ZmxLDCp9hnqB3r80lcAcIdPbl99GHc9b+6VMkam83dqAd7k7ZG5R+
        BQ9XXA6viTRMZhtkjUpynyTHRHl36taageuKqOszd1m5eOs0Tsgkh8V+I3/QOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1687450194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewK1lcviDY20QWSxoEPSOzj+FsNaT8mSDhtK+zHEFmY=;
        b=rDyhbkUYQdFc6J/n1oIYq6DwfNAytb92WicDl9xI0UvI8bXmflNUNzHkHNtsKs+ADgvFBW
        yRsUMEXLT0qTGawB9bkohlcEiNMxQK62RF92glytP1F2jtJC2hS0qetwqST3XFOWsBjzVK
        5qrFR5NH7eW7hmIJjG941NrBwLd/r27bkQhvMtsj5G2ShmeRpnGnE5j0IJTz5yYWJr0leQ
        Ioq0+nLpXnZznFAs9fcfUu9U5Yd4XR6nUkrTWNJqzqWJkKqetSVihYqaTtEQC4xAyVUabc
        IwWAsP6Te16mXRZ6ICrFRTElxufeUWkx2JuYemAMUq8TB8qhwzzxwOGGSp5/7Q==
ARC-Authentication-Results: i=1;
        rspamd-85899d6fcc-pdqhm;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Wipe-Snatch: 140bd0f62b0b14c0_1687450195247_4098382799
X-MC-Loop-Signature: 1687450195247:3459174947
X-MC-Ingress-Time: 1687450195247
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.123.193.136 (trex/6.9.1);
        Thu, 22 Jun 2023 16:09:55 +0000
Received: from p5090fc90.dip0.t-ipconnect.de ([80.144.252.144]:40966 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <calestyo@scientia.org>)
        id 1qCMsW-00H1ZS-1I
        for linux-btrfs@vger.kernel.org;
        Thu, 22 Jun 2023 16:09:52 +0000
Message-ID: <bbccd0204d2951f54f4303aca3af1b6dab2c3108.camel@scientia.org>
Subject: Re: empty directory from previous subvolume in a snapshot is not
 sent|received
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-btrfs@vger.kernel.org
Date:   Thu, 22 Jun 2023 18:09:45 +0200
In-Reply-To: <9fd09e52-e77e-415b-bd95-9c58dde263d0@gmail.com>
References: <ea6099a3cff73c20da032afaaeb446c0b12ec1da.camel@scientia.org>
         <9fd09e52-e77e-415b-bd95-9c58dde263d0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3-1 
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

On Thu, 2023-06-22 at 18:22 +0300, Andrei Borzenkov wrote:
> I think it is expected. btrfs does not support either recursive 
> snapshots or recursive send so "btrfs send" skips directory entry
> that 
> points to subvolume root.

Well it's clear that the sub-volume is not contained in the snapshot or
sent.

But in the snapshot (on the original fs) I have the empty directory
from the subvolume that was not recursively snapshotted.
Shouldn't that be just a plain empty directory... and thus be
sent|received (as empty directory) when I send|receive the snapshot?


Cheers,
Chris.
