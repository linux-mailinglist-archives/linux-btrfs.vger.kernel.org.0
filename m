Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD96277079
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 13:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbgIXL7C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 07:59:02 -0400
Received: from mout.gmx.net ([212.227.17.21]:45023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbgIXL7C (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 07:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600948735;
        bh=sJ7oqCMT9Er5Je7Ee7V8YXsNfAarvnzasxAfevcXvrw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CqCLKammkIE5S49WkFTpp6k47c+EDxTHeb0I3kmxYyxpITozGNLFSdgJ4Ja7dlJIe
         j3v/80cFyoaSlT5QLcHHOLY8CU24IymJzPcI5Ikw5QmPi2zu48qQfx8+1bYaGhdR35
         YBGqmACPZF5LM9NGeFDXFGDa3JOCAA9jFB/pEo1k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdNY8-1kuTbK1M92-00ZLYN; Thu, 24
 Sep 2020 13:58:55 +0200
Subject: Re: [PATCH 1/2] btrfs: drop never met condition of disk_total_bytes
 == 0
To:     Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com, dsterba@suse.com
References: <cover.1600940809.git.anand.jain@oracle.com>
 <4fea8a706aedf7407d6af7a545126511168e15f5.1600940809.git.anand.jain@oracle.com>
 <c9e538dd-c039-478c-d677-0e9dd95cfc39@suse.com>
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
Message-ID: <b879f134-5bf9-a28a-885a-750d39f29a63@gmx.com>
Date:   Thu, 24 Sep 2020 19:58:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c9e538dd-c039-478c-d677-0e9dd95cfc39@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oexcBFCUoHyY12mptNQSrwzq2svE4kG2rMRpSkNeAtv0A3t/py3
 dYdwzsTIbT3Om3zHXpbmXNBDB2J1FoqeoFpBFN9TN0lmP6Zo4D8ag/PjmPuD0zlYgdqKzXL
 8iFkOh60e0y/YspvOMJidb5ypI23EC6o0ebxDrqX/M4tQ3nVl9ZolISk5UzzgW/Y4t1fzlO
 MS7w//3hkImvdmN16oakw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WfhYL/ZwBK4=:MmN2HQTJ6+DItOZOy3j17A
 mKKIba0r5+Bs178dkxSHhRIP7FEHoqV36EK6BbFacTKpYtgYav9sRI1865cGLhwGRg0ebH/wT
 43Fq59cajL2SWz91KgtHH6F8/4xhkL6FPRrIoUJnh7tDOwJabhMqrUH/VelV6Jsx3HV1cFT60
 fb022VuhbGwacj/YtsI8DTCAhwCWqSwjERpI0dWhZHnNdtPxAn7XXkSIzLGhKXihoL+YnMYNb
 3aFOiTRDCEN1enejwlgzr2uMzjSFxSLyS3zVZ2bVsYUvjhUk9seq0R5bSNx8170jjuKe08Fwh
 OTzFsoZp9oeXOaUDaTTG1eAcIGREMrlIfL/9Rnc7dM8SsV7Zh0X2lyL6e3+hhbE1+2U0HMjvo
 yKSztsWQsLz8lN6wB92Jr3zUtQpud0TzCvYWp8lxgLIO6nf6KzLvnOCLp3h2aMDsGbG7DZ62U
 Ru2oWNRBG67zSmaNYUxxg9rue5Yix5291TIIPRViRyCZgbb4qICLjuLDIPMkxYc1PIAcoa4i5
 cut/H4N0H6WfRoQOeA1kMH3CBuaCd1V3wzK3MSY9XJS8MKyLq26ta/xYpY2bg7CjlrTbfrUwl
 +KdNY7D5nLLadBsgfkJVdhL5yByN0zxEQ5ezrGLR+xHpMtiIV2vM+4WILHvNOBRPjf81qIDwZ
 jqUGeNuBynpbaLbElc5RWKJHkZiibA+Q1Y8qDxzbIckNVxvKC+xU+V3Igo1WQvaYgJN8DBvyD
 1+nj0/5ZsAXs/AJ3HO6BK++fcpyYobMkTy/14qv4uI6VVAcQXLDrh6A8GJD0k/iHjEzQgE/53
 C6lCzlTXznrFfD9GTZIn/Eon4nUS/VlqGqhgGkI3GgCHCWISaIqWjgQ1qA6YSS4u/1egTqzvq
 yVD57FXHrwrBDYnz7xSKMcqxlFuJYpgaGpxWZ3qhMcUyKVRlnB8fMud0zkVoEfa54R/oyAAs6
 in0ugOpMNPrS012q2vOdwKgPW3Q5jyRsQb1plJVwRm+PwG9w/4v6tivA1UTdb4m+NdPeTnJri
 Z9e18+FtXQpQfk8TRc93sc7YeuX1K5DeWkwbkiU7hXFH858K5Q91TMeS6ZuZN/kw4PeMf0Olb
 DSpzKc3ru2Gh/+T3ltdDaWa97eRKdwINB+59gt03rSYaOlTxT4TYVdvJvh5JmJ8WeRpTYw+5U
 y75jfReDskJCMr+cgmtWa1V5F7DRxCaDa/GQOMmQNpdqfl/qbYuVehe0za4x9Gt/poxNc9EK8
 0+/7PayKjB2wZKLsnVgK862LlLmNSck8TMuOAGQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/24 =E4=B8=8B=E5=8D=887:48, Nikolay Borisov wrote:
>
>
> On 24.09.20 =D0=B3. 13:11 =D1=87., Anand Jain wrote:
>> btrfs_device::disk_total_bytes is set even for a seed device (the
>> comment is wrong).
>>
>> The function fill_device_from_item() does the job of reading it from th=
e
>> item and updating btrfs_device::disk_total_bytes. So both the missing
>> device and the seed devices do have their disk_total_bytes updated.
>>
>> So this patch removes the check dev->disk_total_bytes =3D=3D 0 in the
>> function verify_one_dev_extent()
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>  fs/btrfs/volumes.c | 15 ---------------
>>  1 file changed, 15 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 7f43ed88fffc..9be40eece8ed 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -7578,21 +7578,6 @@ static int verify_one_dev_extent(struct btrfs_fs=
_info *fs_info,
>>  		goto out;
>>  	}
>>
>> -	/* It's possible this device is a dummy for seed device */
>> -	if (dev->disk_total_bytes =3D=3D 0) {
>> -		struct btrfs_fs_devices *devs;
>> -
>> -		devs =3D list_first_entry(&fs_info->fs_devices->seed_list,
>> -					struct btrfs_fs_devices, seed_list);
>> -		dev =3D btrfs_find_device(devs, devid, NULL, NULL, false);
>> -		if (!dev) {
>> -			btrfs_err(fs_info, "failed to find seed devid %llu",
>> -				  devid);
>> -			ret =3D -EUCLEAN;
>> -			goto out;
>> -		}
>> -	}
>
> The commit which introduced this check states that the device with a
> disk_total_bytes =3D 0 occurs from clone_fs_devices called from open_see=
d.
> It seems the check is legit and your changelog doesn't account for that
> if it's safe you should provide description why is that.

And it would be even better to mention the fragmentation problem in the
man page for btrfs-convert.

The fragmentation problem is a little too complex to explain in the
error message nor usage.

Thanks,
Qu
>
>> -
>>  	if (physical_offset + physical_len > dev->disk_total_bytes) {
>>  		btrfs_err(fs_info,
>>  "dev extent devid %llu physical offset %llu len %llu is beyond device =
boundary %llu",
>>
