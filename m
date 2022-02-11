Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF44A4B1DE9
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 06:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbiBKFbW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 00:31:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiBKFbW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 00:31:22 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84990BE4
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 21:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644557479;
        bh=pPQSOupyiDcudm2J0SYMWq5nugv0HwyjXlc13cjCiSc=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=OvG5oO82VvnCnvq+FIzo/6SONd8tzwwUr1RcXiMsoB7Oku2K55CpDipiSEMuS2z7J
         Zcwq7urKOZNaM38aIFCEeLx2Fze3lP/8oCmjLd40Ea7BbGdHIBjtlG5bEcJi9QqbmM
         KXtNld8afg9qTIjbG/RUVqMJRYURoyUoJyNE55rQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Ml6mE-1o1K7G1yFY-00lVtT; Fri, 11
 Feb 2022 06:31:19 +0100
Message-ID: <dbe39a73-9366-9f95-a3af-3dea7f1dd1ae@gmx.com>
Date:   Fri, 11 Feb 2022 13:31:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <9f936d59-d782-1f48-bbb7-dd1c8dae2615@gmail.com>
 <ecd46a18-1655-ec22-957b-de659af01bee@gmx.com>
 <65e916e1-61b4-0770-f570-8fd73c27fe03@gmail.com>
 <3a654f5d-e210-5c3e-4bcf-f0eae626cde2@gmx.com>
 <c75599fa-3b4e-5a5a-c695-75c99b315a06@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Used space twice as actually consumed
In-Reply-To: <c75599fa-3b4e-5a5a-c695-75c99b315a06@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9I8H6Lr8EuH2AoaUAXPNypxhjS/R05zYE8e+ZtxoihJGcTLcIzv
 WDAdMHWf8jjQnZreteMSnXebddWPXA60teI7UHx7ceVl5qtUf/pVdS4Z7cLB2dm9xPf/3u8
 s3AzgnhxaoxbUqbvqJuEvXIdkaBclT5zbKnWs7QCuirtTAfFrO7iZdmYmMXvZbraVNytkW/
 rvSMYjmuSQtiDFoF/HtrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y30mbCxawNw=:UwO8U+s9NIS0BnBNvw5pJn
 NI5mZWya177iFmCvnYZFEBDHHR/MP4MVnM6HWvyfbCSCB0mkGz/1JX+MxFziozMWVqImm9jFv
 E/ByfSV2aMQbDmv2phrtKSK7YUnaaAvv7lvO1aPgzuN69xrVl8jzG4BaxnPbZHrM3a3X45z1b
 RkzdeSZnSG/JchoLSINrCc1KH6wt5kv1gqTvsu0m17cKlXGS0z+udaJdPzp10sijtHCM/ZsY/
 hgqO54Gjx4tJJnwQSHVrzdAytWT0mc9I/Ehm6nWFqWVir0LVH+rZnFZYkhgSGAHLZtK/1ScmU
 dnriN4v2P7KakmCYSA2r1wrICpxoxcKOPiDjCv5b2V8/D+e9CWdhxQI1RE1sL6FPMkC1DMeGL
 WXCYMi+QxVTmQzlViQBH+cypLroYAL9o+BdZfl5ZCnSjoR0fKezRRXlQNCPW+9v989qiT8K8x
 874oQYTrDdBjRpf6qMIhVNfuq4hPJEsPTfvdKQQI5apwvf4dVoDwM06hvFPhQZu26d4OALeyh
 G78hAfIA1yETmAnYtioGjHXF16xZ4mzRZ10xyQdjmZI3UthIP0HX9LOtVt6nM81Eil2/UuC5Q
 u4Yh26NPU4WgBroyE7hxixW/hsj1p6MRYrhioK54skY2R+V0Jm5nbgU5uu7/0MtG0EuMmoux3
 bAbdirb6xemQjLKm6xygd0jRjFmz5u+skQ7Pz/I033AQMLvIJYam9P8ANl5u3Iedbbv/dTVmu
 sLy588veiKIZCD3/o+Q1uvYLgrgXy6PrMSUtl4ZLdJSJ/YoL2SPzVYZRPRibUN5Rld2QRZaKy
 dkSfT/4wGSZo6H9LmegJOfWKtCX3C6NCDdR6B7iUEddRWx8a8PLofFLngBeo3E3KMObVV+Amc
 fgGX7ywPybHmq7IAtjmmXxiGp+tUOtSc8A119qLZWgdK3B1Z/JyBbdG7Xc7VS8vxk2A5qYLdb
 zQK+MNhlgHPkhOeahjKZJn6a1PGRBLV6OVAS3EHEstxxf9n3W7KklezKZfNDEas5ChidJMPqN
 y4oJHFFyKMAun9xtebWoYleJDU7Cn2NZP7BK4rf8sUJEczs644Lpc1eGIFoW3LNC/BjaMgCVJ
 MW7yat+MD4JVms=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/11 13:02, Andrei Borzenkov wrote:
