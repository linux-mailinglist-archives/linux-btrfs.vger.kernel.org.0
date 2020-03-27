Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE636194FEF
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Mar 2020 05:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgC0EP7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Mar 2020 00:15:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47202 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgC0EP7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Mar 2020 00:15:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02R4DTI7095225;
        Fri, 27 Mar 2020 04:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=7Qw3Nn6P1OTn3vS6ZxTvZ5gp23zIJGYyKQDtGQgQvqI=;
 b=mvhKCFWDDm5Y8czMkrPO9Fnoodi/btU5c/rzqHEe2inw9ZReU4pKbT+kOwREtDjlVyiI
 HL5AVm1mbAc3AVWGEHbbfXLEYoZkREzkB+JGP2cF39LKBZ3uVWyv8fkPvT9cLFNKUHbP
 FEyxQTzkZd++IRH5hdXWSVXiu7UF5tTEOzErhhmrDNumJ9YAzbX4lgDxfAqRqaPIE4LY
 yQe0zjW16p4OMeyzky/MlA68rb06a6AZUD3HMKpboEInrzvrr/QrYAYVpkQcT63oASUl
 Z9SZmBNypcmFgKJ6WgBPwmIg4tTK/iaUMNJIMnTiXtCDY6UaPKm1RVURv5OjoFZHTzTw lQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3014598wtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 04:15:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02R4CedM176274;
        Fri, 27 Mar 2020 04:15:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30073ff1ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 04:15:53 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02R4Fq5a017869;
        Fri, 27 Mar 2020 04:15:52 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Mar 2020 21:15:52 -0700
Subject: Re: [PATCH 2/2] btrfs-progs: fix misc-test/029 provide device for
 mount
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <1585125129-11224-1-git-send-email-anand.jain@oracle.com>
 <1585125129-11224-2-git-send-email-anand.jain@oracle.com>
 <20200326154609.GH5920@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a6267fcd-28e1-6763-8c91-1a50758f9324@oracle.com>
Date:   Fri, 27 Mar 2020 12:15:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200326154609.GH5920@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270036
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270036
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/26/20 11:46 PM, David Sterba wrote:
> On Wed, Mar 25, 2020 at 04:32:09PM +0800, Anand Jain wrote:
>> The mount fails with 'file exists' error. Fix it by providing the device
>> name.
> 
> Can you be more specific about the environment where it fails? The test
> passes for me.
> 

I am running it as

/btrfs-progs$ make TEST=029\* test-misc
     [TEST]   misc-tests.sh
     [TEST/misc]   029-send-p-different-mountpoints
failed: mount -t btrfs -o subvol=subv1 /btrfs-progs/tests//test.img 
/btrfs-progs/tests/misc-tests/029-send-p-different-mountpoints/subvol_mnt
test failed for case 029-send-p-different-mountpoints
make: *** [test-misc] Error 1

OR

make test

I wonder if there is any other/better way to run them?


>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   tests/misc-tests/029-send-p-different-mountpoints/test.sh | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/misc-tests/029-send-p-different-mountpoints/test.sh b/tests/misc-tests/029-send-p-different-mountpoints/test.sh
>> index a478b3d26495..e34402d9ec06 100755
>> --- a/tests/misc-tests/029-send-p-different-mountpoints/test.sh
>> +++ b/tests/misc-tests/029-send-p-different-mountpoints/test.sh
>> @@ -19,8 +19,10 @@ run_mayfail $SUDO_HELPER mkdir -p "$SUBVOL_MNT" ||
>>   run_check_mkfs_test_dev
>>   run_check_mount_test_dev
>>   
>> +# The sed part is to replace double forward-slash with single forward-slash
>> +lodev=$(losetup  | grep $(echo $TEST_DEV | sed 's/\/\//\//') | awk '{print $1}')
> 
> There's a simpler way to canonicalize a path, eg using readlink or
> realpath.
> 

  Err. yep. I will fix.

> And I don't see why would two slashes appear in a path. IIRC a path
> starting with two slashes is standardized as a network path and
> recognized by VFS but why this is a concern for the testsuite?
> 

The mount finds the path given is an image file and tries to add another
loop device to it (as I understand the above error), now I wonder
it should fail in your environment as well. If my understand is only
true.

Thanks, Anand

