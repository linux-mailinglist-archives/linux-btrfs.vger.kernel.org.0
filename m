Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE72232C0E
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jul 2020 08:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgG3GpM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 02:45:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24126 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbgG3GpL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 02:45:11 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06U6d6Qp022301;
        Wed, 29 Jul 2020 23:45:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=D86hotX/cb7r6d/EHfMbllA7mX8WZmtuKEbcZgxk+dc=;
 b=EZeLkpyYjRlSrkSGThmrnuavPVViNtA71Fd7w7NozQ6lL3U2itADCSNMxSmx8VOf6Kma
 FsOKcxIaiELz66iGnzoK7rtsV0cxBJoX9yCbEAD77Q+lsR1Lqq1ez1KSFpCcWxNIS7+Z
 WatY3Ak10Mep09O61ZofX0xWDWb3uu8+pp8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32k7hw4k3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 Jul 2020 23:45:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 29 Jul 2020 23:45:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iqf2SZjBFchqx7toi8yTtG0k94e2129A/szv62Xo7l1mLRfeV6dllkxfrnvaySrtlRwLuMWk6pzhK8ps3OHjuqcF78QokMAHVVxK1P75iTnTJ4DCfy0NP91+j1piGctzniafQytXp66ohBk+jj8YIuuMB8i8BFvzwfzvAmYrp9g8jTCwhIbV+TyRrsOt7s7KEISxjTmHh+nD+VQDLzj4mLinI06lY7aCgHcxL0QMg0gaV4iGuKEC1yj1qdonNXTgBNn/OPczlKfAIujU22oaNQsoP3N3OVu2EP5mr/+z5Hn+G1n4uNw9kgsYbwyImRqTAqz5hJShXQrFeLe2LDeEYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D86hotX/cb7r6d/EHfMbllA7mX8WZmtuKEbcZgxk+dc=;
 b=odyyowvYdv1qaxYjcAYcHJZ4E8IjjRfGW+p/KUhnIaso1gvWqLNl5w40N2xXv58SWoaOdrzainq7isCvwHUf0yh/gw2cTS13j4R+tHAszBSqtZUvv7jPgIPraFQYq9pq/GV3tTExWq8ryvaJZq9xM6f3hWct10kKowt9l5grMPL3rq5sydw14ApAMvThVIH0P+SsNZq/mZNiEMANVx9dF/caIVB716gLkm33Y14Uwmim7UaaDJ+7MPAZ1u/N+jqCBEhCp7suO/8goIbQMemwM8UfC5fkINhVTCi7bXxiTipEETD+wpXYkZTQBR5agdwc8SUQlahHoeDYB41D16ILaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D86hotX/cb7r6d/EHfMbllA7mX8WZmtuKEbcZgxk+dc=;
 b=TyzdJEf1o2fiwoo/8kFmlM+HiBolP86jntBTPwPw0gBINlrMQxzk5DdDBj2Jfdj8f0VjCv/9w5kHzNQ4Ae/jjfzJJDxm7j49wVKGj3bdQOZ4OSegvgLVkZBkCekPf83oB7DQNey/Rck6jVRWGN+G2lmglUxTzhAb9cxicw9f6AM=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2567.namprd15.prod.outlook.com (2603:10b6:a03:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18; Thu, 30 Jul
 2020 06:45:04 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::543:b185:ef4a:7e8]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::543:b185:ef4a:7e8%5]) with mapi id 15.20.3216.034; Thu, 30 Jul 2020
 06:45:04 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
CC:     Vojtech Myslivec <vojtech@xmyslivec.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        Michal Moravec <michal.moravec@logicworks.cz>
Subject: Re: Linux RAID with btrfs stuck and consume 100 % CPU
Thread-Topic: Linux RAID with btrfs stuck and consume 100 % CPU
Thread-Index: AQHWZewvOpSjlemJhUCrvChqakxCNakfrg+A
Date:   Thu, 30 Jul 2020 06:45:04 +0000
Message-ID: <D8373CAD-7BB0-4DB9-AB6C-7BF0BE035286@fb.com>
References: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz>
 <a070c45a-0509-e900-e3f3-98d20267c8c9@cloud.ionos.com>
In-Reply-To: <a070c45a-0509-e900-e3f3-98d20267c8c9@cloud.ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: cloud.ionos.com; dkim=none (message not signed)
 header.d=none;cloud.ionos.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:395d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09ecde66-330b-407f-a47d-08d83454170d
