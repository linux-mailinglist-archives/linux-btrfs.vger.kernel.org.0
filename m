Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EEF1B1FE8
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 09:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgDUHds (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 03:33:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42410 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgDUHds (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 03:33:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03L7WO6M002833;
        Tue, 21 Apr 2020 07:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=1Mmoi3VjD9/pPOVoayA9CP1Mu18Tb0cTUxaQW7aSrEo=;
 b=M8EL0Q6KTKVcv7by7mvGlEjt4WQCrHP0LhSSi5mAHgyybuYwfQgbBlA1f4801wvQh2Vo
 7mENKrodrc3YUsELCorbQ6QMVHhWF/gCMa+gjUvcg+fNtXwkEb2X8xm7iGK+QUZaTWIc
 Ch2KESsU4SnODF6jiWtsdef4jtr9nTVMc3UMLKShktkQHhhiiXjrJi8AUY6TrcqaBsQ1
 L5GqsfrJz6yORz4/2+sOMFuvT5SdMVEWNq/kE+ozie8ow0Hp7DpN4ynoF2K+xpADeFXL
 gYminDp6Jl+/k7pqfIxjk0RZauAEu0GwlizXwcGiBZBJxorZGg4XKX2M/HJTk3KqFAOk Xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30fsgkucd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 07:33:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03L7RYj1083107;
        Tue, 21 Apr 2020 07:33:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 30gb3rtjgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 07:33:39 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03L7XbpR007649;
        Tue, 21 Apr 2020 07:33:38 GMT
Received: from [10.0.2.15] (/39.109.243.230)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Apr 2020 00:33:37 -0700
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: 5.4.20: cannot mount device that blipped off the bus: duplicate
 device fsid:devid for
To:     Marc MERLIN <marc@merlins.org>
Cc:     Nikolay Borisov <nborisov@suse.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200321202307.GA15906@merlins.org>
 <1aaae706-0029-be4f-9f6f-194b03087b35@suse.com>
 <20200325201455.GO29461@merlins.org>
 <a9dd1b1a-b38e-a0f4-91e1-b89063e8ae1e@oracle.com>
 <20200326013007.GS15123@merlins.org>
 <0d2ea8e2-cbe8-ca64-d0d4-fa70b8cad8b1@oracle.com>
 <20200326042624.GT15123@merlins.org> <20200414003854.GA6639@merlins.org>
 <07166dd6-4554-a545-9774-a622890095a7@oracle.com>
 <20200420145659.GA26389@merlins.org>
Message-ID: <0333488d-79d1-7252-cfce-df12ddb424ea@oracle.com>
Date:   Tue, 21 Apr 2020 15:33:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420145659.GA26389@merlins.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9597 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004210063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9597 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210064
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Marc,

  Could you please use the kernel patch (sent to the list or at
  git@github.com:asj/btrfs-boilerplate.git boilerplate-v5.6) it can dump
  the btrfs kernel device_list into the user space using procfs. (This
  patch is only for debugging).

  I tried test (as below) if there will be any availability issue
  (that is requiring to reboot) steps used are as below, and I am
  unable to reproduce. When it happens again at your end, these insight
  into the kernel might shed some more light on the issue.

--------------------------------
$ fillfs /btrfs 10000
$ devmgt detach /dev/sda

[65985.636630] BTRFS: error (device sda) in 
btrfs_commit_transaction:2345: errno=-5 IO failure (Error while writing 
out transaction)
[65985.636631] BTRFS info (device sda): forced readonly
[65985.636633] BTRFS warning (device sda): Skipping commit of aborted 
transaction.
[65985.636634] BTRFS: error (device sda) in cleanup_transaction:1894: 
errno=-5 IO failure
[65985.636636] BTRFS info (device sda): delayed_refs has NO entry

$ devmgt attach host0

[66501.910237] BTRFS warning (device sda): duplicate device fsid:devid 
for 8cc98c45-1a11-4a30-bca8-9760c246ccb4:1 old:/dev/sda new:/dev/sdb

$ btrfs fi show -m
Label: none  uuid: 8cc98c45-1a11-4a30-bca8-9760c246ccb4
	Total devices 1 FS bytes used 16.06MiB
	*** Some devices missing

above -m option reads the device path from the kernel which does provide 
as /dev/sda but as we check its access in the user-space and as its not 
accessible so we report missing.

$ cat /proc/fs/btrfs/devlist
::
		device:		/dev/sda
::
		generation:	10
::
		dev_state:	|WRITEABLE|IN_FS_METADATA|dev_stats_valid
		bdev:		not_null


$ mount /dev/sdb /btrfs1
mount: /btrfs1: mount(2) system call failed: File exists.

The above mount fails because we find the same fs signature on both 
/dev/sda (stale) and /dev/sdb and further the generation number on both 
of these devices are same.

$ btrfs in dump-super /dev/sdb | grep ^generation
generation		10

$ btrfs dev scan --forget
$ cat /proc/fs/btrfs/devlist
::
		device:		/dev/sda

--forget option can't clean the device because its still mounted.

$ umount /btrfs
$ cat /proc/fs/btrfs/devlist | egrep 'device:|bdev'
		device:		/dev/sda
		bdev:		null

unmount is successful and bdev is null. Now --forget should work.

$ btrfs dev scan --forget
$ cat /proc/fs/btrfs/devlist | egrep 'device:|bdev'
$

Now as there isn't any stale device in the kernel and mount will be 
successful.

$ mount /dev/sdb /btrfs
$ cat /proc/fs/btrfs/devlist | egrep 'device:|bdev'
		device:		/dev/sdb
		bdev:		not_null

So reboot was required.
---------------------

Thanks, Anand


On 4/20/20 10:56 PM, Marc MERLIN wrote:
> On Mon, Apr 20, 2020 at 07:10:24PM +0800, Anand Jain wrote:
>> The steps below are they in the chronological order?
>   
> That is my recollection, yes.
> 
>>   Before and after --forget command
>>      btrfs fi show -m
>>   could have told us what devices are still mounted.
>   
> Oh, I didn't know about this. If/when it happens next, I'll
> run this to show btrfs' understanding of what's mounted instead of
> the kernel's understanding (/proc/self/mounts)
> 
>> I will send a boilerplate code to dump device list from the kernel it will
>> help to debug. As of now this boilderplate code which I have been using is
>> too localized needs a lot of cleanups, will take sometime.
> 
> Sounds good.
>   
> Thanks,
> Marc
> 
