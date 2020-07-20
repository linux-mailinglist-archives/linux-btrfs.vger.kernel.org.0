Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2C3225681
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jul 2020 06:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgGTEXO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jul 2020 00:23:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39934 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgGTEXN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jul 2020 00:23:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06K4MNMU085083;
        Mon, 20 Jul 2020 04:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=BjvCAqnmGHqylgwZBAuGD7IYBRZOOpRkcHHSez3gnUo=;
 b=jBbzM1pvKhsu82X0m5lJVjwV77flq74S63P5ioJE70so/VPjvCRmmKVVEvWKsxqwbpe6
 4LrC10Ygy5/WTkGAifJU8PvcQ/na81AEVS9gd0LT1kVih+e93CVbPwcmlOMsfJzleNvy
 YXJcmMHr0AWw3lrhBgHRzATTZ5N+w+qsuLIV3rdd1eeJ8KQsEXFthS9ny8tgQMogBbSr
 +ObTLMgAAJ9n2f/O2+4oJu9o8CVTD7NvdKqK6KobNrFWccTj3HifepmBrzVfKbm24bim
 mIdqDNt+wpq9q4HxUo5QC9ULyXbHshYptQOLLengHYHf5LgqlMEiBi7VHdXdtOEji8h9 8w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32brgr4gwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 04:23:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06K4MsRb146939;
        Mon, 20 Jul 2020 04:23:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 32d2r0bv87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 04:23:11 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06K4NAfW024613;
        Mon, 20 Jul 2020 04:23:10 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jul 2020 04:23:10 +0000
Subject: Re: Troubles removing missing device from RAID 6
To:     Edmund Urbani <edmund.urbani@liland.com>,
        linux-btrfs@vger.kernel.org
References: <23712d34-1787-058d-b49a-6b3e78969920@liland.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <ef42a584-3d59-ff55-1c5e-01acb94261bb@oracle.com>
Date:   Mon, 20 Jul 2020 12:23:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <23712d34-1787-058d-b49a-6b3e78969920@liland.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9687 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200032
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9687 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1011 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200032
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As you have an additional slot for the new disk, the proper procedure 
would have been

btrfs replace start -r <faulty-dev> <new-dev> /mnt

  -r shall avoid reading from the faulty dev.

(In some cases there might not be any spare slots, I am looking into 
fixing replace command for those cases.)

Thanks, Anand

On 19/7/20 10:13 pm, Edmund Urbani wrote:
> Hello everyone,
> 
> after having RMA'd a faulty HDD from my RAID6 and having received the 
> replacement, I added the new disk to the filesystem. At that point the 
> missing device was still listed and I went ahead to remove it like so:
> 
> btrfs device delete missing /mnt/shared/
> 
> After a few hours that command aborted with an I/O error and the logs 
> revealed this problem:
> 
> [284564.279190] BTRFS info (device sda1): relocating block group 
> 51490279391232 flags data|raid6
> [284572.319649] btrfs_print_data_csum_error: 75 callbacks suppressed
> [284572.319656] BTRFS warning (device sda1): csum failed root -9 ino 433 
> off 386727936 csum 0x791e44cc expected csum 0xbd1725d0 mirror 2
> [284572.320165] BTRFS warning (device sda1): csum failed root -9 ino 433 
> off 386732032 csum 0xec5f6097 expected csum 0x9114b5fa mirror 2
> [284572.320211] BTRFS warning (device sda1): csum failed root -9 ino 433 
> off 386736128 csum 0x4d2fa4b9 expected csum 0xf8a923f9 mirror 2
> [284572.320225] BTRFS warning (device sda1): csum failed root -9 ino 433 
> off 386740224 csum 0xcad08362 expected csum 0xa9361ed3 mirror 2
> [284572.320266] BTRFS warning (device sda1): csum failed root -9 ino 433 
> off 386744320 csum 0x469ac192 expected csum 0xb1e94692 mirror 2
> [284572.320279] BTRFS warning (device sda1): csum failed root -9 ino 433 
> off 386748416 csum 0x69759c1f expected csum 0xb3b9aa86 mirror 2
> [284572.320290] BTRFS warning (device sda1): csum failed root -9 ino 433 
> off 386752512 csum 0xd3a7c5d5 expected csum 0xd351862f mirror 2
> [284572.320465] BTRFS warning (device sda1): csum failed root -9 ino 433 
> off 386756608 csum 0x1264af83 expected csum 0x3a2c0ed5 mirror 2
> [284572.320480] BTRFS warning (device sda1): csum failed root -9 ino 433 
> off 386760704 csum 0x260a13ef expected csum 0xb3b4aec0 mirror 2
> [284572.320492] BTRFS warning (device sda1): csum failed root -9 ino 433 
> off 386764800 csum 0x6b615cd9 expected csum 0x99eaf560 mirror 2
> 
> I ran a long SMART self-test on the drives in the array which found no 
> problem. Currently I am running scrub to attempt and fix the block group.
> 
> scrub status:
> 
> UUID:             9c3c3f8d-a601-4bd3-8871-d068dd500a15
> 
> Scrub started:    Fri Jul 17 07:52:06 2020
> Status:           running
> Duration:         14:47:07
> Time left:        202:05:46
> ETA:              Tue Jul 28 00:07:36 2020
> Total to scrub:   16.80TiB
> Bytes scrubbed:   1.14TiB
> Rate:             22.56MiB/s
> Error summary:    read=295132162
>    Corrected:      0
>    Uncorrectable:  295132162
>    Unverified:     0
> 
> device stats:
> 
> Label: none  uuid: 9c3c3f8d-a601-4bd3-8871-d068dd500a15
>          Total devices 5 FS bytes used 16.80TiB
>          devid    3 size 9.09TiB used 8.76TiB path /dev/sda1
>          devid    4 size 9.09TiB used 8.76TiB path /dev/sdb1
>          devid    5 size 9.09TiB used 8.74TiB path /dev/sdd1
>          devid    6 size 9.09TiB used 498.53GiB path /dev/sdc1
>          *** Some devices missing
> 
> Is there anything else I can do to try and specifically fix that one 
> block group rather than scrubbing the entire filesytem? Also, is it 
> "normal" that scrub stats would show a huge number of "uncorrectable" 
> errors when a device is missing or should I be worried about that?
> 
> Kind regards,
>   Edmund
> 
> 

