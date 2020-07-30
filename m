Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0EA232A33
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jul 2020 04:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgG3C5m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 22:57:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53392 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgG3C5l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 22:57:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06U2vZ8H124536;
        Thu, 30 Jul 2020 02:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=d+5ZOm3eeUeivpKlzKbUf9D2uuYsDZHDL8y7P7jveR8=;
 b=oyBqnNGCM8J5j6p11vrVhlzXGNmjqIWV1gqaZ1A32nMiYg5dUamiuVVXTmD8mUzmLC4U
 Zt1bW/8SZ6EKrNuwTezzwDMjZWulOdnpcBYE15jd4yznaCN2bMSj/sso3EQ2ktvI85wi
 MgQv0i/1SjA6rfElZ09X1THWozO8VqkQuutsJx1zj7eISvi1Q15uEIvNGPUXXqcSB6uB
 WvNgJkUWXrbJN3Y+hxpXHYEtHrwJHNd1bkQIHCwPj65Sft6Ol79ubUT415navGHroCXD
 xz6gI8safO2egrPMogJ7h6DmooovXdtu5wiaX8FE7hAhV/+EFlHy8wLP1ARGfOiTYUS+ oA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32hu1jh61k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 02:57:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06U2qeuo092332;
        Thu, 30 Jul 2020 02:57:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 32hu5vysrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jul 2020 02:57:35 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06U2vVa9030279;
        Thu, 30 Jul 2020 02:57:31 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 19:57:31 -0700
Subject: Re: [PATCH] btrfs/162: Stop using device mount option
To:     Nikolay Borisov <nborisov@suse.com>, guan@eryu.me
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20200724131250.3377-1-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <437821d1-5fc4-77e2-d66d-ab63e935c15b@oracle.com>
Date:   Thu, 30 Jul 2020 10:57:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20200724131250.3377-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300020
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/7/20 9:12 pm, Nikolay Borisov wrote:
> btrfs is clever enough to figure out which devices constitute the sprout
> fs even without specifying them explicitly with -o device.

   holds good only in this test case.

> Additionally,
> explicitly settings the devices via -o device reduces coverage of the
> test since it didn't detect breakage a local change introduced.

  We relay on unmount not freeing up the btrfs_device.

> Without
> -o device instead this breakage was detected.

  That's like testing two things in one test case. I am ok.

> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

  Reviewed-by: Anand.Jain@oracle.com
