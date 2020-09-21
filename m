Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0580B2736ED
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 01:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgIUXyI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 19:54:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38004 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgIUXyH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 19:54:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08LNmcZ7026109;
        Mon, 21 Sep 2020 23:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=9KhiferwRuQuHv71IActh2KJrDWuzjxMoSrlK32mRaw=;
 b=gea0Bn1QjQBG51UgDXjrF2QoH+/1GHsiPa3O2lNREL+t8mZ2H2oTI4VY/EqGGxAGxlZi
 2X6ZolsbGIZaFpuoeMP3sMy5Qd4JIcJj5a5gtCQwKxGO5tgX2B0hZ6HDScxQvT6n0k1w
 uNY1bW3h+ZOExlx9QjOnT2DwKQL1ZrHtjUiEloKJxx7Ammp/RCr5Q50uku956pKQYt5O
 qkPhilYwRkBfXDb1tTNedFKZG8HVYN0PEnXgN2aJDWd/7+hqn6XAmt6wbf3eD6Z8d4nP
 tLfHBEsgenYdLALe52PBpQ26X1S+OlY6i7aScFoGCq3OUqv1Bl4XS43ag26X7R5kUIsL +w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33ndnu9txa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 23:54:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08LNoLc9093222;
        Mon, 21 Sep 2020 23:52:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 33nurrrkq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 23:52:02 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08LNq18N021214;
        Mon, 21 Sep 2020 23:52:01 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Sep 2020 16:52:01 -0700
Subject: Re: [PATCH 1/2] btrfs: init device stats for seed devices
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1600461724.git.josef@toxicpanda.com>
 <b0c2be2e6722f091821521301f251628afcd8313.1600461724.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <37e7f35d-c77e-a731-571f-489bb4baf592@oracle.com>
Date:   Tue, 22 Sep 2020 07:51:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <b0c2be2e6722f091821521301f251628afcd8313.1600461724.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210175
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210175
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/9/20 4:44 am, Josef Bacik wrote:
> We recently started recording device stats across the fleet, and noticed
> a large increase in messages such as this
> 
> BTRFS warning (device dm-0): get dev_stats failed, not yet valid
> 
> on our tiers that use seed devices for their root devices.  This is
> because we do not initialize the device stats for any seed devices if we
> have a sprout device and mount using that sprout device.  The basic
> steps for reproducing are
> 
> mkfs seed device
> mount seed device
> fill seed device
> umount seed device
> btrfstune -S 1 seed device
> mount seed device
> btrfs device add -f sprout device /mnt/wherever
> umount /mnt/wherever
> mount sprout device /mnt/wherever
> btrfs device stats /mnt/wherever
> 
> This will fail with the above message in dmesg.
> 
> Fix this by iterating over the fs_devices->seed if they exist in
> btrfs_init_dev_stats.  This fixed the problem and properly reports the
> stats for both devices.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand
