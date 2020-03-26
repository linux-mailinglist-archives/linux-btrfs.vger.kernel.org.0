Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB10193716
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 04:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgCZDdm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 23:33:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49784 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbgCZDdm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 23:33:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02Q3XYqj129589;
        Thu, 26 Mar 2020 03:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GlJi6hlPiSqnrOLMrw/wSwgbjuy3TVqS3iKTZwwhmKQ=;
 b=PPZM7Eg0rS6DHKAx1alHXuHUqtH19ujXDP0ES8C6RAAbMkMzScm7QC1l1Y8Se0fi9uLI
 5hohClyOhMGM3K3YvDnb0fIQbz6OtSVjnNCiZTusYNHEQwpHtjuh5YaM++rd2YQpHIPU
 cXrmAgEZ+4N70x1HfD/ciuNbAi/e4PsCLgQZlVWmn23AzJha8KL3u/8zJx+qKAnkhUbS
 l7RVy0DRJtsfj6wkfTvP5IDATNmgUfIEMUugBAn2WGC1iKICHXHN4Pp/P+QGk2rOKd3W
 TiA4rW//TRFtnT6ytbf2IxBp3r7VN06RlZDO2fMin7S6hA/nlyDEOmIt2ttxpAbtmDuu 3g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2ywavmd9x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 03:33:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02Q3Wa0G075705;
        Thu, 26 Mar 2020 03:33:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30073c25d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 03:33:33 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02Q3XWPc025046;
        Thu, 26 Mar 2020 03:33:32 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 20:33:32 -0700
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
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <0d2ea8e2-cbe8-ca64-d0d4-fa70b8cad8b1@oracle.com>
Date:   Thu, 26 Mar 2020 11:33:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200326013007.GS15123@merlins.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260019
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/26/20 9:30 AM, Marc MERLIN wrote:
> On Thu, Mar 26, 2020 at 07:56:10AM +0800, Anand Jain wrote:
>>> Are users really supposed to know this?
>>> Why does btrfs device scan not invalidate the cache of devices and keep
>>> remembering a device that's gone (not visible in new scan)?
>>
>>   btrfs device scan --forget is only useful to cleanup the unmounted
>>   devices, per the logs below the device was mounted when it disappeared.
>>   More below.
>   
> I'm confused: why is --forget even needed? Why would it remember devices
> that were unmounted and not part of a new scan?
> 
> And yes, the device was not unmounted. The sata layer failed, device
> disappeared while mounted and then re-appeared


> I was able to force umount the mountpoints, so maybe --forget would have
> helped, but I'm confused as to why it even exists.
>

  We would log the below only if the old device sde is still in mounted
  state.  Unfortunately we don't have the unmount event log yet (patches
  are in the ML) so we don't know if unmount was successful.

[2560416.434529] BTRFS warning (device sde1): duplicate device 
fsid:devid for 727c7ba3-f6f9-462a-8472-453dd7d46d8a:1 old:/dev/sde1 
new:/dev/sdq1

  If the device is unmounted, the scan would have replaced the sde
  to sdi, unless the sde (stale) generation is > generation in sdi
  (lost commit). In which case the --forget is useful to remove the
  state device entry (provided device is unmounted).

>>    This indicates the device was mounted when it disappeared. So it
>>    re-appears with the new path, but as its fsid+uuid+devid matches
>>    with the old still mounted device we rightly consider it as an
>>    alien device and fail the mount.
>   
> It was unmounted after disappearing, see the 'grep sde /proc/mounts'
> showing that it wasn't mounted anymore, so it seems that even that part
> didn't work as intended?

  Its strange /proc/mounts doesn't list sde. Could you please send me
  complete kernel logs. Lets try if there is any clue.


  I tried to reproduce.. but in my case the unmount was successful.


$ mkfs.btrfs -fq /dev/sdc && mount /dev/sdc /btrfs
$ devmgt show | grep sdc
host2 sdc
$ devmgt detach /dev/sdc
::
detach /dev/sdc successful
$ devmgt attach host2
::
	sd 2:0:0:0: [sdb] Attached SCSI disk
::
	BTRFS warning (device sdc): duplicate device fsid:devid for 
dcbc5603-e1cf-4d8d-9ec2-832bc3ac4e36:1 old:/dev/sdc new:/dev/sdb
------------------
attach host2 successful

mounts shows sdc is in ro.

$ cat /proc/mounts | grep sdc
/dev/sdc /btrfs btrfs ro,relatime,noacl,space_cache,subvolid=5,subvol=/ 0 0

$ dmesg -k | tail

[ 1427.268767] BTRFS warning (device sdc): duplicate device fsid:devid 
for dcbc5603-e1cf-4d8d-9ec2-832bc3ac4e36:1 old:/dev/sdc new:/dev/sdb

$ umount /dev/sdc

Unfortunately there is no log about the unmount :-(.

And the following device scan replaces the sdc with sdb.

$ btrfs dev scan
Scanning for Btrfs filesystems

$ cat /proc/fs/btrfs/devlist | grep sdc
$ cat /proc/fs/btrfs/devlist | grep sdb
		device:		/dev/sdb
$

And mount is successful.

$ mount /dev/sdb /btrfs


Thanks, Anand

> Marc
