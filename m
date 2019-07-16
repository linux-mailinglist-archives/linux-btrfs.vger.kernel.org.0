Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E24EC69FFA
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 02:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbfGPAif (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jul 2019 20:38:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52536 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730383AbfGPAie (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jul 2019 20:38:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6G0YMXs132171;
        Tue, 16 Jul 2019 00:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=EBQbebqrbCLao3gfL77MFtbAvivgpUKXOuWukMJgbhE=;
 b=uGU0x+5GXR/4eXJtkXfcL9Uy2nL9nSMLM7FpUq73XX+IWUhEI3GG7fS2020z83FTWUF6
 PxaDlW1IlujV+aeK++v5fSj9xMVnTkwkgfR8EIu4+ZJuuLE+7MWbxYpmicEZIRivvAz5
 ug5pm4bfLg8oZXXYFMimn9KzuPx3eHGW5E/hWPt+L1l9AntynlpEkvvP7Y63p0j9120M
 yhMmfjmBvYgH9hPHOSVF4cXVBU262APi9LPiC7yOvZUQ9zL2jOPNyFB0ZSBcGDcwTELx
 7QjnckW1JmNPSbfLc/8JvHqK8kNKcpr867LIHB6vv0G40nkS8VtObwjsGYHq85y9p3CG 8A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2tq78phdvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 00:38:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6G0XBTi076803;
        Tue, 16 Jul 2019 00:36:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2tq742tet4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 00:36:28 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6G0aQJq009607;
        Tue, 16 Jul 2019 00:36:27 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jul 2019 17:36:26 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] btrfs-progs: add verbose option to btrfs device scan
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <4f150d66-0c4d-b0f2-4cf9-9bc1194d83e9@suse.com>
Date:   Tue, 16 Jul 2019 08:36:22 +0800
Cc:     linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A736C16C-244B-4803-A394-8F789C8FD5F3@oracle.com>
References: <20190715144241.1077-1-anand.jain@oracle.com>
 <4f150d66-0c4d-b0f2-4cf9-9bc1194d83e9@suse.com>
To:     Nikolay Borisov <nborisov@suse.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160003
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 15 Jul 2019, at 11:09 PM, Nikolay Borisov <nborisov@suse.com> =
wrote:
>=20
>=20
>=20
> On 15.07.19 =D0=B3. 17:42 =D1=87., Anand Jain wrote:
>> To help debug device scan issues, add verbose option to btrfs device =
scan.
>>=20
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>=20
> I fail to see what this patch helps for.
>=20

To know what are the devices path scanned.

>  We get the path in case of errors,

No. We get the devices path when we use -v option and the cli [1] can be =
success / fail.
[1] 'btrfs device scan -v'

> in case of success what good could the path be ?



>=20
>> ---
>> cmds/device.c        | 8 ++++++--
>> cmds/filesystem.c    | 2 +-
>> common/device-scan.c | 4 +++-
>> common/device-scan.h | 2 +-
>> common/utils.c       | 2 +-
>> disk-io.c            | 2 +-
>> 6 files changed, 13 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/cmds/device.c b/cmds/device.c
>> index 24158308a41b..2fa13e61f806 100644
>> --- a/cmds/device.c
>> +++ b/cmds/device.c
>> @@ -313,6 +313,7 @@ static int cmd_device_scan(const struct =
cmd_struct *cmd, int argc, char **argv)
>> 	int all =3D 0;
>> 	int ret =3D 0;
>> 	int forget =3D 0;
>> +	int verbose =3D 0;
>=20
> nit: make it a bool.

yep. Will do.

Thanks, Anand=
