Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9FF29D597
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Oct 2020 23:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbgJ1WFX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 18:05:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53846 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729969AbgJ1WFV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 18:05:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SCSkDO177766;
        Wed, 28 Oct 2020 12:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=PeP18W0QTy/tvKaVKz+LFRNkUSMOlhDcDDaufZeA+/A=;
 b=G8P8fjtngGhC/1FLV65KQR+9YkemcXVrumvPygGyx++n/Pp9srBZXTAbVxfl0bh1njk4
 +jfEQu0Ohg8VJsMnF+sNgHLm7AfELekInWWeIw/SCXaK9HOpCcOtcID8F0Ak+iq9S5iM
 cM6hRs8ZR6Pf8F17zw7VtsoMdeUV65iS7C0YsPrv5WJTOluNyPiZV2VKSSLqvx7mDD1M
 62NUDlnsVYoKI2M3exfqVMRIuzsZcVHS8DubGEYVbF1XpHnBELESeODHkABWQmLXQcbD
 go0spYu+CPeuBj/+tJ+ScmJot3hCAQg8gCFHFrkZO4zh6KRkQPw1q8TELU3RSZexme1O FQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34dgm44sdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 12:38:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SCUnCa049537;
        Wed, 28 Oct 2020 12:38:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 34cwunhy92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 12:38:03 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09SCc1Up017241;
        Wed, 28 Oct 2020 12:38:01 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 05:38:00 -0700
Subject: Re: [PATCH v9 3/3] btrfs: create read policy sysfs attribute, pid
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.com
References: <cover.1603347462.git.anand.jain@oracle.com>
 <abd366082eeb8b289cd420cb04528a687a250433.1603347462.git.anand.jain@oracle.com>
 <20201026175750.GT6756@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <fd2cf101-f983-9780-00d8-9f6765af0ad3@oracle.com>
Date:   Wed, 28 Oct 2020 20:37:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201026175750.GT6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280085
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/10/20 1:57 am, David Sterba wrote:
> On Thu, Oct 22, 2020 at 03:43:37PM +0800, Anand Jain wrote:
>> Add
>>
>>   /sys/fs/btrfs/UUID/read_policy
>>
>> attribute so that the read policy for the raid1, raid1c34 and raid10 can
>> be tuned.
>>
>> When this attribute is read, it shall show all available policies, with
>> active policy being with in [ ]. The read_policy attribute can be written
>> using one of the items listed in there.
>>
>> For example:
>>    $cat /sys/fs/btrfs/UUID/read_policy
>>    [pid]
>>    $echo pid > /sys/fs/btrfs/UUID/read_policy
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v9: fix C coding style, static const char*
>> v5:
>>    Title rename: old: btrfs: sysfs, add read_policy attribute
>>    Uses the btrfs_strmatch() helper (BTRFS_READ_POLICY_NAME_MAX dropped).
>>    Use the table for the policy names.
>>    Rename len to ret.
>>    Use a simple logic to prefix space in btrfs_read_policy_show()
>>    Reviewed-by: Josef Bacik <josef@toxicpanda.com> dropped.
>>
>> v4:-
>> v3: rename [by_pid] to [pid]
>> v2: v2: check input len before strip and kstrdup
>>
>>   fs/btrfs/sysfs.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 5ea262d289c6..e23ae3643527 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -883,6 +883,54 @@ static int btrfs_strmatch(const char *given, const char *golden)
>>   	return -EINVAL;
>>   }
>>   
>> +static const char * const btrfs_read_policy_name[] = { "pid" };
>> +
>> +static ssize_t btrfs_read_policy_show(struct kobject *kobj,
>> +				      struct kobj_attribute *a, char *buf)
>> +{
>> +	int i;
>> +	ssize_t ret = 0;
>> +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
>> +
>> +	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
>> +		if (fs_devices->read_policy == i)
>> +			ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s[%s]",
> 
> All snprintf have been upgraded to scnprintf as it does have sane
> behaviour when the buffer is not large enough.

This is taken care in v10.

Thanks, Anand

> 
>> +					(ret == 0 ? "" : " "),
>> +					btrfs_read_policy_name[i]);
>> +		else
>> +			ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
>> +					(ret == 0 ? "" : " "),
>> +					btrfs_read_policy_name[i]);
>> +	}
>> +
>> +	ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
>> +
>> +	return ret;
>> +}

