Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9B686024E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 10:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfGEIjI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 04:39:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:51609 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbfGEIjI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 04:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562315941;
        bh=Nl2Hzl/b05jh6u7d1C4wyMjJgSst0/48d7xxvpzmDYI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CLGz059JX9pOq9qZL0qvWzgSCvv3lKeLujyQ5DSTkzS+jIvgZethqsX98yP9yY1VG
         zHe46f2hVJXiU1DtBGYNSOZcj3k4IydSU10eIFUp9mlA6vP4I/XXbROXM3cEca8fjg
         ZyIU+k3dooLIHCEeO7WLb0+ut0JUKb/H3lFflSck=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MF5FT-1hkjqp1Gzz-00GJAm; Fri, 05
 Jul 2019 10:39:01 +0200
Subject: Re: [PATCH 1/5] btrfs-progs: mkfs: Apply the sectorsize user
 specified on 64k page size system
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190705072651.25150-1-wqu@suse.com>
 <20190705072651.25150-2-wqu@suse.com>
 <8b26ebd6-55d7-35ef-0f5e-9136c31db876@suse.com>
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
Message-ID: <193292d1-1b5f-eab5-dc1f-c233752b307c@gmx.com>
Date:   Fri, 5 Jul 2019 16:38:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8b26ebd6-55d7-35ef-0f5e-9136c31db876@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wrY3OpaPaCtXLRLLG8pL2FLSsRfW7cWGgdhxCafLJZe7wHJGwNk
 HsXLllJMz9n4vHi2+HR/JXahlp0lejwyLlnc6EuPCsF3QwZJSq4v+hicjd1e0LJoFgT+pCi
 clajn0kjkLBVPjQoR8HCbF4pSPGGJni9xC0jNsofJVVVTYcA9tftz+jfxEjm8rMKwvjl/9C
 1u0RSmSJK99Q5v9iOiE1A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4WMsn5RrUDg=:RRus/+ld20QX8UE4ygiRyU
 yz6KbBkKBq3FHIRpNlGCQy2LfELUKCsbFLqo096i+iDUpNXil2XFX1O5K71ynMa9yZQZwcbw7
 QbGvSYPytH3yP3HnQ7HWyy4hd4TVOiVkNkvNGGn/+TFiUl3LW1CQWzFJ+Voq1BFiXthLVLYo9
 Z6nZ9DeHtMxAwpADCWZuwX17mLA93f76wEbfF/XOB+aVYcqKJOIp9JLfnFiPEzof4VnVZhvEt
 kMNKaXtGNnRh7kGl/GGz16kFhPmfxnK9VL6NrPlUM8gXYJl1Cn9UKLDC3gdNJtOE+mH8RbZzk
 B/te+hMU3gEtBZTuPgDLBg5ymhDg6dntyE6cCSw6BAk4+kg1wA4qFaYAai+uRbDRMFRDKMLtk
 OrhXUiQ/dr7FxH17Rey4LzJAQaRSeNCY6HZ/Ojq0heKQ4VzsbjEhjgZ/J584tKe20/5q7RgVx
 JU3cXVovj0IqdPziONpyJqS7AvLRa+ZHiAq0mRpAJiUCego1W5DMioFffvEesQsv6veL1iSfF
 muIrqQ3ZGsujP0bGf0rw75FBW4BplFT7+brdE3PGlEmPoQP1adCGu5cltmmDbxhr+aKJRU8Br
 XsYbmZqI1CM0aPwxbR9XSjqdpG2jC3JUbZa34EB9RwGVP7ZXMqDvA/EgUs1aCAGCNnqgK+RBs
 yZdS3K7elL6Yc5BroPE6ee6XNM5oFw9bHkNA1ikw4vNCZiAmx2nGcQ5hfgiQfWvzW9VU5x9hN
 /21D8ZLmmylXnSQyAqAsTaQOYbqiqmwXrBJFzThbZ5oFiTJ5uE60BQUTLJFl8ZShXWypqMtZS
 i/Iycepmw5Y4jhrFwBcrzRaKV1n0Du/QtnQtPJVvClcXutt0Z6A8WaxLCuW3+Aw9b56gp5sND
 mRR0hXqNTkvWqZqWlPlRy6u30oWaG1xEwLKKDbhHvaLhAzXaa7orVhvG3aeOfhV4XEiGUlrCy
 OPVsY/ATv8UsthX6wo8DNqgbbIZlc2QbHKsbxmn0fMQ/nJJUmJIv44dlSlletlYnRMevFobpT
 mq2NusCGrs+i2bcMAOsfTVcK3vr4FpNJQx5CrDEAf0WOOtv1IwxOkqOH/w/sUDMlJ12XJL9ab
 Xb2lsQ4m9MpRaq+ailESGgKvLtVDZCcGzkH
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/5 =E4=B8=8B=E5=8D=883:45, Nikolay Borisov wrote:
>
>
> On 5.07.19 =D0=B3. 10:26 =D1=87., Qu Wenruo wrote:
>> [BUG]
>> On aarch64 with 64k page size, mkfs.btrfs -s option doesn't work:
>>   $ mkfs.btrfs  -s 4096 ~/10G.img  -f
>>   btrfs-progs v5.1.1
>>   See http://btrfs.wiki.kernel.org for more information.
>>
>>   Label:              (null)
>>   UUID:               c2a09334-aaca-4980-aefa-4b3e27390658
>>   Node size:          65536
>>   Sector size:        65536		<< Still 64K, not 4K
>>   Filesystem size:    10.00GiB
>>   Block group profiles:
>>     Data:             single            8.00MiB
>>     Metadata:         DUP             256.00MiB
>>     System:           DUP               8.00MiB
>>   SSD detected:       no
>>   Incompat features:  extref, skinny-metadata
>>   Number of devices:  1
>>   Devices:
>>      ID        SIZE  PATH
>>       1    10.00GiB  /home/adam/10G.img
>>
>> [CAUSE]
>> This is because we automatically detect sectorsize based on current
>> system page size, then get the maxium number between user specified -s
>> parameter and system page size.
>>
>> It's fine for x86 as it has fixed page size 4K, also the minimium valid
>> sector size.
>>
>> But for system like aarch64 or ppc64le, where we can have 64K page size=
,
>> and it makes us unable to create a 4k sector sized btrfs.
>>
>> [FIX]
>> Only do auto detect when no -s|--sectorsize option is specified.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  mkfs/main.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/mkfs/main.c b/mkfs/main.c
>> index 8dbec0717b89..26d84e9dafc3 100644
>> --- a/mkfs/main.c
>> +++ b/mkfs/main.c
>> @@ -817,6 +817,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>  	char *source_dir =3D NULL;
>>  	bool source_dir_set =3D false;
>>  	bool shrink_rootdir =3D false;
>> +	bool sectorsize_set =3D false;
>>  	u64 source_dir_size =3D 0;
>>  	u64 min_dev_size;
>>  	u64 shrink_size;
>> @@ -906,6 +907,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>  				}
>>  			case 's':
>>  				sectorsize =3D parse_size(optarg);
>> +				sectorsize_set =3D true;
>>  				break;
>>  			case 'b':
>>  				block_count =3D parse_size(optarg);
>> @@ -943,7 +945,15 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>  		printf("See %s for more information.\n\n", PACKAGE_URL);
>>  	}
>>
>> -	sectorsize =3D max(sectorsize, (u32)sysconf(_SC_PAGESIZE));
>> +	if (!sectorsize_set)
>> +		sectorsize =3D max(sectorsize, (u32)sysconf(_SC_PAGESIZE));
>
> This means it's possible for the user to create a filesystem that is not
> mountable on his current machine, due to the presence of the following
> check in validate_super:

