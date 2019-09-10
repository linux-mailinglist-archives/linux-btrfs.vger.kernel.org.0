Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1438AE61C
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 10:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfIJI5O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 04:57:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59084 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfIJI5O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 04:57:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8A8sKSZ062681;
        Tue, 10 Sep 2019 08:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=8KjXdwqdVGc4553HYgNYMiNwAS5iZ6VyLJvmwznxr2M=;
 b=ID3PZjmpEQvJPsd4xO2ElWTJlgaOHgI2ZP8LtRAP4dDyAhDFZHaayRrP8mBm9R6+sqgK
 8DirxGs/J71qc+jAmFqQHaWJTOiqaRApy81cnEB/7jPenolDuoUQ4yEitaWF7vQkn5Pu
 /HF/gLcIws4oHFeIxxLreBx4voaEQdhLJuXA7+rm/OsyJvJbuEKkxO00Z/qOuPOSaZCR
 8EvFgr2RvmujpngCxiCsz9Ga1X3VIgVnZ8YEBI+XZsTAdrwuWNvmJvFvFrjON8sYL8Se
 hDJxlDqH6JqvLSpEY3hrnac25GLE7Ve14GVq4YjJ0L3LuOiA7VpPX7mb/p/dfJIl9Fb9 yw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2uw1jk9w5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 08:57:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8A8sEmQ066364;
        Tue, 10 Sep 2019 08:57:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2uwq9pmu2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 08:57:09 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8A8v8J2013476;
        Tue, 10 Sep 2019 08:57:08 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Sep 2019 01:57:08 -0700
Subject: Re: [PATCH 0/2] fix BUG_ON and retun real error in find_next_devid()
 and clone_fs_devices()
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20190827074045.5563-1-anand.jain@oracle.com>
 <20190827132558.GI2752@twin.jikos.cz>
 <031925e7-65a0-0345-8b46-b2e778f50edb@oracle.com>
Message-ID: <981c8121-d639-5bcc-59da-f97e54adee0e@oracle.com>
Date:   Tue, 10 Sep 2019 16:57:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <031925e7-65a0-0345-8b46-b2e778f50edb@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909100090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909100090
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/8/19 7:12 AM, Anand Jain wrote:
> On 27/8/19 9:25 PM, David Sterba wrote:
>> On Tue, Aug 27, 2019 at 03:40:43PM +0800, Anand Jain wrote:
>>> Fixes BUG_ON in find_next_devid() and fixes to return real error in
>>> clone_fs_devices(). These two patches can be send to be independent.
>>>
>>> Anand Jain (2):
>>>    btrfs: fix BUG_ON with proper error handle in find_next_devid
>>>    btrfs: fix error return on alloc fail in clone_fs_devices
>>
>> Added to misc-next, thanks. 
> 
> 
> 
>> If you have script that can reproduce the
>> problem, please add them to the changelog. I've added more from the
>> discussion and questions from Qu.
>>
> 
>   The script and output rather makes senses in the patch [1] it doesn't 
> here.
>    [1] [PATCH v2] btrfs: tree-checker: Fix wrong check on max devid

David,

  The script does not make sense in this patch. I still see it in misc-next.

Thanks, Anand
