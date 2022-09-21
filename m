Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C0A5BF3A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Sep 2022 04:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiIUClO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Sep 2022 22:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIUClG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Sep 2022 22:41:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603D558DC3
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Sep 2022 19:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663728059;
        bh=ozggWSDSiFvMBNpcZXN/PqgODMTATEytIrKoVBS5QeI=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=J1R+DKRz4NhWEp3tDDBVUHv8t0jRaBRXuXUAvvxumkgUewCxpYEIX+T8bFIY9gb/p
         unkEZb/CYK0TNvZt0bcn4fbMzpUNo3dirxhizFET0KuMDQxyjuHnIK6yzkEzm+Mxt9
         BkaCM8EhSlhl/D7BObj5UxXewSjKZ5Pqs9ZIdWIk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MwwZd-1pTb6n0HRD-00yNrI; Wed, 21
 Sep 2022 04:40:58 +0200
Message-ID: <6d72763c-d024-3224-be8e-0ade32540883@gmx.com>
Date:   Wed, 21 Sep 2022 10:40:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: call trace when btrfs-check tries to write on ro-blockdev
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        linux-btrfs@vger.kernel.org
References: <70591e96d9dbc46cfaa44316f0eb1bcccc7017f5.camel@scientia.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <70591e96d9dbc46cfaa44316f0eb1bcccc7017f5.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bsRRjy8sDmOwri2c7jKjgF5PHTSHmNgqP19JJXgNZOSLGwDrHMB
 MwvrUVj72a+aNKsclz97Oah5FcMAMvu42qMlUoxL04wijPNqQAYRzthkGpKdaa0hw6FDPMO
 pbdDr85L0I7gVacjzgyeqlY0w5Tk1zblt7gZnwgU+pvm7XrYfuYZj7Im+ZnmhJ6dTSjkotF
 MMepmj6hm11D6lI/Zi6Hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RPibz9Y2EYs=:X9fyK4WZFrAqyH/eJWc+MM
 uyQ2+4RlQNva5dmQPHt/gz7tahyKQ7w3OSXpHlHOxrG1yq/QFp/UTpWjajhOFvERdTBS70vXI
 D/NtrBGs+hPQVSH+OwzwUI28d3GGwQ37XYMWETfmkU6rfAsEr49gvM9QuZq4lk/mNvqj7viGR
 QnRkbVGX2x2iDxfRW6ur+zjx2rzPCMuY3q+be8xcti2ouPs1qDcpN/ss3mZZcgjYo8ufkISsf
 N6ZWTGN2fpfQeHWveHAbmT5mUhRGNyhVhihq45mEJUg6JHc5sNJtNc4/Xq3WXt3q5IIIapazP
 dP4VvwmOdRBEMsjonoNWM9AGXuptYYmbg/dwmhT7lWEZf/dH+KhNyJk/lHt7GtqmKNEJAdAIM
 eXDvTqBG950KLfVfXib2IZ9ZU6cyHnFwS8K/Bq5hxi+Rbb4CJnEa4oGCgB8ICmZTSSqfaX1Ci
 OOQWyvDSbXyDkn715l598Ii/t0WMaGGSzU06nuJMn08TzPCX/zNdKYRY5i1j78APwXx8+LKX8
 6+OH9DNNXhk47TSq5l/m8yL26Ncr8FoRDNcmt6gJfm8Jc/Rmtx4uf6/v2Ka6WCui7GO9oI/uT
 jewHJLYnfn3XakVHqgrdGkAbhbdOlfOe1ZKNElneuKR7A2MT6lD75GEouXiAD+gHH3K40sC4R
 hC4erfcIZqPs12QJhf/Sc7ei05rjKS9PDLD2HW4YAgfwVjLWAlUbJJd3iDjZfMDpQVTbVPNGw
 5B/hWFFhJX/ezFsknYWlfoOSkvIc1CVT0tIGMOao4ihkb8sGaGCL2ABiIraPFr9SDswzBLpQQ
 Lk/Ea3x2CXbFyMr+5IcQyXaXB4J5fRqSjLZ8q1GBN3oli+uQVIT/FOKk+dLp+iguwbshz3NKz
 ayKzBpLYX4xUonu7CE1tVVFxrGdTVPcqVYSM3SfOEgt861w8htB9zOK8Xfokba0C9qJintQL8
 N2osofkAOivqQj67mmg8K5T680JHJfVO/vk4YZtVBEcPTmCVN4xYiHmusS4KOqFtLM7MzcaKE
 dKQgWHIG5rETfstbGv94VYCB7tIC+iHtvNYrvVvzOqNVZzPiWC3OPzGkuys/mg7J/Dv3Qj/Ru
 DT1Ed1qqHAbB0zkhBw9cVtEkVymqbd0u56r7K7BWSqamtGRk0zKk354crPWA73jHB76yqntxj
 +P0otola/y9SmQcPNSd3GMgb5y
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/21 10:29, Christoph Anton Mitterer wrote:
> Hey.
>
> Not really a big problem but a but "ugly"...
>
> When trying to do some write operation with btrfs check on a blockdev
> that is set read-only, one gets a call trace like the following:

BUG_ON() is definitely something we should fix.

But my concern is, why this is not reported at fs open time?

As for repair we should open the device with O_RDWR, and if that device
is RO, we should error out at open() time.

Let me dig deeper into the case.

Thanks for the report,
Qu

>
>
> # btrfs check --clear-space-cache v1 /dev/mapper/data
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/data-b-1
> UUID: 18343f60-3955-11ed-a6c8-38afd7a81270
> Error writing to device 1
> kernel-shared/transaction.c:156: __commit_transaction: BUG_ON `ret`
> triggered, value 1
> btrfs(+0x3683b)[0x55c75780483b]
> btrfs(__commit_transaction+0xc6)[0x55c757804b32]
> btrfs(btrfs_commit_transaction+0x130)[0x55c757804ca0]
> btrfs(+0x61963)[0x55c75782f963]
> btrfs(+0x6e297)[0x55c75783c297]
> btrfs(main+0x318)[0x55c7577e6138]
> /lib/x86_64-linux-gnu/libc.so.6(+0x2920a)[0x7f6fd6ff920a]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x7c)[0x7f6fd6ff92bc]
> btrfs(_start+0x21)[0x55c7577e6171]
> Aborted
>
>
> Cheers,
> Chris.
>
> PS: That was with progs 5.19.
