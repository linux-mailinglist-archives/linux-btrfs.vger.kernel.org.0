Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75EB63711EE
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 09:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhECHYa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 03:24:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50646 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhECHYa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 May 2021 03:24:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1437FECs124271;
        Mon, 3 May 2021 07:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=PRTKyLHF7uB7hw/rNKqK5iaFT2wvuHgVDu9UJa42LW0=;
 b=KGpBy2aSTBDXoVNuL/opNj2f9Yd+7p11aE399zSP9/JC74BWSf8KKPenffN4FC/NLavA
 DORdDmGQAuBXsad8jIntu1jp4i+/bRnOTcnJ6lKgzFzRz2wmjB06mEjHqTXnzP0W7fqk
 +4B4K5tYpLmrPYXgk4m5s/39K/hzJDrmH0hT6srC8UE0VfokJ91eK/2kvB3ql9X9B07s
 F2OV7o2C+oK0rwbEkolIS/boZqwatH+Fq5EfUFPVc56m6Xd2QfuDrY2X45uC9s1vaNk0
 XZKcfMuEw0XVvz4yBb3TkO2n73oxVTyQrILAmjhHb63plr5qYbTog2xoF7XduAdlTDbf 2g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 388xxmtpxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 07:23:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1437KAkq062499;
        Mon, 3 May 2021 07:23:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 388xt1xuqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 07:23:31 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1437NV9s078301;
        Mon, 3 May 2021 07:23:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 388xt1xuq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 07:23:31 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1437NTGo012563;
        Mon, 3 May 2021 07:23:29 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 May 2021 00:23:28 -0700
Date:   Mon, 3 May 2021 10:23:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Khaled ROMDHANI <khaledromdhani216@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/btrfs: Fix uninitialized variable
Message-ID: <20210503072322.GK1981@kadam>
References: <20210501225046.9138-1-khaledromdhani216@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210501225046.9138-1-khaledromdhani216@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: YsC9ZDBNHAigZu5GhynQq1XkYp9b4oEt
X-Proofpoint-ORIG-GUID: YsC9ZDBNHAigZu5GhynQq1XkYp9b4oEt
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9972 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030048
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 01, 2021 at 11:50:46PM +0100, Khaled ROMDHANI wrote:
> Fix the warning: variable 'zone' is used
> uninitialized whenever '?:' condition is true.
> 
> Fix that by preventing the code to reach
> the last assertion. If the variable 'mirror'
> is invalid, the assertion fails and we return
> immediately.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
> ---

This is not how you send a v4 patch...  v2 patches have to apply to the
original code and not on top of the patched code.

I sort of think you should find a different thing to work on.  This code
works fine as-is.  Just leave it and try to find a real bug and fix that
instead.

regards,
dan carpenter

