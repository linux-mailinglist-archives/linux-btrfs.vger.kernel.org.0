Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEFA20936
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 16:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfEPOKT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 10:10:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:33299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfEPOKT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 10:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558015811;
        bh=9HKlRe35qEJxMSQYWLOXoFvPDNZaxp4iw1tjKakMug4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Wr3+vBTYrK3uf7B2d4Sr/96QRzW3RBZDuOLGoO5CA2KApb2vs8PuevNKNihZR+uWp
         bd+sGcN5F45Tgy6DjrLua5YhhS4pmnnJDXfll6bVTmRF3oiHJtfO9UmOUJmpK0KZXX
         ccPpw8VVPYmjUK9biFxUiW167QdMEHmJoDI3uAnQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Fjb-1hM3l73Pmh-006QTj; Thu, 16
 May 2019 16:10:11 +0200
Subject: Re: [PATCH 1/2] btrfs-progs: Correctly open filesystem on image file
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190516131250.26621-1-nborisov@suse.com>
 <e7a99dd5-5107-5da9-df95-6ad43bf8ad7e@gmx.com>
 <dc21e6b1-15c6-598a-4b63-3649ee57675f@suse.com>
 <7214c003-5321-d1f1-a164-105dd8000415@gmx.com>
 <922c8020-5b7d-e550-4f12-6cddc01dd370@suse.com>
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
Message-ID: <b4fe92f0-61d7-5c54-f317-dc4302dfe900@gmx.com>
Date:   Thu, 16 May 2019 22:10:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <922c8020-5b7d-e550-4f12-6cddc01dd370@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dS6VNB+MFDt2/1GMM50WLwMSjQF95by97MuQxuVyDl68Pj0F2tJ
 UuVsh+JeeafLEt5E/y40/1NHfsn+DTz/vrtbvo3pIgpKCx91l20HUeNebK8T6VaJfd139QD
 WPVXvNTv0weABPGlNES7TGI+C/rkRDpjv3cjpUUIytOZNweOq5Gz4c4lEjUPew5Uy9fpaRp
 5coaIr2C3IiyHJDzK7hLQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xMwgmyEZtiA=:TnzP/qsJaPlbzcJxVI2f3n
 unbPORB8Z7lor7n+ByI6WXNE6boVNVfZsMiKnAVwtYaf648TJP4XQ+Y9ZDlkDueXthrwSGDN4
 eaoC6gtkSKGKJ89KRZJeQq8gpTx48mL6XKAtj1DF9Sit8B1ut1QseszYUZv+EW/acK7BgC3NM
 LINGmZHqM4czXYO/neUsYeETTlHfVk+GBduDXrOy4DwIXT8NWKg4s61FLQKYMWfBp8Wr3vYOt
 LUQmzl4Y54W6qQPZX/kAHpVY8KuZTrve95OsOvQtA7O3MPImhUnpOmpLSM4p+zxOkN30oSU4q
 uZJX+OFro2DmCTepeSavX1nS66Mu9Isd/UWeJf/YrC3pKGnUX8qgO/mre3hyqF+h/uD3LUSVf
 JdOV8BOQicwrwyYEilOSAZYsgmqnsrbwqT7qZVwQ3l7tmdSPUaYbvrsteaJrNbhxx1KE42HGU
 P6hGA3VRUZ9W4N4oXipYEffmAWBYkbgJUYrMitw+26MfDfljuCmLOy82gIfUBYwNr8qBjJoFw
 D1ntilUWGRIcdSf6+OHcsbSvMgLFnBSXBA6VeG0BRQLCRmlYNgKhzUkIhVd8CSWRjQ+zhOs0e
 v9LhQRdnQspAloe9537+JWqhT8dDecNLqeyXdyt3WfoIu/qzxF/2tkrHiyQ+Xk069nbR6qOcH
 HPLrh3JjnBUIVFBmTpPI/OCW9Q0WFbptyFJ5d6u69z5enJCliHz1nCB+EiLfIpGWolIfENZEE
 TT7bpLluE/vhjv2vC7ZPYaaoIkYpZqv4rsumTxGQ14U6uOqrgWgUXXJyzt/4XQHbC7XRzaZo1
 qL9syKJe3fcQJZst1w2vN9cw2r2sJwr3oPXpE6C3IeakgjKGsFBbRjD9qzZDCipGybDQY+hOJ
 ARct7bH2WzG5OYQw0ZN66+f3gkPJYZymIhPVMylsY0UuacKsuUiMIA66maney9qXZCSJ0Iofz
 MInkX+f0OrVtmntZKgpDv2x1aXi6Vcy2QPkRVSX5L91JTUNyt4evH
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/5/16 =E4=B8=8B=E5=8D=8810:01, Nikolay Borisov wrote:
>
>
> On 16.05.19 =D0=B3. 16:54 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2019/5/16 =E4=B8=8B=E5=8D=889:45, Nikolay Borisov wrote:
>>>
>>>
>>> On 16.05.19 =D0=B3. 16:41 =D1=87., Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2019/5/16 =E4=B8=8B=E5=8D=889:12, Nikolay Borisov wrote:
>>>>> When btrfs' 'filesystem' subcommand is passed path to an image file =
it
>>>>> currently fails since the code expects the image file is going to be
>>>>> recognised by libblkid (called from btrfs_scan_devices()). This is n=
ot
>>>>> the case since libblkid only scan well-known locations under /dev.
>>>>>
>>>>> Fix this by explicitly calling open_ctree which will correctly open
>>>>> the image and add it to the correct btrfs_fs_devices struct. This al=
lows
>>>>> subsequent cmd_filesystem_show logic to correctly show requested
>>>>> information.
>>>>>
>>>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>>>> ---
>>>>>  cmds-filesystem.c | 13 ++++++++++++-
>>>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/cmds-filesystem.c b/cmds-filesystem.c
>>>>> index b8beec13f0e5..f55ce9b4ab85 100644
>>>>> --- a/cmds-filesystem.c
>>>>> +++ b/cmds-filesystem.c
>>>>> @@ -771,7 +771,18 @@ static int cmd_filesystem_show(int argc, char *=
*argv)
>>>>>  		goto out;
>>>>>
>>>>>  devs_only:
>>>>> -	ret =3D btrfs_scan_devices();
>>>>> +	if (type =3D=3D BTRFS_ARG_REG) {
>>>>> +		/*
>>>>> +		 * We don't close the fs_info because it will free the device,
>>>>> +		 * this is not a long-running process so it's fine
>>>>> +		 */
>>>>
>>>> The comment makes sense, but I'm pretty sure we still prefer to clean=
 it up.
>>>>
>>>> Just something like:
>>>>
>>>> 	struct btrfs_root *root =3D NULL;
>>>>
>>>> 	root =3D open_ctree();
>>>> 	if (root)
>>>> 		ret =3D 0;
>>>> 	else
>>>> 		ret =3D 1;
>>>> 	close_ctree(root);
>>>
>>> Tested that and it doesn't work, because close_ctree will call
>>> btrfs_close_devices which frees existing devices so the test fails.
>>
>> Sorry for the confusion, I missed "..." line before close_ctree(root);
>>
>> I mean something like:
>
> That would work but it quickly becomes ugly due to the other possible
> failures i.e :
>
>  ret =3D map_seed_devices(&all_uuids);
>         if (ret) {
>
>                 error("mapping seed devices returned error %d", ret);
>
>                 return 1;
>
>         }
>
> It's not critical since we return 1 and all allocated memory is free. So
> the options is to either change those 'return 1' statement to 'goto
> close_ctree' or just leave it as is currently. I opted for the the latte=
r.

Fair enough.

Reviewed-by: Qu Wenruo <wqu@suse.com>

The problem can be later solved by implementing refcount for each
device, but so far we don't have so much desire for that feature, so it
should be OK.

Thanks,
Qu

>
>>
>> diff --git a/cmds-filesystem.c b/cmds-filesystem.c
>> index c4e43f8446dd..d20cbd49c201 100644
>> --- a/cmds-filesystem.c
>> +++ b/cmds-filesystem.c
>> @@ -677,6 +677,7 @@ static int cmd_filesystem_show(int argc, char **arg=
v)
>>  {
>>         LIST_HEAD(all_uuids);
>>         struct btrfs_fs_devices *fs_devices;
>> +       struct btrfs_root *root =3D NULL;
>>         char *search =3D NULL;
>>         int ret;
>>         /* default, search both kernel and udev */
>> @@ -779,7 +780,8 @@ devs_only:
>>                  * We don't close the fs_info because it will free the
>> device,
>>                  * this is not a long-running process so it's fine
>>                  */
>> -               if (open_ctree(search, btrfs_sb_offset(0), 0))
>> +               root =3D open_ctree(search, 0, 0);
>> +               if (root)
>>                         ret =3D 0;
>>                 else
>>                         ret =3D 1;
>> @@ -821,6 +823,7 @@ devs_only:
>>                 free_fs_devices(fs_devices);
>>         }
>>  out:
>> +       close_ctree(root);
>>         free_seen_fsid(seen_fsid_hash);
>>         return ret;
>>  }
>>
>> Thanks,
>> Qu
>>>
>>>>
>>>> Despite that, I think the patch looks good to me.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>> +		if (open_ctree(search, btrfs_sb_offset(0), 0))
>>>>> +			ret =3D 0;
>>>>> +		else
>>>>> +			ret =3D 1;
>>>>> +	} else {
>>>>> +		ret =3D btrfs_scan_devices();
>>>>> +	}
>>>>>
>>>>>  	if (ret) {
>>>>>  		error("blkid device scan returned %d", ret);
>>>>>
>>>>
>>
