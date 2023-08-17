Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A770B77F553
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 13:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350329AbjHQLcs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 07:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350275AbjHQLcV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 07:32:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326451AE
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 04:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1692271936; x=1692876736; i=quwenruo.btrfs@gmx.com;
 bh=r/xZN1DCGaEVg+WuwoC7eFlCJw7MglnhlWGn72+g9n8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=XyiX5LHA7qPNu5BuRZtDAeWBzWP0V7vzBb5XJurz9EKEskwb+1G/7QpkHiJdZ8UgJSjg+uQ
 11woR0sp0sipQowDnjNjpWiaJQpVM5Q8JTnQqhvYoXtCbgeb5HtK29MbGi0KUYqkDKmmY07rg
 lhYRgOroms9f1RhsqDDaKzXRa6VmM3VQm0G5bJJXiCuxIjgc2XQ2W/B55g8RZxtWRpbvBh1sf
 LOaKqX3hLKOWISJ9Djr/olfFp/mvYqbC/7pjjOebvCDtDTA8f4EuDP37XlGRbE7Ak/4D7LmSn
 1iehF2jXguoqfvqycd1DG7BJAG+WSJqF4W446/gRcajMP0IRpyhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEm6F-1qYaMG2EP5-00GGzM; Thu, 17
 Aug 2023 13:32:16 +0200
Message-ID: <547df338-dc8f-4e75-9b42-877cbb298ccf@gmx.com>
Date:   Thu, 17 Aug 2023 19:32:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] btrfs: map uncontinuous extent buffer pages into
 virtual address space
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1690249862.git.wqu@suse.com>
 <46e2952cfe5b76733f5c2b22f11832f062be6200.1690249862.git.wqu@suse.com>
 <20230727141840.GC17922@twin.jikos.cz>
 <60fc4f77-7992-1f27-a2e3-98570a48253d@gmx.com>
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
In-Reply-To: <60fc4f77-7992-1f27-a2e3-98570a48253d@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TixkkuH6dxMc54ryJdjF5eZEtf9SCeEdYlytW0rIA4OU+YL1uK1
 ez2G6aemcX4F1vsI+XWZJIFc+U641mvcaEk8nQmHWXMRKugPDZVcH69AxVmK4SpoQ+C2ugb
 WPtSlhytwKA/QfLrYZnPsmHWW5GFzD5BiisadBsL1BDGMwe3tZtc2UGxTCtqOMKI8UhfPPj
 +/8KmAyjD+g1YO9US6low==
UI-OutboundReport: notjunk:1;M01:P0:0EuvTW8C+u8=;sbE3SygWy6veA4Q7+7zfjOkdEKi
 pL12IDu3dEZV+cpzLBJcGFDZ7YNgN31WRu+BvPt4MKShbNmQMZnb4EwuwC+0UjTjmbeIYPSxi
 scPq0OUsEaQY64SMzsot5rfX24wqdHDL35mBWXo+DA6kuOJgj+ILuCIlnsfbe5bhv/Jw7VcrI
 L6YDst2wYcMkvDBoETCPNiCNWHNB6h8SJ9FrPM1mIzPz3STBixMVfR/1vgla9INyQ5EYXWEvn
 lnI+iy890IJzeAWTnVWWto+xffiv377Ex/zPryL3pdHn5koc9r2Qr79DYrH2e6NVXSdFvjYhl
 FDVw8rd3BWK7v2iVzXaZ9z2rE/ETBghJBDWUpGnI120eGiwwHHbh4uxRQrMm/Tn3hKhLbE6iH
 vj4lLpDntppM0mKHP9rQIt9f+8K2Xmc4z8H9yxMFsrjsg+8RZh4qDB7uI8Rn8ym7ta1N2OhN0
 qD3Y7YdWfkaC4FYxQTe8X5rKDO0efMnqOdVOxzts1IFSFGCvOM3FquJb/lXPIqpWne7ariMe7
 VHOkViLq+9xg+NgM9yM/n45oLTQgnAsZApcJCh3CAieu1wWiWST/t18i7qzVMTF9fEm9F88sV
 cVbecloq+rczTvfLwl9WyA1hWORUqepF4bElN3+uR5jhUhg7kVD+6M1h+5jVxrLpw2gxyIxOC
 48fdcj7NYID6v09xB0PNMD9iRTWCmGOwSaFE+C/fMpRDdXKv8zv/ClswtmMgrZsKmOxQG4vKs
 OlMP5hOr45RWMKIXScsQ5AfEyLNiS6vF6ED18d42tuoRtMFlDCLnYl8T3Nl5YvhVrP8AoSgac
 wjiCKjH/8TGuHEhSsV9dGPq1Ekn/uCRUWlSpcKxzw1zgcAh2WV+Dof6K+DMS0f/SdxdD40SCg
 LkEjvtBGWgjNoqhoQCtyIUrrUhymPo5Iyv/VevzeIkM3cDeMH8Vdf4wX7ccz3V+bqfk7kJBbm
 qVa34SUYkL1Bumx/Ij3NssIg/wA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/28 06:24, Qu Wenruo wrote:
