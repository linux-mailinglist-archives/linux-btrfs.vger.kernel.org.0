Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29190214C15
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jul 2020 13:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgGELjd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jul 2020 07:39:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46144 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgGELjd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jul 2020 07:39:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 065BdRat060817;
        Sun, 5 Jul 2020 11:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fr+GvMgEBLNzoXe+wonnV15c9DZxO/68X7sy02zejTk=;
 b=xVhyZh7bUDZVVKzHlJHeaK9eOE5a4X0gHzenik8AAUzkpaU0xTrLtS5oO7VqAi8lTSSH
 Qwv40di+0A6TPI//Y6RwSEDg7sHe0+qhoVpSalBNc/tug6PssvSUrxNCsK27CdHqgPoh
 9DSkkmLrspJJB7ge8u2nSJHxdKEJxyeHitC8bG4eGFY8p24l5UoHi2wlcKYpvA+7AgrZ
 bszLxd3tPrUi6aJdijlyo2JdJBBWr/41S1rvxDfE9hUCk9m5OXeLfVNpze12pAgdVfS0
 nn+bAX2XB1ODmFLdtAjEcbiXVaWo496XdJHOOPdK/YTp8ZyHP62kCOU+jqlphzPhz53b Cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 322h6r2ryq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 05 Jul 2020 11:39:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 065BXAYR046564;
        Sun, 5 Jul 2020 11:39:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3233bk1y0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Jul 2020 11:39:26 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 065BdO9C024450;
        Sun, 5 Jul 2020 11:39:25 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 05 Jul 2020 04:39:24 -0700
Subject: Re: [PATCH v2] btrfs: sysfs: Add bdi link to the fsid dir
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200702122335.9117-9-nborisov@suse.com>
 <20200703081315.11824-1-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <7d6e0347-6e6a-90d6-1b76-955a85b361e6@oracle.com>
Date:   Sun, 5 Jul 2020 19:39:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200703081315.11824-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9672 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007050091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9672 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 impostorscore=0
 cotscore=-2147483648 malwarescore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007050091
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Adds little cleanup also.

Looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>
