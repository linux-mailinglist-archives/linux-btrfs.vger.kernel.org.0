Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C30D2422B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 01:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgHKXE3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 19:04:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:60077 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgHKXE3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 19:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597187064;
        bh=uKAgCO3RBu4JaXinB4Phs9JJv8+XX6wMSmVlzGawWEY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=R9DqEHP/vOEeNTyGFUVb5+plG6ssFRxt300nJ8AB4R+smtCdjBncw51UKuvw1E32H
         J0VL94gQfkKr+S95RvLtrslLXRz8vtl5NYRThAm/6HOGaKxfx0hpWbXgQig6UhL+Z1
         wNLW2z1yr7aIDg9sYp9bICYqQc3xpcwkrF1jyRkg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMobO-1kOP9g0YNg-00ImNW; Wed, 12
 Aug 2020 01:04:24 +0200
Subject: Re: [PATCH v3 3/5] btrfs: Detect unbalanced tree with empty leaf
 before crashing btree operations
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200809120919.85271-1-wqu@suse.com>
 <20200809120919.85271-4-wqu@suse.com>
 <8d21ba85-52a5-5419-dc16-ceece8b0c3a8@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <dbe1176e-db46-7ff7-1231-ee69d7c3c5d1@gmx.com>
Date:   Wed, 12 Aug 2020 07:04:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8d21ba85-52a5-5419-dc16-ceece8b0c3a8@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3tKwSQg9LaLtgjMLb2Nd5Py/4IATyNVaS+rxVMgh9i7VmggPNRP
 iJ6hwfaoJYRkEw9LIWu/wYL9WFBGddgP33GDGYNhV2jNOcMtV9NERsFFecNOxDP7Dmn121Z
 u8dV43rmnX6eSk/K/+fFtKhgj8KqSXHZ27yN5ovenHCDTkaHGinVX9AQpsuYZdWkaqTUzzI
 QtgionBCIvitXFzy85zuA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bdI1Cj0eams=:19IyB1J1nUqw3pg2JYgBE+
 FV/Zzo+PnyjvcHbk3ofb4l3A+apY3sBmEiinekJpzIRzBDvKnLUTbb7FPc77Zqez9Eek4YETF
 8/tSlll90Pq/Gl7dW/GqS8g7j6OoTC/GIG5DPScOWre34OkeVcJtf3hdNU18uiBcbQykZahMu
 OpWZtKMExnO83tHRXekDo0xaZ8YoQZJGEEyLiveEP5p+AE3QcIDzAT75W0o+KEWCcFGftGcIg
 LpszBoNniMBcNo0RgPYaKQQ2AaQXd3nQ7F3Z6YWc04FXZT5dmSihnA5Y0InsKaS9aIruhP96q
 nVfd1QS4qrzqttspTiO0Zxn1XxnfIjd9JAJmR7cl6jYBEH0NUhmILG1Q7KNtKY7u6ptNdDGdw
 vup7no0vizyiA5yLqBTU8CCHZXl94tjwpamGHdau4Gjp4+mEBiYbB5viCCGTd4Psc9DLMeSP2
 n7PDwjFXUGINC7oRg5M7myUwYZvnbMXbCk1pcsIWEHIzKgo6Lvomi2riqbWRSss1Ih6Keaolc
 Urds0cuW+Sr40jsZ2U7CiJdCnqVpDhdqqIq0jNT2ik+Awk64+uWDJ6+24Caa1hn5gEENreJzx
 WVKXQ1/y6/lyGDl0GBkm8pBas7+wDl2J/kxNnCiW/jpvIK0M/+GIBUutPJ8T6eWWaWjEjtjOF
 OG971+eGNgEaCDFksENpK1A7w2zICvggqFKw1WX1wDpNDTDtV75RpSdUI/p117YpD+yoes3F0
 iGGi24yCoCmVGFa83jYuRZQBsp/jim6xu6tI4isY1KJ/Flc0v7EUpriEzi25zsypsaXgUwJMm
 iLPgZ68YKlXSYflqmKqlTKbZaVO87mWN0dR9gJ+7kfFLoF8vcSiL7ptxplqGOUgfEo5fnQfP2
 DP1kStS11skWGMJHyboCujbTy/PCsyi7m32IJZ/X3vHFMo09Rj19wIjt/+V6Xe50p34VpvHBd
 qMqeS3erQpp+5lTrRBUsyMrRvkgrAul7rWAfLFlCmqsrYmqaZdTUNfC7lX3hi1SAeCJUC+8OM
 mhzQoiP9DA7Fz0Tok/tUyMBhIFFbJ1dbQjaPi+Bx3igSMTqfkeuHyTQ0WTonxJzG7UFNEhpDg
 LRrw4ltUuoCx72nLUowj7dSXgLcFNsu0DdK3LFuWxZaMEyogwiVEc3fuRwgL9XUjQa+2irApg
 7wGAMX5XOxlyUqCjouGOxU8WA0gko0OzhQ7vFYKIRYpc5vbtqzar+M+Di7CybzgvbdUy/Okcz
 alNXJcOM+ZRUc1bJx/ju6JzyFaFTZU5szab9aqw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/8/12 =E4=B8=8A=E5=8D=882:48, Josef Bacik wrote:
