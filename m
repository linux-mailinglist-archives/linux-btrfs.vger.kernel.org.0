Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EC0258AF2
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 11:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIAJFL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 05:05:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35762 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgIAJFL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 05:05:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08194p3s158909;
        Tue, 1 Sep 2020 09:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=yUF1F+enXUsy1WzFlgtJX3emLG8qW0+sgqvJIXiMCk0=;
 b=pATlwZ0L/pvA9W9zY2fkyzvRsZZTwPnkzCJGdb1HMdcON6VuxnOgBCY4Vl9fwpSSL7tz
 0IEbJPlfuXaH/y4123gaPVa1qkx+s1Dvs5O9rY/Jxs8W6f1FxeBPyCizujWgGQCKhNQK
 7dXfxja15bLpEUpYUdzrvgaOXL0W7MyowBffzRKtMhkHEUhIx0ozjficXRh4AmJpJDxd
 wqr5e90dkSssvVyz7cfZFGi8IRSweASW3yCW3MSAGV6aZcrWa78aX2Rr2P7WgQgJAcEz
 iTJxuClaSNLkX6NqGA7zCrgR+4/vPu2LfOpXFHMVNPr97X8KqCPuSU51cr+ZID2Jl2Sa Jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 337eequ1m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Sep 2020 09:05:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08190xwM095886;
        Tue, 1 Sep 2020 09:03:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3380sra66n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Sep 2020 09:03:05 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 081934br005036;
        Tue, 1 Sep 2020 09:03:04 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Sep 2020 02:03:04 -0700
Subject: Re: [PATCH 04/11] btrfs: reada: use sprout device_list_mutex
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1598792561.git.anand.jain@oracle.com>
 <b5ad15e6583f4e61cfd44344ef17ea7a93f6bb57.1598792561.git.anand.jain@oracle.com>
 <aad607a0-89e4-27da-9d01-ab7ac95761c0@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <33a66be6-3d8e-fa60-d610-76bb272d67ec@oracle.com>
Date:   Tue, 1 Sep 2020 17:02:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <aad607a0-89e4-27da-9d01-ab7ac95761c0@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009010080
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 1/9/20 12:08 am, Josef Bacik wrote:
> On 8/30/20 10:40 AM, Anand Jain wrote:
>> On an fs mounted using a sprout-device, the seed fs_devices are 
>> maintained
>> in a linked list under fs_info->fs_devices. Each seed's fs_devices also
>> have device_list_mutex initialized to protect against the potential race
>> with delete threads. But the delete thread (at btrfs_rm_device()) is 
>> holding
>> the fs_info::fs_devices::device_list_mutex mutex which is sprout's
>> device_list_mutex instead of seed's device_list_mutex. Moreover, there
>> aren't any significient benefits in using the seed::device_list_mutex
>> instead of sprout::device_list_mutex.
>>
>> So this patch converts them of using the seed::device_list_mutex to
>> sprout::device_list_mutex.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> This doesn't apply cleanly to misc-next as of this morning.  Thanks,

   Kdave renamed the function to reada_start_for_fsdevs() dropping
   the __ prefix. Rebased my misc-next. I am sending V2.

Thanks, Anand

> 
> Josef
