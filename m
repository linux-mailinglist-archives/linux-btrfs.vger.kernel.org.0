Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5AAE57AE
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Oct 2019 03:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfJZBCF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 21:02:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48988 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfJZBCE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 21:02:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9Q0x6Jr143996;
        Sat, 26 Oct 2019 01:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=aciyQ0vpZkDr4oH9JLyqnDa3YkhKfEnIj9GZWzc52yo=;
 b=bAzE9q2NnTpU0/rXuTto9sIHqMr7EtKwG9wsKze8EHNX0Lez7fOl/HHZVsGxKYyCWNaS
 VPov5wbalmLGTAbD+a9iCI0wYc8vo13UuLWIBbHA3G+rcAfdLMCE6lF0GMv9wP11nc4P
 mS4ysBixM/S+3qkfm5xFVG9jjIVwpAzOdKq+y3zDV9fPmmKIHpk/oopC21tewZDIJLgs
 bDiTVHoiaR4qyVa9mAF3tZl22sdK0IKSb3nmTQjJJN1gj5qr1xYY1uwylpFG2/nVUNSr
 7sEzVBod7vMfv6fr0DcHDTo7JZV7yF6zqhJvCWwVDVZVYZxSdvKqpY8Ss9rC2+rirotZ xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vqswu6ewn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Oct 2019 01:02:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9Q0w1BB013342;
        Sat, 26 Oct 2019 01:01:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vunbngke8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Oct 2019 01:01:59 +0000
Received: from abhmp0021.oracle.com (abhmp0021.oracle.com [141.146.116.27])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9Q11v3b022123;
        Sat, 26 Oct 2019 01:01:58 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 26 Oct 2019 01:01:57 +0000
Subject: Re: [RFC PATCH 0/3] btrfs-progs: make quiet to overrule verbose
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20191024062825.13097-1-anand.jain@oracle.com>
 <20191024154151.GI3001@twin.jikos.cz>
 <1166a5c7-8bc9-b93f-6f4c-8871b5fc394b@oracle.com>
 <7b97f0ce-1f62-09fa-ad86-6a4d0af40e1d@oracle.com>
 <20191025163555.GP3001@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <79a8fa97-6aff-3698-2263-548fbb68baf0@oracle.com>
Date:   Sat, 26 Oct 2019 09:01:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191025163555.GP3001@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9421 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910260009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9421 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910260009
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/10/19 12:35 AM, David Sterba wrote:
> On Fri, Oct 25, 2019 at 09:56:14AM +0800, Anand Jain wrote:
>> On 25/10/19 7:51 AM, Anand Jain wrote:
>>>
>>>
>>> On 24/10/19 11:41 PM, David Sterba wrote:
>>>> On Thu, Oct 24, 2019 at 02:28:22PM +0800, Anand Jain wrote:
>>>>> When both the options (--quiet and --verbose) in btrfs send and receive
>>>>> is specified, we need at least one of it to overrule the other,
>>>>> irrespective
>>>>> of the chronological order of options.
>>>>
>>>> I think the common behaviour is to respect the order of appearance on
>>>> the commandline.
>>>
>>>     I am fine with this. Will fix it as this.
>>
>>    Question: command -v -q -v should be equal to command -v, right?
> 
> No, that would be equivalent to the default level:
> 
> verbose starts with 1			()
> verbose++				(-v)
> verbose = 0				(-q)
> verbose++ is now 1, which is not -v	()
> 

Oh I was thinking its a bug, and no need to carry forward to the global
verbose. Will make it look like this.

