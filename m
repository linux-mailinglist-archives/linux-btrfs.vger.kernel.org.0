Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C142B5D3F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Nov 2020 11:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgKQKux (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Nov 2020 05:50:53 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53390 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgKQKux (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Nov 2020 05:50:53 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHAiWG5076610;
        Tue, 17 Nov 2020 10:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Uhs+ZoH99UlmCcFrcWj6jE2Yu3Vc8GRgm34iE/PhAOg=;
 b=Wh8p06aZNm9gapD2jIHj9nsDIJiA+vlZjG/5CUajBhizzfSVUOdcZn1GgAelkLOJ7OTl
 gzu9vbzGcfafAnOt919c4kwcWMuAAe5fuDs9C4Z0MO4K28e+s6gfYMsU+IlwePJ97fIv
 s23HgE56IFd5Jbj3hXUk9lroSinclBjFW0tt8pgXpJVYC/WJ4tAteS8Nr+whPq88+VgQ
 W3g9VdpF9mXsQVq/b31mcw8jNUFcFDg9hB3LG5PECyfhPc5pgZysAu9fpDJS4q2TfSCQ
 fyphzJyv5Xsn2O/jaY2kPhflJ0dKbLNooQgXQE8rOAnamzKajMAfYBwAm3uAFLV4umLX Dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34t76ksven-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 10:50:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHAjSeh151196;
        Tue, 17 Nov 2020 10:50:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34ts0qqcpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 10:50:45 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AHAoiCR015589;
        Tue, 17 Nov 2020 10:50:44 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Nov 2020 02:50:44 -0800
Subject: Re: [PATCH v2] btrfs: don't access possibly stale fs_info data for
 printing duplicate device
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        "syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com" 
        <syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com>
References: <0e9eb675e0a199bf034f13c58fbe5678f4e94a3c.1605513154.git.johannes.thumshirn@wdc.com>
 <58b88874-7ca0-cb0c-1752-315a3fb5bab2@oracle.com>
 <SN4PR0401MB359815F550099C9117016F359BE20@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <4ff4fd75-8867-9a32-580a-2d84768f8063@oracle.com>
Date:   Tue, 17 Nov 2020 18:50:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB359815F550099C9117016F359BE20@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=2 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9807 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170079
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17/11/20 4:19 pm, Johannes Thumshirn wrote:
> On 17/11/2020 08:20, Anand Jain wrote:
>>    This patch fixes the issue in a very gross way, as I mentioned.
> 
> I know but I've not found a better way.
> 

>>    Instead, do we know more about what/how threads were racing,
>>    leading to the access of the freed fs_info?
> 




> If I read the reproducer code correctly it's just mounting a crafted
> image twice via different /dev/loop devices.
> 
> This image is rejected by the mount code, because it can't read the chunk
> tree.
 >
> As far as I've debugged it down scan_one_device() is racing with
> deactivate_locked_super(), so fs_info->sb can already be freed, when
> device_list_add() calls btrfs_warn_in_rcu(device->fs_info,...) leading
> to a use-after-free in btrfs_printk() accessing fs_info->sb_s_id.
> 

  This explains the problem how it happened, IMO this should go into the
  change log.

> It feels like we're missing a mutex_lock(&uuid_mutex) in btrfs_kill_super()

  Yes.
  But uuid_mutex (or device_list_mutex) is too sever for a simple
  problem, and there are other constraints with device_list_mutex.

  Ok let us take out use of fs_info from the device_list_add().

  I am ok with either NO_FS_INFO approach or just NULL.

Thanks, Anand

> but this hasn't led me to anything.

> 
> I'm all ears for a pointer to the correct fix.
> 


