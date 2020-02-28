Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B25F817337C
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2020 10:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgB1JHK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Feb 2020 04:07:10 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42568 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgB1JHK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Feb 2020 04:07:10 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01S93Uva162577;
        Fri, 28 Feb 2020 09:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=tbza0jYYfBH50ICeqXbY9O6roEYNNZ03PY5H7yjkvoc=;
 b=anaDhu9vUXlCEpSpc12h2c2jHH97wKI2fuFjy++C3/LW+zmLMlJMLnxFFv2JfwT5zqWd
 uWSwsaAW0wq/OOk8TxUZ1iv8YHiO+Pg5CSWWg8FayLmhqkVIT3gZFN9LOCr1zNQ6C1VP
 J4mdBFVBrGtVfpj3aYFHAfZQgik6EPayq6GoS8q/81bP0tLeJFH8DZqp//6Q8isOQz4q
 GL02+AY2OrzXbpiahxsb0YzzImH9sA4kFlzHBe3MWojpr59FuxbWgeK0Ejm/wt8VX8Mt
 uoTjxUn8rRLO9zp7kiu+kHSCoVAPJvO8wbf0TNpNIVFoMR0GvJJK9YNqpvWpwiy14xxV Zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ydcsnsjk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 09:07:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01S92Ngi018070;
        Fri, 28 Feb 2020 09:07:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ydcs7y5jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 09:07:02 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01S971bS008558;
        Fri, 28 Feb 2020 09:07:01 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 01:07:01 -0800
Subject: Re: [PATCH] btrfs-progs: convert, warn if converting a fs which won't
 mount
To:     David Sterba <dsterba@suse.com>
References: <1582877026-5487-1-git-send-email-anand.jain@oracle.com>
 <af69d1ab-4609-d603-980c-b8a6cfb87f43@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Message-ID: <39c3e381-b49e-a571-d058-a01734b8b4a9@oracle.com>
Date:   Fri, 28 Feb 2020 17:06:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <af69d1ab-4609-d603-980c-b8a6cfb87f43@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280075
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2/28/20 4:27 PM, Qu Wenruo wrote:
> 
> 
> On 2020/2/28 下午4:03, Anand Jain wrote:
>> On aarch64 with pagesize 64k, btrfs-convert of ext4 is successful,
>> but it won't mount because we don't yet support subpage blocksize/
>> sectorsize.
>>
>>   BTRFS error (device vda): sectorsize 4096 not supported yet, only support 65536
>>
>> So in this case during convert provide a warning and a 10s delay to
>> terminate the command.
> 
> This is no different than calling mkfs.btrfs -s 64k on x86 system.
> And I see no warning from mkfs.btrfs.
> 
> Thus I don't see the point of only introducing such warning to
> btrfs-convert.
> 

I have equal weight-age on the choices if blocksize != pagesize viz..
   delay and warn (this patch)
   quit (Nikolay).
   keep it as it is without warning (Qu).

  Here we are dealing with already user data. Should it be different
  from mkfs?
  Quit is fine, but convert tool should it be system neutral?

  I am not sure.

  David, any idea?

Thanks, Anand

> Thanks,
> Qu
> 
>>
>> For example:
>>
>> WARNING: Blocksize 4096 is not equal to the pagesize 65536,
>>           converted filesystem won't mount on this system.
>>           The operation will start in 10 seconds. Use Ctrl-c to stop it.
>> 10 9 8 7 6 5 4^C
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   convert/main.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/convert/main.c b/convert/main.c
>> index a04ec7a36abf..f936ec37d30a 100644
>> --- a/convert/main.c
>> +++ b/convert/main.c
>> @@ -1140,6 +1140,21 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
>>   		error("block size is too small: %u < 4096", blocksize);
>>   		goto fail;
>>   	}
>> +	if (blocksize != getpagesize()) {
>> +		int delay = 10;
>> +
>> +		warning("Blocksize %u is not equal to the pagesize %u,\n\
>> +         converted filesystem won't mount on this system.\n\
>> +         The operation will start in %d seconds. Use Ctrl-C to stop it.",
>> +			blocksize, getpagesize(), delay);
>> +
>> +		while (delay) {
>> +			printf("%2d", delay--);
>> +			fflush(stdout);
>> +			sleep(1);
>> +		}
>> +	}
>> +
>>   	if (btrfs_check_nodesize(nodesize, blocksize, features))
>>   		goto fail;
>>   	fd = open(devname, O_RDWR);
>>
> 
