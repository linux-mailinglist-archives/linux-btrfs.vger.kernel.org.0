Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30187E414F
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 03:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389584AbfJYB4Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 21:56:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54876 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389488AbfJYB4Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 21:56:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9P1sKEq166658;
        Fri, 25 Oct 2019 01:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=th6c5YIzLx9aIOTU/eseqYH34/PfjR65tSCsS/9IBjw=;
 b=NODdzaj3uYe3Y5BXekEmZ/LToCyH1+O+f2DhpUEKrDVY2Es+y3AX7mF6ythoc8iBmh3U
 68D8OB1ZSzQ5LcVCNp8QZ/2w6DGff6wt9w0meiG+yxcROWVpLbbXQgPh17fkJas4GXMA
 YZnW+Fce2yle866ldA4pmfTZcfPzCFJICB2GPtMdKN/rmRjrfP2iejsgwMgHY0xlOj4z
 uwjDWa/rmrc2szOOliSZHC2KkVNWX4WUaA4vblPCJoBQH0sDF+KQw+DNXQYzLTqsOf4o
 l1xMKgiR6bfapUCaxubXMxohK75Prpv85HTWh3DnXC2isJ8zSyRk66A3pQXEunnffyh3 Gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vqswtyduq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 01:56:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9P1rRST082194;
        Fri, 25 Oct 2019 01:56:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vunbk7q8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 01:56:19 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9P1uIK9006855;
        Fri, 25 Oct 2019 01:56:18 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Oct 2019 18:56:18 -0700
Subject: Re: [RFC PATCH 0/3] btrfs-progs: make quiet to overrule verbose
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20191024062825.13097-1-anand.jain@oracle.com>
 <20191024154151.GI3001@twin.jikos.cz>
 <1166a5c7-8bc9-b93f-6f4c-8871b5fc394b@oracle.com>
Message-ID: <7b97f0ce-1f62-09fa-ad86-6a4d0af40e1d@oracle.com>
Date:   Fri, 25 Oct 2019 09:56:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1166a5c7-8bc9-b93f-6f4c-8871b5fc394b@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910250019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910250019
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/10/19 7:51 AM, Anand Jain wrote:
> 
> 
> On 24/10/19 11:41 PM, David Sterba wrote:
>> On Thu, Oct 24, 2019 at 02:28:22PM +0800, Anand Jain wrote:
>>> When both the options (--quiet and --verbose) in btrfs send and receive
>>> is specified, we need at least one of it to overrule the other, 
>>> irrespective
>>> of the chronological order of options.
>>
>> I think the common behaviour is to respect the order of appearance on
>> the commandline.
> 
>    I am fine with this. Will fix it as this.

  Question: command -v -q -v should be equal to command -v, right?

Thanks, Anand


>    (IMO generally command -q is used in scripts so it makes sense to keep
>    it absolutely quiet when used. Where as -v is used for
>    understanding.).
> 
>> So 'command -vvv -q' will be the same as 'command -q',
> 
>> while 'command -q -vvv' will be 'command -vvv'.
> 
>   We need to fix this. As of now command -q -vvv is command -vv.
> 
> Thanks, Anand
> 
>> Eg. ssh behaves like that, OTOH rsync does not and -q beats -vvv. I
>> don't know about other commands that accept multiple -v and -q to get
>> more samples. The usage pattern where order on command line matters is
>> following the idea where there's a long line and adding -vvv to the end
>> will make it verbose.
>>
> 
> 

