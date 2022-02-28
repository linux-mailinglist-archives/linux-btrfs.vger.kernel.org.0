Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAF94C62A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 06:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbiB1FdJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 28 Feb 2022 00:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiB1FdG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 00:33:06 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A08C6344
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 21:32:25 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3D55E121464;
        Mon, 28 Feb 2022 05:32:25 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 450AD120DF8;
        Mon, 28 Feb 2022 05:32:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1646026344; a=rsa-sha256;
        cv=none;
        b=9iXHGDwPQtaa9wb7ZA+ZcjzP4H/h+po50QT2NtylUN+3jtnD/UQE580yg9ZL8HyfebKhHS
        dsUb5SQaWMYX8JXIuQqJzxoijftrXcjOJsJLdoTXjK0jGoS11nrx4vFRauqftrYzrl2jO+
        bA3TywlG54/aC62oe0nIQiXKhRiRjAiycuqXohmSlG1VTiTSsNEO1XabBlvWkojMYUsVYd
        r9sEEO2HGlhSRGV+4S0wM6J6AunRig/U0eDLIbHlcQR07imyxGkx4bb0MMijPpZIxJ/Yhv
        l61ew1duhjfDvjPixvXo+3ohl1JbPkzaodqqA87P4yLdPAGikUC5OWEDhGCnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1646026344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2JScSRb8ZslEw5vvAMOjvSkWiJLPK6pWPHW5M8mcQ9k=;
        b=fvhr4bKR1I2FaruUrByBjpVi/APEwvOI5KkD2Ii1j0hlsqn0oSKcdEHRMHoKi780M5yuqy
        HN3AVpMX71v3wU4nxQG+SERDfdJbzhP6AhPi7wyNDybMYRZKgwF55F8+cPAl0HWQG3fpxt
        7hYGEFkV/OGWNURleuTxlc90cbw3S8+wx3ZsUowU+BdSiko0C5hu7FM/D1DYf31djuw0Rj
        9IYbbUembZF8hDgYcJs6TlxoXLq7GKPtDETwF7KL/W+DTV5ZDINFCO/vclRmtbP1HMvZ3D
        lL6nfEIKjKhiIftMAxVjtDHgKeu9rDzLBkQprjXgCCLEOHz7/hs+jZJigNnCKg==
ARC-Authentication-Results: i=1;
        rspamd-56df6fd94d-s56zt;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.107.255.153 (trex/6.5.3);
        Mon, 28 Feb 2022 05:32:25 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Drop-Wide-Eyed: 676c1c794e29a894_1646026344915_2031468589
X-MC-Loop-Signature: 1646026344915:690431404
X-MC-Ingress-Time: 1646026344915
Received: from ppp-88-217-35-91.dynamic.mnet-online.de ([88.217.35.91]:58802 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1nOYdu-00030f-1z; Mon, 28 Feb 2022 05:32:22 +0000
Message-ID: <22f7f0a5c02599c42748c82b990153bf49263512.camel@scientia.org>
Subject: Re: BTRFS error (device dm-0): parent transid verify failed on
 1382301696 wanted 262166 found 22
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date:   Mon, 28 Feb 2022 06:32:17 +0100
In-Reply-To: <ff871fa3-901f-1c30-c579-2546299482da@gmx.com>
References: <2dfcbc130c55cc6fd067b93752e90bd2b079baca.camel@scientia.org>
         <5eb2e0c2-307b-0361-2b64-631254cf936c@gmx.com>
         <f7270877b2f8503291d5517f22068a2f3829c959.camel@scientia.org>
         <ff871fa3-901f-1c30-c579-2546299482da@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.43.2-2 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-0.5
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

And I still don't understand this:


On Mon, 2022-02-28 at 08:55 +0800, Qu Wenruo wrote:
> The corruption part is a tree block in checksum tree (ironically).
> 
> This corruption makes btrfs unable to read (part of) checksum tree

You say the damage is in the csum tree... is that checksummed itself
(and the error is noticed just by reading the block in the tree)... or
is it noticed when the (actual data) is compared to the (wrong) data in
the ckecksum tree and the mismatch is detected.


> thus
> unable to verify a lot of data.

How much is a lot? I copied the whole fs before, when I made the
backup,.. and I got errors only for that 1382301696 and that one
file... all others, tar read without giving any error.
Is that exepcted?




> For memory bitflip, since it's corrupted in memory, the checksum will
> be
> calculated using the corrupted data, thus the checksum for that tree
> block will be correct, thus scrub won't detect it.

Could that part of the checksum block have been rewritten recently?
Cause I send/received that data at least once in the past to another
fs... and I would have assumed that any error should have shown up
already back then (didn't however).... so the bitflip must have
happened recently... after the affected file had been written to disk
originally (and after it's checksum had been written originally).


Thanks,
Chris.
