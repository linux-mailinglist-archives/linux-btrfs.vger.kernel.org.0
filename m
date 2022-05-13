Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795D25260EA
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 13:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379906AbiEMLWQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 07:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379895AbiEMLWN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 07:22:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A57554A1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 04:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652440921;
        bh=YQ8uyVuHCmtkszSAaLdatSJ+hh4AugsXoSbpXLsPvkQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=LkZHadxy+w2XOLfj9hwmktfNFmVRt4//uKWpKidm/1GGZww+IBrjWGNUh+OA3rqJK
         5NyNRv2nmm0AsD3EKJMOkfYZ5nMVotcK5nFPJ1cODDIKSdswC2PvjbpcgWfbg55d4f
         RtlbVhlPw20N+b/Lw0Mk7JUKmf9SOm3Y/YCDXIzs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCpb-1oNQTf0W8N-00bO6L; Fri, 13
 May 2022 13:22:00 +0200
Message-ID: <581432b0-9324-8509-2737-a57f19c93937@gmx.com>
Date:   Fri, 13 May 2022 19:21:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 05/13] btrfs: add btrfs_read_repair_ctrl to record
 corrupted sectors
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1651559986.git.wqu@suse.com>
 <3f9b82f1bcc955fbb689a469e749cf1534857ea1.1651559986.git.wqu@suse.com>
 <YnFE62oGR5C/8UN2@infradead.org>
 <dac4707a-04f4-f143-342b-cd69e0ffcd80@gmx.com>
 <YnKIM/KBIJEqU/6b@infradead.org>
 <efb8bdf0-28f0-0db9-c2b0-a08ffbd22623@gmx.com>
 <20220512171629.GT18596@twin.jikos.cz> <Yn40Fkhz0jyef1ow@infradead.org>
 <5520df08-b998-a384-f1aa-16b301474cab@gmx.com>
 <Yn45tomlUQ8mGyVs@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Yn45tomlUQ8mGyVs@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/7ndPNJ83TlEvDdBoK2IQi7FjYV7xN97qAPkWW/bYCQme2mz9W1
 ZGG4P+FNO0Z3UOsAHWhme4g2DKTrlVq86+HSBIe9A2LzOb4fVrULPwpK3lM+ImdoTzCjlHE
 FVL9DFlH/tFgXBmXl/xk2usaXOdTGpH20Jr6EUNGrR/Zvkz7R75dwpL17gE0IL5MJ+Pl1N9
 hNFapjlG61kkhzmAvVQLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pILtr5XC7qg=:I+XQgjTQOhM1qXBEL7heM9
 Qb5K4Vu3kxHNiC20q0CZnJxTHFotSsv5BYX9ULPRRaFOribqA56SMmuY0radNHRIfEepj0HZW
 RyB2wUm1Flasupz6JrZLSW8y/veKYb5oGhQnhIuBY1B6r78MF+DspbWOTb/56IsrcG4GsMDp3
 T/9d/Z8Jjucobz2+GmHTVlCLFULt/58otWiq6g0tiC+28uZFBiq66AtuOkK6rG/bb1bkJG03d
 uc7Zqi3zjJLiomL4BfsdB1o7mOq8uoXxKnv5ia9VJYeQG0BX0OU/F2Jho6mjVv6Nkchx2wu37
 2nbj/JByn+6MXVea/V24A0UzOJfzFWkMX2oq4MiRhMZX+TeJxQmj7klpDH7vYD+Swj24d3kWL
 MEAHhpqhqG9sf0w8vNZZBu4KDmhT3fb9K77T4AGpre6cqvM64+igMwsR1FnQdmq08QslhcnOV
 vE1XPYdF5YzFX2BcGegXG/ZFIqhk0nNjY3eucN4pcyn5g7niRlalDu8WE4DRVh28awEGe3fOS
 O3zGzEVGt0vbJ/R+9m6AsDu6fsAq4Vkr0ZYdnocQde9VmvLvJCt/n6zdAOosYQ+9Smk2K6V+q
 n74AYkb22vgMk6+tty8bg3QHYnng2z3q9duAV6Q2I5GY04NuUz571XN1aVY8vP9eS5OHWPS3R
 5qw45YOyhWv5NW+Hmi6NuLqKZMIT8g6iyX1SLgR9RXB0WIMWpyynFHarhnMpb5Kyu0xecZ1WH
 o3bU2LXS1e/bIEts/AnUNsMzmW/45pSyhEQshyEeqIg66ln7D4KgE7PFKquLrFg4Yf617xioS
 qDHWKfxCFm0UOMHr0g5JQCISK+BCVIydgU7G92RyGWHHCHjLCUFT4laBJxj2Fa2NprVdhlxgH
 oCYqSektQj4xBxcCnuUCSv/C5UViLs9iwI7b5lX2CI7cX1eO+h5kxN1kUXZrY3vFTdY4a1XHa
 o1WRPX2EG/Lirg6HusyBhV3uj0E4WTkeP7zFGRe/ilHZqQy2dl5y+PBpvliO7Lu5ompEW5LxF
 QUqlOJfGhZUHm3bctk5EwhebH9W/H2HAf6IKkbSuMAzU34rH4GW2Tu1iPNIV7tGALEzT4OPo0
 GB2Z/WrtoUMcSo=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/13 18:57, Christoph Hellwig wrote:
> On Fri, May 13, 2022 at 06:53:13PM +0800, Qu Wenruo wrote:
>> Mind to share the overall idea?
>
> Build up the repair read bio as large as possible, then submit it
> synchronously, and then do the same for the repair writebck.  Basically
> go back to synchronous I/O, but do nice large I/O wherever possible.

OK, then it goes back more like the very first version.

I'm totally fine with that, especially this makes a lot of things much
simpler, but not sure would other guys agree on the performance part.

>
>> I hope to get rid of both io_failure_tree the re-entry of endio.
>
> Yes, it reuses this and various other bits from your series.

Yes, it's kinda of a middle ground between fully asynchronous batched
submit and fully synchronous submit for each sector.

This middle ground is still synchronous, but batched.

Although for the checker patterned corrupted sectors, it falls back to
fully synchronous submit for each sector.

Thanks,
Qu
