Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8742784D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Sep 2020 12:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgIYKNa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Sep 2020 06:13:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36608 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbgIYKN3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Sep 2020 06:13:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PABOk0064750;
        Fri, 25 Sep 2020 10:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=2RFNmVQT5VJmIllysBse/DT9GFvcnJCfpuMcOfAbqOQ=;
 b=YVDX2WrYUELJpOdTirve33RuX7qc2tBGZVia4YHIYpbToAhd8rE6LFFYZSyGoaQPYVGo
 qO9lGX9RkW411+qaBgUyem5s548lRow7Hxd6OIkrHptNYEMkykW1/cZPEVnM9yoQJmW1
 GTyousqt06WOtNarSjteXE9W1iNYcdK/p7dEt7siZsOiheLWnpKC/3x2+0BqAouaTYH5
 G4n+ECo+a7AJ4f+dqfHzt0hCUDFBcEtuIK1Oa6ZTfFNcataYzmRfKgVfVUEg2w63COuS
 j0fpYsf+puGDh2CPjWPrPMUOFY2yYOdHms58RCg1LiVsdIYTxHk64h911SqJLIrk6wCU 0A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 33ndnuvtmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Sep 2020 10:13:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08PA9WfD158629;
        Fri, 25 Sep 2020 10:11:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 33nux47gd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Sep 2020 10:11:22 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08PABKbY031098;
        Fri, 25 Sep 2020 10:11:20 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Sep 2020 03:11:20 -0700
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
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <b93a6de0-96f7-11f1-e4ac-59de97d60cc0@oracle.com>
Date:   Fri, 25 Sep 2020 18:11:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <a6766b76-a1fd-4011-5290-11406bc2923e@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=2 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=2 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250069
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/9/20 10:02 pm, Josef Bacik wrote:
> On 9/24/20 7:25 AM, David Sterba wrote:
>> On Wed, Sep 23, 2020 at 09:42:17AM -0400, Josef Bacik wrote:
>>> On 9/23/20 12:42 AM, Anand Jain wrote:
>>>> On 22/9/20 9:08 pm, Josef Bacik wrote:
>>>>> On 9/22/20 8:33 AM, Anand Jain wrote:
>>
>>> Yeah I mean we do something in btrfs_init_dev_replace(), like when we 
>>> search for
>>> the key, we double check to make sure we don't have a devid ==
>>> BTRFS_DEV_REPLACE_DEVID in our devices if we don't find a key. 


>>> If we 
>>> do we
>>> return -EIO and bail out of the mount.  Thanks,


I read fast and missed the bailout part before.

If we bailout the mount, it means a btrfs rootfs can fail to boot up.

To recover from it, the user has to remove the trespassing/extra device
manually and reboot.
For a non-rootfs, the user would have to remove the device manually and run
'btrfs dev scan --forget' to free up the extra devices.
What we are doing now is removing the extra/trespassing device
internally.

IMO. The case of trespassing/extra device trying to sabotage the setup
is a bit different from a corrupted device, in the former case
resilience is preferred?

Thanks, Anand


>>
>>  From user perspective, then do what? Or do we treat this with minimal
>> efforts to provide a sane fallback and error handling just to pass
>> fuzzers (like in many other cases)?
>>
> 
> That's a question for fsck.  I don't want to spend a lot of time chasing 
> imaginary cases that fuzzers come up with, I just want them to fail as 
> quickly as possible so we can move on with our lives.
> 
> If this happened in the real world then it would be because we either
> 
> 1) Lost the replace item somehow?
> 2) Got a random corruption that changed the devid to 0
> 
> I think for #1 it's impossible to detect really, unless you can tell 
> which device was being replaced somehow?  I'm not sure  how you would do 
> that, I'm not familiar enough with the replace code to see if we could 
> figure that out.
> 
> For #2 it should be straightforward, as long as we can determine that we 
> really weren't doing a device replace, then we just change the devid to 
> 1 or something and carry on with life?  Thanks,
> 




> Josef

