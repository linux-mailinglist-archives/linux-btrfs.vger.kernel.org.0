Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 720D5BC691
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 13:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409605AbfIXLVT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 07:21:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37792 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388125AbfIXLVT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 07:21:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8OBJPAt141948;
        Tue, 24 Sep 2019 11:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=X3vwedJndxgTA+uum+8XCK6v/YiRQvUR8UYW9vIgMz8=;
 b=VdhY+DYNOPRCBBjwEqXbyRsIo4JHy7zgRVwfIkVd5PLqLyYznE/HRn394kuTcuqnjWVB
 XI0hs27CV9or0OmE3gXLERgETUsytT0MFEeu50fccq8BLmIEoflQ7koF1VOEyZUd2mer
 +JJWI9WMmPeSZ9hsTmcp6DOO4bhJVHWi1TT9C3qsYBIN29avoVzG67KvCHS0tQ8SXygb
 cvIm7Yy6SzNqheepd0BgqnqLBJzyHM55xrj146p2MVafQS3/sTR061ID38fOmZuF65Iq
 jqaZjttrGmsqpZJP5QJYB/DLhiePmXQ5LWqpSgfi5LW6fPpVh6oe6I/rrfBVfrSgGXfL sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2v5cgqwagt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 11:21:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8OBIIix025350;
        Tue, 24 Sep 2019 11:21:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2v6yvrg19g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 11:21:10 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8OBL9Bd026579;
        Tue, 24 Sep 2019 11:21:09 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Sep 2019 04:21:09 -0700
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
Message-ID: <faa13b5c-38f9-980b-eb6e-5311a7437b0d@oracle.com>
Date:   Tue, 24 Sep 2019 19:20:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1cd24402-40dd-86f0-ac47-91cad78ef5fe@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909240115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909240115
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


David, ping on this patch.



On 9/12/19 8:45 AM, Anand Jain wrote:
> 
> thanks for the comments, more inline below.
> 
>>> - btrfstume -M <uuid> isn't the place to check if the fsid is a
>>>     duplicate. Because, libblkid will be unaware of the complete list of
>>>     fs images with its fsid.
>>
>> I don't understand this part. Blkid tracks the device iformation, like
>> the uuid, and the cache gets updated. So what does 'will be unaware of
>> the complete list' mean?
>>
>> If it's on the same host it's a matter of keeping the cache in sync with
>> the actual devices.
> 
> In case of vm guest images copied from the golden image there is no
> physical device or loop device or nbd device until its configured on
> the host when required, so check for duplicate fsid at the time of
> btrfstune -M is not convincing or a very limited approach.
> 
>>> - As I said before, its a genuine use-case here where the user wants to
>>>     revert the fsid change, so that btrfs fs root image can be booted.
>>>     Its up-to the user if fsid is duplicate in the user space, as btrfs
>>>     kernel rightly fails the mount if its duplicate fsid anyways.
>>
>> Reverting the uuid is fine 
> 
> ok thanks.
> 
>> and requiring the uuids to be unique is
>> preventing the users doing stupid things unknowingly.
> 
> Right it should be done. But..
> btrfstune -M is a wrong place. Because it can't avoid all the
> cases of fsid getting duplicated.
> Even after btrfstune -M, the fsid can be duplicated by the user.
> So what's the point in restricting the btrfstune -M and fail to
> undo the changed fsid.
> 
>> You seem to have a
>> usecase where even duplicate uuids are required but I'm afraid it's not
>> all clear how is it supposed to work. A few more examples or commands
>> would be helpful.
>>
> 
> In the use case here, even the host is also running a copy of the golden
> image (same fsid as vm guest) and because of duplicate fsid you can
> only mount a vm guest image on the host after the btrfstune -m command
> on the vm guest image. But after you have done that, as the vm guest
> fsid is changed, it fails to boot, unfortunately changed fsid can not
> be undone without this patch.
> 
> The fsid can be duplicate by many different other ways anyways. So in
> this case how does it matter if btrfstune -M tries to ensure that fsid
> is unique among the blkid known set of devices, which may change any
> time after btrfstune -M as well (just copy a vm guest and map it to
> a loop device). So btrfstune -M should be free from this check and
> help the use case as above.
> 
> And if we are concerned about the duplicate fsid as I asked Nikolay
> before, we need to know what are problems in specifies, so that it can
> be fixed in separate patches, but definitely not in btrfstune -M as
> it can't fix the duplicate fsid problem completely as vm images can
> be copied and mapped to a loop/nbd device anytime even after
> btrfstune -M.
> 
> Thanks, Anand

