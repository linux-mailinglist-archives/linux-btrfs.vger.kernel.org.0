Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A882151AA1
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 13:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgBDMje (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 07:39:34 -0500
Received: from mout.gmx.net ([212.227.17.20]:47053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbgBDMjd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Feb 2020 07:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580819964;
        bh=g69kJNcdFR7UVsjfPqsYMvYj9aqjbZ73oWRTJtD/02w=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Iz7S4b2WO3gxkhW7lMMu5TOAGbFE/SgNAcRypY1LHkU7LO8JWw2ItCem1nsHUFdKE
         MPgFbtZ63bTAuEHQGNhmKz6DQZa+jom8Rv9zp17R9cwZBrgls7hCjlJ4F2pqET2uAI
         972NWaJQ+wgCkzX4/VUAjSyzn8fZRUSIpYB41V10=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2V4J-1jgAZI1C7L-013uxf; Tue, 04
 Feb 2020 13:39:23 +0100
Subject: Re: [PATCH 2/3] btrfs: add a comment describing delalloc space
 reservation
To:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200203204436.517473-1-josef@toxicpanda.com>
 <20200203204436.517473-3-josef@toxicpanda.com>
 <7000f8a2-4d78-d9a1-2e3f-143b88ace1eb@gmx.com>
 <55055cf9-2c36-8e3e-d1b8-b3fb53cc03c1@suse.com>
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
Message-ID: <356f2d03-bc34-7d13-ff0c-15cf39676333@gmx.com>
Date:   Tue, 4 Feb 2020 20:39:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <55055cf9-2c36-8e3e-d1b8-b3fb53cc03c1@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1E1fT7POdjN5tQjxLDqIQwpC0PqJui9TbhlTV1wMMxf4pEq6iZK
 C8ZR14fdx/EaWyhRDmF2+FQip0+OAE8xPJEBiqrNiZnRuMHSP0LXieMKjoM06FUYsSnzBGt
 5txFftVFHlpij96dszgw5qgPI0fcCtiNqbnsaJELgm8FuRzEA4qCvktYrSvgdNJY6eSHAiG
 cnxxm0SCT+cFa0wJAdoIA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gL2MmUpKE9w=:NnS7iSVcMeuR/OdQBZwVkh
 U5gqzCuKW4bhmqqvRjvN5yLFAJiZxmi5pzheWABiRopRSgU4YOc/XGUQxEJvOSD/Jzccp4PYn
 68SDtCweYAcfm+AZvvatlPX+ktYbAbNOXNiTgt0xc+NrvzP7W0NB+tkkpK+Ly36UMrUnzIq9M
 v0j9EJkJUgeN0Olr1tK/eYhBJlcnX45fY00Wmcy6fufIV8mbkqzY/0sC9c1PceqNdGtY66pYA
 5Z4aCMiEXX18eHSzpmAnZjKiBLgqfz0pwIIP/9ibNJYQGYlLjPqgaPJnEFLUCvcJl11h3aq2j
 sET5WqjJz2MsQeBZM4k4Rk4oPjELx9h95KO7yFqdthAv7xeghghriht/E5muWrl9kyRWMbqiG
 czcSWWaN1XoZYpCbu50f1y/ilLuK1J2r26Xgz5dzK2UhHkDMgRJwh5KYKT5MUmE3ZtqFm+cBC
 SCjm+7MbW47V5O66KllSD49ZOouJZGvC5s+ZAIS3HHH7hO+fg3EX4ChCFpFC/GzCgiSOPvmtc
 PceCYAnlI6dAz5TZPaHz0sFS3WS8yikBG8jSVtTCfCkfq00FmGtXsPA4R1bVgcaYrSzEcOOBB
 sG448NFVKxDzikxDPWaUclbOAEORxovaKqO1Jl3XxlyH8+UFid+TGyxuOLqS+W8UKI54lAZpV
 5uInUdMEjIePZu1H+QqZCG7L948bJyg3sO92PV+gVeI14AguYvPKh4RPaswE7Mv27oAms3X6h
 G0PDi/z1/8tjOVT1rc1xagiE5l6BjflxIbA5r4jKnHVZ+EVM18ffna+jsDEJMum+66RtXoJfM
 Qy7CbbSrPYIQmW0c7K0aDMVQs2+Lnjx9IGQY7jr2xGtVoS5x9uu4aHmqiHxncTtbuVmSocS7Z
 9brnEQH/0/zntBSkCVZZyt2Ls65hCd1qzSDQ7vs38mrPVyNjt70X8+FvUXaQUAGDoV3Zs0eBC
 k7J/nAXEtsIeUlxAU+uVYfozM6ruDInNAFOOAMrXI0QhA+/fqyfLA/UCgqfaOFnRetEtAR+eo
 mhBmBIifHel1syrmvDRaNYeituwBlu55z6bCnK8N+9nfRlSPy/ulNjfa8CdRExu708KPqFtCZ
 L1S51rmJDAGaPwXsw+62Qi841AhLgTPWEE5OVqyHIppZZYwik0txhOjArAjEkHRaPQ1G2YSNI
 8fhR87EW0f9OmBCcwc2yb1DlTqDqyXRYS3I1xRvRcWcsh65og+oaPL7gk9OI90Y+k5c0aQjiz
 T3SBvbP6dJZwDycvd
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/4 =E4=B8=8B=E5=8D=888:27, Nikolay Borisov wrote:
>
>
> On 4.02.20 =D0=B3. 11:48 =D1=87., Qu Wenruo wrote:
>>
>
>
> <snip>
>
>>
>>> + *
>>> + *   Once this space is reserved, it is added to space_info->bytes_ma=
y_use.  The
>>> + *   caller must keep track of this reservation and free it up if it =
is never
>>> + *   used.  With the buffered IO case this is handled via the EXTENT_=
DELALLOC
>>> + *   bit's on the inode's io_tree.  For direct IO it's more straightf=
orward, we
>>> + *   take the reservation at the start of the operation, and if we wr=
ite less
>>> + *   than we reserved we free the excess.
>>
>> This part involves the lifespan and state machine of data.
>> I guess more explanation on the state machine would help a lot.
>>
>> Like:
>> Page clean
>> |
>> +- btrfs_buffered_write()
>> |  Reserve data space for data, metadata space for csum/file
>> |  extents/inodes.
>> |
>> Page dirty
>> |
>> +- run_delalloc_range()
>> |  Allocate data extents, submit ordered extents to do csum calculation
>> |  and bio submission
>> Page write back
>> |
>> +- finish_oredred_io()
>> |  Insert csum and file extents
>> |
>> Page clean
>>
>> Although I'm not sure if such lifespan should belong to delalloc-space.=
c.
>
> This omits a lot of critical details. FOr example it should be noted
> that in btrfs_buffered_write we reserve as much space as is requested by
> the user. Then in run_delalloc_range it must be mentioned that in case
> of compressed extents it can be called to allocate an extent which is
> less than the space reserved in btrfs_buffered_write =3D> that's where t=
he
> possible space savings in case of compressed come from.

If you spoiler everything in the introduction, I guess it's no longer
introduction.
An introduction should only tell the overall picture, not every details.
For details, we go read mentioned functions.

And too many details would make the introduction pretty hard to
maintain. What if one day we don't the current always reserve behavior
for buffered write?

So I tend to have just a overview, and entrance function. With minimal
details unless it's a really complex design.

Thanks,
Qu

>
> As a matter of fact running ordered io doesn't really clean any space
> apart from a bit of metadata space (unless we do overwrites, as per our
> discussion with josef in the slack channel).
>
> <snip>
>
>>> + *
>>> + *   1) Updating the inode item.  We hold a reservation for this inod=
e as long
>>> + *   as there are dirty bytes outstanding for this inode.  This is be=
cause we
>>> + *   may update the inode multiple times throughout an operation, and=
 there is
>>> + *   no telling when we may have to do a full cow back to that inode =
item.  Thus
>>> + *   we must always hold a reservation.
>>> + *
>>> + *   2) Adding an extent item.  This is trickier, so a few sub points
>>> + *
>>> + *     a) We keep track of how many extents an inode may need to crea=
te in
>>> + *     inode->outstanding_extents.  This is how many items we will ha=
ve reserved
>>> + *     for the extents for this inode.
>>> + *
>>> + *     b) count_max_extents() is used to figure out how many extent i=
tems we
>>> + *     will need based on the contiguous area we have dirtied.  Thus =
if we are
>>> + *     writing 4k extents but they coalesce into a very large extent,=
 we will
