Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 640C4C86B1
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 12:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfJBKtx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 06:49:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50964 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfJBKtx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Oct 2019 06:49:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x92An9pr062967;
        Wed, 2 Oct 2019 10:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Jwul1mUQAULPFBFF5V08J6BO2YXXYLH6DvrSr8hAaxE=;
 b=CxzeLXnLeW/Taid1PdEhl696gE89030JMtZgLm/BARJ+gSp5afgUAdnSnF6jknFDhfRM
 /09xzzf1VOIlCtD1GeY2M+uUAjidMshqtrDurcAjkAvARVhxGekPgpMk+0TUZgPDkrbj
 L7pmrG2spP8PsXVJQw96A7xBZ+5+iarJRv0f9DJHRwcEPh5hdGb1hn1gqU7JJRxSf8R/
 Kluw4kvkswV4DPlgUJdBrOhyYbu4aucFl5dkS7KxjZ7v2JGEmPk93jhNPAkgL7JqDUq4
 1+zu1Vzi3TUG0eVvsktqRgEdlhDrqTPUnQaU/Fy1HiD1YczoURVAyOV8ZG2RGImDIwRm YQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2v9yfqc5bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 10:49:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x92Amctd166225;
        Wed, 2 Oct 2019 10:49:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vcg612qyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 10:49:47 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x92Ank8h008477;
        Wed, 2 Oct 2019 10:49:46 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Oct 2019 03:49:46 -0700
Subject: Re: [PATCH] btrfs: add device scanned-by process name in the scan
 message
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <1570012248-16099-1-git-send-email-anand.jain@oracle.com>
 <1e84a4cb-1c50-9dbb-99ee-a50632a8f0ff@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c0adf2fd-49b5-4482-4ddc-1709c23c51ac@oracle.com>
Date:   Wed, 2 Oct 2019 18:49:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1e84a4cb-1c50-9dbb-99ee-a50632a8f0ff@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910020102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910020102
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/2/19 6:39 PM, Nikolay Borisov wrote:
> 
> 
> On 2.10.19 г. 13:30 ч., Anand Jain wrote:
>> Its very helpful if we had logged the device scanner process name
>> to debug the race condition between the systemd-udevd scan and the
>> user initiated device forget command.
>>
>> This patch adds scanned-by process name to the scan message.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Same effect can be achieved (for debugging purposes) if you have used
> ftrace on device_list_add without needing to patch the kernel.
>
> I'm somewhat indifferent whether this will be merged or not but I
> personally don't see much value in it.

  Its always good to provide a completely cooked log messages.
  Half cooked ideas or the log messages leads to more questions
  than answers.

Thanks, Anand
