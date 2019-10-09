Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC25DD085F
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2019 09:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfJIHfg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Oct 2019 03:35:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50916 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfJIHfg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Oct 2019 03:35:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x997YIHR071366;
        Wed, 9 Oct 2019 07:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=SdZq9F0UL/wC5iCun5/OzBIV3ZLGaGIqP+S3Pl6WK9Y=;
 b=YAsLQ2UNIDXOymk4f2I88bUH3A6MgsZPjTbp8BPFOUDNFikK1WvGoIG+2isfunrBJh+/
 ayrUOl6EQkG6dizr/sINUDkVi4IUKzxMaagjFMagbCEmtYaTrBDodoMvRW+DCo9EBvHe
 oh0qy1NiklydUkIlgtfAzzlFVBhv7x5Hdqaz7Y0gCllffYLCBY1ytx5Wb4on9ngI/8E4
 W8+4j+T1nUs81rI63oQyNhZIlMI0EjTKwgMPYuS4di75y0GjrzB3gKE/msCBPEPfZ6Vs
 o4IMpgR2drYZ+bC5Ai9telL5HsSzVWD87ft6lnXrxqoMa+qqf7cZ/+6nm10Rt7X9Hhpv lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vek4qj8bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 07:35:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x997Xr2J052735;
        Wed, 9 Oct 2019 07:35:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vgefc5ngr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 07:35:29 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x997ZS8p028061;
        Wed, 9 Oct 2019 07:35:28 GMT
Received: from [10.190.176.95] (/192.188.170.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 00:35:28 -0700
Subject: Re: [PATCH] btrfs: opencode extent_buffer_get
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20191008112847.14359-1-dsterba@suse.com>
 <0e0edb46-a58c-8dad-4acc-b755b5524354@suse.de>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <1bf53bd8-de2f-4298-26d4-64a9bd9e9bb0@oracle.com>
Date:   Wed, 9 Oct 2019 15:35:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0e0edb46-a58c-8dad-4acc-b755b5524354@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=943
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910090071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910090071
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/8/19 7:35 PM, Johannes Thumshirn wrote:
> On 08/10/2019 13:28, David Sterba wrote:
>> The helper is trivial and we can understand what the atomic_inc on
>> something named refs does.
>>
>> Signed-off-by: David Sterba <dsterba@suse.com>
>> ---
>>
>> quiz: find where and how is the refs are decremented
> 
> 
> free_extent_buffer(), free_extent_buffer_stale(),
> release_extent_buffer() and alloc_extent_buffer() in free_eb label ;-)

  -ditto- ;-)


Reviewed-by: Anand Jain <anand.jain@oracle.com>

> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> 
> 
> 

