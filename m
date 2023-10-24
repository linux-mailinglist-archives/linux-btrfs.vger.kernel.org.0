Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB287D5C91
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Oct 2023 22:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343883AbjJXUpJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Oct 2023 16:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjJXUpJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Oct 2023 16:45:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01C010CE
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Oct 2023 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1698180303; x=1698785103; i=quwenruo.btrfs@gmx.com;
        bh=UEQIc16FyKx6Hlqwf7OB+6FaDkMK8WsfrdIsMRN0gds=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=ZjqIxWy9AuymaMGEORc+xomrxLohr6pKdPz+SCCSgTbNwIZT6/p+0DvxyNs2NyJi
         /43KKyFwHdeOP5qzK6m2DVcXT4MqdLvZR++w+i8u320tyqB1cmLoMqcjngzAD3Kjv
         dAMvVjSnL0bqN7t9ZEXUudKDcUUq0M40I4aPLCTPGgFXGT0v4u4+yK0bm+fQWDh5z
         rY6xJuf+bmFNk4EKO2j6NJomSHxfWI6gCZsRgGYTPDviCGh6hR3CKV5ggf3Gp6FKD
         tIUw5jmdoSfHQcx9b+68aZU4+JUBMu4ON+5cLG7jPMwlCcoNx0AcNgU51735TeuiB
         IIJJqM2QZ2gK/qVnrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.10.18] ([218.215.59.251]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZTmO-1r1UPA3Iww-00WSQI; Tue, 24
 Oct 2023 22:45:03 +0200
Message-ID: <136e8bf5-3b77-4e66-be24-54cd7e14b83a@gmx.com>
Date:   Wed, 25 Oct 2023 07:14:58 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] btrfs-progs: use a unified btrfs_make_subvol()
 implementation
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <cover.1697430866.git.wqu@suse.com>
 <7b951f3a0619880f35f2490e2e251eb35e2f2292.1697430866.git.wqu@suse.com>
 <20231017134929.GA2350212@perftesting>
 <3df53251-41f6-4655-a0fe-a7baecb2a66d@gmx.com>
 <20231017231128.GA26353@twin.jikos.cz>
 <fd864ecf-5887-4b3f-94be-352b87fe29df@suse.com>
 <20231024173806.GR26353@suse.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20231024173806.GR26353@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J9oiSCcDpAdIRM82xtHJ7lACmA0F8bHnALIVURhW0kjcLMa/fuR
 mEzI8I6A/v4d2R+W4yP+vfTqR5o0vVApg+xR4/dq5qfIXfPENh+avE7XDmR1Alfn973xzyX
 CqtIBNxQgrpOq8gzQqq6xFF+CjcWpgwbyFe6NTIoyCrHWELPOMY8hhadNR4GAFKNIch0ayw
 Ly061AN/s1vlOMgwr0tIA==
UI-OutboundReport: notjunk:1;M01:P0:Demb8YgTrMc=;bZdYjaFyv0xetM0++crv/RQGLo7
 wKpx8jTynkUql8EPvWAfkUMKH81IPD+tae1BZGqu3iLYtzBazS75vBsVbjQFqfQCCZRelLaCw
 Hf0+FTldmlOVGEhQMxNvPM63rs/1q7ZnqxsbUzEG82/3RG/4e1nYGhrRPQ6VN8ETVJdbCahdX
 j+5qJp5LiOCN6EEG0S3LGjNe3JcBdmWC46rrLpc5G1vKMokLMhkiWYgOfDhuYkbdj2I4QExUD
 3t9Dun1CKOEQWwC59XwWpK2gnlUIJhmqLQ/RL1zK0ydXAvtfjJspMR4NcoEt/bWYXUssNLjg/
 7rzToahjgsPZ0EWkveRHTO2Ybr4alPdqUvt7b6O3Pn7T+ZKcB3NwLQ/fjpSsaNf0vZ4HjPuYS
 A2NLE25oang/rykA5bQPnzVHISfPt2O3k1pANFrh+n2DflJ4olmIEP/9JzizZIx2PmcU/pKST
 PxfEt6QQEGsdsb++upRlZlxgigZG5BXWBmTV773gznmfAlz4JLS6guWMPRuBA7lSHjH9N+FZZ
 rQCJiEfxLQYksoNdyZ41QX4o0UIyBfwu/sgaJdWCqIkof354RJ0Onx4yqEvm6+TRjcln1VN3d
 cxTYSPdE1QcMcMP/veTCl8jl6jKkqNVN9kCrGkBQU8IwzVyRN2Bf8cy8VwQ8h+bBcC7/epJu0
 A7LPyqFGlLptQ5GRRM4CtdRueuxB1Yrwcid4XdD/3IQgTkqN3N0ksxK+0b0IWo27kTrNEE1x3
 IHSVGW6yUS/BontEC6J2gLGbj4F1pPilcff2qNTVvarsVvEFAxUccuk1I3kQYO6EfIhpNOn46
 RgY1oFjRZXY87yVtOcIO0Jw5tC74qmOD/tDRetG6xWy75YX9w1caS9IaLlQbMVdC7Q5USmCri
 guvCvWiHU35K3IOrWJUwAWGcc//x0Ld1uF2mu9b67KOnkyUopI7qIM25pMcsTRpToBfIb3TzJ
 zjjIBQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/25 04:08, David Sterba wrote:
> On Wed, Oct 18, 2023 at 10:20:57AM +1030, Qu Wenruo wrote:
>>>>> We're moving towards a world where kernel-shared will be an exact-is=
h copy of
>>>>> the kernel code.  Please put helpers like this in common/, I did thi=
s for
>>>>> several of the extent tree related helpers we need for fsck, this is=
 a good fit
>>>>> for that.  Thanks,
>>>>
>>>> Sure, and this also reminds me to copy whatever we can from kernel.
>>>
>>> I do syncs from kernel before a release but all the low hanging fruit =
is
>>> probably gone so it needs targeted updates.
>>
>> For the immediate target it's btrfs_inode and involved VFS structures
>> for inodes/dir entries.
>>
>> In progs we don't have a structure to locate a unique inode (need both
>> rootid and ino number), nor to do any path resolution.
>>
>> This makes it almost impossible to proper sync the code.
>>
>> But introduce btrfs_inode to btrfs-progs would also be a little
>> overkilled, as we don't have that many users.
>> (Only the new --rootdir with --subvol combination).
>
> I have an idea for using this functionality, but you may not like it -
> we could implement FUSE.

In fact I really like it.

> The missing code is exactly about inodes, path
> resolution and subvolumes. You have the other project, with a different
> license, although there's a lot shared code. You can keep it so u-boot
> can do the sync and keep the read-only support. I'd like to have full
> read-write support with subvolumes and devices (if there's ioctl pass
> through), but it's not urgent. Having the basic inode/path support would
> be good for mkfs even in a smaller scope.

The existing blockage would be fsck.
If we want FUSE, inode is super handy, but for fsck doing super low
level fixes, it can be a burden instead.
As it needs to repair INODE_REF/DIR_INDEX/DIR_ITEMs, sometimes even
missing INODE_ITEMs, not sure how hard it would be to maintain both
btrfs_inode and low-level code.


There are one big limiting factor in FUSE, we can not control the device
number, unlike kernel.
This means even we implemented the subvolume code (like my btrfs-fuse
project), there is no way to detect subvolume boundary.


Then comes with some other super personal concerns:

- Can we go Rust instead of C?

- Can we have a less restrict license to maximize the possibility of
   code share?
   Well, I should ask this question to GRUB....
   But a more hand-free license like MIT may really help for bootloaders.

Thanks,
Qu
