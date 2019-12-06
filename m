Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F93115148
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 14:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfLFNrB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 08:47:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51354 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfLFNrB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 08:47:01 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB6DiVuL182113;
        Fri, 6 Dec 2019 13:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=exF4dxzPsJy4RWwTzBIetZM70CNzaQHtDEHLP2Z7ROQ=;
 b=kSBPBL0PrhtbbbQNGQ84z5arApPI8lYptMqgvHirBKE1mWpTu86C6vq7Apy1mosOpqB7
 hqrFtbGnDyXPTeCCbXBZVDoJUxhQixynIzrc3EECyZqeF+R+Cyd3B2Ys177NrsRgTX3V
 9EeE/i7zL8HviPaMgQGD98K5JerGxrHFa3htDVx8+4jFJ6bXmsa3pyt1zEPV5yycyyi2
 KkbB9sdBVk8OueipIKb8Pur+JXhhoKz7VqyX7SmSeUdmZxdfVKtp1KsP+59QBKMIzUfE
 QtWLQuhf/+B4UMMVqGUKkVtvWRwS9TJkNxPWxKqmnAsUvWWPRyr5BwWgDXibCeTgBne+ iA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wkh2rv3vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Dec 2019 13:46:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB6DdEsI161119;
        Fri, 6 Dec 2019 13:46:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wqm0rqr3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Dec 2019 13:46:55 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB6DkscT022675;
        Fri, 6 Dec 2019 13:46:54 GMT
Received: from [10.186.51.247] (/10.186.51.247)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Dec 2019 05:46:54 -0800
Subject: Re: [PATCH 0/4] btrfs, sysfs cleanup and add dev_state
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20191205112706.8125-1-anand.jain@oracle.com>
 <20191205150022.GR2734@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <67aa265f-9eb7-b819-ec07-b1c40600e2cb@oracle.com>
Date:   Fri, 6 Dec 2019 21:46:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191205150022.GR2734@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9462 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912060118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9462 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912060119
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5/12/19 11:00 PM, David Sterba wrote:
> On Thu, Dec 05, 2019 at 07:27:02PM +0800, Anand Jain wrote:
>> Anand Jain (4):
>>    btrfs: sysfs, use btrfs_sysfs_remove_fsid in fail return in add_fsid
>>    btrfs: sysfs, add UUID/devinfo kobject
>>    btrfs: sysfs, rename device_link add,remove functions
>>    btrfs: sysfs, add devid/dev_state kobject and attribute
> 
> So we can start adding things to devinfo, I did a quick test how the
> sysfs directory looks like, the base structure seems ok.
> 
> Unlike other sources for sysfs file data (like superblock), the devices
> can appear and disappear during the lifetime of the filesystem and as
> pointed out in the patches, some synchronization is needed.
> 
> But it could be more tricky. Reading from the sysfs files should not
> block normal operation (no device_list_mutex) but also must not lead to
> use-after-free in case the device gets deleted.
> 
> I haven't found a simple locking scheme that would avoid accessing a
> freed device structure, the sysfs callback can happen at any time and
> the structure can be freed already.
> 
> So this means that btrfs_sysfs_dev_state_show cannot access it directly
> (using offsetof(kobj, ...)). The safe (but not necessarily the best) way
> I have so far is to track the device kobjects in the superblock and add
> own lock for accessing this structure.
> 
> This avoids increasing contention of device_list_mutex, each sysfs
> callback needs to take the lock first, lookup the device and print the
> value if it's found. Otherwise we know the device is gone.



> The lock is rwlock_t, sysfs callbacks take read-side, device deletion
> takes write possibly outside of the device_list_mutex before the device
> is actually going to be deleted. This relies on fairness of the lock so
> the write will happen eventually (even if there are many readers).
> 

  Yeah this makes sense to me. I completely forgot about the %device
  getting deleted while sysfs is reading. Let me fix in the patch 4/4.

