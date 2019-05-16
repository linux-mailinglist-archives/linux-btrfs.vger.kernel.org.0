Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23D98208A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 15:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfEPNye (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 09:54:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:37321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbfEPNyd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 09:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558014867;
        bh=3RntEpaAge8O1Uz2TIL6p62efVKECO0B5ZzEq0fLfDg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=B9ngkIIo8wmtMlRFFLONvkCmiC9wmdsSS8XMlBa571ZGcHASrjz+B9lokwQIePe0K
         Kvg7H20RII+Q4VLIh8dYuprZlWllp2tAp/APA7gbK80X6fHTYCxrKIq0qW6Iam4AtV
         WiV6/Cxva+PNXxYby5Gyg1tu7uQGBWQKBFch0jek=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTzfG-1hIurz3kuo-00QzXE; Thu, 16
 May 2019 15:54:27 +0200
Subject: Re: [PATCH 1/2] btrfs-progs: Correctly open filesystem on image file
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190516131250.26621-1-nborisov@suse.com>
 <e7a99dd5-5107-5da9-df95-6ad43bf8ad7e@gmx.com>
 <dc21e6b1-15c6-598a-4b63-3649ee57675f@suse.com>
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
Message-ID: <7214c003-5321-d1f1-a164-105dd8000415@gmx.com>
Date:   Thu, 16 May 2019 21:54:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <dc21e6b1-15c6-598a-4b63-3649ee57675f@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3i8QA9rdkOmSbXpvN3Wf1BSoq7xMmMtvbRd+S0dU1+Z0uQ7l5mQ
 DMzqOhjNP1UIJIqJ51sbC2cwcEEO/A++GEsa+APNfdqjoh0ZFmxIrKZe/87RoGvjY6jFFwd
 I4wW3eHHxJg9nAyV/iUifXg5GEbH5N8ScrsdV9tDaSZ+k7HnYZyfxarhGfpO2QaYIWTCyMu
 HB5eNlUzMkDQxJko1cXbg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2IYG1Y7w2UM=:13bk22/zIgXsaxJrkHv/rp
 iMny75zc4l8FJoX4LpGEPGgxz3aLvDGpX79zaftkw3Dbpj1VR+3e4CwnOcsrycrwZyfBW1v+h
 kHAQpvkSAIC26BRmt6/mIjy7o8xSRRptxBabvrCo6RQtkxYzCVTFi2opiQcIMC1TCMYrlfZU7
 ibb7AuL+LJQhVuEv3vxr6yoNSoMg0BB7hZTyT2zMNddBXJl3jdD5RwERUl1JrsQ8KYReomD3Q
 BLZn2R62k6em4qhX91tYZDP+gUQZr6lMZ9j+9gn+fa5tBkInt0DGbc0XOaDlU/f7bg/z/ulfZ
 tMciSL5l6m5Uwy+NfWnY0OcRp+IOd+D27SDDOx2rVux4FAUyJo5N7OpcfKoh7OW8PP9MfwXIv
 6yoeUp8yBFESLM5JWd3aA4/BN5+fWj4qlOCDNaItGtQ1s5+iA5pWdmBxIU8OT0Ni9D7ItvoKF
 An62ZAtzVTkkZrrmod6m3iMVvkYSlcuhy2TNPM5cE2E+AG8cGrZxgVpgX5Dhir8VfZQ3wNt/I
 X4AtY2jM3LPK7OPon5LldjPTYe70gU1DBBz4ZaF5GBvb2A7SPgzA/1Zhvb32yBvHfNyxUtrba
 kTPKdbI1dXPZqTVlXwzq3ID5OD+IT2K/Vums8QdMRA+myrkxVXbmaLz0cNsuyzUGdOxH+uplb
 QXSVUR6Y5ieH1qvJBXP++NG7RsH7t1Wsr5wuhgty1uDec7jKj5WRQnWDVZmwb6vXOenwpwgkI
 M4ps2Dxf4TiWPD+BYM9bpv6jXQJBtpBUWnn0faz5YhAIeX0EVCZGJl6n/iCTA3+DQSKuRSsij
 jEAn2O5HTQsuAA9+2nc05JVKhQC82LdLEqEWgz6Uclk6AMHLaGlK+3EzTCZkar+AfIUWA6oaV
 x1qTI8bT6X1kNyJD0s4144O1iujo+2Lz/q6pr+zQZvaoQBgsjOpP4c4O/AXkbHJLvKOf07lW5
 aWcb20VU9U+A7wDJUrGv/74okh/aHAvrtxxAQBIGg6dektTcd9vX3
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/5/16 =E4=B8=8B=E5=8D=889:45, Nikolay Borisov wrote:
>
>
> On 16.05.19 =D0=B3. 16:41 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2019/5/16 =E4=B8=8B=E5=8D=889:12, Nikolay Borisov wrote:
>>> When btrfs' 'filesystem' subcommand is passed path to an image file it
>>> currently fails since the code expects the image file is going to be
>>> recognised by libblkid (called from btrfs_scan_devices()). This is not
>>> the case since libblkid only scan well-known locations under /dev.
>>>
>>> Fix this by explicitly calling open_ctree which will correctly open
>>> the image and add it to the correct btrfs_fs_devices struct. This allo=
ws
>>> subsequent cmd_filesystem_show logic to correctly show requested
>>> information.
>>>
>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>> ---
>>>  cmds-filesystem.c | 13 ++++++++++++-
>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/cmds-filesystem.c b/cmds-filesystem.c
>>> index b8beec13f0e5..f55ce9b4ab85 100644
>>> --- a/cmds-filesystem.c
>>> +++ b/cmds-filesystem.c
>>> @@ -771,7 +771,18 @@ static int cmd_filesystem_show(int argc, char **a=
rgv)
>>>  		goto out;
>>>
>>>  devs_only:
>>> -	ret =3D btrfs_scan_devices();
>>> +	if (type =3D=3D BTRFS_ARG_REG) {
>>> +		/*
>>> +		 * We don't close the fs_info because it will free the device,
>>> +		 * this is not a long-running process so it's fine
>>> +		 */
>>
>> The comment makes sense, but I'm pretty sure we still prefer to clean i=
t up.
>>
>> Just something like:
>>
>> 	struct btrfs_root *root =3D NULL;
>>
>> 	root =3D open_ctree();
>> 	if (root)
>> 		ret =3D 0;
>> 	else
>> 		ret =3D 1;
>> 	close_ctree(root);
>
> Tested that and it doesn't work, because close_ctree will call
> btrfs_close_devices which frees existing devices so the test fails.

Sorry for the confusion, I missed "..." line before close_ctree(root);

I mean something like:

diff --git a/cmds-filesystem.c b/cmds-filesystem.c
index c4e43f8446dd..d20cbd49c201 100644
=2D-- a/cmds-filesystem.c
+++ b/cmds-filesystem.c
@@ -677,6 +677,7 @@ static int cmd_filesystem_show(int argc, char **argv)
 {
        LIST_HEAD(all_uuids);
        struct btrfs_fs_devices *fs_devices;
+       struct btrfs_root *root =3D NULL;
        char *search =3D NULL;
        int ret;
        /* default, search both kernel and udev */
@@ -779,7 +780,8 @@ devs_only:
                 * We don't close the fs_info because it will free the
device,
                 * this is not a long-running process so it's fine
                 */
-               if (open_ctree(search, btrfs_sb_offset(0), 0))
+               root =3D open_ctree(search, 0, 0);
+               if (root)
                        ret =3D 0;
                else
                        ret =3D 1;
@@ -821,6 +823,7 @@ devs_only:
                free_fs_devices(fs_devices);
        }
 out:
+       close_ctree(root);
        free_seen_fsid(seen_fsid_hash);
        return ret;
 }

Thanks,
Qu
>
>>
>> Despite that, I think the patch looks good to me.
>>
>> Thanks,
>> Qu
>>
>>> +		if (open_ctree(search, btrfs_sb_offset(0), 0))
>>> +			ret =3D 0;
>>> +		else
>>> +			ret =3D 1;
>>> +	} else {
>>> +		ret =3D btrfs_scan_devices();
>>> +	}
>>>
>>>  	if (ret) {
>>>  		error("blkid device scan returned %d", ret);
>>>
>>
