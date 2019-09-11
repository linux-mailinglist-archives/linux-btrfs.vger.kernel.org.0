Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6028BAFD03
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 14:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfIKMpF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 08:45:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:53485 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbfIKMpE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 08:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568205897;
        bh=WWQW1zNKy+enfGPzczUCqNArJ3H/SILi+W+sHkU+gbY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=SSFDKeLbQK7LdJ7yqpngwjpxdPRXmdtF9o5+5G7+vdNQhsJtBq6E+HfYPJ6j+kY9A
         5ofpcTwLwuAirMe7X6ReP5MfJ6EDIF/Vbv4FRSyV1e2E7T4ZYMlJ/TwG96tgCrM19T
         TJL/0SlCT+/ET0eK8R4i/nHFPQnfywulhp13uwhc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0McmFl-1hqdhG2o6L-00HtVg; Wed, 11
 Sep 2019 14:44:57 +0200
Subject: Re: [PATCH v2 3/6] btrfs-progs: check/common: Make
 repair_imode_common() to handle inodes in subvolume trees
To:     Nikolay Borisov <nborisov@suse.com>, WenRuo Qu <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190905075800.1633-1-wqu@suse.com>
 <20190905075800.1633-4-wqu@suse.com>
 <d78eb326-5441-94ab-f5ee-01f5526a97e5@suse.com>
 <9ab43823-0649-f277-5b19-224aa66f781e@gmx.com>
 <b7ccda0e-55e4-85be-0c97-b9f80fad4862@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
Message-ID: <e77effa8-13db-b226-bf61-9ca4a9470847@gmx.com>
Date:   Wed, 11 Sep 2019 20:44:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <b7ccda0e-55e4-85be-0c97-b9f80fad4862@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6qjrf09L3ZvOysKhYjGK7JTFMdh3r1piPG9SNqGAFGp7FGXGOdm
 zUBY81zM1UcvoXnWrzEfB73PEVKkSNieLztj210oSKOR7aQWy/AA+zDQyh91MOEtw7trI8N
 xnSgvP1NNANl4rOKsd5Tirc33E6LZALhSDy971rYr05PkZYCzvKD8Syb6HonpKUr7Eea/R1
 xpdMS/D0HgTHetI844BKw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F2MGOOS5iNQ=:wDhZLxvDa6NFJxOVPkjuAr
 pUuY5c6ab1EnqRrLQHnSNq9O5qZY68eeIjAfEwxLcC42bgZJ+R3ow6eutJ2Qc9zlRL5x/Xla5
 WCjo+EEax7CX2oR9XNIwvJWb9tfvCbgg9MZr1XTeXyhQ+RuRIY/sApTJvOL910gFa8IdA/5sG
 5YYueXRihHz1F/wbcTpja1ZuzypPE7FeIUoMjzXQL4UjTlLPCVgYzKUeAP4aZGnE3h59lr2JI
 s4iKEvgKUympt/K5gt68iw7YX3cQvCDBpSpBwkzufYpDK5qBYMIC+G5vTnNprOClGhZThN/ac
 6PhVrqTGs5wZ6JHSv8Y+CwTUaLGkDFqkSlGDHet3ddqiN55foe+oE3PEtMI53P0Z4O+3BrphD
 wCD5YYm33GXj+nbsEzGX14kh5qD5ZpwiCIjHaVIz6tv0Im/R+PLbfBSVnKV7bmVurlRhdE3m3
 dTh5YfOR1uXeamvapS+7jTHuhNgHCrTWkRxqOG1UOtiXUZRGKXNy/SNMVjLRykax8fNKHizug
 f47pP8D4gWKM/E8bgXbM/FmvtptJYaiB8hcv8NfCLeooce/Em8JALkBkWY56+JlCGcEQQy/6M
 co309nteWtg/vmrnUV0lHzuKncNDQxgWLejJOUlfRN/5eIabSUOIkVl3u6pc6+DrXJs8M3XBN
 tduFeJuYBCGEelgB/YxrfPMfVXuxuMusLIZatD+v2JatVGZt3UOtMLSjfIWWjpApc2dWKKUzo
 m2fLfmUNchtq1/LFn6jHhwfYNnfnBEKq0GxS6ZCyN2pad5w7BWTb32mhTGgP2nCQO7I6HcPXb
 woaQ8km7FaFszGqyYtzjejFnXd0zT+2Pe7tseb726iFLrSf4h+HhY+nyn083/aFM3H9q2C58S
 zjCP0ozhTczMxPeduifA19Dnt0jA8d5BjjwagLu8FQct9+nrU+2A8p1gf0mGQGde+apfZWkMm
 vTMK1dAmnWIdvCefpgivP12XdTNc8MbeUo3paCosl2pwLpab50V7NiZNuNR1XQh49bTwaIH65
 KN/izOqYNsH3WIAj6VxFNR/XrYgkT+QUUUJWnKNiN5K17UsBlvW0C+VuQLqhV0P6RzcnDVr/M
 5qt1ayaOSVD4Ocd85D3e9iG3RfABUoopSHMyeKRAJXtuYicwdUvE34BIuLOiJI3yPrQ+Mvbxw
 ph5U9yOxxQ/qVA+H7CZbM8AxduyLVIuvpfnsv6StVdO+82UjRFoCKEBMUW/c26+OGYC4kpINu
 e9gtiIKG3FkuoIleSg2zDON5IqRI8hraSJhGJzute9R+eFnh7oKAc942NKBs=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[...]
