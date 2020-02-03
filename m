Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE4DF1500D9
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 05:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgBCEGY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Feb 2020 23:06:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36504 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgBCEGY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Feb 2020 23:06:24 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0134381Q068731;
        Mon, 3 Feb 2020 04:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=vYBM2Hek9P3EEAEqFb8ccD89olYEAiAbXf2gaGxpANA=;
 b=mTCiKX4kFSMFmLnw5mfdw39QsGhSSkFYPl3vBLguYlQLmH3W4iy/Lresl0aEvs87mSl3
 jLcpHQDhmku0Im3IyuNizPjFZ2rLaNfGGQyrBKQ51i0V2869G1fINUILtaoQITCpkohA
 gLUa1hvwcFRMIUzDpG8+/4KG6QZgzvshDLGoQQ04FZHcJZjCWf8qDiUhHjjH4j+Mv+B1
 BonpFbqnWyq/bx5/ThgsqFcL/8zolInGFewSXNYNTryD/fxeD3z1SL1QcQmjRzOK/+8C
 QUrlrAI4viMaR+KnBlJL5qeuFstkm2gTDyByNehvfGCraXFmRgXghCt6jGgalZr3e5NW wQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xwyg99c1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Feb 2020 04:06:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0133x4LN089676;
        Mon, 3 Feb 2020 04:06:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xwkfs61kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Feb 2020 04:06:20 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01346Iuv022795;
        Mon, 3 Feb 2020 04:06:19 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 02 Feb 2020 20:06:18 -0800
Subject: Re: [PATCH 1/4] btrfs: add NO_FS_INFO to btrfs_printk
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20200114060920.4527-1-anand.jain@oracle.com>
 <cfd79de2-fa25-c112-0540-3c3058379275@gmx.com>
 <6f0db474-905e-02f3-41e4-6cb842d776e3@oracle.com>
 <20200122155012.GA3929@twin.jikos.cz>
 <60c5d589-e6bb-4fbe-58d1-68f11617dc5b@oracle.com>
Message-ID: <2fb7aad9-2672-5cd7-9896-d40994f4c1bb@oracle.com>
Date:   Mon, 3 Feb 2020 12:06:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <60c5d589-e6bb-4fbe-58d1-68f11617dc5b@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9519 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002030030
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9519 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002030030
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David,

  Ping on this.
  Any idea if the open code as in the patch below [1] is better
  or how do we fix it? My proposal about using fsid in the
  btrfs_printk() instead of current sb->s_id is another choice.

  [1]
  [PATCH 1/2] btrfs: open code log helpers in device_list_add()

  I think for now make it open code as in [1] so it stands correct.

Thanks, Anand


On 23/1/20 3:22 PM, Anand Jain wrote:
> 
> 
> On 1/22/20 11:50 PM, David Sterba wrote:
>> On Tue, Jan 14, 2020 at 03:21:14PM +0800, Anand Jain wrote:
>>> On 14/1/20 2:54 PM, Qu Wenruo wrote:
>>>> On 2020/1/14 下午2:09, Anand Jain wrote:
>>>>> The first argument to btrfs_printk() wrappers such as
>>>>> btrfs_warn_in_rcu(), btrfs_info_in_rcu(), etc.. is fs_info, but in 
>>>>> some
>>>>> context like scan and assembling of the volumes there isn't fs_info 
>>>>> yet,
>>>>> so those code generally don't use the btrfs_printk() wrappers and it
>>>>> could could still use NULL but then it would become hard to 
>>>>> distinguish
>>>>> whether fs_info is NULL for genuine reason or a bug.
>>>>>
>>>>> So introduce a define NO_FS_INFO to be used instead of NULL so that we
>>>>> know the code where fs_info isn't initialized and also we have a
>>>>> consistent logging functions. Thanks.
>>>>
>>>> I'm not sure why this is needed.
>>>>
>>>> Could you give me an example in which NULL is not clear enough?
>>>
>>> The first argument in btrfs_info_in_rcu() can be NULL like for example..
>>> btrfs_info_in_rcu(NULL, ..) which then it shall print the prefix..
>>>
>>>      BTRFS info (device <unknown>):
>>>
>>>    Lets say due to some bug local copy of the variable fs_info wasn't
>>> initialized then we end up printing the same unknown <unknown>.
>>>
>>>     So in the context of device_list_add() as there is no fs_info
>>> genuinely and be different from unknown we use
>>> btrfs_info_in_rcu(NO_FS_INFO, ..) to get prefix something like..
>>>
>>>    BTRFS info (device ...):
>>
>> With the fixup to set fs_info to NULL on a device that's unmounted, do
>> we still need the NO_FS_INFO stub?
> 
>   Its trivial we don't need NO_FS_INFO IMO.
> 
>>  The only difference I can see is a
>> to print "..." instead of "<unknown>" that I don't find too useful or
>> improving the output.
> 
>   Agree. Two ways we can make it better one use open code.
>   Patch [1] disk that.
>   [1]
>   [PATCH 1/2] btrfs: open code log helpers in device_list_add()
> 
>   two, change btrfs_printk() and all its wrapper to use fs_devices
>   instead of fs_info. It solves two purposes, device name
>   does not make sense for logging of volume so will use fsid,
>   and avoid confusion when the device errors are being reported.
>   Secondly we could use btrfs_printk() wrappers in the unmounted context.
>   And added bonus is logging becomes truly consistent.
>   Let me know if you think this is the right way, will look into it.
> 
>> My idea about the stub fs info was to avoid any access to fs_info inside
>> device_list_add in case we can't reliably close the race where scan can
>> read device::fs_info during mount that sets it up, but as I'm told it's
>> not a problem anymore.
>   Using NULL instead of fs_info or open code or using fs_devices
>   (as discussed above) will solve it.
> 
>   The analysis about the race needed few more information, so I am
>   not sure.
> 
>   My idea is to make it theoretically correct. Using
>   uninitialized fs_info in device_list_add is wrong.
> 
> Thanks, Anand

