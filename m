Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02355591926
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 09:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbiHMHGZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 03:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbiHMHGY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 03:06:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F353AE4E
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 00:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660374377;
        bh=pJ18QNw5hzyl4arcyBHWRwvgGj745ABjgr8KlU+fioA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DoaDgAf6yPfjmvwaQ7SrqBxeA5mJJExBy8hr9VZJ+7DdJtMZsjjm/8hoOwrZbXSlt
         2xMmrouVVCZXoQ4f2OeVu7wO5amgxWq25b1VtfsI5XsgaekIePEVvRwm0GPrgLjz1y
         5HeV5Acbpel4QVv44E7sxsqtt2YqYZf0hMeTMYyY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mwfac-1nTII60YHq-00yBc8; Sat, 13
 Aug 2022 09:06:17 +0200
Message-ID: <f9ccaa97-3616-8611-614b-4ea9f73a38a0@gmx.com>
Date:   Sat, 13 Aug 2022 15:06:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] Revert "btrfs: fix repair of compressed extents" and
 "btrfs: pass a btrfs_bio to btrfs_repair_one_sector"
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <09b666a5e355472749a243946a9199ce2d6cef77.1660370422.git.wqu@suse.com>
 <20220813061901.GA10401@lst.de>
 <ff84cdb1-fb69-ca19-d82d-658c976c89da@gmx.com>
 <8b8b669c-fe7b-70d7-df2a-d9f0339d6372@gmx.com>
 <20220813070249.GB11075@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220813070249.GB11075@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V3QDUs3gLYhyAZH9GumE9gmI3y9Wqh5F8UVvqnBje15gjzzHPZa
 yUmj3W8f+KmaH7LNLwUtRXm5diPXrSIdLdiO40uWbZ3UjOa2IHH7h4soo9HDKlhWfaJZmsN
 ZolMSvVIU54MDxDpjKLDi5ThPZnJuLbJnClL9kmU7KBge7+EZ8GnRw16QI9xfRMcV9BzRqC
 D4mgNzTjqrGYaUILrL/0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rlqR4TJbgVk=:e2aGXhvDiK/7KCyZsEnc35
 4WVIEz5ycsbbhq0IhKTOfYgcVBFJ1iOwlflOWSwUWBwLkd6MEOw6dJXAH2XlnG7znzH+4AWnh
 4nUwXJYPQxy9a5WXQVbzJt1W6FGFJ+jHW3Kz8gSMcx+hw9SqTBF6sWDeBNHsSs3AxA/dA74iv
 4Y7ewYyYVMnlJEg/DUyGzg/wKzNfo+R5PNNhOkLlvL+/jSyxm48KPqaYcn2ZLfeMVyKQsJq8B
 9egAe7ab/qQvM4hv20S+ZRo54W4yDyvytSoAMSedjl9bZ4Vz0lFH6w6N2R3ifl41hw9AI10QF
 CC5GOleAJMXYhMhSEZ6rVOIEDvQgua9sco3BTjUYtHdwI1sXKJBrCf7KIxGNgSRf7ZkEtSIe6
 fdSc5kk3UxHclj2NpHQ9LbwLMISU9J9nb16cGhHGeJEsDR4WgdmAZjHLg1yNWu9/++24mU4lX
 5cTXmgHuUMKRUkcqw4BtX4cVczHLkmcicgKTO2GUJJXqkWDd5GPWU0AKj3JekUOs4pnb5JeQ1
 P86wAE5a/LbF8NhZEAfA7rETyjVm29RHIcpM4yLyf0L7fBoPzC6NKBRN6NoyVnSXxzYNK78bC
 K4QjA1TuTXVzMjw81TMlMUx/21/xbW+M5/BL4z0Zri8N2Bi35py+5BK3sbAHAlxcG9TupUytW
 4+lVzmg5eDUVrH4bDFdsF8oRQixQyoBMokHHAOXTs++XSH5A8iK7NFhlUpeHpnEyS66IQFTjf
 zMPQ6hEXQwhr0xdpD01NOsBcdw9QIR/vj5S4ssZwkwKEjvEGPhCmxXTY/UHZ0Dxc8NFz9TzF6
 eCt8YhmFRETNaAP6Qob7Pf+jQripRVHaGYtVC0ivjT+SozT59e3/agzoCE61i2Q8ufeaKy9DS
 Nb+bULV/btZxIXjeAkSle+/7veEzfIZLZr+PCWK8IyoTbgKi7lQOFjrCg2zptbAL0jkaLN890
 rE/kKmnJgZSprjVTkoZQ401GuK+iD7ZIXHMTgLmZefGs2aGZ79cn/6jJC/6jTsEmH1W4xfTpL
 LoWcYspEznIBz0XstL1XSJ9htRWHCTl/48g6qyFHy7nKjApbDo3AvGeAFRfqJx1iA6t+Fw/Wm
 0WVRqNcTRa8MHB/bgCBYwkz8WHGX9jTQcT/WT0LOSpA9pysMZYbkGVLMg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/13 15:02, Christoph Hellwig wrote:
> On Sat, Aug 13, 2022 at 02:58:16PM +0800, Qu Wenruo wrote:
>> To answer that, the reason I found so far is purely because of btrfs
>> RAID profiles.
>>
>> Unlike all other fses, btrfs has the in-built raid profiles, thus only
>> requiring the logical bytenr to be continuous will reduce the amount of
>> bios submitted by btrfs.
>>
>> (Especially for profiles like RAID56 and RAID0/10)
>>
>> Although I'm not sure if the reduced amount of bio would really cause
>> any different, as block layer should have its own merge optimization.
>
> But does it actually work that way?  The extent_io code walks by
> file logical offset, and is bound by the I/O gemeorty from the
> chunk map.  Once we hit a stripe boundary, the bio is submitted
> anyway.

In the reproducer I provided, there is indeed an hole involved in the rang=
e.

And as long as we didn't hit the boundary (nor other conditions), that
bio can be there for a whole until next range is being added, thus
allowing us to merge the pages.

>  So I think the only case where this bio could actually
> happen is when a file has a hole and the allocation spans over
> that hole.  This is is just from my head, need to verify it in
> detail.

But my question is, do this behavior has any perf benefit?

IIRC block layer should be more clever than us?

Thanks,
Qu
