Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30E829E14C
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 03:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgJ2CAE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 22:00:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59976 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbgJ2B62 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 21:58:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09T1mo7d121845;
        Thu, 29 Oct 2020 01:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=QbwqWMD/dkclGHof01BSi7G23d+PDzGOlOVjkjEJjL8=;
 b=znTn6CaATr/vtY3Kf4qJd386qtVJ2u3LSHfoGQ80hLleErvFiZxacWDWch1cgIaoEk1x
 1beD9Dkd3Xl9Rz2ZT6BMhdeQ8V+pbnwYiKRLUfryAI6uudgvoyk2Ow5zUvAibHWJMS9d
 MZMM1tl3T8qcvNpZvCRo4lzeUj8tpJZt6AFr7TF6j8cHh25mg8Zx9+XlX05yqehCFgo+
 BsXgHLqkf3xp9WxWdgeSdd1YaWbS/EOsMFtxPn40cbZAfo7CYoMEOcmrI6vwzL9kYPyp
 4UhmI5U5tWPVZr1h1PLmDFl4WjsQiMPu4GR3a/hYFfw/YiLdmFnFhTk5k53m7wLYUEth eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34dgm48274-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 01:58:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09T1o7nd188058;
        Thu, 29 Oct 2020 01:56:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34cx6009dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 01:56:22 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09T1uKNm023768;
        Thu, 29 Oct 2020 01:56:20 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 18:56:20 -0700
Subject: Re: [PATCH 3/4] btrfs: introduce new read_policy device
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1603884539.git.anand.jain@oracle.com>
 <858d5cb67f299fbdd7a8e7bfab66b426bbe54e0c.1603884539.git.anand.jain@oracle.com>
 <a467a511-e2e4-f79b-d316-cf7f9ddb3e12@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <35d39972-4ad7-8723-7408-4d5aca422742@oracle.com>
Date:   Thu, 29 Oct 2020 09:56:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <a467a511-e2e4-f79b-d316-cf7f9ddb3e12@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290009
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




>> +static int btrfs_find_read_preferred(struct map_lookup *map, int 
>> first, int num_stripe)
>> +{
>> +    int stripe_index;
>> +    int last = first + num_stripe;
>> +
>> +    /*
>> +     * If there are more than one read preferred devices, then just 
>> pick the
>> +     * first found read preferred device as of now.
>> +     */
>> +    for (stripe_index = first; stripe_index < last; stripe_index++) {
>> +        if (test_bit(BTRFS_DEV_STATE_READ_PREFERRED,
>> +                 &map->stripes[stripe_index].dev->dev_state))
>> +            return stripe_index;
>> +        }
> 
> b4 isn't working for me because these patches didn't make it to 
> linux-btrfs proper for some reason, 

  Yep. Since yday I am getting email delivery failure.

-----
for recipient address <linux-block@vger.kernel.org> the policy analysis 
reported: zpostgrey: connect: Connection refused
-----

> so I could be wrong here, but it 
> looks like this } is off?  There's spaces here instead of a tab maybe?

> If not then just ignore me. Thanks,
Yeah tab is ok. Its just in the email.

Thanks, Anand

> Josef
