Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577002F075C
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Jan 2021 14:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbhAJNHi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Jan 2021 08:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbhAJNHh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Jan 2021 08:07:37 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB32C061786
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Jan 2021 05:06:56 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id CB7129C2C4; Sun, 10 Jan 2021 13:06:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1610284012;
        bh=ShFU9YvUn17PJwr7Jv4ib9rVj3WXHcM/DgJ7kZgjJVE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Uaybep1K808SP9kpXxhs/FMtmebjVf11IG3p7xTT/diJMxOF5iJxqRDMqKP/3MJ/t
         7plO5EeMMW+4uar54UA4ZEjOniE6EHtLJVlDb2p/Del/RATwtnmLyHBBHVme3K7oqF
         BKI33JWd4lGDlK6YTd01/4ROSOFOv/LBE884+AeHEF50JpnX+xuj6h9p01acXlrwMI
         H6GmW1wcIP/mXgBTfNswpnTjpJkU1YbUP/pnA7+olph+PbVjImKevER954ssspqpzp
         3tMoFQwr37GWqNt0R20q/PhqmTIMhKcOBo0bnUeNbwstGoavQLd7csmKWevKurYX2A
         9LrDbVOU4NaZg==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.0 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 1E9779B84E;
        Sun, 10 Jan 2021 13:06:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1610284006;
        bh=ShFU9YvUn17PJwr7Jv4ib9rVj3WXHcM/DgJ7kZgjJVE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VpdrA8o3OV73nkTYw5La6krGOZBpMnUBn4YYfPQGuknqyWP9agHDlPiyBot9+ZGe7
         wHmkDu73WHrzanNGSgjSI5z0wNuwax7ZtKCRS9EPAv5QZqTjZhF4eUrscHri0b5rX1
         5Yqp4M11VxYM3FU9HwFKcNOhicli0BtvQ5QtcA6+OijkMKc8VB3auKeM9/r9ivq0qC
         3MlAOT94WulYoWv8fmOPnBo6Kl9cpw7y0hi9o0x6vss2IRdxeVT7rhDXI2RHrNz06f
         EiUnr0iSyzCcWozFE9oH8pYIww5EXcTlJwmWXPZJQFPwoFtHgHHuJtpbj0bMvdMAUm
         eSD3psK9PUAkQ==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 5C92B1D1682;
        Sun, 10 Jan 2021 13:06:45 +0000 (GMT)
Subject: Re: Re: Re: cloning a btrfs drive with send and receive: clone is
 bigger than the original?
To:     Cedric.dewijs@eclipso.eu
Cc:     arvidjaar@gmail.com, linux-btrfs@vger.kernel.org
References: <55cef4872380243c9422595700686b79@mail.eclipso.de>
 <2752504c-d086-0977-06a3-1bb22c799a70@gmail.com>
 <b709a56556c3adfc9ff352f2a51db3a3@mail.eclipso.de>
 <067af02fb023de04276f14aa6f26ae8e@mail.eclipso.de>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <8344b57d-9a2a-f4e9-59cb-42d6a7fa0600@cobb.uk.net>
Date:   Sun, 10 Jan 2021 13:06:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <067af02fb023de04276f14aa6f26ae8e@mail.eclipso.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/01/2021 07:41, Cedric.dewijs@eclipso.eu wrote:
> I've tested some more.
> 
> Repeatedly sending the difference between two consecutive snapshots creates a structure on the target drive where all the snapshots share data. So 10 snapshots of 10 files of 100MB takes up 1GB, as expected.
> 
> Repeatedly sending the difference between the first snapshot and each next snapshot creates a structure on the target drive where the snapshots are independent, so they don't share any data. How can that be avoided?

If you send a snapshot B with a parent A, any files not present in A
will be created in the copy of B. The fact that you already happen to
have a copy of the files somewhere else on the target is not known to
either the sender or the receiver - how would it be?

If you want the send process to take into account *other* snapshots that
have previously been sent, you need to tell send to also use those
snapshots as clone sources. That is what the -c option is for.

Alternatively, use a deduper on the destination after the receive has
finished and let it work out what can be shared.

