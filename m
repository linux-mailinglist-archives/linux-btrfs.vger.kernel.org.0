Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82F921B935
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 17:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgGJPRg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 11:17:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51000 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgGJPQ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 11:16:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06AEquQf132094;
        Fri, 10 Jul 2020 15:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=kXCkbplT+FPAGg7wgsRBUZpWsgmUZkWtp2Vq5ig20Fk=;
 b=oWhFJ+rLN2gf65vCzX/3/vUdaZbILQYlyiwYu9eGtoxusGO1SgMdWdLDUJ7JBAS46EZF
 PbwM661/6P9wRX6CJKgTFPwHs3fmEvOeao98fE3MIS/3X+0e65O1y7CpBGWWKDYJjmbH
 JUgFI2VkW3PlcSdxRBeBjHbMskNdSKMYJUsqemWQ/e7WcLe0bkVhrOPC6jvSGmmg2ihj
 BtFBoH5xKhut0CBCWlaCpxBnsHF/5wXT3n0rK1OJLtjuKsCkb+bAfgGiqKbeMcELJXsq
 L2SF5ZKcHTKgcBzBHFXVT7HPBkXzMMsLkZfQZDu5KvKoRqchKL/QC6hBcbTYAIbl7B2S Zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 325y0ar2c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jul 2020 15:16:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06AFEP4R106881;
        Fri, 10 Jul 2020 15:16:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 325k42kydp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 15:16:07 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06AFG7pb007004;
        Fri, 10 Jul 2020 15:16:07 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Jul 2020 08:16:06 -0700
Subject: Re: [PATCH] btrfs_show_devname don't traverse into the seed fsid
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20200710063738.28368-1-anand.jain@oracle.com>
 <68bd59f6-8817-f682-1570-ad2131086ac8@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <e66f6a5b-9790-b545-b5ee-8e1ce007b0cc@oracle.com>
Date:   Fri, 10 Jul 2020 23:16:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <68bd59f6-8817-f682-1570-ad2131086ac8@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9678 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9678 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100104
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> 
> This needs to come with an xfstest so we do not regress this in the 
> future.  Thanks,

  Oh yes. Makes sense. An xfstests test case is on its way.

Thanks, Anand

> 
> Josef
