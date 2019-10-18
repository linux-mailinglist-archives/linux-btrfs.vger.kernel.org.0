Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D77BEDC06D
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2019 10:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395304AbfJRI67 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 04:58:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41904 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731444AbfJRI67 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 04:58:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9I8mk4a034724;
        Fri, 18 Oct 2019 08:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Kks4KPe+JNJNIAvB6decv7HuScd89hIZO1Sv0aRY2Hk=;
 b=fCcOuDxI03trQSkoOYd8bo+yE8KMUGEDp2CVJv8SMtNKJtq/ZwTgDc5asrB2yx6bDxng
 r9lJvFSE+ChkXyL+C+q9GeKDXXu8YQh2uURFoLaXg/7uVWxuZgg18TGamFDNYyMBd/ou
 YqVH6JzHYK8NXSV8gy23ZWZhXDSREghMC1+94C9MeWSPqFmsGxuZiK1VPR1KcvuJqz0b
 EwvqsTnmq8bwSmsi+gTDtewhaD2nW3HcPm1CAetZAFjPkO77JTDDqov0MhDglVpk3orh
 7568k6MuP4m9mp77svF3feNGCNhC4ITHjyz9AtXi0TKuKMcRVcDAF6tiDNGvEiVXBRCx +Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vq0q42gt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 08:52:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9I8lojg044929;
        Fri, 18 Oct 2019 08:52:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vq0edp6jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 08:52:21 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9I8qKRj025093;
        Fri, 18 Oct 2019 08:52:20 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Oct 2019 08:52:19 +0000
Subject: Re: [PATCH] btrfs-progs: drop unique uuid test for btrfstune -M
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190906005025.2678-1-anand.jain@oracle.com>
 <f3d33e1d-803e-34a5-4dfa-7eeceec6177c@suse.com>
 <232bccd3-3623-8ee9-18db-98edf7cd2e25@oracle.com>
 <673ba386-debc-96e9-311e-4c3c0abd89d0@suse.com>
 <41b5b682-e67f-40d6-93cb-75e4889a4b06@oracle.com>
 <20190911170139.GH2850@twin.jikos.cz>
 <1cd24402-40dd-86f0-ac47-91cad78ef5fe@oracle.com>
 <20191017163252.GL2751@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <3952c4bf-755a-5824-b57e-1c2ce1deda99@oracle.com>
Date:   Fri, 18 Oct 2019 16:52:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191017163252.GL2751@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910180087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910180087
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/18/19 12:32 AM, David Sterba wrote:
> On Thu, Sep 12, 2019 at 08:45:50AM +0800, Anand Jain wrote:
>> In case of vm guest images copied from the golden image there is no
>> physical device or loop device or nbd device until its configured on
>> the host when required, so check for duplicate fsid at the time of
>> btrfstune -M is not convincing or a very limited approach.
>>
>>>> - As I said before, its a genuine use-case here where the user wants to
>>>>      revert the fsid change, so that btrfs fs root image can be booted.
>>>>      Its up-to the user if fsid is duplicate in the user space, as btrfs
>>>>      kernel rightly fails the mount if its duplicate fsid anyways.
>>>
>>> Reverting the uuid is fine
>>
>> ok thanks.
>>
>>> and requiring the uuids to be unique is
>>> preventing the users doing stupid things unknowingly.
>>
>> Right it should be done. But..
>> btrfstune -M is a wrong place.
> 
> No it's not, it's exactly the right place because that's the moment when
> user is doing an action that has consequences and if there's room for
> mistakes, it should not be too easy. If the usecase is valid, it should
> be possible though.


>> Because it can't avoid all the
>> cases of fsid getting duplicated.
> 
> But this does not matter. We're not protecting an image against external
> changes, but by accidental change by a concrete user action at a
> specific time.


>> Even after btrfstune -M, the fsid can be duplicated by the user.
> 
> Yes of course, eg. by doing 'echo UUID | dd of=image seek=... bs=...',
> there's no way we can prevent users from doing that. But that command is
> up to user to check for the target device and we have no responsibility
> for the damage.

>> So what's the point in restricting the btrfstune -M and fail to
>> undo the changed fsid.
> 
> The point is to prevent accidental damage.

> For the same reasons we have
> 'mkfs.btrfs -f' or 'btrfd device add -f' or even 'btrfstune -f -S 0'.
> I'm surprised and slightly disappointed that we have to go through these
> points, this is 101 of user interfaces.

  David,
  I understand the -f warning part we can have that too here, but that
  wasn't review comments so far.
  Per this thread's comments so far, it was only to keep undo fsid part
  blocked and reasoning was arbitrary, neither the code or patch which
  blocked it explains. It only sounded like punish the expert users
  so that we can keep the naive users safe.

>>> You seem to have a
>>> usecase where even duplicate uuids are required but I'm afraid it's not
>>> all clear how is it supposed to work. A few more examples or commands
>>> would be helpful.
>>
>> In the use case here, even the host is also running a copy of the golden
>> image (same fsid as vm guest) and because of duplicate fsid you can
>> only mount a vm guest image on the host after the btrfstune -m command
>> on the vm guest image. But after you have done that, as the vm guest
>> fsid is changed, it fails to boot, unfortunately changed fsid can not
>> be undone without this patch.
> 
> I can't say I have a clear picture yet, can you please describe it in
> some more desriptive way, like
> 
> host1: create image1-uuid1
> 
> host2: copy image1-uuid1 to image1-uuid2
> host2: use image1-uuid2
> host2: change image1-uuid2 back to uuid1     <-- I want this to work
  From the bug as I received.
     create btrfs root-image for the vm use.
     copy root-image to root-image1
     copy root-image to root-image2
     start vm1 using root-image1
     (when root-image1 has issues; shutdown vm1)
     start vm2 using root-image2 with root-image1 accessible.
     login to vm2
       (change fsid so that root-image1 can be mounted)
       btrsftune -m remote/root-image1
       mount -o loop remote/root-image1 /mnt
         analyze, collect logs, fix remote/root-image1
       umount /mnt
       (Revert the changed fsid so that vm2 can boot) <<<< Usecase wants 
this to work
       btrfstune -M $(btrfs in dump-super remote/root-image2 | \
                      grep metadata_uuid | awk '{print $2}') \
                      remote/root-image2
     logout from vm2
     start vm1 using root-image1

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
> 
> This only reiterates and was aswered above.
> 
> The usecase was not explained at the beginning,

  The change log explains the usecase. Looks like it wasn't sufficient
  to bring the whole context correctly. My bad.

> so it got a NAK because
> it brought a potentially dangerous change. The next step is usecase
> clarification so we understand if there's a way to make it work for the
> common and your usecase.
> 
> And we're almost there, but instead of handwaving that we can't prevent
> users doing lots of things, a simple 'so let's allow duplicate uuids
> with -f with a big warning and a paragraph in documentation, and btw
> here's a testcase' would do.  The patch could have been merged a month
> ago.
> 

  This usecase was using ext4 before. They aren't happy that btrfs needs
  btrfstune -m to mount a duplicate fsid and is still hoping that
  we would provide a better seamless solution like as below so that it
  to circumvent the duplicating fsid.

     mount -o loop,random_temp_fsid root-image2 /mnt

  where option random_tmp_fsid creates a kernel in-memory random-fsid
  to mount the duplicate fsid.

  If we are ok to support -o random_tmp_fsid (which I received a nack on
  the other channel), then I can drop this btrfs-progs patch altogether.
  I think we should allow the flexibility seamlessly. Also this kernel
  approach doesn't confuse the user space as perceived, as both
  metadata_uuid and fsid remains unchanged and it helps this use case
  much better.

Thanks, Anand
