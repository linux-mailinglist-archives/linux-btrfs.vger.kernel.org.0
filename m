Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63418147999
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 09:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbgAXIsV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 03:48:21 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56596 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAXIsV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 03:48:21 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00O8h9EZ005444;
        Fri, 24 Jan 2020 08:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=8COMlZBQ6sEgZRmAdP2CTwod/Zcr7WdeGfAXu2gLwwQ=;
 b=KXBFGL/4oVKcv1J4iC7cLXeDlxPP40srSUS64k8uT9nbYCqT4Y5s8FUlqhRLmuGUbd56
 z5PA2O6wof/LIRKbiCoq68xfPJ+7RVjUYfo/fHq8/K79nY1wj96VQLS+ksZ3PNCokpD+
 XHkvnprFzsHdc5A2GggLCtT/LMhVFqd5VYLi6MOIS1NgG9Fc+471s5M0y3kZEqivzWid
 /I4sMWBZPBCNJKv1vCR1YkdhQsc0kV6inkp35uZVfDCKnL6eLRA6Ovu7jU2hC/w/4WRU
 H5FcU2ygimNnJekD92rYORIl/vtzD1uz7mBWCMJCKK/abHjMLji545o3/tYITvYrxGoS 6Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xkseuyry2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jan 2020 08:48:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00O8hsUs191467;
        Fri, 24 Jan 2020 08:46:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xqmuyft9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jan 2020 08:46:17 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00O8kGO5014905;
        Fri, 24 Jan 2020 08:46:16 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jan 2020 00:46:16 -0800
Subject: Re: [PATCH] btrfs-progs: fix btrfs-qgroup man page as unstable
 feature
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20200124072521.3462-1-anand.jain@oracle.com>
 <2a302f48-2acd-d963-0c86-992eccb1fe6a@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <d5103932-90ef-6674-05c2-4d7723ce0c25@oracle.com>
Date:   Fri, 24 Jan 2020 16:46:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2a302f48-2acd-d963-0c86-992eccb1fe6a@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001240072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001240072
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24/1/20 3:28 PM, Qu Wenruo wrote:
> 
> 
> On 2020/1/24 下午3:25, Anand Jain wrote:
>> There are known performance and counting errors for the quota when qgroup is
>> enabled.
> 
> Counting error is a big problem, please report if you found one not
> caused by impersistent qgroup status.

  I mean the already known issues btrfs/153 (count error on write to
  falloc-ed space) and btrfs/179 (after a lot of snapshot
  create and distroy with fsstress on subvol the btrfs check
  reports qgroup count diff).

> For performance, we still have problem, but that should only be snapshot
> dropping.
> Balance is no longer a big problem.
> 
> Personally I think the current man page still stands.

  IMO kernel version in the man page is bit confusing though when
  its still unstable.

Thanks, Anand

> Thanks,
> Qu
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   Documentation/btrfs-qgroup.asciidoc | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/Documentation/btrfs-qgroup.asciidoc b/Documentation/btrfs-qgroup.asciidoc
>> index 0c9f5940a1d3..2da3d7819ba6 100644
>> --- a/Documentation/btrfs-qgroup.asciidoc
>> +++ b/Documentation/btrfs-qgroup.asciidoc
>> @@ -16,8 +16,7 @@ DESCRIPTION
>>   NOTE: To use qgroup you need to enable quota first using *btrfs quota enable*
>>   command.
>>   
>> -WARNING: Qgroup is not stable yet and will impact performance in current mainline
>> -kernel (v4.14).
>> +WARNING: Qgroup is an unstable feature as of now.
>>   
>>   QGROUP
>>   ------
>>
> 
