Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70612263116
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 17:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbgIIP6n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 11:58:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43416 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730585AbgIIP6H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Sep 2020 11:58:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089FrxWM018239;
        Wed, 9 Sep 2020 15:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=oM9mCkOZDmZm+GjACibq9sK0TlBY0UOX8QC2r3avGT8=;
 b=bUqajC69nNeYQ6U35vodC23YlpcUtJL1bJGL8j22NSYsiOVXsMQpc793U3cDGOQx6PyM
 HW9j8rWcpBtplxxeE30kPxpruGohdiBrsj53DWygGz8fFF0ZwP8QawnNkE8Em5NzMiGd
 IG7AylFTaYls8xYzYxqC7BWS7QHsBbjz6oI/oSHZWU8zw7Lq8zUFeaOBZJ6SOOxbTv09
 9C3UyI3n9cc1e3MrKuH1t8t37fvDU6zvE4UZ2vHfDj3CH+n725DduetKakGVuZPlJVe4
 ca0vEiGjrLSxb7WdkIR5NV6S3FSmcv9Y6z22oTVGykTFpihYje3kZO4eMATE/n7dP5sS 9w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 33c3an2mnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 15:57:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089FuNAU088223;
        Wed, 9 Sep 2020 15:57:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 33cmky3ja1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Sep 2020 15:57:42 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 089Fvftl024773;
        Wed, 9 Sep 2020 15:57:41 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Sep 2020 08:57:41 -0700
Subject: Re: [PATCH -next] btrfs: Remove unused function
 calc_global_rsv_need_space()
To:     YueHaibing <yuehaibing@huawei.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200909135142.27352-1-yuehaibing@huawei.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <3ecd422e-9c5a-642b-aee9-1f6089c52137@oracle.com>
Date:   Wed, 9 Sep 2020 23:57:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200909135142.27352-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9739 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 clxscore=1011 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090143
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/9/20 9:51 pm, YueHaibing wrote:
> It is not used since commit 0096420adb03 ("btrfs: do not
> account global reserve in can_overcommit")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

