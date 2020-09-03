Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1430D25B910
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 05:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgICDPE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 23:15:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55384 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgICDPD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 23:15:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0833C6Et131000;
        Thu, 3 Sep 2020 03:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=uSIhunwDl2BLTZ5BTUx/BRUK4Tcif98Ck9hCQW4VlKQ=;
 b=hZ7yXQ+w494xvx/LphAoyQJEoIJMxZ+O6MeG8N/PVtQ3g/mnA3Ohe+jpPWG0V6+iifcu
 XlXFdmyAOmfYSf6HCTEb7tI9nqGklrtUlzeYzNzGFr6xr0L4KbPTgN15qnVjsFC31NR7
 BwAfaL6A9iquPQD+5evuLRRZpIHP0/6epnie40vFfre3mk9z0M2IQLnUkG+bmeqJE/8W
 5hoXGV+zyKCxKnAP3pr3thD/QJtZ1a3EnMyGa2w7z+M4ikiVsYEIpImVi8AA9ifOEBO2
 qa/g18Sxkg4QCfbGQP0Hf7E30XY5mGRPul7efiGXZKi7EkZlu41mQFvSEK9o9YjvDIFx sA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 337eyme5g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Sep 2020 03:15:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0833B5EU098852;
        Thu, 3 Sep 2020 03:13:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3380sv6r6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Sep 2020 03:13:01 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0833D0Ta014455;
        Thu, 3 Sep 2020 03:13:00 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 20:12:59 -0700
Subject: Re: [PATCH] fstests: btrfs/219 add a test for some disk caching
 usecases
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <8e841e0e05934baaf6119363414440b271426a03.1599065695.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <0ae4f962-34b2-902e-b7d4-ec55ccac3dfb@oracle.com>
Date:   Thu, 3 Sep 2020 11:12:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <8e841e0e05934baaf6119363414440b271426a03.1599065695.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030029
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/9/20 1:03 am, Josef Bacik wrote:
> This is a test to check the behavior of the disk caching code inside
> btrfs.  It's a regression test for the patch
> 
>    btrfs: allow single disk devices to mount with older generations
> 
> Thanks,
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Also thanks for adding the kernel patch information in the test case header.

-Anand
