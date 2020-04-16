Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6001AC36A
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 15:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441550AbgDPNmj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 09:42:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45066 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441485AbgDPNmd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 09:42:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03GAigAx188594;
        Thu, 16 Apr 2020 10:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=uhQkGBV7R+x83HlBMoixgXSEKiPtSgWLhfzGJ+KG+P8=;
 b=IaiNMPaySMFmx60JgF1eG6gTtW7Fq64hJms52nt+AN8FrTG9vSE7//bXqo5lwbnFKseA
 eS6aDYa89oWjwEuYbBa/Y38hdR2eGDznIRjcGexRBs5pfjl0lOUVQp1KarcceXqCf+jE
 DfNkbJ5nrRZmlv82/nAZlPu4t2K+jhUJXIM13lk76tQl1HF7y6cOzjsgN0yL0odI/qy/
 UFKI2nDjEHb7Wk2toOamYWfL+gnESvUEvpK9LRFWs+1w+3TXQrUH5zbXWQIiog9edQ6/
 F4yhv8U309IH9EE8C333m2p+2EBB+rst6meFErsTQsAgzbhs8F48x4W0DaO1MxQc+GCU IA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30dn95rn1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 10:45:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03GAg7J8068645;
        Thu, 16 Apr 2020 10:43:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30dn9f1k55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 10:43:48 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03GAhif1021798;
        Thu, 16 Apr 2020 10:43:45 GMT
Received: from [10.191.61.208] (/10.191.61.208)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Apr 2020 03:43:43 -0700
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
Message-ID: <f85fccf5-eeb4-28ef-4dc4-500cf9221619@oracle.com>
Date:   Thu, 16 Apr 2020 18:43:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414003854.GA6639@merlins.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004160074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160074
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4/14/20 8:38 AM, Marc MERLIN wrote:
> Anaud, I had this happen agin with 5.5.11, and it was impossible to do
> anything to fix it, I had to reboot again.
> btrfs device scan --forget
> did nothing.
> 
> See details:
> BTRFS: device label btrfs_space devid 1 transid 35178413 /dev/sde1
> BTRFS info (device sde1): use lzo compression, level 0
> BTRFS info (device sde1): disk space caching is enabled
> BTRFS info (device sde1): has skinny extents
> BTRFS info (device sde1): enabling ssd optimizations
> sd 6:1:3:0: [sde] tag#642 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=2s
> sd 6:1:3:0: [sde] tag#640 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=2s
> sd 6:1:3:0: [sde] tag#702 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=2s
> sd 6:1:3:0: [sde] tag#702 CDB: Write(16) 8a 00 00 00 00 00 f1 a7 3a 68 00 00 01 f0 00 00
> blk_update_request: I/O error, dev sde, sector 4054268520 op 0x1:(WRITE) flags 0x100000 phys_seg 62 prio class 0
> sd 6:1:3:0: [sde] tag#701 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=2s
> sd 6:1:3:0: [sde] tag#701 CDB: Write(16) 8a 00 00 00 00 00 f1 a7 38 68 00 00 02 00 00 00
> blk_update_request: I/O error, dev sde, sector 4054268008 op 0x1:(WRITE) flags 0x104000 phys_seg 64 prio class 0
> sd 6:1:3:0: [sde] tag#700 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=2s
> sd 6:1:3:0: [sde] tag#700 CDB: Write(16) 8a 00 00 00 00 00 f1 a7 36 68 00 00 02 00 00 00
> blk_update_request: I/O error, dev sde, sector 4054267496 op 0x1:(WRITE) flags 0x104000 phys_seg 64 prio class 0
> BTRFS error (device sde1): bdev /dev/sde1 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
> sd 6:1:3:0: [sde] tag#641 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=10s
> sd 6:1:3:0: [sde] tag#641 CDB: Unmap/Read sub-channel 42 00 00 00 00 00 00 00 18 00


> BTRFS info (device sde1): forced readonly

Unfortunately that's the only thing we do as of now.

> BTRFS warning (device sde1): Skipping commit of aborted transaction.
> BTRFS: error (device sde1) in cleanup_transaction:1894: errno=-5 IO failure
> BTRFS info (device sde1): delayed_refs has NO entry
> btrfs_dev_stat_print_on_error: 244 callbacks suppressed
> 
> gargamel:~# dmtail 3
> [1887142.765448] BTRFS error (device sde1): bdev /dev/sde1 errs: wr 1038, rd 4529, flush 0, corrupt 0, gen 0
> [1887142.795820] BTRFS error (device sde1): bdev /dev/sde1 errs: wr 1038, rd 4530, flush 0, corrupt 0, gen 0
> [1887142.826176] BTRFS error (device sde1): bdev /dev/sde1 errs: wr 1038, rd 4531, flush 0, corrupt 0, gen 0

