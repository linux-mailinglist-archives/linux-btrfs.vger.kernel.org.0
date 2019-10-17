Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F16DA382
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 04:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391419AbfJQCQT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 22:16:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47002 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbfJQCQT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 22:16:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9H28vZA109150;
        Thu, 17 Oct 2019 02:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Z+ChNgFtZJ3P49UFHyFnQT1zXTVt+lG+C+msBI9TAXs=;
 b=MSRjicEOT3lDWr7LGGdNVvBq52+5vIHUMbebjJ0906RJbkb508pE7XHQbSasSmD5CfbW
 i4CcqlIIpauuzzh9Q6KEtnB1w/yTaH/0Ln6AeARrIN7ZBaXNxuUPIuAOa7RvzYmTAp0j
 W5lr4fizqWqmxYj1DjHUGdWS+TJ7nyXRrgskYC6ydn4TmthmamDGa75wy4FU+n37/zgg
 PU37iUYSYAfpLj5urijoNNHb1pNJ5iEuTBNNr+67ROT6ikojSgtX2e79g2RGQtV0RiUn
 JAX/nrZhg9RUd4zUwZuWFlrtDhHiL8GDv3YQJLz+Y8gXp7QWUfJLc20R6qys+7oOAhzQ Rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vk6squ1b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 02:16:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9H2DFUl143049;
        Thu, 17 Oct 2019 02:16:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vpcm1y6f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 02:16:13 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9H2GCEP031478;
        Thu, 17 Oct 2019 02:16:12 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 02:16:12 +0000
Subject: Re: [PATCH v2 1/7] btrfs-progs: Refactor excluded extent functions to
 use fs_info
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191008044936.157873-1-wqu@suse.com>
 <20191008044936.157873-2-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <51af74bc-89b7-1cb2-c3eb-039f7174d744@oracle.com>
Date:   Thu, 17 Oct 2019 10:16:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008044936.157873-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=990
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170014
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/8/19 12:49 PM, Qu Wenruo wrote:
> The following functions are just using @root to reach fs_info:
> - exclude_super_stripes
> - free_excluded_extents
> - add_excluded_extent
> 
> Refactor them to use fs_info directly.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
