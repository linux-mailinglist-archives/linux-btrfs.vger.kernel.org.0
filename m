Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE4A7D7825
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Oct 2023 00:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjJYWmM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Oct 2023 18:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJYWmL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Oct 2023 18:42:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14D4D8
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Oct 2023 15:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1698273725; x=1698878525; i=quwenruo.btrfs@gmx.com;
        bh=7ovsyzf+bCqavbj18EyurFIbLL5piMa75XrQwbr4fiw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=Wfl9+y5ToRZM1SAN7ofklFON9UZW+PmXA4mh3d7C6aDwCt42XpzkOHJVb6R3bIJz
         cvvoYBHbx2ie664d1paLp6SnOUPEgUKwcruOT+QLt+4wtAto7UuZyMvgPLW4fNhPm
         r8D7nkYR2sGtexQJfwxWg9sHYeBBWXJanYcweUD5WKdFG5tHgKB7J2CTjlXF86wo+
         fSoY0k9DXwNjGMAJagXTh7CoQ7QRGoXij8E8lrLCPM3+/YLLfvpcOtQ1SiiatbWyB
         gbRn2+BaFUGgGmzlC/a6ql3ZX/RTmaUtXT13V64Zyk7vQTjRxBgboO0YQQYek5oJu
         HbKiG+nj+ZuyyY3ztw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MsYqv-1rkZsN2HIx-00tzKp; Thu, 26
 Oct 2023 00:42:05 +0200
Message-ID: <cd6955d5-a4d4-4f4e-b3c5-c02bb3c9583e@gmx.com>
Date:   Thu, 26 Oct 2023 09:11:58 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] btrfs-progs: use a unified btrfs_make_subvol()
 implementation
To:     dsterba@suse.cz
Cc:     Qu Wenruo <wqu@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1697430866.git.wqu@suse.com>
 <7b951f3a0619880f35f2490e2e251eb35e2f2292.1697430866.git.wqu@suse.com>
 <20231017134929.GA2350212@perftesting>
 <3df53251-41f6-4655-a0fe-a7baecb2a66d@gmx.com>
 <20231017231128.GA26353@twin.jikos.cz>
 <fd864ecf-5887-4b3f-94be-352b87fe29df@suse.com>
 <20231024173806.GR26353@suse.cz>
 <136e8bf5-3b77-4e66-be24-54cd7e14b83a@gmx.com>
 <20231025161832.GA21328@suse.cz>
Content-Language: en-US
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
In-Reply-To: <20231025161832.GA21328@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7SSrbpOKLlCTzB850pCTRr2/KWIPg6SaJhNiJjnBoszQqlAmeQt
 tDk30hwyQi81q9wydE/qcPJT3oU6dYH+4htlVbW4wTbYDign/o9uCfxX08zVllNYln3jnsT
 mBa/V7z5Ps5eJhipOmiBUiRm8wJvaGVVVfI4q9Y23XgfNDH8+UqCdsGxfxIBhTbsf1whggR
 cczHHELm5F0IEhNl2hxIg==
UI-OutboundReport: notjunk:1;M01:P0:fiO2eveCmPk=;BvXKYxVTsi2gXbsGObCDyyK2hYk
 B5eUR2Nxn/PXlNx288vB+xJf4hLwSB/7l2BMx+koVpwDeJTMZII3bNE6hTkiGgNcOoG0ty+tU
 +IB+TH6q1D+Ita4nZEIfYkrehd5sqGQLSJpO4U4AtaoilaNi/XbFjXNKfBy03BrDVg0dFYj4K
 FQawB65Tb0M85AsXZC16p/zJY6wM9WUXWIRkKuh54pk1eiTZQu62T0wyVA3o4V1iWcoF7VXwp
 QFMBdCE+LyV2U41zToYNK/EFRdAdD0F9VDDHb2GWwcjJCGzUQ/SjfbE0RMhEhxXIjfpAZcST5
 cpBSsnDZjZr5oZAoL43BBffuYoC/irCxAMMBvivvTBPAdF8Hn8UQ1LkIOSnGWyPEIF5m2fioL
 2wl3SQ4WTPsImfPqZ/Kuz0dTszXjwqgBZ0/0j/lfZnpOkPA/QtVNpGgV0C6ohML7mYmCBVIt4
 Ex9fCqKqhGKp7W/B7sQibd6llplFRPF7XaFwb7Ao8eHK6wIS/PFUeuLraNrmYbIQeawo2VH10
 8AQFYtBhN+/JgV49Z2MHhHxEGBvUvzVFJUkSxb9zSZemq8Wbv8fQDy/LAeLwa7NuqDLtUs4rW
 fWYWgmU0v6kLLrB55rurQsv2gmEx0fVa73ykSv9UqUis6cKWBYLw7+EmenAcUM0LGXxAPK58n
 OEdSe7jn2eMPZjhugqzBkOc0fI05pujie6oNjwDIZ8egg1mYhMTffLcITiHMzXyIJcW0lH9py
 vEfaApFdqLh6ccRjus2qfk2yNG44UQLEO76pIsnjb/hqD3XejSv7UPLrruz2SUlKM35C+sXi7
 tSyGLYU0qJwb2MTq0d3+0yT/7aiIcegV9sBxSUvaQjmNJmL30hUGMlSOWc6fIGqWjtnLuwyf4
 9Gl8uYpc7gA1y4CMuLa/otSvN/BoWKueD/1/y7Y3+fWrpJDmKEosW63GWf7g+VvV/GR495ugD
 cp4rkZFXI4FWeglN7Zax9zrbth8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/26 02:48, David Sterba wrote:
