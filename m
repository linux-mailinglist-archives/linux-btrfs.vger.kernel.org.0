Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 378A2C2EA1
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 10:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbfJAIIx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 04:08:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40546 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfJAIIw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Oct 2019 04:08:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9183tPM111295;
        Tue, 1 Oct 2019 08:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=hkx4JHO80OaZqJXUhmG4g00xxdnPu71aEzV0CgWFRbs=;
 b=dDZHcxJW4uyct5rcORwiOs2VodmekjKRfjH97/qtLfVnf4mTNecBpjlQYWS1K/UMXfRY
 YmF+gchBBORLrYX5a1W5Zx+2KmTly0M8DtsHNLA8GpndrzWLzCck2Vl0N6CdpuF1Fhnq
 3LH15xjUwPAxiVT/1WYVibtSd6aiJPk3oVRwzBvVb0cRSexx6xj5DGNOvLD0kGSC0Saj
 CaGNJEHiKlJHu5eyCPi9v2e4r7ArqKM0d+xw3JSr5IiXY2adWThYZO4O0UTgvpkpAVfd
 77FY6AyxtvxR0iwS9K5CsjwvGRFLJxj2iv4pFzpH08TpntsXlIuIU8bobIi9iVlgjQ1L Eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2v9yfq4156-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 08:08:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9183dh6069135;
        Tue, 1 Oct 2019 08:08:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vbsm1h9yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 08:08:46 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9188jOt018137;
        Tue, 1 Oct 2019 08:08:45 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 01:08:45 -0700
Subject: Re: [PATCH] btrfs-progs: drop unique uuid test for btrfstune -M
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190906005025.2678-1-anand.jain@oracle.com>
 <f3d33e1d-803e-34a5-4dfa-7eeceec6177c@suse.com>
 <232bccd3-3623-8ee9-18db-98edf7cd2e25@oracle.com>
 <673ba386-debc-96e9-311e-4c3c0abd89d0@suse.com>
 <41b5b682-e67f-40d6-93cb-75e4889a4b06@oracle.com>
 <20190911170139.GH2850@twin.jikos.cz>
 <1cd24402-40dd-86f0-ac47-91cad78ef5fe@oracle.com>
 <faa13b5c-38f9-980b-eb6e-5311a7437b0d@oracle.com>
Message-ID: <18cc32e4-4469-32d7-2b92-7760845ab027@oracle.com>
Date:   Tue, 1 Oct 2019 16:08:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <faa13b5c-38f9-980b-eb6e-5311a7437b0d@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010078
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Ping.

Just found that- an image with metadata_uuid can't be a seed device - 
does not make any sense to me as to why.

And test_uuid_unique() blocks undo of metadata_uuid on certain systems.

Moreover the reason to use test_uuid_unique() in the first place
is arbitrary.

Thanks,
Anand



On 9/24/19 7:20 PM, Anand Jain wrote:
> 
> David, ping on this patch.
> 
> 
> 
> On 9/12/19 8:45 AM, Anand Jain wrote:
>>
>> thanks for the comments, more inline below.
>>
>>>> - btrfstume -M <uuid> isn't the place to check if the fsid is a
>>>>     duplicate. Because, libblkid will be unaware of the complete 
>>>> list of
>>>>     fs images with its fsid.
>>>
>>> I don't understand this part. Blkid tracks the device iformation, like
>>> the uuid, and the cache gets updated. So what does 'will be unaware of
>>> the complete list' mean?
>>>
>>> If it's on the same host it's a matter of keeping the cache in sync with
>>> the actual devices.
>>
>> In case of vm guest images copied from the golden image there is no
>> physical device or loop device or nbd device until its configured on
>> the host when required, so check for duplicate fsid at the time of
>> btrfstune -M is not convincing or a very limited approach.
>>
>>>> - As I said before, its a genuine use-case here where the user wants to
>>>>     revert the fsid change, so that btrfs fs root image can be booted.
>>>>     Its up-to the user if fsid is duplicate in the user space, as btrfs
>>>>     kernel rightly fails the mount if its duplicate fsid anyways.
>>>
>>> Reverting the uuid is fine 
>>
>> ok thanks.
>>
>>> and requiring the uuids to be unique is
>>> preventing the users doing stupid things unknowingly.
>>
>> Right it should be done. But..
>> btrfstune -M is a wrong place. Because it can't avoid all the
>> cases of fsid getting duplicated.
>> Even after btrfstune -M, the fsid can be duplicated by the user.
>> So what's the point in restricting the btrfstune -M and fail to
>> undo the changed fsid.
>>
>>> You seem to have a
>>> usecase where even duplicate uuids are required but I'm afraid it's not
>>> all clear how is it supposed to work. A few more examples or commands
>>> would be helpful.
>>>
>>
>> In the use case here, even the host is also running a copy of the golden
>> image (same fsid as vm guest) and because of duplicate fsid you can
>> only mount a vm guest image on the host after the btrfstune -m command
>> on the vm guest image. But after you have done that, as the vm guest
>> fsid is changed, it fails to boot, unfortunately changed fsid can not
>> be undone without this patch.
>>
>> The fsid can be duplicate by many different other ways anyways. So in
>> this case how does it matter if btrfstune -M tries to ensure that fsid
>> is unique among the blkid known set of devices, which may change any
>> time after btrfstune -M as well (just copy a vm guest and map it to
>> a loop device). So btrfstune -M should be free from this check and
>> help the use case as above.
>>
>> And if we are concerned about the duplicate fsid as I asked Nikolay
>> before, we need to know what are problems in specifies, so that it can
>> be fixed in separate patches, but definitely not in btrfstune -M as
>> it can't fix the duplicate fsid problem completely as vm images can
>> be copied and mapped to a loop/nbd device anytime even after
>> btrfstune -M.
>>
>> Thanks, Anand
> 

