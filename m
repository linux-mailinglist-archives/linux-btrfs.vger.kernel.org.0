Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33832CAA06
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Dec 2020 18:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbgLARoK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Dec 2020 12:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730971AbgLARoK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Dec 2020 12:44:10 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1890C0613CF
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Dec 2020 09:43:29 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id CDFA19BBC7; Tue,  1 Dec 2020 17:43:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1606844606;
        bh=StXtQf58t9mhK82HMJh7qaYxjQGXJuEiyurcho7POTI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=NLzYVBKZRKuycja0/sexrD77ncANCgKzHvG4sGCoYDJbn7sCF2b1i0E4uV4lQ46lK
         5l/lHmGVwy82eqNO3Rg7gCDi5QRkf412/w+RlA9/xjed8ncTYeZF9PQaLcHULzPWuC
         ExvKa7Jy3181oz3Su83flOzZ5vjrsKRvQFVV8ayw/hODTgoUjc9mVXWv+8b0q24wRB
         1fQ6eEEiKLNgsV5f5A5lswY27gO/DKmlosFRW/1KQSqQfyMojDxuiz3IQ00yB9iPyV
         hN2eoEiEqDRPjvg4uNcidzvbEL4lT33YTFM3lNTaFX5g3sZn07HET0xOfZo4mTUk79
         Q/f1SyYMpwXjQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.0 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id D6E2B9B6E2;
        Tue,  1 Dec 2020 17:43:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1606844599;
        bh=StXtQf58t9mhK82HMJh7qaYxjQGXJuEiyurcho7POTI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=GohauWpGrnm0tmWGEsvpFe0mDC1AS4wo5DkGOf6e4hWKihMKfYGW+vvwMRMZxz+mN
         MDFt/Pda0TdtbHEoM3c1oZ3mB1L689NPI7pfDGaZMM2YD/613YBmbSvko6lYohWUYS
         iq9jU2CD/QgL0gOG/hKna4inavZm1mjUYibKnwJ2OKiBF/JC0n8Bxtwgo77K7k3Tzp
         u89yRJsPIkrUj23x6Y2FnlGdvPosyGfWdupLtbD00rJ0uSHim2/Kyh58WR9+88uFxT
         sIEG1k3is3EIU9ChlCFJNV2VHE2RVomdplOUTdA+O5DnxPagy4qOuDFiFIdktBxT9o
         0Z8PAbPGrzJiw==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 3CEF31ABAC1;
        Tue,  1 Dec 2020 17:43:19 +0000 (GMT)
Subject: Re: problem with btrfs snapshot delete
To:     Hugo Mills <hugo@carfax.org.uk>,
        James Courtier-Dutton <james.dutton@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAAMvbhFCX5B124V26HzKziJpzMjoYzvhvjTgxeMiauoydGhycg@mail.gmail.com>
 <20201201141712.GI1908@savella.carfax.org.uk>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <21e0697a-0756-add4-1e78-6099f91ecc50@cobb.uk.net>
Date:   Tue, 1 Dec 2020 17:43:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201201141712.GI1908@savella.carfax.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/12/2020 14:17, Hugo Mills wrote:
> On Tue, Dec 01, 2020 at 02:00:21PM +0000, James Courtier-Dutton wrote:
>> I do:
>> btrfs subvolume list /foldername
>>
>> This is a mounted external disk in folder /foldername
>>
>> ID 257 gen 3455989 top level 5 path @
>> ID 258 gen 3455995 top level 5 path @home
>> ID 15214 gen 2317920 top level 5 path @apt-snapshot-2018-08-20_20:37:56
>> ID 15296 gen 2317920 top level 5 path @apt-snapshot-2018-08-22_11:18:45
>> ID 15297 gen 2317920 top level 5 path @apt-snapshot-2018-08-22_11:32:41
>> ID 15398 gen 2317920 top level 5 path @apt-snapshot-2018-08-23_21:11:42
>>
>> I try
>> btrfs subvolume delete @apt-snapshot-2018-08-23_21:11:42
>> but no luck.
>> I don't understand. If the "btrfs subvolume list" has an option for
>> path, why doesn't the btrfs subvolume delete?
>> It seems that the
>> btrfs subvolume delete @apt-snapshot-2018-08-23_21:11:42
>> is only looking for subvolumes on root and not a within a folder or
>> external disk.
>>
>> Can anybody help me with deleting an apt-snapshot that is on an
>> external disk, and thus not mounted as /   ?
> 
>    btrfs sub delete takes a path to a subvolume within the visible
> filename tree (i.e. from /)
> 
>    The filesystem must therefore be mounted somewhere, and the
> subvolume to be deleted must be visible under that mount. In your
> case, the filesystem is mounted at /foldername, so:
> 
>    btrfs sub del /foldername/@apt-snapshot-2018-08-23_21:11:42

It is also possible that the whole disk is NOT mounted at /foldername.
It might be that a particular subvolume is mounted at /folderdisk
(possibly using the "btrfs subvolume set-default" command).

If you can't find the path you are looking for at /foldername, try
mounting the root subvolume somewhere. You will need to name the root
using its subvolume id, which is always 5. For example:

mount <device> -o subvolid=5 /mnt/somewhere

Then you will find the subvolume you are looking for at:
/mnt/somewhere/@apt-snapshot-2018-08-23_21:11:42
