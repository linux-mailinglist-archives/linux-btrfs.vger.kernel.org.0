Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531F01ECDC6
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 12:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgFCKnN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 06:43:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50456 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgFCKnN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Jun 2020 06:43:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053AgNeC014315;
        Wed, 3 Jun 2020 10:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=qVQujuccg95i1Z25P6CCU9ZwGb7/RArYyVW80oFxs50=;
 b=Obf7SorXDo7RMMpmXUlF4EsyJTKGCdE1DBT9YRDrF79bwEU5IhFV9a4BGxJafHUHv6/i
 80JUqNrH4SIgTjhFfNV+SRKsTEHlAwweTcXhTLDBUSn8dw82/c3CMj1C9fWZiHoS9ZhD
 EVYH8JzXmGG4108h6kHRswdx3v5D+gKYHbWNdFWCEvW97FMuJf9JRx87z6VJ2DzmX/hh
 KjmxIsjE5DSECwsYSzGMwXdrGs1xtKapNxPIzuGPWBjAbiDGVw/ubxZ55ryloPHr5wVb
 +bxnn4y6TJl2j48MNJJYICOrf3P6gvUI0bwdghP5tpIYP3htpYyjMmqspLPqwiHTjHbv eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31dkrunmwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 03 Jun 2020 10:43:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053Ac0rM011558;
        Wed, 3 Jun 2020 10:43:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31dju31eke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jun 2020 10:43:11 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 053AhAMg023468;
        Wed, 3 Jun 2020 10:43:10 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 03:43:10 -0700
Subject: Re: [PATCH 2/3] btrfs: rename btrfs_block_group::count
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20200603101020.143372-1-anand.jain@oracle.com>
 <20200603101020.143372-3-anand.jain@oracle.com>
 <CAL3q7H7g6DA7S27RM8o=uG7wbXbvKYKvc6ot2qnnaY1A73kPhA@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <f01398d6-2a0a-95e3-9372-2029626a3447@oracle.com>
Date:   Wed, 3 Jun 2020 18:43:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7g6DA7S27RM8o=uG7wbXbvKYKvc6ot2qnnaY1A73kPhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 suspectscore=1 malwarescore=0 clxscore=1011
 adultscore=0 mlxlogscore=999 cotscore=-2147483648 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030084
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/6/20 6:19 pm, Filipe Manana wrote:
> On Wed, Jun 3, 2020 at 11:13 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> The name 'count' is a very commonly used name. It is often difficult to
>> review the code to check if there is any leak. So rename it to
>> 'bg_count', which is unique enough.
> 
> Hum? Seriously?
> 
> count to bg_count?
> It's a member of the block group structure, adding a bg_ prefix adds
> no value at all, we know the count is related to the block group.
> I could somewhat understand if you named it 'refcount' instead.


Oh right. Now, bg_count does not make sense to me as well.

Something like bg_refcount is better so that it is easy to search
where all its been used. IMO.

Are we ok with btrfs_block_group::bg_refcount instead ?

Thanks,
Anand


> Thanks.
