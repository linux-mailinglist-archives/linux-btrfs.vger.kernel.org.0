Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3067D21D506
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 13:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgGMLdK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 07:33:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39834 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbgGMLdK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 07:33:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DBQqd9004406;
        Mon, 13 Jul 2020 11:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ej0zrZNQiX/HPGjC/2BwwYwjonQPxWHgYcNVUYMkJYs=;
 b=keHPpx3IJY8i5aZeFLOun2iAMsPBP91IerGOe04DDNahFzxM6vsyxzN572SHgSdUVpJ/
 O/tknMs6sIEUP2kHFgUD6E03MzQkE4koCxFOYvg9Q8OyXnRyKsXMvsmhhIEOTPkCIPGj
 HSv/jzqsg/qgTSldeHQGCioaE5QR6xwgKzx6mpGP04EV4mx9UB0o1rCx8Z/fcCtg/geP
 Cd5g4K9+7GTo4DtYCph+6mZZYrVKCMbRPrXKALeJZ2wGyLAefUtBho5BM35J3KfjO8NH
 J6pHBhNGlF3oJn+fAsvL3expwCvhvoEf6HJ87gQIi76L9Mh8ZSZzElrpX7eZtgnT9evj DA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32762n6b7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Jul 2020 11:33:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DBSYbI085106;
        Mon, 13 Jul 2020 11:33:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 327qbvegpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jul 2020 11:33:02 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06DBX1tv007561;
        Mon, 13 Jul 2020 11:33:01 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jul 2020 04:33:01 -0700
Subject: Re: [PATCH v2] fstests: btrfs test if show_devname returns sprout
 device
To:     Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        guaneryu@gmail.com
References: <6dcd6b3c-06a9-51a7-988b-63cb254d7749@suse.com>
 <20200713110017.66825-1-anand.jain@oracle.com>
 <f8d76542-f7bb-5207-267e-82dae31e49af@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c334d1b4-5d68-f1ce-44b2-2c7501760f53@oracle.com>
Date:   Mon, 13 Jul 2020 19:32:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f8d76542-f7bb-5207-267e-82dae31e49af@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9680 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9680 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130087
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




>> +# check if the show_devname() returns the sprout device instead of seed device.
>> +cat /proc/self/mounts | grep $SCRATCH_MNT | awk '{print $1}' | \
>> +							_filter_devs $sprout
> 
> Why does this have to be so complicated - 4 chained program executions,
> 1 additional function...
> 

For example:
  /dev/sdb /btrfs btrfs 
ro,relatime,noacl,space_cache,subvolid=5,subvol=/ 0 0

  $1 to $3 remain constant, but $4 options might vary. So to avoid
  unnecessary breakage of test case due to kernel updates or mount
  options, I just used $1.

> dev=$(grep $SCRATCH_MOUNT /proc/mounts | awk '{printf $1}')
> 
> if [ $sprout != $dev ]; then
>   _fail "Unexpected device"
> fi
  fstests prefers use of .out file to look for the expected string.
  Will wait for Eryu comments.

Thanks, Anand
