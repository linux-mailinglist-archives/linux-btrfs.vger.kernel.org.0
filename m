Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60F4293566
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Oct 2020 09:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404731AbgJTHBy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Oct 2020 03:01:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58888 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404728AbgJTHBy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Oct 2020 03:01:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09K70h0R183363;
        Tue, 20 Oct 2020 07:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=0PktUh+NBzrPBeCqX7mqWPc5+bADzrP/RM5b+xJTzTU=;
 b=TTAzIsIfXt6f7pWuJtopVg3p0F5H4cEKcoh9OJNtOsu2CRq3vbWoOfUzADUA311l4y4C
 VyXEAVJNPyw3+1hxkW+x/TE5AAqXi9oLfnPDmYPYmpd4RyDqgFKlbihOTikrDQL9Vcq7
 n4Yngq0KMBq1QGULO4taFxtUJRJZsaLiRkT9AmeyrmTAJBgks7I/HPWJHSzkskV2EAtn
 3M4eFAq3o3gg7lqFga0vF2MiO+e9n95mntwMid4bpmtJIA0GRjOVOGbZUIfLaLoxMzOs
 6WMXuObg+FvzaEXrwo5REsRVTbydgZzqq/p9iIdCa/ahrPAnQduALKQ2rnOx3peUAQLS 1w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 347s8ms42m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Oct 2020 07:01:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09K6xZuM072342;
        Tue, 20 Oct 2020 07:01:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 348agx21qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Oct 2020 07:01:49 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09K71mHd022636;
        Tue, 20 Oct 2020 07:01:48 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Oct 2020 00:01:48 -0700
Subject: Re: [PATCH] btrfs-progs: btrfs-sb-mod add devid to the modifiable
 list
To:     dsterba@suse.cz
References: <8c8c3cbe61cc62d8a5f09ca497d6e88a0a1cd74d.1602065251.git.anand.jain@oracle.com>
 <20201019183909.GZ6756@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <132a79a4-f8de-6330-66a2-7a7e9aaf8ad3@oracle.com>
Date:   Tue, 20 Oct 2020 15:01:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201019183909.GZ6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=1 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010200044
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=1
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010200044
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/10/20 2:39 am, David Sterba wrote:
> On Wed, Oct 07, 2020 at 06:08:05PM +0800, Anand Jain wrote:
>> We need this patch to create a crafted image with bogus devid.
>>
>> For example:
>> ./btrfs-sb-mod devid =0
> 
> This should maintain some parity with the output of 'dump-super', ie.
> this should have dev_item. prefix.

  Ah. dev_item.devid  is nice.

> There's also total_size for a device
> and this could be confusing with the superblock total_size.
> I'll fix it
> and add the remaining dev_item members as well.

  Ok. Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

  f0b3cf9e3224 btrfs-progs: sb-mod: add syntax to the help text
  bd873c39d3da btrfs-progs: sb-mod: add remaining dev_item members
  5cee4e5a7d2d btrfs-progs: sb-mod: add dev_item prefix for sb::device 
members


Thanks, Anand
