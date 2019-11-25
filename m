Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEF2108BD5
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 11:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfKYKhS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 05:37:18 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45518 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfKYKhS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 05:37:18 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY7I2006405;
        Mon, 25 Nov 2019 10:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=ioXwkebINcs40NTwm42Z7faphFTqlaWlYRYypr3A+oI=;
 b=Q3ZWrxJ/Kna5LxZpwHehEE/i+WF3zQAUbS7u9WGn54SBVoKbJQuXfm+ouPMglK6ozx0A
 f43FW+BGQZnTO9Y0fCdpbWMQy1GdLayCHH0kc95rGxHeCrX7QoJnlLdz00Rh9YWVQL6C
 MAIwEGZOhNa7NXteU4tO9mQxxtsMyj3vMUOHt7QeLh12i9iPJoOEbtK6bCN5S3+nQho6
 5SV9WQqtguFIWzrv5YZKUP8l9mun8IbvrTh0a3zygqa93oIRyhSz7tFU9DQBsdo+8p+S
 Ea42XaxBwuYLoVRaWaN+Q8tYahbiXPYuSBtdKAIvMXg47Tao9zRmP0EG8n0XJReR1lS/ Gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wewdqxn7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 10:37:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAXHP7191710;
        Mon, 25 Nov 2019 10:35:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2wfex64jm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 10:35:10 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAPAZ8VV031919;
        Mon, 25 Nov 2019 10:35:09 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 02:35:08 -0800
Subject: Re: [PATCH v1 08/18] btrfs-progs: filesystem defragment: use global
 verbose option
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
 <1572849196-21775-9-git-send-email-anand.jain@oracle.com>
 <20191114161653.GL3001@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <1d223c31-00f5-8201-f777-d67427453e94@oracle.com>
Date:   Mon, 25 Nov 2019 18:35:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191114161653.GL3001@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911250098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911250098
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/15/19 12:16 AM, David Sterba wrote:
> On Mon, Nov 04, 2019 at 02:33:06PM +0800, Anand Jain wrote:
>> Transpire global --verbose option down to the btrfs receive sub-command.
>>
>> Suggested-by: David Sterba <dsterba@suse.com>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   cmds/filesystem.c | 16 +++++++++-------
>>   1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
>> index 4f22089abeaa..819b9fd1fcc5 100644
>> --- a/cmds/filesystem.c
>> +++ b/cmds/filesystem.c
>> @@ -844,11 +844,12 @@ static const char * const cmd_filesystem_defrag_usage[] = {
>>   	"(e.g., files copied with 'cp --reflink', snapshots) which may cause",
>>   	"considerable increase of space usage. See btrfs-filesystem(8) for",
>>   	"more information.",
>> +	HELPINFO_GLOBAL_OPTIONS_HEADER,
>> +	HELPINFO_INSERT_VERBOSE,
> 
> Please not that this needs to be put right after the command options,
> ie. before the paragraph.
> 

This is fixed in v2.
