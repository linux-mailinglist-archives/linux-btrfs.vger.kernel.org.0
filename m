Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E112A5B56
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 01:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgKDAzw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 19:55:52 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48068 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgKDAzw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 19:55:52 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A40rP75118327;
        Wed, 4 Nov 2020 00:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=XgvmG0sLxoc0GzdGqpZ+suRkAC5jGAzJl0Fzcey1lkM=;
 b=vHa09Fq+9LR0tIfvwWyToKrvAj8PsWLZXQCqsidoJ9ZdBSEn+brO0FNbA0ExWrWVwxsE
 JdPj6k3DZPasTobLvvSJ+fLDk2fzoQEmdGbKOz6gtx4tEdtw8Q3dikIUu6Ku3aJrtDe1
 8z6DWM9Li8nHKNa7r7u6zv8/T2tpG8cJs3/bb9uNCnzNmG+3mvgeLAD6PcuSwffhCjja
 z0ckTlMzLdcQAmcgVrcya57vp0Atm0wEqfsJYvFPH4Jzpfed9nKFuUX8DDNLHCQSjWlY
 +I39XcQJhR6aUKFlHsSyQEi/yV+uxvTjSRCUsaP1dWTjICOXa4dQjkYa+suoUjvq5u3A Pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34hhvccaam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 04 Nov 2020 00:55:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A40oTxb033130;
        Wed, 4 Nov 2020 00:55:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34hw0hsyxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Nov 2020 00:55:43 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A40tgGt017603;
        Wed, 4 Nov 2020 00:55:42 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Nov 2020 16:55:42 -0800
Subject: Re: [PATCH RESEND v2] btrfs: fix devid 0 without a replace item by
 failing the mount
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com,
        syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com
References: <cover.1604009248.git.anand.jain@oracle.com>
 <d0b5790792b8b826504dd239ad9efc514f3d9109.1604009248.git.anand.jain@oracle.com>
 <20201103183618.GA6756@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <556d196c-24df-b6f2-8a7b-3569f1421e17@oracle.com>
Date:   Wed, 4 Nov 2020 08:55:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103183618.GA6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=2 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040003
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 1b2742da5d4a..bb6f067f2fb9 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -1056,22 +1056,13 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
>>   			continue;
>>   		}
>>   
>> -		if (device->devid == BTRFS_DEV_REPLACE_DEVID) {
>> -			/*
>> -			 * In the first step, keep the device which has
>> -			 * the correct fsid and the devid that is used
>> -			 * for the dev_replace procedure.
>> -			 * In the second step, the dev_replace state is
>> -			 * read from the device tree and it is known
>> -			 * whether the procedure is really active or
>> -			 * not, which means whether this device is
>> -			 * used or whether it should be removed.
>> -			 */
>> -			if (step == 0 || test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
> 
> This removes the use of step parameter so it can be removed from the
> call chain too (separate patch).

  Will see to it.

> Patch added to misc-next, thanks.

Thanks.