>
> I THe way you have worded this is a bit confusing because first you
> mention that count_max_extents calcs how many extent items we'll need
> for a contiguous area. Then you mention that if we make a bunch of 4k
> writes that coalesce to a single extent i.e create 1 large contiguous
> (that's what coalescing implies in this context) we'll have to split it
> them. This is counter-intuitive.
>
> I guess what you meant here is physically contiguous as opposed to
> logically contiguous?
>
>>> + *     break this into smaller extents which means we'll need a reser=
vation for
>>> + *     each of those extents.
>>> + *
>>> + *     c) When we set EXTENT_DELALLOC on the inode io_tree we will fi=
gure out
>>> + *     the nummber of extents needed for the contiguous area we just =
created,
>
> nit: s/nummber/number
>
>>> + *     and add that to inode->outstanding_extents.
>
> <snip>
>
>>> + *
>>> + *   3) Adding csums for the range.  This is more straightforward tha=
n the
>>> + *   extent items, as we just want to hold the number of bytes we'll =
need for
>>> + *   checksums until the ordered extent is removed.  If there is an e=
rror it is
>>> + *   cleared via the EXTENT_CLEAR_META_RESV bit when clearning EXTENT=
_DELALLOC
>
> nit: s/clearning/clearing
>
>>> + *   on the inode io_tree.
>>> + */
>>> +
>>>  int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 by=
tes)
>>>  {
>>>  	struct btrfs_root *root =3D inode->root;
>>>
>>
