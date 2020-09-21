Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4885E271962
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 04:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgIUCkB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Sep 2020 22:40:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50908 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgIUCkA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Sep 2020 22:40:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08L2dvU7165586;
        Mon, 21 Sep 2020 02:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/Pvc5rDqaLFxES0tjIeKk7xdNZ0zegmmpbZDH3QO+3Q=;
 b=GkRfnGR+gfXERzTwyM7es5PuKKMcUXGsfwaA8/maxAkBJe6SSMYSxWH9LipRktBV51Kf
 7sFsaBFU9ApxJoXvLi9t2AUJqh6hZDmUh6KnG25mWLLglCeopdhFs3ZdqrJyG89h2Azv
 /8/k3sOoODvcKXRBibJlQKovB37aZskVKg39cCNQNuSPff4QVnac8CGXJ39gpl4ITEIJ
 /57gFHBE7f8R0A1PtkAVxZhS+RcA+5DTrP6HlQvG93olNhkVvKzCYWF2h8l6OcjqKBS+
 KlG70KqY/6l6C8SNWi6+Ar4/LRV63XP2nE1VYbO4UQfFB9/rJJJnnAkjiQIEmOCYID4t kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33ndnu2weu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 02:39:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08L2Zk5Z185640;
        Mon, 21 Sep 2020 02:37:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33nuvyf93y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 02:37:56 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08L2bsRJ016144;
        Mon, 21 Sep 2020 02:37:54 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 20 Sep 2020 19:37:54 -0700
Subject: Re: [PATCH] btrfs: remove stale test for alien devices
To:     Eryu Guan <guan@eryu.me>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <20200917141353.28566-1-johannes.thumshirn@wdc.com>
 <f4606506-78a1-4771-96cd-6bc28e6a7074@oracle.com>
 <SN4PR0401MB35987D9F6868271DAD0A05009B3F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200920161532.GP3853@desktop>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <0763fac7-d9a8-e486-ef20-670e139deb14@oracle.com>
Date:   Mon, 21 Sep 2020 10:37:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200920161532.GP3853@desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9750 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210017
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9750 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210018
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21/9/20 12:15 am, Eryu Guan wrote:
> On Fri, Sep 18, 2020 at 07:06:42AM +0000, Johannes Thumshirn wrote:
>> On 18/09/2020 02:15, Anand Jain wrote:
>>> The fix is not too far. It got stuck whether to use EUCLEAN or not.
>>> Its better to fix the fix rather than killing the messenger in this case.
>>
>> OK how about removing the test from the auto group then until the fix is merged?
>> It's a constant failure and hiding real regressions. And having to maintain an
>> expunge list doesn't scale either.
>>
>> Thoughts?
> 

The patch is in the ML for review.

  [PATCH] btrfs: free device without BTRFS_MAGIC

  https://patchwork.kernel.org/patch/11786607/

I am OK if you still think it has to be removed from the auto.
But I don't think it is required now.


> Yeah, please remove it from the auto group then.
> 
> Thanks,
> Eryu
>>
