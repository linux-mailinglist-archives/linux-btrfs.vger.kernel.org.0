Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAE225A2BB
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 03:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgIBBri (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 21:47:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:36559 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbgIBBqm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Sep 2020 21:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599011194;
        bh=uRib9XEGOO0hSnxZ/n0yAv8VteduFYx6A+RWYVvQidA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bOz/CUvSuMxpVpAEaR6w9xvXfSfq2EfUEyC8Ad6OhwGfpQUbvbE9rt49ImIk8Suuy
         4zSXjLip/gTPIQoO7qI6sU21XmM6alraHJUvZFQ/G3iB8s1UVbnuQjlym4CdJEiKco
         Zh9t4jVOibuZgIF5P1ZUSEM9546sk0Se4BphD/tA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHoRA-1kOn6N1Mj0-00EwuQ; Wed, 02
 Sep 2020 03:46:34 +0200
Subject: Re: BUG at fs/btrfs/relocation.c:794! Still happening on misc-next
 and 5.8.3
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        wqu@suse.com
References: <20200630221006.17585-1-dsterba@suse.com>
 <20200723215641.GE5890@hungrycats.org>
 <bfecfacd-2d9d-386d-dfb7-951a5c5c6f6e@gmx.com>
 <20200804161626.GN5890@hungrycats.org> <20200828000313.GS5890@hungrycats.org>
 <20200828000822.GT5890@hungrycats.org>
 <720f3ac7-6af5-e171-5947-ed0240d5f5e5@suse.com>
 <20200828204255.GV5890@hungrycats.org> <20200901225341.GY5890@hungrycats.org>
 <45343d53-7dc0-1a7b-6da5-6461b653cde0@gmx.com>
 <20200902001429.GZ5890@hungrycats.org>
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
Message-ID: <e2c84d2e-5038-7aaa-2bdf-789f5e075245@gmx.com>
Date:   Wed, 2 Sep 2020 09:46:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902001429.GZ5890@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kq5g+p/peejFQH9BvB23eyQF00jq5CpVHp64oAwqZkBmBGuHSGa
 vXwPtYhMpa5HZPwY0aye8WcDuUrjkHNr/cQAEDU3XA2hz4BcC7HUnQDUya4IlMlF0eup1Uv
 sIBzj80NBy3R3dULPbsi8ghjkb2B/oNEjo8dPHKbYEGPk0bn0Vr7Ov3ijIFjlbDOdjxIG7T
 i7TqxXnln03aCXFIDZoiA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XHch8Tf/b6Y=:ChExkbyzUUJMs42i1ygcb1
 mIZo5t520l63hIsCv+WfMek4E13/0hRYtGsFhgNzqUF+oZWM/BzZmILQzISYtduUBrMDdxeQ5
 4hZMwLIllkTroEtCGvo932pI6LsBFNiNDkBaXD3GAohf0ktVnOalQp2VV7LzVE2/8yrjzz1pN
 aqwrGDEkb9s/WPTvHoiQhNNMCyUx/vG1P6JsU5qObZWMBGIC+ot47fjTfB0qZ+1nWzN2r/B21
 xpjybnhgeDaji3GfeawEPD2zXEXO0oDaxZfXXOX8AomeMXkODT8mJ8lgLiidC1bsdXI0s3ojY
 Ruxl17eOpjfNfaBbfkwwthPF1t02IoRjqJJnbpTEr8seOygCZVjNJS8LJn7ckR1W4VyDfstNv
 uwdCv1BuadsD5OEjOH/2KLiPpOm9Py/bV7PzenoAQJn1p4PNqnMVrhMvj/AEyP4D7A3ERXx0+
 luz5wyvfUk6mu2dk80b4nLlO+2BaHaPdGEjcbnI7rtJGvKNb4pgAyjffb+ZpEAurpc5klKIBO
 5FVcDZY6RzmyZ28KgWp4LGqncFLRoA9nQ2NTY5qZh6nawUg2fh9jg9OBqJ2mFLWQHEApXMehh
 +AQJg460RfGWdhzrsT4CwMslpmGBr7+Nin51+h9K+76xvGfv42u6tOrhlGo+8zbpRTe2Eenn9
 nmqwm81uC6DdCYQI2R6b+BxT/F72ZgKjI9Y6kE0RQ+wbD8XCQUm/ShXfRUHvy56szYCjDMLRg
 QQyb86Pm0lzw2AQzTUxK3cLSwTA/OLEo4SE4EK0cvsSBV6rhCvDvTI6xzxyiKApwVlRu5qs5I
 rKuQdtlvn5dMVvicLUJ52qP0DOPeTzjmQt1hFdEA5SH+Dhdbplv7cEHcqr+g8/uwiHm7aZ/Xl
 iwwJ0PPd2wp2Ngyx7DhAneyPXJ9TkKy/wDcXUU4q5VKXvxTL9NrNxyLxxsjqXvbubLE88G5xX
 J1hjOP/dDhqFHEUVyDcEIpJ8V7l/bEWv0Ux9jviu6vTj5ocdE1L4MwKDS7nfZ4SkAiLjvo2oQ
 0bSBXSTsX7pwhSgLTlUz/xhiwvjY/Z4vNslURZ6hGiPrQiEOY1WjtwVQ7uy/lwVXSv3dxDjTH
 kxOcbHXxlgBQTeSVtnrxrOEyPIeLai/jRTL12s+HM5FAEiJbyafi5LglwZuMaNOlaEv1/qCux
 e66qVHjvk0bu2gu12VT4sBJQdA6uXd3cDOtwK9+lPP2NLMEsPuUweCDmkWPlDv0DptdHH9VM7
 mBoXNhkOVbC8/r7WJgAReUTP+h64Rei0rwjfUtg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/2 =E4=B8=8A=E5=8D=888:14, Zygo Blaxell wrote:
> On Wed, Sep 02, 2020 at 07:33:21AM +0800, Qu Wenruo wrote:
>> This looks like a race between some reloc tree creation from some other
>> part.
>>
>> If you could add debug output for create_reloc_root() and its callers,
>> we may have a chance to debug it.
>
> The callers are always the same:
>
> 	btrfs_init_reloc_root+0x1b0
> 	record_root_in_trans+0x18c
> 	record_root_in_trans+0x8b
> 	start_transaction+0x189
>
> 	(gdb) l *(create_reloc_root+0x468)
> 	0xffffffff81930848 is in create_reloc_root (fs/btrfs/relocation.c:1503)=
.
> 	1498            btrfs_tree_unlock(eb);
> 	1499            free_extent_buffer(eb);
> 	1500
> 	1501            ret =3D btrfs_insert_root(trans, fs_info->tree_root,
> 	1502                                    &root_key, root_item);
> 	1503            BUG_ON(ret);
> 	1504            kfree(root_item);
> 	1505
> 	1506            reloc_root =3D btrfs_read_tree_root(fs_info->tree_root,=
 &root_key);
> 	1507            BUG_ON(IS_ERR(reloc_root));
> 	(gdb) l *(btrfs_init_reloc_root+0x1b0)
> 	0xffffffff81937db0 is in btrfs_init_reloc_root (fs/btrfs/relocation.c:1=
567).
> 	1562            if (!trans->reloc_reserved) {
> 	1563                    rsv =3D trans->block_rsv;
> 	1564                    trans->block_rsv =3D rc->block_rsv;
> 	1565                    clear_rsv =3D 1;
> 	1566            }
> 	1567            reloc_root =3D create_reloc_root(trans, root, root->roo=
t_key.objectid);
> 	1568            if (clear_rsv)
> 	1569                    trans->block_rsv =3D rsv;
> 	1570
> 	1571            ret =3D __add_reloc_root(reloc_root);
> 	(gdb) l *(record_root_in_trans+0x18c)
> 	0xffffffff81889bfc is in record_root_in_trans (./include/asm-generic/bi=
tops/instrumented-atomic.h:41).
> 	36       *
> 	37       * This is a relaxed atomic operation (no implied memory barrie=
rs).
> 	38       */
> 	39      static inline void clear_bit(long nr, volatile unsigned long *a=
ddr)
> 	40      {
> 	41              kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
> 	42              arch_clear_bit(nr, addr);
> 	43      }
> 	44
> 	45      /**
> 	(gdb) l *(start_transaction+0x189)
> 	0xffffffff8188f0d9 is in start_transaction (fs/btrfs/transaction.c:697)=
.
> 	692              * Thus it need to be called after current->journal_inf=
o initialized,
> 	693              * or we can deadlock.
> 	694              */
> 	695             btrfs_record_root_in_trans(h, root);
> 	696
> 	697             return h;
> 	698
> 	699     join_fail:
> 	700             if (type & __TRANS_FREEZABLE)
> 	701                     sb_end_intwrite(fs_info->sb);
> 	(gdb) quit
>
> It seems to be very early in the transaction.  Is there anything to
> output here?  Or are we more interested in what is left over from
> the previous transaction?

What I mean is, I want to see who else created the reloc tree, not only
who caused the EEXIST BUG_ON().

That's why I hope to add enough debug pr_info or whatever for
create_reloc_root(), so that we can catch the ordinary calls that seems
safe but may be unsafe for other callers.

Thanks,
Qu

>
>> But for the first step, we can hunt down the BUG_ON()s first and make i=
t
>> exist more gracefully.
>>
>> I'll try to spare some time to do this in the following week.
>>
>> Thanks,
>> Qu
>>
>> On 2020/9/2 =E4=B8=8A=E5=8D=886:53, Zygo Blaxell wrote:
>>> On Fri, Aug 28, 2020 at 04:42:55PM -0400, Zygo Blaxell wrote:
>>>> On Fri, Aug 28, 2020 at 09:34:31AM +0300, Nikolay Borisov wrote:
>>>>> On 28.08.20 =D0=B3. 3:08 =D1=87., Zygo Blaxell wrote:
>>>>>> On Thu, Aug 27, 2020 at 08:03:13PM -0400, Zygo Blaxell wrote:
>>>>>>> On Tue, Aug 04, 2020 at 12:16:26PM -0400, Zygo Blaxell wrote:
>>>>>
>>>>> <snip>
>>>>>
>>>>> Since you can repro reliably could you modify the code in
>>>>> create_reloc_root so it prints what's the returned error value, I'd
>>>>> speculate it's EEXIST from
>>>>>
>>>>> btrfs_insert_root
>>>>>   btrfs_insert_item
>>>>>    btrfs_insert_empty_item
>>>>>      btrfs_insert_empty_items
>>>>>        btrfs_search_slot
>>>>>
>>>>> But better be sure.
>>>>
>>>> Here you go, EEXIST =3D=3D 17:
>>>>
>>>> 	Aug 28 15:30:55 regress kernel: [18452.845182][T31546] BTRFS info (d=
evice dm-0): balance: start -dlimit=3D9
>>>> 	Aug 28 15:30:55 regress kernel: [18452.874627][T31546] BTRFS info (d=
evice dm-0): relocating block group 15873413742592 flags data
>>>> 	Aug 28 15:30:55 regress kernel: [18453.097516][ T2100] btrfs_search_=
slot ret =3D 0
>>>> 	Aug 28 15:30:55 regress kernel: [18453.104865][ T2100] btrfs_search_=
slot ret =3D 0
>>>> 	Aug 28 15:30:55 regress kernel: [18453.109751][ T2100] btrfs_search_=
slot ret =3D 0
>>>> 	Aug 28 15:30:56 regress kernel: [18454.453135][ T2100] btrfs_search_=
slot ret =3D 0
>>>> 	Aug 28 15:30:56 regress kernel: [18454.453955][ T2100] btrfs_insert_=
empty_item ret =3D -17
>>>> 	Aug 28 15:30:56 regress kernel: [18454.455022][ T2100] btrfs_insert_=
root ret =3D -17
>>>> 	Aug 28 15:30:56 regress kernel: [18454.456229][ T2100] ------------[=
 cut here ]------------
>>>> 	Aug 28 15:30:56 regress kernel: [18454.457622][ T2100] kernel BUG at=
 fs/btrfs/relocation.c:795!
>>>
>>> I did a low-resolution bisect for this issue.  I dug up 5.4, 5.5, 5.6,
>>> and 5.7 kernel sources, backported btrfs fixes from 5.4 to the obsolet=
e
>>> kernels, and ran the tests on each kernel.  Results:
>>>
>>> 	5.8:  kernel BUG at fs/btrfs/relocation.c:794
>>>
>>> 	5.7:  kernel BUG (same code but different line number)
>>>
>>> 	5.6:  kernel BUG (same as the others)
>>>
>>> 	5.5:  assertion failure (stack trace below)
>>>
>>> 	5.4:  kernel BUG (!)
>>>
>>> The 5.4 result is interesting--I've been running 5.4 for some time and
>>> not hit this before.  So there are 3 possible theories:
>>>
>>> 	1.  It's because of sending signals to balance.  That has been
>>> 	added to my test workload after 5.7 was released, so earlier
>>> 	tests on 5.4 would not have triggered it.
>>>
>>> 	2.  There's a regression in 5.4-stable, which I've cherry-picked
>>> 	to all the other kernels during my test setup.	(On the other
>>> 	hand, if I don't backport some fixes, kernels 5.5..5.7 crash
>>> 	before they get to this bug.)
>>>
>>> 	3.  There's something rotten in my test filesystem, and the
>>> 	BUG will go away for a while if I do a mkfs.  Qu asked for
>>> 	a dump earlier in this thread, and I provided one.
>>>
>>> All three of these theories are testable to some extent, so I'll have
>>> my test VM run some variations.
>>>
>>> The full test workload is:
>>>
>>> 	balance metadata or data at random intervals
>>>
>>> 	scrub, scrub cancel at random intervals
>>>
>>> 	20x rsync updating files
>>>
>>> 	snapshot create, delete at random intervals
>>>
>>> 	bees dedupe (lots of EXTENT_SAME and LOGICAL_INO calls)
>>>
>>> 	balance cancel at random intervals
>>>
>>> 	kill -9 $(pidof btrfs balance) at random intervals (NEW - added
>>> 	when 5.7 came out)
>>>
>>> This is the 5.5 root assertion failure:
>>>
>>> 	Sep  1 04:48:48 regress kernel: [10642.537825][T24161] assertion fail=
ed: root, in fs/btrfs/relocation.c:837
>>> 	Sep  1 04:48:48 regress kernel: [10642.538911][T24161] ------------[ =
cut here ]------------
>>> 	Sep  1 04:48:48 regress kernel: [10642.539704][T24161] kernel BUG at =
fs/btrfs/ctree.h:3125!
>>> 	Sep  1 04:48:48 regress kernel: [10642.540621][T24161] invalid opcode=
: 0000 [#1] SMP KASAN PTI
>>> 	Sep  1 04:48:48 regress kernel: [10642.540624][ T4639] irq event stam=
p: 49626809
>>> 	Sep  1 04:48:48 regress kernel: [10642.540632][ T4639] hardirqs last =
 enabled at (49626809): [<ffffffff8a00481a>] trace_hardirqs_on_thunk+0x1a/=
0x1c
>>> 	Sep  1 04:48:48 regress kernel: [10642.541451][T24161] CPU: 1 PID: 24=
161 Comm: btrfs Tainted: G        W         5.5.19-76348822ab91+ #14
>>> 	Sep  1 04:48:48 regress kernel: [10642.542114][ T4639] hardirqs last =
disabled at (49626808): [<ffffffff8a004836>] trace_hardirqs_off_thunk+0x1a=
/0x1c
>>> 	Sep  1 04:48:48 regress kernel: [10642.543693][T24161] Hardware name:=
 QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>>> 	Sep  1 04:48:48 regress kernel: [10642.545017][ T4639] softirqs last =
 enabled at (49626726): [<ffffffff8bc0048b>] __do_softirq+0x48b/0x5be
>>> 	Sep  1 04:48:48 regress kernel: [10642.545023][ T4639] softirqs last =
disabled at (49626715): [<ffffffff8a1258a2>] irq_exit+0x112/0x120
>>> 	Sep  1 04:48:48 regress kernel: [10642.546536][T24161] RIP: 0010:asse=
rtfail.constprop.42+0x1c/0x1e
>>> 	Sep  1 04:48:49 regress kernel: [10642.551589][T24161] Code: 48 c7 c6=
 c0 90 03 8c e8 89 29 f1 ff 0f 0b 55 89 f1 48 c7 c2 40 82 03 8c 48 89 fe 4=
8 c7 c7 60 83 03 8c 48 89 e5 e8 41 b0 90 ff <0f> 0b 0f 1f 44 00 00 55 48 8=
9 e5 41 54 49 89 f4 53 48 89 fb 48 83
>>> 	Sep  1 04:48:49 regress kernel: [10642.554495][T24161] RSP: 0018:ffff=
c90002327150 EFLAGS: 00010282
>>> 	Sep  1 04:48:49 regress kernel: [10642.555371][T24161] RAX: 000000000=
0000034 RBX: 000004513701c000 RCX: ffffffff8a264242
>>> 	Sep  1 04:48:49 regress kernel: [10642.556515][T24161] RDX: 000000000=
0000000 RSI: 0000000000000008 RDI: ffff8881f580004c
>>> 	Sep  1 04:48:49 regress kernel: [10642.557680][T24161] RBP: ffffc9000=
2327150 R08: ffffed103eb017e1 R09: ffffed103eb017e1
>>> 	Sep  1 04:48:49 regress kernel: [10642.558895][T24161] R10: ffffed103=
eb017e0 R11: ffff8881f580bf07 R12: ffff88800d1ea5c0
>>> 	Sep  1 04:48:49 regress kernel: [10642.560139][T24161] R13: ffffc9000=
23273e0 R14: 0000000000000000 R15: ffff8880bbf238f0
>>> 	Sep  1 04:48:49 regress kernel: [10642.561391][T24161] FS:  00007f03f=
48488c0(0000) GS:ffff8881f5600000(0000) knlGS:0000000000000000
>>> 	Sep  1 04:48:49 regress kernel: [10642.562779][T24161] CS:  0010 DS: =
0000 ES: 0000 CR0: 0000000080050033
>>> 	Sep  1 04:48:49 regress kernel: [10642.563801][T24161] CR2: 00007f1ca=
b76f718 CR3: 0000000189a5e004 CR4: 00000000001606e0
>>> 	Sep  1 04:48:49 regress kernel: [10642.565046][T24161] Call Trace:
>>> 	Sep  1 04:48:49 regress kernel: [10642.565565][T24161]  build_backref=
_tree+0x186b/0x2590
>>> 	Sep  1 04:48:49 regress kernel: [10642.566389][T24161]  ? relocate_da=
ta_extent+0x1a0/0x1a0
>>> 	Sep  1 04:48:49 regress kernel: [10642.567295][T24161]  ? lock_downgr=
ade+0x3d0/0x3d0
>>> 	Sep  1 04:48:49 regress kernel: [10642.568142][T24161]  ? match_held_=
lock+0x20/0x260
>>> 	Sep  1 04:48:49 regress kernel: [10642.568925][T24161]  ? do_raw_spin=
_unlock+0xa8/0x140
>>> 	Sep  1 04:48:49 regress kernel: [10642.569765][T24161]  ? _raw_spin_t=
rylock_bh+0x60/0x80
>>> 	Sep  1 04:48:49 regress kernel: [10642.570605][T24161]  ? release_ext=
ent_buffer+0x13b/0x230
>>> 	Sep  1 04:48:49 regress kernel: [10642.571480][T24161]  ? free_extent=
_buffer.part.45+0xd7/0x140
>>> 	Sep  1 04:48:49 regress kernel: [10642.572406][T24161]  relocate_tree=
_blocks+0x204/0xa50
>>> 	Sep  1 04:48:49 regress kernel: [10642.573244][T24161]  ? build_backr=
ef_tree+0x2590/0x2590
>>> 	Sep  1 04:48:49 regress kernel: [10642.574103][T24161]  ? rb_insert_c=
olor+0x3af/0x400
>>> 	Sep  1 04:48:49 regress kernel: [10642.574896][T24161]  ? kmem_cache_=
alloc_trace+0x5af/0x740
>>> 	Sep  1 04:48:49 regress kernel: [10642.575785][T24161]  ? tree_insert=
+0x90/0xb0
>>> 	Sep  1 04:48:49 regress kernel: [10642.576495][T24161]  ? add_tree_bl=
ock.isra.38+0x1d6/0x230
>>> 	Sep  1 04:48:49 regress kernel: [10642.577387][T24161]  relocate_bloc=
k_group+0x528/0x9d0
>>> 	Sep  1 04:48:49 regress kernel: [10642.578220][T24161]  ? merge_reloc=
_roots+0x470/0x470
>>> 	Sep  1 04:48:49 regress kernel: [10642.579047][T24161]  btrfs_relocat=
e_block_group+0x26e/0x4c0
>>> 	Sep  1 04:48:49 regress kernel: [10642.579968][T24161]  btrfs_relocat=
e_chunk+0x52/0xf0
>>> 	Sep  1 04:48:49 regress kernel: [10642.580773][T24161]  btrfs_balance=
+0xe5b/0x1800
>>> 	Sep  1 04:48:49 regress kernel: [10642.581542][T24161]  ? btrfs_reloc=
ate_chunk+0xf0/0xf0
>>> 	Sep  1 04:48:49 regress kernel: [10642.582381][T24161]  ? kmem_cache_=
alloc_trace+0x5af/0x740
>>> 	Sep  1 04:48:49 regress kernel: [10642.583270][T24161]  ? _copy_from_=
user+0xaa/0xd0
>>> 	Sep  1 04:48:49 regress kernel: [10642.584022][T24161]  btrfs_ioctl_b=
alance+0x3de/0x4c0
>>> 	Sep  1 04:48:49 regress kernel: [10642.584819][T24161]  btrfs_ioctl+0=
x3122/0x4470
>>> 	Sep  1 04:48:49 regress kernel: [10642.585540][T24161]  ? __asan_load=
N+0xf/0x20
>>> 	Sep  1 04:48:49 regress kernel: [10642.586229][T24161]  ? __asan_load=
N+0xf/0x20
>>> 	Sep  1 04:48:49 regress kernel: [10642.586920][T24161]  ? btrfs_ioctl=
_get_supported_features+0x30/0x30
>>> 	Sep  1 04:48:49 regress kernel: [10642.587935][T24161]  ? __asan_load=
N+0xf/0x20
>>> 	Sep  1 04:48:49 regress kernel: [10642.588649][T24161]  ? pvclock_clo=
cksource_read+0xeb/0x190
>>> 	Sep  1 04:48:49 regress kernel: [10642.589566][T24161]  ? __asan_load=
N+0xf/0x20
>>> 	Sep  1 04:48:49 regress kernel: [10642.590254][T24161]  ? pvclock_clo=
cksource_read+0xeb/0x190
>>> 	Sep  1 04:48:49 regress kernel: [10642.591128][T24161]  ? __kasan_che=
ck_read+0x11/0x20
>>> 	Sep  1 04:48:49 regress kernel: [10642.591913][T24161]  ? check_chain=
_key+0x1e6/0x2e0
>>> 	Sep  1 04:48:49 regress kernel: [10642.592707][T24161]  ? __asan_load=
N+0xf/0x20
>>> 	Sep  1 04:48:49 regress kernel: [10642.593409][T24161]  ? pvclock_clo=
cksource_read+0xeb/0x190
>>> 	Sep  1 04:48:49 regress kernel: [10642.594312][T24161]  ? kvm_sched_c=
lock_read+0x18/0x30
>>> 	Sep  1 04:48:49 regress kernel: [10642.595139][T24161]  ? check_chain=
_key+0x1e6/0x2e0
>>> 	Sep  1 04:48:49 regress kernel: [10642.595929][T24161]  ? sched_clock=
_cpu+0x1b/0x120
>>> 	Sep  1 04:48:49 regress kernel: [10642.596712][T24161]  do_vfs_ioctl+=
0x13e/0xad0
>>> 	Sep  1 04:48:49 regress kernel: [10642.597432][T24161]  ? btrfs_ioctl=
_get_supported_features+0x30/0x30
>>> 	Sep  1 04:48:49 regress kernel: [10642.598455][T24161]  ? do_vfs_ioct=
l+0x13e/0xad0
>>> 	Sep  1 04:48:49 regress kernel: [10642.599202][T24161]  ? compat_ioct=
l_preallocate+0x170/0x170
>>> 	Sep  1 04:48:49 regress kernel: [10642.600128][T24161]  ? __kasan_che=
ck_write+0x14/0x20
>>> 	Sep  1 04:48:49 regress kernel: [10642.600949][T24161]  ? up_read+0x1=
76/0x4f0
>>> 	Sep  1 04:48:49 regress kernel: [10642.601648][T24161]  ? down_write_=
nested+0x2d0/0x2d0
>>> 	Sep  1 04:48:49 regress kernel: [10642.602476][T24161]  ? handle_mm_f=
ault+0x211/0x480
>>> 	Sep  1 04:48:49 regress kernel: [10642.603263][T24161]  ? __kasan_che=
ck_read+0x11/0x20
>>> 	Sep  1 04:48:49 regress kernel: [10642.604062][T24161]  ? __fget_ligh=
t+0xb2/0x110
>>> 	Sep  1 04:48:49 regress kernel: [10642.604805][T24161]  ksys_ioctl+0x=
67/0x90
>>> 	Sep  1 04:48:49 regress kernel: [10642.605471][T24161]  __x64_sys_ioc=
tl+0x43/0x50
>>> 	Sep  1 04:48:49 regress kernel: [10642.606203][T24161]  do_syscall_64=
+0x77/0x2d0
>>> 	Sep  1 04:48:49 regress kernel: [10642.606933][T24161]  entry_SYSCALL=
_64_after_hwframe+0x49/0xbe
>>> 	Sep  1 04:48:49 regress kernel: [10642.607875][T24161] RIP: 0033:0x7f=
03f493b427
>>> 	Sep  1 04:48:49 regress kernel: [10642.608588][T24161] Code: 00 00 90=
 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0=
f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 4=
8 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
>>> 	Sep  1 04:48:49 regress kernel: [10642.611697][T24161] RSP: 002b:0000=
7ffd6bd78fb8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
>>> 	Sep  1 04:48:49 regress kernel: [10642.613035][T24161] RAX: fffffffff=
fffffda RBX: 00007ffd6bd79058 RCX: 00007f03f493b427
>>> 	Sep  1 04:48:49 regress kernel: [10642.614313][T24161] RDX: 00007ffd6=
bd79058 RSI: 00000000c4009420 RDI: 0000000000000003
>>> 	Sep  1 04:48:49 regress kernel: [10642.615605][T24161] RBP: 000000000=
0000003 R08: 0000000000000003 R09: 0000000000000078
>>> 	Sep  1 04:48:49 regress kernel: [10642.616877][T24161] R10: fffffffff=
ffff5ab R11: 0000000000000206 R12: 0000000000000001
>>> 	Sep  1 04:48:49 regress kernel: [10642.618132][T24161] R13: 000000000=
0000000 R14: 00007ffd6bd7aa46 R15: 0000000000000001
>>> 	Sep  1 04:48:49 regress kernel: [10642.619378][T24161] Modules linked=
 in:
>>> 	Sep  1 04:48:49 regress kernel: [10642.620153][T24161] ---[ end trace=
 a33c17a7d43dd973 ]---
>>>
