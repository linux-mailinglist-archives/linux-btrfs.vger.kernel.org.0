Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 872C915AAE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 15:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgBLOYj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 09:24:39 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33078 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgBLOYj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 09:24:39 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CEN7AQ188716;
        Wed, 12 Feb 2020 14:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2020-01-29;
 bh=yR4bXLLdYXOrhDWOVLL2QlyJGpoOKlVp6NT6Bw7hpfY=;
 b=z5RuZVCd2rGn5i9ok51R0nr7P2lh0I4oKn1VQsx6ZIL0eLCKMIcFSt1F9HKoZ7UHxJFB
 facDYwRcXYE9A1+q+xI7l0q0PtNm/0wQapTdLaJTm5TrnYMppMnG10WgdjSZvctgciBQ
 ZYETgwWMKnymjrQ0fICuYmSbR9D7+4Z7jCP4vj2Y5XrzIsDEXJzcmLZuSGv7skXXrfbj
 niAqBFHazX8gCtswI6Ur2qNVazzVDCd7Zsnh+EYt4vBe46FEI9ETUvUPl9qU9REKq6iZ
 HJRmDihmAdrcrMGogd63R4IRGDR5pfy++HlXAq2phXiNJV8Oe7YVcj88TXHqWALcWprE EA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2y2p3sjj1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 14:24:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CENAEJ009095;
        Wed, 12 Feb 2020 14:24:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2y26fkcag2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 14:24:34 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01CEOX63024700;
        Wed, 12 Feb 2020 14:24:33 GMT
Received: from [10.191.56.83] (/10.191.56.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 06:24:33 -0800
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3 2/2] btrfs: sysfs, add read_policy attribute
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <b39e2e18-4116-f77b-df59-d39aa006ea93@applied-asynchrony.com>
 <20200108041647.2330-1-anand.jain@oracle.com>
 <20200129184950.GM3929@twin.jikos.cz>
Message-ID: <a6a71d58-7078-67a0-5bbd-c4f7e0c5e08d@oracle.com>
Date:   Wed, 12 Feb 2020 22:24:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129184950.GM3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120113
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/30/20 2:49 AM, David Sterba wrote:
> On Wed, Jan 08, 2020 at 12:16:47PM +0800, Anand Jain wrote:
>> Add
>>
>>   /sys/fs/btrfs/UUID/read_policy
>>
>> attribute so that the read policy for the raid1 and raid10 chunks can be
>> tuned.
>>
>> When this attribute is read, it shall show all available policies, and
>> the active policy is with in [ ], read_policy attribute can be written
>> using one of the items showed in the read.
>>
>> For example:
>> cat /sys/fs/btrfs/UUID/read_policy
>> [by_pid]
>> echo by_pid > /sys/fs/btrfs/UUID/read_policy
>> echo -n by_pid > /sys/fs/btrfs/UUID/read_policy
> 
> Dropping "by_" is a good thing, but it should be removed everywhere.
> Also '-n' to echo should not be necessary and the store handler of sysfs
> should deal with that.

My reference was Block device's scheduler [1],

[1]
cat /sys/block/sda/queue/scheduler
[mq-deadline] kyber none

/sys/block/sda/queue$ echo mq-deadline > ./scheduler
/sys/block/sda/queue$ echo "mq-deadline " > ./scheduler
/sys/block/sda/queue$ echo " mq-deadline " > ./scheduler
/sys/block/sda/queue$ echo -n mq-deadline > ./scheduler
/sys/block/sda/queue$ echo -n " mq-deadline " > ./scheduler
/sys/block/sda/queue$ echo -n " mq-deadline test" > ./scheduler
echo: write error: Invalid argument
/sys/block/sda/queue$ echo -n "mq-deadline kyber" > ./scheduler
echo: write error: Invalid argument

We could allow both echo and echo -n.

