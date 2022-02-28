Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602FB4C6270
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 06:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiB1FUs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 28 Feb 2022 00:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiB1FUr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 00:20:47 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CB739B83
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 21:20:08 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DCFCE861153;
        Mon, 28 Feb 2022 05:20:07 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 061C186174A;
        Mon, 28 Feb 2022 05:20:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1646025607; a=rsa-sha256;
        cv=none;
        b=7NzRp//n1f+5lTppX3WKKA6maZ73zVOyQmAB91OjDJ4rFemtvRpc6duFv7WN0ubaah/fCK
        kLzP4y63DtxgesgccwdW8SbYwuuWIegppG/qwky182fyz2p1iFkrRC2JzjBZD8UeHUb3sJ
        P51jGsjvOacz+juzShX7Tjp0MwbZcGCiRrR2s8RPImANzwcU2jkW/PNoWPhLYe+X6tFZN2
        iJBvcZZ6bZ1UiQB3/k33h3PaVXadRsAquR5y8PThkGTx6TXZMbNJYe3Fj7EWSxzyqRAupd
        d8tiENa4EIrp0QIsI/bI9pWyAviKlmOUMir4gm2rX6YJ37VIiJMQbuH573GNLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1646025607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wVBmy0f/txe0FkzSvlagPBsuPIM6ggfzvG5UKNJijVc=;
        b=VxhMIVCBb0lDIQfi4SEaPgG7NZGQ+LIk3T3dA6xQsmIk5sDyfk4SDP7WGwAWTCU+5OxsUL
        7k6DqBmeMXPVljMGKsxB4PqhvtVkFwGV5bfOnTEAboD/c4R+NC4uEOzx6Zc0ABavnzfZQw
        Ex+b+2YCedrDxOlHjwr5uFHH5sjTmwAC8uQvjN7qZejiKP/E5Xo1+u6O2qUJZ8sGvzUpEW
        nynSejGAKe/4tpHoqL61QancbA902gOrrMDxjjxJltikG/ABP4LqKLG4DRONE/LDzzMbv9
        zcCmJEJpCKH/of1oQ16sAeooGNAigk/ayPrmYTIeMhkmbvggj+tKlYVmbXg8yA==
ARC-Authentication-Results: i=1;
        rspamd-c9cb649d9-n4sgl;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.106.113.39 (trex/6.5.3);
        Mon, 28 Feb 2022 05:20:07 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Spicy-Oafish: 34f9f42c390e7ea4_1646025607665_1577905404
X-MC-Loop-Signature: 1646025607664:2206960526
X-MC-Ingress-Time: 1646025607664
Received: from ppp-88-217-35-91.dynamic.mnet-online.de ([88.217.35.91]:58800 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1nOYS0-00013h-Ck; Mon, 28 Feb 2022 05:20:05 +0000
Message-ID: <cc0d3de26d74f5342681f011459049db8de24765.camel@scientia.org>
Subject: Re: BTRFS error (device dm-0): parent transid verify failed on
 1382301696 wanted 262166 found 22
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date:   Mon, 28 Feb 2022 06:19:59 +0100
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

On Mon, 2022-02-28 at 08:55 +0800, Qu Wenruo wrote:
> The corruption part is a tree block in checksum tree (ironically).
> 
> This corruption makes btrfs unable to read (part of) checksum tree,
> thus
> unable to verify a lot of data.

I see... so, can one find out which files are affected by that part of
the checksum tree?



> Please note that, scrub only checks the checksum.

Sure, and it fails, presumably then when encountering that broken block
and stops completely:
Feb 28 05:56:11 heisenberg kernel: BTRFS error (device dm-0): parent transid verify failed on 1382301696 wanted 262166 found 22
Feb 28 05:56:11 heisenberg kernel: BTRFS info (device dm-0): scrub: not finished on devid 1 with status: -5



> For memory bitflip, since it's corrupted in memory, the checksum will
> be
> calculated using the corrupted data, thus the checksum for that tree
> block will be correct, thus scrub won't detect it.

I though that would depend on where/when the bitflip happens... i.e. if
it happens on either the data or the csum, after the latter has been
calculated but before both are written.



> The problem is not in the file data, but that checksum tree block.
> 
> Unfortunately there will be no good way to reset that bitflip using
> btrfs-check.
> 
> It's possible to manually reset that generation and re-calculate the
> csum to fix the fs.
> 
> But it needs to be done manually, as no tool has taken bitflip into
> consideration.

So how to do it then?

If I could determine which files are all affected and if it was e.g.
just that one,... would deleting it help (assuming that this would also
clear the broken part of the checksum tree)? 

And if not... how can  recover? Recursively copying all files to a
fresh fs would also fail, I guess.


And is there a way to read the content of the file while ignoring the
csum errro?


Thanks,
Chris.
