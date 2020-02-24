Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0A6169CBB
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 04:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgBXDpv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Feb 2020 22:45:51 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49602 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbgBXDpv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Feb 2020 22:45:51 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01O3h0KM006674;
        Mon, 24 Feb 2020 03:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=L7LY27x43M9ZOsIulW2KOEnDULh0geFs4r23bKj0AgU=;
 b=kXuOchsak3mkVCvqZJ+XYjnwwWJhAi8rwzE7K0GpA6j2kPoX87V5FKQInctKVszy9XZJ
 0zRxxhIzorSD70iYMc9EIU+p9GAvSMszoPX7p4at+xDAqIij95mWFX1tx/1PNfaCAOLK
 muwwSq/ec3Uf3xNR8NJ6r5FoqVVkipTCwO8ubMgeY0V5u4KOkOXB6hIs1724iEleoAEd
 YUz1nZ9bYm+3UKWKMnd6wImOUV05knRNZU5cK8jirr+kJfZ6luc5t2vd7TskSsERcyku
 G/5/XQLB3L9MxeayBEgaVd7ZcGitg8IuQLO1LwPiKZJL2S6yY5eWFkmXcxsGI5OxkEpK yA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2yavxrcp1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 03:45:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01O3gWGj179654;
        Mon, 24 Feb 2020 03:43:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2ybdutdn0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 03:43:46 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01O3hjmv027310;
        Mon, 24 Feb 2020 03:43:45 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 23 Feb 2020 19:43:45 -0800
Subject: Re: [PATCH 05/11] btrfs: simplify parameters of
 btrfs_set_disk_extent_flags
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1582302545.git.dsterba@suse.com>
 <e9483711e6f093259df9488c1d4d9753426fdf0a.1582302545.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <f5340812-4b52-823d-0224-505bb5ba454b@oracle.com>
Date:   Mon, 24 Feb 2020 11:43:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e9483711e6f093259df9488c1d4d9753426fdf0a.1582302545.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240030
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240030
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/22/20 12:31 AM, David Sterba wrote:
> All callers pass extent buffer start and length so the extent buffer
> itself should work fine.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>


