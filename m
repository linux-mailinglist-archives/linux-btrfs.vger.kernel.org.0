Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4578137C75
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2020 09:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgAKIu3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jan 2020 03:50:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39962 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgAKIu3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jan 2020 03:50:29 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00B8mZZ9074250;
        Sat, 11 Jan 2020 08:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=vAQ4Wh8f7jde2jDY0X7mlxQo7E6fiRQOgcz8er/CZ+o=;
 b=XGciat/dNLV2OEhjUMj+SfOy6oVYjMudbt0xJlSYm5smAy2b0bvjZNOjdXYNlnlbuCeM
 3hl39phHNEk3yELR7BP5lUCbth9tjiaQThPELrqTPJZdfDSLvYWkVC8HiiFgZmYY8kBd
 tEjULQwuVhnuIYD8QHWcFrS+esDbyLACJx5aRv5XLoIe7S6DB8rslbgmZ80L1aYymPfF
 oR8agdIh9rLiyBlJdj9IxmiejYdCYY/gaz88EXm34cni55lngAJo5ZS3PWibSDLU1oJx
 PW2D7Ym/ISxnMllWnnG352o4e6EpYDAL75i36s9F6YpYXI8yPeXO3ovcOCK4jxvFZS2I qA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xf73t8gfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Jan 2020 08:50:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00B8mc4I172596;
        Sat, 11 Jan 2020 08:50:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xf758burt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Jan 2020 08:50:26 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00B8oQ8b020425;
        Sat, 11 Jan 2020 08:50:26 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 11 Jan 2020 00:50:25 -0800
Subject: Re: [PATCH] btrfs: device stat, log when zeroed assist audit
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20200110042634.4843-1-anand.jain@oracle.com>
 <7b449175-4e73-7fe9-07b2-d1c04feeba8e@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <054ca606-1886-d7f3-64e2-b1a032034648@oracle.com>
Date:   Sat, 11 Jan 2020 16:50:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7b449175-4e73-7fe9-07b2-d1c04feeba8e@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9496 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001110075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9496 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001110075
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/10/20 11:07 PM, Josef Bacik wrote:
> On 1/9/20 11:26 PM, Anand Jain wrote:
>> We had a report indicating that some read errors aren't reported by
>> the device stats in the userland. It is important to have the errors
>> reported in the device stat as user land scripts might depend on it to
>> take the reasonable corrective actions. But to debug these issue we need
>> to be really sure that request to reset the device stat did not come
>> from the userland itself. So log an info message when device error reset
>> happens.
>>
>> For example:
>>   BTRFS info (device sdc): device stats zeroed by btrfs (9223)
>>
>> Reported-by: philip@philip-seeger.de
>> Link: https://www.spinics.net/lists/linux-btrfs/msg96528.html
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   BTRFS info (device sdc): device stats zeroed by btrfs (9223)
>> The last words are name and pid of the process, unfortunately it came out
>> as 'by btrfs'. At some point if there is a python and lib to reset it
>> would change, otherwise its going to be 'by btrfs', I am ok with it,
>> if otherwise please suggest the alternative.
> 
> I think name(pid) makes sense, similar to what drop_caches does
> 
> pr_info("%s (%d): drop_caches: %d\n",
>      current->comm, task_pid_nr(current),

There is a small deviation to what we already have in
device_list_add(), name (pid) is at the end the log message..

------
                         pr_info(
         "BTRFS: device label %s devid %llu transid %llu %s scanned by 
%s (%d)\n",
                                 disk_super->label, devid, 
found_transid, path,
                                 current->comm, task_pid_nr(current));
--------

I am not sure. Can David can tweak during merge ?

Thanks, Anand

> Thanks,
> 
> Josef

