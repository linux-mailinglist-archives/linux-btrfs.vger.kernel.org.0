Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17C6412CDF9
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 10:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfL3JJn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 04:09:43 -0500
Received: from mout.gmx.net ([212.227.17.21]:55493 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbfL3JJm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 04:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577696976;
        bh=o43peOlbkRKBJhjVuwLX/BRpdtol7qjamVgouLthVmo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OSA/znIBe0YEVCvPU/ASGMJ4Q8URDLfwLTCuF7eurNOOOqI9DMdHEbOQada0I0CMW
         VRraVpXpz7ysiLhqBWwRjqph/IEmjnNv0lSKFkVOAZDno0Xlvm5ZxyoqIRppwtXlf0
         yfcw6w2ae6OqRnvEF2EJt+9XqpDVlduXmCje+lkc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwQTF-1jdP4s1YDV-00sMji; Mon, 30
 Dec 2019 10:09:36 +0100
Subject: Re: read time tree block corruption detected
To:     Patrick Erley <pat-lkml@erley.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
 <4bf17941-2ab0-15ca-b4c9-f6ba037624ee@gmx.com>
 <CAOB=O_jfwBVihtbNTF1xLNWNtf2_Mi=Bs_BCZ8VnXOKWosw7uQ@mail.gmail.com>
 <66d35620-160e-105a-6970-03c3de3f7c78@gmx.com>
 <CAOB=O_jpg0K4eDARfG+XDDRMHhm+yKp8XfhjqHsFxAswSPUfdQ@mail.gmail.com>
 <CAOB=O_hdjpNtNtMMi93CFh3wO048SDVxMgBQd_pC0wx0C_49Ug@mail.gmail.com>
 <a2f28c83-01c0-fce7-5332-2e9331f3c3df@gmx.com>
 <CAOB=O_gBBjT9EVduHWHbF8iOsA8ua-ZGGh4s1x6Lia24LAZEMg@mail.gmail.com>
 <4c06d3a9-7f09-c97c-a6f3-c7f7419d16a7@gmx.com>
 <CAOB=O_i=ZDZw92ty9HUeobV1J4FA8LNRCkPKkJ1CVrzHxAieuw@mail.gmail.com>
 <27a9570c-70cc-19b6-3f5f-cd261040a67c@gmx.com>
 <CAOB=O_hMPVfmFqumfcdS8LxG0tZXR2AiccDwgN1f6Lomntg9uQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <4a28f224-a602-61e7-3404-68a4414df81c@gmx.com>
Date:   Mon, 30 Dec 2019 17:09:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAOB=O_hMPVfmFqumfcdS8LxG0tZXR2AiccDwgN1f6Lomntg9uQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vOPJgCEZzxntg1XYYPCxpntYvEPHbADLZ"
X-Provags-ID: V03:K1:U/7cPtHelXtsQq1f1qFbslAnYaRKyGaCbTR3CXkZe7G/pmi+poq
 1tcPEiQL1asMZBS5mrB+vuaawN3Fol5el8Pl1fIyLXnXbe4JAqb5BqWXIG4ASZNMv7bzKw9
 Kw9HA9vi9pszmXUKqK9cGJ0//cvquR+TR916fb4n0HKTdolZVfZfa/Joi7rN6wMcKt29LON
 3Ctr55qvqfbA+o1dfWIBA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EZvjcpIBlW8=:q3ybFntHdr0PvvDemERra1
 fNkySeNqMvXZMXf1TNdGOpVwkUQOsSNS/cZiBjraOQQhP3vILlhuY8kXMascOPBNv8w2GO/KL
 rDI5/j4HoCROK5E1u5pTMKfW3ELcFhy2kLQgbFd6Osi4NEAcp2ZZYKwLiRtGXiXhy4o8qygYN
 4eSBNtCRYdFO1q7xHiss+Jk+Jh2jDTufJLJ/ICTRnD52ffjz11Y0aWfZOtaoZsvgwk3/nDL3S
 s0OydMmgV1fZ3+oJlqCVu1DgWBFgqjV1EexBakHg9gvIoa06LDznUzrQxNVqa81ypKOETDwB8
 VTKn7Snm8Bcy4ajkYBuNg061aobwgs0TKXTwVWQSpDjIRIh2Q4LHnTdJP/o4bR+EdcuaQ06aD
 MfJLgAfzKYogKt5ECK4uZTHatDNfRExmX/eCAhHJt5ctmHwL2OlK5S7rMLxFGtKsab14+cV3M
 P2KP5Uj+fZKk16FosXwxuBE5eu+7EH3/6kRZ+pL69l5XJvbXADhfN61SDC6kKetP5zo9i8qy0
 lee9vs/3O781iKVsxjY8cyRZ5DYRHyLjkN7OQNOCRmj+tpOvHmuKFFainsZypXLbj6Sti1qfu
 Oy3T/x+w04hIdy8noeQ7GNOkUJqAXQCu/Ab+S5Qmme3axLvD1e4aaKMxDdqp4r5eFi/yJ5lEy
 QAQKr56T3VqTf3YxVCrvPQtFLhDlSxj/0p/QMZvLCjwxkxXUXsS629zX//Zs/2nyZH+b3oZb8
 gNs0kryvtRIeljB2I8CbZNd1BSt6lr/oqP0sCaiKHwcYtpQbm9VsYO21cXhE71N4ISnKYLaro
 06Z2yrM5wOMxNq34oCfP013U0b8JKvdk8tF/k+IHPGD2sBmAKhpFIqL1JGbuhufxXUSLCNDvu
 EpSzLpT07MOKg40xsgrnyQhGfW2ifHLZ2RRM5ZY2w2TotK2CJcwJKLiAYR1YqQGNa9UBB9m60
 FpjhJa+SFH/y9bF9PCJ/GOXOMsUfj8b5PuQT2cX+KPaRC18kFg+89NfU+80il0mJTAnj+fsTG
 oQeMVIjF98PXqsk176R5eXhgQAji42FicfYNYOHxuDfjkf4W6Y2QcxKPkv7Rtu8BAJd15/93P
 W8o0Ffu7NukOh5FyFl11vcO3pLrY4F/fDygqSmqoGMiIoDzqa7DnLzL2cRAz9thjPZBTMIJzo
 J7g1k0feLOuVfw6AGKpiiF3n/E8CFserzZp9rHD6UmvBFA7WBAh79fLUsu6F6s/f/DhO4hV3C
 dYS3SA9TJdf9SijyVwI/8K4vSGGjSeq7kfE1wedUit6PEdrqcVnzNKy4gFT8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vOPJgCEZzxntg1XYYPCxpntYvEPHbADLZ
Content-Type: multipart/mixed; boundary="CL2qAib9nnT137jXJlEb53AQV1oWCz1cG"

--CL2qAib9nnT137jXJlEb53AQV1oWCz1cG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/30 =E4=B8=8B=E5=8D=885:01, Patrick Erley wrote:
> On Mon, Dec 30, 2019 at 8:54 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>> On 2019/12/30 =E4=B8=8B=E5=8D=884:14, Patrick Erley wrote:
>>> On Mon, Dec 30, 2019 at 6:09 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
>>>
>>> Should I also paste in the repair log?
>>>
>> Yes please.
>>
>> This sounds very strange, especially for the transid mismatch part.
>>
>> Thanks,
>> Qu
>>
>=20
>=20
>=20
> enabling repair mode
> WARNING:
>=20
>     Do not use --repair unless you are advised to do so by a developer
>     or an experienced user, and then only after having accepted that no=

>     fsck can successfully repair all types of filesystem corruption. Eg=
=2E
>     some software or hardware bugs can fatally damage a volume.
>     The operation will start in 10 seconds.
>     Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1parent transid verify failed on 499774464000
> wanted 3323349 found 3323340
> parent transid verify failed on 499774521344 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774529536 wanted 3323349 found 33233=
40

This message is from open_ctree(), which means the fs is already corrupte=
d.

Would you like to provide the history between last good btrfs check run
and --repair run?

Thanks,
Qu

> [1/7] checking root items
> parent transid verify failed on 499774373888 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774480384 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774386176 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774390272 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774394368 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774398464 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774402560 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774406656 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774423040 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774427136 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774435328 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774439424 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774320640 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774324736 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774443520 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774447616 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774504960 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774513152 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774468096 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774337024 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774341120 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774517248 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774558208 wanted 3323349 found 33233=
40
> Fixed 0 roots.
> [2/7] checking extents
> extent back ref already exists for 499952799744 parent 0 root 2
> extent back ref already exists for 499952803840 parent 0 root 2
> extent back ref already exists for 499952807936 parent 0 root 2
> extent back ref already exists for 499952812032 parent 0 root 2
> extent back ref already exists for 499952816128 parent 0 root 2
> extent back ref already exists for 499952824320 parent 0 root 5
> extent back ref already exists for 499952832512 parent 0 root 2
> extent back ref already exists for 499952852992 parent 0 root 2
> extent back ref already exists for 499952857088 parent 0 root 2
> extent back ref already exists for 499952861184 parent 0 root 2
> extent back ref already exists for 499952877568 parent 0 root 2
> extent back ref already exists for 499952885760 parent 0 root 2
> extent back ref already exists for 499952889856 parent 0 root 2
> extent back ref already exists for 499952898048 parent 0 root 2
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499774554112
> leaf parent key incorrect 499773358080
> bad block 499773358080
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> [4/7] checking fs roots
> parent transid verify failed on 499774283776 wanted 3323349 found 33233=
40
> Wrong key of child node/leaf, wanted: (1442047, 1, 0), have:
> (523365974016, 168, 16384)
> ERROR: child eb corrupted: parent bytenr=3D499750891520 item=3D2 parent=

> level=3D2 child level=3D0
> root 5 inode 1442047 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name etc filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 1835263 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name bin filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 1966335 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 4 name proc filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 2097407 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 5 name lib32 filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 2228479 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name sys filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 2359551 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 5 name lib64 filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 3145983 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name dev filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 3277055 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name opt filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 3408127 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name mnt filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 3539199 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name usr filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 3670271 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 5 name media filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 4587775 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 4 name sbin filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 4980991 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 4 name etc2 filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 4984678 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name run filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 5505279 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 7 name exports filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 5767423 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 5 name debug filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 5898495 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 4 name etc3 filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 6029567 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 4 name root filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 6431345 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 4 name boot filetype 2
> errors 6, no dir index, no inode ref
> ERROR: child eb corrupted: parent bytenr=3D499762622464 item=3D37 paren=
t
> level=3D2 child level=3D0
> root 5 inode 6553855 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name var filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 7602431 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name tmp filetype 2
> errors 6, no dir index, no inode ref
> ERROR: child eb corrupted: parent bytenr=3D499752206336 item=3D14 paren=
t
> level=3D3 child level=3D0
> root 5 inode 9133291 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 13 name .pulse-cookie
> filetype 1 errors 6, no dir index, no inode ref
> ERROR: child eb corrupted: parent bytenr=3D499748732928 item=3D14 paren=
t
> level=3D3 child level=3D0
> root 5 inode 9133292 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 6 name .pulse filetype 2
> errors 6, no dir index, no inode ref
> ERROR: child eb corrupted: parent bytenr=3D499752206336 item=3D14 paren=
t
> level=3D3 child level=3D0
> root 5 inode 9980485 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 9 name bootchart filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 10254180 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 4 name temp filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 11827458 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 8 name tftpboot filetype 2
> errors 6, no dir index, no inode ref
> ERROR: child eb corrupted: parent bytenr=3D499748732928 item=3D17 paren=
t
> level=3D3 child level=3D0
> root 5 inode 14435353 errors 2001, no inode item, link count wrong
>     unresolved ref dir 131327 index 0 namelen 4 name s0be filetype 2
> errors 6, no dir index, no inode ref
> ERROR: child eb corrupted: parent bytenr=3D499752206336 item=3D17 paren=
t
> level=3D3 child level=3D0
> root 5 inode 14646004 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 4 name s0be filetype 2
> errors 6, no dir index, no inode ref
> ERROR: child eb corrupted: parent bytenr=3D499748732928 item=3D17 paren=
t
> level=3D3 child level=3D0
> root 5 inode 14910590 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 13 name .bash_history
> filetype 1 errors 6, no dir index, no inode ref
> root 5 inode 23438027 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 8 name mknod.sh filetype 1
> errors 6, no dir index, no inode ref
> root 5 inode 25548332 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 8 name ctrl_dir filetype 1
> errors 6, no dir index, no inode ref
> root 5 inode 25548333 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 5 name state filetype 1
> errors 6, no dir index, no inode ref
> root 5 inode 26407893 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 6 name e2fsck filetype 1
> errors 6, no dir index, no inode ref
> root 5 inode 36767707 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924630 index 0 namelen 31 name
> lib_mysqludf_log-warnings.patch filetype 1 errors 6, no dir index, no
> inode ref
> root 5 inode 36767712 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924632 index 0 namelen 32 name
> lib_mysqludf_stem-mysql_m4.patch filetype 1 errors 6, no dir index, no
> inode ref
> root 5 inode 36767838 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924633 index 0 namelen 33 name
> mysql-udf-base64-signedness.patch filetype 1 errors 6, no dir index,
> no inode ref
> root 5 inode 36767839 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924633 index 0 namelen 20 name
> mysql-udf-base64.sql filetype 1 errors 6, no dir index, no inode ref
> root 5 inode 36767840 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924634 index 0 namelen 27 name
> mysql-udf-http-stdlib.patch filetype 1 errors 6, no dir index, no
> inode ref
> root 5 inode 36767843 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924635 index 0 namelen 29 name
> mysql-udf-ipv6-warnings.patch filetype 1 errors 6, no dir index, no
> inode ref
> root 5 inode 37030378 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924616 index 0 namelen 12 name metadata.xml
> filetype 1 errors 6, no dir index, no inode ref
> root 5 inode 37030384 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924619 index 0 namelen 12 name metadata.xml
> filetype 1 errors 6, no dir index, no inode ref
> root 5 inode 37030490 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924625 index 0 namelen 12 name metadata.xml
> filetype 1 errors 6, no dir index, no inode ref
> root 5 inode 37030492 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924626 index 0 namelen 12 name metadata.xml
> filetype 1 errors 6, no dir index, no inode ref
> root 5 inode 37030497 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924628 index 0 namelen 12 name metadata.xml
> filetype 1 errors 6, no dir index, no inode ref
> root 5 inode 39198776 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 8 name bootback filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 51520157 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924616 index 0 namelen 29 name
> lib_mysqludf_log-0.0.2.ebuild filetype 1 errors 6, no dir index, no
> inode ref
> root 5 inode 51520163 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924619 index 0 namelen 30 name
> lib_mysqludf_stem-0.9.1.ebuild filetype 1 errors 6, no dir index, no
> inode ref
> root 5 inode 51520278 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924625 index 0 namelen 32 name
> mysql-udf-base64-20010618.ebuild filetype 1 errors 6, no dir index, no
> inode ref
> root 5 inode 51520280 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924626 index 0 namelen 25 name
> mysql-udf-http-1.0.ebuild filetype 1 errors 6, no dir index, no inode
> ref
> root 5 inode 51520284 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924628 index 0 namelen 25 name
> mysql-udf-ipv6-0.4.ebuild filetype 1 errors 6, no dir index, no inode
> ref
> root 5 inode 58792107 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name foo filetype 1
> errors 6, no dir index, no inode ref
> root 5 inode 63681251 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 4 name xpra filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 66715793 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 8 name .viminfo filetype 1
> errors 6, no dir index, no inode ref
> root 5 inode 71469207 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924616 index 0 namelen 8 name Manifest filetype
> 1 errors 6, no dir index, no inode ref
> root 5 inode 71469208 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924619 index 0 namelen 8 name Manifest filetype
> 1 errors 6, no dir index, no inode ref
> root 5 inode 71469238 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924625 index 0 namelen 8 name Manifest filetype
> 1 errors 6, no dir index, no inode ref
> root 5 inode 71469239 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924626 index 0 namelen 8 name Manifest filetype
> 1 errors 6, no dir index, no inode ref
> root 5 inode 71469240 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924628 index 0 namelen 8 name Manifest filetype
> 1 errors 6, no dir index, no inode ref
> ERROR: child eb corrupted: parent bytenr=3D499748732928 item=3D65 paren=
t
> level=3D3 child level=3D1
> root 5 inode 75334150 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 7 name lib.new filetype 2
> errors 6, no dir index, no inode ref
> parent transid verify failed on 499774287872 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774291968 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774296064 wanted 3323349 found 33233=
40
> root 5 inode 77351088 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name lib filetype 7
> errors 6, no dir index, no inode ref
> ERROR: errors found in fs roots
>=20
> Starting repair.
> Opening filesystem to check...
> Checking filesystem on /dev/sda3
> UUID: 815266d6-a8b9-4f63-a593-02fde178263f
> cache and super generation don't match, space cache will be invalidated=

> reset isize for dir 256 root 5
> reset isize for dir 131327 root 5
> reset isize for dir 924616 root 5
> Moving file 'lib_mysqludf_log' to 'lost+found' dir since it has no vali=
d backref
> Fixed the nlink of inode 924616
> reset isize for dir 924619 root 5
> Moving file 'lib_mysqludf_stem' to 'lost+found' dir since it has no
> valid backref
> Fixed the nlink of inode 924619
> reset isize for dir 924625 root 5
> Moving file 'mysql-udf-base64' to 'lost+found' dir since it has no vali=
d backref
> Fixed the nlink of inode 924625
> reset isize for dir 924626 root 5
> Moving file 'mysql-udf-http' to 'lost+found' dir since it has no valid =
backref
> Fixed the nlink of inode 924626
> reset isize for dir 924628 root 5
> Moving file 'mysql-udf-ipv6' to 'lost+found' dir since it has no valid =
backref
> Fixed the nlink of inode 924628
> reset isize for dir 924630 root 5
> reset isize for dir 924632 root 5
> reset isize for dir 924633 root 5
> reset isize for dir 924634 root 5
> reset isize for dir 924635 root 5
> Trying to rebuild inode:1442047
> Trying to rebuild inode:1835263
> Trying to rebuild inode:1966335
> Trying to rebuild inode:2097407
> Trying to rebuild inode:2228479
> Trying to rebuild inode:2359551
> Trying to rebuild inode:3145983
> Trying to rebuild inode:3277055
> Trying to rebuild inode:3408127
> Trying to rebuild inode:3539199
> Trying to rebuild inode:3670271
> Trying to rebuild inode:4587775
> Trying to rebuild inode:4980991
> Trying to rebuild inode:4984678
> Trying to rebuild inode:5505279
> Trying to rebuild inode:5767423
> Trying to rebuild inode:5898495
> Trying to rebuild inode:6029567
> Trying to rebuild inode:6431345
> Trying to rebuild inode:6553855
> Trying to rebuild inode:7602431
> Trying to rebuild inode:9133291
> Trying to rebuild inode:9133292
> Trying to rebuild inode:9980485
> Trying to rebuild inode:10254180
> Trying to rebuild inode:11827458
> Trying to rebuild inode:14435353
> Trying to rebuild inode:14646004
> Trying to rebuild inode:14910590
> Trying to rebuild inode:23438027
> Trying to rebuild inode:25548332
> Trying to rebuild inode:25548333
> Trying to rebuild inode:26407893
> Trying to rebuild inode:36767707
> Trying to rebuild inode:36767712
> Trying to rebuild inode:36767838
> Trying to rebuild inode:36767839
> Trying to rebuild inode:36767840
> Trying to rebuild inode:36767843
> Trying to rebuild inode:37030378
> Trying to rebuild inode:37030384
> Trying to rebuild inode:37030490
> Trying to rebuild inode:37030492
> Trying to rebuild inode:37030497
> Trying to rebuild inode:39198776
> Trying to rebuild inode:51520157
> Trying to rebuild inode:51520163
> Trying to rebuild inode:51520278
> Trying to rebuild inode:51520280
> Trying to rebuild inode:51520284
> Trying to rebuild inode:58792107
> Trying to rebuild inode:63681251
> Trying to rebuild inode:66715793
> Trying to rebuild inode:71469207
> Trying to rebuild inode:71469208
> Trying to rebuild inode:71469238
> Trying to rebuild inode:71469239
> Trying to rebuild inode:71469240
> Trying to rebuild inode:75334150
> Trying to rebuild inode:77351088
> found 89594781696 bytes used, error(s) found
> total csum bytes: 0
> total tree bytes: 108093440
> total fs tree bytes: 53248
> total extent tree bytes: 107958272
> btree space waste bytes: 36265970
> file data blocks allocated: 27983872
>  referenced 27983872
>=20


--CL2qAib9nnT137jXJlEb53AQV1oWCz1cG--

--vOPJgCEZzxntg1XYYPCxpntYvEPHbADLZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4JvswXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qg95Af/VXfFWdaZjnLMuv5X84fKgRMd
SvRgTksPlqUEGhN5/rEb4pftQ/7tRCDm+dp3tevuQtr3bsWl7rnt1+JDJrmK/p1u
zHk+BVyb+gd9RC3qL5W9gKIBGirHNftYCKQw/GBgesXECeiD95xTS4EKxE87/rLg
HaD/eP3VI5k62YzWKEJSITL0NfOVguD4O7twosR1PZ17ujNdnnT4Cjl3QnS8StIf
i2O8eZ8JSdVPs/YcN+vbSt4C9tItsMK2ztTo6AyY3LCpskjka8Q5gppPEG22Vadl
M7NBfJmTJW+P6sRU3qgfWULvqGr3m51tXNc4MccIddBjdIMX86Df2qMRgEt89Q==
=6OcS
-----END PGP SIGNATURE-----

--vOPJgCEZzxntg1XYYPCxpntYvEPHbADLZ--
