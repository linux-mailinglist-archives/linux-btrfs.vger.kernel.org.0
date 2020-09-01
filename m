Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0101D25A1F4
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 01:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIAXdh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 19:33:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:49243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgIAXdf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Sep 2020 19:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599003206;
        bh=ZWnngAA4O34NsTTSrrGdByNjvWEoTpDQBVEWUJnMgao=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Khth0W7zCwLA68g/1ELNVNm/1YE0yEtOQzMNqVbjZx5jm2AnPvXU2+fx8Bwt8G9Dq
         CzJ4J5gC+XI9BtGy5d4+misfkdAlWb9ZSl1xOXd1g8WxIiHj9YwWRBSodVWUJzYPuT
         sn0UgobNnkADNWsc5Bk6fFDo4lSlun2mG0A1X790=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3siA-1kdTqH21OS-00zk23; Wed, 02
 Sep 2020 01:33:26 +0200
Subject: Re: BUG at fs/btrfs/relocation.c:794! Still happening on misc-next
 and 5.8.3
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        wqu@suse.com
References: <20200630221006.17585-1-dsterba@suse.com>
 <20200723215641.GE5890@hungrycats.org>
 <bfecfacd-2d9d-386d-dfb7-951a5c5c6f6e@gmx.com>
 <20200804161626.GN5890@hungrycats.org> <20200828000313.GS5890@hungrycats.org>
 <20200828000822.GT5890@hungrycats.org>
 <720f3ac7-6af5-e171-5947-ed0240d5f5e5@suse.com>
 <20200828204255.GV5890@hungrycats.org> <20200901225341.GY5890@hungrycats.org>
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
Message-ID: <45343d53-7dc0-1a7b-6da5-6461b653cde0@gmx.com>
Date:   Wed, 2 Sep 2020 07:33:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901225341.GY5890@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L00B6/L3WrhQJEgQ7eAUn5xMrCbvXs0uH6Xk+l417fzWeM0dXVR
 rC1OsnNOfEqirmFJ5L3HFHZS6Vu0eSeifJfOqWagCrzkUs/xyrL8vEsNrWPdYxNB1IQHs3L
 SQ3unuRjuERnzwtUTqUiXVag6FL+hf/w7iOa7yjwnDW63GbHfjCeA+VY34MF3eXlgAzFXOs
 0gs7alx/xnu5NRCNW1R+A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Bl1wgjeKbA=:UGuKpmv8KnH45oatWq4XRo
 p9fg4kqDLerIwfP2eBN2zq5JFhwG1JOWG+FONb80DgtcoXAZ07MbuViLcjx7P7whmtnOkNe9C
 DJKiSyTouxRyfgvOfe1GB1+EQGLLuTf2JLcpYJsMLlAzhSu+JSCSeDRA/9/qz/M03YZg8gklx
 yC7oAmS/fLiU74DLRsknp7/oFc8z9RKul2V58YZFdzpGRrhXo7sAWGalXgrhYW/lvaC2KQTzU
 uTSwI1fP2X+YTcEiGp6iEMEY2qV53EkqaaYPtoCqplzxT2EAcxpPGkMZKoq6u5Becm9QX9CY1
 TgkG95R57FJiWcBrUcxybDxehv4hF+lXQMn9ZXGt++k+7VY9bokVps6CFnPYyFh9iFGd2RJC4
 mgenpP3fcOSivpr/mWpm+d/3ZJM6R94RP9t5nrdjpKQ9+BLYpxWTdfdyWfptQ5lpF27gFgWH2
 NL6wqg77BxvPqKTqqJkaZTpjNGSifl57xSZeyQPNQgisPSm97c8BOFrrI7iyJiHXEO0suRgsn
 N4Y2vLdH0pozVbuvAbaMF3/YmTjlSAgpn4vTHK1vqagcIUa1ngTTQYOsU+EgIW7ZOzimBNwq6
 sjuGj8ELwq4fCA2GA1+vNC3b76UxDUtauA/57RbkpLVVECAJc5kvLNj/u+Pt1kmNEu8evSkxW
 +JP6t+C/FHSeUQLPUaNkThnjwKgbArICVpwrF4RNfCbqDvvB2aueTloO7qpKY4lYJQ55lROPJ
 6LGOu5HtF7uZURGjN25UA7li2penAkFsojw9x7cHXS+jGN0Xcmg9zZqiwqJ80KvmNzlW8/4bN
 AJUl8DMdSoajDlhUXLMQuGPdyUSNAgtAQ040NVki4koZL+ckOdRJh0pkqGFYUoloxjqMgBAkS
 K8F2VkuvV+sY8HBk+Oj8nRjds0zTvRBxCr5+keY8vUO9DbC8nhCK6VrPNoGZhb01klU+j+0sG
 BmGY3XjBQHTnO2I8Qqja9QyfLhHgO3DvA0CQd36/0Tw9KaOeO8mwdrciAHnAe1Klehp/Z8jUq
 1Wua3RRBuQSOqZMZXjwp6adT2qCUeYFI92LRJfH0msqqGVggo9fA5FG6haqWdbdCk1wBCSG3E
 7iJODFly7eBpRcP9PPyYWx4KUWPHUTLc1/DjTm5KpF7k01wtQwtpG7cVDlcHzz0MF6Qv23eok
 8ze/8nR1p/kajCMkLTDim+0WuEN90Ltgdrm3BCJxdNJDAtbHsF1WouMgwaIBTmjcO+FxkFXhY
 ZlKaE+FLNOgu+LGi7VLkZt4fmu+LY/3ns4bVpQw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This looks like a race between some reloc tree creation from some other
