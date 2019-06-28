Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF78959192
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2019 04:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfF1Cr5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jun 2019 22:47:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49008 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfF1Cr4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jun 2019 22:47:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S2hx7Z175055;
        Fri, 28 Jun 2019 02:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=lC/ma62zwdWbGkw4GXf2Kg+jzklcDsLDdWs+taUi5Iw=;
 b=zUoiK4ifC+WvkaRtnIirQl+eFMltT6KfdeguQ2P0mN6mnaqMntXHqb1bgnggScSy3H6r
 CUL/HQ2rbOpWpYrV9NWTJ6pJTjq79MpS4D8xdbcurjW8yR8UEvLslOvz1JG9jn/w094O
 zFaTcQHhz7ao9mWLdfVD7ATV0BoSbXjmTFJTgDLeExhDUV5p6Tvp0ltvCgTfL7Uz/92o
 +8rSF/UEWSQnefg4K5ItIX6Wj+J39JBQ6RzWCuS+RkWU3Y7bdvrNtNNF2ux0dhaIQSPM
 1yypyQbMZOXZLzDQvZwELK7YrS+TGtEETSXxSIzXR3ji9kbeGSrs0xT3Su54ScF0Nryb fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t9cyqu63c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 02:47:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S2k3tO129930;
        Fri, 28 Jun 2019 02:47:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2t99f5bavf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 02:47:46 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5S2lhVG028219;
        Fri, 28 Jun 2019 02:47:43 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 19:47:43 -0700
Subject: Re: [PATCH 1/2] btrfs: inode: Don't compress if NODATASUM or
 NODATACOW set
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20180515073622.18732-1-wqu@suse.com>
 <20180515073622.18732-2-wqu@suse.com>
 <95e8171b-6d08-e989-a835-637ccf2efe76@gmx.com>
 <20190627145849.GA20977@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <fa804a25-b0a8-ad1d-760a-bf543418970a@oracle.com>
Date:   Fri, 28 Jun 2019 10:47:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190627145849.GA20977@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280026
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/6/19 10:58 PM, David Sterba wrote:
> On Tue, Jun 25, 2019 at 04:24:57PM +0800, Qu Wenruo wrote:
>> Ping?
>>
>> This patch should fix the problem of compressed extent even when
>> nodatasum is set.
>>
>> It has been one year but we still didn't get a conclusion on where
>> force_compress should behave.
> 
> Note that pings to patches sent year ago will get lost, I noticed only
> because you resent it and I remembered that we had some discussions,
> without conclusions.
> 
>> But at least to me, NODATASUM is a strong exclusion for compress, no
>> matter whatever option we use, we should NEVER compress data without
>> datasum/datacow.
> 
> That's correct, 

  But I wonder what's the reason that datasum/datacow is prerequisite 
for the compression ?

Thanks, Anand

>but the way you fix it is IMO not right. This was also
> noticed by Nikolay, that there are 2 locations that call
> inode_need_compress but with different semantics.
> 
> One is the decision if compression applies at all, and the second one
> when that's certain it's compression, to do it or not based on the
> status decision of eg. heuristics.
> 

