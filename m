Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4C7BDF8CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 01:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfJUXtT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 19:49:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57196 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbfJUXtT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 19:49:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9LNnDWN123143;
        Mon, 21 Oct 2019 23:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=4a11XYGIcnyJm4eh/d5oNpO0KGwG3bAvlYwfqokVjc0=;
 b=FKAkqMydQa/BFiEWJ20d2vrNraUVr4CLff1AvZtu91CEpGd9M7aUlrZplpkUbx7PITIc
 VrBz5D3KYK+3hq+FL2HGBqXaprez7pjf5c6d4BhaG4/5+QCtcNw5NmCgB7yzHAZTSH1v
 CuUVF+/fw48NlfiY9FsCQlbW6h01TveR/yAw4dBsee73zXTE2AVNTZOVgEL4rBhLUK7i
 1DuIdCVQ7JI+VbkdgSlq5AA6Vrk7ECPkZIqEqZO0bs5RaFi1LFT5/ksogTQyPe6dsKAK
 kTvEvbJUMJQ0X/jzShb18Ueo6fidNJEPOy71R6JG/GveMzZI5ObeXcBLKC6FD5vyiq4a Bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vqu4qjua0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Oct 2019 23:49:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9LNnBh5127914;
        Mon, 21 Oct 2019 23:49:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vrcnb6d6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Oct 2019 23:49:12 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9LNmouL014615;
        Mon, 21 Oct 2019 23:48:51 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 16:48:50 -0700
Subject: Re: [PATCH v3] btrfs-progs: add verbose option to btrfs device scan
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <1569989512-5594-1-git-send-email-anand.jain@oracle.com>
 <20191007174129.GK2751@twin.jikos.cz>
 <a9c0a957-e151-32e8-a42e-b5c6d817ed78@oracle.com>
 <20191014152457.GQ2751@twin.jikos.cz>
 <365faddf-cf4f-2a03-820d-d4f5071240e8@oracle.com>
 <20191021134346.GL3001@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <17f53bd1-10bf-9415-10dd-2724c48f5bea@oracle.com>
Date:   Tue, 22 Oct 2019 07:48:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191021134346.GL3001@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910210226
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910210226
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/21/19 9:43 PM, David Sterba wrote:
> On Tue, Oct 15, 2019 at 11:29:34AM +0800, Anand Jain wrote:
>>    I was thinking there might be some common code between the
>>    sub-commands in btrfs-progs now or in future, and if the printf()
>>    due to verbose is required in one sub-command and the same printf()
>>    due to verbose is not required in another sub-command (which I
>>    called unwanted message) then we won't have any choice to not
>>    to print those unwanted printf().
>>    But as this is just an anticipatory only, so probably we could try
>>    global verbose and see how it fares. I will try.
> 
> I see, but it would be better to have a concrete example where it's
> problematic so we can figure out ways how to filter unwanted messages.
> 

I solved with an argument to btrfs_scan_devcies() [1], by adding
%verbose argument to btrfs_scan_devices() to make sure
only btrfs dev scan would print the verbose and not the btrfs fi show.
If btrfs fi show prints the verbose it shall break few test-cases
in fstests.

[1]
https://patchwork.kernel.org/patch/11201791/
https://patchwork.kernel.org/patch/11201793/
