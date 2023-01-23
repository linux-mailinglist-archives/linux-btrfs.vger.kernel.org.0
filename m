Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D22C677BB4
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jan 2023 13:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjAWMvc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Jan 2023 07:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjAWMvb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Jan 2023 07:51:31 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A4E12052
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jan 2023 04:51:03 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLi8m-1p2PQp1D4S-00HbYs; Mon, 23
 Jan 2023 13:50:44 +0100
Message-ID: <e08376e2-0722-b8b0-fe72-645a08972fcf@gmx.com>
Date:   Mon, 23 Jan 2023 20:50:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: btrfs corruption, extent buffer leak
To:     Filipe Manana <fdmanana@kernel.org>,
        Maxim Mikityanskiy <maxtram95@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
References: <Y8voyTXdnPDz8xwY@mail.gmail.com>
 <CAL3q7H5vjCrVEPVm0qySoXndBsnNDDT6H5VYMLORFxsZegXNpA@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H5vjCrVEPVm0qySoXndBsnNDDT6H5VYMLORFxsZegXNpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:u9145B95hwJJV95RoAgBawOTsGmg2QwsczJQ59ERX7q5Z7hZeOR
 CaGRUbAyyqys5kbQ4aq4CYCcFkdazBNCbxSITDwZCRCjsiZObnrB0WNgT4zRTsidSvbOrov
 +BHvEzUG8BoMjKIrMFHGTCV8MKls72bxdzppZyeH/gcia5vNK+E5B/QTWRUlVLQBIwUAB/i
 X3jtdXSiH0N3vKkzaMIgw==
UI-OutboundReport: notjunk:1;M01:P0:DBvkIj9tx0s=;nrgx8weemHx0pevtAV5qwVS3qzD
 dy7D8Nxc55CBqoLwnC6BSdMieWdwKgbK+7HB2vnKeWReoF+0DjjE6RVaF0tZpDln7aKj3kGp0
 22opCLRDddQoQqoglqosFI757Lq5S6Utj5r5+CWYV5B4MsBD1P0t/H76yF7QPTRt4g6NRre0K
 mjdtzdWiSHIl0cWiA2hp5XWMJ8D3uqhoCeQZr+VqJYgQWvaEdyxMhh/w27SpfRipAAQEgPW4W
 /KnaAcJMIF+jFiraSvULKHZACjmpFnQ+Py7eBnLq2L/nq/nl5PohvCzSfUl+Jy6fGFjoP/fDd
 hn7pUKSHORd4l08iCQwH1IOgA6fC/cySH90cnZmZtE7uiniS44wGFOgia+RxPnhBKEwDlIZLP
 wpBZVCWgyFTbe1rQmeNWEY/CqgE+ZWjPdzJK/1v688UyLqAu4zJo011MmbMibae22F0x+a0IH
 o+C9vKZ8FBRpqHcnGreFnkaf6KEA9TLJd6Oyp069NQ7njKBPMoBcx7BhPuUNsEkjMPdPFrARs
 fT0pZjm1Q+4OHpHuuN5I9Tuy3m9WZ3MdcLH6HBBAg/TNa/dhYvbjKlTZ3qheLFvJgFPdVcb/a
 /tB5ks+ePh39AhE29w58FkQVWAHnNEa4AMUSWy+of4UH2atxhXPKfEaJ/kvMA0ok9yM0gbGzF
 iEet1QaDDKctfoH32yxz1NsPFwMP2OAwUmeDPEKB1eUM8al/j4Dmu3U7cWZSAyItEAhgsNyJI
 wxQMjCLB/+UomLRZEkYRMhhz11tGDjodhhW6Q6mNFA0d6PEKwfgd6cAY7yMVHUN6YBdbrXHjf
 W0RwzxHBeG0H0dZIid6WMKSGGsCKLxxp4Fq6zKI3YlBovwYTKETTkahSZXJ1DijehFrh1DyXq
 cuw9SRQG5c/NJMrs+x3dSgcqewy6YurrtZ8aFiDiLaUcH5Vv4dC4jHGCS3cNLn8yBI4nUuSBk
 l5lnOKJwb8rMFvLmwJcrhn0Wyc4=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/23 18:39, Filipe Manana wrote:
> On Sat, Jan 21, 2023 at 1:59 PM Maxim Mikityanskiy <maxtram95@gmail.com> wrote:
>>
[...]
>>
>> Opening filesystem to check...
>> Checking filesystem on /dev/mapper/root
>> UUID: ********-****-****-****-************
>> [1/7] checking root items
>> [2/7] checking extents
>> [3/7] checking free space tree
>> [4/7] checking fs roots
>> [5/7] checking only csums items (without verifying data)
>> [6/7] checking root refs
>> [7/7] checking quota groups
>> ERROR: failed to add qgroup relation, member=258 parent=71776119061217538: No such file or directory
>> ERROR: loading qgroups from disk: -2
>> ERROR: failed to check quota groups
> 
> This is a different issue, it's the first time I see it, nothing
> related to the previous one. I'm adding Qu to CC since he knows
> qgroups much better than I do, and so he may have an idea.

This looks like that, we have a relation key, but there is no such qgroup.

Not a big deal, you can disable qgroup, and re-enable qgroup.
Which would rebuild the whole qgroup tree, although it means you lost 
the qgroup relationship, and need to re-add them.

Thanks,
Qu