x-ms-traffictypediagnostic: BYAPR15MB2567:
x-microsoft-antispam-prvs: <BYAPR15MB2567110512499794F6F9F694B3710@BYAPR15MB2567.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RwjXldVGyOp9/mhlNFY7nN1jjVhsTLI5d65ndTObppyWlj7xFTuRHbOh9H4k7vtrUWko/jOoqmmAQhp03xdE7GaY+krcSKDx982QEh5iaWrL9IpKNcFoTPs/Jzmu3IQN4li2zLg4jS0xFRUnAbyrsUmF7EsiK3pe8tpwH+6fhagjokmF+sATrrdXb+nqBSwehdo1JpAb2lrMZs2ywoIVLJDWFJlVfRz3Rw9QNrUGfyQzd/uDMIxZevZX12fdjLT+9PNZ4/bNici2b35NrzrTZZ8ow8STYPRvU8muU6BMcBhR6QGf/ykiQnAGe64N788q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(39860400002)(396003)(366004)(136003)(2906002)(2616005)(83380400001)(33656002)(186003)(6916009)(4326008)(66476007)(66556008)(5660300002)(64756008)(66446008)(6486002)(76116006)(66946007)(6506007)(53546011)(478600001)(8936002)(86362001)(54906003)(8676002)(6512007)(36756003)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: eTW1IntOi58tF27M9TYcJh/yqjYUXxlDYG9mwqqMXqNYVblyVAVhhyGMNrYbppG6VG0HRY8SDIO44EhGl1WjoxtdDQDoANcnxWNMMoHKR9vExOqG1RzjImbOcf4t1gQmzsNt6iMSZkrE++o9XW/h64Ue95E5zVMvRnuXevOlQRrynsVE1cPcMR7NEQ/rlA313oi/Yal1TkYXst0dVhsvsx7gvqPKcjD44N1kRIksTSDiVNVL9Xt6MiyMgBIsBwEvxnOk2mc/sVdBpsjU+fTCjrL8TKcDFzVoClvmttg8H91+m+QN9eSku/Fkr4saN/V1aLiDTUVJNTo+0MSti2ZPddyroXHZaPPrOBKvcWCXeki7M6+lE4a276GXqaK5C9k1q8Kk1gr7MesVHE/1A+Cx2sl8X4/z5+wXJG94BjNMhI64arBHLZjJSgNWdTO/G9LM1F+mQot+ZXUybH0SSdntE/a2ftl7xaa2zV80vjyQstA+8AebPOGSYEavucsx2Y+PiQA/8Msd2iXwahvCa+C+TzAT76CPy0xMKbJVN6a3Pq5JWwAyP7maAzaBVjOnBY7TK6U1MAbFBlkayi7QRYaByBH4jxrbstjM87QAtKcZ76NeE5LOmsCd8ViKxxlH+Dakui3WoHjbGRkowrTTkCbTD1kxaABwiAgBCbArFaZ0SNOLXZ2/AzBML7Zreri0UmIR
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27162D9B601CF24A983FDDD3B89FB8D7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ecde66-330b-407f-a47d-08d83454170d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 06:45:04.0912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6X1eG6m7VkCD+I2BeQ9ijCDUtseUAYagur0dv9bC5YOJJ5iip8ef2oZKA1rRY7EugLyzIQS5NUA6y5A19gNKwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2567
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-30_04:2020-07-30,2020-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007300049
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On Jul 29, 2020, at 2:06 PM, Guoqing Jiang <guoqing.jiang@cloud.ionos.com=
> wrote:
>=20
> Hi,
>=20
> On 7/22/20 10:47 PM, Vojtech Myslivec wrote:
>> 1. What should be the cause of this problem?
>=20
> Just a quick glance based on the stacks which you attached, I guess it co=
uld be
> a deadlock issue of raid5 cache super write.
>=20
> Maybe the commit 8e018c21da3f ("raid5-cache: fix a deadlock in superblock
> write") didn't fix the problem completely.  Cc Song.
>=20
> And I am curious why md thread is not waked if mddev_trylock fails, you c=
an
> give it a try but I can't promise it helps ...
>=20
> --- a/drivers/md/raid5-cache.c
> +++ b/drivers/md/raid5-cache.c
> @@ -1337,8 +1337,10 @@ static void r5l_write_super_and_discard_space(stru=
ct r5l_log *log,
>          */
>         set_mask_bits(&mddev->sb_flags, 0,
>                 BIT(MD_SB_CHANGE_DEVS) | BIT(MD_SB_CHANGE_PENDING));
> -       if (!mddev_trylock(mddev))
> +       if (!mddev_trylock(mddev)) {
> +               md_wakeup_thread(mddev->thread);
>                 return;
> +       }
>         md_update_sb(mddev, 1);
>         mddev_unlock(mddev);
>=20

Thanks Guoqing!

I am not sure whether we hit the mddev_trylock() failure. Looks like the=20
md1_raid6 thread is already running at 100%.=20

A few questions:=20

1. I see wbt_wait in the stack trace. Are we using write back throttling he=
re?
2. Could you please get the /proc/<pid>/stack for <pid> of md1_raid6? We ma=
y
   want to sample it multiple times.=20

Thanks,
Song





