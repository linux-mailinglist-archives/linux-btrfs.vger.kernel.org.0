Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB3710E940
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 12:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfLBLCd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 06:02:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37548 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfLBLCd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 06:02:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2As8t7081888;
        Mon, 2 Dec 2019 11:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=UMQ2RSntZkZvofydqwwVGa8grQ2sA6xJfZS8x5GyK8A=;
 b=Iojz1tApUpz/Uc/G/7wafxUeTbTmfheMctDKlV70IcXaeKROuY9wa01dtqOnD68x13ad
 F6TR163Sn5SMIz2s1vFOvbcu7hXCCf18JFaorXYafH6FqekJ0xYvaYwbHbLJxIRATFlz
 j0QpJ9EDj3lk6WlXZCq8/7gysTbKkw+J29mctQqMvJqz3EQ3ilTYUWnEUmBjZRsr7k8O
 kih21PCDYT0hXfDv2UvatNx0SYpPSdzipbFg1m++FWaz1w2A4sNK04SZAPoyifngYYnn
 FM4jzmJrsDixf+EukC9xwUDqdzx0h0PDZ38OAqapuV+Kp/q9cP2mg+as2Xpi24TWKjLt Nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wkgcpy6nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 11:02:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2AsDt0051152;
        Mon, 2 Dec 2019 11:02:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wm2jvmqsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 11:02:30 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB2B2Tp2003651;
        Mon, 2 Dec 2019 11:02:29 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Dec 2019 03:02:28 -0800
Subject: Re: [PATCH 0/6] btrfs-progs: add support for LOGICAL_INO_V2 features
 in logical-resolve
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20191127035509.15011-1-ce3g8jdj@umail.furryterror.org>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <3d8298c5-bab4-67f5-2bf7-8156865d949f@oracle.com>
Date:   Mon, 2 Dec 2019 19:02:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191127035509.15011-1-ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9458 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912020100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9458 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912020100
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/11/19 11:55 AM, Zygo Blaxell wrote:
> This patch set adds support for LOGICAL_INO_V2 features:
> 
>          - bigger buffer size (16M instead of 64K, default also increased to 64K)
> 
>          - IGNORE_OFFSETS flag to look up references by extent instead of block
> 
> If the V2 options are used, it calls the V2 ioctl; otherwise, it calls
> the V1 ioctl for old kernel compatibility.
> 
> 

For the whole series.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

(Nit: This should be v4 as this patch was submitted before:

https://lore.kernel.org/linux-btrfs/20170922175847.6071-1-ce3g8jdj@umail.furryterror.org/T/#t
)

