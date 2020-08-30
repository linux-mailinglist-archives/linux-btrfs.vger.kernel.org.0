Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6095256E9C
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Aug 2020 16:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgH3OjS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Aug 2020 10:39:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58092 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgH3OjP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Aug 2020 10:39:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEXnNK130577;
        Sun, 30 Aug 2020 14:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=FouRbD0Jo/zOG1sY0gMjb64I3xKtNLZsXT4bG5gznDs=;
 b=zmqLOcU3MTw8cFJSuT+9KDrRl4Y9bJBr+YrYmSGUWZhes+M2UIqdT4l3mHKBxDHaE6Ps
 IwNtD7ivDT9F7TBt+GhBZ81ta8+i5UJB8+nEFhCYlS7KktVgA0bNxlQHgPg2YE7gxPTJ
 0bUqbkW5ReASLXoo7OYn3GQQz0OHS47ccfcJBQrhXSBElSer8UocvB8miABuLc06Ymr2
 UnPxM+P6ZmFbQaHQvOiuWK9lnlLZVi3UHxJqr8j6e1bs+HiQmczL//KZg61+rYh5ff1q
 6uuv1n1Z08YIz7q5LzhUDiQLkVk+gM0ijMxBEzLGSg7MtFTmmRf2ECzxstuqLxo0xuV0 Jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 337qrha2a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Aug 2020 14:39:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEaqho138830;
        Sun, 30 Aug 2020 14:39:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3380sp0t38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Aug 2020 14:39:10 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07UEd9xC024090;
        Sun, 30 Aug 2020 14:39:09 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 Aug 2020 07:39:09 -0700
Subject: Re: [PATCH v2] btrfs: Switch seed device to list api
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200715104850.19071-6-nborisov@suse.com>
 <20200716072533.32592-1-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c636ed17-e920-f042-39b2-98b7b2f87821@oracle.com>
Date:   Sun, 30 Aug 2020 22:39:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200716072533.32592-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9728 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008300118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=2 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008300118
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/7/20 3:25 pm, Nikolay Borisov wrote:
> While this patch touches a bunch of files the conversion is
> straighforward. Instead of using the implicit linked list anchored at
> btrfs_fs_devices::seed the code is switched to using
> list_for_each_entry. Previous patches in the series already factored out
> code that processed both main and seed devices so in those cases
> the factored out functions are called on the main fs_devices and then
> on every seed dev inside list_for_each_entry.
> 
> Using list api also allows to simplify deletion from the seed dev list
> performed in btrfs_rm_device and btrfs_rm_dev_replace_free_srcdev by
> substituting a while() loop with a simple list_del_init.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> V2:
>   * Removed tmp_fs_devices from btrfs_rm_dev_replace_free_srcdev. Reported by
>   kernel test robot
> 

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

