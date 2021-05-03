Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA1137149B
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 13:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhECL40 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 07:56:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41926 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhECL4Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 May 2021 07:56:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143Bs17B134887;
        Mon, 3 May 2021 11:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=AAyZkKWuqq5vRsFe0Durc3DY/xdDGYQ5XRUSlOZ3gyE=;
 b=ojrx5BJbSJn1S5VJDTtBfc1kUpouSrPLIsZeOKRxdSfuKTzDS22r9s4bdUFuJ+K7ZApq
 8px6V6ypOASA1oPOeIGNX+KED+qYZs0PRm5cLWrtY4guHHzzEkGoNji9KFOL8Z/T8SKW
 WAmah8E6KHCGNbDljn0WljwmN6yArHo9lX43EnDjUwB38H0i5T7WYUUCRWl6kBsePu3p
 1ryZ3O7ccv1NOCAdmTbBmZzhMjM9U4AbfAEJvqf+uWUx0JaDK0g7b4l3eR3EtafxtOpj
 6UTOXF4rR+Kl2bCPEJF+4w+nmBdUSYU4nz+KiuPI7xAEPIkkA+EzQDg/wNhui3C8JAPy zQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 388xxmubfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 11:55:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143Bt9Kv095064;
        Mon, 3 May 2021 11:55:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 388v3uvn4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 11:55:25 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 143BtOdw096285;
        Mon, 3 May 2021 11:55:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 388v3uvn3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 11:55:24 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 143BtNCr008052;
        Mon, 3 May 2021 11:55:23 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 May 2021 04:55:23 -0700
Date:   Mon, 3 May 2021 14:55:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Khaled Romdhani <khaledromdhani216@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/btrfs: Fix uninitialized variable
Message-ID: <20210503115515.GJ21598@kadam>
References: <20210501225046.9138-1-khaledromdhani216@gmail.com>
 <20210503072322.GK1981@kadam>
 <20210503101312.GA27593@ard0534>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503101312.GA27593@ard0534>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: Ns5gJI1mwHALv6qd-EvkF4RqtyxAsrfu
X-Proofpoint-ORIG-GUID: Ns5gJI1mwHALv6qd-EvkF4RqtyxAsrfu
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9972 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=926 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030083
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 03, 2021 at 11:13:12AM +0100, Khaled Romdhani wrote:
> On Mon, May 03, 2021 at 10:23:22AM +0300, Dan Carpenter wrote:
> > On Sat, May 01, 2021 at 11:50:46PM +0100, Khaled ROMDHANI wrote:
> > > Fix the warning: variable 'zone' is used
> > > uninitialized whenever '?:' condition is true.
> > > 
> > > Fix that by preventing the code to reach
> > > the last assertion. If the variable 'mirror'
> > > is invalid, the assertion fails and we return
> > > immediately.
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
> > > ---
> > 
> > This is not how you send a v4 patch...  v2 patches have to apply to the
> > original code and not on top of the patched code.
> > 
> > I sort of think you should find a different thing to work on.  This code
> > works fine as-is.  Just leave it and try to find a real bug and fix that
> > instead.
> > 
> > regards,
> > dan carpenter
> >
> 
> Sorry, I was wrong and I shall send a proper V4.
> 
> Yes, this code works fine just a warning caught by Coverity scan analysis. 

We're going to a lot of work to silence a static checker false positive.
As a rule, I tell people to ignore the static checker when it is wrong.

Btw, Smatch parses this code correctly and understands that the callers
only pass valid values for "mirror".

regards,
dan carpenter

