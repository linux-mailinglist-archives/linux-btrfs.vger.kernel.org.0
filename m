Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEF21142E0
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 15:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfLEOjd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 09:39:33 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36534 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbfLEOjc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 09:39:32 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5EdBLW032333;
        Thu, 5 Dec 2019 14:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=i7ULJ2zuuHfdz/841cV23KLrP4JEZLhPF+J/k8MA78I=;
 b=RP/4UAf5asL2pcoyblTNXMgle4qk+B2x1wgt7320/tBXosNlzFVRqp7GM7X3Cgbk+nnK
 GBV1sv9O/0PtJnuqBpa9uH51aRqoxPXVx/Ilq3w0Ja+yFwvJq16UyzG4s+ctnCjt1l2h
 Htpk/2j3e1dCXEPy2NkHycKmLAV3KU+bWZJrHY3ZVC7mvRfOyXa+6J49Wvf6KI0bkRNY
 CZsHbez3eGSqXZ438LpISVuIWb/vgAVfeZXSYpRnWsgtD3tg77RcS3f3XEW6OC5XwrPh
 QYafIfZ5sl7lxc7lRCFje4xS+gYTaHkbiEHZUrRKZH68kqe3d3rgTwEWT5pjlTR9esuG wQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wkh2rne7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Dec 2019 14:39:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5EdEan136118;
        Thu, 5 Dec 2019 14:39:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2wptnxhwj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Dec 2019 14:39:24 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB5EcMdw022952;
        Thu, 5 Dec 2019 14:38:22 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Dec 2019 06:38:22 -0800
Subject: Re: [PATCH 4/4] btrfs: sysfs, add devid/dev_state kobject and
 attribute
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20191205112706.8125-1-anand.jain@oracle.com>
 <20191205112706.8125-5-anand.jain@oracle.com>
 <20191205142148.GQ2734@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <78560abd-7d85-c95d-ed76-7810b1d03789@oracle.com>
Date:   Thu, 5 Dec 2019 22:38:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191205142148.GQ2734@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912050123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912050123
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12/5/19 10:21 PM, David Sterba wrote:
> On Thu, Dec 05, 2019 at 07:27:06PM +0800, Anand Jain wrote:
>> A new sysfs RW attribute
> 
> Why RW? Most attributes/files in sysfs are supposed to be read-only, but
> you actually define the attribute as read-only with the macro
> BTRFS_ATTR.
> 

  Oh. Change log has to be fixed here.

  But I am also working on a new patch to make this RW, to set the
  new read_preferred state on the device.

>>    UUID/devinfo/<devid>/dev_state
>> is added here. The dev_state here reflects the state of the device from
>> the kernel parameter btrfs_device::dev_state and this attribute is born
>> after the device is mounted and goes along with the dynamic nature of the
>> device add and delete. This attribute gets deleted at unmount.
>>
>> For example:
>> pwd
>>   /sys/fs/btrfs/6e1961f1-5918-4ecc-a22f-948897b409f7/devinfo
>> cat 1/dev_state
>>   IN_FS_METADATA MISSING
>> cat 2/dev_state
>>   WRITABLE IN_FS_METADATA
> 
> So the values copy the device state macros, that's probably ok.
> 
  Yep.

>> +static ssize_t btrfs_sysfs_dev_state_show(struct kobject *kobj,
>> +					  struct kobj_attribute *a, char *buf)
>> +{
>> +	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
>> +						   devid_kobj);
>> +
>> +	btrfs_dev_state_to_str(device, buf, PAGE_SIZE);
> 
> The device access is unprotected, you need at least RCU but that still
> does not prevent from the device being freed by deletion.

  We need RCU let me fix. Device being deleted is fine, there
  is nothing to lose, another directory lookup will show that
  UUID/devinfo/<devid> is gone is the device is deleted.

> The
> device_list_mutex is quite heavy and allowing a DoS by repeatedly
> reading the file contents is not something we want to allow.
> 

   Yes we don't have to use device_list_mutex here, as its read,
   a refresh/re-read will refresh the dev_state.

Thanks, Anand


