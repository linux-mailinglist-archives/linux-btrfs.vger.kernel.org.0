Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD711A03A8
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 15:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfH1NsZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 09:48:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48468 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfH1NsY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 09:48:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SDk9ZL052583;
        Wed, 28 Aug 2019 13:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=tqH6CHJ/ET/rAdAhMVuF7/1RQFPJEvdKSNTcHp4O2pc=;
 b=TpjRmE5kuYiF5VQTAhp6pJxWwGO/Yv/seloOk7GBv3DM5/7/k/1quPrnNvVon2aj4acS
 J6N3KXVEPkgsGm2aTAuHjPghyW62mXnUPCDXONmyTOK6X8uNkp5Ql7c03sAB+4EhUtXi
 wdn2dkzMzF288MiIklm5cG5ZN97RPqCx2pt4KodC5z0I9aWlQU7MsK60kpuZA86qW8G/
 WXcIHMoBAX1ux/ZBKoI9pBsluH+zVsyS1zg97HOFVWk07qNl8qEjjEahk1v83qozUMlX
 9OELMA3n/C1NO7B7yOkseit/Ppm1KruCupq3aq39++WOiVclXMsF1z3XLs7L55+nBpZu Rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2untsc80tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 13:48:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SDXf4s090307;
        Wed, 28 Aug 2019 13:48:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2untet9bfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 13:48:20 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7SDmIb0024979;
        Wed, 28 Aug 2019 13:48:20 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 06:48:18 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] btrfs-progs: add BTRFS_DEV_ITEMS_OBJECTID in comment
 in print-tree
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <f5992432-3bed-de22-0cb2-3c631aa01a03@suse.com>
Date:   Wed, 28 Aug 2019 21:48:07 +0800
Cc:     Anand Jain <anand.jain@oracle.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A590A125-DB60-4E7E-AA64-1154D9911043@oracle.com>
References: <20190828095619.9923-1-anand.jain@oracle.com>
 <f5992432-3bed-de22-0cb2-3c631aa01a03@suse.com>
To:     Nikolay Borisov <nborisov@suse.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280144
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 28 Aug 2019, at 9:01 PM, Nikolay Borisov <nborisov@suse.com> wrote:
>=20
>=20
>=20
> On 28.08.19 =D0=B3. 12:56 =D1=87., Anand Jain wrote:
>> So when searching for BTRFS_DEV_ITEMS_OBJECTID it hits. Albeit it is
>> defined same as BTRFS_ROOT_TREE_OBJECTID.
>>=20
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> print-tree.c | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/print-tree.c b/print-tree.c
>> index b31e515f8989..5832f3089e3d 100644
>> --- a/print-tree.c
>> +++ b/print-tree.c
>> @@ -704,6 +704,7 @@ void print_objectid(FILE *stream, u64 objectid, =
u8 type)
>> 	}
>>=20
>> 	switch (objectid) {
>> +	/* BTRFS_DEV_ITEMS_OBJECTID */
>=20
> That comment looks really cryptic to someone just looking at the code.
> Adding case BTRFS_DEV_ITEMS_OBJECTID: is better.
>=20

Both of them defined with the same value (we find which object by type).
So only one of it can be in the case.

#define BTRFS_DEV_ITEMS_OBJECTID 1ULL
::
#define BTRFS_ROOT_TREE_OBJECTID 1ULL

Thanks, Anand


>> 	case BTRFS_ROOT_TREE_OBJECTID:
>> 		if (type =3D=3D BTRFS_DEV_ITEM_KEY)
>> 			fprintf(stream, "DEV_ITEMS");
>>=20

