Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A37277058
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 13:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgIXLzW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 07:55:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45404 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbgIXLzW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 07:55:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OBtIRU065376;
        Thu, 24 Sep 2020 11:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=SR55tr4CHgJMupaWI6pOv+wMImvTxoTR1wUCFqudhWw=;
 b=u74N8MPKlS9JboGn2hHav612kv3U4m+hnRN9gREbZneM+y4N/ZZqshb6mtRDGK93fPxt
 1XKlDypAib2VAZnzXXH19hCjeZm0f9zVtGyUdT4Y22zjR8TVLnhWSIn5k6HCVrFN6Pkz
 k5rcB+Uuxv9tD7nAuL2fQa5GcFAr4TqisJNc1kml5WLsBaR5nZEjrvLBKYqg7vd4bDEi
 dRtNaTEHA/cKx2J07Px3jcm4OAUhyOC3MaICKO2ehMUyNNYUeur7lpk0MN2TEyr8nNnA
 mmglI8WS4Bwo8SM6E/ldQXbb0NbtS3sq+ovI0Xb33RNy2rariHsflZCMN6T1JrHxuCCM tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33q5rgp1w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 11:55:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OBo9lD140988;
        Thu, 24 Sep 2020 11:55:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 33r28wwah5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 11:55:17 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08OBtH93011397;
        Thu, 24 Sep 2020 11:55:17 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Sep 2020 04:55:16 -0700
Subject: Re: [PATCH v2] btrfs: free device without BTRFS_MAGIC
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes.Thumshirn@wdc.com
References: <dbc067b24194241f6d87b8f9799d9b6484984a13.1600473987.git.anand.jain@oracle.com>
 <1ee9b318e3bb851aaec9c1efd1eadb117ad46638.1600741332.git.anand.jain@oracle.com>
 <a0dc643f-81ee-8450-1371-d5c7f89dd8db@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <64b0a260-c5da-cf23-c030-4fd9cfaac735@oracle.com>
Date:   Thu, 24 Sep 2020 19:55:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <a0dc643f-81ee-8450-1371-d5c7f89dd8db@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=2 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=2 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240094
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23/9/20 7:09 pm, Nikolay Borisov wrote:
> 
> 
> On 22.09.20 г. 6:13 ч., Anand Jain wrote:
>> Many things can happen after the device is scanned and before the device
>> is mounted.
>>
>> One such thing is losing the BTRFS_MAGIC on the device.
>>
>> If it happens we still won't free that device from the memory and causes
>> the userland to confuse.
>>
>> For example: As the BTRFS_IOC_DEV_INFO still carries the device path which
>> does not have the BTRFS_MAGIC, the btrfs fi show still shows device
>> which does not belong. As shown below.
>>
>> mkfs.btrfs -fq -draid1 -mraid1 /dev/sda /dev/sdb
>>
>> wipefs -a /dev/sdb
>> mount -o degraded /dev/sda /btrfs
>> btrfs fi show -m
>>
>> /dev/sdb does not contain BTRFS_MAGIC and we still show it as part of
>> btrfs.
>> Label: none  uuid: 470ec6fb-646b-4464-b3cb-df1b26c527bd
>>          Total devices 2 FS bytes used 128.00KiB
>>          devid    1 size 3.00GiB used 571.19MiB path /dev/sda
>>          devid    2 size 3.00GiB used 571.19MiB path /dev/sdb
>>
>> Fix is to return -ENODATA error code in btrfs_read_dev_one_super()
>> when BTRFS_MAGIC check fails, and its parent open_fs_devices() to
>> free the device in the mount-thread.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Has an fstest for this been submitted ?
> 

  This is fix for btrfs/198.


> <snip>
> 
