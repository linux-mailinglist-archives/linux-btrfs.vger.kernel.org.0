Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAD11F68EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 15:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgFKNRk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 09:17:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52078 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgFKNRk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 09:17:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BDCPOe123250;
        Thu, 11 Jun 2020 13:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=w5z4mK/LtWZBnOdE5SC9WGu3/HUOYdR9r+3YTZKnwqU=;
 b=oeeFyurMt7mbLMQ9WGfMDIwlAQqKmLTyUhH8mOOy8hwFAZ+ZNVYQwMieElcxyEcJB/8D
 uY8i9jVfM4O2P3wlprdnST7gZwMUNwJdV8+gJAZcMUgokLbYMOY6JY6kxiATsHfABckm
 NnnmSC0UYTsuiAxPmK/GDBOHJ1iPjbtWfYVvFE8Yjvk1pOntnf2zeh3mK8k2YYt9MuhV
 C8QfzbMo/1nUWG5Ve343YiPvuVXLNT/ruarZCOwgFTRwaFiwq/+sPmv8qnQMce9JAFgu
 vu/WZbfGXLiHKoTn6gJ/wmLqhzQj/4YWObxuqqTWsJ8AxXabTBCCf4mxjQm+PG+K9gXC IQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31g2jrfu8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Jun 2020 13:17:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BDDnwi126092;
        Thu, 11 Jun 2020 13:17:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31gn31nkdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jun 2020 13:17:35 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05BDHXY1004076;
        Thu, 11 Jun 2020 13:17:34 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jun 2020 06:17:33 -0700
Subject: Re: [PATCH 1/8] btrfs-progs: quota rescan: add quiet option
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20200608063851.8874-1-anand.jain@oracle.com>
 <20200608063851.8874-2-anand.jain@oracle.com>
 <20200610083044.GF27795@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <743a28a8-0ab2-0aa6-6c83-f4702d97597f@oracle.com>
Date:   Thu, 11 Jun 2020 21:16:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610083044.GF27795@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006110103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006110103
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/6/20 4:30 pm, David Sterba wrote:
> On Mon, Jun 08, 2020 at 02:38:44PM +0800, Anand Jain wrote:
>> Enable the quiet option to the btrfs(8) quota rescan command.
>> Does the job quietly. For example:
>>    btrfs --quiet quota rescan
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   cmds/quota.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/cmds/quota.c b/cmds/quota.c
>> index 075fc79816ad..4a68f9db081b 100644
>> --- a/cmds/quota.c
>> +++ b/cmds/quota.c
>> @@ -108,6 +108,8 @@ static const char * const cmd_quota_rescan_usage[] = {
>>   	"",
>>   	"-s   show status of a running rescan operation",
>>   	"-w   wait for rescan operation to finish (can be already in progress)",
>> +	HELPINFO_INSERT_GLOBALS,
>> +	HELPINFO_INSERT_QUIET,
>>   	NULL
>>   };
>>   
>> @@ -172,7 +174,7 @@ static int cmd_quota_rescan(const struct cmd_struct *cmd, int argc, char **argv)
>>   	}
>>   
>>   	if (ret == 0) {
>> -		printf("quota rescan started\n");
>> +		pr_verbose(-1, "quota rescan started\n");
> 
> That the raw value -1 is used here is not nice, I assume it means print
> unless there was another setting of the verbosity (nothing if -q,
> otherwise yes).

  Yes that's right. In v3 I have defined -1 as

  #define MUST_LOG  -1

  I ran out of ideas to name it more sensibly, open to suggestions.


> 
>>   		fflush(stdout);
>>   	} else if (ret < 0 && (!wait_for_completion || e != EINPROGRESS)) {
>>   		error("quota rescan failed: %m");
>> -- 
>> 2.25.1

