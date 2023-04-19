Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443C06E76C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 11:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjDSJu7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 05:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjDSJu6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 05:50:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DA0559F
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 02:50:55 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7b6b-1ph4dj02fd-0086SX; Wed, 19
 Apr 2023 11:50:50 +0200
Message-ID: <385910f0-abf2-618d-0955-3abee00daa5d@gmx.com>
Date:   Wed, 19 Apr 2023 17:50:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] btrfs-progs: logical-resolve: fix the subvolume path
 resolution
Content-Language: en-US
To:     Andrei Borzenkov <arvidjaar@gmail.com>, dsterba@suse.cz
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Torstein Eide <torsteine@gmail.com>
References: <20230417094810.42214-1-wqu@suse.com>
 <20230418235505.GU19619@twin.jikos.cz>
 <CAA91j0Vvm172Pz=DUhGo_k3B6aOEv+VrsskKWFAHiuHkPwA77g@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAA91j0Vvm172Pz=DUhGo_k3B6aOEv+VrsskKWFAHiuHkPwA77g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+Fj5b3u6B/3NFQ4xoI5Fwop04XbZjOjMDGGARI2TfPNTMqRagTU
 /jK5HBYMOxs6zhDF7EeWwYxVIz9lXNvOeOYWEgCqTxLz4xjPaXn1IjZJ4aHrXwYJIMkfYPU
 oAdRHeALR+C2x0PsVBMXCsr9i2sdBEkUW2gBkUg+PEN/xU9tEuOWRkCmVtIImxHF4frEW/J
 mnd9ByoF4bbejR+/owOiQ==
UI-OutboundReport: notjunk:1;M01:P0:kUUpcsKxy6w=;vv8AmtKfr+zrfcy7pEOrcWrlC9R
 QoItzY9LcxMY1paM4darPkULt6ILFL6fWl1mVvcPVQk+jCrDR1kFsGfOuZVk4SSovBHg6CO6w
 L32TpkHx0cvmkgiWuHvieCtLyikUDx0sUVUcp7osfvTjT9l5nRcGnQdUT+tc1WSAxZqflH+LL
 TJjwxnqbwLjZVJSr/OLmMNrwJ6lpkaBtHftg0oQC1TmkEAb9Ga64ivuiX65iFsI0Reo1fprLI
 bowh1NJjVE8AkDeoHVMl82VjnN/YL6Psv2P4S7Xl9Tm3d6CYgKpItCETG3uwMB+dATEtbDbrL
 ITxZ0ya8anpXokuz0ueMiEhIk5pTB8Ubpu/WthfwjFyzrfdJug3wf+nki5KxjEKyuqPHaGmcl
 ZqvRZVuXdJFwIOE+0LkZBXdERSs+wpvJEG/q+lEyww6GXSPJHBtCY0wNYpCoXGwd9+tkzcj+N
 3g37aWOXwnDijZn4ys+bBEKN5QZBEGL9pMQj3kV5SfGEe/b+7CCZMEl31Ads26T19vphW4T/g
 3MpRZSg3urBCJ4VkAWkA0/FwkfFSLwnPEe9+YJWS+1hsA2A1hY5d0wmyLix9o8dQ7xEH5i4o8
 cwYxouSm7IcRdI4+O6fnYagyP4aGfZVN6y3dNXO69PsazV6Ep6tKT1xB1Go/8M6JfAdFwTNIb
 xJ6Ik/WA/vJS/8675Bb15272nZLmHWqulBgx2rPUFaLATu67b/sONEhitNN7B1oUWxXExa157
 Y8Ap75RhS0iDfR3mSyaZ+O34uizoJ30zjUiWjWzhntUI0rl/W60f5YGoeuZ/V4w9KDs6w03+P
 DHCD+gM3mzJEqQ9XfeTvzVRiuTRe0FciS6qP56kmfaswvv6GSaXhEJMRbljs8sqA7oi6ArDrA
 /D17vOsMspopDe99i3IHUyZxta2FjTl5IUqTsDBNUTB5H/p9hq+Mt5yeKzef/oMaxBTPf538v
 rMS2PrIB4HDZvHKFAaaenUsHczQ=
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        LOTS_OF_MONEY,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/19 16:55, Andrei Borzenkov wrote:
> On Wed, Apr 19, 2023 at 3:24 AM David Sterba <dsterba@suse.cz> wrote:
>>
>> On Mon, Apr 17, 2023 at 05:48:10PM +0800, Qu Wenruo wrote:
>>> [BUG]
>>> There is a bug report that "btrfs inspect logical-resolve" can not even
>>> handle any file inside non-top-level subvolumes:
>>>
>>>   # mkfs.btrfs $dev
>>>   # mount $dev $mnt
>>>   # btrfs subvol create $mnt/subv1
>>>   # xfs_io -f -c "pwrite 0 16k" $mnt/subv1/file
>>>   # sync
>>>   # btrfs inspect logical-resolve 13631488 $mnt
>>>   inode 257 subvol subv1 could not be accessed: not mounted
>>>
>>> This means the command "btrfs inspect logical-resolve" is almost useless
>>> for resolving logical bytenr to files.
>>>
>>> [CAUSE]
>>> "btrfs inspect logical-resolve" firstly resolve the logical bytenr to
>>> root/ino pairs, then call btrfs_subvolid_resolve() to resolve the path
>>> to the subvolume.
>>>
>>> Then to handle cases where the subvolume is already mounted somewhere
>>> else, we call find_mount_fsroot().
>>>
>>> But if that target subvolume is not yet mounted, we just error out, even
>>> if the @path is the top-level subvolume, and we have already know the
>>> path to the subvolume.
>>>
>>> [FIX]
>>> Instead of doing unnecessary subvolume mount point check, just require
>>> the @path to be the mount point of the top-level subvolume.
>>
>> This is a change in the semantics of the command, can't we make it work
>> on non-toplevel subvolumes instead? Access to the mounted toplevel
>> subvolume is not always provided, e.g. on openSUSE the subvolume layout
>> does not mount 5 and there are likely other distros following that
>> scheme.
> 
> The BTRFS_IOC_INO_PATHS ioctl used to map inode number to path expects
> opened file on subvolume as argument and it is not possible unless
> subvolume is accessible. So either different ioctl is needed that
> takes subvolume is/name as argument or command has to mount subvolume
> temporarily if it is not available.

Nope, if you're at the toplevel subvolume, all subvolumes can be 
accessed, and btrfs_subvolid_resolve() gives us the path from TOP-LEVEL 
subvolume to the target one.


