Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26073273738
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 02:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgIVASP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 20:18:15 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54906 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgIVASN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 20:18:13 -0400
X-Greylist: delayed 1683 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 20:18:12 EDT
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08LNnP2v104360;
        Mon, 21 Sep 2020 23:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=CXEBM6dnpV4T5DeBAp5FgQJ3kismk491/nHM3kUpRF4=;
 b=dU3lgAifJF3kWQpLmr8xig25X+AjA/KNj3cgkEZJtmnvXiRax246IIXVQXiYsze+9o1u
 zuMyb99yCKvhxYDYkMoHputGWSZEK+DB+c8P8H/tWSimUXoL4rPWE9G7t27FeKQPDOlB
 +Nxrgl/p0em7rlL+CKod01PBokUN+bV4Md4prIozhjqqBYHdZGtqCtFlYQES5y3ophz+
 4MpAhJKCn3Zdb+x7oThNSoIpEKMgSBGmy8f/raaD/+Q6GJDFYaULlKy+Rfv5X5ZBDATK
 rPSbrEkl6Uvx0rO0HuLpmd9e8eQrfrXL/EP4G20dvhMMDkvJzn1wDbCwaZUZve+TblyN bQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 33n7gacfp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 23:50:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08LNnnQ1073991;
        Mon, 21 Sep 2020 23:50:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 33nuw27nbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 23:50:04 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08LNo1dv031677;
        Mon, 21 Sep 2020 23:50:03 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Sep 2020 16:50:00 -0700
Subject: Re: [PATCH 1/2] btrfs: init device stats for seed devices
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1600461724.git.josef@toxicpanda.com>
 <b0c2be2e6722f091821521301f251628afcd8313.1600461724.git.josef@toxicpanda.com>
 <8217721c-0bd9-67af-1900-9594689c127b@oracle.com>
 <20200921202502.GT6756@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <61d797cc-3fbe-e043-6430-2fa1c29d5d0b@oracle.com>
Date:   Tue, 22 Sep 2020 07:49:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921202502.GT6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210175
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210175
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22/9/20 4:25 am, David Sterba wrote:
> On Sat, Sep 19, 2020 at 05:47:18AM +0800, Anand Jain wrote:
>>
>> Seed read errors should remain persistent.
> 
> How? The seed device is read-only, we can't record the stats and
> recording them on the sprout device

yeah on the sprout.

 > has unclear meaning.

Ok. Not required then.

> 
>> A similar update to btrfs_run_dev_stats() is required?

