Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D065E131D40
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 02:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgAGBbY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 20:31:24 -0500
Received: from mout.gmx.net ([212.227.15.19]:37691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbgAGBbY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 20:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578360678;
        bh=MxLv6chb5UMDk07dDAfRd5HMxBLFkNXpcO9sDa6j2Uw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UpFGptoXwwdNt06olRBQrfm1i70MK/9Te9C7GVNF/5rMy8y0QMbW039gPU8a/qxBd
         WDM9ChG+QcS+p2f0XdkqdyWBRDbEE9m7AJ9L/6ibqXmVYBu19aMAhInxhxqLojhqNM
         l+Q9v9I1WCTdB/+9vwDqkbgoggJiX6m6V3Uz84NI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.186] ([104.199.231.176]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N2mBa-1jrLoH0G6u-01337P; Tue, 07
 Jan 2020 02:31:18 +0100
Subject: Re: [PATCH 5/6] btrfs: copy fsid and metadata_uuid for pulled disk
 without INCOMPAT_METADATA_UUID
To:     Nikolay Borisov <nborisov@suse.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191212110132.11063-1-Damenly_Su@gmx.com>
 <20191212110132.11063-6-Damenly_Su@gmx.com>
 <4a825596-5e3b-8de4-2583-774a41e59db4@suse.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <4ed7ac86-e9d5-f389-247f-d14f8a8b5af7@gmx.com>
Date:   Tue, 7 Jan 2020 09:31:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <4a825596-5e3b-8de4-2583-774a41e59db4@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nrdc6QUyyN66a2uWbPGwZZHs+191uofX7ysQyB9wX2O2zZTIbyr
 mUfzoN+Wzw6wffxPXLm57i405Mia6S8Mhc0i1T5w+jR1WI2HUVLIHTB4CChTmjzdn6jlk90
 rEZrmHGV38+5jwbaBbT7Do7zPmgWuLEM8rDhjpR+2JVrgd0D9rAyDLuXjBibepp4xdO2plP
 5a6/0DOjHvNA+Ga4BSnEg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DSB7OguGF68=:0iDbDjbF1DF7xQp63f8heL
 0++oqnRWprBOEv6CgF749F4NuYhClx0HRbKNawecLi+oCuy+dEN+r3sMSV4kwqRFRGMGW0nZn
 OCjEHFasCwf4z9hqR10UJyTxWCpPvUTDiRUr0+AYrpikyfqIm26H10QQl4M2hNoXP0dDaNi4c
 ycQKdhtZ62QgicRcSmQKe/7I2E39APhjJMur7yPRapmdP97cxnTRoyA4ZqyQ1b2g9FHNVn/N4
 6PRadc/J3kfUH2kyCc9sjq4DZ1coMoQkqpEoYJv4EOPNzrZcacD3OvX8ZRRDQnXxaaWRSsTAG
 AcWhaBXicO1inw58T0q0A2i6H9XfRw9P/e128Bti4mR85I15IJVymokS+l4gPe0nZ1kNmggff
 qfZvg/IMhQh/dcg5xC4CwOk/P059IKSvFPPzs7lOR4/LdUh/z+uxyy0L/Lifhsi4H0J+P6BjC
 6g/aA7q3uarV0cEVNbAQoZbGHS5OqbJa0+xiPu1YkXkUsJJiOq2mbY3WIalKJTpTS791RAqLN
 GpAqLlcgylkYewPn8KBgdKJFnA022RKP3ZYRq+jqFUd/lMRjZ0YVWktouj81zVrWr7+mx/8gN
 JfxW8As2h9NZOB6eVqLAOLQ6akgFpuTmXx7yvROBOEkTIojuVGyG5U+DPTThjc6xQb4GIKjD3
 rafIBO+GSHTH5+yva5bVBSuJuU514wPmKcIE5+FZgTCrXSnoRIyNKMWbZfb1DknxyVZQQJTWL
 O+wowGclgBVrxBApQg3FYNV4umna991sOse2KbMPK6dwJLlKUJ/Y9g4ykj4ytyIVltexdP3YU
 OPXc2t7fsxvC2NgYV1F2teHEkNWM+Q3X5dSUNqisPKLdf2ZEC1Ip90q/JOqKli45k9fNqC/mF
 CNI1nFqMfeosmq42tn6f3dAs14skdtcaxv+G64BpLtfbljLRcRXAWVLk5cjyPAryUqnDU4EWQ
 ee7UkyA26Q9nQ/Zp6NBU0qvyJu7f5D53C7zfnnxKtB13/nLzlwrhOgmVYuzDH451p0ZwKxG1c
 p03/Fb1Yr6AdHWc7h9Y+tBOPqEdJQjndE2w1yl1sBqFsxPF2UW34WlA65XHqN8exMfw3oDfRK
 6u+C8TYfVg4V+O5aQAa18unjXexvmh02X3txOs7SHWuo/yeP0Ufp9ApJXcX2cfVYV0KvLC65P
 2+bcP54QnqM7wJElJtO9H676ppi2IMQM3+2Atj18G8k9UgoQIX2Orn36hiovMPuxBIRluu2kD
 B220prcvkug5f0ES8zF7bM9FpGqMfS6LqBkVX9rAYZyeoxRCT3vr/ptRDtRI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020/1/6 11:12 PM, Nikolay Borisov wrote:
>
>
> On 12.12.19 =D0=B3. 13:01 =D1=87., damenly.su@gmail.com wrote:
>> From: Su Yue <Damenly_Su@gmx.com>
>>
>> Since a scanned device may be the device pulled into disk without
>> metadata_uuid feature, there may already be changing devices there.
>> Here copy fsid and metadata_uuid for above case.
>>
>> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
>
>
> What does this patch fix, why is it needed? It seems to be independent
> of the split brain fixes?
>

Sorry for the messy and short commit log.
It's one of the split brain fixes.

As mails I replied you earlier, the case
is for device which succeed to sync in
the second transaction and is without
metadata_uuid feature. If there is fs_devices
already scanned, the device's fsid instead of
metadata_uuid(NULL here) should be copied into
the fs_devices->metada_uuid field.

Thanks.

>> ---
>>   fs/btrfs/volumes.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index faf9cdd14f33..b21ab45e76a0 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -964,13 +964,16 @@ static noinline struct btrfs_device *device_list_=
add(const char *path,
>>   	 * metadata_uuid/fsid values of the fs_devices.
>>   	 */
>>   	if (*new_device_added && fs_devices_found &&
>> -	    has_metadata_uuid && fs_devices->fsid_change &&
>> +	    fs_devices->fsid_change &&
>>   	    found_transid > fs_devices->latest_generation) {
>>   		memcpy(fs_devices->fsid, disk_super->fsid,
>>   		       BTRFS_FSID_SIZE);
>> -		memcpy(fs_devices->metadata_uuid,
>> -		       disk_super->metadata_uuid, BTRFS_FSID_SIZE);
>> -
>> +		if (has_metadata_uuid)
>> +			memcpy(fs_devices->metadata_uuid,
>> +			       disk_super->metadata_uuid, BTRFS_FSID_SIZE);
>> +		else
>> +			memcpy(fs_devices->metadata_uuid,
>> +			       disk_super->fsid, BTRFS_FSID_SIZE);
>>   		fs_devices->fsid_change =3D false;
>>   	}
>>
>>

