Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B707EABB
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 05:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfHBDjV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 23:39:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37660 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfHBDjV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Aug 2019 23:39:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x723cmTc046107;
        Fri, 2 Aug 2019 03:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=TrIETqKWhQWbG4+acaYS70cKG/3wlkYgHKzbBHHVmps=;
 b=EdZarclL5+KCpmSB0ZwGbx/JdcHDJr5a4Y5biYQoQec2DXUjEJH4G36B+ZwFxSPD1fBn
 nHCFbB1Co5j+m0z1Vj9g+v0PIPUr2Rsj3c9TZ3ncanC81Ti+etb2iNL3OSetK9AZk8Wd
 2cia3W9Vch7dvwUclL+fxbgTjp/Z80p6464g6/RoL09N1/b8hA3+IjWw6aEoypboPn0h
 apShJWODJDDlTX/K2OoMPehwpVpHaXzcXEpXc3mwgxIlRdqcn2jnHiMuB01ZJR/CPh9H
 BYRZ0GVB7xrKtWhPrLx8/V3xFz3oerhd9FITD15paL6ZE11W8+klbBCJdOcSUrttYwzh ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2u0ejpycku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 03:38:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x723c9Pt127624;
        Fri, 2 Aug 2019 03:38:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2u3mbv1b70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 03:38:53 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x723cqDX029968;
        Fri, 2 Aug 2019 03:38:52 GMT
Received: from [192.168.1.147] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Aug 2019 20:38:52 -0700
Subject: Re: [PATCH 1/2] btrfs: remove unused btrfs_device::flush_bio_sent
To:     David Sterba <dsterba@suse.com>
References: <cover.1564681931.git.dsterba@suse.com>
 <e81ad9bab030f1b4dbde91b6b0f5ef9caee42ab4.1564681931.git.dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <5bbea82d-2d31-23ed-f99f-bfa8b3a39c27@oracle.com>
Date:   Fri, 2 Aug 2019 11:38:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e81ad9bab030f1b4dbde91b6b0f5ef9caee42ab4.1564681931.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9336 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908020036
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9336 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908020036
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/2/19 1:53 AM, David Sterba wrote:
> The status of flush bio is tracked as a status bit, changed in commit
> 1c3063b6dbfa ("btrfs: cleanup device states define
> BTRFS_DEV_STATE_FLUSH_SENT"), the flush_bio_sent was forgotten.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

oops my bad.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
