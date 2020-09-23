Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF068274F92
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 05:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgIWDbh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 23:31:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44466 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIWDbg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 23:31:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08N3OuNF176134;
        Wed, 23 Sep 2020 03:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=rxb5Y7AF9HiyHIHNSUUz0AvLrbIXoSNxkpn99kqI85s=;
 b=pZiux1mheWRgwgZoYnlriE2C6n4HtBSsdT321Z5DntEB9TX0Pzc5mlwRkazl7uTJ6krK
 RbXgJ+sW+xrBEi2Ga427i8h/qcnHH3sQZ8IIUdZ0yrVKVH3yxmExE6751kLEIpGBc7fs
 uZv+gUzv4+e3AtfAhkCzclWBkWkXYjQTRiE2wVK12gEj5fu+O8ymLH1fey9VAVsE5cKT
 0fAXTBar2O4SyjOyfdiYgULpX+bgZZWshOi4pEFv4nLOi1DtiLsrve/8shtwNBuwPVPT
 aBNrKFimfWT2ygw3ctixykKl/plbYr/ya3SpAndE/1tVlan0HtKkPGjKswn684+Bz7+1 tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33ndnug375-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 03:31:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08N3Q1vd142050;
        Wed, 23 Sep 2020 03:31:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 33nuw5puyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Sep 2020 03:31:32 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08N3VUQW024141;
        Wed, 23 Sep 2020 03:31:30 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Sep 2020 20:31:30 -0700
Subject: Re: [PATCH v2] btrfs: remove stale test for alien devices from auto
 group
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Eryu Guan <guan@eryu.me>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20200921143035.26282-1-johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <b6bc4c66-0195-e86b-1644-9c1d65d99c81@oracle.com>
Date:   Wed, 23 Sep 2020 11:31:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921143035.26282-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009230024
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009230024
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/9/20 10:30 pm, Johannes Thumshirn wrote:
> btrfs/198 is supposed to be a test for the patch
> "btrfs: remove identified alien device in open_fs_devices" but this patch
> was never merged in btrfs.
> 
> Remove the test from fstests' auto group, as it is constantly failing.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
