Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF8FE14627F
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 08:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgAWHW6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 02:22:58 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54986 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAWHW6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 02:22:58 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00N7HuuE130421;
        Thu, 23 Jan 2020 07:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=yRGPG/a1hBYUSlXKTi8b15y4LctRjBh209WYTd1izqw=;
 b=QbILDK994rOPJ6suyCgoF+/FdtMbjKEjLtJ6o1brCXW1ns9V65L0bg75BwYDNpVlUMdM
 ctTHfVnIdX9l2xL+WTyxszMSiqyFl8w00JMSbhhHYPmS/sz4/+7Sq9jCjN9LxtWlL10B
 h4m6jOSK6lc3Kg4NF933a5jyUTrwaiZQbWzmpZzy3m0aBx1/0X9NWBKlnf4sxtTrbPvA
 CYnqFGTzthoQDfFVZiEUMfsHw5HkfdTgfbepqSnz9EBdlOIv+1vtH3k7fmhua4WkBgYZ
 BmuRnA8F9Yk72ouodeErsDW+3hRkhdLYegKMdpCWiVcQdW8BxBkZF61uCNPhFJEKKQPq hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xktnrg7t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 07:22:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00N7JORQ121780;
        Thu, 23 Jan 2020 07:22:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xpq7m3u28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 07:22:49 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00N7MmKj007861;
        Thu, 23 Jan 2020 07:22:49 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Jan 2020 23:22:48 -0800
Subject: Re: [PATCH 1/4] btrfs: add NO_FS_INFO to btrfs_printk
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
References: <20200114060920.4527-1-anand.jain@oracle.com>
 <cfd79de2-fa25-c112-0540-3c3058379275@gmx.com>
 <6f0db474-905e-02f3-41e4-6cb842d776e3@oracle.com>
 <20200122155012.GA3929@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <60c5d589-e6bb-4fbe-58d1-68f11617dc5b@oracle.com>
Date:   Thu, 23 Jan 2020 15:22:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200122155012.GA3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001230062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9508 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001230062
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 1/22/20 11:50 PM, David Sterba wrote:
> On Tue, Jan 14, 2020 at 03:21:14PM +0800, Anand Jain wrote:
>> On 14/1/20 2:54 PM, Qu Wenruo wrote:
>>> On 2020/1/14 下午2:09, Anand Jain wrote:
>>>> The first argument to btrfs_printk() wrappers such as
>>>> btrfs_warn_in_rcu(), btrfs_info_in_rcu(), etc.. is fs_info, but in some
>>>> context like scan and assembling of the volumes there isn't fs_info yet,
>>>> so those code generally don't use the btrfs_printk() wrappers and it
>>>> could could still use NULL but then it would become hard to distinguish
>>>> whether fs_info is NULL for genuine reason or a bug.
>>>>
>>>> So introduce a define NO_FS_INFO to be used instead of NULL so that we
>>>> know the code where fs_info isn't initialized and also we have a
>>>> consistent logging functions. Thanks.
>>>
>>> I'm not sure why this is needed.
>>>
>>> Could you give me an example in which NULL is not clear enough?
>>
>> The first argument in btrfs_info_in_rcu() can be NULL like for example..
>> btrfs_info_in_rcu(NULL, ..) which then it shall print the prefix..
>>
>>      BTRFS info (device <unknown>):
>>
>>    Lets say due to some bug local copy of the variable fs_info wasn't
>> initialized then we end up printing the same unknown <unknown>.
>>
>>     So in the context of device_list_add() as there is no fs_info
>> genuinely and be different from unknown we use
>> btrfs_info_in_rcu(NO_FS_INFO, ..) to get prefix something like..
>>
>>    BTRFS info (device ...):
> 
> With the fixup to set fs_info to NULL on a device that's unmounted, do
> we still need the NO_FS_INFO stub?

  Its trivial we don't need NO_FS_INFO IMO.

>  The only difference I can see is a
> to print "..." instead of "<unknown>" that I don't find too useful or
> improving the output.

  Agree. Two ways we can make it better one use open code.
  Patch [1] disk that.
  [1]
  [PATCH 1/2] btrfs: open code log helpers in device_list_add()

  two, change btrfs_printk() and all its wrapper to use fs_devices
  instead of fs_info. It solves two purposes, device name
  does not make sense for logging of volume so will use fsid,
  and avoid confusion when the device errors are being reported.
  Secondly we could use btrfs_printk() wrappers in the unmounted context.
  And added bonus is logging becomes truly consistent.
  Let me know if you think this is the right way, will look into it.

> My idea about the stub fs info was to avoid any access to fs_info inside
> device_list_add in case we can't reliably close the race where scan can
> read device::fs_info during mount that sets it up, but as I'm told it's
> not a problem anymore.
  Using NULL instead of fs_info or open code or using fs_devices
  (as discussed above) will solve it.

  The analysis about the race needed few more information, so I am
  not sure.

  My idea is to make it theoretically correct. Using
  uninitialized fs_info in device_list_add is wrong.

Thanks, Anand
