Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4586266F2A
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2019 14:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfGLMuG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jul 2019 08:50:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58118 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfGLMuF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jul 2019 08:50:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6CCnDS3044561;
        Fri, 12 Jul 2019 12:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=OVz0C7J++rAdc87gDc/BVCDeku5EvkTnvWo7ebWEvZo=;
 b=VjLeSdYWc2621pvkuSD0K7gIr0bBtZGhEzNAVZ+DcND5C0VrUP7A7oHPaOHa/qoBMqYt
 MVk1v/P26DeoUq7mJ3IIWcEZA/FwqFFdS+Sl34cQqPBq2lqmwEQe2lBVYBcpDxF+wGug
 9etTkJdPoJwEbyjF7KNRRpB11DvyvpjXaGerWEMmsfN3WvGVUu8+a9aZRYJxVATPM+CV
 iMU8i5SmPIM8+N6vOTFKbR6q7MbuGq2Q3ir3GxpnE3WMbpX385yPGoSeCfhyfbEOkqnk
 d30aU5r+dqydZKr5biF/KRwDjDKURLKyFbUSSrwkOZZ5N+WLZJUL4QU2HSAq13K/LiEJ gQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2tjm9r5dtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 12:50:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6CClh2N192077;
        Fri, 12 Jul 2019 12:50:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2tpefd2w4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 12:50:01 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6CCo0od009239;
        Fri, 12 Jul 2019 12:50:00 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jul 2019 05:50:00 -0700
Subject: Re: "btrfs: harden agaist duplicate fsid" spams syslog
To:     Christoph Anton Mitterer <calestyo@scientia.net>,
        linux-btrfs@vger.kernel.org
References: <5d8baf80-4fb3-221f-5ab4-e98a838f63e1@cobb.uk.net>
 <c01ab9f6-c553-3625-5656-a8f61659de7d@oracle.com>
 <e483092adc63d3d86cb99c8e4dcbd56f1d1539b8.camel@scientia.net>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <e806da6a-e4c8-2ce8-2d1a-b391938fada1@oracle.com>
Date:   Fri, 12 Jul 2019 20:49:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e483092adc63d3d86cb99c8e4dcbd56f1d1539b8.camel@scientia.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120140
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/7/19 7:06 AM, Christoph Anton Mitterer wrote:
> I'm also seeing these since quite a while on Debian sid:
> 
> Jul 11 13:33:56 heisenberg kernel: BTRFS info (device dm-0): device fsid 60[...]3c devid 1 moved old:/dev/mapper/system new:/dev/dm-0
> Jul 11 13:33:56 heisenberg kernel: BTRFS info (device dm-0): device fsid 60[...]3c devid 1 moved old:/dev/dm-0 new:/dev/mapper/system
> Jul 11 23:43:35 heisenberg kernel: BTRFS info (device dm-0): device fsid 60[...]3c devid 1 moved old:/dev/mapper/system new:/dev/dm-0
> Jul 11 23:43:35 heisenberg kernel: BTRFS info (device dm-0): device fsid 60[...]3c devid 1 moved old:/dev/dm-0 new:/dev/mapper/system
> 
> In my case it's a simply dm-crypt layer below the fs.
> 
> 
> Some years ago, there was a longer thread on this list about the
> fragility of btrfs with respect to accidentally or intentionally
> colliding UUIDs.

> IIRC there were quite some concerns that this could have even a big
> security impact when an attacker e.g. plugs in a device with a certain
> UUID and the kernel or userland automatically adds or somehow else uses
> such device (just by UUID).

> Back then it was said this would be looked into... has anything
> happened there?

Thanks for refreshing on that report. Looking into it.

-Anand

> 
> Cheers,
> Chris.
> 

