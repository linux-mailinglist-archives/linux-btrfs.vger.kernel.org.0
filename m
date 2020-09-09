Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6785262EA3
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 14:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbgIIMju (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 08:39:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44010 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730193AbgIIMiC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Sep 2020 08:38:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089BExUY057407;
        Wed, 9 Sep 2020 11:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=RfbiCIreVVi3FHYyKt0s61miRi7A72600y0aaUzUwbg=;
 b=bHQ7hSJjLPL8F/2fipDkyviHKtVyhW8jAcRQyb0C3BJE+k3fGq+SGhHw7Tf4OeNXhqir
 kXHfsSRbb3YccwQfW1D3jeugOTGm5l0QMQR3xY5R0flaq2aZlMdOwlzC7Hyf0fs4mwMi
 1PqbOxz23BRxIBxV69IZnLeMdyygPqGH9+LmwkIscC2AB3gLVXUrI2lchfkIXB1ge0Ty
 ptbbmrV1GKmcSDqqRbm71cyNLxeuD1n1yHGhv3ClQbvUAvZtKyuH2TTXfgeRQJEwiWeo
 nay2pNVyoRLkFXZGIX70Q8tPOwYcwC5g0Kv30Ki/DMJujjYIZGevctfYuPfR3K+pA+EG kA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33c2mm11ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 11:15:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089B6bR9035517;
        Wed, 9 Sep 2020 11:15:11 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33cmkxm32r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Sep 2020 11:15:11 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 089BFAkZ024115;
        Wed, 9 Sep 2020 11:15:10 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Sep 2020 04:15:10 -0700
Subject: Re: [PATCH 13/16] btrfs: cleanup btrfs_remove_chunk
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, nborisov@suse.com
References: <cover.1599234146.git.anand.jain@oracle.com>
 <731ff89d22332c3e344f9ea4ca28012f01d50656.1599234146.git.anand.jain@oracle.com>
 <20200909105039.GF18399@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <9d15b919-0b9e-8463-9c31-a4ae70c983ec@oracle.com>
Date:   Wed, 9 Sep 2020 19:15:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200909105039.GF18399@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090100
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9/9/20 6:50 pm, David Sterba wrote:
> On Sat, Sep 05, 2020 at 01:34:33AM +0800, Anand Jain wrote:
>> In the function btrfs_remove_chunk() remove the local variable
>> %fs_devices, instead use the assigned pointer directly.
> 
> Local variable that caches some pointer is ok if it's used multiple
> time, this patch does the opposite.
> 

Oh. By this, it was easy to find and confirm that the device_list_mutex
is of the main device fs_info->fs_deices. I should have mentioned that
in the changelog.

Thanks, Anand

