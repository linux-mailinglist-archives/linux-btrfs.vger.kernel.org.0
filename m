Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3CFB103404
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 06:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKTFy1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 00:54:27 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45958 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKTFy0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 00:54:26 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAK5dQKL103964;
        Wed, 20 Nov 2019 05:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=k1Wm71UpvR0COmRAum3NyQY3ez8MCgzYjS3MbQoftBQ=;
 b=KwT4SomCTf0xHbHgdkXkwdJQo7INuPTURb/Mga9Y+2S6o/HrskWXVF/+tnEMaktElsMG
 q/Go4JrpJ0PBP29unkHj5Cd3Oj/Jk918WNOeVeU9FRkp19Ma9sww8swHqoa7zN/0KKZ8
 UiVmCclVxa9dSCo8tFnk8to3VZlwE49V7nWAvzkRj7qTdSFZn5M5CDpcio5z1fsukhpF
 V+a34j2Z4sSqI8RTwiLACuSZQmkoz9fSzwLP1VHI8roR2x99PgOM1FlzuMyG7r1jTFmE
 Stz8NNq3lKVJg1NaVSyaXscV+rwUh2eb3dXn1hePo2/WM1Sr+IEJUFBQzSs6VfrvHm9D PA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wa9rqk72k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 05:53:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAK5cA8Q085027;
        Wed, 20 Nov 2019 05:53:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wc0ahnywt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 05:53:14 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAK5rCOt029385;
        Wed, 20 Nov 2019 05:53:13 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Nov 2019 21:53:12 -0800
Subject: Re: [PATCH] btrfs: resize: Allow user to shrink missing device
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Nathan Dehnel <ncdehnel@gmail.com>
References: <20191118070525.62844-1-wqu@suse.com>
 <18e6af7c-a9b0-9a9d-f91b-ade078c6b2c1@oracle.com>
 <a7dedb8c-f80c-8abb-8332-cbbc681e7a49@gmx.com>
 <9f35f91d-802f-9c93-11f5-fbdffe583a88@oracle.com>
 <20191119143444.GT3001@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <925c1064-02a6-916b-a1b9-a1be15545800@oracle.com>
Date:   Wed, 20 Nov 2019 13:52:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191119143444.GT3001@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911200052
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911200052
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/19/19 10:34 PM, David Sterba wrote:
> On Tue, Nov 19, 2019 at 03:40:42PM +0800, Anand Jain wrote:
>>    IMO changing the size of the missing device is point less. What if
>>    in between the resize and replace the missing device reappears
>>    in the following unmount and mount.
> 
> The reappearing device is always tricky. If the device is missing from
> the beginning, it'll exist in the fs_devices structure with MISSING bit
> set. If it reappears, device_list_add will find it, update the path and
> drop the missing bit.

  Right.

>  From that point the device is regular but might miss some data updates.

  Um no its not regular yet. If the device has reappeared after mount it
  won't be part of the dev_alloc_list, so no new chunks are allocated
  on it. It needs patch [1] to be regular but as I said in other
  thread its better not to do that unless writehole is fixed.
   [1] [PATCH] btrfs: handle dynamically reappearing missing device

> There's a check for last generation of the device to pick the latest
> one, but this applies only to mount.

  This will work as long as there is only one umount mount sequence.
  A umount mount sequence of two times will make generation on all disks
  equal including device with missing some data. But that's fine..

> Now when there's a replace in progress, and on a redundant profile, like
> in the reported case, the device can be used as source device as long as
> the data are not stale. This is detected by generation mismatch.

  Right. Reading dev_items are safe as they are read from the tree.
  (Just off topic - but non-inline file data are not so lucky in this
  scenario as they are read off-tree and there is no header, ML patch:
  "[PATCH] fstests: btrfs test read from disks of different generation"
  reproduced it).

> The resize of missing device happens on the in-memory structure as it is
> represented in the fs_devices list, before the device reappears. And
> after it's scanned again, the device item in memory is not changed, so
> the size stays and is used until replace finishes.

  Right, I checked it, it looks safe now. Thanks for verifying it.

> Which is IMO all ok for the usecase, but the device states are tricky so
> I could have missed something.

  Missing device state was only relevant here.. I can't think of any
  other.

Thanks, Anand
