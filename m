Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E7425F66B
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Sep 2020 11:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgIGJ00 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Sep 2020 05:26:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37474 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgIGJ0Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Sep 2020 05:26:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0879OsG7030052;
        Mon, 7 Sep 2020 09:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=XcPXiR2VG/RsUv7LK7pnHMx3bhMsodD0OguMMQUMNOo=;
 b=tQcoR3qmafX+PuCJw3/Y8Pspjztop0fzvrj90JqBGD9mhDLyhec3hPw85vCEoFSgIWoF
 w9cdSZjCSF5nS7MyLFxDgC1YeKPDByjCde1pWnGr3LsLr2AHhIfdShV5aLbRw0tu+AeX
 /7nS9lvlKZ/v2DoVlfIt1Ja+gnvD2GQaa3sI+0DxJvz95y3Wj5+wJxWWAR1L9EH14ul0
 6C8obD8USAburmHUja0BSSxQMK8DiUN9dLKx42FWx8tX9llEP+AXDwdzN6Hmfy2p7CB7
 ECCooJccOtJl0JDQG9ZC7naS3kHkRJuOThSnaEPK7FlYpt9pf3kmH6usWW+loUbhw2ib fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33c2mknm93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 07 Sep 2020 09:26:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0879PCPl116924;
        Mon, 7 Sep 2020 09:26:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 33cmk04ryn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Sep 2020 09:26:22 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0879QL54011326;
        Mon, 7 Sep 2020 09:26:21 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Sep 2020 02:26:21 -0700
Subject: Re: [PATCH] btrfs/154: remove test for fix that never landed
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20200904114530.21746-1-johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <2ae0d906-4af4-0b7a-2a7f-fcc449191a79@oracle.com>
Date:   Mon, 7 Sep 2020 17:26:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200904114530.21746-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9736 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009070092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9736 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070092
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4/9/20 7:45 pm, Johannes Thumshirn wrote:
> The btrfs/154 testcase fails if the kernel patch "btrfs: handle
> dynamically reappearing missing device" isn't applied, but this patch was
> never merged into the upstream kernel.
> 
> Delete the test so we have one less testcase that will always fail.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand
