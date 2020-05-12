Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC2E1D0580
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 05:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgEMD0R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 23:26:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57282 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEMD0R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 23:26:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04D3NGrO181486;
        Wed, 13 May 2020 03:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=0PMTUfAJ97gfOHpwnX6mLWwxJXWWLbCJT/bTkFLbNek=;
 b=QaY0jh0/m9B0e6CbHfvoa7JOOEjQc+n6ppYBrNYi82RIGlSgvNjJgL9RVrTmdLF4FPo4
 oe3Pgu/oxMuQZvgbDar335ypaMWJQtgSVkc24Wgucm/ddIWH66qG1WftdPZY9bFcBf9X
 GvZT2aeEzumsPkMBki8gvhwyokyMTg3ZTVZNXoYvKmar73Lum/kj55RODgo5cuDhU24J
 /9nV1w/yyWaAPY8AvfV9zXfUwPW1/Y7xoYcQ5ooGQD+XwTP7pxcOgOJIPawUyl8eAJVB
 5UDPWT9MQO7Rd26OgwRmO8yhHfYVrIlFfEhkS2A6BbrQMuiQpOwAt0BQLlQa9AT6qOsB NA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3100xw9rw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 03:26:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04D3MSGo048111;
        Wed, 13 May 2020 03:26:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3100yk5ruj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 03:26:09 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04D3Q5Ni030328;
        Wed, 13 May 2020 03:26:07 GMT
Received: from [192.168.1.102] (/39.109.177.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 May 2020 20:26:05 -0700
Subject: Re: Bug 5.7-rc: lockdep warning, chunk_mutex/device_list_mutex
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <5e955017351005f2cc4c0210f401935203de8496c56cb76f53547d435f502803.dsterba@suse.com>
 <52b6ff4c2da5838393f5bd754310cfa6abcfcc7b3efb3c63c8d95824cb163d6d.dsterba@suse.com>
 <20200512232827.GI18421@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <65c57205-2c42-1e14-f3ea-55e2f7f0b097@oracle.com>
Date:   Wed, 13 May 2020 03:25:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200512232827.GI18421@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 cotscore=-2147483648
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130029
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/5/2020 7:28 am, David Sterba wrote:
> On Tue, May 12, 2020 at 04:15:46PM +0200, David Sterba wrote:
>> [ 5174.283784] -> #1 (&fs_info->chunk_mutex){+.+.}-{3:3}:
>> [ 5174.286134]        __lock_acquire+0x581/0xae0
>> [ 5174.287563]        lock_acquire+0xa3/0x400
>> [ 5174.289033]        __mutex_lock+0xa0/0xaf0
>> [ 5174.290488]        btrfs_init_new_device+0x316/0x12f0 [btrfs]
>> [ 5174.292209]        btrfs_ioctl+0xc3c/0x2590 [btrfs]
> 
> ioctl called
> 
>> [ 5174.293673]        ksys_ioctl+0x68/0xa0
>> [ 5174.294883]        __x64_sys_ioctl+0x16/0x20
>> [ 5174.296231]        do_syscall_64+0x50/0x210
>> [ 5174.297548]        entry_SYSCALL_64_after_hwframe+0x49/0xb3
>> [ 5174.299278]
>> [ 5174.299278] -> #0 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
>> [ 5174.301760]        check_prev_add+0x98/0xa20
>> [ 5174.303219]        validate_chain+0xa6c/0x29e0
>> [ 5174.304770]        __lock_acquire+0x581/0xae0
>> [ 5174.306274]        lock_acquire+0xa3/0x400
>> [ 5174.307716]        __mutex_lock+0xa0/0xaf0
>> [ 5174.309145]        clone_fs_devices+0x3f/0x170 [btrfs]
>> [ 5174.310757]        read_one_dev+0xc4/0x500 [btrfs]
>> [ 5174.312293]        btrfs_read_chunk_tree+0x202/0x2a0 [btrfs]
>> [ 5174.313946]        open_ctree+0x7a3/0x10db [btrfs]
> 
> ... while the filesystem is being set up. This is actually possible
> because this is with enabled seeding, so the mounted filesystem accesses
> the seeding filesystem's structures when cloning the devices.
> 
> Should be fixed by lifting the device_list_mutex from clone_fs_devices
> to some of it's callers. In btrfs_read_chunk_tree it's between the uuid
> mutex and chunk mutex, in btrfs_init_new_device lock device_list_mutex
> before "if (seeding_dev)".
> 

Two strange things as of now, why we see this only now and mount thread 
is still running but we have the device add ioctl thread.



>> [ 5174.315411]        btrfs_mount_root.cold+0xe/0xcc [btrfs]
>> [ 5174.317122]        legacy_get_tree+0x2d/0x60
>> [ 5174.318543]        vfs_get_tree+0x1d/0xb0
>> [ 5174.319844]        fc_mount+0xe/0x40
>> [ 5174.321122]        vfs_kern_mount.part.0+0x71/0x90
>> [ 5174.322688]        btrfs_mount+0x147/0x3e0 [btrfs]
>> [ 5174.324250]        legacy_get_tree+0x2d/0x60
>> [ 5174.325644]        vfs_get_tree+0x1d/0xb0
>> [ 5174.326978]        do_mount+0x7d5/0xa40
>> [ 5174.328294]        __x64_sys_mount+0x8e/0xd0
>> [ 5174.329829]        do_syscall_64+0x50/0x210
>> [ 5174.331260]        entry_SYSCALL_64_after_hwframe+0x49/0xb3