> gargamel:~# cat /proc/partitions  |grep sd[ep]
>     8      240 3750738264 sdp
>     8      241 3750737223 sdp1

So the same device reappears as sdp. But btrfs does not close a failed 
device yet (patches are in the mailing list) the old path sde
is still in the block layer and opened. I guess /proc/partitions
doesn't show non working sde.

> gargamel:~# mount | grep sde 
> /dev/sde1 on /mnt/btrfs_space type btrfs (ro,noatime,compress=lzo,ssd,discard,space_cache,skip_balance,subvolid=5,subvol=/)
> /dev/sde1 on /var/local/space type btrfs (ro,noexec,noatime,compress=lzo,ssd,discard,space_cache,skip_balance,subvolid=257,subvol=/varlocalspace)
> /dev/sde1 on /var/cache/zoneminder type btrfs (ro,nosuid,nodev,noatime,compress=lzo,ssd,discard,space_cache,skip_balance,subvolid=257,subvol=/varlocalspace/zoneminder)
> /dev/sde1 on /var/lib/mysql type btrfs (ro,nosuid,nodev,noatime,compress=lzo,ssd,discard,space_cache,skip_balance,subvolid=3648,subvol=/mysql)


> gargamel:~# umount /mnt/btrfs_space; umount /var/local/space; umount /var/cache/zoneminder; umount /var/lib/mysql


> gargamel:~# mount | grep sde
better to have grep-ed sdp also, here.
And /proc/self/mounts will be more accurate as it probes the fs module.

> gargamel:~# mount /dev/sdp1 /mnt/mnt
> mount: /mnt/mnt: mount(2) system call failed: File exists.

> gargamel:~# dmtail 2
> [1887142.826176] BTRFS error (device sde1): bdev /dev/sde1 errs: wr 1038, rd 4531, flush 0, corrupt 0, gen 0
> [1887453.610947] BTRFS warning (device sde1): duplicate device fsid:devid for 727c7ba3-f6f9-462a-8472-453dd7d46d8a:1 old:/dev/sde1 new:/dev/sdp1

Unmount wasn't successful above. Or it was remounted by automount? just 
guessing.

> 
> gargamel:/usr/local/bin# btrfs device scan --forget
> gargamel:/usr/local/bin# mount /dev/sdp1 /mnt/mnt
> mount: /mnt/mnt: mount(2) system call failed: File exists.
> 

  Can you please send a complete kernel logs.

> After reboot, I made sure sde is not used by anything weird, just simple mounts:
> gargamel:~# lsblk  | grep sde
> sde                                 8:64   1 931.5G  0 disk
> ├─sde1                              8:65   1 488.3M  0 part
> ├─sde2                              8:66   1  14.9G  0 part
> ├─sde3                              8:67   1    80G  0 part
> └─sde4                              8:68   1 836.1G  0 part
> 


So in summary the chronological order of events are...

  sde disappears.
  btrfs does not close the device.
  block layer creates sdp when the disappeared device reappears.
  unmount of sde was tried but it might not have completely successful 
we don't have sufficient logs to prove it.
  mount of sdp fails per log indicates that sde is still mounted.

So thing(s) to fix is/are:
  The root of the issue - When sde fails we need to close the device
  so that block layer can reuse sde when it reappears (not sdp).
  In btrfs as we have closed the failed device btrfs dev scan --forget
  can work to cleanup the stale entries left behind during unmount.

  We can do something better here:
  When two different device with same fsid uuid and devid and one of it
  is mounted we have to fail the scan/mount of the newer device for
  obvious reasons. That's when we get the log - 'duplicate device fsid'.
  But here the case it bit skewed that both are same device with same
  major number but different minor number (sde sdp). I need to figure
  out a way so that we don't treat these two device paths as different
  device. Probably should check the guid/wwid assigned by the block
  layer which should be same for both of these devices, or in the
  last resort check scsi inquiry_VPD page and get the serial number
  but its going too much beyond what FS should do. Let me check with
  block layer experts what they suggest.

  We might need a workaround tool to force clean a given FSID to avoid
  reboot.

Still unknown:
  unmount is successful? And mount logs shows that device sde still 
exists in btrfs.

Sorry I was diverted into other stuffs when you reported last time, let 
me take a fresh look.

Thanks, Anand


> Any ideas?
> 
> Marc
> 
