Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB454284C54
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Oct 2020 15:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgJFNMc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Oct 2020 09:12:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49860 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFNMc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Oct 2020 09:12:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 096D9OTp194056;
        Tue, 6 Oct 2020 13:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Y5DozJRjQnNuYBJzFij3tyPPkAw7i6h6WpMP2ZPgGWk=;
 b=Ry3sL6wdoPK3vFsmBYFomPsu+llnaJGD08TQD7sdBi7SKiQwgvyBzjtqzGvNirmNpEGi
 D9GKkVMqy3oxXTJGhKhvL8PWB5Esmy/BxGNjyoCICOA1fR/VUWzXiX9KxE4s4Qap4VQD
 F51Ke9fHglRENPopOKgYs1xQIAtig3+qKRtXlEWIJT0uFSfdgjsF9eHMaAncusH1uqYf
 Rjfp6x19Xe7gEu3MMrc6FhLqwleGQH4bLiGIxSYyYojz5pKTuUN0kDHQfx/obeyAcWeY
 3r6uHUkzHPiPAjmCOxtsJKfrOTqSkZFxBwGKNnp3prJhPjv+hB7Ba45ADNlT4R2HuC42 6w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33xhxmuucf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 06 Oct 2020 13:12:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 096DAo1u006845;
        Tue, 6 Oct 2020 13:12:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33y36xy3v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Oct 2020 13:12:25 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 096DCNs6016884;
        Tue, 6 Oct 2020 13:12:23 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Oct 2020 06:12:22 -0700
Subject: Re: [PATCH add reported by] btrfs: fix rw_devices count in
 __btrfs_free_extra_devids
To:     Josef Bacik <josef@toxicpanda.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org,
        syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com
References: <b3a0a629df98bd044a1fd5c4964f381ff6e7aa05.1600777827.git.anand.jain@oracle.com>
 <4f924276-2db3-daba-32ec-1b2cf077d15d@toxicpanda.com>
 <3d5fdbd9-7a2c-d17f-62b7-f312042c7e0a@oracle.com>
 <a9910086-ad40-2cc8-8dd5-923ba6ff3990@toxicpanda.com>
 <20200924112513.GT6756@twin.jikos.cz>
 <a6766b76-a1fd-4011-5290-11406bc2923e@toxicpanda.com>
 <b93a6de0-96f7-11f1-e4ac-59de97d60cc0@oracle.com>
 <7b481788-110e-b2a7-607c-2f443f30f663@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <6a59bb52-1603-74ca-9bd8-7b30888a4842@oracle.com>
Date:   Tue, 6 Oct 2020 21:12:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <7b481788-110e-b2a7-607c-2f443f30f663@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=2 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010060085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=2 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010060085
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/9/20 10:28 pm, Josef Bacik wrote:
> On 9/25/20 6:11 AM, Anand Jain wrote:
>> On 24/9/20 10:02 pm, Josef Bacik wrote:
>>> On 9/24/20 7:25 AM, David Sterba wrote:
>>>> On Wed, Sep 23, 2020 at 09:42:17AM -0400, Josef Bacik wrote:
>>>>> On 9/23/20 12:42 AM, Anand Jain wrote:
>>>>>> On 22/9/20 9:08 pm, Josef Bacik wrote:
>>>>>>> On 9/22/20 8:33 AM, Anand Jain wrote:
>>>>
>>>>> Yeah I mean we do something in btrfs_init_dev_replace(), like when 
>>>>> we search for
>>>>> the key, we double check to make sure we don't have a devid ==
>>>>> BTRFS_DEV_REPLACE_DEVID in our devices if we don't find a key. 
>>
>>
>>>>> If we do we
>>>>> return -EIO and bail out of the mount.  Thanks,
>>
>>
>> I read fast and missed the bailout part before.
>>
>> If we bailout the mount, it means a btrfs rootfs can fail to boot up.
>>
>> To recover from it, the user has to remove the trespassing/extra device
>> manually and reboot.
>> For a non-rootfs, the user would have to remove the device manually 
>> and run
>> 'btrfs dev scan --forget' to free up the extra devices.
>> What we are doing now is removing the extra/trespassing device
>> internally.
>>
>> IMO. The case of trespassing/extra device trying to sabotage the setup
>> is a bit different from a corrupted device, in the former case
>> resilience is preferred?
>>
> 
> Well this doesn't happen in real life right?  This is purely from a 
> fuzzing standpoint, so while resilience should be the first thing we 
> shoot for, I'd rather not spend a long time trying to make it work.
> 
> In the case of just randomly deleting a device, I don't think that's a 
> decision that the kernel can/should make, we should require a user to 
> intervene at that point.  That makes failure the best option here, thanks,
> 

  It makes sense to me, its different from what we had before.
  Made those changes in v2.

Thanks, Anand

> Josef

