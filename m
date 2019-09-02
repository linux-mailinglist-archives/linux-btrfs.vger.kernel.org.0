Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8B62A50BD
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2019 10:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfIBICp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Sep 2019 04:02:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42380 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbfIBICo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Sep 2019 04:02:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x827xiFe035735;
        Mon, 2 Sep 2019 08:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=qQkl5wkEtarjPWpjaza7R6gxr+SlLKogrjetlmq3RWg=;
 b=BgVBGELGSXiK/BKXot0x0m1pB7DMCe/eyFtCLlxW/DkzNgk8hzRoLdg8ikUHhaD2agBI
 2vzh+aUWlxVj95xJd5gEjqOZT9FVYnwQINvXVULMXt3PqD6mq/zCiEPZ4lXv6r6N1s43
 FBOgq382NUXYof0W4lV7sKtQqpjLUnmmfrlBmaNKWyCTeCWdUqS/l4JXT1d0o/7rMP0o
 bGHjv88OLY6A65mCXoMj9bBNCCPqn0csuHriwgl9hbI9khOJlRx2kbMNGFULg4b7Obsn
 zxhpKWYp9WBlpGZxOrmC1xUY8wmWiDqbJsfewVIeqhm11GNio3+b+Ib1q2zo/v7rAD3l 6A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2ury6280mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Sep 2019 08:02:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x827wmAn057687;
        Mon, 2 Sep 2019 08:02:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2uqg82tvpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Sep 2019 08:02:05 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x82824Oe002432;
        Mon, 2 Sep 2019 08:02:04 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Sep 2019 01:02:03 -0700
Subject: Re: [PATCH] btrfs_progs: mkfs: match devid order to the stripe index
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz
References: <20190628022611.2844-1-anand.jain@oracle.com>
 <20190703132158.GV20977@twin.jikos.cz>
 <e2ab1be9-8b83-987f-0d88-c1f5547060d4@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <51c42306-b4ae-a243-ac96-fb3acb1a317c@oracle.com>
Date:   Mon, 2 Sep 2019 16:01:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e2ab1be9-8b83-987f-0d88-c1f5547060d4@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=971
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909020090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909020090
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


David,

  I don't see this patch is integrated. Can you please integrated this 
patch thanks.

Thanks, Anand


>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>
>> Added to devel, thanks.
>>
> 
>   I don't see this patch is integrated. Any idea?
> 
> Thanks, Anand

