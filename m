Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAB841655E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 04:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbgBTDyb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 22:54:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50578 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgBTDyb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 22:54:31 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01K3rHUC162860;
        Thu, 20 Feb 2020 03:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=TlJB7MWmyW+DW4FaAdUY3HYHJoZPWA/K183yT52GNGc=;
 b=TGNCxZx23+scxIftcektRBoXFJGQG/2FCuHFrCFcqp8RlYAv9vh2NpHFZ3a5t2XFoVyh
 jyYkBmkb8K7HlZADvBX4ySXHhe/O7X1nYaIzIP5u7HloLqhw87wfdeafPxoMCiSjZ/kj
 +HUWqysoTIkVo4AvqyaGaMQPbfh1EO3J5KaQyNlAeGDqO01aUQtoVQeT/Zki6XeNGqom
 Rgvjzm3NKzRp1pNc8gp1BwTzjv1RxWFFJ/rM/kR/Rai//H78Ce5+9ve+CjlTWJNso8pJ
 MRgVLUCjBUbpaVitB0vu2F4BNH7DoOt+gjPgb6N/GtjLEpSeVdPHuk3zWVnetyleFiJ1 xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2y8udd759h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 03:54:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01K3pwpK093024;
        Thu, 20 Feb 2020 03:54:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2y8ud9vtp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 03:54:22 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01K3sK8l025382;
        Thu, 20 Feb 2020 03:54:20 GMT
Received: from [192.168.44.21] (/183.90.37.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 19:54:20 -0800
Subject: Re: [PATCH v6 5/5] btrfs: introduce new read_policy device
To:     Steven Davies <btrfs-list@steev.me.uk>
Cc:     josef@toxicpanda.com, dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <1582111766-8372-1-git-send-email-anand.jain@oracle.com>
 <1582111766-8372-6-git-send-email-anand.jain@oracle.com>
 <ca5fe4b1232aadb3aa0d39b3b339dcbe@steev.me.uk>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <27060c4c-548c-242e-0443-b826de487b8c@oracle.com>
Date:   Thu, 20 Feb 2020 11:54:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ca5fe4b1232aadb3aa0d39b3b339dcbe@steev.me.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200025
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>> Whenever there isn't any read preferred device(s) or if more than one
>> stripe is marked as read preferred device then this read policy shall
>> use the stripe 0 for reading.
> 
> Should we consider the situation where more than one device is preferred 
> (perhaps for a future patch) - e.g. devid1 is HDD, devid2 is SSD, devid3 
> is SSD and data is RAID1C3?

Once we have read policy type qdepth, we will use the read preferred 
device with the larger qdepth. This message is in the code comment. Oops 
I should have add it here also.

> Will there be a warning when this fallback to stripe 0 happens? Although 
> I imagine that would either always display on mount before 
> read_preferred is set or flood dmesg for every read.

In a 3 disks raid1, if there is only one disk marked as read preferred, 
and if the stripe 0 and 1 are on non-read-preferred disks, it will pick 
stripe 0 and warning is unnecessary.

In a 3 disks raid1, if there are 2 disks marked as read preferred, and 
the stripe 0 and 1 are on those two read preferred disks, we will be 
using the Qdepth to find the suitable read preferred device.

> Perhaps fallback to the %pid policy to give some form of balancing would 
> be a better default?
> 

Lets say read_policy is set to 'device' but there isn't any 
read_preferred device, then it make sense to fall back to default 
read_policy. But for every read to determine if there is any read 
preferred device outside of the striped chunk not a good idea.

Thanks, Anand
