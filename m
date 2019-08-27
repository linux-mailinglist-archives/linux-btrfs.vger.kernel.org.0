Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8779F6B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 01:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfH0XNH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 19:13:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41456 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfH0XNH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 19:13:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7RN5Xiw150017;
        Tue, 27 Aug 2019 23:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=W+G1w6kNX/fNTLC27/fGpiAI4srOpi4ziwJ5s1I7HXI=;
 b=gMi7rvJouVY3PhtLwy+m14fb/Pm9ThAFxlbmg11k0uYGtArnJj/XB/kT3AxiXcO4hOpx
 DVjOrDLI9Uxo9ox/b+Tjw1UOnr/3SFtRTsdO6oXw1tTNheWd35hpDyfj+vsIcKf6WDmp
 uO2EjpcClErjYib6YN4Nc+2kCps9r0NDEiuYGg06qyOh4mBxLbtnkiT8RoR6ssGwINUi
 B5NesZOw8HU896U6LTSzjx+VutUO5JkKj8WkrZZXKLDU5fcLSAWdL6CiBBHkQSKkfNPC
 Yzzr1xfnDiuiAhDUH0fbREJGOnQlx58v+ysnweiZyI6QsJ4PWlZBmQ8z2OrgkjKyUpYu Mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2undvj80ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 23:13:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7RN317S011089;
        Tue, 27 Aug 2019 23:13:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2un5rk5n7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 23:13:03 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7RND1X4019367;
        Tue, 27 Aug 2019 23:13:02 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Aug 2019 16:13:01 -0700
Subject: Re: [PATCH 0/2] fix BUG_ON and retun real error in find_next_devid()
 and clone_fs_devices()
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20190827074045.5563-1-anand.jain@oracle.com>
 <20190827132558.GI2752@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <031925e7-65a0-0345-8b46-b2e778f50edb@oracle.com>
Date:   Wed, 28 Aug 2019 07:12:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190827132558.GI2752@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270219
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908270219
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/8/19 9:25 PM, David Sterba wrote:
> On Tue, Aug 27, 2019 at 03:40:43PM +0800, Anand Jain wrote:
>> Fixes BUG_ON in find_next_devid() and fixes to return real error in
>> clone_fs_devices(). These two patches can be send to be independent.
>>
>> Anand Jain (2):
>>    btrfs: fix BUG_ON with proper error handle in find_next_devid
>>    btrfs: fix error return on alloc fail in clone_fs_devices
> 
> Added to misc-next, thanks. 



> If you have script that can reproduce the
> problem, please add them to the changelog. I've added more from the
> discussion and questions from Qu.
> 

  The script and output rather makes senses in the patch [1] it doesn't 
here.
   [1] [PATCH v2] btrfs: tree-checker: Fix wrong check on max devid

Thanks, Anand
