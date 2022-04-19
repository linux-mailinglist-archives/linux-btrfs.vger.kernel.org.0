Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C07B507D2B
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 01:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245313AbiDSXZx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 19:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239609AbiDSXZw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 19:25:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6BC39BA5
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 16:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650410584;
        bh=EwhPgfUaiJW6FTBd8/r8n0Zd8wBwuwBofw0BHdk+07k=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=hOPh/bT6OD1GJkVN/1thnDWk5lDbrY+S+dg/dEnTXLAjmmC/glQ9hZGf/uLctWaqe
         wC16Rdzhns3H/8WHzkYwIkWIV3qUS/+Q79S9YyZ2/BcVc1o8SHubLdMsUGDaRwr+L3
         +VXR3ngrYqT5btsFZsr0xfkXc7d+AGmk6XcZk8S4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M2wGs-1nderj1U2W-003LpP; Wed, 20
 Apr 2022 01:23:04 +0200
Message-ID: <3945a9a5-83ab-1124-50bd-bc8d78b1982a@gmx.com>
Date:   Wed, 20 Apr 2022 07:22:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH RFC 0/2] btrfs: make read repair work in synchronous mode
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1648201268.git.wqu@suse.com>
 <20220419191944.GI2348@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220419191944.GI2348@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:23KVV6cOiMxbo6Awo30j2DDAKa+YDwmMI54LxbKHJDAO5N13l2u
 84jVBLBnrshvMVECqjv+6UndcBpxyPu6kblKlSA0OQixO151I4F+lQUxqrTqZ/4HjG8cgr1
 FIuw7PVu3k6flpflT9OMJo/J/thxO8nEJ2jAPPBSkCedHxlzNuQucy9FERCMlRplc7aIpog
 0g1J32T76ds/wKgKYE2ow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RzDxDGZll+U=:f7O6/a724zv0ATId3Qhmv+
 7MXS4ijvP0GL3uo29I4YAxfGo+0F9iq+5EYnukyFT5AIoGOt1duptnDuYkpM35+VKNI+7IpLa
 NIDFH1cz2HVzBbdOe9smJPVJp3JIW8xJmvAVBxvYCTVJXaKivF9XU/ExvQAgylYEmpbCs/cV4
 7ShnMS6Do85lBV3ka4ZbSDM/G9cefQp562eCbcrs/lNKw/KGUzF67vDVhHOElPoMuxEFs/qy8
 g+wqfo/gnvKBGm/Ul9P8OUB7R/HK5xYUwgqfXxWLJ5OrB2HqNUWnYDZ7PrPWWwoC+r21JTchG
 Yn7c3E4ig4gMS/z5mLZP2Jn2I2q62zv5fAopASDLpYLTVO9oU6o/GH/IQccNZEuTveVhpCmK1
 O8O1zyQ0hrmxVrFZc6Gv7fcSAmNHwMu98uRJnsf8KC/5HTH31K8aE4nqTVikGgt3fxKPBYWo5
 dGP6S526poljkcUgcuiN9vSmju7YfqASVwedoKHPCqOk9ByqOnFOQB3LGoEtGu34Ip7CdlTDj
 Cwh2Gv5ZJwV4nUwGTRUR8YOYsotu3AVdv6MiKybWXDoBYZIZ0r7VO3vKT6x7/ZwvgwuiUFdjh
 tWOJ9CHiJkEEZUeGhZnu3HLwIFo3cyLyC9yg55/WFpBAYA1BrIxGdF+0ux54xfwlGc8qKCfJY
 o0dsetIM3Xq4eCsJs4Oq3ecgAsxtxRDLwGRv9+u+gSGMheHsLoUSAFyczByB0EkwhcPCT33CL
 h876bmjP7XdPZTBzzsoKO2w4pQM+/oCLdw6W9sx4YqBnzmqNan6Yk22rcYsz8pM+jDWPQwMDr
 J6AYl8W4iealsDtD65Xrv+0Mo/VnhrlZdh6ez5dHi2/E4g/ZxUBQApJ547yM75hLJhZWOYn9S
 rbgY7VZMJRa6CPkH1qKZGzeHIAK3oVru/GchFFoHEFuqMpe6VMozmqEm8ihubPZBJc92i7PuY
 FFVAyhsXLsLoLcnaro+ZbKskMmSKM4mppyRlD/4Fb41RLqiUYdu9+iUFuvs87z9AZLbOyl4M/
 uDgsY5UTb3m4khMZkgIMkfCb5ew/2keiJjGqondx7/n/tFiVUTQ7XOcSS32Zyeo06+0/THfTp
 K0iKQwtUBoigjU=
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/20 03:19, David Sterba wrote:
> On Fri, Mar 25, 2022 at 05:42:47PM +0800, Qu Wenruo wrote:
>> The first patch is just a preparation for the 2nd patch, which is also
>> the core.
>>
>> It will make repair_one_sector() to wait for the read from other copies
>> finish, before returning.
>>
>> This will make the code easier to read, but huge drop in concurrency an=
d
>> performance for read-repair.
>>
>> My only justification is read-repair should be a cold path, and we may
>> be able to afford the change.
>>
>> Qu Wenruo (2):
>>    btrfs: introduce a pure data checksum checking helper
>>    btrfs: do data read repair in synchronous mode
>
> After reading the discussion, is it right that you're going to implement
> the repair in another way?

Yes, this is just RFC and I didn't expect it get merged anyway due to
the big performance drop, even it's just for repair performance.

Thanks,
Qu
