Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E044F2AFF60
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 06:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgKLFcb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 00:32:31 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48072 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgKLDHV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 22:07:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AC35Lsb005628;
        Thu, 12 Nov 2020 03:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=KazDb6T+B9ZJDz55nRFBuKjvoi+xZlJHnUwu5It3D/Y=;
 b=lJIvyKDda7BKrbyU8gWWf0b8UtzBz3q5nCu1qheBtznd7Bl9ZI8D/xWpmp/MmKXjH8Ry
 p4tEwi0HU1vR/iDDA/WdL5E6AxJkB7mm9aa+QwbBMHga/9jaPJ7ruana748Mb2n0lTLa
 lpROf0QHJLBTkZDDM1fzuj1mykl30vOiy3movTVHrVxvKivzNR/WrfZqz/wdiq/P3ojH
 297RNtcyFGu2SXzZhgZ2wE+RiK+jonR4pGICEen3PqD/3br+wAPrW1VlT0sx4H8DmMVc
 Js4JefdyAG/icJAjEbLECn+c0aO0OTAV537zLtwknEcCu7K39i1BP8sta1QlRuwLQbq3 xQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34p72esd8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 03:07:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AC30Fur029921;
        Thu, 12 Nov 2020 03:07:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34rtkr2tw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 03:07:16 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AC37EmR031945;
        Thu, 12 Nov 2020 03:07:14 GMT
Received: from [192.168.1.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Nov 2020 19:07:14 -0800
Subject: Re: [PATCH] btrfs: hold device_list_mutex while accessing a
 btrfs_device's members
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <3a6553bc8e7b4ea56f1ed0f1a3160fc1f7209df6.1605109916.git.johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <29aebf1e-4684-4003-44b4-c5e8846b69eb@oracle.com>
Date:   Thu, 12 Nov 2020 11:07:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <3a6553bc8e7b4ea56f1ed0f1a3160fc1f7209df6.1605109916.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9802 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=2 bulkscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120017
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9802 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=2 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120017
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/11/20 11:52 pm, Johannes Thumshirn wrote:
> A struct btrfs_device's lifetime in device_list_add() is protected by the
> device_list_mutex. So don't drop the device_list_mutex when printing a
> duplicate device warning in device_list_add.
> 

The only other thread which can free the %device is the userland
initiated forget command. But both this (scan) and the forget threads
are under %uuid_mutex. So %device is protected from freeing.

Did we see any bug reproduced due to this?

Thanks.
