Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF8D25BE7D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 11:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgICJdi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 05:33:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52638 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgICJdg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 05:33:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0839OPnR135504;
        Thu, 3 Sep 2020 09:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fiNqnQPYLK3dafbFqSnGGPQuLI0Fb91poSMajJ1t7S4=;
 b=gUvQ1xdO4iiS1wisb/4OeMBmlBj9V3CfvWZnl2i9b0yO5FQsJmp7b8WdmYhoS2jxfBot
 qeJ/q6xWZ9HShB55DqhH1OAbgFlKlLFyHzdpwRI8dzONo/kJst3YuxIfOHJ8pIwM1T7t
 7c/jBQIEpYhYDKEYT8F1PXzC+JvkLYHEqUbV4XWeNfpSDV8lqw3WZcayolH3iTDhrBtR
 XAHCBGdhGktj1JfpZAPNZ7VwSIMufyClrprv6VWshjl2d/qkF1fYjzmsArjlvXOtGBkX
 dqOodOKXHOhLRi0YnhOTaPoaciv+EItDfpPSdm853ZeQQpfWwdMTuKS8s0L3SKA4U3W8 Fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 337eymfmpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Sep 2020 09:33:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0839Q4YO083649;
        Thu, 3 Sep 2020 09:33:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 3380y1jk8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Sep 2020 09:33:30 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0839XTL5005561;
        Thu, 3 Sep 2020 09:33:29 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Sep 2020 02:33:29 -0700
Subject: Re: [PATCH 5/5] btrfs: Switch seed device to list api
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200715104850.19071-1-nborisov@suse.com>
 <20200715104850.19071-6-nborisov@suse.com>
 <09086e7f-a00d-a65f-e750-e833e7eba3cc@oracle.com>
 <2f98d441-ccb9-a2f0-2beb-eac7e526dee8@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <d3017c3a-62e3-d715-fee1-d23c7ce6ab57@oracle.com>
Date:   Thu, 3 Sep 2020 17:33:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <2f98d441-ccb9-a2f0-2beb-eac7e526dee8@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030086
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/9/20 5:03 pm, Nikolay Borisov wrote:
> 
> 
> On 2.09.20 г. 18:58 ч., Anand Jain wrote:
>>
>>
>> The seed of the current sprout should rather be at the head instead of
>> at the bottom.
>>
>>
>>> @@ -2397,7 +2381,7 @@ static int btrfs_prepare_sprout(struct
>>> btrfs_fs_info *fs_info)
>>>        fs_devices->open_devices = 0;
>>>        fs_devices->missing_devices = 0;
>>>        fs_devices->rotating = false;
>>> -    fs_devices->seed = seed_devices;
>>> +    list_add_tail(&seed_devices->seed_list, &fs_devices->seed_list);
>>
>>   It should be list_add_head.
> 
> Generally yes, but in this case I don't think it makes any functional
> differences so even adding at the tail is fine.
> 

  Hm No. Adding to the head matches to the order of dependency. As it 
was in the while loop.

Thanks, Anand



>>
>>>          generate_random_uuid(fs_devices->fsid);
>>>        memcpy(fs_devices->metadata_uuid, fs_devices->fsid,
>>> BTRFS_FSID_SIZE);
>>
>>
>>
>>
>>> @@ -6728,8 +6718,8 @@ static struct btrfs_fs_devices
>>> *open_seed_devices(struct btrfs_fs_info *fs_info,
>>>            goto out;
>>>        }
>>>    -    fs_devices->seed = fs_info->fs_devices->seed;
>>> -    fs_info->fs_devices->seed = fs_devices;
>>> +    ASSERT(list_empty(&fs_devices->seed_list));
>>> +    list_add_tail(&fs_devices->seed_list,
>>> &fs_info->fs_devices->seed_list);
>>
>>   It should be list_add_head.
>>
>>>    out:
>>>        return fs_devices;
>>>    }
>>
>>
>> Thanks, Anand
>>
