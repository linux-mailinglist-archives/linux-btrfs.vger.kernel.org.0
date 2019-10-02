Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9368DC464D
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 06:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfJBELj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 00:11:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47564 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfJBELj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Oct 2019 00:11:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9249ScT145648;
        Wed, 2 Oct 2019 04:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=oHUsFJyQlFnP2Lhz/7d1N9gt+L9vp5VE6iLp4LhrpVE=;
 b=ABZHWPyXXrNWtiT2QnGo1LDIYghG18PNUm9AlJX+vtJD0XME0782RiHQ0R4L1eWgcDFA
 3na3fyb+lrZmocXeZqcJuDOvRZmZSOMvirPSmcRutn5waszylz33oxNBvIAhRg4vKbPw
 YEDkCRHgGWjf/9tE0CgfjcYJqOHdPfWIwB/EZjtqvIip2PesedIKyJ6HSz/oL8LjLgWX
 ipXejsm+0Da7x6A0bBCP3r/RO7OZwuhMu7ATNIYrOVFsT5H8NXzsbkGIFNUccRJ7AZty
 EhI4OF5LJaX0nmh9hZNx2f1tKyLH9mYJUhGKcOsQsnaBrIXvF6Bh4E4xU9VJU/nvx6tm 9A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2v9yfqaf4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 04:11:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9248dg9061118;
        Wed, 2 Oct 2019 04:11:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vcg60f2r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 04:11:33 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x924BVuf000407;
        Wed, 2 Oct 2019 04:11:32 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 21:11:31 -0700
Subject: Re: [PATCH v2 RESEND] btrfs-progs: add verbose option to btrfs device
 scan
From:   Anand Jain <anand.jain@oracle.com>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     linux-btrfs@vger.kernel.org
References: <1569398832-16277-1-git-send-email-anand.jain@oracle.com>
 <1db59f87-9abc-c0ca-a086-3c65eaa5e629@oracle.com>
 <b8929b52-817f-beb4-d371-188d0edfba91@cobb.uk.net>
 <818e0fa9-208b-4210-8144-7a85fcf28f30@oracle.com>
Message-ID: <2daf15de-d1e7-b56a-be51-a6a3062ad28a@oracle.com>
Date:   Wed, 2 Oct 2019 12:11:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <818e0fa9-208b-4210-8144-7a85fcf28f30@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910020036
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910020036
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/1/19 6:37 PM, Anand Jain wrote:
> 
>> Shouldn't "--verbose" be accepted as a long version of the option? That
>> would mean adding it to long_options.
> 
> For verbose we provide -v in
>     btrfs balance
>     btrfs convert
>     btrfs filesystem
>     btrfs inspect-internal
>     btrfs rescue
> 
> and -v|--verbose in
>     btrfs send
>     btrfs restore
>     btrfs subvolume
> 
> we kind of lost the consistency. But most of it is -v.

  Added --verbose in v3. It is now consistent within
  btrfs dev scan sub-command. Thanks.

-Anand

> 
>> The usage message cmd_device_scan_usage needs to be updated to include
>> the new option(s).
> 
>   Will do.
> 
>> I have tested this on my systems (4.19 kernel) and it not only works
>> well, it is useful to get the list of devices it finds. If you wish,
>> feel free to add:
> 
> Thanks.
> 
>> Tested-by: Graham Cobb <g.btrfs@cobb.uk.net>
> 
> Thanks, Anand
> 
>> Graham

