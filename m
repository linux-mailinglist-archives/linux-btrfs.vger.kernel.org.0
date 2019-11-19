Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE3010116B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 03:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfKSCpN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 21:45:13 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47696 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfKSCpN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 21:45:13 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ2d2U6003857;
        Tue, 19 Nov 2019 02:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=kVYtulNDwODEgytq0iZ6SCI55jQt0D38yNGGj2vGtEs=;
 b=BjQDnxJkHvuqyHcVA7K2hkHN7mtIQ6gRLwnBh2+y3XBsyaIPYCZX0EEK6tUAFqSCyUcn
 NAptdHgs837KpaJfG5T+eswJLdfBq6o+lnLr9SD8Y4+RoF1buc9piQlD9JpWIJs/5vwU
 MAE7aLTo4dFVpHquMeqmZ/ctNzMSqTMqq8PnZKlRqaDCXKUnXMaeb9K9hzQ/ovfxx/su
 v9M8nmiuf6Ph8agMlBICK/QquUCTLkhQ3f3lwvt0Y5fUt8Z+ezz8lPRyY3C2or7DyCWj
 Uvnfn7io4+R5jbGCCnEX6hPhej0Uo3J8SGOWYO6JFxaGoDEgzr665jYKoQP7PCX+k7Hu Dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wa92pm0d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 02:45:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ2hkbb117639;
        Tue, 19 Nov 2019 02:45:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2wbxm3gg45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 02:45:08 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAJ2j7cM012857;
        Tue, 19 Nov 2019 02:45:07 GMT
Received: from [172.20.10.3] (/183.90.36.224)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 18:45:07 -0800
Subject: Re: [PATCH v1.1 04/18] btrfs-progs: add global verbose and quiet
 options and helper functions
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
 <1572849196-21775-5-git-send-email-anand.jain@oracle.com>
 <20191114160813.GK3001@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <adb7f077-e45c-98de-a409-d374cfd41efd@oracle.com>
Date:   Tue, 19 Nov 2019 10:44:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191114160813.GK3001@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190023
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/15/19 12:08 AM, David Sterba wrote:
> On Mon, Nov 04, 2019 at 02:33:02PM +0800, Anand Jain wrote:
>>   /*
>> + * Global verbose option for the sub-commands
>> + */
>> +#define HELPINFO_GLOBAL_OPTIONS_HEADER						\
>> +	"",									\
>> +	"Global options:"
>> +#define HELPINFO_INSERT_VERBOSE							\
>> +	"-v|--verbose       show verbose output"
>> +#define HELPINFO_INSERT_QUIET							\
>> +	"-q|--quiet         run the command quietly"
>> +
>> +/*
>>    * Special marker in the help strings that will preemptively insert the global
>>    * options and then continue with the following text that possibly follows
>>    * after the regular options
> 
> I've realized there's more magic around the global options, because
> currently the --format option depends on the subcommand definition thus
> it can't be a static text like you do with the definition of
> HELPINFO_GLOBAL_OPTIONS_HEADER.
 >
> There's a special keyword that gets replaced, the verbose/quite options
> don't need that so it's just the plain textual definition/description.
> 
> As this is a simple fixup
> s/HELPINFO_GLOBAL_OPTIONS_HEADER/HELPINFO_INSERT_GLOBALS/, hold on with
> resending I might find more things or fix it myself.
> 
  As v2 is in progress I shall fix this.

Thanks, Anand
