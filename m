Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294D7206B51
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 06:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgFXEkj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 00:40:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50040 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgFXEkj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 00:40:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05O4cSpD075876;
        Wed, 24 Jun 2020 04:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=9qy9JZW62+Prtd9Xnov/vPBUrNIIr4w6OvXWTFIk0xI=;
 b=I8A78C1MOv53tEOm+66Dk8lkCHj7JxGluJB/j5BhtRLciGSdGkL/Wz2cW3W8La88KwVr
 uuoXMYosOSoTtJuS6YjxQvAqoPNt8zZ2qrNIb0dJ3eM1TFu3KNq9qIT98CpkdLGm2AAE
 1lbuCREx+m1MeBgHpZKMD+uOTcnBwqnh72XUHhwk/Cb7vBcVhps4zVFkihLnUg9B+MZm
 byKMiqj/fW00l0ZfMLj0JZt/S4xQREKwBeyAeZ1EGShGfj26ZCKtNW4YF5tYR/k3Ufob
 E0rSIggaCIiJ/15GnzSXxOuFQT5E/FpY+BLUrBKTYIM0ICRR4+gBhlsWDJ7dmcjSRa7T pQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31uustgmtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 04:40:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05O4XF6g165233;
        Wed, 24 Jun 2020 04:38:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31uurq72x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 04:38:35 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05O4cYCf001107;
        Wed, 24 Jun 2020 04:38:34 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jun 2020 04:38:34 +0000
Subject: Re: [PATCH v5 3/3] btrfs: refactor btrfs_check_can_nocow() into two
 variants
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200623232352.668681-1-wqu@suse.com>
 <20200623232352.668681-4-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <cc441d00-c31b-41d9-a460-38039d3ac79e@oracle.com>
Date:   Wed, 24 Jun 2020 12:38:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623232352.668681-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240032
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 cotscore=-2147483648 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006240033
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>
