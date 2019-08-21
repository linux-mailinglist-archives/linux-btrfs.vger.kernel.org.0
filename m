Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3188B98819
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 01:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfHUXry (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 19:47:54 -0400
Received: from mout.gmx.net ([212.227.17.22]:53127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbfHUXrx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 19:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566431266;
        bh=w46fCot75IQS2gqDHdonJNDNyjg6uYYICk6cRjtRQvE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=I7Y2C89yeJVO+P/Vys+SvxnQjmU/QhRhAAt0UX4ZVXw8J6iCpFR8TNtJ9csZs0Y3j
         Eywbon9N+o3Py2jblZnAhyRHJc6G2kApDGyOoSBwiydMAuIVZIFj+1nujVoT1elxWR
         t433ibdhEAkBrFk1KxMa9IRvb5ORsl7QxRg3I3Tc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MDR21-1i1QL60hEj-00Gpvq; Thu, 22
 Aug 2019 01:47:45 +0200
Subject: Re: [PATCH 5/6] btrfs: Simplify extent type check
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190805144708.5432-1-nborisov@suse.com>
 <20190805144708.5432-6-nborisov@suse.com>
 <20190821154039.GA2752@twin.jikos.cz>
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
Message-ID: <bb544b37-ed4c-f3f1-bf2a-df7b9a3b4479@gmx.com>
Date:   Thu, 22 Aug 2019 07:47:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821154039.GA2752@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uRT1vl2m9T7PhnJqo+3VigKgRezh68PmRJWRxtF+GGZdWYbyAjt
 /hKD8QehW5iqAYizHN36dDoHlfrobDhuWO/JNxsBzNWS6/3r1VpUcsW8mSu1Q/IXWJzhPIv
 z1/Gy+mviucgV27l3KUpOXJgdH9PKbIthEKH/zynDND3zlBLcjvvb2KTh0aWWD4jlKC2vGD
 PgQku0KIM9R4yJpAoxllQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kL1C9yvqfZI=:uHSyuh8fjeC2idiwNCin5q
 X7B6aukRRZDaP52icF7h8qxWx4VXOmf7FZh2xoGYqJ4ZszcICTkFzopJ3lkZyJyJ2IUmcsSUC
 KDUX6YqSg+ez2Awfp6q3Q4B0pRTIRuQg7YR+pa15WBaFZ1OPzIgEh83TlmjRagYUG8l+0xMTp
 biXd5sPN/5KdMfpmkdAZar563RiQMmmroyrYbyNkca8/IuGd8Pan+45cgm0ROu+N+Yfx+D9/l
 rGcagttjTHJndZxZZYrR17vXLUuFUgyUETooO4pgDM5TQgKj40sXZhShHqwIv2LbgIoZuQW/+
 PydJZAK6C52Ou9sMf5vv3qfLsnWpLUzs8L6IfZtwKdWMwMmbtmSBlU0lv/hegM3dBman/5aev
 0Z3oc89pprERbwYJX2VgqDv9o2tplNqvyuAa91dD2pkp271rkp3lSpwFm7g+b1SPR4buI3rZh
 BpUrSOsPRjHEsygXv0ul2fG+Y2nI86w47UpGC5XTeItWbtXjEArD7M80eHn+yaj1jqBs3TAIg
 /WSQxcu0MGdyONhvOmCQ5w+KTWSm4HCr9q/eYOqvYUkET8I9m1hj6nq6iS11EyppOkEQNGLEL
 UADjF7wO5NJHI1JQTBbhJllxLYx8u83IyOWgYImzOWyeHb8HLBGduU67WoEQRQe7P05779Hky
 bHhCwmC0hgb91zv/FMSspLqTOU4ZWJMkcIYEDl5AVQvE4AgAXbiddme8H7Ot8ZZ3mpTwLqwNK
 fjzXzQZy4S+SgzEeFZpMSWJyBfKn4hOMynCLsmPeIzTUiDWcAW7SNjRUcx2TpkTW2iq+gN8Va
 EKpoevDwAO74de+okSgzIMk1LLTADEm2TIWdAE1m4TMYaKQZkpxhy6HcXDvShfYlNt9KWGBgR
 R+r7uSOyeGRYb/tOguBeqw64mEZ1VDxHJSvuNJEU5nwz1uay7nNfy/dPfP4nq/Yhqxg5n+O9u
 xsMH6Uf6YCfJq7lJZ5GS6a/EmKSd2jmSJZUc+H7M/Jjrbe+w5aV0q1c/8Ye4YjT84BCf+O+MA
 2R5QZZkUHzymJj3v9R41Yv6VbKG0rgrYze2VdcCiu40RB0HDHR2XsTm7qDCdw7DQjF0aYcvnN
 hChKVmhhyZmbLUoqnarFoeD9nx0k4QDvL1bPEzK1ObgjxM/z0eNSgfcnpS+BTldxQczqutzsu
 Wsulc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/8/21 =E4=B8=8B=E5=8D=8811:40, David Sterba wrote:
> On Mon, Aug 05, 2019 at 05:47:07PM +0300, Nikolay Borisov wrote:
>> Extent type can only be regular/prealloc/inline. The main branch of the
>> 'if' already handles the first two, leaving the 'else' to handle inline=
.
>> Furthermore, tree-checker ensures that leaf items are correct.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>  fs/btrfs/inode.c | 10 +++-------
>>  1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 8e24b7641247..6c3f9f3a7ed1 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -1502,18 +1502,14 @@ static noinline int run_delalloc_nocow(struct i=
node *inode,
>>  			if (!btrfs_inc_nocow_writers(fs_info, disk_bytenr))
>>  				goto out_check;
>>  			nocow =3D true;
>> -		} else if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
>> -			extent_end =3D found_key.offset +
>> -				btrfs_file_extent_ram_bytes(leaf, fi);
>> -			extent_end =3D ALIGN(extent_end,
>> -					   fs_info->sectorsize);
>> +		} else {
>> +			extent_end =3D found_key.offset + ram_bytes;
>> +			extent_end =3D ALIGN(extent_end, fs_info->sectorsize);
>>  			/* Skip extents outside of our requested range */
>>  			if (extent_end <=3D start) {
>>  				path->slots[0]++;
>>  				goto next_slot;
>>  			}
>> -		} else {
>> -			BUG();
>
> I am not sure if we should delete this or leave it (with a message what
> happened). There are other places that switch value from a known set and
> have a catch-all branch.

We can just delete it IHMO.

That's why we have tree-checker, we have ensured at least EXTENT_DATA
item read from disk doesn't contain invalid type.
So removing the BUG() here should be OK.

Although converting it to a better error handler won't hurt.
In that case it can catch runtime memory corruption earlier.

Thanks,
Qu

>
> With your change the 'catch-all' is the inline extent type. It's true
> that the checker should not let an unknown type appear in this code,
> however I'd rather make it explicit that something is seriously wrong if
> there's an unexpected type rather than silently continuing.
>
> The BUG can be turned to actual error handling so we don't need to crash
> at least.
>
