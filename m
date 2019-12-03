Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B29910F485
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 02:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfLCBau (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 20:30:50 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38198 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfLCBau (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 20:30:50 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB31TSLw033678;
        Tue, 3 Dec 2019 01:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=kYpZsmJNXxvJfPlBe4wpFGyhVCrfHOUpOct2VpMBqTs=;
 b=WC6j2H/ZUWkBSnHIhHrnpyFgfU4PJxQHL4ppWQ1bWWgxB105GxANOGH/GPx9mD7FIY6f
 CVJlLGDL2KA+40dpQjkEQVyxa+QxiA43uwfC3BsZIOmle076T9UqvD7YwH0GYDtLzdaR
 uuHk4dkwqqwEfzbk2Wx/KsBjthF2iY3PIokeXo2GTaRPdlCJ73pbd0iso4tUMTdkygti
 cbNdvJf49vh4sFYZf7SVIe+ZKYTm9SSJJ2NqN90mzfimheCwIlD2WNZ/eKGMSbDYNnYZ
 vtB8PvK/6CBdB5WrgtcUKZyVtl997jl7fLptk5wZ6IxqpN6lxay83Aap68e2aqv/QphE CQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wkgcq402r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 01:30:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB31NmUm127463;
        Tue, 3 Dec 2019 01:30:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wn4qnr6e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 01:30:40 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB31UZ7B007854;
        Tue, 3 Dec 2019 01:30:35 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Dec 2019 17:30:35 -0800
Subject: Re: BTRFS subvolume RAID level
To:     waxhead@dirtcellar.net, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <494b0df1-2aab-5169-836d-e381498f64db@dirtcellar.net>
 <ed65c577-3971-8c4f-c690-83e85dd8188e@oracle.com>
 <fcbe2d91-a6ad-5b9b-fa66-aebb2edd14f1@dirtcellar.net>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <422a04ba-2e63-f951-7097-19ecc7a88c53@oracle.com>
Date:   Tue, 3 Dec 2019 09:30:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fcbe2d91-a6ad-5b9b-fa66-aebb2edd14f1@dirtcellar.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912030011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912030012
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12/3/19 7:27 AM, waxhead wrote:
> 
> 
> Anand Jain wrote:
>>
>>> I imagine that RAIDc4 for example could potentially give a grotesque 
>>> speed increase for parallel read operations once BTRFS learns to 
>>> distribute reads to the device with the least waitqueue / fastest 
>>> devices.
>>
>>   That exactly was the objective of the Readmirror patch in the ML.
>>   It proposed a framework to change the readmirror policy as needed.
>>
>> Thanks, Anand
> 
> Indeed. If I remember correctly your patch allowed for deterministic 
> reading from certain devices.
  It provides a framework to configure the readmirror policies. And the
  policies can be based on io-depth, pid, or manual for heterogeneous
  devices with different latency.

> As just a regular btrfs user the problem I 
> see with this is that you loose a "potential free scrub" that *might* 
> otherwise happen from often read data. On the other hand that is what 
> manual scrubbing is for anyway.

  Ha ha.

  When it comes to data and its reliability and availability we need
  guarantee and only deterministic approach can provide it.

  What you are asking for is to route the particular block to
  the device which was not read before so to avoid scrubbing or to
  make scrubbing more intelligent to scrub only old never read blocks
  - this will be challenging we need to keep history of block and the
  device it used for read - most likely a scope for the bpf based
  external tools but definitely not with in kernel. With in kernel
  we can create readmirror like framework so that external tool can
  achieve it.


Thanks, Anand