There is no problem for it as we can also do that on x86:
mkfs.btrfs -f -s 64k -n 64k

>
> if (sectorsize !=3D PAGE_SIZE) {
> btrfs_err(..)
> }
>
> Perhaps the risk is not that big since if someone creates such a
> filesystem they will almost instantly realize it won't work and
> re-create it properly.

And I'd argue any user of -s option should be considered as experienced
user.

>
>
>
>> +	if (!is_power_of_2(sectorsize) || sectorsize < 4096 ||
>> +	    sectorsize > SZ_64K) {
>
> nit: Perhaps this check should be modified so that it follows the kernel
> style :
> if (!is_power_of_2(sectorsize) || sectorsize < 4096 ||
>               sectorsize > BTRFS_MAX_METADATA_BLOCKSIZE) {
>
> MAX_METADATA_BLOCKSIZE is defined as 64k but using the same defines
> seems more clear to me.

That's correct and looks cleaner.

I'll update this patch.

Thanks,
Qu

>
>
>> +		error(
>> +		"invalid sectorsize: %u, expect either 4k, 8k, 16k, 32k or 64k",
>> +			sectorsize);
>> +		goto error;
>> +	}
>>  	stripesize =3D sectorsize;
>>  	saved_optind =3D optind;
>>  	dev_cnt =3D argc - optind;
>>
