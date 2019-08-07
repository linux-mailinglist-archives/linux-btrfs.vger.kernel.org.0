Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1E084765
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 10:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbfHGIa1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 04:30:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43584 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387516AbfHGIa0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Aug 2019 04:30:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x778TiCp071345;
        Wed, 7 Aug 2019 08:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=b/2lFhxWqQyQoedI2e6nsVMwQxnbsXZZC72z3i9kKnk=;
 b=YQ+yxIGh5RBVIK6y/W7w7UI/LjVCGD3Saw11oc7PunUsMmd606YLPAOskkWLIT6VIMX3
 Esg8f2GzroPRPQAXrmmayr6f461JBrtwnY6vWI/Oz4cOhvcRMGg45I5S/WzqYyC4v/AB
 +c6PWisy39Jhm0wkwJd/bvkXIpeTC4XVEI5gEpqFb2lzF6Nyh+rx2XLkF3pbEisLn7Kd
 huYWbgln3s36SG6NyAmq99oEy+V6xxjllKmhFUXWL4sSRog3lt9Fw0Ytvzd4NZrjdBij
 dMnEk7w5rV1k3jE4z28vSkZFlrEx3kawAwPd9k+LbZngfNjst8iWJvat5ZJ+Oh18Jaut 1Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2u527ptr9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Aug 2019 08:29:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x778SCY3056208;
        Wed, 7 Aug 2019 08:29:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2u7577qr7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Aug 2019 08:29:56 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x778TsXp030708;
        Wed, 7 Aug 2019 08:29:54 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Aug 2019 01:29:54 -0700
Subject: Re: [PATCH 0/2] Sysfs updates
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1564505777.git.dsterba@suse.com>
 <939d08f0-e851-4f00-733e-c7de15685318@oracle.com>
 <20190806164604.GN28208@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <1893f2cd-b2d3-875e-977f-ce2c8ec43852@oracle.com>
Date:   Wed, 7 Aug 2019 16:29:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190806164604.GN28208@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908070092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908070092
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/8/19 12:46 AM, David Sterba wrote:
> On Tue, Aug 06, 2019 at 11:17:09PM +0800, Anand Jain wrote:
>> On 7/31/19 1:10 AM, David Sterba wrote:
>>> Export the potential debugging data in the per-filesystem directories we
>>> already have, so we can drop debugfs. The new directories depend on
>>> CONFIG_BTRFS_DEBUG so they're not affecting normal builds.
>>>
>>> David Sterba (2):
>>>     btrfs: sysfs: add debugging exports
>>>     btrfs: delete debugfs code
>>>
>>>    fs/btrfs/sysfs.c | 68 +++++++++++++++++++++++-------------------------
>>>    fs/btrfs/sysfs.h |  5 ----
>>>    2 files changed, 32 insertions(+), 41 deletions(-)
>>>
>>
>> For 2/2:
>>    Reviewed-by: Anand Jain <anand.jain@oracle.com>
>>
>> For 1/2:
>>    IMO it would be better to delay this until we really have a debug hook
>>    exposed at the sysfs.
> 
> Sorry, I don't understand what you mean.
> 

  I notice that /sysfs/fs/btrfs/<debug>|<fsid/debug> is dummy as of now,
  IMO its better to add this (1/2) patch along with the some actual trace
  which is needed. Potentially either dtrace/bfp probes will be better
  runtime debugging approach.

Thanks, Anand
