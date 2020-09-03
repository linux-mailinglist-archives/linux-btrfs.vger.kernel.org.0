Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEF025C4BB
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 17:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgICPQb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 11:16:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55078 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgICLfu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 07:35:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 083BZOQU067699;
        Thu, 3 Sep 2020 11:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=1cP6vXo2RbRVWFEKYeAJ3TZ7AulIFBiIq/5dPTAYpZo=;
 b=OaD3kQgB//LdK+OcPWm/izyDlrjdV5MVjh4Ym3HGZPM/QlO6T+7M4wbOMKSNk4TMBeVr
 Bqv8deLAVyblxQMT5fuipBFpCV/WdxQ8Lge9mQ+DFIkJOh3DIC5L7I+bj2LzTPHj0dMP
 zd9fo5VWk+r6jLGci5RYICxQccM9XfoytLvmy4IKFkNgt72SniAA5i8q01QwJ8+6jUq9
 Fuz/P4DA89RagzPLf55+r4zh6iy2LSup19ZeRF993iVAZvPAXfKESWOSks4mCDLKSVn8
 o/CsbODXIvEEfo/LPgLGjN839YLEhYVkLrUhTAjQARS1PCwmqH/Xisc0ChF9c49h0gg/ uA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 337eer8751-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Sep 2020 11:35:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 083BZP4p027695;
        Thu, 3 Sep 2020 11:35:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 3380krmed7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Sep 2020 11:35:43 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 083BZhnD011101;
        Thu, 3 Sep 2020 11:35:43 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Sep 2020 04:35:43 -0700
Subject: Re: [PATCH 06/15] btrfs: initialize sysfs devid and device link for
 seed device
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1599091832.git.anand.jain@oracle.com>
 <0b11ff81143ebfcaa1da26296ee12afcfe41dbb5.1599091832.git.anand.jain@oracle.com>
 <053e3d03-a457-eaf0-2523-551ecfb2faad@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <43e80a90-7294-2f4e-fa88-309c7a9410a8@oracle.com>
Date:   Thu, 3 Sep 2020 19:35:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <053e3d03-a457-eaf0-2523-551ecfb2faad@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030108
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/9/20 5:06 pm, Nikolay Borisov wrote:
> 
> 
> On 3.09.20 г. 3:57 ч., Anand Jain wrote:
>> The following test case leads to null kobject-being-freed error.
>>
>>   mount seed /mnt
>>   add sprout to /mnt
>>   umount /mnt
>>   mount sprout to /mnt
>>   delete seed
> 
> This patch warrants an fstests alongside it!

  I have been using one which I forgot to send. Now done.

Thanks, Anand
