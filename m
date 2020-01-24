Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADCD114920F
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jan 2020 00:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387398AbgAXX2a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 18:28:30 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33506 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgAXX2a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 18:28:30 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00ONSNAb091183;
        Fri, 24 Jan 2020 23:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=qHvYPHQEZqEY6R+833yM+JqUr4A3BpXKZvs4r4ZYsb0=;
 b=Zv5Oi3uvY0oe25kMNNcWbuStjAetcgBQU1A6Eq1N5QAhIug/bFQa1eza0l9MoJYGfAtP
 o99teeOwX2qP2PtiM4jQ+Kam0ZUa8LgfHntyIh6d2/FfzuZwjQoUx1UmLYuVtS8I775h
 mwgG7JopL6P2PZEp52cgaC3bMr+pJykhPQCEyvkWVOu85HiHVMGw24wMGWP/acR7yQAv
 VFol0ky+hPlU/1yI6J1WbuK+LOLaryyeWmGLczuyfSotECcmtAJqwCGZ9q+Ys0/rZkWh
 /WxhK2o4gUY+AJsDgRhGQbecuE+Fl2K8Yn4IKSIGf3SV9B9RsTIdu4LC1M/c3QGdRNQP eQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xksyquxv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jan 2020 23:28:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00ONSMVo180825;
        Fri, 24 Jan 2020 23:28:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2xqmug2jhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jan 2020 23:28:22 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00ONS4vY007213;
        Fri, 24 Jan 2020 23:28:04 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jan 2020 15:28:03 -0800
Subject: Re: [PATCH] btrfs-progs: fix btrfs-qgroup man page as unstable
 feature
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
References: <20200124072521.3462-1-anand.jain@oracle.com>
 <2a302f48-2acd-d963-0c86-992eccb1fe6a@gmx.com>
 <d5103932-90ef-6674-05c2-4d7723ce0c25@oracle.com>
 <3592adb3-f29c-9b21-6679-f69aae59f7ef@gmx.com>
 <20200124172221.GQ3929@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <14ca9971-b091-7de5-a608-6f1621b79cdd@oracle.com>
Date:   Sat, 25 Jan 2020 07:27:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200124172221.GQ3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9510 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=973
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001240189
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9510 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001240189
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/1/20 1:22 AM, David Sterba wrote:
> On Fri, Jan 24, 2020 at 04:55:23PM +0800, Qu Wenruo wrote:
>>>> For performance, we still have problem, but that should only be snapshot
>>>> dropping.
>>>> Balance is no longer a big problem.
>>>>
>>>> Personally I think the current man page still stands.
>>>
>>>   IMO kernel version in the man page is bit confusing though when
>>>   its still unstable.
>>
>> OK, for the kernel version part the patch makes sense.
> 
> Perhaps the page should be more specific about the problems (snapshot
> deletion, metadata balance) and the versions where it's considered
> problematic and since where it's not. The significant improvement for
> the metadata balance you implemented is IMO worth mentioning, maybe also
> on the wiki page feature changelog.
> 

Good idea. Qu you may write new patch. I am taking this path back.
  Thanks.
