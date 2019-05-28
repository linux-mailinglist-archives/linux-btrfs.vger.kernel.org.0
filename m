Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E99382C6F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2019 14:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfE1Mrz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 May 2019 08:47:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45734 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfE1Mrz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 May 2019 08:47:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SCSt5X119228;
        Tue, 28 May 2019 12:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=SLuwRvhmDDc50zP/trC1yuerDhOunrf763y0hNa/i7E=;
 b=aPfUTWNmgRyCOqr7leeIvNJPhXVyNvsKwMZkLRV+5D/bJBPecdO2NoKzjoNpxll0mqxb
 B/edMYE7vXf3uycWzek1zJWZwBkLXilYqUPJW9cQmjx+QV3RDnsOCoBTp2rhKRD3GcsJ
 bvwLpJfBdf2gzfwaNz6BJkCz+l+Jn/5h/W7ZWs4i9Uke70C8o8vznvjQdJm2KleQzIzu
 wYfCDsoEXhc9Zev6gtbIxvkh2Zvp6CGuvEt2rH6DvNHN1mG9TPtzfGsQRw+c6Jk4h3LP
 dZ+Xc/nk2gL38oZZc6CNeuDpFWASmnjgG0upOTZqHqBvnenhcti+t/AQjaTRHDkkUyHv 9Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2spw4tau1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 12:47:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SClmQo090233;
        Tue, 28 May 2019 12:47:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2srbdws0x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 12:47:49 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4SClmpN023077;
        Tue, 28 May 2019 12:47:48 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 05:47:47 -0700
Subject: Re: [PATCH 1/2] btrfs-progs: scan: cleanup, return errno when we have
 one
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <1553838594-26013-1-git-send-email-anand.jain@oracle.com>
 <20190515142615.GS3138@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <d26a26fa-b065-a684-3cce-8924c9ad540d@oracle.com>
Date:   Tue, 28 May 2019 20:47:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190515142615.GS3138@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280082
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/5/19 10:26 PM, David Sterba wrote:
> On Fri, Mar 29, 2019 at 01:49:53PM +0800, Anand Jain wrote:
>> @@ -386,7 +386,9 @@ static int cmd_device_scan(int argc, char **argv)
>>   	}
>>   
>>   out:
>> -	return !!ret;
>> +	if (ret < 0)
>> +		return -ret;
>> +	return ret;
> 
> No, cmd_device_scan as the command handler returns the error code that's
> intepreted by shell. Most commands do just 0 and 1, in documented case
> there are other values, but we can't return errno here.
> 

Ok. errno is better error informative though. Interpreted by shell seems 
to be a roadblock.
