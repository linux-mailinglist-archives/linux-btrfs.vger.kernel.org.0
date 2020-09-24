Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077D527711E
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 14:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgIXMfP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 08:35:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50714 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbgIXMfP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 08:35:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OCOlSg164241;
        Thu, 24 Sep 2020 12:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=uoClJBbywQlp6XhiqBQyYJs9pWotLcuaPL7kPEIP7YU=;
 b=RN1RGYFJq8wbrlMAHJ+RnDGcDYuT2xar+Ms5niVRbFKCYVlH7v6LBrJcfAvWVOomck8Q
 k7nLOUQxwMyHvd53aLsw0Df726NVaQbRSYB7QV3KQFN6S4YKHpTUkHbyrq6ap7wdeIgH
 2/6wz4XezcflH8Fy3UkRf55N4MK7492Z0Ur9igukYwTo8h49KG79sfJv4hL/eM0uhACb
 SNgHKfbL6eW8RVAmBOja6U9hr5BLrzz3MTcIpeFCKtRWLh1teICbi3xsCFjsQv2lGTab
 5h2X0y7UKSAEKVeIqMsEx6mRu4WQ6oEeBj0KzNEhWIPkn5/WmDOeMSYtM+Gb5XKJPCPU Fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33ndnuqydu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 12:35:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OCQTic001523;
        Thu, 24 Sep 2020 12:35:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33nurw4s36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 12:35:08 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08OCZ71L013231;
        Thu, 24 Sep 2020 12:35:07 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Sep 2020 05:35:07 -0700
Subject: Re: [PATCH] btrfs/163: Fix recently broken test
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        johannes.thumshirn@wdc.com
References: <20200924121910.22477-1-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <27b33a7f-74de-5ae7-fb71-586e36571b7d@oracle.com>
Date:   Thu, 24 Sep 2020 20:35:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200924121910.22477-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240097
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/9/20 8:19 pm, Nikolay Borisov wrote:
> Upstream commit "btrfs: fix replace of seed device" broke btrfs/163 as
> it disallowed replacing the seed device. Update the test to account for
> this change in behavior.
> 

  Related fix has already been submitted here
     https://patchwork.kernel.org/patch/11758651/
  I think Johannes already picked this.


