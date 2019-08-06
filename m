Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C27AF83368
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 15:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbfHFN4S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 09:56:18 -0400
Received: from mout.gmx.net ([212.227.15.18]:44889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfHFN4R (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Aug 2019 09:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565099765;
        bh=+EHdsKdaA7hJ0g7EJRYeqVtf5tKZ3QvOcjLchqIgwpY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OH9CoQZ2a84BAx3WVjXgZE51s7kCaJsO5ShKaWqmBwyR6OZ3dF7m1xt838fPydNcy
         gjA21bOjRshtbrwgSnQA+flhfp4vkCrk6iT4yTLsaU+K/HK6ohv5Q7KU10HaD7w7ld
         0Y2C3W2uqw1FGz6eQpMvR9L53K5A1FKm2qj+vs2Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LfC00-1if7K024FM-00olyE; Tue, 06
 Aug 2019 15:56:05 +0200
Subject: Re: btrfs: qgroup: Try our best to delete qgroup relations (bug
 report)
To:     Colin Ian King <colin.king@canonical.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ea7f88e7-108e-ad2a-232f-b18715607bf3@canonical.com>
 <ca0946de-5343-aaf9-10f2-007e341cb8a4@canonical.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <8f8edc81-0c54-da50-0902-663e7c4f26ca@gmx.com>
Date:   Tue, 6 Aug 2019 21:55:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ca0946de-5343-aaf9-10f2-007e341cb8a4@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PX2YsugXiYFMk+uek3kDxQiaRgDjeqM8BrXtieqvgMN1bbR5YPN
 pSsnTeV7/RT625QYYmFU9H1kq1nbupy0xMOLylJlLsBJS06ddUYccx+lxpWPVhMLUMlBLyh
 m3q2yc8eZJO8uIz1nchsr4Bz4HJXGwcYRANJTzfSzIjSxYzMl0FinKrBBjJ24d0itgWFCBf
 F04ddtcmn6/hzaWDKVFbQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:B8+Ch19fU84=:D1RbNAAFQcREciKFvnXECt
 6zdbk8s4aaeyt/O57XllOewA4BSy8/Kv39KXJ904Q042NyT028B9ZwPlbsrvyJfhMlyShKv0O
 mjYwVNlX/p+K/Nz/dz5I2bWO4UfOnjv01CJi2p1U3IIEVn7RQu6lDVrmAOp6ruRLqg4/+ZA0m
 ZhhXNNbvUaMlzZ+FHW/Agdfc7Vqtk9qAKvkwD5159CzxL18Uv7gD1JdCK1N4PPAyXkNO5yWkN
 Ss0qhD8DhaV505PX0PRj1EgoAliuZBTy/cv9NmOfYhDuOKpp9ELg2AaHzc6GDAVtxA1/lmSHc
 qeAOWBbTMiET5WnRFxgD2OkYyaWh0hiVqJQv7wRD/hSPeu7fvpxR/pCK/IaW7Fss/G4Cwax2v
 k7siCOnH8rcXIE6WcxLWGGQ934qJ1V3Xwn2+GIEPP2V5I0K8nXZH/6ZBb7zOMU1/a3GKHe63r
 DZrSnVHwmLRMpbxbqN9BKDh6aLIlogzM3skNXjCf6CX2dpLI+nFG/RFfdAWbpFHFaoN7SHWFb
 hSVloh0uIkOjZoHytCr2ki+pVOWg2sCXTh5venB7kinzKW2ijR+La/WRVKrIoRkdQnQTQIN12
 039UbumU7l9zuNpItx73vsFMy+yOR7+G1Uga7M5/3GPEgIcP/9Tg9FjFlUFaS0BO6InI6RD+7
 LZDF811yoemgkSo5yxIhUPkBvVFGGmYp5xdjQbSF/F3zALdPnsSu0r2L+so491ChpsJHOEp8S
 +MQ4cCZXeaTFg/Frp+0kU+mLVfh2uEUr8zxZ5wqHCInkyl7bG1C95SFTuBp9lXnVclbOxIpRU
 3HCIzfQc3t5hkz91/ebv7VrUCv78QLnpwT8uJD1kPSWtNwty4pY9tCceV5ld7jHt9COKFK1wE
 4pdII33dh3MiCk885WLfdzrsP9wfOgbOtCK1a3lbFrcdvD/klDvyvCRLDJNOx9rLJE4jcVKFB
 vlnkrO1mKib9wdaB2vy5BYoovk/BbyBQoJGUx1aybWYV04hzWMqsHP1Nmsi0yt8Ky9hYPhMT7
 lLDLskquERHJhwgRluA6pJa2JXe1+4JUq8gy8ilkh6P8B/Pqf1jsRUwBNvSY6j8HgQEiYR+WW
 ueETPT5plk4RKu75BdYVjSQIInvw5PX8WZmgeA8P/5r2YGrpNkxVrV/ti9aLHyqZ+s3vnOE40
 CZFfm9p5dUmEvRtmTHc5OmG7ECGcaFvWrJpwsu78C+tw0ft1s5TUUAncrcRkzAzcwxONrKj7a
 LDdUvGwcwmdtYHbkix6vnmDpOYKZYyyEsqvQgTIf9KGt09lRYYOZCubJbFoqYXZm74t2TgOZw
 cRr8+vazHBmXBh26LSZ9tVxSuIOgGJfR0aosV5wB52XYMW0POLVFscswHr2zJftM3xHSegEl9
 IjB4Gqs4ZRJdYzUTGFJ9tXPScjac8RM6O3Wia2GlwU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/8/6 =E4=B8=8B=E5=8D=889:49, Colin Ian King wrote:
> On 06/08/2019 14:48, Colin Ian King wrote:
>> Hi,
>>
>> Static analysis with Coverity on linux-next picked up a potential issue
>> with the following commit:
>>
>> commit 035087b3c256741be367747eab866505cece31fb
>> Author: Qu Wenruo <wqu@suse.com>
>> Date:   Sat Aug 3 14:45:59 2019 +0800
>>
>>     btrfs: qgroup: Try our best to delete qgroup relations
>>
>> The static analysis report is as follows:
>>
>> 1334         */
>>
>>     3. Condition !member, taking true branch.
>>     4. var_compare_op: Comparing member to null implies that member
>> might be null.
>>     5. Condition !parent, taking false branch.
>>
>> 1335        if (!member && !parent)
>> 1336                goto delete_item;
>> 1337
>> 1338        /* check if such qgroup relation exist firstly */
>>
>>
>> CID 85026 (#1 of 1): Dereference after null check (FORWARD_NULL)
>>
>> 6. var_deref_op: Dereferencing null pointer member.
>>
>> 1339        list_for_each_entry(list, &member->groups, next_group) {
>> 1340                if (list->group =3D=3D parent) {
>> 1341                        found =3D true;
>> 1342                        break;
>> 1343                }
>> 1344        }
>>
>> An example of the issue that if member is NULL and parent is not null
>> then  the list_for_each_entry loop with dereference the NULL member
>> pointer.  The changed logic in the patch on line 1335 is the root cause
>> of this regression.  I believe it should still be:
>>
>> 	if (!member && !parent)
>> 		goto delete_item;
>
> oops, I mean:
>
> 	if (!member || !parent)
> 		goto delete_item;

Right, thanks for catching this!

I'll update the patch soon.

Thanks,
Qu
>
>>
>> Colin
>>
>
