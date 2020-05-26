Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AB41E1C1E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 May 2020 09:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbgEZHXV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 May 2020 03:23:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35054 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731519AbgEZHXU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 May 2020 03:23:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04Q7Lhg9107945;
        Tue, 26 May 2020 07:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2020-01-29;
 bh=a65xRIo3urv/NzNhdPk03L/O/OFbH9wIqgkpFufbZd0=;
 b=ZrYNnWfcym2B9nNQbPp61f8Noidr3YYC47mVdNhKpSxUW+nkTeHY96p3HylEqVFRlq0x
 qa8ga4pW6ZHr8ktSaeu8QYQwPKhxgx50UPfAueO2BmYGHyNVa0xGhU8pnP0rWztyOG6R
 BUVlnoj9lq2uo7qf8DQfUOVkG0Hv4H+d0022OtQ2EPWOQOAR1KMazUgBzPi+eX7adm8m
 /2DLff7uAFbA9jq2yVZMoffB4Kv++0JykrIbSSW4kUfk37q2vEikpd8uILUTvfwqYHmd
 c81mjAeqplmcd6hT70z55iHempVd581EgaTejd84O54m4+tAm2SKFswqB+JvZDmZ5hZg FA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 318xbjr2vp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 May 2020 07:23:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04Q7Mvvj084045;
        Tue, 26 May 2020 07:23:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 317ddndkmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 May 2020 07:23:13 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04Q7NC6r017488;
        Tue, 26 May 2020 07:23:12 GMT
Received: from [192.168.1.102] (/39.109.177.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 May 2020 00:23:11 -0700
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v7 rebased 0/5] readmirror feature (sysfs and in-memory
 only approach; with new read_policy device)
To:     dsterba@suse.cz, dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
 <a963d6c8-f0ec-7d41-ff0a-26d3ef9d013d@oracle.com>
 <20200515195858.GS18421@twin.jikos.cz>
 <c61a44bf-04ab-01a0-3fbe-4d5970827085@oracle.com>
 <20200522134656.GL18421@twin.jikos.cz>
Message-ID: <a240b771-bec4-dfc5-bfff-e4ee820bc481@oracle.com>
Date:   Tue, 26 May 2020 15:23:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522134656.GL18421@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9632 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9632 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005260057
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22/5/20 9:46 pm, David Sterba wrote:
> On Tue, May 19, 2020 at 06:02:32PM +0800, Anand Jain wrote:
>> On 16/5/20 3:58 am, David Sterba wrote:
>>> On Thu, Apr 30, 2020 at 05:02:27PM +0800, Anand Jain wrote:
>>>>     I am not sure if this will be integrated in 5.8 and worth the time to
>>>>     rebase. Kindly suggest.
>>>
>>> The preparatory work is ok, but the actual mirror selection policy
>>> addresses a usecase that I think is not the one most users are
>>> interested in. Devices of vastly different performance capabilities like
>>> rotational disks vs nvme vs ssd vs network block devices in one
>>> filesystem are not something commonly found.
>>>
>>> What we really need is a saner balancing mechanism than pid-based, that
>>> is also going to be used any time there are more devices from the same
>>> speed class for the fast devices too.
>>
>> There are two things here, the read_policy framework in the preparatory
>> patches and a new balancing or read_policy, device.
>>
>>> So, no the patchset is not on track for a merge without the improved
>>> default balancing.
>>
>> It can be worked on top of the preparatory read_policy framework?
> 
> Yes.
> 
>> This patchset does not change any default read_policy (or balancing)
>> which is pid as of now. Working on a default read_policy/balancing
>> was out of the scope of this patchset.
>>
>>> The preferred device for reads can be one of the
>>> policies, I understand the usecase and have not problem with that
>>> although wouldn't probably have use for it.
>>
>> For us, read_policy:device helps to reproduce raid1 data corruption
>>      https://patchwork.kernel.org/patch/11475417/
>> And xfstests btrfs/14[0-3] can be improved so that the reads directly
>> go the device of the choice, instead of waiting for the odd/even pid.
>>
>> Common configuration won't need this, advance configurations assembled
>> with heterogeneous devices where read performance is more critical than
>> write will find read_policy:device useful.
> 
> Yes that's the usecase and the possibility to make more targeted tests
> is also good, but that still means the feature is half-baked and missing
> the main part. If it was out of scope, ok fair, but I don't want to
> merge it at that state. It would be embarassing to announce mirror
> selection followed by "ah no it's useless for anything than this special
> usecase".

I didn't realize the need for default policy is prioritized before this 
patch set.

Potential default read policy is interesting, looking into it.

Thanks, Anand
