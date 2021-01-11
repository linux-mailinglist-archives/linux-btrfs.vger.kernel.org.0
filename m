Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFD32F0F90
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 11:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbhAKJ6y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 04:58:54 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45500 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbhAKJ6x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 04:58:53 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10B9reBM039830;
        Mon, 11 Jan 2021 09:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=3DiGjJtoI//fN4SLP7PL1zGh1SmhrCi+9rgYpHn7to4=;
 b=ZYEKCNbnXUjBCX7SB2gCDclwW0qaporSwbNZCfHGVBLY/Eh1tIlcTSE3k6UTJs88hwmA
 LHYv+rpg89v3KbtYFonKuRUAvPiq+lkXV8svPykG30Z9DTQsfv3NlKPDFW42dLDTTyD8
 NA7fd3lnlit6srpEKZDkadbJ6uVyW+MT3m94P/z72I/QiaHcOqze3YEARxDgMlo/oykx
 2qf7dRy6j+YIh4bSPs2MN5EsJbZHMLwGy3wSIQfrfe0MPHmhhrhiMivdzUk0jjgfEJUI
 pkMNipyYiVSUhW+xJZq5g7uT8b31jGdcSAdszag9fyzVifCqdl8hi0zZ88Qfid+QB5rH iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 360kcygcde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jan 2021 09:58:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10B9tp2n129178;
        Mon, 11 Jan 2021 09:56:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 360kew22hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 09:56:05 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10B9u4hx006270;
        Mon, 11 Jan 2021 09:56:04 GMT
Received: from [192.168.10.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Jan 2021 01:56:04 -0800
Subject: Re: [PATCH] btrfs: fixup read_policy latency
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com
References: <df71f31c04177b7f5977944b0f1adcecca13391b.1603950490.git.anand.jain@oracle.com>
 <e9cd491fb05be97dbba756b7d0b9df3418b02a1d.1609916374.git.anand.jain@oracle.com>
 <20210108135719.GW6430@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <1c7e9f3a-b611-c0d4-ae3f-48a22207b946@oracle.com>
Date:   Mon, 11 Jan 2021 17:55:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210108135719.GW6430@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9860 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110058
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9860 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110058
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 8/1/21 9:57 pm, David Sterba wrote:
> On Wed, Jan 06, 2021 at 03:08:15PM +0800, Anand Jain wrote:
>> In the meantime, since I have sent the base patch as below [1], the
>> block layer commit 0d02129e76ed (block: merge struct block_device and
>> struct hd_struct) has changed the first argument in the function
>> part_stat_read_all() to struct block_device in 5.11-rc1. So the
>> compilation will fail. This patch fixes it.
>>
>> This fixup patch must be rolled into its base patch [1].
>> [1] [PATCH v2 1/4] btrfs: add read_policy latency
>>
>> I will include these changes in the base patch after the review comments.
> 
> It would be better to resend the patchset in this case as the fixup is
> not just cosmetic. So far there's no discussion ongoing so resend would
> not break the flow.
> 

  Yep. Please find v3 in the ML also I have updated the cover page with
  the performance comparison table.

Thanks, Anand
