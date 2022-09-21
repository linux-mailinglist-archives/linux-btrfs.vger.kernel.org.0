Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651925E5634
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 00:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiIUWUi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 18:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiIUWUg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 18:20:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CECBA5995
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 15:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663798829;
        bh=jgI2piL0w+jg1Qh9227eH8KWpzn5WJIQR9xX6b84uis=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UQomYw8oZJdOuGlTLQXRIBZOvrPlyLXS34P/j9PZpZdACQohC6LdRnwjEiTPdB1lv
         xbI69vTEZGFUVfgSwKmx2Qdn7ufVFsB9vsJdpJ9v1jcIBnOHAuXJWysoMbDstiztYy
         6Yn1Byp6/dOmbYoaNsxxuqn+P9WP6xF9KpDpbZQE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmULr-1p19QL2JpB-00iWGd; Thu, 22
 Sep 2022 00:20:29 +0200
Message-ID: <ecd14905-6ff1-3d26-7354-93631684fa0c@gmx.com>
Date:   Thu, 22 Sep 2022 06:20:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] btrfs-progs: hide block group tree behind experimental
 feature
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <0b8f20ae26661e040dfcaae90928bbc1c6fff5cd.1662952308.git.wqu@suse.com>
 <20220921140611.GG32411@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220921140611.GG32411@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AarefrKcHRcmVtQ0JB0zkYfOe8rZIuCTA6QzWzjF6+U4B/x7sLo
 gltVo6CJMmPmaPVzjKAJRmx+M+0xYZIdHeeoZUiwngaIYmP9pbYFK80vu8FWzp1AwqSmJvG
 GAhhKoReMKKpwxKmCJBq2Z5oPw8/b02EfkEkoXoCxLoHWsz0bQudTnSlYR2RToT6yx2gSVc
 IKGMCmt+AJOJSH4GbOeaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TQmso396ctQ=:XoPCmY7nghql/V4AhH15Fz
 xAe8XYK0DViLpWxfI8ip+/roFMRsyHksx9P6c5ezHgy7WVO+wVb97N6AHjxZljexNcesvkqza
 DtlruirrABt+GZbTle0Y2VlkX/oEAXD+gZGQt6PQOycJSUHVj7jut/ySvOxWdvZNgrsOmrPld
 QKqn2noZ3qGNU5wPo8BDPsg8xS/nofZRyBu6nQtfdQw7tHKRl5CHfr5kkx6ggcbIbZG6rglUA
 vX0g7kfuKGk/GWbkRMmKkUtn1JHploSrUtBU7jyKJyFZDIl+YrNrsUM+O1yVUGYsTEhuof+Rg
 5FBZ6RequdMtWsl44xsSTCy70Hvsx7dD6ZestmoFh2NXpJGrudL+Xc++jw4dqy61Jk9//nBl9
 zl1k4Z98J3upZTc9J7nL3eL8Il91steZA06dTxlP23Uduc4tsDYJ+qQf18gbuYzONyU2maFZ0
 A1z/GYt0MnMS5hCnN0pLSC3LuQLGFeOaHnmFdkew2ZL2muQxG0/JHTE8MGe2UfI5ut6ss/ZVc
 5rxyIBRtVAcTScAUmiFxujT5nfXS2m69rp1dQpTbCWE8X3lyYNMHj+4K83u3AmpSv9GwCKr/y
 pji90IU1aKGZobNRyIsDbkgPe8PPHXiEUZjFH2lboA0DqK+C8iIYMYLVn8expzc1G3yGbf33C
 VjtB4gBD3VplIlQguLWQFM2sqFB5OR4BoRDDtjxc/vOBs+I9dpLSP0TnpAdm8gHD0TqsJAkZh
 lBF9N1Vt9oL1Xde5GZo8oDq4VqBXsTLi2WpmSCm6VeS/8LZWs5RzKp5KmwScMl/2RXQmNk9xc
 s0hco8QVcEAKR8kFRWGJsSKZgzYm7Q6n0Xmsj71Me/JxZlXURHLcjVfhXd9IH6HKdcKCtkr8e
 ANK86MpzEFnTmzT9IbwfAR9GGS0TIxRif0rsjpAiWA+ildcxiLaQmE5026N0j2ZvYxOH5E6B/
 2HIX7SOzVv55CyM/jZqHHbOsrEBiyJT+Ifv6ZDnOj3RhBvPK5c3qh0iGYCY8K+b0kDYaDjTRo
 g4QeMKBh1XdNYu2X55KlqI8ZRjFIs88igZuAuamnh5q0QsKGBswmIWRQIcn5abKG5phTapsl8
 5r/8S+TDtV0divVukjSMD2Ch9TMlMZmI2jc+9L2PeMtFJGT7+fVlksQaI7gB4UOkGWMdLrPqh
 aILU6SGuByP1UIKoF0fZWqUdrr
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/21 22:06, David Sterba wrote:
> On Mon, Sep 12, 2022 at 11:12:01AM +0800, Qu Wenruo wrote:
>> The block group tree doesn't yet have full bi-directional conversion
>> support from btrfstune, and it seems we may want one or two release
>> cycles to rule out some extra bugs before really releasing the progs
>> support.
>>
>> This patch will hide the block group tree feature behind experimental
>> flag for the following tools:
>>
>> - btrfstune
>>    "-b" option to convert to bg tree.
>>
>> - mkfs.btrfs
>>    hide "block-group-tree" feature from both -O (the new default positi=
on
>>    for all features) and -R (the old, soon to be deprecated one).
>
> The block group tree is going to 6.1, so the progs support will be
> experimental in 6.0 and enabled no later than 6.1. It might be enabled
> earlier so we can use the normal build in testing.

Personally speaking, I'd hope bg tree would be hidden behind
experimental until the bi-directional convert is implemented.

(AKA, I should finish the remaining part of the btrfstune for bg tree)

Thanks,
Qu
