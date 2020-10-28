Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43A729D809
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Oct 2020 23:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387496AbgJ1W3B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 18:29:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54622 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387470AbgJ1W2w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 18:28:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09S8PCoa106370;
        Wed, 28 Oct 2020 08:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ravJk633C2uE6JSphklEGkafQyLLeeKun8Ka8Tci5S0=;
 b=s81GeZDOEQuedA+GnZL5mXGkxmKNDW+6/GY3m2c4BwFNNaUSv/y2tOEQaDFfdcUnAcDj
 6sK9AmelyQW3FG5vA59GH6E8KN5gOxTbwDq9TVSxWv9BY/w2240v31rRZzFRgOMJaH8T
 uX1M2xJgpcxIA5K5FwbL5t1U9MqRY/lho5NkezM9S0kMIC21IntFjnjOQnm0b6QK5UIH
 corqeTvrSNfVizic8WDh1TYINofhZFaAPKoAmxzW9WrzyUz7RVZefIAKTFxLFBmfRmZ8
 ZZHUTtJq2Cyl+leIaMyISKlwnmQwdb67NYXavGuqfifTV127Vr8AoaeUG7pYgwYocFe4 Zg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34cc7kwyhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 08:32:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09S8UTgc057226;
        Wed, 28 Oct 2020 08:32:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34cwunb546-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 08:32:12 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09S8WAh6001574;
        Wed, 28 Oct 2020 08:32:11 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 01:32:10 -0700
Subject: Re: [PATCH RFC 2/7] block: export part_stat_read_inflight
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <cover.1603751876.git.anand.jain@oracle.com>
 <187d1f02f82019d48f66c97c0d1b99c9a58cd553.1603751876.git.anand.jain@oracle.com>
 <7e98c923-d484-d05e-b5de-4eb85114ba4d@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <d9e13a30-89e6-9e78-1d65-2cef5cc76f36@oracle.com>
Date:   Wed, 28 Oct 2020 16:32:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <7e98c923-d484-d05e-b5de-4eb85114ba4d@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280056
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/10/20 2:10 am, Josef Bacik wrote:
> On 10/26/20 7:55 PM, Anand Jain wrote:
>> The exported function part_in_flight() returns commands in-flight in the
>> given block device.
>>
>> Cc: linux-block@vger.kernel.org
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> This is much more internal to block and I'd rather not rely on it, I 
> feel like getting the average latency is good enough.  Thanks,
> 

And also, as mentioned in the cover letter, it is hard to know the 
relation between the number of inflight commands and its effect on avg 
latency.

So ok, we don't need this.

Thanks, Anand


> Josef

