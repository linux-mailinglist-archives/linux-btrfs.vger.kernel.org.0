Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9C71EF4EC
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jun 2020 12:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgFEKEL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jun 2020 06:04:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47066 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgFEKEK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jun 2020 06:04:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0559wGmb065285;
        Fri, 5 Jun 2020 10:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=gm7PwiKrtBsF1SnDZTy22GCvD0tLElb1Aior99aXyiI=;
 b=uFufchX367+HvzkXWpOIwOuCfhDtRdC0tzQ7dcHJMBVFHvMzAPtY5qRwy6I8OjnURqXg
 SYh72KKojD9QqSCe1iYXNwMWcWDtV2goV2UTWKwsd+TfC5KA3wlIraSeFOHInZxvF2Jz
 tQ95w4BYbvZGPo0jChzdg4QNm3A+sqHLkG7lL7t+BlZVCoFQQDIDboMDkgJYXou9zc4P
 2kZ23YXlXE/a1fqv1H8cb7i9C2KNcJTpDwYcub4b4rL2DV0mIIYBrTsyTpccvAMb7lF1
 ZTgw1Lv4NdVdUtc6U6/JxK5AF8037MVlwuS5oLGS6M2t3UoSIduTW5PbQUa/TSCWP8/k Kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31f92624d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 05 Jun 2020 10:04:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055A3Qku152873;
        Fri, 5 Jun 2020 10:04:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31f92shung-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jun 2020 10:04:06 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 055A46EN002777;
        Fri, 5 Jun 2020 10:04:06 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Jun 2020 03:04:05 -0700
Subject: Re: [PATCH v7 1/2] btrfs: Introduce "rescue=" mount option
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200604071807.61345-1-wqu@suse.com>
 <20200604071807.61345-2-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <3659322f-0687-d179-ff89-f3a303fe2379@oracle.com>
Date:   Fri, 5 Jun 2020 18:04:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604071807.61345-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 cotscore=-2147483648 bulkscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050075
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/6/20 3:18 pm, Qu Wenruo wrote:
> This patch introduces a new "rescue=" mount option group for all those
> mount options for data recovery.
> 
> Different rescue sub options are seperated by ':'. E.g
> "ro,rescue=nologreplay:usebackuproot".
> (The original plan is to use ';', but ';' needs to be escaped/quoted,
> or it will be interpreted by bash)

  I fell ':' isn't suitable here.

> And obviously, user can specify rescue options one by one like:
> "ro,rescue=nologreplay,rescue=usebackuproot"

  This should suffice right?

Thanks, Anand