> On Wed, Oct 25, 2023 at 07:14:58AM +1030, Qu Wenruo wrote:
>>
>>
>> On 2023/10/25 04:08, David Sterba wrote:
>>> On Wed, Oct 18, 2023 at 10:20:57AM +1030, Qu Wenruo wrote:
>>>>>>> We're moving towards a world where kernel-shared will be an exact-=
ish copy of
>>>>>>> the kernel code.  Please put helpers like this in common/, I did t=
his for
>>>>>>> several of the extent tree related helpers we need for fsck, this =
is a good fit
>>>>>>> for that.  Thanks,
>>>>>>
>>>>>> Sure, and this also reminds me to copy whatever we can from kernel.
>>>>>
>>>>> I do syncs from kernel before a release but all the low hanging frui=
t is
>>>>> probably gone so it needs targeted updates.
>>>>
>>>> For the immediate target it's btrfs_inode and involved VFS structures
>>>> for inodes/dir entries.
>>>>
>>>> In progs we don't have a structure to locate a unique inode (need bot=
h
>>>> rootid and ino number), nor to do any path resolution.
>>>>
>>>> This makes it almost impossible to proper sync the code.
>>>>
>>>> But introduce btrfs_inode to btrfs-progs would also be a little
>>>> overkilled, as we don't have that many users.
>>>> (Only the new --rootdir with --subvol combination).
>>>
>>> I have an idea for using this functionality, but you may not like it -
>>> we could implement FUSE.
>>
>> In fact I really like it.
>>
>>> The missing code is exactly about inodes, path
>>> resolution and subvolumes. You have the other project, with a differen=
t
>>> license, although there's a lot shared code. You can keep it so u-boot
>>> can do the sync and keep the read-only support. I'd like to have full
>>> read-write support with subvolumes and devices (if there's ioctl pass
>>> through), but it's not urgent. Having the basic inode/path support wou=
ld
>>> be good for mkfs even in a smaller scope.
>>
>> The existing blockage would be fsck.
>> If we want FUSE, inode is super handy, but for fsck doing super low
>> level fixes, it can be a burden instead.
>> As it needs to repair INODE_REF/DIR_INDEX/DIR_ITEMs, sometimes even
>> missing INODE_ITEMs, not sure how hard it would be to maintain both
>> btrfs_inode and low-level code.
>
> I'd have to look what exactly are the problems but yes check is special
> in many ways. It could be possible to have an "enhanced" inode used in
> check and regular inode everywhere else.
>
>> There are one big limiting factor in FUSE, we can not control the devic=
e
>> number, unlike kernel.
>> This means even we implemented the subvolume code (like my btrfs-fuse
>> project), there is no way to detect subvolume boundary.
>
> This could be a problem. We can set the inode number to 256 but
> comparing two random files if they're in the same subvolume would
> require traversing the whole path. This would not work with 'find -xdev'
> and similar.
>
>> Then comes with some other super personal concerns:
>>
>> - Can we go Rust instead of C?
>
> I know rust on the very beginner level, and I don't think we have enough
> rust knowledge in the developers group.  The language syntax or features
> are still evolving, we'd lose the build support on any older distros or
> distros that don't keep up with the versions. The C-rust
> interoperability is good but it can become a burden. I'm peeking to the
> kernel rust support from time to time and I can't comprehend what it's
> doing.
>
>> - Can we have a less restrict license to maximize the possibility of
>>     code share?
>
> The way it's now it's next to impossible. Sharing GPL code works among
> GPL projects, anything else must be written from scratch. I don't know
> how much you did that in the btrfs-fuse project

It's manageable for a read-only project to start from scratch, at least
for the implementation part.
(It takes me around 2 weeks for the main part of the code)

However I intentionally keep a lot of function names (especially for
accessors.[ch]) the same, while only re-implement the code.

But I guess it's never possible for btrfs-progs due to the amount of
contributors.

That's also why I'd try to explore rust, as in that case we need to
re-implement everything anyway.

Thanks,
Qu
>
>>     Well, I should ask this question to GRUB....
>>     But a more hand-free license like MIT may really help for bootloade=
rs.
>
> You can keep your btrfs-fuse to be the code base with loose license for
> bootloaders, but you can't copy any code.
