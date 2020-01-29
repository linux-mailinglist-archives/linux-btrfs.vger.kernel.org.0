Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F05014C8FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 11:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgA2KvU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 05:51:20 -0500
Received: from mout.gmx.net ([212.227.15.18]:33713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgA2KvT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 05:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580295073;
        bh=2K6pofCVoFyhzDiiLwc6juiShxzT0DCD/s6Qv53nDV4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UuW+pYByUH1cMiD7eRX9nRsZ+TxMOwJ+5FL8BSNEwGgrATWGmEE1o3WYX5cvxLJ8R
         TQC7nU8nGo4WCannht2xFDAMkXSyxLWARjM2HCTTRr1BJFDq6FI8cCVBTbgVLDkagd
         h9abI4udsBKFWKqRNTMgdQ1UB4XA/2+WN/5+nyyA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mwwdl-1jlidW0XHv-00yRd4; Wed, 29
 Jan 2020 11:51:13 +0100
Subject: Re: [PATCH v6 0/4] Introduce per-profile available space array to
 avoid over-confident can_overcommit()
To:     Nikolay Borisov <nborisov@suse.com>, Qu WenRuo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>
References: <20200116060404.95200-1-wqu@suse.com>
 <55af2fa3-0762-3893-90b4-e0b90a225d27@suse.com>
 <52054f1b-bfed-d709-16c9-ce7007f6f3df@suse.com>
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
Message-ID: <793e5380-a510-ecd4-668f-7b51c6b11fc7@gmx.com>
Date:   Wed, 29 Jan 2020 18:51:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <52054f1b-bfed-d709-16c9-ce7007f6f3df@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EpZJSpSaFmMpNcHmemcwk8XRnGUvo2BkyNG95v+YR1uKhsLeDnp
 W24s5Cxl7I1EFfB3z+cConWcW3waKbh1m1+USxXsRyypr6k/P4IRW8AErx1Jb/3nvQJ6dU/
 9v3NQynruIXjjmJ/xGx07eyL3LCCvZVzbTrx1CsPEbXbKpBboGAxJjrVPAE8JaJg7Dtocm8
 jIBVR5qeExzeT6xni+e9A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:adXg1GrMw10=:SEVYmKjNxt93al4+TjKxiX
 HY7z39XkPuW88ubmmuUbOrylfFZyk9iMYAPnt1QdMYHXyhaWQ+xHz48o/KVliw1VhCQPAGAsR
 jE49vkNW9q+SP+Oy4XyJ75qUs1kxGtEJl3wkZFqpmZEw+GJ0sdb2EhysHmBMMwRWWXzQI7i3Q
 1Nt9Lc9nLHcYM3PseTamB+vjmkfnKkB6PCjD/OxwsBXUm8aBdZV8vY1fEIN0G+nOGnBbjqtBH
 J2QMO0WiwypA6ndkpTXqZqVJR57diJujv34jSj8tZ/vpGMbeGVshwPxrsEhJ6tvQ8i08kadRH
 fl9GlNp/S40HiPe4+oy1ef7BC1xzhaUFTipKghP71VhsWwUzTmFHkJn2/x9en8MHLFqES9f7Y
 ZoEyj/04kHlaSqSFRoLpPnJIP8jHy6nT9SGOm2lMZWj7EbcaGswBJLrncXelUSIxF2OXQd99Z
 ziBVdwOaivAsRBK624YTVdLr2gU9KpAsJHhBEThvEa4OIdntfndSXZUk3PXYuvEarf26Y2eTj
 r+kguR8cKWw0reO51MU6fT6f9PzEUirfBgihdqKy8toDR97CO5HdGd96Qqcyx31eVBfQxjpWl
 +BPCVw7r5ERT19UICQpT59JGIilH+JhqJLbzToziOWU8D6wzGvEF38iZQEzxVTu2xVT+c4f3I
 f0Z+X7uXrDS9LzfMjiiO/tLlkBkOOtLyNT57tBrhS0rUnx1L+UzW+yvqffMEbIOQqHN+vi9+y
 rx9lrlk60faaz3tm++pL/LMj31kPFx/yngD8cvXYIGHP1rCOL450sxr+EHq0/dOQ7l8sXrm56
 nabPti3/SmpDZzebNn7gWEBbpHOfiwwdCADyZaXj5x3dLF9ZPnPRhzrC25/kDBy/pan/zj91z
 cbw7FF1/GjkWGaYrsFAy5LyF2iqS/q3TXUgl82P5OAn/e9bWW5DiNNzh/BUgfS+twjpihQjis
 sVNsNfPaoHYd7LVHr3zP5aj7v8B8NZJSv+YWtmRW/LSciu2im94ZYONIEZeH5nIVvfGudw3cg
 LrcFOllJ79tfNZNcS1FTfOYB5fvZcxMJaah+4oCMR4xG0KwK+kJWQHsAxIUe89XglilNNo9EY
 mafb+BB4LqnzwG95odPHh1jIGZOqs8MF1AVzIdsT95ZjhxoVOaFRMXj/veb3YwPKSQ2QYNOo3
 M9Fbj3K2Ursb0NhLdxDj53pf08bMAe2U4QNxrJpnj0beB4s+txDS+UCnmoaGcGUiVtDRLJF2t
 mAcGDlG/ZWnbkw8NV
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/1/29 =E4=B8=8B=E5=8D=885:23, Nikolay Borisov wrote:
>
>
> On 29.01.20 =D0=B3. 7:19 =D1=87., Qu WenRuo wrote:
>> Hi David,
>>
>> Mind to merge the patchset for misc-next?
>>
>> As patches 1~4 are reviewed, and the last patch is not that complex to
>> grasp, I guess it's time to finish the long existing df 0 space bug,
>> with better RAID5/6 estimation for df.
>>
>>
>> For the long discussion about whether we should set available space bac=
k
>> to 0 when metadata is exhausting, I still tend not to do so, since
>> metadata and data are separate resources.
>
> Be that as it may users shouldn't really care about the distinction
> between metadata/data space. What they should care is whether they can
> create any new files, if metadata is exhausted they can't.

As I mentioned, other fs has their own limitation too.
E.g the inode number limitation for xfs/ext4.

And they report their limit with other mechanism (as df supports it),
but not blindly report 0 available.

BTW aren't there reports of free data space but no meta space and df
still reports available space?
That 0 available space mechanism only get triggered when things go
wrong, not making much real benefit to the end user.

Thanks,
Qu

>
>
>>
>> Thanks,
>> Qu
>>
