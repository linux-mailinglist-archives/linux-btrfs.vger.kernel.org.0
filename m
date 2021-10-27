Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57F943C424
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 09:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbhJ0Hnz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 03:43:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:35835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240527AbhJ0Hny (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 03:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635320487;
        bh=AOOawK6goSntAKO26toW/bcDTAZezeO29iw+I/BvSn4=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=h3aZPMls15dRKCpRjKnHJ+EUKRD2/HmCturJDdwkWWW4QM/xlgLKs9CWYQ1czAeiJ
         7+llAYnkIxgdsHr+5QtKwrdtzZoJyQxHBD8x5v89kLY2mwrAPgmcm7D4sqEZlHHCDV
         yFJqtUaJ5SZU4hcdJdMdVH/vebmUdIW/UKqGHGIU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmULr-1n5vt920JN-00iV0f; Wed, 27
 Oct 2021 09:41:27 +0200
Message-ID: <06ccca88-72f7-be2e-4ba4-87ca947aa9be@gmx.com>
Date:   Wed, 27 Oct 2021 15:41:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211027052859.44507-1-wqu@suse.com>
 <20211027052859.44507-3-wqu@suse.com>
 <62d6f59e-b4f0-fb47-54b2-bb6e5c5b744b@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 2/2] btrfs: use ilog2() to replace if () branches for
 btrfs_bg_flags_to_raid_index()
In-Reply-To: <62d6f59e-b4f0-fb47-54b2-bb6e5c5b744b@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GbKeP6uKk0B4/fto8Z2uhbZhp/2qLfqCeo9XK3GVnRDm64zb1rW
 BhjfKN/H4kys9PfLajPLLKlsDgc5SG2oDHPvCeqOrSxH8Qh9lglMPY2Pm/6Xf5s1ZsJgGvJ
 r5one3Nk6Qh+y5GF6Jedm5yhygWZyKL/R1oTOwEuPW6lJj8ULVZe8Gr1Fqw1cJNW2S5xusw
 MTGOE6v9mkrnd0Hab0ybQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XL76ySczgVY=:PxsXao9O7KEw9w3VJCpVDy
 qwq726deh9Me0Z53u+ej9YqbrRWArJ4op8uYGoHIIzKSksiV9J8GdCuq/k+k0G4L3Vo8ARTHk
 OSxrXLxXzjU0Bwj/ms6ySFylm2GVDi9qb4c6411qyNHKD91uBKV1jhoOOLU7Ov21XH4Pp/tus
 qw7G7451wS3HTde+uKXo4P6p6yjiWdSrKCJMoafTni37GHKdi6KLV/WYlOaVmx2PM9eV14vLx
 sDdoZEPH7/7GxczcUfcnbJAsA7N+cWH8KGB0TUdQgQrdayKPgyze3GwCeAA+/0Yjw40QNUsxJ
 7xfBHkd56jhovneuQngU/8ta/QYaospxgC46Q/ppQq2LiEZhrTlkVvhFhocNP/squMSSYnPqc
 3373SszawwmrsO5QDO+B9aKWWFl5kbmhED0UzifiWjEpOwEmDtxbSG/gDE6ZXqFWeMdzdauMy
 7rV2ZmZUUxznIIkZ4K6HuR0XYmYl4duk7U8LG0NsBbJz1Qc1n1EJQxIV5R2yauc8ilRA60HCS
 9t6rvMpXadNgRHtrOuLwwUB5fNkAXiIoeaUCAbYXdSOGxMVpXxuSk+Ymum3ghBWD3CEpFRWXP
 gg2lDfVuY54SHjV26Nmlpsfm7MXDlKM55bjm87Z/JOn4Tc3aQ4Tv+uqVsHfpI+cvZhyrU6fP0
 nv1kyz6/UaStMcgpX9bjg7I+YWPM6afFNRB2dv1lOAK1xHY8FESaE/DRIV+q02qIBuBnILwy/
 q4zMBvHZ3i77iaq0AzOzNHDiEmqX5M3KGnOaoBMKrSr/oj/Upu0DlqGy3TlD1pAY+BepN1anJ
 DifaV8HQL7emnCfI0KNthGqaAuudcS8Ceq/7sHUddoh8h/sukaKI+moVyEh+19s7QRGRKxFjm
 RxY2SanodjKGgOdErYScB+tD+ghGWWYxkTxWCOr5ApUv07E8VBtNF103CKfIh9oXMhRF75MY3
 91Okye97ef4XeOsmYSek9jAQUyK7bsZ5dXVyN2iBXgmZzZjJjLX9RMiiU8RcmHB+QUq4Jr/UL
 o/YzDEvDmDzUGIQrQpXOvk5on6DXo3DK6JHtd3ot59fQpNGsI7avnziUZQdSoyb8Ac0AshkNn
 El5S9E2a/9AyN4=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/27 14:37, Nikolay Borisov wrote:
>
>
> On 27.10.21 =D0=B3. 8:28, Qu Wenruo wrote:
>> In function btrfs_bg_flags_to_raid_index(), we use quite some if () to
>> convert the BTRFS_BLOCK_GROUP_* bits to a index number.
>>
>> But the truth is, there is really no such need for so many branches at
>> all.
>> Since all BTRFS_BLOCK_GROUP_* flags are just one single bit set inside
>> BTRFS_BLOCK_GROUP_PROFILES_MASK, we can easily use ilog2() to calculate
>> their values.
>>
>> Only one fixed offset is needed to make the index sequential (the
>> lowest profile bit starts at ilog2(1 << 3) while we have 0 reserved for
>> SINGLE).
>>
>> Even with that calculation involved (one if(), one ilog2(), one minus),
>> it should still be way faster than the if () branches, and now it is
>> definitely small enough to be inlined.
>>
>
> Is this used in a performance critical path,

Not really in a hot path.

Most of them are called in a per block group/chunk base.

The only hotter path is in __btrfs_map_block() where if we need full
stripe, we will call btrfs_chunk_max_errors() which in turn call the
function.

That's the hottest path I can find, and even for that case it's just
per-bio base.

> are there any numbers which prove that it's indeed faster?

No real world bench for it.

But from x86_75 asm code, it's definitely smaller, with only one branch.

New:
btrfs_bg_flags_to_raid_index:
         xorl    %eax, %eax
         andl    $2040, %edi
         je      .L2499
         shrq    $2, %rdi
         movl    $-1, %eax
         bsrq %rdi,%rax
.L2499:
         ret

Old:
btrfs_bg_flags_to_raid_index:
         xorl    %eax, %eax
         testb   $64, %dil
         jne     .L429
         movl    $1, %eax
         testb   $16, %dil
         jne     .L429
         movl    $7, %eax
         testl   $512, %edi
         jne     .L429
         movl    $8, %eax
         testl   $1024, %edi
         jne     .L429
         movl    $2, %eax
         testb   $32, %dil
         jne     .L429
         movl    $3, %eax
         testb   $8, %dil
         jne     .L429
         movl    $5, %eax
         testb   $-128, %dil
         jne     .L429
         andl    $256, %edi
         cmpq    $1, %rdi
         sbbl    %eax, %eax
         andl    $-2, %eax
         addl    $6, %eax
.L429:
         ret

Which I don't really believe the older code can be any faster,
considering so many branches, and pure lines of asm.

Thanks,
Qu
