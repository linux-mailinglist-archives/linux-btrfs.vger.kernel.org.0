Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52E5EF870D
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 04:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKLDOj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 22:14:39 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40096 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfKLDOi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 22:14:38 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAC39LSq078094;
        Tue, 12 Nov 2019 03:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=UTbj9nCnbDQ9XFfUZf0QpPzkozHDVf7BjKA4nNAEIGU=;
 b=LJCo3cfITk98gcxbL21cCKAZxH9b14BA/z3xYXVlBgoKPpkbVsBl2D0LJtGDWqJmbRJ4
 P+Dvs1217q+w0rc4nQECT2BQNW1uF4X6gwcSu9cmYC0lKUUUEjZvFYHhzUT276wE9Uma
 PdWpAc3niLapq8DYUrNu0X9z9OA66ThyFRMaFwDGP6qjon2IoRYztYxolmhHyPuKpkW/
 7UeKYvGWWkMcSGDu63DAytBT3RvOWU5dZfgweRyQRS/F26ZgDAkaAA6Esog6w189G6qP
 KLwWQuuxq6Mhv95MqGA+Pd+2zmZAOB2J/klRh7/qWZqql+bC/T1anpgHIDQQyNrjr8kB ng== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2w5ndq20gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 03:13:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAC39btj195425;
        Tue, 12 Nov 2019 03:11:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2w6r8kfjkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 03:11:09 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAC3B6rX013345;
        Tue, 12 Nov 2019 03:11:07 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Nov 2019 19:11:06 -0800
Subject: Re: [PATCH] btrfs: mkfs: Make no-holes as default mkfs incompat
 features
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191111065004.24705-1-wqu@suse.com>
 <20191111180256.GR3001@twin.jikos.cz>
 <aa6d036e-bac9-1756-51b7-12167bd949ac@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <d0ea9e14-cd33-9da3-9a6c-d625c13b7e2b@oracle.com>
Date:   Tue, 12 Nov 2019 11:10:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <aa6d036e-bac9-1756-51b7-12167bd949ac@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9438 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911120025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9438 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911120025
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/11/19 9:01 AM, Qu Wenruo wrote:
> 
> 
> On 2019/11/12 上午2:02, David Sterba wrote:
>> On Mon, Nov 11, 2019 at 02:50:04PM +0800, Qu Wenruo wrote:
>>> No-holes feature could save 53 bytes for each hole we have, and it
>>> provides a pretty good workaround to prevent btrfs check from reporting
>>> non-contiguous file extent holes for mixed direct/buffered IO.
>>>
>>> The latter feature is more helpful for developers for handle log-writes
>>> based test cases.
>>
>> Thanks. The plan to make no-holes default has been there for some time
>> already. What it needs is a full round of testing and validation before
>> making it default. And as defaults change rarely, I'd like to add
>> free-space-tree as mkfs default as well, there's enough demand for that
>> and we want to start deprecating v1 in the future.
>>
>> I have in my near-top todo list to do that, with the following
>> checklist:
>>
>> - run fstests with various features together + the new default
>>    - release build
>>    - debugging build with UBSAN, KASAN and additional useful debugging
>>      tools
> Already running with no_holes for several previous releases.
> 
> Not to mention new btrfs specific log-writes test cases are all already
> using this feature  to avoid btrfs check failure.
> 
> So I think this part should be OK.
> 
>> - run stress tests + the new feature
> 
> Any extra suggestions for the stress test tool?
> 
> Despite that, extra 24x7 host may be needed for this test.
> 

   To keep the ball rolling I can run stress tests part here,
   yep need extra suggestions on the stress test tools.

Thanks, Anand

>> - check that the documentation covers the change
>>    - mkfs.btrfs help string
>>    - manual page of mkfs.btrfs: benefits, pros/cons, conversion to/from
>>      the feature (if applicable), with example commands (if applicable)
>>    - wiki documentation update
> 
> Forgot this part.
> I'll add this info in next update.
> 
> Thanks,
> Qu
>> - verify that all commonly used tools work with it (image, check, tune)
>>
>> For free-space-tree specifically, there's
>> https://github.com/kdave/drafts/blob/master/btrfs/progs-fst-default.txt
>>
>> I don't have objections to the patch, that's the easy part. The above is
>> non-coding work and is namely making sure that the usecase and usability
>> is good, or with known documented quirks.
>>
>> Making it default in progs release 5.4 is IMO doable, there are probably
>> 2-3 weeks before the release, but this task needs one or more persons
>> willing to do the above.
>>
> 

