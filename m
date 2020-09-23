Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AB227500C
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 06:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgIWEmQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 00:42:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41888 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgIWEmQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 00:42:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08N4dZnZ179932;
        Wed, 23 Sep 2020 04:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=p9uNQ5jRIFUVgZp4vll4hDxFZNaI4emCVil4sgyGkL0=;
 b=o7paZ5R/mShqxnmY+6cydFiemu4LjO3SMT+ZcehDL/mFoqn8lfYQsMTTXbGg6sSPfFME
 Jsvr/CaBm/tzFL7kROzQQW6C3tcwsGjGzE54H9XRp/CxKoWTBLCHGdld2MMaQxXSX1Xu
 cmNJZLaorKumXgdpQWlqFgRoqlqrYwG1cy4gjMhL5mOSHpMeRa+b1BT5DVVlw71HgYuT
 /TFDBCNVSf2Ltof8yPz+2OvqxaheLjwMRIhK8Iqq/6zrT9kOvIBWYc4SOraDToOqZpTa
 q5dWZgZCguFBdJ7ebWewFQS9Ybc2X3bs/QyUutn/NkDSMxJb+Pv+GPbfC8TCneAtaE3o jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33q5rgej68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 04:42:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08N4e1ER155973;
        Wed, 23 Sep 2020 04:42:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 33nuw5u0je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Sep 2020 04:42:12 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08N4gBmj019268;
        Wed, 23 Sep 2020 04:42:11 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Sep 2020 21:42:11 -0700
Subject: Re: [PATCH add reported by] btrfs: fix rw_devices count in
 __btrfs_free_extra_devids
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com
References: <b3a0a629df98bd044a1fd5c4964f381ff6e7aa05.1600777827.git.anand.jain@oracle.com>
 <4f924276-2db3-daba-32ec-1b2cf077d15d@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <3d5fdbd9-7a2c-d17f-62b7-f312042c7e0a@oracle.com>
Date:   Wed, 23 Sep 2020 12:42:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <4f924276-2db3-daba-32ec-1b2cf077d15d@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=2 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009230035
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=2 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230034
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22/9/20 9:08 pm, Josef Bacik wrote:
> On 9/22/20 8:33 AM, Anand Jain wrote:
>> syzbot reported a warning [1] in close_fs_devcies() which it reproduces
>> using a crafted image.
>>
>>          WARN_ON(fs_devices->rw_devices);
>>
>> The crafted image successfully creates a replace-device with the devid 0.
>> But as there isn't any replace-item. We clean the extra the devid 0, at
>> __btrfs_free_extra_devids().
>>
>> rw_devices is incremented in btrfs_open_one_device() for all write-able
>> devices except for devid == BTRFS_DEV_REPLACE_DEVID.
>> But while we clean up the extra devices in __btrfs_free_extra_devids()
>> we used the BTRFS_DEV_STATE_REPLACE_TGT flag which isn't set because
>> there isn't the replace-item. So rw_devices went below zero.
>>
>> So let __btrfs_free_extra_devids() also depend on the
>> devid != BTRFS_DEV_REPLACE_DEVID to manage the rw_devices.
>>
> 
> This is an invalid state for the fs to be in,

OK, to be more specific. There is an alien device that is pretending to 
be the replace-target (devid = 0).

 > I'd rather fix it by
 > detecting we have a devid == BTRFS_DEV_REPLACE_DEVID with no
 > corresponding dev_replace item and fail out before we get to this
 > point.  Thanks,

Yes. __btrfs_free_extra_devids() is already doing in a way the same.

------------------------------------
1040 static void __btrfs_free_extra_devids(struct btrfs_fs_devices 
*fs_devices,
::
1059 if (device->devid == BTRFS_DEV_REPLACE_DEVID) {
::
1070 if (step == 0 || test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
1071 &device->dev_state)) {
1072 continue;
1073 }
------------------------------------

OR I did not understand what do you mean.

Thanks, Anand

> 
> Josef
