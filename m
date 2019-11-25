Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8B0F108BD4
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 11:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKYKhD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 05:37:03 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34728 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfKYKhD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 05:37:03 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY7l6021487;
        Mon, 25 Nov 2019 10:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=5k7gDTWCXnVdWZS3OA8yACh5YrMmj0TdHrPN1yixMsg=;
 b=Bd/0TUXVcC/YBm8zhK5J4oEi0t3TA51nCKsYsQH5v3USNDhBZhU3sPX5yaEVMsZN3IoM
 SXN3Z8NmwCDlskM/DU11WtkI6uUR8iCWr+1jbl2uaP3jWAUjJLuyEyDse669OzZKlbsH
 61flvs+4muksE4AuitWl2MQIM/dvABq4dDlcvHNX+ZYDoWis3IBJpdJFzE7mY8zwVpzV
 3YmjVN3LIQwQu606IyGr3CSqJRZLw7G99wAcZqCQzcaie/IzqQ00gHQo6kKEDpYzyvQ3
 WYBjOqOo2BdqRhf/f3j2LYDJ6hQWENB0z+6+AwXYteF76vI3mxQtv1VxjWWwKG9fChna Bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wevqpxrf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 10:36:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAXtgv173219;
        Mon, 25 Nov 2019 10:36:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wfe9erea1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 10:36:57 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAPAav1s015928;
        Mon, 25 Nov 2019 10:36:57 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 02:36:57 -0800
Subject: Re: [PATCH v1.1 04/18] btrfs-progs: add global verbose and quiet
 options and helper functions
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
 <1572849196-21775-5-git-send-email-anand.jain@oracle.com>
 <20191114160813.GK3001@twin.jikos.cz>
 <6852d675-0244-388e-899f-008dc53b6ad9@oracle.com>
 <20191119165147.GW3001@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <8e4e8164-ac80-bc2f-0196-1f86570c2e47@oracle.com>
Date:   Mon, 25 Nov 2019 18:36:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191119165147.GW3001@twin.jikos.cz>
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



On 11/20/19 12:51 AM, David Sterba wrote:
> On Tue, Nov 19, 2019 at 11:36:59AM +0800, Anand Jain wrote:
>>> As this is a simple fixup
>>> s/HELPINFO_GLOBAL_OPTIONS_HEADER/HELPINFO_INSERT_GLOBALS/, hold on with
>>> resending I might find more things or fix it myself.
>>>
>>
>> But there is one problem,  HELPINFO_INSERT_GLOBALS is already defined
>> as..
>>        Global options:
>>       --format TYPE      where TYPE is: text
>>
>> (ref: common/help.c   do_usage_one_command())
>>
>> Albeit all commands support --format text by default.
>>
>> But no sub-command is using the HELPINFO_INSERT_GLOBALS in its usage.
>>
>> Looks like its a good idea to separate title and the options, like
>> #define HELPINFO_INSERT_GLOBALS		"Global options:"
>> #define HELPINGO_INSERT_FORMAT		"--format TYPE"
> 
> Yeah, makes sense to split it, right now the format does not bring
> anything so that will be better done in a major release some time in the
> future when more commands have json output.

  Ok. In v2 I have split
   HELPINFO_GLOBAL_OPTIONS_HEADER into HELPINFO_INSERT_GLOBALS and
   HELPINGO_INSERT_FORMAT as above.

Thanks, Anand


>> As at the moment I am not sure if its safe to declare that all
>> sub-commands will support --format json (whenever we do that).
> 
> No, right now json output should not be declared anywhere.
> 
>> So with the defines split as above, in each sub-command-usage
>> we shall do..
>> 
>> -----------------------------------------
>> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
>> index 4f22089abeaa..f4dba38b4c17 100644
>> --- a/cmds/filesystem.c
>> +++ b/cmds/filesystem.c
>> @@ -631,6 +631,10 @@ static const char * const
>> cmd_filesystem_show_usage[] = {
>>           "-m|--mounted       show only mounted btrfs",
>>           HELPINFO_UNITS_LONG,
>>           "If no argument is given, structure of all present filesystems
>> is shown.",
>> +       HELPINFO_INSERT_GLOBALS,
>> +       HELPINFO_INSERT_FORMAT,
>> +       HELPINFO_INSERT_VERBOSE,
>> +       HELPINFO_INSERT_QUIET,
> 
> Sounds ok.
> 
