Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0398210F45F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 02:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfLCBJQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 20:09:16 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48318 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfLCBJQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 20:09:16 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB319Dfj018537;
        Tue, 3 Dec 2019 01:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=X2t7Pls+qjsu7cx3oWYbrRFxKDnSdDKNAGMjyUPHhEU=;
 b=nOChwqzyhHnmNje5eX0aI7WQIxT5P9Mc0o0+hu3Dye8l+pJD/AaH0cdL1Kyexjx88BBR
 wxbx7c/kOLuyQo+myZEcqSqQLJI/zZlsu4LiQ5F1kH5MVcjpy5MkGV4bnC1SmYnW0RQ3
 f3OxbVNLJ+iMvtGQCRxx5kcc9Ohrn8h1k3Up+SYwf7lu1E52XO22ZDrQr68ViGGHzJ7H
 4dWRZQnupvupT95DltGJp04D9DK0dcTXDNwuFMx0GOQ5vIyCV5qEl9ySTki8Slj/rQQr
 aFG3WC1DQG0/c97g0szFKvTo4Qj04wflX5h0S0y1Nw1eIpg/Ok++TeUtLRNMTkXC+ysp wA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wkgcq3w5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 01:09:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB314LIW155530;
        Tue, 3 Dec 2019 01:09:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2wn8k1e07k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 01:09:13 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB319C3h005351;
        Tue, 3 Dec 2019 01:09:12 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Dec 2019 17:09:12 -0800
Subject: Re: [PATCH 0/6] btrfs-progs: add support for LOGICAL_INO_V2 features
 in logical-resolve
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20191127035509.15011-1-ce3g8jdj@umail.furryterror.org>
 <3d8298c5-bab4-67f5-2bf7-8156865d949f@oracle.com>
 <20191202184203.GH1046@hungrycats.org>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <d885b9d7-8d6e-ba40-3e70-d5ffa97afaef@oracle.com>
Date:   Tue, 3 Dec 2019 09:08:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191202184203.GH1046@hungrycats.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912030008
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912030009
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12/3/19 2:42 AM, Zygo Blaxell wrote:
> On Mon, Dec 02, 2019 at 07:02:26PM +0800, Anand Jain wrote:
>> On 27/11/19 11:55 AM, Zygo Blaxell wrote:
>>> This patch set adds support for LOGICAL_INO_V2 features:
>>>
>>>           - bigger buffer size (16M instead of 64K, default also increased to 64K)
>>>
>>>           - IGNORE_OFFSETS flag to look up references by extent instead of block
>>>
>>> If the V2 options are used, it calls the V2 ioctl; otherwise, it calls
>>> the V1 ioctl for old kernel compatibility.
>>>
>>>
>>
>> For the whole series.
>>
>> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>>
>> (Nit: This should be v4 as this patch was submitted before:
>>
>> https://lore.kernel.org/linux-btrfs/20170922175847.6071-1-ce3g8jdj@umail.furryterror.org/T/#t
> 
> Nit^2:  That was the kernel patch, this is a btrfs-progs patch to use
> the kernel feature.
> 
> I'm assuming kernel and userspace patches get different version
> numbering...?

  Ah. After I commented on the kernel patch at the above link,
  I remember seeing the progs patches which I can't find now.
  And I got confused with the kernel patch. Ok this isn't v4.

Thanks, Anand

>>
>>
