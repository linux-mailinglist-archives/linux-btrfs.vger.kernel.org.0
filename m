Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3A651963DE
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Mar 2020 06:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgC1FqO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Mar 2020 01:46:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57092 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgC1FqO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Mar 2020 01:46:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02S5iSpK123936;
        Sat, 28 Mar 2020 05:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=owcrWsc9PmMSRGpKswKpZ3Z79pzuJ/8tCL4DxvoFuMY=;
 b=YV/iE4hHOyFpJeD8C5WqNxw03eoeGJkgRu6OIBjIrPdA2tIiGMVtsbf8cz5VcN6V2+TS
 IDiqI3S8gM72+WzKPzxuZSx094y4YbbB6IaKCheuRbiKP8BYogvCO9cdXRJJfAWJ+kuV
 7ugIuftehvjI7S4d5IVo//rZIjuNdh1fIysM5dYPWJs6aUXYNypKU5MKFLoyupv1raQh
 CIeCDInxx9f3fLyl2FU579ccXpjabq2CwSpQ7C4UU1vb6d6isf+GMZybQQUK5XOz9Oy8
 ambhsBDgPJSwpOtI7brpfZshjAtpdS5EOF3h2kcp7sxtU+6xfKLIMKPPmRuz6LjPA1fr JQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 301xhkg548-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Mar 2020 05:46:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02S5jLRP110542;
        Sat, 28 Mar 2020 05:46:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 301xd09u48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Mar 2020 05:46:08 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02S5k7s1016774;
        Sat, 28 Mar 2020 05:46:07 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Mar 2020 22:46:07 -0700
Subject: Re: [PATCH v2 00/16] btrfs-progs: global verbose and quiet option
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
 <8a2bac99-5c07-2aa9-fe3b-e09f2ad16213@oracle.com>
 <20200114114047.GC3929@suse.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <d38e842d-e2a7-5d27-3157-72532c3526b4@oracle.com>
Date:   Sat, 28 Mar 2020 13:45:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200114114047.GC3929@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9573 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003280051
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9573 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003280051
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/1/20 7:40 PM, David Sterba wrote:
> On Tue, Jan 14, 2020 at 02:14:24PM +0800, Anand Jain wrote:
>>    I wonder if could this be integrated?
> 
> Yes, when I get to it through the pile of other patches.
> 

  Can this get into the upcoming release.

Thanks, Anand