part.

If you could add debug output for create_reloc_root() and its callers,
we may have a chance to debug it.

But for the first step, we can hunt down the BUG_ON()s first and make it
exist more gracefully.

I'll try to spare some time to do this in the following week.

Thanks,
Qu

On 2020/9/2 =E4=B8=8A=E5=8D=886:53, Zygo Blaxell wrote:
> On Fri, Aug 28, 2020 at 04:42:55PM -0400, Zygo Blaxell wrote:
>> On Fri, Aug 28, 2020 at 09:34:31AM +0300, Nikolay Borisov wrote:
>>> On 28.08.20 =D0=B3. 3:08 =D1=87., Zygo Blaxell wrote:
>>>> On Thu, Aug 27, 2020 at 08:03:13PM -0400, Zygo Blaxell wrote:
>>>>> On Tue, Aug 04, 2020 at 12:16:26PM -0400, Zygo Blaxell wrote:
>>>
>>> <snip>
>>>
>>> Since you can repro reliably could you modify the code in
>>> create_reloc_root so it prints what's the returned error value, I'd
>>> speculate it's EEXIST from
>>>
>>> btrfs_insert_root
>>>   btrfs_insert_item
>>>    btrfs_insert_empty_item
>>>      btrfs_insert_empty_items
>>>        btrfs_search_slot
>>>
>>> But better be sure.
>>
>> Here you go, EEXIST =3D=3D 17:
>>
>> 	Aug 28 15:30:55 regress kernel: [18452.845182][T31546] BTRFS info (dev=
ice dm-0): balance: start -dlimit=3D9
>> 	Aug 28 15:30:55 regress kernel: [18452.874627][T31546] BTRFS info (dev=
ice dm-0): relocating block group 15873413742592 flags data
>> 	Aug 28 15:30:55 regress kernel: [18453.097516][ T2100] btrfs_search_sl=
ot ret =3D 0
>> 	Aug 28 15:30:55 regress kernel: [18453.104865][ T2100] btrfs_search_sl=
ot ret =3D 0
>> 	Aug 28 15:30:55 regress kernel: [18453.109751][ T2100] btrfs_search_sl=
ot ret =3D 0
>> 	Aug 28 15:30:56 regress kernel: [18454.453135][ T2100] btrfs_search_sl=
ot ret =3D 0
>> 	Aug 28 15:30:56 regress kernel: [18454.453955][ T2100] btrfs_insert_em=
pty_item ret =3D -17
>> 	Aug 28 15:30:56 regress kernel: [18454.455022][ T2100] btrfs_insert_ro=
ot ret =3D -17
>> 	Aug 28 15:30:56 regress kernel: [18454.456229][ T2100] ------------[ c=
ut here ]------------
>> 	Aug 28 15:30:56 regress kernel: [18454.457622][ T2100] kernel BUG at f=
s/btrfs/relocation.c:795!
>
> I did a low-resolution bisect for this issue.  I dug up 5.4, 5.5, 5.6,
> and 5.7 kernel sources, backported btrfs fixes from 5.4 to the obsolete
> kernels, and ran the tests on each kernel.  Results:
>
> 	5.8:  kernel BUG at fs/btrfs/relocation.c:794
>
> 	5.7:  kernel BUG (same code but different line number)
>
> 	5.6:  kernel BUG (same as the others)
>
> 	5.5:  assertion failure (stack trace below)
>
> 	5.4:  kernel BUG (!)
>
> The 5.4 result is interesting--I've been running 5.4 for some time and
> not hit this before.  So there are 3 possible theories:
>
> 	1.  It's because of sending signals to balance.  That has been
> 	added to my test workload after 5.7 was released, so earlier
> 	tests on 5.4 would not have triggered it.
>
> 	2.  There's a regression in 5.4-stable, which I've cherry-picked
> 	to all the other kernels during my test setup.	(On the other
> 	hand, if I don't backport some fixes, kernels 5.5..5.7 crash
> 	before they get to this bug.)
>
> 	3.  There's something rotten in my test filesystem, and the
> 	BUG will go away for a while if I do a mkfs.  Qu asked for
> 	a dump earlier in this thread, and I provided one.
>
> All three of these theories are testable to some extent, so I'll have
> my test VM run some variations.
>
> The full test workload is:
>
> 	balance metadata or data at random intervals
>
> 	scrub, scrub cancel at random intervals
>
> 	20x rsync updating files
>
> 	snapshot create, delete at random intervals
>
> 	bees dedupe (lots of EXTENT_SAME and LOGICAL_INO calls)
>
> 	balance cancel at random intervals
>
> 	kill -9 $(pidof btrfs balance) at random intervals (NEW - added
> 	when 5.7 came out)
>
> This is the 5.5 root assertion failure:
>
> 	Sep  1 04:48:48 regress kernel: [10642.537825][T24161] assertion failed=
: root, in fs/btrfs/relocation.c:837
> 	Sep  1 04:48:48 regress kernel: [10642.538911][T24161] ------------[ cu=
t here ]------------
> 	Sep  1 04:48:48 regress kernel: [10642.539704][T24161] kernel BUG at fs=
/btrfs/ctree.h:3125!
> 	Sep  1 04:48:48 regress kernel: [10642.540621][T24161] invalid opcode: =
0000 [#1] SMP KASAN PTI
> 	Sep  1 04:48:48 regress kernel: [10642.540624][ T4639] irq event stamp:=
 49626809
> 	Sep  1 04:48:48 regress kernel: [10642.540632][ T4639] hardirqs last  e=
nabled at (49626809): [<ffffffff8a00481a>] trace_hardirqs_on_thunk+0x1a/0x=
1c
> 	Sep  1 04:48:48 regress kernel: [10642.541451][T24161] CPU: 1 PID: 2416=
1 Comm: btrfs Tainted: G        W         5.5.19-76348822ab91+ #14
> 	Sep  1 04:48:48 regress kernel: [10642.542114][ T4639] hardirqs last di=
sabled at (49626808): [<ffffffff8a004836>] trace_hardirqs_off_thunk+0x1a/0=
x1c
> 	Sep  1 04:48:48 regress kernel: [10642.543693][T24161] Hardware name: Q=
EMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> 	Sep  1 04:48:48 regress kernel: [10642.545017][ T4639] softirqs last  e=
nabled at (49626726): [<ffffffff8bc0048b>] __do_softirq+0x48b/0x5be
> 	Sep  1 04:48:48 regress kernel: [10642.545023][ T4639] softirqs last di=
sabled at (49626715): [<ffffffff8a1258a2>] irq_exit+0x112/0x120
> 	Sep  1 04:48:48 regress kernel: [10642.546536][T24161] RIP: 0010:assert=
fail.constprop.42+0x1c/0x1e
> 	Sep  1 04:48:49 regress kernel: [10642.551589][T24161] Code: 48 c7 c6 c=
0 90 03 8c e8 89 29 f1 ff 0f 0b 55 89 f1 48 c7 c2 40 82 03 8c 48 89 fe 48 =
c7 c7 60 83 03 8c 48 89 e5 e8 41 b0 90 ff <0f> 0b 0f 1f 44 00 00 55 48 89 =
e5 41 54 49 89 f4 53 48 89 fb 48 83
> 	Sep  1 04:48:49 regress kernel: [10642.554495][T24161] RSP: 0018:ffffc9=
0002327150 EFLAGS: 00010282
> 	Sep  1 04:48:49 regress kernel: [10642.555371][T24161] RAX: 00000000000=
00034 RBX: 000004513701c000 RCX: ffffffff8a264242
> 	Sep  1 04:48:49 regress kernel: [10642.556515][T24161] RDX: 00000000000=
00000 RSI: 0000000000000008 RDI: ffff8881f580004c
> 	Sep  1 04:48:49 regress kernel: [10642.557680][T24161] RBP: ffffc900023=
27150 R08: ffffed103eb017e1 R09: ffffed103eb017e1
> 	Sep  1 04:48:49 regress kernel: [10642.558895][T24161] R10: ffffed103eb=
017e0 R11: ffff8881f580bf07 R12: ffff88800d1ea5c0
> 	Sep  1 04:48:49 regress kernel: [10642.560139][T24161] R13: ffffc900023=
273e0 R14: 0000000000000000 R15: ffff8880bbf238f0
> 	Sep  1 04:48:49 regress kernel: [10642.561391][T24161] FS:  00007f03f48=
488c0(0000) GS:ffff8881f5600000(0000) knlGS:0000000000000000
> 	Sep  1 04:48:49 regress kernel: [10642.562779][T24161] CS:  0010 DS: 00=
00 ES: 0000 CR0: 0000000080050033
> 	Sep  1 04:48:49 regress kernel: [10642.563801][T24161] CR2: 00007f1cab7=
6f718 CR3: 0000000189a5e004 CR4: 00000000001606e0
> 	Sep  1 04:48:49 regress kernel: [10642.565046][T24161] Call Trace:
> 	Sep  1 04:48:49 regress kernel: [10642.565565][T24161]  build_backref_t=
ree+0x186b/0x2590
> 	Sep  1 04:48:49 regress kernel: [10642.566389][T24161]  ? relocate_data=
_extent+0x1a0/0x1a0
> 	Sep  1 04:48:49 regress kernel: [10642.567295][T24161]  ? lock_downgrad=
e+0x3d0/0x3d0
> 	Sep  1 04:48:49 regress kernel: [10642.568142][T24161]  ? match_held_lo=
ck+0x20/0x260
> 	Sep  1 04:48:49 regress kernel: [10642.568925][T24161]  ? do_raw_spin_u=
nlock+0xa8/0x140
> 	Sep  1 04:48:49 regress kernel: [10642.569765][T24161]  ? _raw_spin_try=
lock_bh+0x60/0x80
> 	Sep  1 04:48:49 regress kernel: [10642.570605][T24161]  ? release_exten=
t_buffer+0x13b/0x230
> 	Sep  1 04:48:49 regress kernel: [10642.571480][T24161]  ? free_extent_b=
uffer.part.45+0xd7/0x140
> 	Sep  1 04:48:49 regress kernel: [10642.572406][T24161]  relocate_tree_b=
locks+0x204/0xa50
> 	Sep  1 04:48:49 regress kernel: [10642.573244][T24161]  ? build_backref=
_tree+0x2590/0x2590
> 	Sep  1 04:48:49 regress kernel: [10642.574103][T24161]  ? rb_insert_col=
or+0x3af/0x400
> 	Sep  1 04:48:49 regress kernel: [10642.574896][T24161]  ? kmem_cache_al=
loc_trace+0x5af/0x740
> 	Sep  1 04:48:49 regress kernel: [10642.575785][T24161]  ? tree_insert+0=
x90/0xb0
> 	Sep  1 04:48:49 regress kernel: [10642.576495][T24161]  ? add_tree_bloc=
k.isra.38+0x1d6/0x230
> 	Sep  1 04:48:49 regress kernel: [10642.577387][T24161]  relocate_block_=
group+0x528/0x9d0
> 	Sep  1 04:48:49 regress kernel: [10642.578220][T24161]  ? merge_reloc_r=
oots+0x470/0x470
> 	Sep  1 04:48:49 regress kernel: [10642.579047][T24161]  btrfs_relocate_=
block_group+0x26e/0x4c0
> 	Sep  1 04:48:49 regress kernel: [10642.579968][T24161]  btrfs_relocate_=
chunk+0x52/0xf0
> 	Sep  1 04:48:49 regress kernel: [10642.580773][T24161]  btrfs_balance+0=
xe5b/0x1800
> 	Sep  1 04:48:49 regress kernel: [10642.581542][T24161]  ? btrfs_relocat=
e_chunk+0xf0/0xf0
> 	Sep  1 04:48:49 regress kernel: [10642.582381][T24161]  ? kmem_cache_al=
loc_trace+0x5af/0x740
> 	Sep  1 04:48:49 regress kernel: [10642.583270][T24161]  ? _copy_from_us=
er+0xaa/0xd0
> 	Sep  1 04:48:49 regress kernel: [10642.584022][T24161]  btrfs_ioctl_bal=
ance+0x3de/0x4c0
> 	Sep  1 04:48:49 regress kernel: [10642.584819][T24161]  btrfs_ioctl+0x3=
122/0x4470
> 	Sep  1 04:48:49 regress kernel: [10642.585540][T24161]  ? __asan_loadN+=
0xf/0x20
> 	Sep  1 04:48:49 regress kernel: [10642.586229][T24161]  ? __asan_loadN+=
0xf/0x20
> 	Sep  1 04:48:49 regress kernel: [10642.586920][T24161]  ? btrfs_ioctl_g=
et_supported_features+0x30/0x30
> 	Sep  1 04:48:49 regress kernel: [10642.587935][T24161]  ? __asan_loadN+=
0xf/0x20
> 	Sep  1 04:48:49 regress kernel: [10642.588649][T24161]  ? pvclock_clock=
source_read+0xeb/0x190
> 	Sep  1 04:48:49 regress kernel: [10642.589566][T24161]  ? __asan_loadN+=
0xf/0x20
> 	Sep  1 04:48:49 regress kernel: [10642.590254][T24161]  ? pvclock_clock=
source_read+0xeb/0x190
> 	Sep  1 04:48:49 regress kernel: [10642.591128][T24161]  ? __kasan_check=
_read+0x11/0x20
> 	Sep  1 04:48:49 regress kernel: [10642.591913][T24161]  ? check_chain_k=
ey+0x1e6/0x2e0
> 	Sep  1 04:48:49 regress kernel: [10642.592707][T24161]  ? __asan_loadN+=
0xf/0x20
> 	Sep  1 04:48:49 regress kernel: [10642.593409][T24161]  ? pvclock_clock=
source_read+0xeb/0x190
> 	Sep  1 04:48:49 regress kernel: [10642.594312][T24161]  ? kvm_sched_clo=
ck_read+0x18/0x30
> 	Sep  1 04:48:49 regress kernel: [10642.595139][T24161]  ? check_chain_k=
ey+0x1e6/0x2e0
> 	Sep  1 04:48:49 regress kernel: [10642.595929][T24161]  ? sched_clock_c=
pu+0x1b/0x120
> 	Sep  1 04:48:49 regress kernel: [10642.596712][T24161]  do_vfs_ioctl+0x=
13e/0xad0
> 	Sep  1 04:48:49 regress kernel: [10642.597432][T24161]  ? btrfs_ioctl_g=
et_supported_features+0x30/0x30
> 	Sep  1 04:48:49 regress kernel: [10642.598455][T24161]  ? do_vfs_ioctl+=
0x13e/0xad0
> 	Sep  1 04:48:49 regress kernel: [10642.599202][T24161]  ? compat_ioctl_=
preallocate+0x170/0x170
> 	Sep  1 04:48:49 regress kernel: [10642.600128][T24161]  ? __kasan_check=
_write+0x14/0x20
> 	Sep  1 04:48:49 regress kernel: [10642.600949][T24161]  ? up_read+0x176=
/0x4f0
> 	Sep  1 04:48:49 regress kernel: [10642.601648][T24161]  ? down_write_ne=
sted+0x2d0/0x2d0
> 	Sep  1 04:48:49 regress kernel: [10642.602476][T24161]  ? handle_mm_fau=
lt+0x211/0x480
> 	Sep  1 04:48:49 regress kernel: [10642.603263][T24161]  ? __kasan_check=
_read+0x11/0x20
> 	Sep  1 04:48:49 regress kernel: [10642.604062][T24161]  ? __fget_light+=
0xb2/0x110
> 	Sep  1 04:48:49 regress kernel: [10642.604805][T24161]  ksys_ioctl+0x67=
/0x90
> 	Sep  1 04:48:49 regress kernel: [10642.605471][T24161]  __x64_sys_ioctl=
+0x43/0x50
> 	Sep  1 04:48:49 regress kernel: [10642.606203][T24161]  do_syscall_64+0=
x77/0x2d0
> 	Sep  1 04:48:49 regress kernel: [10642.606933][T24161]  entry_SYSCALL_6=
4_after_hwframe+0x49/0xbe
> 	Sep  1 04:48:49 regress kernel: [10642.607875][T24161] RIP: 0033:0x7f03=
f493b427
> 	Sep  1 04:48:49 regress kernel: [10642.608588][T24161] Code: 00 00 90 4=
8 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f =
1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 =
8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
> 	Sep  1 04:48:49 regress kernel: [10642.611697][T24161] RSP: 002b:00007f=
fd6bd78fb8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> 	Sep  1 04:48:49 regress kernel: [10642.613035][T24161] RAX: fffffffffff=
fffda RBX: 00007ffd6bd79058 RCX: 00007f03f493b427
> 	Sep  1 04:48:49 regress kernel: [10642.614313][T24161] RDX: 00007ffd6bd=
79058 RSI: 00000000c4009420 RDI: 0000000000000003
> 	Sep  1 04:48:49 regress kernel: [10642.615605][T24161] RBP: 00000000000=
00003 R08: 0000000000000003 R09: 0000000000000078
> 	Sep  1 04:48:49 regress kernel: [10642.616877][T24161] R10: fffffffffff=
ff5ab R11: 0000000000000206 R12: 0000000000000001
> 	Sep  1 04:48:49 regress kernel: [10642.618132][T24161] R13: 00000000000=
00000 R14: 00007ffd6bd7aa46 R15: 0000000000000001
> 	Sep  1 04:48:49 regress kernel: [10642.619378][T24161] Modules linked i=
n:
> 	Sep  1 04:48:49 regress kernel: [10642.620153][T24161] ---[ end trace a=
33c17a7d43dd973 ]---
>
