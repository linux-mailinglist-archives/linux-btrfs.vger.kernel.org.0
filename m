Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB3126A46A
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 11:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfGPJAB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jul 2019 05:00:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52096 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfGPJAB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jul 2019 05:00:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6G8werU033666;
        Tue, 16 Jul 2019 08:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=xgYP1TV/SD8LAibnjG/fEYNLEBgewouqBlXzL6EPNJ0=;
 b=xI+VCKML6FustLbrA2ncNTTAgbmuHzkmF6/I+NVspRYnSdpkyMVgwhRBAndqDgb0/L6x
 3/NNa4kjyP9Bu1FYtARwhqv+jhgMnG8LRUwiDPY0Mskz2n+H65i2bPQPLcufTxrYlVZ4
 kz6cqLzhQ6Wl96y8xWEmTDJFN4FuqZF9RD2U0VakQ4c4ksFALx94cFYD5o9xdzQetKgI
 uY0sFPYRvEqCQLInwE1MES6QpuJjPxSWwX+/pqjpSvmSrJT9Mz3rS8KiBR2/caY+Hu9o
 CqMhedQ5deb11WoBUt3kiUR/6a8EUT51E6t3w6eZ2JTU420Fi4ZxCxZ8Tx/2ULbEQHtv cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2tq7xqu71a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 08:59:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6G8vc6s038561;
        Tue, 16 Jul 2019 08:59:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2tq4dtt1tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 08:59:53 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6G8xoS8005865;
        Tue, 16 Jul 2019 08:59:50 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 01:59:50 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] btrfs-progs: add verbose option to btrfs device scan
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <d40bf6e2-cf8f-d2af-a769-b217f97ab7dc@suse.com>
Date:   Tue, 16 Jul 2019 16:59:46 +0800
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <16170046-FE04-4F39-A469-14FD9D788D2C@oracle.com>
References: <20190715144241.1077-1-anand.jain@oracle.com>
 <4f150d66-0c4d-b0f2-4cf9-9bc1194d83e9@suse.com>
 <e8aaa2cf-3e10-4ff9-dabe-c6192583e93c@gmx.com>
 <d40bf6e2-cf8f-d2af-a769-b217f97ab7dc@suse.com>
To:     Nikolay Borisov <nborisov@suse.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160115
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 16 Jul 2019, at 2:46 PM, Nikolay Borisov <nborisov@suse.com> wrote:
>=20
>=20
>=20
> On 16.07.19 =D0=B3. 4:26 =D1=87., Qu Wenruo wrote:
>>=20
>>=20
>> On 2019/7/15 =E4=B8=8B=E5=8D=8811:09, Nikolay Borisov wrote:
>>>=20
>>>=20
>>> On 15.07.19 =D0=B3. 17:42 =D1=87., Anand Jain wrote:
>>>> To help debug device scan issues, add verbose option to btrfs =
device scan.
>>>>=20
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>=20
>>> I fail to see what this patch helps for. We get the path in case of
>>> errors, in case of success what good could the path be ?
>>=20
>> AFAIK it would provide an easy way to debug blkid related bug.
>>=20
>> E.g. scan only works on some devices and misses some devices.
>=20
> In this case (and I already debugged one such case) it's invaluable to
> use LIBBLKID_DEBUG environment variable, the debug string added in =
this
> patch won't help in this particular case.
>=20
> <snip>

Export LIBBLKID_DEBUG=3Dall is good for debugging libblkid itself,
btrfs dev scan -v provides a confirmation on which devices
were scanned and their paths.

Thanks, Anand

