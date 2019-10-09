Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B69AD0E66
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2019 14:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbfJIMJp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Oct 2019 08:09:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43786 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbfJIMJp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Oct 2019 08:09:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99C45qZ136036;
        Wed, 9 Oct 2019 12:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=BvP4SMkTweElo9BbgkooBOfkc1ddK5xzdFuI0yyGjkw=;
 b=Y5wpT3vQmTGcH3KQXw0wwXVmoTke5S0dDwayptmyyLZ+KYUUViEkNLDacVz2M9iDl2BX
 /5mCMHkYzU8bo/E7aDHezSdkmEM3GnGOrRknGGUngZdEzVJ4IDexQ1O9e/1gkYlGtEgx
 2Q4cAu6KBGr+jZM5/mUqT5pMm8i+tDfWh1yUMqTAoCjP3P1MzrEzl9utRew+lIrdxlkO
 0uBLTbjoETkT19SLcTiaWMcLD/k681FBBJvErqVeZJNlz1HIWZqefYZ0CEgBx713q3et
 o1lrfJ6gGXklFqvf+ndcqMJvYTJvHzQNm6RwRzXcS6BUSsjDt+BiwLI8JZ12PsOqBt/c 6w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vektrkk7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 12:09:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99C98iB032426;
        Wed, 9 Oct 2019 12:09:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vgev17w3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 12:09:17 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x99C8NWU030002;
        Wed, 9 Oct 2019 12:08:23 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 05:08:23 -0700
Subject: Re: [PATCH v2 1/3] btrfs: block-group: Refactor
 btrfs_read_block_groups()
To:     Qu Wenruo <wqu@suse.com>
References: <20191008044909.157750-1-wqu@suse.com>
 <20191008044909.157750-2-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <d4b783b7-6706-e32e-d57e-946b27a8d833@oracle.com>
Date:   Wed, 9 Oct 2019 20:08:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008044909.157750-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910090115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910090114
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/8/19 12:49 PM, Qu Wenruo wrote:
> Refactor the work inside the loop of btrfs_read_block_groups() into one
> separate function, read_one_block_group().
> 
> This allows read_one_block_group to be reused for later BG_TREE feature.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Nit: Change log didn't mention about things which is also fixed here.
  1. The incompatible feature check cleanups.

+       int mixed = btrfs_fs_incompat(info, MIXED_GROUPS);

  2. The bug we failed to call "btrfs_put_block_group(cache);" at [1]

-----------------
-               if (!mixed &&
-                   ((cache->flags & BTRFS_BLOCK_GROUP_METADATA) &&
-                   (cache->flags & BTRFS_BLOCK_GROUP_DATA))) {
-                       btrfs_err(info,
-"bg %llu is a mixed block group but filesystem hasn't enabled mixed 
block groups",
-                                 cache->key.objectid);
-                       ret = -EINVAL;                     <---- [1]
+               btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+               ret = read_one_block_group(info, path, need_clear);
+               if (ret < 0)
                         goto error;
-               }
-----------------

Otherwise looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand
