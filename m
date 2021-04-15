Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCFB361639
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 01:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbhDOX2j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 19:28:39 -0400
Received: from mout.gmx.net ([212.227.17.20]:42535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236754AbhDOX2h (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 19:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618529291;
        bh=2TZps0iVaPwZ4mxbzzk3zIXevQnkfKAE/0lpV+bwBs4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=MM1vIZX7KzjYBVikvQ0lwZQhpFR/t/250plUkYChINFoPxhNch6TljXKrY9/yALo+
         Ovsx/sSU7lLWCNFq2CoN3ZCkXL6bRTbRmnvryoD5A66xCBexNkkp8F9xKs0aTNXGt3
         5SKJaITM3b+xsoZ0mcJtITAf12Z8J4lv7Pok6X8s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSKy8-1l4Xg235MO-00Sdxs; Fri, 16
 Apr 2021 01:28:11 +0200
Subject: Re: [PATCH 04/42] btrfs: introduce submit_eb_subpage() to submit a
 subpage metadata page
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-5-wqu@suse.com>
 <475c3f1a-ffec-6a7a-1cb0-c7217c87367d@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <38f77eac-dd64-02dc-4130-105acba9e7a7@gmx.com>
Date:   Fri, 16 Apr 2021 07:28:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <475c3f1a-ffec-6a7a-1cb0-c7217c87367d@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PerHs6b9xtDOmemM/JvD5mB9AsGtDZdw5lmvBU7TXxgRwpHecht
 vofF+wY1zZ0mt7icqMILzbiUp1PqYUtTj3jOpkhtocbJ/a/KU5WAt7m85ANGlmVhR6kYbtH
 +Ug1mJCoM5YJ64eX4gjoGv1EQDyIF8Zay+4Dw6WK5kCsgwKDBfg9349mGQWrI6IJA+s7/v8
 98FgW+lI0Ga0uej1NuAjA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DtSl24EFRdo=:a3rbT7DQ3XdJv86yC68ArA
 0xBheI5VfDhEq/XOthdDnMYOyNnSR8TNdzQ0rojSZ2L2BDjpGcK66Up6P/JS5SVHFx4cAgrZI
 RTg6labuDftU8Q8EbXb4ry/XFuxIcntg9XicuOOLC4rXy8Thao9xp//gAyOv7polaPxTxiyGg
 oF9kiHCHRC6VpbyOrSlBE/yWjy3DblQyDV78IqYzC84c/A9daPrp+EQoWjiM22NXn55YPCWkc
 jzDTli1pYhGm+bI31xcirEGdP/XmvW4QfD3AAEhnCve5kPLDcaSUWgUCPgiSC6xQniEU4iKOg
 qfEg87Wv5nLtNMIRGdyVsHKxmrCMQN2fO9XDGYPzNg5yL2Yt7hmwD3V+PSG8GNiPhVvfgyqko
 +ZjrGxcgVy1VOa6nVDiC4t1iSHvodvT2YUog1Gdmn3i2+zoTwGk05FRmcYcDOSV2sw6s6cqaj
 ay43UOVwYrWOdVNeqs8aL0qv2fzqOA1GEAJhI8o6FjZk/GZU6SNRLzMYlblVXVHIb3f/YBio/
 vK5Ydf09c5O8WppBox9P8dI4b1hYjeZiIB/DwbAJR/1xYkl0TtYhOBUBlBWasUM2wQBvfrm1/
 aNMFTOUFcLucNzIpm8sBkmFgSLp5oGOkmqB33ThMf5RBr9SlvKacd8aaem/E12wSboVXoTUIp
 Mud77ilbc1Fta7CqXHM9y+NtxtC/u8p1leqLju8CAuhNIcmv4xidA8nYw9JW4V4J5tkr5ZO4S
 Z1FQaeYrk8PaW1l962oNasakSzmYUgKl3n2DBwQLxl3BXa65TRTm9RG0Zo1irCl2UG95YVP1+
 guNtPsFzM/FaNVqNSxaDTRZBZVpDwz8Zz0revOVZhVTDjJD2B7C8Bp+aBfHBxx8lEilSsxBLv
 nAClNLewUXlrI0B9GItLh6u964o6osipSneR0/DEphdQCuAim8m5FKxf43pWwZx+5bBMWPisV
 k4O0614RRKnYLne7khQyAvXaNlO7pgcDfU918hvXRNdn03ZdY/Gs4zko8+mjYIKaGPP+IxSqY
 e6FxZcgz49TRQ6qOa7mHvWDOBB/mHRtqKWN4rpk4RMgK5rFZPrvFtbwhHd2bBSLquDpma5khh
 iz3WO0pxK+vkZVZltn3/rLP5294APCYs4MbCW296mznnsretVES3hQvIJd4xxiLpyBXb6IcdP
 WpZzu/x1vbtxyXWr6u0GMmIVMei+0frJcfn2QLCC3zXSBIORImo1tYIF9QrEGOp7xtSemn9fl
 wRfZf4jTFeUSDT2vT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/16 =E4=B8=8A=E5=8D=883:27, Josef Bacik wrote:
> On 4/15/21 1:04 AM, Qu Wenruo wrote:
>> The new function, submit_eb_subpage(), will submit all the dirty extent
>> buffers in the page.
>>
>> The major difference between submit_eb_page() and submit_eb_subpage()
>> is:
>> - How to grab extent buffer
>> =C2=A0=C2=A0 Now we use find_extent_buffer_nospinlock() other than usin=
g
>> =C2=A0=C2=A0 page::private.
>>
>> All other different handling is already done in functions like
>> lock_extent_buffer_for_io() and write_one_eb().
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/extent_io.c | 95 ++++++++++++++++++++++++++++++++++++++=
++++++
>> =C2=A0 1 file changed, 95 insertions(+)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index c068c2fcba09..7d1fca9b87f0 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -4323,6 +4323,98 @@ static noinline_for_stack int
>> write_one_eb(struct extent_buffer *eb,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> +/*
>> + * Submit one subpage btree page.
>> + *
>> + * The main difference between submit_eb_page() is:
>> + * - Page locking
>> + *=C2=A0=C2=A0 For subpage, we don't rely on page locking at all.
>> + *
>> + * - Flush write bio
>> + *=C2=A0=C2=A0 We only flush bio if we may be unable to fit current ex=
tent
>> buffers into
>> + *=C2=A0=C2=A0 current bio.
>> + *
>> + * Return >=3D0 for the number of submitted extent buffers.
>> + * Return <0 for fatal error.
>> + */
>> +static int submit_eb_subpage(struct page *page,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct writeback_control *wbc,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_page_data *epd)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *fs_info =3D btrfs_sb(page->ma=
pping->host->i_sb);
>> +=C2=A0=C2=A0=C2=A0 int submitted =3D 0;
>> +=C2=A0=C2=A0=C2=A0 u64 page_start =3D page_offset(page);
>> +=C2=A0=C2=A0=C2=A0 int bit_start =3D 0;
>> +=C2=A0=C2=A0=C2=A0 int nbits =3D BTRFS_SUBPAGE_BITMAP_SIZE;
>> +=C2=A0=C2=A0=C2=A0 int sectors_per_node =3D fs_info->nodesize >>
>> fs_info->sectorsize_bits;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Lock and write each dirty extent buffers in the =
range */
>> +=C2=A0=C2=A0=C2=A0 while (bit_start < nbits) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_subpage *subpa=
ge =3D (struct btrfs_subpage
>> *)page->private;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_buffer *eb;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long flags;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 start;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Take private lock t=
o ensure the subpage won't be detached
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * halfway.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&page->mapping->p=
rivate_lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!PagePrivate(page)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi=
n_unlock(&page->mapping->private_lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&subpage-=
>lock, flags);
>
> writepages doesn't get called with irq context, so you can just do
> spin_lock_irq()/spin_unlock_irq().

But this spinlock is used in endio function.
If we don't use irqsave variant here, won't an endio interruption call
sneak in and screw up everything?

>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!((1 << bit_start) & su=
bpage->dirty_bitmap)) {
>
> Can we make this a helper so it's more clear what's going on here?=C2=A0=
 Thanks,

That makes sense.

Thanks,
Qu

>
> Josef
