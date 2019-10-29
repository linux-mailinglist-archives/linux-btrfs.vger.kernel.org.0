Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE22EE9048
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2019 20:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbfJ2TnG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Oct 2019 15:43:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40652 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbfJ2TnG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Oct 2019 15:43:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TJda0U039697;
        Tue, 29 Oct 2019 19:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=tcZ6kyL59M0mz3RKfleBvxUKESKcCbH5LPyvGyOIYH0=;
 b=rBHGul8yeIJkYp14Z/My2CWjzn8PwQAQmpMRyPbV7dZ466wNcdlStD2/tPkDGTVDNWqb
 EIjMTKfpcZiJVLbNq0uALKwz6X093lVwF81IZ6nxucu93rndb1Xf1b9ObxHVVLDweoJe
 Yl0Xd1T/UShdjQXRIA/Xux8dSCKwp7OHosVDywVLJ2whLutuj+WqOfMzMaSkRYmD1kMG
 EoknKM8bSb1dCr9SxFOb59rsourZOS6DCvT7uSsYOV7XAMh10Pk24cbzzOv9iGS0/3EC
 EyD82PvFZ6jGopedjK+f2xsxk11aThpEfwG/J2ogQgke7V6tNUYtM2owpak3+W9iF4KL Eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vve3qbgsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 19:43:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TJcSAi087624;
        Tue, 29 Oct 2019 19:43:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vxpgfhrmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 19:43:01 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9TJh0a1015425;
        Tue, 29 Oct 2019 19:43:01 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Oct 2019 12:43:00 -0700
Subject: Re: [RFC PATCH 0/3] btrfs-progs: make quiet to overrule verbose
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20191024062825.13097-1-anand.jain@oracle.com>
 <20191024154151.GI3001@twin.jikos.cz>
 <1166a5c7-8bc9-b93f-6f4c-8871b5fc394b@oracle.com>
 <7b97f0ce-1f62-09fa-ad86-6a4d0af40e1d@oracle.com>
 <20191025163555.GP3001@twin.jikos.cz>
 <79a8fa97-6aff-3698-2263-548fbb68baf0@oracle.com>
Message-ID: <0bf84f2d-d125-8c06-cb1a-e5498d84d196@oracle.com>
Date:   Wed, 30 Oct 2019 03:42:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <79a8fa97-6aff-3698-2263-548fbb68baf0@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910290169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910290169
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/10/19 9:01 AM, Anand Jain wrote:
> On 26/10/19 12:35 AM, David Sterba wrote:
>> On Fri, Oct 25, 2019 at 09:56:14AM +0800, Anand Jain wrote:
>>> On 25/10/19 7:51 AM, Anand Jain wrote:
>>>>
>>>>
>>>> On 24/10/19 11:41 PM, David Sterba wrote:
>>>>> On Thu, Oct 24, 2019 at 02:28:22PM +0800, Anand Jain wrote:
>>>>>> When both the options (--quiet and --verbose) in btrfs send and 
>>>>>> receive
>>>>>> is specified, we need at least one of it to overrule the other,
>>>>>> irrespective
>>>>>> of the chronological order of options.
>>>>>
>>>>> I think the common behaviour is to respect the order of appearance on
>>>>> the commandline.
>>>>
>>>>     I am fine with this. Will fix it as this.
>>>
>>>    Question: command -v -q -v should be equal to command -v, right?
>>
>> No, that would be equivalent to the default level:
>>
>> verbose starts with 1            ()
>> verbose++                (-v)
>> verbose = 0                (-q)
>> verbose++ is now 1, which is not -v    ()
>>
> 
> Oh I was thinking its a bug, and no need to carry forward to the global
> verbose. Will make it look like this.
> 

What do you think should be the final %verbose value when both
local and global verbose and or quiet options are specified?

For example:
  btrfs -v -q sub-command -v
  btrfs -q sub-command -v
  btrfs -vv sub-command -q
  etc..

Thanks, Anand

