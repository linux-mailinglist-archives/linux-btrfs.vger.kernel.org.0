Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B0025764A
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 11:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgHaJPJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 05:15:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38892 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgHaJPH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 05:15:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07V8UDw1074874;
        Mon, 31 Aug 2020 09:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fYyrw+WoG9APLfmoiUN2xkWsJw8/gsBNGJ5Qh4eo2dI=;
 b=KAdY/ZucPOPLyI8kKYOtsIicVydk8O1r0m91NICoclCIACtutxJEinyOuiShZRT2l4+B
 zpKzbyr13O68BCcbItp4G/iH2e0dI92VpDAXU8P8327iGjEE33PVIK12M69MatVpELpG
 NTzljzRA1EtOarqgDWoWJRkauF4MlWqqDGtrFq+beGqOlc5WGj/DCJGHYjSYbIZrtV50
 EAZkqanNI81cu6Z6NXYk3kkoKGp40vjIFsi1pRnH9stt5GLeArZNxqxnJqbA35MXaeZh
 PVjZJowdoLW3e8CPJuxmXHk51lD4XqtPM6E/26dxsrSquQ+miC9V3lpt6/8FCr6bFjbc fA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 337qrhca10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Aug 2020 09:15:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07V8Tdxl170804;
        Mon, 31 Aug 2020 09:13:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3380xufa3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Aug 2020 09:13:01 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07V9CxhA025446;
        Mon, 31 Aug 2020 09:13:00 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 31 Aug 2020 02:12:59 -0700
Subject: Re: [PATCH 03/11] btrfs: refactor btrfs_sysfs_remove_devices_dir
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
References: <cover.1598792561.git.anand.jain@oracle.com>
 <170b1d35e76fc68131223839eb74c90557b5da3c.1598792561.git.anand.jain@oracle.com>
 <1c5e29f5-47e0-19fe-cf17-1038541debfc@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <437bf9c9-bd83-9aa2-5c2b-526af15f1e94@oracle.com>
Date:   Mon, 31 Aug 2020 17:12:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <1c5e29f5-47e0-19fe-cf17-1038541debfc@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008310051
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=2 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310051
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 31/8/20 4:58 pm, Nikolay Borisov wrote:
> 
> 
> On 30.08.20 г. 17:40 ч., Anand Jain wrote:
>> Similar to btrfs_sysfs_add_devices_dir() refactor, refactor
>> btrfs_sysfs_remove_devices_dir() so that we don't have to use the 2nd
>> argument to indicate whether to free all devices or just one device. So
>> this patch also adds a bit of cleanups and return value is dropped to
>> void.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> <snip>
> 
>> -/* when 2nd argument device is NULL, it removes all devices link */
>> -int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
>> -				   struct btrfs_device *device)
>> +void btrfs_sysfs_remove_fs_devices(struct btrfs_fs_devices *fs_devices)
>>   {
>> +	struct btrfs_device *device;
>>   	struct btrfs_fs_devices *seed_fs_devices;
>>   
>> -	if (device) {
>> -		btrfs_sysfs_remove_device(device);
>> -		return 0;
>> -	}
> 
> What branch is this based off of ? Because I don't see
> btrfs_sysfs_remove_device function at all ?

  btrfs_sysfs_remove_device() is added in the patch 1/11 in this set.
  Anyways this is based on misc-next last commit 381ebd340264.


> 
> <snip>
> 
