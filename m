Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E8F1404DA
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 09:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgAQIGi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 03:06:38 -0500
Received: from mout.gmx.net ([212.227.15.15]:52737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbgAQIGh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 03:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579248000;
        bh=41nz2FT0kF2RA1Mk6cUEAOucM9qdkVZlSvZ8Unu69qc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lz9N/MUTx31WHf62pCyhCTBF1AdPy6gUPGHgx4FU/agjCP9vvuD1pwJEKfO9vGusD
         AMVhR0bXQP9MC/MKqqIHH9E1O9bpvpUshO/GwgiQlBHa+NNHkT45EAhL4O1+UVDRgC
         LrXjnDCNz7CMbjxSAbgzJb78rRB4ce/3H1vq1ToM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MIdeR-1iom1y3GXF-00Eaqn; Fri, 17
 Jan 2020 09:00:00 +0100
Subject: Re: read time tree block corruption detected
To:     Peter Luladjiev <luladjiev@gmail.com>,
        Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CA+ZCqs6w2Nucbght9cax9+SQ1bHitdgDtLKPA973ES8PXh1EqQ@mail.gmail.com>
 <6ba43f60-22d1-52da-0e9a-8561b9560481@suse.com>
 <CA+ZCqs5=N5Hdf3NxZAmPCnA8wbcJPrcH8zM-fRbt-w8tL+TjUQ@mail.gmail.com>
 <53da4b02-6532-5bb9-391c-720947bac7f1@suse.com>
 <CA+ZCqs4pTKePM4NaStAs=CWYBZbA_btqip1WiU8DC6DL13Eh_Q@mail.gmail.com>
 <CA+ZCqs5hLS3ekUpU8TTJq6UP9rjPYZjBwVYcC4xJcaMXuvSudQ@mail.gmail.com>
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
Message-ID: <70cf34c3-a035-bf60-6920-59cc0c6cc329@gmx.com>
Date:   Fri, 17 Jan 2020 15:59:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CA+ZCqs5hLS3ekUpU8TTJq6UP9rjPYZjBwVYcC4xJcaMXuvSudQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LmkXEgOqsrL/tRBDabZldX3CbgbtlSpw01+IQJD+dTPPJcEFOKg
 +/awMIazDTZLaYvpkrpan+jIMNrTNYO4tofj/gqzPs6OJLiNKaGzAdA+SG78Sh1N3eHNGgB
 nN3BuZbCa0pbno80v4IcSWHQYda9X2Gq0mdqi/J1Hn9rBT8pg1tSXa6cIIQM78I+PM/mqlP
 xZEberblVcK0v61gxnH0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2etCY83QMFo=:O3Y/aHtwf5Dh6cRC5+Fzti
 hrk1PL8AMqWGgheJzAvgZXoqHH24ok6Qj6vFDb5y/QnwG8MuVXVH4MA7dVG0HohbNd0nAZDqu
 fxZRUCiQojKvF/sjMwQbRbyj51cBWrWtU6X2hnhmT65EelDu5IGO6GtjlMAv+16+GVw6gntoh
 g8WSi/O4thtpq7uP7pqo5hWbP2rrKq+Ushippd1EcsXoleSlGptK8n/L2DlAP4kjlOvavi29u
 k5Gm3RgJq9drKYXobjKBiQve2Y5J7KStisuCYfWyyokCYjwsuKJOEGH1RSF50E8+5wFEzXyB6
 sIwl//dVh5GupaZ3nEJPuXavWmkLOg4WN/fAoct9ktyiCepf++PlC0UwqNQMRr326qc9osyvw
 RE09XNoMehgSHz7IJh+Ui+MQ2dNXLUcRsnk4URKkt3ELVNtjuiN8RdmeQxs+eGc+AdyROS+8t
 jkw3nyLZ/AXMpj74Qqvd+2QHxrNeCYXQi9SrBQ3NojJ7RayQ1Y/dVfo+Ffr6hj+7uX0OPl3Le
 cj9ifLR3hypq3u9U7vHrqSVthLFRId1TJFJy8HebA95uTzTirTU8dlqmSd/Lrlw51sl4aCwss
 umlYCTQdhe5z/DzTJ20NyKx7IUAogW7JGTF8aPudLhGpvOoPiU5DDUjvXTAnM4BFT5qqYy0QX
 xBltzqWJ2UTn4RMO0dTnZmeoUd0JAMdBpUt0MSpk7WOfraS+uUBcksSJFUTYFRlE7KRD3oIm0
 cXP8XTJ9mgKWc23JauWAOeNUpDHlgZW8nCJ7Scl0eq0GDMEebS+W52myc290w0DiJCae9gh4i
 Q5nAtdruQbBssuLeSyvnr0c4h0qHahVjKRRodG4knriZujXW5uF6TX8olqRphfhR4zppgXfcS
 CgY2FDqw/spSZp/iQKV3GRhLThokokZrTpB95GHQxJ5vKxJhK1V9ubdRVkLMnUYeNJjBQVwCz
 1+JUuriFD3H4GbwyqpgUxedCU0EsqGnQM+dteXzaZMOfKcu9C/kNOzJMwfBSn7q6GqE21pM4U
 P+EMNvWac6jGq8lqADfZz2lHki9GKUId2xVEjK5wx+MX2CoJBsFcYU21//DlOq/n7ALq0fQEZ
 +siZnHzvh4dd5Ut0WzsCcvD/rPDeDu6Phj9YlusiB1z4iJ4v85WAfuTefzzgPqFDv7BgMc1tE
 OveZi3guPsPa+EpvJfqYaiWQdtBwrBwUhcei471qQieCzd6Tqgp929r1gcrSCvsNHjyaiYrgh
 j5UWY5V2Gb5LmaPYSknkeTusubZwCmD7/m4To0Euhi2tEQmMbftVVDULjwdg=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/1/17 =E4=B8=8B=E5=8D=883:54, Peter Luladjiev wrote:
> Should I run with repair flag?

Please only run --repair with the fs unmounted.

Thanks,
Qu

>
> On Fri, 17 Jan 2020 at 09:51, Peter Luladjiev <luladjiev@gmail.com> wrot=
e:
>>
>> Here is the output:
>>
>> btrfs check --force --mode lowmem /dev/mapper/system-root
>>
>> Opening filesystem to check...
>> WARNING: filesystem mounted, continuing because of --force
>> Checking filesystem on /dev/mapper/system-root
>> UUID: 9639a3e6-cd08-4270-b4d1-d2946d2b8d2e
>> [1/7] checking root items
>> [2/7] checking extents
>> [3/7] checking free space cache
>> btrfs: space cache generation (539645) does not match inode (539641)
>> failed to load free space cache for block group 22020096
>> btrfs: space cache generation (539645) does not match inode (539641)
>> failed to load free space cache for block group 1095761920
>> btrfs: space cache generation (539643) does not match inode (539640)
>> failed to load free space cache for block group 102161711104
>> [4/7] checking fs roots
>> [5/7] checking only csums items (without verifying data)
>> [6/7] checking root refs done with fs roots in lowmem mode, skipping
>> [7/7] checking quota groups skipped (not enabled on this FS)
>> found 53501751296 bytes used, no error found
>> total csum bytes: 43476196
>> total tree bytes: 1552203776
>> total fs tree bytes: 1422196736
>> total extent tree bytes: 70172672
>> btree space waste bytes: 276902557
>> file data blocks allocated: 331882188800
>>  referenced 105424904192
>>
>> On Fri, 17 Jan 2020 at 09:34, Nikolay Borisov <nborisov@suse.com> wrote=
:
>>>
>>>
>>>
>>> On 16.01.20 =D0=B3. 18:53 =D1=87., Peter Luladjiev wrote:
>>>> Hello, thanks for helping, here is the output:
>>>>
>>>> btrfs check --force /dev/mapper/system-root
>>>>
>>>> Opening filesystem to check...
>>>> WARNING: filesystem mounted, continuing because of --force
>>>> Checking filesystem on /dev/mapper/system-root
>>>> UUID: 9639a3e6-cd08-4270-b4d1-d2946d2b8d2e
>>>> [1/7] checking root items
>>>> [2/7] checking extents
>>>> ref mismatch on [1497018368 4096] extent item 72057183177116417, foun=
d 1
>>>> incorrect local backref count on 1497022464 parent 51611369472 owner =
0
>>>> offset 0 found 1 wanted 3087007745 back 0x564582174c70
>>>> backpointer mismatch on [1497022464 4096]
>>>> ERROR: errors found in extent allocation tree or chunk allocation
>>>> [3/7] checking free space cache
>>>> [4/7] checking fs roots
>>>> [5/7] checking only csums items (without verifying data)
>>>> [6/7] checking root refs
>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>> found 53532647424 bytes used, error(s) found
>>>> total csum bytes: 43476204
>>>> total tree bytes: 1551368192
>>>> total fs tree bytes: 1421295616
>>>> total extent tree bytes: 70238208
>>>> btree space waste bytes: 276638054
>>>> file data blocks allocated: 331679563776
>>>>  referenced 105423634432
>>>>
>>>
>>>
>>> Right so it seems this the only error. Just to be sure run btrfs check
>>> --mode lowmem  since it provides more readable output. If this is the
>>> only error in the filesystem then btrfs check --repair --mode lowmem
>>> should be able to fix it.
