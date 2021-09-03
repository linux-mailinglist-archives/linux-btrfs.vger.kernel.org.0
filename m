Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33823FFAB5
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 08:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346964AbhICGyf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 02:54:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:50521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346291AbhICGye (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Sep 2021 02:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630652012;
        bh=PTBg3x3lCQ2VR1pNiqw6Dt8zYARm9zHlHpmetj3eMXY=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=cgJrrgOnZbelurzl8iMro9e5FCk9CcRFCkOkNdx2KyQTH3KEFNuSu+6wH5/yS1Ylh
         3eIAqOiFw9xrz/sfpiGqKYWrBIE5XFMsoFEEylkXAYouqdTfNvIcoYHPMQ2GbzPO/j
         qbt6lxytvfrSYBXrTm7tedTE5HfYfZ/jWnC84FkI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUXpK-1mUoUF3sJ6-00QX7v; Fri, 03
 Sep 2021 08:53:32 +0200
Subject: Re: Next steps in recovery?
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Robert Wyrick <rob@wyrick.org>, linux-btrfs@vger.kernel.org
References: <CAA_aC9-ZAdGC15HY-Q0S-N2M1OukST5BjAk9=WsD+NArCkCFUA@mail.gmail.com>
 <3139b2df-438c-ba40-2565-1f760e6d1edb@gmx.com>
Message-ID: <9c2afb5f-e854-d743-3849-727f527e877b@gmx.com>
Date:   Fri, 3 Sep 2021 14:53:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3139b2df-438c-ba40-2565-1f760e6d1edb@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cLYpZa+FP4fLfpku2t82IOBqo4Tu5oRP9UvBR/CHqFyDEzZT1W+
 6YUW6HFEbabKCRm20jjiDVsrf5i81YxOR415YmZIVeTKRSxSLf6h2YUfOUz6rTijgGQmdxm
 WcKwr5+Q1X+5LAquKEzX/vLYGqlhWFTOl3CE8rV5n+gYaBjsorJiBxhPKsv2f9NplL1r5CL
 CvkVH7bKD9g7Gf6aqmp1g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:r0wr6muXDik=:tocRQ7xQvz7PL+llhBeaIk
 ya7FOYSLn3dj4Rg/8M7RNTV1ahZ80nLjP8CnN95Nc9NEe9FkgYWbZia/HccP2chWYXWl5J4Bq
 rJT9v+y7eLyzKomwf2XQMA9IeRHvdLXbrcRy27+RFcrI6X6YyjOVReEYGGrq6kn3xeY2TFz5l
 PbDh8xBScIo0kAFVJKs5RVMwKmmioT2FAVbmsUT8SGGR6BNPH8/NhtEXm8j38aOgcutSGE074
 0bqaU47/l23uWrJS9AAN3f1hzQFmRUveBiDKPzH4Qo5yywn8gZquwswittmyE8nP3vSD7xzTt
 aLpCaO2AEx59wGGvSBlpxdAbav9Q/dym4JwQOldxKRCrGG6uLZfugIjNAsvdVs7ELfuFRSZ/p
 rZPfh5D1TnT5rJd4lrF+mlwDPi5LXc6aJuoaZKG9Et5wAQE4qzDS1FH7Ys1tmbZ2qvqttWPMw
 U3ZhhTRM8RlRsQejQvdIYC6J7szspN4/ENslrycUyh6PB7LvHciv53T1k7gorYihDcYE7xEiX
 XBuGouMvLDvW6I7xATdXbRfSVUA/JBcdT5RsDvIGnc8QN4vSrqE1GHK6uK1JS+GBwfNqE0LWT
 ngdZ9VpQDq7oYNZIdyb6zb0B3XmsIYXTS+v+BUrpV+OiGplPVd+5T465ulDHCPW24r9UhPTs6
 IU2XjLAZyDVgKCH1T7+T4Fx6Qd1o75C4ax0/88xHf8lSNHdHE/+Mbs+8Z19+7hFgxkYWdp1pv
 6aGRj7Fy8Ymx7b/tIIc2uvYGbHQLW4qbOF/JX7HMSQexbzJ9ur7L+LoYDOZ3+rHdsS8RD0bzJ
 dtwIEmn4NlNYzpKXnILcBJh9HlBZwS5CQ4myp9dHI7VVC0gjZt4Q708028nqiyawr9S+LATyI
 C6iLse8j/GCJAN1D+Ftbuz7kH3V9IJv7N2pgtmgDcey4otEpJE36CcqqW3f/msZr1ydA45hIj
 QQ7sbtWHFEGit9MRi1Nkru8lI2TIq51yi0mcHS9TSrPz5GJwqqIAfoYOIlDWOl5gbsjobUdA+
 oeucNMk/7XthqtcRf37Oheuxjc+fJvkPqPgZ08YnzoDclSRFGnkmVQhjEX8ATBLUH/Gdvanwx
 NBWe6UW8xeIeGidWKo25T1GI4RVnsLXwmttJYS59fO2LsrNG0tn3qzeJQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/3 =E4=B8=8B=E5=8D=882:48, Qu Wenruo wrote:
>
>
> On 2021/9/3 =E4=B8=8A=E5=8D=8810:43, Robert Wyrick wrote:
>> I cannot mount my btrfs filesystem.
>> $ uname -a
>> Linux bigbox 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed Aug 11
>> 15:58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>> $ btrfs version
>> btrfs-progs v5.4.1
>
> The tool is a little too old, thus if you're going to repair, you'd
> better to update the progs.
>>
>> I'm seeing the following from check:
>> $ btrfs check -p /dev/sda
>> Opening filesystem to check...
>> Checking filesystem on /dev/sda
>> UUID: 75f1f45c-552e-4ae2-a56f-46e44b6647cf
>> [1/7] checking root items=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (0:00:59 elapsed,
>> 2649102 items checked)
>> ERROR: invalid generation for extent 38179182174208, have
>> 140737491486755 expect (0, 4057084]
>
> This is a repairable problem.
>
> We have test case for exactly the same case in tests/fsck-test/044 for i=
t.

Oh, this invalid extent generation is already a more direct indication
of memory bitflip.

140737491486755 =3D 0x8000002fc823

Without the high 0x8 bit, the remaining part is completely valid
generation, 0x2fc823, which is inside the expectation.

So, a memtest is a must before doing any repair.
You won't want another bitflip to ruin your perfectly repairable fs.

Thanks,
Qu
>
>
>> [2/7] checking extents=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (0:02:17 elapsed,
>> 1116143 items checked)
>> ERROR: errors found in extent allocation tree or chunk allocation
>> cache and super generation don't match, space cache will be invalidated
>> [3/7] checking free space cache=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0:00:00 elapsed)
>> [4/7] chunresolved ref dir 8348950 index 3 namelen 7 name posters
>> filetype 2 errors 2, no dir index
>
> No dir index can also be repaired.
>
> The dir index will be added back.
>
>> unresolved ref dir 8348950 index 3 namelen 7 name poSters filetype 2
>> errors 5, no dir item, no inode ref
>
> No dir item nor inode ref can also be repaired, but with dir item and
> inode ref removed.
>
> But the problem here looks very strange.
>
> It's the same dir and the same index, but different name.
> posters vs poSters.
>
> 'S' is 0x53 and 's' is 0x73, I'm wondering if your system had a bad
> memory which caused a bitflip and the problem.
>
> Thus I prefer to do a full memtest before running btrfs check --repair.
>
> Thanks,
> Qu
>
>> [4/7] checking fs roots=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (0:00:42 elapsed,
>> 108894 items checked)
>> ERROR: errors found in fs roots
>> found 15729059057664 bytes used, error(s) found
>> total csum bytes: 15313288548
>> total tree bytes: 18286739456
>> total fs tree bytes: 1791819776
>> total extent tree bytes: 229130240
>> btree space waste bytes: 1018844959
>> file data blocks allocated: 51587230502912
>> =C2=A0 referenced 15627926712320
>>
>> I've tried everything I've found on the internet, but haven't
>> attempted to repair based on the warnings...
>>
>> What more info do you need to help me diagnose/fix this?
>>
>> Thanks!
>> -Rob
>>
