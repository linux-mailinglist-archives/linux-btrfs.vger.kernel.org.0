Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF8E514022E
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 04:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389188AbgAQDBi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 22:01:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43244 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388298AbgAQDBi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 22:01:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00H2sSn0054886;
        Fri, 17 Jan 2020 03:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Alf7JGVMdSBj/3XLyh41lux46Zi5EpqX6tVr5qI2PvA=;
 b=MKZaNYBMOu5F2Yi+kbcF43YUdO/Ai2Cg39VXW0ZUeU7fabWWV7zW7P7v/loakt4v2u23
 C9T8UmtiWdWBYC6L7AhtY+K69A3ph5yxBqA7GfvSyMmotKfa6aYzqYU1H8BXpci0wbww
 nxaihPi/s5DmVQWVm5Gja6mjGq264tb0HmKmYa6qZ0gxcM6iSLyQ5UdskQMGa9qX5gH1
 X1Aa/Tucgv6f9jyoVyC19VeyXfUOOeZ2YUPmBOs2EDBIoreXXVq/pn33VUVqAVUNu+qH
 BYi1rPb/gosRULwMvj47B9xrFFrnX9+CYIS8X7EAgM4XVB5G13BD22x5IoiC8aZRjeUD FQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xf74sp6m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 03:01:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00H2sJv4162005;
        Fri, 17 Jan 2020 03:01:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xk24e6nk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 03:01:35 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00H31XoW010950;
        Fri, 17 Jan 2020 03:01:33 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jan 2020 19:01:33 -0800
Subject: Re: [PATCH 2/5] btrfs: include non-missing as a qualifier for the
 latest_bdev
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20191007094515.925-1-anand.jain@oracle.com>
 <20191007094515.925-3-anand.jain@oracle.com>
 <36b867df-4795-d467-dd08-dc5ac4ad7cd0@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <fa7fc9e1-1022-847c-166f-aaa6f0399200@oracle.com>
Date:   Fri, 17 Jan 2020 11:01:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <36b867df-4795-d467-dd08-dc5ac4ad7cd0@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001170019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001170019
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[...]

> This should be turned into an xfstests.

xfstests btrfs/197 was added.

43602315cad9 btrfs: test for alien btrfs-devices

Thanks, Anand


>  You can add
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> 
> Thanks,
> 
> Josef

