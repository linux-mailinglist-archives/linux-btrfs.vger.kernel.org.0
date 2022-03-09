Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DAE4D25D1
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 02:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiCIBIb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 20:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiCIBIQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 20:08:16 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552691451FD
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 16:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646786978;
        bh=p1omnjlbuLxaKdzsyQR7Rhnpj60VUzrNeVRuSLZQeeI=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=lbxBEm5ZEyl3/3iT/VsHB1z2IDnLnpCjLo/hWpzZZlxaJNQoTC0gRVTZL4IG5v9WW
         TDAedRpYRNKA3NCf2UStSmrzmxpKJ+f8/iTbcgHrDWRGWo8sqhCAdj7uP1xCjd2Iyg
         nWhYLfroMwNK/ftTZYWNSUqbFVSgBSmt3s8bZB0Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MuUnA-1oHmCy0z3K-00rats; Wed, 09
 Mar 2022 01:06:55 +0100
Message-ID: <fc451396-db2c-b7d5-0f10-15d77f1b38b1@gmx.com>
Date:   Wed, 9 Mar 2022 08:06:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: A question for btrfs-progs code
Content-Language: en-US
To:     Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org
References: <20220308145539.GA19735@realwakka>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220308145539.GA19735@realwakka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g3khfFOZutTFBCHNOWD8JVfTiMnr8ySfcXrlz7VVBZegqgw3slu
 D8+f4SYZy22OWA56UONhY7qpZNENYQkdDvunGlMSj7ijq5QJyo1pmKDZalDfd9aISXRA11+
 jOhBt6Oj9y9XP8n9Lo1WreMDZ5AXN+xd/5+IbO4RdjC0ygLxuMnEdHYcinNwt6VSNpNOdGo
 Y6cvKRR5Ztt4ZIgh3nspA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Ci9sJHGt+8=:YUSfTtMAEyfa9ibnoJ4HnA
 z1WLAxLUa28PKFCLcaQbuuFxBs7yaacyCip6Q5VDQuHImee0Zijwq6R1b2NMBAmdIcwXQ1NIN
 vSzd2mpN6BCPggBdu/KaEslqKJLMC4qM9YVSPmZn5y6XiLwmUBBpccQUgpykKRG2VLsJp8qWz
 nh/q2WfSHeEgQjcXjU8Jyvp9u8TU/D/Yx1HVp3cK1rLYYorFNfiJkXXb/2+lzVGpTVZQAbE8x
 ggr6UStnYNrGzjSJM0ga0726w8kpUmF4whf3C6V/Q9IDRzxYbVtkdDTA56kIwv6gVMdUVcRCS
 /Tnyda9zMN4nQYjdhyI8Okrm9KGt1Wra57b0UM3qYqI9RPDAXsIvOgvUtXFActT/N1Jl1oUMG
 zHV4UPYNk5ozSz5IIsSFCMwxCMPqor7B1tjPjhgkjxGSe4Zfa1fGVOSTboYuyQ7dvRi+99X83
 UkxcIoBImJ4+VnMVryzjkhAkdPVjkagtAPtdfY/9+Uf/3EA6s62x/UE2UASxjX7w2hQXj2gky
 EXrt2aWKkHy9YfyhpRNdK+jtCh09mZCXbFpqW2Kz+Nm66+tltmsLF66wTy3U38MV3mqLFGyz1
 ZjYimCj2rJJW9mmCgkaYpu5YKbO9kI7NY6xfaPAq+BsDchKbO9mOZLt2NLiuALWiilJtmOBIa
 JFdlyYbw0mZ9HehtF5UjuJrtFAy8oHcbDnFr6x+QR2M3Kc4aj2kxa43WWDlJ7dPz5fF5olm1e
 /qFRPWlpOoF1OAwtMmZGnM5o5tRwC5Ablc0di1gADHQCOI9yOzVcF9ru/uRkzHLHG743HCYvF
 kqkwBIg94IckCyIjGgoCuqy27lB6LR+8UOcesCkJ/hp3zgEtv8tprYi2cMqyuPdBV2oAHsb12
 BrzCUpGTB8tTIjWq3A9672geS7Zm1vPuEQ/fzxT81/Ovpx0GVtkZFayWS999Bbs471GujgRJC
 eVGCd5k5aZy4+XD+ERQWZnjInzf5R3KGyeKl+CMjWGtaa4fGKsSZOugEIv2hKbFyl5texy73k
 UGcmawvCxShWBi32wsNJea4rg3+rpPm2xWgx4mpnDu6naLd9qtbl5xYWf3+FRcX7VZVl9y+ya
 smDUQrAN2dWziU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/8 22:55, Sidong Yang wrote:
> Hi I have a simple question for btrfs-progs.
> In cmd/subvolume.c, It seems that create subvolume command has -c
> option. According to code, it gets two qgroup ids and adds to
> qgroup_inherit. But the command is not in manual. Same as creating
> snapshot.
>
> Is it deprecated option or internally used?

That -c can easily screw up the qgroup numbers.

So we don't want users to use them.

I'm not sure if we should even provide that interface.

> If it should be deleted, It would be glad to do it.

Feel free to do that, as I'm completely fine to remove it.

Thanks,
Qu
