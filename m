Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C1CBD781
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 06:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfIYEzx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 00:55:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37638 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbfIYEzw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 00:55:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8P4tAXc183705;
        Wed, 25 Sep 2019 04:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=mNALWmUD9xu0wUPuXfbkQHni4s30qq9dV7+wchVP3ow=;
 b=rJRBgTY7XOHy2Z6tscdtQe3/j+PnwOznT70jopYP37V8XDm/1dMZx8xzYMgGi32CBBLG
 3tkTFR3yw1/YRA1JJsmF/bVcAaeNiIW7SfGESx2nX7lRDG81vcgYwnTYdPGDI7XBaqTh
 R33ZCvsCFVzxJQmM7IJVbAZ7uRKUtcoOHCc2wzKwNWuRSl2N+S895VnlZoZdzsBirJpq
 OQp/0VNCCqVIt2mJ3vU8dpbFK+CewF+wVICYMtsOAQ5QNZE+ytzbF71BqJrfSkIYeqGF
 BUnFfuTqyIi2S6/8oYgnRVIfDJ7JSNPu/i7IS5NZ4/Fq9rHq1HlbhwxkhlKX+jsGEYLb qQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2v5cgr219a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 04:55:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8P4sXvx118015;
        Wed, 25 Sep 2019 04:55:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2v7vnx6rv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 04:55:46 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8P4qmQU004537;
        Wed, 25 Sep 2019 04:52:48 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Sep 2019 21:52:47 -0700
Subject: Re: [PATCH] btrfs: Fix a regression which we can't convert to SINGLE
 profile
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Murphy <lists@colorremedies.com>
References: <20190925021327.90095-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <0a29bea5-f2e4-b7d3-9c31-08ae8d6fc3c4@oracle.com>
Date:   Wed, 25 Sep 2019 12:51:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925021327.90095-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909250048
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909250048
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/25/19 10:13 AM, Qu Wenruo wrote:
> [BUG]
> With v5.3 kernel, we just can't convert to SINGLE profile by all means:
>    # btrfs balance start -f -dconvert=single $mnt
>    ERROR: error during balancing '/mnt/btrfs': Invalid argument
>    # dmesg -t | tail
>    validate_convert_profile: data profile=0x1000000000000 allowed=0x20 is_valid=1 final=0x1000000000000 ret=1
>    BTRFS error (device dm-3): balance: invalid convert data profile single
> 
> [CAUSE]
> With the extra debug output added, it shows that the @allowed bit is
> lacking the special in-memory only SINGLE profile bit.
> 
> Thus we fail at that (profile & ~allowed) check.
> 
> This regression is caused by commit 081db89b13cb ("btrfs: use raid_attr
> to get allowed profiles for balance conversion") and the fact that we
> don't use any bit to indicate SINGLE profile on-disk, but uses special
> in-memory only bit to help distinguish different profiles.
> 
> [FIX]
> Add that BTRFS_AVAIL_ALLOC_BIT_SINGLE to @allowed, so the code should be
> the same as it was and fix the regression.
> 
> Reported-by: Chris Murphy <lists@colorremedies.com>
> Fixes: 081db89b13cb ("btrfs: use raid_attr to get allowed profiles for balance conversion")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand
