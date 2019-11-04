Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61578ED8F8
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 07:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfKDG1K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 01:27:10 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54376 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbfKDG1I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Nov 2019 01:27:08 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46OD48180004;
        Mon, 4 Nov 2019 06:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=hQZeWgvqDOpfb+Xevnhaz3cICIeWbRjiyGq0V1d0sFo=;
 b=sRWv/B4kXkagvgYY0EsqdjJWagtl57C6IcjCYOmlkUrNFtbZVKZ8mA98WzdNF/8tHxlT
 7yJNEcdBtyCV2euhBpFemkptv9haNxgWyI7hFUE3nRD8mAfx6jc6Sv4KQiMhxGcjiyxt
 Qv0SGUqz+yw7ln1I9zx5aGGf+9aTwqPhmV/VoZ3209NK+HKWZNQJl8v7jKJFhYsubFgK
 SeA73rUfr27xeuaLEzNB5oT4rw4CxMQ7DLaOsHVjTX1NdKYDlUcH92AKIBdNzTJ2p558
 ayFWmFMr2uUM/gNceqdcW58V9y+DbD1ntmlzEjsbk/sWYuqZQil0NvOviUZB2NLX83vg 5g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2w11rpn52c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 06:27:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46OMBh044896;
        Mon, 4 Nov 2019 06:27:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2w1k8u609a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 06:27:01 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA46R03o020394;
        Mon, 4 Nov 2019 06:27:00 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 03 Nov 2019 22:27:00 -0800
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [RFC PATCH 0/3] btrfs-progs: make quiet to overrule verbose
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20191024062825.13097-1-anand.jain@oracle.com>
 <20191024154151.GI3001@twin.jikos.cz>
 <1166a5c7-8bc9-b93f-6f4c-8871b5fc394b@oracle.com>
 <7b97f0ce-1f62-09fa-ad86-6a4d0af40e1d@oracle.com>
 <20191025163555.GP3001@twin.jikos.cz>
 <79a8fa97-6aff-3698-2263-548fbb68baf0@oracle.com>
 <0bf84f2d-d125-8c06-cb1a-e5498d84d196@oracle.com>
 <20191101151815.GV3001@twin.jikos.cz>
Message-ID: <cc5d4ad7-04c3-c752-65d0-3997a101e4b4@oracle.com>
Date:   Mon, 4 Nov 2019 14:26:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191101151815.GV3001@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040061
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/1/19 11:18 PM, David Sterba wrote:
> On Wed, Oct 30, 2019 at 03:42:56AM +0800, Anand Jain wrote:
>>>>>     Question: command -v -q -v should be equal to command -v, right?
>>>>
>>>> No, that would be equivalent to the default level:
>>>>
>>>> verbose starts with 1            ()
>>>> verbose++                (-v)
>>>> verbose = 0                (-q)
>>>> verbose++ is now 1, which is not -v    ()
>>>>
>>>
>>> Oh I was thinking its a bug, and no need to carry forward to the global
>>> verbose. Will make it look like this.
>>
>> What do you think should be the final %verbose value when both
>> local and global verbose and or quiet options are specified?
>>
>> For example:
>>    btrfs -v -q sub-command -v
>>    btrfs -q sub-command -v
>>    btrfs -vv sub-command -q
>>    etc..
> 
> Ah that's the conflicting part.

> I'd say treat all -v and -q equal,

  Umm I don't understand what is treating equal here.
  The sub-command already treats differently under sub-command options.
  As shown below.

       case 'v':
                 bconf.verbose++;
                 break;
       case 'q':
                 bconf.verbose = 0;
		break;


> so
> modify the bconf.verbose variable, and it's straightforward to document.
> Some time in the future we should also issue a warning for 'sub-command
> -v'.

  I am guessing you mean:- Warning option is deprecated ?

> The order makes it unintuitive so
> 
>    btrfs -q command -v
> 
> is going to be the default verbosity.

  default verbosity is 0? 1 ?
  As of now in send/receive default verbosity is 1. And rest
  of the sub-commands its 0.

  And as the -v is last to appear the command will be
  equivalent to 'btrfs sub-command -q -v' which is verbosity level 1.
  I hope this is reasonable.

> We can't ignore the sub-command
> part, and making it conditionally work in case there's no global
> verbosity setting is kind of complicating it.

  Umm. As of now in v1.1, the sub-command continues to operate on the
  global bconf.verbose values, which works very well. Please see v1.1
  in the ML.

> So let's take the simple approach, maybe we'll have second thought on
> that before release.
> 

  Sure. To simplify the discussion, in v1.1 cover-letter I have included
  verbosity implementation code sample, hope this helps.

verbosity code sample as in v1.1

Thanks, Anand


