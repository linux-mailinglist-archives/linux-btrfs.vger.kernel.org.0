Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 561212C6F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2019 14:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfE1MsS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 May 2019 08:48:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40148 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfE1MsS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 May 2019 08:48:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SCSWKc128566;
        Tue, 28 May 2019 12:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=lQxRQ8ea1bBsF9wbaPF4L2Obtr2LJctJ4CwVDolluXk=;
 b=Ag3nViiZFkX//EtMvtzPfTjH+azFo12H6ElyNYD83RMdXIUXRyR5gbh8Irf7R+cSCB1i
 oPQ3ku6VfIX+sHc2vh0/qgPE9csHPViK67Tzex9xP+R8Mk+MP62196h5L70nz69hhPL+
 mL7aK7HNNL+hRDYY6eAqOuawXmQWRG0gTGkLKHz0ffTypd3ZVylSp4EOHbODDGuZrZlN
 FCOhm5PH9txHItJlC78OT7JJwh2CZIfn8Ld3e8C08oMGWw9nS4jIh9vpBdfJ4LJuKIzh
 vmeOO4/DZQvjNpa8cq1uypsTEUDt61wLSQFeOzTclcyXMJPa1Jup3OqGVY7s6LwtmkDv Dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2spxbq2r24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 12:48:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SClJXv040872;
        Tue, 28 May 2019 12:48:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ss1fmuahs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 12:48:14 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4SCmD4Y020663;
        Tue, 28 May 2019 12:48:13 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 05:48:13 -0700
Subject: Re: [PATCH 2/2] btrfs-progs: scan: pass blkid_get_cache error code
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <1553838594-26013-1-git-send-email-anand.jain@oracle.com>
 <1553838594-26013-2-git-send-email-anand.jain@oracle.com>
 <20190515142911.GT3138@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <08dd7747-6af6-f820-419c-a0dc116b5688@oracle.com>
Date:   Tue, 28 May 2019 20:48:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190515142911.GT3138@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=775
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=792 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280082
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/5/19 10:29 PM, David Sterba wrote:
> On Fri, Mar 29, 2019 at 01:49:54PM +0800, Anand Jain wrote:
>> blkid_get_cache() returns error code which is -errno. So we can use them
>> directly.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> Ref:
>> blkid_get_cache() code:
>> https://github.com/karelzak/util-linux/blob/master/libblkid/src/cache.c#L93
>> https://github.com/karelzak/util-linux/blob/master/libblkid/src/blkidP.h#L307
> 
> This is internal header of blkid and incidentally the error numbers
> match errnos, but I don't think we should rely on that. Does blkid have
> a function that translates the code to string, similar to strerror?
> 

Uh. No there isn't BLKID_ERR.. to string conversion.


