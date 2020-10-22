Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAB929596A
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Oct 2020 09:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508762AbgJVHlJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Oct 2020 03:41:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54980 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508754AbgJVHlJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Oct 2020 03:41:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M7Z5Xg071403;
        Thu, 22 Oct 2020 07:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=hOFdlQ0lkw59CX6j4ty/yiur/My2IPJ9JX4l2EjdrQY=;
 b=cJRgod8ZB0BM0v47azVQWi7c6ev2CEA81c3ylgWf3lVjY6uzSz6AhTF8Jz6Tb80ZMUpy
 jE50GWPeEPULenw/j+LEaQFD59ErP966tVhaGZ8pId9caYVxmtmtYYAr/Smi77NpzblQ
 VUIGMVjlKbkqCeHzuHJ+WUGcFMuEIUfhw5WMJPXyengwNLR5c74j45YnxmVorls75z31
 vqzYm9LlNJ4lQujPni0thOcllTWfdYFYHEruquCn2NnDAqmLiUOHCOKtouEysuD0FsUG
 u9KdncufUWtuQ2KRDwn+ThZp+1074+3ms266uUOW2w2mW3zlwJ86V9iu4Y7Di1FMyfet AQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 349jrpvf9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Oct 2020 07:41:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M7ZgWM160779;
        Thu, 22 Oct 2020 07:41:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 348ah0hxjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Oct 2020 07:41:02 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09M7f1ih025374;
        Thu, 22 Oct 2020 07:41:01 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Oct 2020 00:41:01 -0700
Subject: Re: [PATCH v8 1/3] btrfs: add btrfs_strmatch helper
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1602756068.git.anand.jain@oracle.com>
 <7418ae34e5a4cc7d110eed756d9e37c5630ec568.1602756068.git.anand.jain@oracle.com>
 <e599667f-af00-7cbf-65c8-fb1151e66411@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a4cb483a-578f-0fd5-e65f-9b76f9f2fb7f@oracle.com>
Date:   Thu, 22 Oct 2020 15:40:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <e599667f-af00-7cbf-65c8-fb1151e66411@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220049
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21/10/20 10:44 pm, Josef Bacik wrote:
> On 10/20/20 10:02 AM, Anand Jain wrote:
>> Add a generic helper to match the golden-string in the given-string,
>> and ignore the leading and trailing whitespaces if any.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> Suggested-by: David Sterba <dsterba@suse.com>
>> ---
>> v5: born
>>
>>   fs/btrfs/sysfs.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 8424f5d0e5ed..eb0b2bfcce67 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -863,6 +863,29 @@ static ssize_t btrfs_generation_show(struct 
>> kobject *kobj,
>>   }
>>   BTRFS_ATTR(, generation, btrfs_generation_show);
>> +/*
>> + * Match the %golden in the %given. Ignore the leading and trailing 
>> whitespaces
>> + * if any.
>> + */
>> +static int btrfs_strmatch(const char *given, const char *golden)
>> +{
>> +    size_t len = strlen(golden);
>> +    char *stripped;
>> +
>> +    /* strip leading whitespace */
>> +    stripped = skip_spaces(given);
>> +
>> +    if (strncmp(stripped, golden, len) == 0) {
>> +        /* strip trailing whitespace */
>> +        if (strlen(skip_spaces(stripped + len)))
>> +            return -EINVAL;
> 
> if ((strncmp(stripped, golden, len) == 0) &&
>      (strlen(skip_spaces(stripped + len)) == 0))
>      return 0;

fixed in v9 as well.

Thanks, Anand

> 
> Thanks,
> 
> Josef