> On 11.02.2022 07:48, Qu Wenruo wrote:
> ...
>>>>>
>>>>> This apparently was once snapshot of root subvolume (52afd41d-c722-4=
e48-b020-5b95a2d6fd84).
>>>>> There are more of them.
>>>>>
>>>>> Any chance those "invisible" trees continue to consume space? How ca=
n I remove them?
>>>>
>>>> They are being dropped in the background.
>>>> You can wait for them to be completely dropped by using command "btrf=
s
>>>> subvolume sync".
>>>>
>>>
>>>
>>> It returns immediately without waiting for anything
>>>
>>> bor@tw:~> sudo btrfs subvolume sync /
>>>
>>> bor@tw:~>
>>>
>>>
>>> Also
>>>
>>> bor@tw:~/python-btrfs> sudo ./bin/btrfs-orphan-cleaner-progress /
>>>
>>> 0 orphans left to clean
>>>
>>>
>>>
>>> btrfs check does not show any issues.
>>
>> There used to be a bug that some root doesn't get properly cleaned up.
>>
>> To be sure, please provide the following dump:
>>
>> # btrfs ins dump-tree -t root <device>
>>
>> Thanks,
>> Qu
>
>
> btrfs-progs v5.16
>

There are two "ghost" subvolumes still there:

	item 72 key (1331 ROOT_ITEM 82831) itemoff 6938 itemsize 439
		generation 87340 root_dirid 256 bytenr 8514846720 byte_limit 0
bytes_used 313589760
		last_snapshot 82969 flags 0x1000000000001(RDONLY) refs 0
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 87340
		uuid f2a928cf-d243-774b-b2bb-4e80e3d37bdf
		parent_uuid 52afd41d-c722-4e48-b020-5b95a2d6fd84
		received_uuid 00000000-0000-0000-0000-000000000000
		ctransid 82830 otransid 82831 stransid 0 rtransid 0
		ctime 1614330605.649484116 (2021-02-26 09:10:05)
		otime 1614330616.574128143 (2021-02-26 09:10:16)
		stime 0.0 (1970-01-01 00:00:00)
		rtime 0.0 (1970-01-01 00:00:00)


	item 73 key (1332 ROOT_ITEM 82904) itemoff 6499 itemsize 439
		generation 87340 root_dirid 256 bytenr 8515452928 byte_limit 0
bytes_used 313589760
		last_snapshot 82969 flags 0x1000000000001(RDONLY) refs 0
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 87340
		uuid b9125452-fb5d-e14d-a79e-2a967b992ea1
		parent_uuid 52afd41d-c722-4e48-b020-5b95a2d6fd84
		received_uuid 00000000-0000-0000-0000-000000000000
		ctransid 82904 otransid 82904 stransid 0 rtransid 0
		ctime 1614539496.823057032 (2021-02-28 19:11:36)
		otime 1614539499.212006544 (2021-02-28 19:11:39)
		stime 0.0 (1970-01-01 00:00:00)
		rtime 0.0 (1970-01-01 00:00:00)

Their timestamp should give an hint on which kernel is affected.

I remember I submitted some patches for btrfs-progs to detect such
problem and even kernel patches to remove such ghost subvolumes.

But none of them seems get merged yet.

You can try the following patchset.

https://patchwork.kernel.org/project/linux-btrfs/cover/20210625071322.2217=
80-1-wqu@suse.com/

Then btrfs-check should be able to report such problem and --repair
should be able to fix it.

Thanks,
Qu
