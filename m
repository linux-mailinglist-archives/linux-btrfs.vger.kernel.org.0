Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC69103408
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 06:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfKTF5L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 00:57:11 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48348 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKTF5L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 00:57:11 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAK5djav104035;
        Wed, 20 Nov 2019 05:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=e5LumUBOfNenUpDHyTAGkDWOmN4fBgRHDe0UbBYJU1c=;
 b=r695/XYA00k34WySHAf4/VkyhCAzRGTP57ugyj5EoLX6CTBoQNw3Z6J6D4vxr+anbVeW
 m8SAkXjoJ+rOa08eoydmtlIt6/IgZtenvZd0N+tAS7KBPAoy7+591rJMnhPyS/97Srki
 hkD4JMV9A7j5Wvv1BMhtvISGshgoB6sXI6uTZLOTI7AvOopmycqI7IjzsywDRJlN4GxJ
 v109cFUz1eK3ys+ibpYSzNoeHtL/W5OF7CEPXRkoysDI13QtDiyGqcjtjY2qgHnpyGQF
 pTEIfobGmFJugxAFOEpCpSLXlp+wK5QrI8I+OiXSkncEdQFzHyDEt/anzLuXLpuyTDp9 TQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wa9rqk7am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 05:56:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAK5cABw085091;
        Wed, 20 Nov 2019 05:56:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wc0ahp3v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 05:56:09 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAK5u81i030546;
        Wed, 20 Nov 2019 05:56:08 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Nov 2019 21:56:08 -0800
Subject: Re: [PATCH 05/15] btrfs: sysfs, move /sys/fs/btrfs/UUID related
 functions together
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191118084656.3089-1-anand.jain@oracle.com>
 <20191118084656.3089-6-anand.jain@oracle.com>
 <8972a47c-2fcc-f980-8e76-a7dc945ee939@suse.com>
 <20191119105856.GQ3001@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <12c01ace-20c9-7cbd-d9c3-2b01d95c1f42@oracle.com>
Date:   Wed, 20 Nov 2019 13:56:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191119105856.GQ3001@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911200052
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911200052
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/19/19 6:58 PM, David Sterba wrote:
> On Tue, Nov 19, 2019 at 11:24:37AM +0200, Nikolay Borisov wrote:
>>
>>
>> On 18.11.19 г. 10:46 ч., Anand Jain wrote:
>>> No functional changes. Move functions to bring btrfs_sysfs_remove_fsid()
>>> and btrfs_sysfs_add_fsid() and its related functions together.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>
>>
>> This seems like pointless code motion.
> 
> Yeah, unless there's some other reason to move the code, just plain
> moves are not desired.
> 

  The reason was - btrfs_sysfs_add_fsid() and btrfs_sysfs_remove_fsid()
  are related. Easy to read and verify to have placed them one below
  other.

  Ok not a big deal. I am ok either ways.

