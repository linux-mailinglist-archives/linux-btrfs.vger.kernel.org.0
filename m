Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECB6BC6E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 13:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504739AbfIXLca (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 07:32:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49486 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438702AbfIXLc3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 07:32:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8OBTU6b149662;
        Tue, 24 Sep 2019 11:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=shLXkQXUdP2LUEcos+5J3OhRSqdY2gklCM4hG/9ySmo=;
 b=ZlHa9gt0At1pLtuB0VDDwtUmVR7yFnMYmKj4SLsXwGzWnWSd2Gc27TMAF0OZonHmvKD9
 gDLJnpMxcOQw/0r3bq11uOTOqbAAzMu9Sf4+RWUODoEEUCnLLLksnNHGJ5ss4Wer8TyM
 G34zb4TkrInirS6TswNjWlpIeWWJkczAcf88RkUgjClKJkcWaA1AUwGgKCFHonNz5Y4A
 0xaSe6wipYhMyfuIhLD7Yu51NLSAd+3Kk/95Ru6mV41aoqfak8lIIZS8+JfqmnW8Jdjp
 r7ocNym0HElZyqmzXHGzjZ3TIJSMTllzJ0SPClyOxlhaKh29DprvsLpGxigYQus4wwt7 LA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2v5cgqwc3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 11:32:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8OBT151175522;
        Tue, 24 Sep 2019 11:32:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2v6yvq0uvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 11:32:03 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8OBW2LO032136;
        Tue, 24 Sep 2019 11:32:02 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Sep 2019 04:32:02 -0700
Subject: Re: [PATCH v2.1 00/10] btrfs-progs: image: Enhancement with new data
 dump feature
To:     WenRuo Qu <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20190704061103.20096-1-wqu@suse.com>
 <8e533879-f048-fd28-6d88-2222a4c8f019@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c96b0f9f-6bb1-6497-d260-26705bc664e7@oracle.com>
Date:   Tue, 24 Sep 2019 19:31:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8e533879-f048-fd28-6d88-2222a4c8f019@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=983
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909240117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909240117
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/19/19 3:19 PM, WenRuo Qu wrote:
> Gentle ping?
> 
> This feature should be pretty useful for both full fs backup and debug
> purpose.
> 
> Any feedback?

  Did you miss my review? There are bugs in the patch.

Thanks, Anand

> It can still be applied to latest stable branch without any conflict.
> 
> Thanks,
> Qu



