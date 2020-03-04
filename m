Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6199417933D
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 16:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgCDPXN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 10:23:13 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43006 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729664AbgCDPXM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Mar 2020 10:23:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024FI4iw026974;
        Wed, 4 Mar 2020 15:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=eiFTH+fH/XjQWefauMcwN4NruAv8DgW5/FopOp3nQN0=;
 b=nRztg5M0NTr/Zm5J04MrBdr8TkA0sALF6h8gIdJw4t3hb6G09Tr1YrResUi5D8ra/OVc
 37UPchYlKWC9tRzXZx7U0dkHNd2ed9gOnDFNh+tbcudbZeb1tS9vENWAKJkUW2Ds/hED
 4JP9N26qsapV/8jYuNyuV0qG0wSK1ndsB0IwdQMiebbjZ0pIxt1n0sqjrtcWCHkURO5S
 HpY9ckSNEBBpUJEYsOPMEzxVIrJkf8p4JwCdkwpYi60CNMxS8t2onlCCaW5auo6hzh81
 AU3jj+l7zHPe0DN+a1KDZRLxntrVh1rGzUzYcpswkIrxU5YyExbtRAGj8P6ei4l6bZtL RA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2yffwqxxh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 15:23:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 024FGit9031254;
        Wed, 4 Mar 2020 15:23:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2yg1eq2996-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 15:23:02 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 024FN1fx010881;
        Wed, 4 Mar 2020 15:23:02 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Mar 2020 07:23:01 -0800
Subject: Re: [PATCH] btrfs-progs: convert, warn if converting a fs which won't
 mount
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <1582877026-5487-1-git-send-email-anand.jain@oracle.com>
 <af69d1ab-4609-d603-980c-b8a6cfb87f43@gmx.com>
 <39c3e381-b49e-a571-d058-a01734b8b4a9@oracle.com>
 <20200303174422.GM2902@twin.jikos.cz>
 <fc02b904-5af5-035f-bb62-a2982409ffbe@oracle.com>
 <20200304133244.GP2902@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <09a4ac2b-92ae-3717-90a2-a6b7df5eb03a@oracle.com>
Date:   Wed, 4 Mar 2020 23:22:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304133244.GP2902@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040114
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/4/20 9:32 PM, David Sterba wrote:
> On Wed, Mar 04, 2020 at 10:14:20AM +0800, Anand Jain wrote:
>>> the conversion.
>>>
>>> I've tried mkfs.ext4 with 64k block size and it warns and in the
>>> interactive session wants to confirm that by the user:
>>>
>>>     $ mkfs.ext4 -b 64k img
>>>     Warning: blocksize 65536 not usable on most systems.
>>>     mke2fs 1.45.5 (07-Jan-2020)
>>>     img contains a ext4 file system
>>> 	  created on Tue Mar  3 18:41:46 2020
>>>     Proceed anyway? (y,N) y
>>>     mkfs.ext4: 65536-byte blocks too big for system (max 4096)
>>>     Proceed anyway? (y,N) y
>>>     Warning: 65536-byte blocks too big for system (max 4096), forced to continue
>>>     Creating filesystem with 32768 64k blocks and 32768 inodes
>>>
>>>     Allocating group tables: done
>>>     Writing inode tables: done
>>>     Creating journal (4096 blocks): done
>>>     Writing superblocks and filesystem accounting information: done
>>>
>>
>> Just warn is reasonable. But I don't think you meant to introduce
>> interactive part similar to mkfs.ext4 in btrfs-convert?
> 
> No I haven't meant that. So let's go with the warning.
> 
Ok. Patch v2 is in ML.

Thanks, Anand
