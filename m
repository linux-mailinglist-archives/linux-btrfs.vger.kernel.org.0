Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53811AE4F3
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 09:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbfIJHyi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 03:54:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37510 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbfIJHyi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 03:54:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8A7s1cZ018050;
        Tue, 10 Sep 2019 07:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=KqTrWn+LBaaSIu5ZSG4BbCqYVrafQFwWs5+c+/xrA9w=;
 b=gVmoxZzGHCqNOIBt/6OrVa3UqBc7FerOGw/7YAqQ6y44hjdzPJLleRHMMX9kyL3yU9Jk
 +qNt7aQGLK+6UCbb/yyMBkJQgjhTkOhLMUXTmJF7Lp1ND+XfH7Fe194swXVCXzIj7fWS
 xt4IhMfVf4O0vNXKBtbpamfcjZ7Zq09MLMxyT5AuYqczxWvlGkjo9zB3HDm0VTto4IkI
 lQ6Q2Ug4qLF3ZAO4raG2hf6JFC5fZjFhTh3b0XvO5EFWUFN+Vzk5WXBcXKquetlM2mbY
 BHEVZuRApRtSvjrVtVNh4BSleX6Jz/sAPo0FJrbpWZC/8j7fNXfzNQccijt0r4qI+PNw Lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2uw1m8seat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 07:54:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8A7sM0e054028;
        Tue, 10 Sep 2019 07:54:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2uwqqdkc1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 07:54:33 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8A7sSh4027007;
        Tue, 10 Sep 2019 07:54:28 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Sep 2019 00:54:28 -0700
Subject: Re: [PATCH 1/3] btrfs: ctree: Reduce one indent level for
 btrfs_search_slot()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190910074019.23158-1-wqu@suse.com>
 <20190910074019.23158-2-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <148bdfdd-30a0-921a-6f88-73e2676be00d@oracle.com>
Date:   Tue, 10 Sep 2019 15:54:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190910074019.23158-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=809
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909100078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=876 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909100078
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


This patch also adds line stretching until 80 chars.

looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
