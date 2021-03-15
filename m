Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162DF33B2E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 13:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhCOMkB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 08:40:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:47721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhCOMjm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 08:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615811977;
        bh=h7JhyafNPMAd8sfrZVo4KOyHI91viqCRB1QJxFie9u4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=OOhi5toS+Mf2k6F+3RUpGHTkzGON71Tj6Vth8Wr3uJPzr5E3c6GYiAkIK7e6U3d6/
         cTR8N6Y7mRZd+T5sn4wSLQskZGQmqeapI1Hjz3rsSKnaGcUAJNQQ3jZvdCrQAbZ5ic
         TMy/XW/FyDBjNR82O9WFsjAW+78bXiWzRnoO85OI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1Obb-1ljGeB17aV-012mMk; Mon, 15
 Mar 2021 13:39:36 +0100
Subject: Re: [PATCH v2 01/15] btrfs: add sysfs interface for supported
 sectorsize
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210310090833.105015-1-wqu@suse.com>
 <20210310090833.105015-2-wqu@suse.com>
 <61c2ba18-c3de-a67f-046f-1f315500c8c8@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <59a9ee34-1893-a642-2a00-8cc42ec7a31f@gmx.com>
Date:   Mon, 15 Mar 2021 20:39:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <61c2ba18-c3de-a67f-046f-1f315500c8c8@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TWzMCqerrfprOLEJgSpz5cYR3cwfMGwqGqqGiSni94gkzTPUE74
 gSDK92sg8P4cmj9HsMStyORUwNWtInnOZHctOeFk90LySgRgj3FXhIwGO/5r7U3LGQE7nz8
 /TGLW/b0RSz/39VN+HjgB8XaO96TXp2UJngFSkSYl4atX//pfgp8+CjWz+j0xOpxldpBg6Q
 eM0VBQ/6aH+/ssxl460wg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HHdWqoAn+4k=:atuANwONPaAUB9Bv+7TDZ4
 tODPDU+KCwf82T1yAEQhxzBrYChgAg2JVbeC+kNP2IrMc2NPq1h+IxmPX8fJfUHr+FmfodNCl
 m9LG9Nh0YMaj7DbOnqFss8xPSdt9Hohee2mwQnOg0+ESJKRmEDi//12MxxvAE6BGFK3PJqlMM
 5RWCZxBm8sa86s0OBhdsPkYkMRhdUNEhdZ4p+ktVtTPzdX7AGbKPeIyS7eMZndJQZtPuwfaZd
 dyjFumz4TwFXn4Fg2sd9y6hprw5Z+boYDaPK4+Etj3ItG07GlrtwJxstMZitJkOowgxagMOwn
 dIpOLyYJRLgzlPPoJbuni4IizYB3zevlUGSKm+s/R2zhULgVyoqjL2bjvSLFZ49MbTZ+FoMxJ
 OUkuj4yngapb9yrtrTKXH5eDirA4zgQwNkKCKwW0Hc93B5bjjkoZk6Cud1FfCWuDdd3apfiU1
 elDdBjLH0vkeiAAz2kw55OigLZypDGaYrAopq6kFSNDecrnGb3e3tddfvG+17cvGhqAWpAJTl
 Ut7X6ld8rpUkaTek5h5oc+ymeLARf1rT124evy3LpfLSomdZzUroF9xYQA4CWhQwtNunu+f/r
 7KBoliQneM31iSyLmcD5YWsUdORJrD7NGaPSjzysIb8IIkKClWSxGEyOwujtUBXv13zu02srp
 sYpqmJvn8TNST+W29EUw7hNIAPGz5Dm8lltUs29eBxht17SaUKMYb5LDDpcWZyHG/uRdY4TjI
 t2mFwgyvJHTOCy+H3ghzj0Yu6zoa4Wq83Ju8snnelZGbwakW+0own00W5j9WCKNBLRRKyj3qh
 Y6kYu4J7b0W6ZCTLE7zrrklQ0XrMckFCR4N6NgRvL4Ld5vc0RrtQQ9m4CFMqdsxldQrh4n/G5
 E8kOhYpHj0i3Kf2VGHug==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/15 =E4=B8=8B=E5=8D=887:59, Anand Jain wrote:
