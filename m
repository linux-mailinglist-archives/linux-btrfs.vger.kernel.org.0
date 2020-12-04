Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481EB2CE8C9
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Dec 2020 08:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgLDHsP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Dec 2020 02:48:15 -0500
Received: from mout.gmx.net ([212.227.15.15]:37797 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgLDHsP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Dec 2020 02:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607068002;
        bh=4ouVk1YV4k5qoj34RwePLmzOCN7jUyTnaN5fk9R2CTQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CE24v2o7gGrWMIiYNRa3GMHmrMVal3V5CoIpDfoEjFJrq+vfCpAoXWV2YT5uqMnCe
         jVpXYbwuUVh7Nwtm8lT0FY/Fur4KqMbKKY0MN/qwyhToJCglQjB643kbZITjO1CUrk
         TQ7AxVLH2jPgI+GPJ0X1uf71D2wf4Bx2EzeoGdSQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDhhN-1kvEnu0lYl-00AjHM; Fri, 04
 Dec 2020 08:46:41 +0100
Subject: Re: [PATCH] btrfs: qgroup: don't commit transaction when we already
 hold the handle
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>
References: <20201204012448.26546-2-wqu@suse.com>
 <4fce0773-a0ba-4c74-0134-8bc22a95d23e@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <bd2a0740-956c-5b4c-d54c-a08963ff6793@gmx.com>
Date:   Fri, 4 Dec 2020 15:46:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4fce0773-a0ba-4c74-0134-8bc22a95d23e@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:klMP435mwLqYJ0s6pS/uzAtaNO0upkfNX4v5dHUii774MV5aBRD
 p6gwVDEgD/uu7oH5Reb/C34VZ5sL4oYmR6Ezh0w/F+qu3J5oORmjDnUZXwyTY7ig2WDvkDY
 wA7BzquMkn1BHmZCzANs7tEm92rqgBABdM4gmu+zmUgSlmFxDcVd1bWJM2qLc2luRfBxvfl
 xplCFvzrfov44HdFXh8LA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:s+LcHYpgVQU=:1cIjW10pUbLyIMMcN+xfat
 xsn2M1hXwjjcb6EgwstO8vUyqz768QIWuyvw+m1GxtTn1hDHO6LO2F+tiBGxENdXXw2pH+sLN
 NYcyKc1zQFJA6ta3hEuj029jlSCMIKFGScycXUTvxElazBalfKJHO9jGq2nvJ200mUmwsdbVk
 vVbgKnwqeD0KlvWeizjQOj235JzticALg/ONT2R/s9qEKoFbYC685c76lUwP4luYXX89XUFOV
 U7cGNYA6ZRgHKVi5L3G2TnUWHXS55pH21gYZU6pYP/tov11O425EMGjRnv6Eka4c65kZ8J6jQ
 +jTfG1WDMG77/ugFTl/sO6ifgOID41OvbwfWbWxbZCDHWwtMjALH1LUr7VNZ7CDKokC+nTRb6
 T6Nvu5MVXmMTL072QVjH8WM2+PFak/UYSx2rRFJ6SowU+GP5Dh/QPcUqPC6MVMZIC62nD3AST
 3sN1qmWJOsMBULabPANO+vbhsVRjWk4EnCGTaJhOrXRFBIee4CNR/wL0v1d6Hkn5crv6Q3GJZ
 7Bb4NcuKsMoGnVKFnV2AZRwX/O/r2WTXE/58EpvL4oQc1Q336lgOZB3y99aVPCHfkq+dPLx8w
 adW7/zhIfiQeFcLwa6z//rFEqhRZlv/K/46+ijvgEouKhGJU0MK9bAU3oUPaUEaEMDxFj0aet
 Gh8a9Td/LkDUPoTBxAiAzBxevGaDqAIgtknr+mj0rTitcOWpaK1QGhmllV2K2H/14lMtI0JMw
 T43jlBjZa6JF2XS2tGlVPeUDr8+6/08o9QKmI8USNc56eWnLZ/NMFXLbkdaBW3iOF3cExIgur
 i28xzEowT1Cafa1IbUyFBK3rToBdHMFKZEsuMJyOrBt5n+1pAtXGC7QGjIoWSrUZXvangXxig
 OmeWQg0JERvqkTj/YVIw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/4 =E4=B8=8B=E5=8D=883:37, Nikolay Borisov wrote:
>
>
> On 4.12.20 =D0=B3. 3:24 =D1=87., Qu Wenruo wrote:
>> [BUG]
>> When running the following script, btrfs will trigger an ASSERT():
>>
>>   #/bin/bash
>>   mkfs.btrfs -f $dev
>>   mount $dev $mnt
>>   xfs_io -f -c "pwrite 0 1G" $mnt/file
>>   sync
>>   btrfs quota enable $mnt
>>   btrfs quota rescan -w $mnt
>>
>>   # Manually set the limit below current usage
>>   btrfs qgroup limit 512M $mnt $mnt
>>
>>   # Crash happens
>>   touch $mnt/file
>>
>> The dmesg looks like this:
>>
>>   assertion failed: refcount_read(&trans->use_count) =3D=3D 1, in fs/bt=
rfs/transaction.c:2022
>>   ------------[ cut here ]------------
>>   kernel BUG at fs/btrfs/ctree.h:3230!
>>   invalid opcode: 0000 [#1] SMP PTI
>>   RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
>>    btrfs_commit_transaction.cold+0x11/0x5d [btrfs]
>>    try_flush_qgroup+0x67/0x100 [btrfs]
>>    __btrfs_qgroup_reserve_meta+0x3a/0x60 [btrfs]
>>    btrfs_delayed_update_inode+0xaa/0x350 [btrfs]
>>    btrfs_update_inode+0x9d/0x110 [btrfs]
>>    btrfs_dirty_inode+0x5d/0xd0 [btrfs]
>>    touch_atime+0xb5/0x100
>>    iterate_dir+0xf1/0x1b0
>>    __x64_sys_getdents64+0x78/0x110
>>    do_syscall_64+0x33/0x80
>>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>   RIP: 0033:0x7fb5afe588db
>>
>> [CAUSE]
>> In try_flush_qgroup(), we assume we don't hold a transaction handle at
>> all.  This is true for data reservation and mostly true for metadata.
>> Since data space reservation always happens before we start a
>> transaction, and for most metadata operation we reserve space in
>> start_transaction().
>>
>> But there is an exception, btrfs_delayed_inode_reserve_metadata().
>> It holds a transaction handle, while still trying to reserve extra
>> metadata space.
>>
>> When we hit EDQUOT inside btrfs_delayed_inode_reserve_metadata(), we
>> will join current transaction and commit, while we still have
>> transaction handle from qgroup code.
>>
>> [FIX]
>> Let's check current->journal before we join the transaction.
>>
>> If current->journal is unset or BTRFS_SEND_TRANS_STUB, it means
>> we are not holding a transaction, thus are able to join and then commit
>> transaction.
>>
>> If current->journal is a valid transaction handle, we avoid committing
>> transaction and just end it
>>
>> This is less effective than committing current transaction, as it won't
>> free metadata reserved space, but we may still free some data space
>> before new data writes.
>>
>> Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=3D1178634
>> Fixes: c53e9653605d ("btrfs: qgroup: try to flush qgroup space when we =
get -EDQUOT")
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> Signed-off-by: David Sterba <dsterba@suse.com>
>
> Wasn't this submitted already? Also are you going to turn the example
> script into a fstest?
>
Sorry, I forgot to cleanup my patches directory. (Facepalm

The fstests is already submitted:
https://patchwork.kernel.org/project/linux-btrfs/patch/20201111113152.1367=
29-1-wqu@suse.com/

Thanks,
Qu
