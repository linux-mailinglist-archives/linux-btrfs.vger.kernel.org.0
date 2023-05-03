Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BECB6F6202
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 01:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjECXXp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 19:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjECXXo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 19:23:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B48C8A73
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 16:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1683156218; i=quwenruo.btrfs@gmx.com;
        bh=orEZPLufvZJ4k4yXIlDfkB3+XAdfGc25aMcj9ib7tIs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MAvlzECoRg3ijiVYqBmq9EycDuC148mllZfeeO3dGs9uT8udTMlc8uiMwhpReY8kv
         IlA2KXW4Bncvis93q6h8eISSmHOYZe4gQef1FEM3GxaVVDiBaVQuKaEfRPQib4664H
         WtzwzSEcw4BqCvQ0S1pgBe8dzrtGi+fe83jjFHr8qmtw+QmrA9x11TB7pbwhz+ROog
         KU4ISUILvwUuILraARdsIyL08sC1XAB/+Aqd8ZDCi3uxEBZYq4s63xRLUJZIuuPPKw
         lIdwyP1DY2DdqIVBmtIha4rtWtEkMV54cvGPVLEBl4+UelSkUJGIYpOdd/TNDGm/wq
         +E8E3P7Ga848A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHXBp-1pz0dk1kAL-00DVU7; Thu, 04
 May 2023 01:23:38 +0200
Message-ID: <21696de5-655c-0a91-85d7-f11272ed30a1@gmx.com>
Date:   Thu, 4 May 2023 07:23:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/7] btrfs-progs: libbtrfs: remove the support for fs
 without uuid tree
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1683093416.git.wqu@suse.com>
 <6e07c5dd154bc70f9f0a1f9c31cede88dd564bb3.1683093416.git.wqu@suse.com>
 <20230503183505.GD6373@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230503183505.GD6373@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QmsDiNvJ3kgaRLQKl+h4W6+UI+G2Uw4PyjckQ72aqFYvun4GdWB
 yLn6o/ydz6GaITqulIc1SxvPLUvirN6trIPU4y4KP3aGz+f32nc9BXZ6CFqmP7fmePq/jvi
 XcJ6PhtxZI49XJTc+df4gUXspTjpbsXbw5mqRt9E72bpcKJIO1sIMmosoFsYRSC8M3IxgFH
 hamhhqfbkpoP04Sg8zdZg==
UI-OutboundReport: notjunk:1;M01:P0:i6omEeuKAtc=;MkvBfAtvRrbp25Qi5gwnsfNLJBV
 Jl5SqEhvpo4iZDLW4lHeOJ+HaPXJydRMOiWu2p6agkYa8+pb2+MkVcaB9dQe0kVYT1NzRRWho
 d6fFGsrjZrxzWZJJt923cijYyEOzNAg8R6yalL2r5EaXrhzfPeD/FA5vnsI93KaX+k1LW8hpM
 7vGuBWQ1SYYoKl717OgzxpArzIcisTBmiXIt7oi87uUmmjvOCc0O6m0tpuW6FzqrP1fzTrbOS
 sv6wjyTFicuPklge5AO0l+OSPlZNrAAQUmpWREGorD+pn8EgMTsj4llYEKpkshYuy8iIGHW+2
 2FijcS6JlOXehhFXz2YAtCLEZO5VTFtLhabSxm0p+7opDbXNOSCI3n9izmL2pMjhSMrT5DkY6
 a7pbALk/9R1ya0d51IltZw3qS5DyQDdTYvBWuLbVt5WS2pcIAPThOy6tNuJuY3cWZuCBj5rql
 oV1Y1OrE7yb4lF31GWbENQor9CvI/ESvSHHAN3j//cs2gXGQkjMMfwCbkYcJH52sLGFmeoJPk
 j2fGHIEMDxJNBGosIwoZLVILDRjQjPB2EFD69L+pdFoBXNpCZoBuqWoV4N/B7QKskLV+fbFiA
 A8U1TMDslk1yrXAFEMM/g0tqM7A06Ig8TuoBwwnUUaQ/y0nNw2mJ0qsb/OlS/+Bv7dMQgwCFs
 qEniOF7Spo/6gC3fYBnhv/TRagn7TYM6SxyluhmWa8gCus5yfLaTFD130YPT6PMIcVJ2WY7NB
 GRbZU+VNbUIf+xtdOUzddq+NNnV6PpvhadRj94RZeVdOcFmOjCqFnoQkM/PmDGzFFm/pRlwLg
 PHw9vvX6uxBGQ62J3fv6CupcExJixT6LQXv7379G8vZPwLt/LOqEct1fPUnuwrDDEYk6zbjQL
 qyBxOw1sMOSLYkscEKW4YSJfd569In+pTgvthNa4vrMlKGRK/a5sMtl5Xbv8J6C4OzeBVvX1O
 tsRJNd1bvqbFQZXE8KIWZlLOHF0=
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/4 02:35, David Sterba wrote:
> On Wed, May 03, 2023 at 02:03:38PM +0800, Qu Wenruo wrote:
>> Since kernel 3.12, any btrfs mounted by a kernel would have an UUID
>> tree created, to record all the UUID of its subvolumes.
>>
>> Without UUID tree, libbtrfs send functionality has to go through all th=
e
>> subvolumes seen so far, and record those subvolumes' UUID internally so
>> that libbtrfs send can locate a desired subvolume.
>>
>> Since commit 194b90aa2c5a ("btrfs-progs: libbtrfs: remove declarations
>> without exports in send-utils") we're deprecating this old interface
>> already, meaning deprecated users won't be able to build its own
>> subvolume list already.
>>
>> And we received no error report on this so far.
>>
>> So let's finish the cleanup by removing the support for fs without an U=
UID
>> tree.
>
> This changes is the only one that worries me, I saw the potential to
> remove the code in the past but was hesitant to do so to avoid further
> breakage caused by libbtrfs changes.
>
> However, I'd like to get rid of the code too so let's do it. With the
> past experience of breaking some 3rd party tools I now at least know
> what to test in advance. Debian code search did not find anything
> relevant for the removed struct members .h, nor
> BTRFS_COMPAT_SEND_NO_UUID_TREE so this is good.


Even if we drop this patch, the damage is already done in the recent
releases.

Without the proper search/add function exported, the libbtrfs users can
not handle the fs without UUID tree already.

Considering no such report so far, and those functions are only for UUID
search (to implement a receive-like functionality, which is already
super rare), I believe it's the time now.

Thanks,
Qu
