Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09D37834F2
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 17:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbfHFPRk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 11:17:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58624 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFPRk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Aug 2019 11:17:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76FDZPI189591;
        Tue, 6 Aug 2019 15:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=XuyFbvd+WhVf7U+fXWcg29P8qso6pDWgBdvWQBmkmvg=;
 b=Wl/0zPDmBtgLtvR47lsK2cseJOP6KEYsNbf/qLcZay1P2Wof3mC0OOkBhrt3CcIh1eiE
 17FU8U9sQqOjOEuhdRf4RFfz7J/3ogJVNBa3Il9LZiY/aLmU+3bpyWEk9NEj84HZ7x2c
 lD4+RNFxpPJ/hE8TRPVQzcwWI7Ndg9c20aPEYTMllzOYaQMaqVzMEBKN5DPzbR2R+mZn
 +k1R0ATdEWZaUbCH3ybFnf/2nf+Hs88lVMPs3+X1M5SwLZXgV8WqlwKO0k2C+0HydL04
 U5j1BM5xBkuZEf3ik4dCJBUnMNaBRY0sxiBI6XXLJPVe3Shf8h494REkC84A65b45lNa Fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2u52wr6upe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 15:17:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76FGwBg005534;
        Tue, 6 Aug 2019 15:17:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2u7666nn90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 15:17:13 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x76FHC6q016082;
        Tue, 6 Aug 2019 15:17:12 GMT
Received: from [192.168.1.147] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Aug 2019 08:17:12 -0700
Subject: Re: [PATCH 0/2] Sysfs updates
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1564505777.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <939d08f0-e851-4f00-733e-c7de15685318@oracle.com>
Date:   Tue, 6 Aug 2019 23:17:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1564505777.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908060150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908060150
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/31/19 1:10 AM, David Sterba wrote:
> Export the potential debugging data in the per-filesystem directories we
> already have, so we can drop debugfs. The new directories depend on
> CONFIG_BTRFS_DEBUG so they're not affecting normal builds.
> 
> David Sterba (2):
>    btrfs: sysfs: add debugging exports
>    btrfs: delete debugfs code
> 
>   fs/btrfs/sysfs.c | 68 +++++++++++++++++++++++-------------------------
>   fs/btrfs/sysfs.h |  5 ----
>   2 files changed, 32 insertions(+), 41 deletions(-)
> 

For 2/2:
  Reviewed-by: Anand Jain <anand.jain@oracle.com>

For 1/2:
  IMO it would be better to delay this until we really have a debug hook
  exposed at the sysfs.

Thanks, Anand
