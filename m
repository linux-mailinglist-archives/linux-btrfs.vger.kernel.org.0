Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4824C13A19B
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 08:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgANHXj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 02:23:39 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55218 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgANHXi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 02:23:38 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E7MoVc168615;
        Tue, 14 Jan 2020 07:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=LhWHu2LdMhdnZJxVazKtQ8Ek2yZOswpP8TtzN7CIxEQ=;
 b=gCnGkmPLWIToVyuO6lfQ+vDbbl9p9n31xjFcRfXLQuO7y7y1VhxrkdR8qMQWm1jY30Vi
 TbShFnsrjObmu6xuLKNicWe4TFTU/fyLNve+Lb/IE/TPhWbENEdqIAtajVgRgb4tJVMb
 I+he99xYArktvuiQXnaYncdIRbrLdXJPaYZa5emj21wAzXfr7mgSLuS3qs++rMmLxpPi
 q4vv40pS2HupWOo79dhevymZbvVYbj9yp7j2M2iM7c3rBf/50p61ZAlc8vSNTB02jesb
 K74qhCspApV2/Yp8I9Ka/JtUYg26hYggQYB7UE74yJOn6gARgd7f2vwMhgdjdmwrQsKe Fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xf73tky1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 07:23:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E7JTcK093016;
        Tue, 14 Jan 2020 07:21:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2xh2tn7uhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 07:21:27 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00E7LQ1i031171;
        Tue, 14 Jan 2020 07:21:26 GMT
Received: from [10.191.49.251] (/10.191.49.251)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 23:21:26 -0800
Subject: Re: [PATCH 1/4] btrfs: add NO_FS_INFO to btrfs_printk
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
References: <20200114060920.4527-1-anand.jain@oracle.com>
 <cfd79de2-fa25-c112-0540-3c3058379275@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <6f0db474-905e-02f3-41e4-6cb842d776e3@oracle.com>
Date:   Tue, 14 Jan 2020 15:21:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cfd79de2-fa25-c112-0540-3c3058379275@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001140063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001140064
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14/1/20 2:54 PM, Qu Wenruo wrote:
> 
> 
> On 2020/1/14 下午2:09, Anand Jain wrote:
>> The first argument to btrfs_printk() wrappers such as
>> btrfs_warn_in_rcu(), btrfs_info_in_rcu(), etc.. is fs_info, but in some
>> context like scan and assembling of the volumes there isn't fs_info yet,
>> so those code generally don't use the btrfs_printk() wrappers and it
>> could could still use NULL but then it would become hard to distinguish
>> whether fs_info is NULL for genuine reason or a bug.
>>
>> So introduce a define NO_FS_INFO to be used instead of NULL so that we
>> know the code where fs_info isn't initialized and also we have a
>> consistent logging functions. Thanks.
> 
> I'm not sure why this is needed.
> 
> Could you give me an example in which NULL is not clear enough?
> 

The first argument in btrfs_info_in_rcu() can be NULL like for example.. 
btrfs_info_in_rcu(NULL, ..) which then it shall print the prefix..

    BTRFS info (device <unknown>):

  Lets say due to some bug local copy of the variable fs_info wasn't 
initialized then we end up printing the same unknown <unknown>.

   So in the context of device_list_add() as there is no fs_info 
genuinely and be different from unknown we use 
btrfs_info_in_rcu(NO_FS_INFO, ..) to get prefix something like..

  BTRFS info (device ...):

Thanks, Anand


> Thanks,
> Qu
> 
>>
>> Suggested-by: David Sterba <dsterba@suse.com>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/ctree.h |  5 +++++
>>   fs/btrfs/super.c | 14 +++++++++++---
>>   2 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 569931dd0ce5..625c7eee3d0f 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -110,6 +110,11 @@ struct btrfs_ref;
>>   #define BTRFS_STAT_CURR		0
>>   #define BTRFS_STAT_PREV		1
>>   
>> +/*
>> + * Used when we know that fs_info is not yet initialized.
>> + */
>> +#define	NO_FS_INFO	((void *)0x1)
>> +
>>   /*
>>    * Count how many BTRFS_MAX_EXTENT_SIZE cover the @size
>>    */
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index a906315efd19..5bd8a889fed0 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -216,9 +216,17 @@ void __cold btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, .
>>   	vaf.fmt = fmt;
>>   	vaf.va = &args;
>>   
>> -	if (__ratelimit(ratelimit))
>> -		printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
>> -			fs_info ? fs_info->sb->s_id : "<unknown>", &vaf);
>> +	if (__ratelimit(ratelimit)) {
>> +		if (fs_info == NULL)
>> +			printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
>> +				"<unknown>", &vaf);
>> +		else if (fs_info == NO_FS_INFO)
>> +			printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
>> +				"...", &vaf);
>> +		else
>> +			printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
>> +				fs_info->sb->s_id, &vaf);
>> +	}
>>   
>>   	va_end(args);
>>   }
>>
> 
