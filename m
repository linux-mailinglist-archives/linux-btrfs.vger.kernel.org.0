Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18FA29A261
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 02:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504157AbgJ0Bw0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 21:52:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56708 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504096AbgJ0BwZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 21:52:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09R1nEGW008895;
        Tue, 27 Oct 2020 01:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=+9AubAPzbLb9Xwhm4yS8xTeaISbHNPgCQPPxeVQgvHQ=;
 b=LnJcdx2/OoKI8Vaep4oXAbxuVkBS/7jTM4vBIOVfrV+iDmaDoQDnfZBiirM0taf9m4Cw
 fl59QOFecuOl/ogOGe2ZxXsvQHvALuo3PgWxTxympLVDmEOG/jPd9Dt0XZRCG+7k9kz5
 SUnQ2r4mJbA+zcN+76uVZicDoD6+TIouSKjw3Btb9+cqZPNIf1APJ7PcSyh27aZH5jDm
 Q44R76ja1ov28IpkSy9iAuyuX86sKzCRccCB51pxV8c3tQvs8V3sW381gkM/ryMMsTx5
 L9fO6uPuG8F84nKxen7sX3HRwpaDYsW/cFIpHz/TIzkEzdAAgfRHjj5Vxk0zs3oVj/XT jQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34dgm3w314-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 01:52:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09R1pHZV066867;
        Tue, 27 Oct 2020 01:52:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 34cx6vcu9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Oct 2020 01:52:16 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09R1qFAw029432;
        Tue, 27 Oct 2020 01:52:15 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Oct 2020 18:52:15 -0700
Subject: Re: [PATCH v9 0/3] readmirror feature (read_policy sysfs and
 in-memory only approach)
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.com
References: <cover.1603347462.git.anand.jain@oracle.com>
 <20201023170403.GM6756@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <31c3da05-2238-da84-509e-3b29835ec33a@oracle.com>
Date:   Tue, 27 Oct 2020 09:52:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201023170403.GM6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270012
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24/10/20 1:04 am, David Sterba wrote:
> On Thu, Oct 22, 2020 at 03:43:34PM +0800, Anand Jain wrote:
>> v9: C coding style fixes in 1/3 and 3/3
> 
> So the point of adding the sysfs knobs is to allow testing various
> mirror selection strategies, what exactly was discussed in the past. Do
> you have patches for that as well? It does not need to be final and
> polished but at least give us something to test.
> 

Sure. I just sent out the patchset [1]. It provides read_policy: 
latency, device, and round-robin.

[1]
https://patchwork.kernel.org/project/linux-btrfs/list/?series=371023

Thanks, Anand
