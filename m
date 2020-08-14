Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E55244507
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 08:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgHNGaB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Aug 2020 02:30:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54974 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgHNGaB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Aug 2020 02:30:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07E6Bxfx139753;
        Fri, 14 Aug 2020 06:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=N1/jic8NsfFqLX47HyGIr2DJs2IspxImH/2QXLnYc/c=;
 b=dhnsHBqswDtxSaUhEAmAQJYfyI9st0MbVZew+Cj6gNYgBx/6nHBXJBI7Jv2pECiJCngg
 ElYNP58jtXTEPDzSVJrWTcrJcwtRaB8BgIXAw7fSRhQhK2/z6Pfkm0TCUKLivZsycc5P
 uIzSEaTCIFihmE0/grlWNUaLmrmAnY3FF+aaLtk4Nr77WwDNhdqOS72tQOHB9fJtzQQW
 HwKwgrnHZV1gx+TwDKRwHPiZjCwV90Q0Dde6LMZOJ9tpiatmfAwBYNxiRYcCzzzXdRc+
 uh5X5g/a13BF93Yymh+tL30KSZVnDt6cZPpSfgrYDi7bB8D5dByTjixyO4L060Fe2jax Og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32t2ye2xr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Aug 2020 06:29:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07E6DhNk111067;
        Fri, 14 Aug 2020 06:29:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32t5msr9jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Aug 2020 06:29:55 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07E6TtKq007168;
        Fri, 14 Aug 2020 06:29:55 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Aug 2020 06:29:54 +0000
Subject: Re: [PATCH] btrfs: Remove alloc_list splice in btrfs_prepare_sprout
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200812132646.9638-1-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <5aa6c1fb-7c9e-2aef-8149-e7ae4cf53fcb@oracle.com>
Date:   Fri, 14 Aug 2020 14:29:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200812132646.9638-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008140049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008140049
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/8/20 9:26 pm, Nikolay Borisov wrote:
> btrfs_prepare_sprout is called when the first rw device is added to a
> seed filesystem. This means the filesystem can't have its alloc_list
> be non-empty, since seed filesystems are read only. Simply remove the
> code altogether.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
