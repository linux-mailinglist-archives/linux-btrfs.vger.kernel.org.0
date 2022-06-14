Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDC754B1A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 14:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbiFNMrz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 08:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbiFNMrv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 08:47:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A8226131
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 05:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655210858;
        bh=sGVS7+7qMOZQY2ZXdCrmoIDdJ93cVaQNRkM3TXPkOwQ=;
        h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
        b=Z8QdSmcgO//uUUj+YqZNJi+GYNtjVgnd4FuP0S+SbcXgE/xll19yM8vsX4rU9mEUS
         Qj5aOqzOIU1A1DsgLXNHOGBJOI22nNOoQ/q5IRpHPMkYgK19OqTWQ0hMcJ9ZtsRbsO
         sSySCNM1wBWU+VIVVDMEQ8ntQTr8VVvoQdQCzJQU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N33Ib-1nZqit0FqP-013RNp; Tue, 14
 Jun 2022 14:47:38 +0200
Message-ID: <a5c85ecd-b4cb-8b19-a855-978880fdeeab@gmx.com>
Date:   Tue, 14 Jun 2022 20:47:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 12/19] btrfs-progs: set the number of global roots in
 the super block
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Josef Bacik <josef@toxicpanda.com>, dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <cover.1646690972.git.josef@toxicpanda.com>
 <1c28a05081455379be5d91ee760f9a03e4255e6a.1646690972.git.josef@toxicpanda.com>
 <20220308161951.GN12643@twin.jikos.cz>
 <PH0PR04MB741601104CC2D56A2EF3C02C9B099@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220309170553.GY12643@twin.jikos.cz>
 <YikapaHhZ41AFcmj@localhost.localdomain>
 <6b62ea59-02d9-0a0a-11b3-a6bf1c18437d@gmx.com>
In-Reply-To: <6b62ea59-02d9-0a0a-11b3-a6bf1c18437d@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oMfV3QPAcd4Q4IsLUp/aw97tArtvhJFYzPZthjoutuhRs+azFoO
 gBqF/J/KO/Xo8G/X5IxoZdbGmPjES4rNxRKnqnHS+fMIp4nc4U6J3m0OLwsE9t9kTnh22Wx
 Z5ZVVBGVT4QRR4yRDmkQ+zpimkxwRkJRkA0p3lzsJ5i59ty951P9uPRz6wwCOOj4jffgyrM
 LK9DknZowuQHbDVDmhFNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0eRptmLclzw=:jFh72FGj9ypPXOTojheTCR
 hu4axHf5y7opN1x9mKjvGzfVEM9fjTnrfOLAjE6k5dU1aJ1e49GnFVY3j5jAygLGLreehGd07
 txyIZPGMMbftgMkNgum3m2c2x7hhV3EjUy+cTpXhc62cJU8aVSOJi9RsONeT/muVNrwSml8HP
 iBszkGB240yP5DLu/3toLR1pNma1cVtdWkmlHmqEOiwE4JBNYze7Au5p/fvj4P2QHl9/bkiIX
 13LM8irMZFPiKUOOoA3718vDEe7gp7QBvvbCGQT7dYhpWYVNgdriMongKjhAcMyq6ldbkKpwN
 eZgU7xdoCwViXvc+BMJw9XIg4F09bKpVearI4e0UN79R7/ZYN1rZS8f4TqU0sBXpLeDDW9TO1
 ArGcAgx/rjLBi5cwp2Pjyve7E80ywxWGiTEG3uVIYQRpkSHHakzw7Hm60lFfoZJQoqmY07qMt
 9IDLzj6ihvkobGFV36jvr+L9L3CCM6Tu8qLCFcCsYVRkogzckf0pUAPgdlqQmrw1ekZ3IDDUc
 +7VQ6k7RXuigD7HmIPQh6WrEqbd2rzEbJygJC8qiz792/uLf7fwu0NhP3NimDU8wdFpCZ05Zh
 GP2blfE52vn7ppmcLwFkcCYVuruPZcx9E1q0cUlydoozYYoURjPv2noQ9A8YbSX2zVNh1wsDQ
 CTH193xfw5RJfXlB7ZuC4smzK/0FW3YfB9gD88Dml4dxYjZmFMmnzt1Zhw0d+vAgh8ZifGDrk
 Grem+5odKU3sLP+brWePyMiDV14YV7xb2ZPjJeY570DTqUjOeAXpjBo9hnJUsA9I2N36lU/VX
 WQBDxHVaMTZ+OzyY/2W6hO2yIY9dscQSgz2W71b4MMfp2EIxGWJvGM5P9YNV24/hcHihnDSBr
 wQMyhjUVuC2Lh0sIVFZ/eqLKIVZ28N+ei3TpFTcYFS0QXG1pKhmAKyEnpfz2kxtIt+XM+9Kn5
 BJyzQFdE5idWkVoVpWGvRo+kV/sc9jzj+lX5HTGbLiP35faT3a+Ww/3HiFE/a99EUdYqgAhac
 u52b+G2LBrKhUq8CieSb0bpuOAhseim1Mcibj00NEd1q6CDjhs/jKi15fKL80tTMI9CHBR4Y2
 cHaNY9oV6xrKSBis0jcapDprEegkkZRXg/vzTfmd4RZNaBF5B0Typ8cgA==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/14 20:15, Qu Wenruo wrote:
>
>
> On 2022/3/10 05:22, Josef Bacik wrote:
>> On Wed, Mar 09, 2022 at 06:05:53PM +0100, David Sterba wrote:
>>> On Tue, Mar 08, 2022 at 04:41:44PM +0000, Johannes Thumshirn wrote:
>>>> On 08/03/2022 17:23, David Sterba wrote:
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 metadata_uuid[BTRFS_FSID_SIZE];
>>>>>>
>>>>>> +=C2=A0=C2=A0=C2=A0 __le64 nr_global_roots;
>>>>>> +
>>>>>
>>>>> Shouldn't this be added after the last item?
>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __le64 block_group_root;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __le64 block_group_root_generation;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 block_group_root_level;
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* future expansion */
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 reserved8[7];
>>>>>> -=C2=A0=C2=A0=C2=A0 __le64 reserved[25];
>>>>>> +=C2=A0=C2=A0=C2=A0 __le64 reserved[24];
>>>>
>>>> Or at least inside one of these reserved fields.
>>>
>>> OTOH, it's still experimental so we don't expect backward compatibilit=
y
>>> yet so it should be ok to change for now.
>>
>> I did it this way because it's all still experimental and it makes
>> more sense
>> for it to be before the new root stuff.=C2=A0 Thanks,
>
> I'd say, please don't.
>
> It's making anyone who want to add a new member in super block miserable=
.
>
> Everyone is going to add the new member from the reserved members, but
> such insert into the existing members are destructive.
>
> Furthermore, if the new member is going to be merged way before extent
> tree v2 part, how do we solve the conflicts?
>
> (The new member I want to introduce is just to indicate how many bytes
> we have reserved at the beginning of each device, with a new RO compat
> flag).

My bad, the main problem is not shuffling the members of extent tree v2,
but out-of-sync between kernel and btrfs-progs for super block.

Anyway, I'd use the padding[] for my new members, to avoid possible
out-of-sync problems.

Thanks,
Qu
>
> Thanks,
> Qu
>>
>> Josef
