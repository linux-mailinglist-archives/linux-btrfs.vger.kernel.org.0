Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 564BD9E50E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 11:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfH0J7I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 05:59:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52654 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfH0J7I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 05:59:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R9x4RQ028227;
        Tue, 27 Aug 2019 09:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=WzKfXhLyl5qb772Vl608f9gXGX3AL3SOaESg9hibZBk=;
 b=lwsCGWbHzjvQOkxG073Y6tq0qq7zqkemhJoBThO+CV1vQ0xzKMNV/Gb35mXTLvDMLfjN
 a+QZG77C6hupQFj5k/sPlKC/JqyM4YKpXY0MOuTFLCQ3nqLU3UE3SXpbujOY8UqwtHA1
 CZoZL86i1keogLd3M96sPnkjHSILFExpAMlDt0+5ACT2aiIcEulT7DbnhtHpM29AcmkA
 P/ZZTMGjYy38O9yD7hu99uPPbav20VgiwMj6S3ayqo/n12QRakAj9n3AasmPt4XUX6Zt
 +JpGZYNFhr5leJSzXfD0tlLW6zZKH9SUS/wXbTktk8X2T/0xngjINUjaqB4gpmzMpmcG Rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2un1sh08p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 09:59:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R9x3Kv142745;
        Tue, 27 Aug 2019 09:59:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2umhu8htk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 09:59:02 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7R9wHbU012223;
        Tue, 27 Aug 2019 09:58:17 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Aug 2019 02:58:17 -0700
Subject: Re: [PATCH 1/2] btrfs: fix BUG_ON with proper error handle in
 find_next_devid
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20190827074045.5563-1-anand.jain@oracle.com>
 <20190827074045.5563-2-anand.jain@oracle.com>
 <2a203bdb-7cde-f970-6e33-38ba5f190c1b@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <5b866472-0a12-78df-d8a3-d940caf755ef@oracle.com>
Date:   Tue, 27 Aug 2019 17:58:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2a203bdb-7cde-f970-6e33-38ba5f190c1b@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908270113
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/8/19 4:12 PM, Qu Wenruo wrote:
> 
> 
> On 2019/8/27 下午3:40, Anand Jain wrote:
>> In a corrupted tree if search for next devid finds the device with
>> devid = -1, then report the error -EUCLEAN back to the parent
>> function to fail gracefully.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 4db4a100c05b..36aa5f79fb6c 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -1849,7 +1849,12 @@ static noinline int find_next_devid(struct btrfs_fs_info *fs_info,
>>   	if (ret < 0)
>>   		goto error;
>>   
>> -	BUG_ON(ret == 0); /* Corruption */
>> +	if (ret == 0) {
>> +		/* Corruption */
>> +		btrfs_err(fs_info, "corrupted chunk tree devid -1 matched");
> 
> It will never hit this branch.
> 
> As in tree checker, we have checked if the devid is so large that a
> chunk item or system chunk array can't contain one.

  That check is buggy. It assumes devid represents the num_devices,
  it does not account for the possible devid hole as created in the
  below script.

$ cat t

umount /btrfs
dev1=/dev/sdb
dev2=/dev/sdc
mkfs.btrfs -fq -dsingle -msingle $dev1
mount $dev1 /btrfs

_fail()
{
	echo $1
	exit 1
}

while true; do
	btrfs dev add -f $dev2 /btrfs || _fail "add failed"
	btrfs dev del $dev1 /btrfs || _fail "del failed"
	dev_tmp=$dev1
	dev1=$dev2
	dev2=$dev_tmp
done

-----------------------
[  185.446441] BTRFS critical (device sdb): corrupt leaf: root=3 
block=313739198464 slot=1 devid=1 invalid devid: has=507 expect=[0, 506]
[  185.446446] BTRFS error (device sdb): block=313739198464 write time 
tree block corruption detected
[  185.446556] BTRFS: error (device sdb) in 
btrfs_commit_transaction:2268: errno=-5 IO failure (Error while writing 
out transaction)
[  185.446559] BTRFS warning (device sdb): Skipping commit of aborted 
transaction.
[  185.446561] BTRFS: error (device sdb) in cleanup_transaction:1827: 
errno=-5 IO failure
-----------------------


Thanks, Anand


> That limit is way smaller than (u64)-1.
> Thus if we really have a key (DEV_ITEMS DEV_ITEM -1), it will be
> rejected by tree-checker in the first place, thus you will get a ret ==
> -EUCLEAN from previous btrfs_search_slot() call.
> 
> Thanks,
> Qu
>> +		ret = -EUCLEAN;
>> +		goto error;
>> +	}
>>   
>>   	ret = btrfs_previous_item(fs_info->chunk_root, path,
>>   				  BTRFS_DEV_ITEMS_OBJECTID,
>>
> 