> On 8/9/20 8:09 AM, Qu Wenruo wrote:
>> [BUG]
>> With crafted image, btrfs will panic at btree operations:
>> =C2=A0=C2=A0 kernel BUG at fs/btrfs/ctree.c:3894!
>> =C2=A0=C2=A0 invalid opcode: 0000 [#1] SMP PTI
>> =C2=A0=C2=A0 CPU: 0 PID: 1138 Comm: btrfs-transacti Not tainted 5.0.0-r=
c8+ #9
>> =C2=A0=C2=A0 RIP: 0010:__push_leaf_left+0x6b6/0x6e0
>> =C2=A0=C2=A0 Code: 00 00 48 98 48 8d 04 80 48 8d 74 80 65 e8 42 5a 04 0=
0 48 8b
>> bd 78 ff ff ff 8b bf 90 d0 00 00 89 7d 98 83 ef 65 e9 06 ff ff ff <0f>
>> 0b 0f 0b 48 8b 85 78 ff ff ff 8b 90 90 d0 00 00 e9 eb fe ff ff
>> =C2=A0=C2=A0 RSP: 0018:ffffc0bd4128b990 EFLAGS: 00010246
>> =C2=A0=C2=A0 RAX: 0000000000000000 RBX: ffffa0a4ab8f0e38 RCX: 000000000=
0000000
>> =C2=A0=C2=A0 RDX: ffffa0a280000000 RSI: 0000000000000000 RDI: ffffa0a4b=
3814000
>> =C2=A0=C2=A0 RBP: ffffc0bd4128ba38 R08: 0000000000001000 R09: ffffc0bd4=
128b948
>> =C2=A0=C2=A0 R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000240
>> =C2=A0=C2=A0 R13: ffffa0a4b556fb60 R14: ffffa0a4ab8f0af0 R15: ffffa0a4a=
b8f0af0
>> =C2=A0=C2=A0 FS: 0000000000000000(0000) GS:ffffa0a4b7a00000(0000)
>> knlGS:0000000000000000
>> =C2=A0=C2=A0 CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> =C2=A0=C2=A0 CR2: 00007f2461c80020 CR3: 000000022b32a006 CR4: 000000000=
00206f0
>> =C2=A0=C2=A0 Call Trace:
>> =C2=A0=C2=A0 ? _cond_resched+0x1a/0x50
>> =C2=A0=C2=A0 push_leaf_left+0x179/0x190
>> =C2=A0=C2=A0 btrfs_del_items+0x316/0x470
>> =C2=A0=C2=A0 btrfs_del_csums+0x215/0x3a0
>> =C2=A0=C2=A0 __btrfs_free_extent.isra.72+0x5a7/0xbe0
>> =C2=A0=C2=A0 __btrfs_run_delayed_refs+0x539/0x1120
>> =C2=A0=C2=A0 btrfs_run_delayed_refs+0xdb/0x1b0
>> =C2=A0=C2=A0 btrfs_commit_transaction+0x52/0x950
>> =C2=A0=C2=A0 ? start_transaction+0x94/0x450
>> =C2=A0=C2=A0 transaction_kthread+0x163/0x190
>> =C2=A0=C2=A0 kthread+0x105/0x140
>> =C2=A0=C2=A0 ? btrfs_cleanup_transaction+0x560/0x560
>> =C2=A0=C2=A0 ? kthread_destroy_worker+0x50/0x50
>> =C2=A0=C2=A0 ret_from_fork+0x35/0x40
>> =C2=A0=C2=A0 Modules linked in:
>> =C2=A0=C2=A0 ---[ end trace c2425e6e89b5558f ]---
>>
>> [CAUSE]
>> The offending csum tree looks like this:
>> checksum tree key (CSUM_TREE ROOT_ITEM 0)
>> node 29741056 level 1 items 14 free 107 generation 19 owner CSUM_TREE
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key (EXTENT_CSUM EXTEN=
T_CSUM 85975040) block 29630464 gen 17
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key (EXTENT_CSUM EXTEN=
T_CSUM 89911296) block 29642752 gen 17 <<<
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key (EXTENT_CSUM EXTEN=
T_CSUM 92274688) block 29646848 gen 17
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>>
>> leaf 29630464 items 6 free space 1 generation 17 owner CSUM_TREE
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 0 key (EXTENT_CSU=
M EXTENT_CSUM 85975040) itemoff 3987
>> itemsize 8
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 range start 85975040 end 85983232 length 8192
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>> leaf 29642752 items 0 free space 3995 generation 17 owner 0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^ empty leaf=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 invalid owner ^
>>
>> leaf 29646848 items 1 free space 602 generation 17 owner CSUM_TREE
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item 0 key (EXTENT_CSU=
M EXTENT_CSUM 92274688) itemoff 627
>> itemsize 3368
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 range start 92274688 end 95723520 length 34488=
32
>>
>> So we have a corrupted csum tree where one tree leaf is completely
>> empty, causing unbalanced btree, thus leading to unexpected btree
>> balance error.
>>
>> [FIX]
>> For this particular case, we handle it in two directions to catch it:
>> - Check if the tree block is empty through btrfs_verify_level_key()
>> =C2=A0=C2=A0 So that invalid tree blocks won't be read out through
>> =C2=A0=C2=A0 btrfs_search_slot() and its variants.
>>
>> - Check 0 tree owner in tree checker
>> =C2=A0=C2=A0 NO tree is using 0 as its tree owner, detect it and reject=
 at tree
>> =C2=A0=C2=A0 block read time.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D202821
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> This test is done further down, just after a
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_header_generation(e=
b) > fs_info->last_trans_committed)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 0;
>
> Which I assume is the problem?=C2=A0 The generation is 19, is that >
> last_trans_committed?=C2=A0 Seems like this check just needs to be moved
> lower, right?=C2=A0 Thanks,

Nope, that generation 19 is valid. That fs has a higher generation, so
that's completely valid.

The generation 19 is there because there is another csum leaf whose
generation is 19.

Thanks,
Qu

>
> Josef
