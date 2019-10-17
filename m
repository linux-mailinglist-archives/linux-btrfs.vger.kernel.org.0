Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66EBFDA322
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 03:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388822AbfJQB2N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 21:28:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58544 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbfJQB2N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 21:28:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9H1JAQ0076085;
        Thu, 17 Oct 2019 01:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=rv1XnPZ8uoBsbGXrdViuea49sI1NZd4aRJWnHAEpYtM=;
 b=XZleZvzEas/A7p13YkJBY/0O6n1HEFNd2mbkU44TqvjYwY9KG9oGgTpi92i4xC1nVwLO
 +rvrT59PNuIk8uZb8VEMlnx72u7t9ip3ethIDLpwGQ8RCM5eeyY1LQIsQ5Qb/hG4vT1F
 GR+7Pn1LP8Zd+0ilQrTcxcWr7C5aaDLfG9UyzI8i08WMFMg1isJ36ASgWB4VFu19T9S7
 mllS7NxaBngxYQjdCid2YwiOGGbUpHi1KqTTity20Yr5g3LgIQozLp+YghDPyUjrUIah
 p9/SzpWBBPB4OBCmAV9JVwTMbQnaOy5gQXhbzJUzJFmnwcF54dwbC7yDgJzB+b7Tj7QK kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vk6sqtvyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 01:28:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9H1N4EZ051462;
        Thu, 17 Oct 2019 01:26:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vpcm1wcrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 01:26:06 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9H1Q4W6005768;
        Thu, 17 Oct 2019 01:26:05 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 01:26:04 +0000
Subject: Re: [PATCH] btrfs-progs: warn users about the possible dangers of
 check --repair
To:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     rbrown@suse.de,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191016140533.10583-1-jthumshirn@suse.de>
 <0b32b2d3-e473-dcbd-57b9-036b9505d145@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <77db6cb7-b1e9-7834-a454-b01b4d4a1f59@oracle.com>
Date:   Thu, 17 Oct 2019 09:25:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0b32b2d3-e473-dcbd-57b9-036b9505d145@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170007
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170007
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/16/19 10:31 PM, Nikolay Borisov wrote:
> 
> 
> On 16.10.19 г. 17:05 ч., Johannes Thumshirn wrote:
>> The manual page of btrfsck clearly states 'btrfs check --repair' is a
>> dangerous operation.
>>
>> Although this warning is in place users do not read the manual page and/or
>> are used to the behaviour of fsck utilities which repair the filesystem,
>> and thus potentially cause harm.
>>
>> Similar to 'btrfs balance' without any filters, add a warning and a
>> countdown, so users can bail out before eventual corrupting the filesystem
>> more than it already is.
>>
>> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
>> ---
>>   check/main.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/check/main.c b/check/main.c
>> index fd05430c1f51..acded927281a 100644
>> --- a/check/main.c
>> +++ b/check/main.c
>> @@ -9970,6 +9970,23 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>>   		exit(1);
>>   	}
>>   
>> +	if (repair) {
>> +		int delay = 10;
>> +		printf("WARNING:\n\n");
>> +		printf("\tDo not use --repair unless you are advised to do so by a developer\n");
>> +		printf("\tor an experienced user, and then only after having accepted that no\n");
>> +		printf("\tfsck successfully repair all types of filesystem corruption. Eg.\n");
>> +		printf("\tsome other software or hardware bugs can fatally damage a volume.\n");
> 
> nit: The word 'other' here is redundant, no ?
> 
>> +		printf("\tThe operation will start in %d seconds.\n", delay);
>> +		printf("\tUse Ctrl-C to stop it.\n");
>> +		while (delay) {
>> +			printf("%2d", delay--);
>> +			fflush(stdout);
>> +			sleep(1);
>> +		}
> 
> That's a long winded way to have a simple for  loop that prints 10 dots,
> 1 second apart.


>  IMO a better use experience would be to ask the user to
> confirm and if the '-f' options i passed don't bother printing the
> warning at all.

  Agreed. -f will suffice (at least make it non-default) is a good fix.
  But again as Qu pointed out our test cases will fail or old test case
  with new progs will fail.

Thanks, Anand

>> +		printf("\nStarting repair.\n");
>> +	}
>> +
>>   	/*
>>   	 * experimental and dangerous
>>   	 */
>>