>
>
> On 2023/7/27 22:18, David Sterba wrote:
>> On Tue, Jul 25, 2023 at 10:57:21AM +0800, Qu Wenruo wrote:
>>> Currently btrfs implements its extent buffer read-write using various
>>> helpers doing cross-page handling for the pages array.
>>>
>>> However other filesystems like XFS is mapping the pages into kernel
>>> virtual address space, greatly simplify the access.
>>>
>>> This patch would learn from XFS and map the pages into virtual address
>>> space, if and only if the pages are not physically continuous.
>>> (Note, a single page counts as physically continuous.)
>>>
>>> For now we only do the map, but not yet really utilize the mapped
>>> address.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> =C2=A0 fs/btrfs/extent_io.c | 70 +++++++++++++++++++++++++++++++++++++=
+++++++
>>> =C2=A0 fs/btrfs/extent_io.h |=C2=A0 7 +++++
>>> =C2=A0 2 files changed, 77 insertions(+)
>>>
>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>> index 4144c649718e..f40d48f641c0 100644
>>> --- a/fs/btrfs/extent_io.c
>>> +++ b/fs/btrfs/extent_io.c
>>> @@ -14,6 +14,7 @@
>>> =C2=A0 #include <linux/pagevec.h>
>>> =C2=A0 #include <linux/prefetch.h>
>>> =C2=A0 #include <linux/fsverity.h>
>>> +#include <linux/vmalloc.h>
>>> =C2=A0 #include "misc.h"
>>> =C2=A0 #include "extent_io.h"
>>> =C2=A0 #include "extent-io-tree.h"
>>> @@ -3206,6 +3207,8 @@ static void
>>> btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(!extent_buffer_under_io(eb));
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_pages =3D num_extent_pages(eb);
>>> +=C2=A0=C2=A0=C2=A0 if (eb->vaddr)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm_unmap_ram(eb->vaddr, nu=
m_pages);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < num_pages; i++) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *pa=
ge =3D eb->pages[i];
>>>
>>> @@ -3255,6 +3258,7 @@ struct extent_buffer
>>> *btrfs_clone_extent_buffer(const struct extent_buffer *src)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_buffer *new;
>>> +=C2=A0=C2=A0=C2=A0 bool pages_contig =3D true;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int num_pages =3D num_extent_pages(src)=
;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>
>>> @@ -3279,6 +3283,9 @@ struct extent_buffer
>>> *btrfs_clone_extent_buffer(const struct extent_buffer *src)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *p =
=3D new->pages[i];
>>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (i && p !=3D new->pages=
[i - 1] + 1)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pa=
ges_contig =3D false;
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D attach_=
extent_buffer_page(new, p, NULL);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 btrfs_release_extent_buffer(new);
>>> @@ -3286,6 +3293,23 @@ struct extent_buffer
>>> *btrfs_clone_extent_buffer(const struct extent_buffer *src)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON(PageDir=
ty(p));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (!pages_contig) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int nofs_flag;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int retried =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nofs_flag =3D memalloc_nof=
s_save();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ne=
w->vaddr =3D vm_map_ram(new->pages, num_pages, -1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (new->vaddr)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm=
_unmap_aliases();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } while ((retried++) <=3D =
1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memalloc_nofs_restore(nofs=
_flag);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!new->vaddr) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt=
rfs_release_extent_buffer(new);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn NULL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 copy_extent_buffer_full(new, src);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_extent_buffer_uptodate(new);
>>>
>>> @@ -3296,6 +3320,7 @@ struct extent_buffer
>>> *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 u64 start, unsigned long len)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_buffer *eb;
>>> +=C2=A0=C2=A0=C2=A0 bool pages_contig =3D true;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int num_pages;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> @@ -3312,11 +3337,29 @@ struct extent_buffer
>>> *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < num_pages; i++) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *p =
=3D eb->pages[i];
>>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (i && p !=3D eb->pages[=
i - 1] + 1)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pa=
ges_contig =3D false;
>>
>> Chances that allocated pages in eb->pages will be contiguous decrease
>> over time basically to zero, because even one page out of order will
>> ruin it.
>
> I doubt this assumption.
>
> Shouldn't things like THP requires physically contiguous pages?
> Thus if your assumption is correct, then THP would not work for long
> running servers at all, which doesn't look correct to me.
>
>> This means we can assume that virtual mapping will have to be
>> used almost every time.
>>
>> The virtual mapping can also fail and we have no fallback and there are
>> two more places when allocating extent buffer can fail.
>
> Yes, it can indeed fail, but it's only when the virtual address space is
> full. This is more of a problem for 32bit systems.
>
> Although my counter argument is, XFS is doing this for a long time, and
> even XFS has much smaller metadata compared to btrfs, it doesn't has a
> known problem of hitting such failure.
>
>>
>> There's alloc_pages(gfp, order) that can try to allocate contiguous
>> pages of a given order, and we have nodesize always matching power of
>> two so we could use it.
>
> Should this lead to problems of exhausted contiguous pages (if that's
> really true)?
>
>> Although this also forces alignment to the same
>> order, which we don't need, and adds to the failure modes.
>
> We're migrating to reject non-nodesize aligned tree block in the long ru=
n.
>
> I have submitted a patch to warn about such tree blocks already:
> https://patchwork.kernel.org/project/linux-btrfs/patch/fee2c7df3d0a2e91e=
9b5e07a04242fcf28ade6bf.1690178924.git.wqu@suse.com/
>
> Since btrfs has a similar (but less strict, just checks cross-stripe
> boundary) checks a long time ago, and we haven't received such warning
> for a while, I believe we can gradually move to reject such tree blocks.

Any extra feedback? Without this series, it's much harder to go folio
for eb pages.

Thanks,
Qu
>
> Thanks,
> Qu
