Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B833179073
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 13:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbgCDMde (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 07:33:34 -0500
Received: from mout.gmx.net ([212.227.15.18]:35623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387776AbgCDMde (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 07:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583325207;
        bh=oITgtcd2t9Ddi2r+zojRZoIP5YvayOW1Hom+ihEGyXc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=EzB2Rm0b1l/3HF56+FFKmfsAjprB45vYzpGXqcRSwOVEHEE7+bAbh4CJuQQ5tYi5r
         to4HRTDX84GKq7NSecfwp78UlsrNxk9xKF4GMk4BN/LL/oXWqIa7Mn0b5ctZRsA7/X
         Z0128WR0L14HZIMTbfbLtg6tL4Y3Mi3l/i3tTtas=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZTqW-1iugBk3bvi-00WXgu; Wed, 04
 Mar 2020 13:33:27 +0100
Subject: Re: [PATCH v2 05/10] btrfs: relocation: Refactor tree backref
 processing into its own function
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200302094553.58827-1-wqu@suse.com>
 <20200302094553.58827-6-wqu@suse.com>
 <da92b934-0463-bcdb-8c19-1de0aa763b1a@suse.com>
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
Message-ID: <0aa8e084-f3f9-1a30-9040-70093289a91b@gmx.com>
Date:   Wed, 4 Mar 2020 20:33:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <da92b934-0463-bcdb-8c19-1de0aa763b1a@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:owUrOvnG3ojEJ3C/JaCilN1XV7B+zXgIZkH/u4C6bmIaPVLz6e+
 YcZfK4FhyAF2dMez3zXwJqIJK+uwvuKa2QxEOSKrHIvjTpxTml2HjSh2lDGu7VIZfTe05lM
 VDRDx+BvF7W2pNfcE8ImA3DxNE7UxekRlcDHKhTQ8nNkkGuTR11TU6Ra8fp9hYue4knyo5Y
 NdXz58RKppdFqTsj7Zu8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3iy+3fgZ2/k=:wR6JNGTWMd6zMOwkB9lhu8
 osAyZJVOmXmJuO+0Cm7g1LpCJjJHk7synbkUoqhRDViPocNHXY0B67CHV8OamqKg97cescflP
 YNYFFey5imj/FyuFp3P57mNoRo2i/UvwWiHGOiZBxf28gAE9bFB3ndEmuCGOcXzuBSdC4HR2m
 NoTuPpUt2ljrDNDVGXczEMVPmxGcUEwebJXepd0HTBi+BlnLrRvHHIIt7mQj1BNuV05mN2VfQ
 KQFnqu84vPQpG4kmX45GrZJF/LGqIyPmQG4fXGxOxfkwhiZdTUPQvtx6k75p+avTwuKoJ9TP6
 cz/glIILkVUimu3KPaUaqwSr2KKcfwnD0VQ3xkA0Ry+TictuIg5TJUJPG6tNXGYwPNEwHjXsC
 dmtR+WTAQgUajUXAk3kQyCUYGUGjsCIkg5NbiSLnfCufc8IwerxRs94YdrbH1q93MKJuQw924
 T49rcid5MDEJzT0y+GZCGx8pVsvaQZ5UCC2hwMwSEtYKIhksD+l5yFAovB1y7TcLvadyeh7it
 X7VO9wUPWq/BVXqziqmT4GJcVpr6/I/L8ZWRN+7ACKe1sBqcRZHpTEAAdh8VOKBhYdxrR5fnt
 joEGJDYlU4JceiMTO4SXAC9yTkn0+W2BjZdZrnMEw6tDVlDwyzDwexN3fZ5wBW5R6Gdn3ho8G
 p6MFFlFBDtTTUBKxne9hrWN4nwEj/jSHgc9+JuKy5oHB9vfMtl/EGaGACFm0ohp+ywwN8aVIF
 KZqRA3SArFwSI7ZDPKyPXY+Ee+FC7imzPgbx6viBc/9vlq1WV4KyoEfir8Gz1UdGe9yNDEqRb
 7OJ/wUWgbQ+/Im8BZJQyacOX4UqKnnHVyIvYGs2X4moPPGkSsrNNEFeAlvQStyOgu9AQSkEoT
 z0qViv1Y0Pq3qSbOxGFVSAmmhy1D0KnFNQ1XxVGD/vztJ/4kzTtPQxfU/ta61Bb/e3Yh8XEbk
 u/x2NIW0Xb1jgLtLFnny8I0F0LPoFLENnVWg0+u8Puivc8HoCY06Pz31rSrKCc4tHrD3MeDC8
 qZeIneK+RlErwSo2FFfu6hXkYBbqfc3iadhqaimnoo8SLU4++w6AQwjTDcaymB846NE2r+bLC
 uEeznMzpffL5YpOkeGYMZ+29dnw7qQM5Z3dKNqZDXqIl08xLren6qks2UoFlsU+YbKzurveyy
 1LP7zGRyghN5Ew2PtLajZuOKsWXTo9HvjRMNO95FopmZiZkptDXNDrY9gsbtruAWkqSuuDmrx
 hgj5N9nSS8XGrrXr5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/3/4 =E4=B8=8B=E5=8D=888:23, Nikolay Borisov wrote:
>
>
> On 2.03.20 =D0=B3. 11:45 =D1=87., Qu Wenruo wrote:
>> build_backref_tree() function is painfully long, as it has 3 big parts:
>> - Tree backref handling
>> - Weaving backref nodes
>> - Useless nodes pruning
>>
>> This patch will move the tree backref handling into its own function,
>> handle_one_tree_backref().
>>
>> And inside that function, the main works are determined by the backref
>> key:
>> - BTRFS_SHARED_BLOCK_REF_KEY
>>   We know the parent node bytenr directly.
>>   If the parent is cached, or it's root, call it a day.
>>   If the parent is not cached, add it pending list.
>>
>> - BTRFS_TREE_BLOCK_REF_KEY
>>   The most complex work.
>>   We need to grab the fs root, do a tree search to locate all its
>>   parent nodes, weaving all needed edges, and put all uncached edges to
>>   pending edge list.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/relocation.c | 395 +++++++++++++++++++++---------------------
>>  1 file changed, 202 insertions(+), 193 deletions(-)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index d1e1d613ab98..04416489d87a 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -666,6 +666,206 @@ static struct btrfs_root *read_fs_root(struct btr=
fs_fs_info *fs_info,
>>  	return btrfs_get_fs_root(fs_info, &key, false);
>>  }
>>
>> +static int handle_one_tree_backref(struct reloc_control *rc,
>> +				   struct list_head *useless_node,
>> +				   struct list_head *pending_edge,
>> +				   struct btrfs_path *path,
>> +				   struct btrfs_key *ref_key,
>> +				   struct btrfs_key *tree_key,
>> +				   struct backref_node *cur)
>
> That function has 7 parameters and while @rc and @path are somewhat
> self-explanatory others are not.

That's exactly what I'm fixing in the 2nd patchset.
To kill 2 parameters by moving @useless_node and @pending_edge into
backref_cache.

Since you're complaining about this, it looks like I'd better put that
patch earlier.

> Also it's really doing 2 distinct
> things which, in my opinion, would be much better split across 2
> functions - 1 handling BTRFS_SHARED_BLOCK_REF_KEY and the other handling
> BTRFS_TREE_BLOCK_REF_KEY. For example the @tree_key,@useless_node and
> @path are not used in BTRFS_SHARED_BLOCK_REF_KEY case. You'd have two
> functions named:
>
> handle_(in)?direct_tree_backref
>
> One will take only 4 parameters the other will have to, unfortunately,
> take all 7.
>

That looks reasonable.

I'll split them into two functions, and move the two lists into
backref_cache in next version.

Thanks,
Qu
