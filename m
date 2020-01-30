Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3458F14E611
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 00:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgA3XOY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 18:14:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33436 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3XOY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 18:14:24 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00UNCwSQ146109;
        Thu, 30 Jan 2020 23:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=wbbk38sNGBYaSFsAfrdMXD3mVciomM2DOEhfxnCMSPc=;
 b=nrrl/f1gM3q5go4uVuYhb1lMnzFLoUP2ifJq3za3mlBXCjvDU/WVltU9X/xCgDPeVnHw
 iki8DIRsrFB4YbeFUfKDHOAsCuua1Q56JTcJ4L1WSB2nE2eJSww3NMGxmmuhpbmeFBUk
 CLVMRKATa8BfAKQ1g8sUXMK7d4f/i4QEN/hebofeVAZjbmD88Gxno+2vU4nFZQv0rGbQ
 soypV90c2gnh2je8LIe1nJqlASPacOpcsm53arXqWP8K3a1Gc2ViCid9g5fccz0x+75W
 TEF8A4Yy3xDLgikFqR2JZxrnf8Egjl+kciqIzcx3foHayyGJToQJsGJ4/MYGf+2wRNha jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xrearq5q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 23:14:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00UNDVGj137589;
        Thu, 30 Jan 2020 23:14:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2xu8e9qfga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 23:14:18 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00UNEGco005185;
        Thu, 30 Jan 2020 23:14:16 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jan 2020 15:14:16 -0800
Subject: Re: [PATCH] btrfs: statfs: Don't reset f_bavail if we're over
 committing metadata space
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200115034128.32889-1-wqu@suse.com>
 <38a5dc98-7233-0252-4ba3-76c59d7b21e7@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <5bd8edb4-8315-31b7-4b43-af42b787ad1d@oracle.com>
Date:   Fri, 31 Jan 2020 07:14:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <38a5dc98-7233-0252-4ba3-76c59d7b21e7@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001300155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001300155
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/31/20 5:05 AM, Josef Bacik wrote:
> On 1/14/20 10:41 PM, Qu Wenruo wrote:
>> [BUG]
>> When there are a lot of metadata space reserved, e.g. after balancing a
>> data block with many extents, vanilla df would report 0 available space.
>>
>> [CAUSE]
>> btrfs_statfs() would report 0 available space if its metadata space is
>> exhausted.
>> And the calculation is based on currently reserved space vs on-disk
>> available space, with a small headroom as buffer.
>> When there is not enough headroom, btrfs_statfs() will report 0
>> available space.
>>
>> The problem is, since commit ef1317a1b9a3 ("btrfs: do not allow
>> reservations if we have pending tickets"), we allow btrfs to over commit
>> metadata space, as long as we have enough space to allocate new metadata
>> chunks.
>>
>> This makes old calculation unreliable and report false 0 available space.
>>
>> [FIX]
>> Don't do such naive check anymore for btrfs_statfs().
>> Also remove the comment about "0 available space when metadata is
>> exhausted".
>>
>> Please note that, this is a just a quick fix. There are still a lot of
>> things to be improved.
>>
>> Fixes: ef1317a1b9a3 ("btrfs: do not allow reservations if we have 
>> pending tickets")
> 
> This isn't the patch that broke it.  The patch that broke it is the 
> patch that introduced this code in the first place.
> 
> And this isn't the proper fix either, because technically we have 0 
> available if we don't have enough space for our global reserve _and_ we 
> don't have any unallocated space.  So for now the best "quick" fix would 
> be to make the condition something like



> if (!mixed && block-rsv->space_info->full &&

  Makes sense. I didn't realize we have space_info::full I was
  experimenting create btrfs_calc_avail_data_space() (which we use
  few lines above in this function) for type metadata.

  This issue is easy to reproduce as below.

  mkfs.btrfs -fq -n64K -msingle /dev/sdb && mount /dev/sdb /btrfs && df 
-k /btrfs

  Filesystem     1K-blocks  Used Available Use% Mounted on
/dev/sdb         3072000 13824         0 100% /btrfs

  So xfstests using _get_available_space() with MKFS_OPTS="-m single"
  option is failing.

  Unfortunately, revert of patch 0096420adb03 (btrfs: do not account
  global reserve in can_overcommit) also fixes this, I don't know yet
  how and why yet. Any idea?

  As because whats happening for the test case above, is
  %found->disk_total is 8388608 (for single) but the %block_rsv->size is
  13631488 (for nodesize 64K). So the condition fails. The
  %block_rev->size scales with nodesize, where as  %found->disk_total
  doesn't, so with default nodesize 16K this problem isn't reproducible.

Thanks, Anand


>      total_free_meta - thresh < block_rsv->size)

> Thanks,
> 
> Josef

