Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3FFD375F
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 04:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfJKCC0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 22:02:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49818 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbfJKCC0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 22:02:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9B1wxYX019225;
        Fri, 11 Oct 2019 02:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=XiajA+N5h/eZuxn803wF4ngWuaSD2vUxddMOUCZM3mo=;
 b=X1HZB9sSKY7vqOJO3E++mVQUQ6wkF3+aKDO5VXEoGugRJ1Rr6oEiRTNdY71Nbg9dertu
 WuuUTqM5mWyqcorD69LE1IUCL8T+glSE10qo5kD9VNktpFMJkEoDOMv/e5xDf4rEA1H8
 GJ0Sbgypn9U3yHM0HobU8qo35+DhrQx3hoaEuPAaNUEk7oe8gmPKNpJixW7ApIaabsz6
 M7gQAjs8AXd3KDI+Lx2MberKTLIzzZqdSVMVCgctjuJcbQhLsjSkRI0VHzevm5Dp/9ed
 yE9L5xxH/p5dCutQai4TEzwWmSJn/jkVYFyRkDmwE59W75lNwFxQFwFXqM27IS9ZQDcx zQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vektrxcth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 02:02:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9B1wrlH192518;
        Fri, 11 Oct 2019 02:02:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vjdyjy6ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 02:02:19 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9B22IoX002888;
        Fri, 11 Oct 2019 02:02:18 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Oct 2019 19:02:18 -0700
Subject: Re: [PATCH] btrfs: ioctl: Try to use btrfs_fs_info instead of *file
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191011002311.12459-1-marcos.souza.org@gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <7d74f317-0e5f-e7a5-28f8-070337bbb9a8@oracle.com>
Date:   Fri, 11 Oct 2019 10:02:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191011002311.12459-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9406 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910110014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9406 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910110014
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

(cleaned up cc list - I didn't want to clutter others inboxes with my 
review).

On 10/11/19 8:23 AM, Marcos Paulo de Souza wrote:
> Some functions are doing some bikeshedding to reach the btrfs_fs_info
> struct. Change these functions to receive a btrfs_fs_info struct instead
> of a *file.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Thanks for the fix.
Reviewed-by: Anand Jain <anand.jain@oracle.com>
