Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D575977A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 12:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfHUKzl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 06:55:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48014 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHUKzk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 06:55:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LArW8j089942;
        Wed, 21 Aug 2019 10:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=HrzWG/tr2nsoSxoULjEwmKkhu7QhpvnZ6ywNVWSsUhc=;
 b=bxAS2OP+DOauvGYajvw90ryEVas4hmKdWY8RLs/S2A/+y6gOmeyaOklYsJZPvicrmoyL
 dp1JSV79OFH89phT8bDm4GJ++Xvp1zNzYXPmTYr8oaVDTDfjTtcnG+RXCb1ODnTvi8GU
 bzAE073dMvAdsEtI/h1Jo2bNIO1e6AQLrX4cj7wkwdohVt+LlP9VIez6n9zmwhZEND/d
 Hw32CrwJ5je78Q4CbAg3GXduNAHGWm2lRPSwrMZT/+LQ5VdTH+kdEFutNkOygbrhvZyJ
 pcpf3ahyylyaA6GyL+9bmJPQSOgKEIbX0HG8WOS1Meyh5Q/oix6Tvh+7qeUQTGMTwhfs cQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2uea7qvsc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 10:55:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LAnEG1152240;
        Wed, 21 Aug 2019 10:55:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2ugj7psha6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 10:55:36 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7LAtZp1015769;
        Wed, 21 Aug 2019 10:55:35 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 03:55:34 -0700
Subject: Re: [PATCH v2 1/2] btrfs: define compression levels statically
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1566313756.git.dsterba@suse.com>
 <d4972ff57eb3ef57c616f5f7545f92d0cab7e12e.1566313756.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <08f16559-a8f9-f147-2919-2f0ceb8f317e@oracle.com>
Date:   Wed, 21 Aug 2019 18:55:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d4972ff57eb3ef57c616f5f7545f92d0cab7e12e.1566313756.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210118
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/8/19 12:17 AM, David Sterba wrote:
> The maximum and default levels do not change and can be defined
> directly. The set_level callback was a temporary solution and will be
> removed.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
