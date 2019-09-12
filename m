Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 220F7B0647
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 02:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfILArd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 20:47:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59986 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbfILArc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 20:47:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8C0iMEJ110420;
        Thu, 12 Sep 2019 00:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=qLOoLcGHsm8TEMTXqpo7Wz1gapfgp6fvpf+lOvmLusI=;
 b=H8LX5AuZvtAE5JPaVfn+Gc7P8tNJP5itzqdj2m7IWozk80TbVyXPlfVW0POAZoRDXbjz
 hjAx1pOkIfhJOoXqkOFO2gONZKm++BC+D95d/eSBVaCOINAkbvot7DkStdOytoqRX+3Z
 4bA1CRI/rrlyqPrFqfSUOjOHf869LhwYP7t1Xo+KOW8JOCAYq9gr2xft1fp2tV4EpW7a
 QCORWIAFvt9FGFGazGOXeE9xK6Rexo6WKqROMMnkaHhK1kmbOBV5K2UUmrLhCFU+RV4z
 ZWQF0Da0er4msXzu6R2qQyKWqhfU/pJP4q9v+AfnAw6oGTsvlLnr0xybmaiv+AePYA3K iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2uw1jkn9nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Sep 2019 00:47:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8C0hlNC003948;
        Thu, 12 Sep 2019 00:47:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2uxj89bcrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Sep 2019 00:47:25 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8C0lODA013497;
        Thu, 12 Sep 2019 00:47:24 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Sep 2019 17:45:59 -0700
Subject: Re: [PATCH] btrfs-progs: drop unique uuid test for btrfstune -M
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190906005025.2678-1-anand.jain@oracle.com>
 <f3d33e1d-803e-34a5-4dfa-7eeceec6177c@suse.com>
 <232bccd3-3623-8ee9-18db-98edf7cd2e25@oracle.com>
 <673ba386-debc-96e9-311e-4c3c0abd89d0@suse.com>
 <41b5b682-e67f-40d6-93cb-75e4889a4b06@oracle.com>
 <20190911170139.GH2850@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <1cd24402-40dd-86f0-ac47-91cad78ef5fe@oracle.com>
Date:   Thu, 12 Sep 2019 08:45:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190911170139.GH2850@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909120004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909120005
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


thanks for the comments, more inline below.

>> - btrfstume -M <uuid> isn't the place to check if the fsid is a
>>     duplicate. Because, libblkid will be unaware of the complete list of
>>     fs images with its fsid.
> 
> I don't understand this part. Blkid tracks the device iformation, like
> the uuid, and the cache gets updated. So what does 'will be unaware of
> the complete list' mean?
> 
> If it's on the same host it's a matter of keeping the cache in sync with
> the actual devices.

In case of vm guest images copied from the golden image there is no
physical device or loop device or nbd device until its configured on
the host when required, so check for duplicate fsid at the time of
btrfstune -M is not convincing or a very limited approach.

>> - As I said before, its a genuine use-case here where the user wants to
>>     revert the fsid change, so that btrfs fs root image can be booted.
>>     Its up-to the user if fsid is duplicate in the user space, as btrfs
>>     kernel rightly fails the mount if its duplicate fsid anyways.
> 
> Reverting the uuid is fine 

ok thanks.

> and requiring the uuids to be unique is
> preventing the users doing stupid things unknowingly.

Right it should be done. But..
btrfstune -M is a wrong place. Because it can't avoid all the
cases of fsid getting duplicated.
Even after btrfstune -M, the fsid can be duplicated by the user.
So what's the point in restricting the btrfstune -M and fail to
undo the changed fsid.

> You seem to have a
> usecase where even duplicate uuids are required but I'm afraid it's not
> all clear how is it supposed to work. A few more examples or commands
> would be helpful.
> 

In the use case here, even the host is also running a copy of the golden
image (same fsid as vm guest) and because of duplicate fsid you can
only mount a vm guest image on the host after the btrfstune -m command
on the vm guest image. But after you have done that, as the vm guest
fsid is changed, it fails to boot, unfortunately changed fsid can not
be undone without this patch.

The fsid can be duplicate by many different other ways anyways. So in
this case how does it matter if btrfstune -M tries to ensure that fsid
is unique among the blkid known set of devices, which may change any
time after btrfstune -M as well (just copy a vm guest and map it to
a loop device). So btrfstune -M should be free from this check and
help the use case as above.

And if we are concerned about the duplicate fsid as I asked Nikolay
before, we need to know what are problems in specifies, so that it can
be fixed in separate patches, but definitely not in btrfstune -M as
it can't fix the duplicate fsid problem completely as vm images can
be copied and mapped to a loop/nbd device anytime even after
btrfstune -M.

Thanks, Anand