>>> I have intentionally deleted INODE_REF too see what's happening. Is th=
is intended?
>>
>> Yes, completely intended.
>>
>> For this case, you need to iterate through the whole tree to locate the
>> DIR_INDEX to fix, which is not really possible with current code base,
>> which only search based on the INODE, not the DIR_INDEX/DIR_ITEM from
>> its parent dir.
>>
>> Furthermore, didn't you mention that if we don't have confident about
>> the imode, then we should fail out instead of using REG as default?
>
> I did, what I supposed could happen here is if we can't find an
> INODE_REF then do a search for DIR_INDEX/DIR_ITEM since those items also
> contain the type of the inode they are pointing to. Fixing really boils
> down to exploiting redundancy in the on-disk metadata to repair existing
> items. Here comes the question, of course, what to do if we don't have
> an INODE_REF and DIR_INDEX/DIR_ITEM are broken. I guess it's a judgement
> call, currently you decided that inode_ref will be the source of
> information. I'm fine with that I was merely pointing there is more we
> can do. Of course we need to weigh the pros/cons between code complexity
> and the returns we get.

BTW, the kinda of "inconsistency" between different judgement calls is
somewhat causing the problem you see in some more complex repair situation=
.

To me and the old Fujitsu guys, what we (at least used to) believe is,
if we have any chance to recover, then try our best. (just like what I
did when we can't find inode ref)

But if we have redundant info, like the INODE_REF/DIR_INDEX/DIR_ITEM, we
go democracy, two valid items then recovery, one valid item, then
discard it.

If we have a very consistent policy, like anything wrong the discard the
bad part even it will cause data loss.
The recovery will be much easier and consistent.
In this imode case, we don't "recover" the inode, but remove it
completely, and if the INODE_REF/DIR_INDEX/DIR_ITEM repair follows the
same standard, a lot of things will be much easier to do.
(Now I'm regretting the call I did for the INODE_REF/DIR_INDEX/DIR_ITEM
repair code)

But I guess that's the ultimate judgement call made way beyond I joined
the btrfs-progs development (see the extent repair code and bad key
order repair), thus not that easy to change without a large rework...

>
> Just that I will advise to make it explicit in the changelog that you
> made a judgement call to utilize INODE_REF as the starting point of
> doing imode repair but not necessarily the only one.

No problem, I'd add more comment and the disadvantage of the current
behavior.

Thanks,
Qu

>
>
> <snip>
>
