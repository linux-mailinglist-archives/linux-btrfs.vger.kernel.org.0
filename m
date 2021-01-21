Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94E12FE1AD
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 06:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbhAUDrK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 22:47:10 -0500
Received: from mout.gmx.net ([212.227.17.22]:53129 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbhAUAx4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 19:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611190287;
        bh=y46RDmwOCEcz1KoFpMnOWtF6rMZ+0/FGww0Yx+uqpx8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=HyudRhD6QHYho1tuW3BezriRrCOYA2MlSIfDDSKEQ08FCECXD4AEY75DK12RZ4Fmp
         QNag3aWFfouc9zgUUHyEk5X8IAkSoS+Ixjwl2Fb/TCbEv+Kq9Mq0Y+6itCES4j4SXj
         TR91B11O7cr/tSkFcRbVI7RqdVjGp3ik/bK3Bi14=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Msq24-1lqmzG14Nk-00tAeq; Thu, 21
 Jan 2021 01:51:26 +0100
Subject: Re: [PATCH v4 12/18] btrfs: implement try_release_extent_buffer() for
 subpage metadata support
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-13-wqu@suse.com>
 <4732f7cb-8d1c-6af2-0ec4-9b9cf5a47c3e@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <e3f4f9d4-c521-83ec-b1cc-9064c90a658a@gmx.com>
Date:   Thu, 21 Jan 2021 08:51:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <4732f7cb-8d1c-6af2-0ec4-9b9cf5a47c3e@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1FF9TqztiSoiQx2OCXBqYxYy1MFpg6zzW9bqKDcF5jCt6YQBZFm
 vVTO9LsC99tYI6feQs+ehECgigjXYsbukHmW8RE02XXO8JOmp1wrNIx/q/YVkaIzaOjFNtQ
 Qpw3jDLIcg2VmnZxYYl3uzHPZkCc4yzB+YacJy7AhgYpTT3fkp3u7I+Z8QPBJXo/lJNLImj
 cxboK3I9AcufPmaFOEA1Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EZ82QZOtGYo=:sXDBLRGbLpcQONzYJjTuCO
 pAklZv+w9Qez8Vfnbg0GGfJlwAf00E7Ad47KNJZPpd8ZoWGIoVRT3YtFeXSGVErqN4ZTXPnJA
 CiaKDpKRk2aBBhJ6aagumZJ5BGEv6c+gXf9bS6c1QID1rqfabhCChwIt77fUXRlbQJDULxRFE
 oGOLw33IEgWvtiT3AGQCtS6u3gV9KWqLpJdm6a5qcSQFMXUDy3wjecONDt4ktuVH1hiK5+LUL
 eA+YryxHoPdcRnc2HpF+l5vUxrCNfyaUoPGvqF2JgKNjDBQtcyME8S5w/517oJPGmhUk60jT1
 qrlO6C9fEuo5j3TusT+Al1EZcNbU1APh2lo3l91xDNivIRjGRBbXqJq+euQ/QwbFAXya1dpaE
 gAjW3ejoemmdmOuK+9A6NFCiz2VTod+x0347k3H2Tr2JcL0qoVzhhak5LiFmEg2ch6OgrFRfv
 UaNAjErFMzH1oBppDDxA4edYRkEsfsGgfM1r9yqD71+jCxPtpNeOHkWaIs25dfdV2c3buSQ5B
 CrOgtnWw6ImABh39XfKTucTuVo+i3LN1uPhzVcfyUAZVB/jYIYVNBtphHSXaM7kV0FSrmv4vE
 4S/9428Z7rBwXsEeA807it/3ztlz10Z9cWqCEkGBGETGAXoGnwknU/wt9YHCVz9djp9VWxm1b
 oAS5RZjQcKCeOXdmTfmoeYrtF5hCpKE6u/C6DYOU5tXWfwRyVmSpcFUiHkRgW2DGyYW/Yry3u
 Fnq92KfgcGR+ODwgZRGq2bOcjJWecb58sQeZbOekaL89Hrx0GpvzFBD1mWsMbmlxhz6c1kknf
 o2umLRq3+Me+PXCaaeI2PkgXAELy+rWZAn+Ync1WD7j7iWQgb10rBrw4dbWX3GiJT90/xJwn1
 0XOxghGQPM0Aucg2DhHw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/20 =E4=B8=8B=E5=8D=8811:05, Josef Bacik wrote:
> On 1/16/21 2:15 AM, Qu Wenruo wrote:
>> Unlike the original try_release_extent_buffer(),
>> try_release_subpage_extent_buffer() will iterate through all the ebs in
>> the page, and try to release each eb.
>>
>> And only if the page and no private attached, which implies we have
>> released all ebs of the page, then we can release the full page.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/extent_io.c | 106 +++++++++++++++++++++++++++++++++++++=
+++++-
>> =C2=A0 1 file changed, 104 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 74a37eec921f..9414219fa28b 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -6335,13 +6335,115 @@ void memmove_extent_buffer(const struct
>> extent_buffer *dst,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> +static struct extent_buffer *get_next_extent_buffer(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *fs_in=
fo, struct page *page, u64 bytenr)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct extent_buffer *gang[BTRFS_SUBPAGE_BITMAP_SIZ=
E];
>> +=C2=A0=C2=A0=C2=A0 struct extent_buffer *found =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 u64 page_start =3D page_offset(page);
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +=C2=A0=C2=A0=C2=A0 int i;
>> +
>> +=C2=A0=C2=A0=C2=A0 ASSERT(in_range(bytenr, page_start, PAGE_SIZE));
>> +=C2=A0=C2=A0=C2=A0 ASSERT(PAGE_SIZE / fs_info->nodesize <=3D BTRFS_SUB=
PAGE_BITMAP_SIZE);
>> +=C2=A0=C2=A0=C2=A0 lockdep_assert_held(&fs_info->buffer_lock);
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D radix_tree_gang_lookup(&fs_info->buffer_rad=
ix, (void **)gang,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 byt=
enr >> fs_info->sectorsize_bits,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PAG=
E_SIZE / fs_info->nodesize);
>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ret; i++) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Already beyond page end =
*/
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gang[i]->start >=3D pag=
e_start + PAGE_SIZE)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Found one */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gang[i]->start >=3D byt=
enr) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fou=
nd =3D gang[i];
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 return found;
>> +}
>> +
>> +static int try_release_subpage_extent_buffer(struct page *page)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *fs_info =3D btrfs_sb(page->ma=
pping->host->i_sb);
>> +=C2=A0=C2=A0=C2=A0 u64 cur =3D page_offset(page);
>> +=C2=A0=C2=A0=C2=A0 const u64 end =3D page_offset(page) + PAGE_SIZE;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 while (cur < end) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_buffer *eb =
=3D NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Unlike try_release_=
extent_buffer() which uses page->private
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to grab buffer, for=
 subpage case we rely on radix tree, thus
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we need to ensure r=
adix tree consistency.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We also want an ato=
mic snapshot of the radix tree, thus go
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * spinlock other than=
 RCU.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&fs_info->buffer_=
lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb =3D get_next_extent_buff=
er(fs_info, page, cur);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!eb) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* =
No more eb in the page range after or at @cur */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi=
n_unlock(&fs_info->buffer_lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur =3D eb->start + eb->len=
;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The same as try_rel=
ease_extent_buffer(), to ensure the eb
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * won't disappear out=
 from under us.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&eb->refs_lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (atomic_read(&eb->refs) =
!=3D 1 || extent_buffer_under_io(eb)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi=
n_unlock(&eb->refs_lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi=
n_unlock(&fs_info->buffer_lock);
>
> Why continue at this point?=C2=A0 We know we can't drop this thing, brea=
k here.
>
> <snip>
>
>> +}
>> +
>> =C2=A0 int try_release_extent_buffer(struct page *page)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_buffer *eb;
>> +=C2=A0=C2=A0=C2=A0 if (btrfs_sb(page->mapping->host->i_sb)->sectorsize=
 < PAGE_SIZE)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return try_release_subpage_=
extent_buffer(page);
>
> You're using sectorsize again here.=C2=A0 I realize the problem is secto=
rsize
> !=3D PAGE_SIZE, but sectorsize !=3D nodesize all the time, so please cha=
nge
> all of the patches to check the actual relevant size for the
> data/metadata type.=C2=A0 Thanks,

Again, nodesize >=3D sectorsize is the requirement for current mkfs.

As sectorsize is the minimal unit for both data and metadata.
(We don't have separate data unit size and metadata unit size, they
share sector size for now).

Thanks,
Qu

>
> Josef