>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>> v3: rename [by_pid] to [pid]
>> v2: v2: check input len before strip and kstrdup
>>
>>   fs/btrfs/sysfs.c   | 66 ++++++++++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/volumes.h |  1 +
>>   2 files changed, 67 insertions(+)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 104a97586744..cc4a642878a1 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -809,6 +809,71 @@ static ssize_t btrfs_checksum_show(struct kobject *kobj,
>>   
>>   BTRFS_ATTR(, checksum, btrfs_checksum_show);
>>   
>> +static const inline char *btrfs_read_policy_name(enum btrfs_read_policy_type type)
>> +{
>> +	switch (type) {
>> +	case BTRFS_READ_BY_PID:
>> +		return "pid";
>> +	default:
>> +		return "null";
>> +	}
>> +}
> 
> A simple table should do, similar what we have for the compression
> number -> string mapping.
> 

  Yes. Much better thanks.

>> +
>> +static ssize_t btrfs_read_policy_show(struct kobject *kobj,
>> +				      struct kobj_attribute *a, char *buf)
>> +{
>> +	int i;
>> +	ssize_t len = 0;
> 
> As this is used as return value, plese rename it to 'ret'
> 

  Ok.

>> +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
>> +
>> +	for (i = 0; i < BTRFS_NR_READ_POLICY_TYPE; i++) {
>> +		if (len)
>> +			len += snprintf(buf + len, PAGE_SIZE, " ");
> 
> You can use the same thning for the separator as is in
> supported_checksums_show, ie. (i == 0 ? "" : " ") and add one more %s to
> the format.
> 
  Ok.

>> +		if (fs_devices->read_policy == i)
>> +			len += snprintf(buf + len, PAGE_SIZE, "[%s]",
>> +					btrfs_read_policy_name(i));
>> +		else
>> +			len += snprintf(buf + len, PAGE_SIZE, "%s",
>> +					btrfs_read_policy_name(i));
> 
> Keeping the default and the rest as separte calls to snprintf is
> probably better so with the separator it would be
> 
> 		if (fs_devices->read_policy == i)
> 			len += snprintf(buf + len, PAGE_SIZE, "%s[%s]",
> 					(i == 0 ? "" : " "),
> 					btrfs_read_policy_name(i));
> 		else
> 			len += snprintf(buf + len, PAGE_SIZE, "%s%s",
> 					(i == 0 ? "" : " "),
> 					btrfs_read_policy_name(i));
> 

  Yes. fixed.

>> +	}
>> +
>> +	len += snprintf(buf + len, PAGE_SIZE, "\n");
>> +
>> +	return len;
>> +}
>> +
>> +static ssize_t btrfs_read_policy_store(struct kobject *kobj,
>> +				       struct kobj_attribute *a,
>> +				       const char *buf, size_t len)
>> +{
>> +	int i;
>> +	char *stripped;
>> +	char *policy_name;
>> +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
>> +
>> +	if (len > BTRFS_READ_POLICY_NAME_MAX)
>> +		return -EINVAL;
>> +
>> +	policy_name = kstrdup(buf, GFP_KERNEL);
> 
> Can you avoid the allocation? None of the sysfs handlers should need it.
> 
>> +	if (!policy_name)
>> +		return -ENOMEM;
>> +
>> +	stripped = strstrip(policy_name);
> 
> So the allocation is to make a copy of a string to get rid of leading
> and trailing whitespace. There shouldn't be any leading space that we
> should care about, but anyway skip_spaces() can be used on a read-only
> string just fine.

  Ah. Yes.

> The trailing whitespace is for the potential '\n' that we want to
> handle. But doing an allocation here is an overkill, you can add a
> helper that will verify that there's no garbage at the end of the
> string, once the policy string matches one of ours.

  ok. Good idea.

Thanks, Anand

>> +
>> +	for (i = 0; i < BTRFS_NR_READ_POLICY_TYPE; i++) {
>> +		if (strncmp(stripped, btrfs_read_policy_name(i),
>> +			    strlen(stripped)) == 0) {
>> +			fs_devices->read_policy = i;
>> +			kfree(policy_name);
>> +			return len;
>> +		}
>> +	}
>> +
>> +	kfree(policy_name);
>> +	return -EINVAL;
>> +}
>> +BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, btrfs_read_policy_store);
>> +
>>   static const struct attribute *btrfs_attrs[] = {
>>   	BTRFS_ATTR_PTR(, label),
>>   	BTRFS_ATTR_PTR(, nodesize),
>> @@ -817,6 +882,7 @@ static const struct attribute *btrfs_attrs[] = {
>>   	BTRFS_ATTR_PTR(, quota_override),
>>   	BTRFS_ATTR_PTR(, metadata_uuid),
>>   	BTRFS_ATTR_PTR(, checksum),
>> +	BTRFS_ATTR_PTR(, read_policy),
>>   	NULL,
>>   };
>>   
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 46f4e2258203..fe1494d95893 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -209,6 +209,7 @@ BTRFS_DEVICE_GETSET_FUNCS(disk_total_bytes);
>>   BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
>>   
>>   /* read_policy types */
>> +#define BTRFS_READ_POLICY_NAME_MAX	12
> 
> And this can be dropped afterwards
> 
>>   #define BTRFS_READ_POLICY_DEFAULT	BTRFS_READ_BY_PID
>>   enum btrfs_read_policy_type {
>>   	BTRFS_READ_BY_PID,
>> -- 
>> 2.23.0

