Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97520282EA7
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Oct 2020 03:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgJEBg7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Oct 2020 21:36:59 -0400
Received: from mout.gmx.net ([212.227.17.21]:49437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgJEBg7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 4 Oct 2020 21:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601861816;
        bh=IuIV7+lprFFeUSaU5DJJkXLWZusXwwgPmqDcsFckU38=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=k00o5Gehi5LsNL1PgX86FJ3vUHFSeOpleX1atVnjXXWTCVXWH4ewccq7SPKV5KI2u
         AIzHyFA7MS40+5MFd9UmoSy/qm+bvASBiOoraaZaauRnnxCrG3i2C7eHMoc3vMNnTF
         LiTQU27M7BTCA2AQe0UB449DDLxpyNZeW+TsUNlg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJE27-1k56Hk1bVz-00Kgxm; Mon, 05
 Oct 2020 03:36:56 +0200
Subject: Re: ERROR... please contact btrfs developers
To:     Eric Levy <ericlevy@gmail.com>, linux-btrfs@vger.kernel.org
References: <CA++hEgx2x=HjjUR=o2=PFHdQSFSqquNffePTVUqMNs19sj_wcQ@mail.gmail.com>
 <CA++hEgxubm6qW++ozNbxUfeikjJ9g_MGn3wnQBoj=mST3x0kZg@mail.gmail.com>
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
Message-ID: <854a65c4-1fa2-ab4e-ed68-aafd5ed3ef4e@gmx.com>
Date:   Mon, 5 Oct 2020 09:36:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CA++hEgxubm6qW++ozNbxUfeikjJ9g_MGn3wnQBoj=mST3x0kZg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="H79aW7hVvwfLCdqIMNTO74ncKU3qp1L2y"
X-Provags-ID: V03:K1:JbCPr5HuUlmREZdAEyMBwxNHSVjV4Xafh1E8qyaFzc5PtISjGDX
 K0Be+h4galDNBU2kDMNURDmehxyIlgDXahcZB77K62E3nj5JntfH9AVq6NWva1RalCcAACT
 H0/88DzsdUrQJhlzrNCxBTEpnEajjyZUhNAfd8yhxVlL18fejfEgJxNpj5dgaYQDJ7xJyhy
 SRyHDyFLzkOJA+5MMjlPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0j77+edp2Uo=:oi/jeX+7JJwEoyb2/hvnOw
 9PmFj+UHUzlEiPIi4+N1uDotchn7ap3MovdArTzR/QQCTBshkPpjAZHZZQKnqF02W82pjAqdF
 K8eCRUNAHYr8r2NjaVcMNwvsUB549lpY8Ze+Z4gfg6aZvh85mJMDXtjOjBmH1I7pMkL0mLf40
 Kqna/V8tO5YDrxDVobyQx5/OkDPbIIsBK6tkWAMj1LepN6vQ6XBuEa5JpP9pEFsthDCyeKsX5
 4UZ9jqf5YGGplC1crAlA5JewVI9oar5s1AWkoI3DEsC2xpUySn+ti3eXzAwRoL5JQGXIyrKBP
 IwDdUj2lLbLVNrlkqV107QaSQAJ9ErsZGlQzA4A1SIMFk/jdXTdphinLLp/1uCd2bvjU9lIhF
 mt5VmaM7zGxWGsAhgPQTGHHC3ulU5QzjYZXi43+zmP6jxu7K1pYJqArgO+2CaPBWjNMN8TtBe
 YL+X30GvBdQR+7ZKMh+IFOyLdUQgfpC/raCwVzYnsBvu4pKcmBqIEEZlzzjjKhurxS7h2LMZ4
 eh4ZCHXn6QQ4y0XC7Th+HcYPSxaz/y02MN+k9J6RMcVfvg9Odm7SU4DJcP77SnzjevDUK2gQb
 ErIm54cs1Aq9h+/QUgcasaSvw3A/wbuN75YCHe5BTQWfOZo8CiLP/TdzcCnbsXWE6hh3sgDcW
 YeZV/IyxxuEvg/tbG/9PlH0wCo8J3Bo51/rvY3A3ayWMWG6k+/jnj43R2dXhlGMmNWoBiypub
 lJPbjTdaqz0zdQX915VepcXmHEpg8pevphCdLtW3kXFzYtn76tKowZ6VNw0wEUFlXWPQGvtHN
 ZZAQIj5MQSF/8sgw2EK3BlxJK4/BIhCP5HH3LPbvnju8nw6WxF3EG5/5j7FWgsd30kNANAdvU
 Dgel7Ol4divwTnLXs35ninHsbhiv42D39p76a7lcsA/AEQqATYuHJ3wg8x9CM4aP8WtRS73DZ
 4v9W7or3ovieEOiiOo8v2LpHwctBn4EPtTu87qnBRU3RlH3gBrTdupthEbSr394MuwxaqJpym
 jyw+AKPzSYF9pEdR5tMDRircqYcGHlLLraqRMAtCvsaa78ChmZ9HXYfPrWHo+Kjbu9poMRoCM
 FXJi53yLEsYY4j/BuxN8MAW2lTb7Nvg6uENnkeIW7MbxBV/LForgOrNuBYdWtJDwHYvYjmWQ1
 Xu0N/fvBwqQ/tKds9kKWEpZM6rZRuGM5xF9YzVEEpilEofNFEWyGJOagWIISMybbZZ++7tJhj
 BrmhmP0Ci7Z4w2bZHKvMMifyxDF5rAj+hMlEoxQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H79aW7hVvwfLCdqIMNTO74ncKU3qp1L2y
Content-Type: multipart/mixed; boundary="F5jzwwvlff1C7vy2L7Q9h69AdAcySRZMJ"

--F5jzwwvlff1C7vy2L7Q9h69AdAcySRZMJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/5 =E4=B8=8A=E5=8D=889:33, Eric Levy wrote:
> A new observation is that I notice that through the RO option,
> although the mount still degrades after continued use, it is more
> stable than in a standard RW mode. At this point, I believe I have
> recovered the crucial folders, though I have no guarantee that no
> files are missing or corrupted.

As replied, none of your data is lost or corrupted by this incident.

You can reverted to older kernel without the extent item generation
check to continue your usage without any problem.

Also as said, using this branch with "btrfs check --repair" should solve
your problem, and make the fs safe against latest kernel
https://github.com/adam900710/btrfs-progs/tree/extent_gen_repair

Thanks,
Qu


> I would hope to restore this
> filesystem to a fully functional state, or otherwise clone the
> subvolumes successfully to another partition, with as much data
> recovery as possible.
>=20
> Even with RO, the receive command still fails rather abruptly, though
> not always immediately:
>=20
> ERROR: send ioctl failed with -5: Input/output error
>=20
> I have written to the list because I believe that doing so best
> satisfies the request within the error message to "please contact
> btrfs developers". If another avenue of communication is more
> suitable, then please advise.
>=20
> On Tue, Sep 29, 2020 at 9:44 PM Eric Levy <ericlevy@gmail.com> wrote:
>>
>> I recently upgraded a Linux system running on btrfs from a 5.3.x
>> kernel to a 5.4.x version. The system failed to run for more than a
>> few minutes after the upgrade, because the root mount degraded to a
>> read-only state. I continued to use the system by booting using the
>> 5.3.x kernel.
>>
>> Some time later, I attempted to migrate the root subvolume using a
>> send-receive command pairing, and noticed that the operation would
>> invariably abort before completion. I also noticed that a full file
>> walk of the mounted volume was impossible, because operations on some
>> files generated errors from the file-system level.
>>
>> Upon investigating using a check command, I learned that the file
>> system had errors.
>>
>> Examining the error report (not saved), I noticed that overall my
>> situation had rather clear similarities to one described in an earlier=

>> discussion [1].
>>
>> Unfortunately, it appears that the differences in the kernels may have=

>> corrupted the file system.
>>
>> Based on eagerness for a resolution, and on an optimistic comment
>> toward the end of the discussion, I chose to run a check operation on
>> the partition with the --repair flag included.
>>
>> Perhaps not surprisingly to some, the result of a read-only check
>> operation after the attempted repair gave a much more discouraging
>> report, suggesting that the damage to the file system was made worse
>> not better by the operation. I realize that this possibility is
>> explained in the documentation.
>>
>> At the moment, the full report appears as below.
>>
>> Presently, the file system mounts, but the ability to successfully
>> read files degrades the longer the system is mounted and the more
>> files are read during a continuous mount. Experiments involving
>> unmounting and then mounting again give some indication that this
>> degradation is not entirely permanent.
>>
>> What possibility is open to recover all or part of the file system?
>> After such a rescue attempt, would I have any way to know what is lost=

>> versus saved? Might I expect corruption within the file contents that
>> would not be detected by the rescue effort?
>>
>> I would be thankful for any guidance that might lead to restoring the =
data
>>
>>
>> [1] https://www.spinics.net/lists/linux-btrfs/msg96735.html
>> ---
>>
>> Opening filesystem to check...
>> Checking filesystem on /dev/sda5
>> UUID: 9a4da0b6-7e39-4a5f-85eb-74acd11f5b94
>> [1/7] checking root items
>> [2/7] checking extents
>> ERROR: invalid generation for extent 4064026624, have 94810718697136
>> expect (0, 33469925]
>> ERROR: invalid generation for extent 16323178496, have 94811372174048
>> expect (0, 33469925]
>> ERROR: invalid generation for extent 79980945408, have 94811372219744
>> expect (0, 33469925]
>> ERROR: invalid generation for extent 318963990528, have 94810111593504=

>> expect (0, 33469925]
>> ERROR: invalid generation for extent 319650189312, have 14758526976
>> expect (0, 33469925]
>> ERROR: invalid generation for extent 319677259776, have 414943019007
>> expect (0, 33469925]
>> ERROR: errors found in extent allocation tree or chunk allocation
>> [3/7] checking free space cache
>> block group 71962722304 has wrong amount of free space, free space
>> cache has 266420224 block group has 266354688
>> ERROR: free space cache has more free space than block group item,
>> this could leads to serious corruption, please contact btrfs
>> developers
>> failed to load free space cache for block group 71962722304
>> [4/7] checking fs roots
>> [5/7] checking only csums items (without verifying data)
>> [6/7] checking root refs
>> [7/7] checking quota groups
>> found 399845548032 bytes used, error(s) found
>> total csum bytes: 349626220
>> total tree bytes: 5908873216
>> total fs tree bytes: 4414324736
>> total extent tree bytes: 879493120
>> btree space waste bytes: 1122882578
>> file data blocks allocated: 550505705472
>>  referenced 512080416768


--F5jzwwvlff1C7vy2L7Q9h69AdAcySRZMJ--

--H79aW7hVvwfLCdqIMNTO74ncKU3qp1L2y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl96eLQACgkQwj2R86El
/qhOUwgAqYmZJ/LwMrUi1k4WLogcnC1paZ6RYJwdLrh2p0hbNw1env0x7bS/u4JH
lzR75+N2t9LE6MVmTJUvtt+QfNBrYcHUHrravfAIHrY/79PxRVPJ803rq2Ot5enQ
kBBF8pMGRkVLQxGd9gFittPfKEMMXWUyUa7IqI0ZIdvA5AsmauCW+dul0udwzhHj
dvX12f5t8hRuYZjYOlKVGJiTikJWwgHA8vqsbvsh++4rfBz47nfXdaTwvXBle7Vc
QCTl57bvsWgyS1wL7jqp8++4jalgOm+CVw55XzDAZQS3aJ9QlkzmcB2YuRFRHIbF
N8p6ltJW2nTRcHxV/Kk1osB0KtpI4Q==
=0Gh4
-----END PGP SIGNATURE-----

--H79aW7hVvwfLCdqIMNTO74ncKU3qp1L2y--
