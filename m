Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2410316B85A
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 05:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgBYEAi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 23:00:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47414 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbgBYEAi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 23:00:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01P3xYsw177552;
        Tue, 25 Feb 2020 04:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ktLGmEGWz4Iu7baH4gMWCQOD/oz6lcC4Imrz6G4DM00=;
 b=J3V9CBMFejkNAaj1osOCxDQIA5++ntxPONTWYdTnv7D50O6zMmfz75A36PB0VPzVVWUC
 Mv5gLl4CDZ+3ulSPiLE4Jy9fxDZzeFpMUZ0nnSOqlqMTR0rhCO8OHuBgpy2LsC7+1G6A
 YAsovLe9U7ZhvhQAut+phbuHz8xB1cW1uy7clWO3ZFn3oOkZ9hOxf69SiAPKrvJUQ4uK
 2lSHHWDkcKl+m2xarMkk2b8bjKzNW4ep7zQMH/a1VIa1JfkfXqSLnnnlyrlIhwdHE7/B
 bPmZ0tzxgXUpSL/P+BqAp3OcqSuRnD0uI2B7bH7AApgf7WY3jZ82RNaOa36hCi8+eVTQ QA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ycppr957g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 04:00:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01P3wCmB148199;
        Tue, 25 Feb 2020 04:00:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ybdsjbbnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 04:00:33 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01P40Vlk005662;
        Tue, 25 Feb 2020 04:00:31 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Feb 2020 20:00:31 -0800
Subject: Re: [PATCH v2] btrfs: merge unlocking to common exit block in
 btrfs_commit_transaction
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes.Thumshirn@wdc.com
References: <133258557ae4387d6a1d01bafa3e5214ca91228d.1582302545.git.dsterba@suse.com>
 <20200224151345.14174-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <7f7008d8-f501-7181-253d-df5bc1a1e213@oracle.com>
Date:   Tue, 25 Feb 2020 12:00:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224151345.14174-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002250030
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 spamscore=0 phishscore=0 mlxscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250030
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/24/20 11:13 PM, David Sterba wrote:
> The tree_log_mutex and reloc_mutex locks are properly nested so we can
> simplify error handling and add labels for them. This reduces line count
> of the function.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
> 
> v2:
> - fixed label after commit_fs_roots, to point to unlock_tree_log
> - added comment after btrfs_handle_fs_error and keep the locks as is

Reviewed-by: Anand Jain <anand.jain@oracle.com>