> On 10/03/2021 17:08, Qu Wenruo wrote:
>> Add extra sysfs interface features/supported_ro_sectorsize and
>> features/supported_rw_sectorsize to indicate subpage support.
>>
>> Currently for supported_rw_sectorsize all architectures only have their
>> PAGE_SIZE listed.
>>
>> While for supported_ro_sectorsize, for systems with 64K page size, 4K
>> sectorsize is also supported.
>>
>> This new sysfs interface would help mkfs.btrfs to do more accurate
>> warning.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>
> Changes looks good. Nit below...
> And maybe it is a good idea to wait for other comments before reroll.
>
>> =C2=A0 fs/btrfs/sysfs.c | 34 ++++++++++++++++++++++++++++++++++
>> =C2=A0 1 file changed, 34 insertions(+)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 6eb1c50fa98c..3ef419899472 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -360,11 +360,45 @@ static ssize_t
>> supported_rescue_options_show(struct kobject *kobj,
>> =C2=A0 BTRFS_ATTR(static_feature, supported_rescue_options,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 supported_rescue_optio=
ns_show);
>> +static ssize_t supported_ro_sectorsize_show(struct kobject *kobj,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stru=
ct kobj_attribute *a,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char=
 *buf)
>> +{
>> +=C2=A0=C2=A0=C2=A0 ssize_t ret =3D 0;
>> +=C2=A0=C2=A0=C2=A0 int i =3D 0;
>
>  =C2=A0Drop variable i, as ret can be used instead of 'i'.
>
>> +
>> +=C2=A0=C2=A0=C2=A0 /* For 64K page size, 4K sector size is supported *=
/
>> +=C2=A0=C2=A0=C2=A0 if (PAGE_SIZE =3D=3D SZ_64K) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret +=3D scnprintf(buf + re=
t, PAGE_SIZE - ret, "%u", SZ_4K);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i++;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 /* Other than above subpage, only support PAGE_SIZE=
 as sectorsize
>> yet */
>> +=C2=A0=C2=A0=C2=A0 ret +=3D scnprintf(buf + ret, PAGE_SIZE - ret, "%s%=
lu\n",
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (i ? " " : ""), PAGE_SIZE);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^ret
>
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +BTRFS_ATTR(static_feature, supported_ro_sectorsize,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 supported_ro_sectorsize_show);
>> +
>> +static ssize_t supported_rw_sectorsize_show(struct kobject *kobj,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stru=
ct kobj_attribute *a,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char=
 *buf)
>> +{
>> +=C2=A0=C2=A0=C2=A0 ssize_t ret =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Only PAGE_SIZE as sectorsize is supported */
>> +=C2=A0=C2=A0=C2=A0 ret +=3D scnprintf(buf + ret, PAGE_SIZE - ret, "%lu=
\n", PAGE_SIZE);
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +BTRFS_ATTR(static_feature, supported_rw_sectorsize,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 supported_rw_sectorsize_show);
>
>  =C2=A0Why not merge supported_ro_sectorsize and supported_rw_sectorsize
>  =C2=A0and show both in two lines...
>  =C2=A0For example:
>  =C2=A0=C2=A0 cat supported_sectorsizes
>  =C2=A0=C2=A0 ro: 4096 65536
>  =C2=A0=C2=A0 rw: 65536

If merged, btrfs-progs needs to do line number check before doing string
matching.

Although I doubt the usefulness for supported_ro_sectorsize, as the
window for RO support without RW support should not be that large.
(Current RW passes most generic test cases, and the remaining failures
are very limited)

Thus I can merged them into supported_sectorsize, and only report
sectorsize we can do RW as supported.

Thanks,
Qu

>
>
>
>> =C2=A0 static struct attribute *btrfs_supported_static_feature_attrs[] =
=3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_ATTR_PTR(static_feature, rmdir_sub=
vol),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_ATTR_PTR(static_feature, supported=
_checksums),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_ATTR_PTR(static_feature, send_stre=
am_version),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_ATTR_PTR(static_feature, supported=
_rescue_options),
>> +=C2=A0=C2=A0=C2=A0 BTRFS_ATTR_PTR(static_feature, supported_ro_sectors=
ize),
>> +=C2=A0=C2=A0=C2=A0 BTRFS_ATTR_PTR(static_feature, supported_rw_sectors=
ize),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL
>> =C2=A0 };
>>
>
