Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC9FAC9F85
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2019 15:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfJCNeQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Oct 2019 09:34:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39142 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730403AbfJCNeQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Oct 2019 09:34:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x93DXasN042164;
        Thu, 3 Oct 2019 13:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=4RMt4aue0ROkIOCxZljju0VtX4nkPm8Gh7jLMr6psK0=;
 b=riUoU+gjTKrV9YW142vnT+SpjLIoFJQiWiXyIpz33zQndGLO6pWcoeOsg5nCJdjVRUYh
 O4t/qZzY6EFr41v6cNm3IJgFJftE1Ep/Gj5TwvWJamEAHPQkLMqsA5PBBKp3dvuOiw7H
 +e6LPVb5y4MLbThuVOy6E0Tqfu2DHCHbR8aM7Y0bbg8IwWSnReKpjf5aJEbyDg9cCuxm
 /RfHuys79KUC4zBUGq9sMX9wPoS9v22FDS1Y1OeUI7R2VshyjsU496QWoLIAUfZNz5NC
 LtZjS+91F7pRDk+ovZAk8ay7gFNkp5YR3/ljEM9vxaA6HX0bLwJgi2crmHsMOl1iYVcv CA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2v9xxv45gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Oct 2019 13:34:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x93DXZS9177548;
        Thu, 3 Oct 2019 13:34:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vckyqsm3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Oct 2019 13:34:11 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x93DYAc9003437;
        Thu, 3 Oct 2019 13:34:11 GMT
Received: from [10.191.60.111] (/10.191.60.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Oct 2019 06:34:10 -0700
Subject: Re: [PATCH] btrfs: add device scanned-by process name in the scan
 message
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <1570012248-16099-1-git-send-email-anand.jain@oracle.com>
 <20191003132445.GU2751@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <1cb1de56-cae7-7311-42a1-3f139ecca12b@oracle.com>
Date:   Thu, 3 Oct 2019 21:33:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191003132445.GU2751@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910030128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910030128
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/10/19 9:24 PM, David Sterba wrote:
> On Wed, Oct 02, 2019 at 06:30:48PM +0800, Anand Jain wrote:
>> Its very helpful if we had logged the device scanner process name
>> to debug the race condition between the systemd-udevd scan and the
>> user initiated device forget command.
>>
>> This patch adds scanned-by process name to the scan message.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Added to misc-next with the updated message.
> 

oops I had v2 with pid.
sorry for the delay I got stuck with a debugging.

Sending it now.

Thanks, Anand
