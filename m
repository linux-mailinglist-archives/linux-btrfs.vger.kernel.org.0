Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CE027F6F8
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 03:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbgJABGE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 21:06:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33166 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbgJABGC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 21:06:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0910nekb139720;
        Thu, 1 Oct 2020 01:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=63R+7k20dgB7Dj6svTNWG8jeDr0OA6tStLH8vQzkg20=;
 b=SZ7wlHd2S7olcbYkE5tJR8O0y0D6ioJ8ae13S1vA6bNOnlQ1F3X//ntsu+0bwgbPNMeq
 kG14GMlb5tbZHjFb70eMpXUDkIahrkHpdN40lS4MAJFTF2xPjH8dJ6ryVzv+qUAs5cCZ
 c/uZzfSeK+M3RzwCi/JTVoGSCPyp//Rl2X0b+7GJB4zM8rLaJjbbUg3PYsWm4njxXEVy
 UGfUX5b2hvxSQLOjckrUfi5skE1zjAESy6Bh2Qzlejk4qW9FVQm/axVXdy5NclzERLm2
 dpmjZwLrMizvMMgh8Fnpn+UPel8kUqJCYozLIwvf7HbcGJWSDmuJi53HIc3LKGO8HWX7 Kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33swkm3dsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 01 Oct 2020 01:05:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0910nv92095116;
        Thu, 1 Oct 2020 01:05:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33tfk0n66h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Oct 2020 01:05:57 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09115tR4008981;
        Thu, 1 Oct 2020 01:05:55 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Sep 2020 18:05:44 -0700
Subject: Re: [PATCH v3] btrfs: free device without BTRFS_MAGIC
From:   Anand Jain <anand.jain@oracle.com>
To:     "dsterba@suse.com" <dsterba@suse.com>
Cc:     Johannes.Thumshirn@wdc.com, nborisov@suse.com,
        josef@toxicpanda.com,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <dbc067b24194241f6d87b8f9799d9b6484984a13.1600473987.git.anand.jain@oracle.com>
 <e15a2f44a540c1e036e19664fd3a8220045dd762.1601470709.git.anand.jain@oracle.com>
Message-ID: <bacc1617-cee1-c486-79fa-17be73881cb6@oracle.com>
Date:   Thu, 1 Oct 2020 09:05:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <e15a2f44a540c1e036e19664fd3a8220045dd762.1601470709.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9760 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9760 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010004
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David,

  FYI this patch is the fix for fstests btrfs/198

Thanks, Anand


