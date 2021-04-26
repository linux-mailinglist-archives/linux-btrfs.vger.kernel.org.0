Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E63336BAA8
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 22:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241856AbhDZUXq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 26 Apr 2021 16:23:46 -0400
Received: from mail-be0deu01on2126.outbound.protection.outlook.com ([40.107.127.126]:53216
        "EHLO DEU01-BE0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241598AbhDZUXq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 16:23:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ej7LbEul/ZgA8tgPoz1YoTscV5UcfIQE+NZ8UnL6D+pkAZWnET6NV+7rUTKe+yfrumVmvzCrr6w14qDn9Ih3DDNLdhzBU6sP/Z1XROBH3P/y0vLPj+oOhMCQeyCpoEzX073Jsyog7MwOsFk47TA4EakF4gpdB67HXitJ5kyY0vqHF3cqlIHVFWhPWX9dtOulySEgJm/hi2e3Gr81xYvxy1qVFSzf2cb0zMOszDsy4FHlNlaKB8bhLdRuqt6wp2u95zqBOmAuETvfmlHqQ0ln6lPRp7SHw7s8Z54TWuzsRmmEmffYGgeBzYSnfVouBeyEE+E0ayzEJ9YeUoQHNJDzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxvHPilriATPXGLyqIM4Oj1vzNw59/2iWHCOkWhbbDo=;
 b=lxTdpaAvoD1hCKys7dZzHnpBdqAid4M/+8VStHag8V6uZYwrMMTIqCpeSkkCP6fhTiLvxQoeF64dRl4iZL5tw/55UgGSzGUwSGLSD4BHGEkvldJN05QDL8BoUNV8C+OF8/T4QyStm1mKz+vNuq2USN3TKZD7ueqGpy5+99a00u9wZmVrRqjUjFzvMZ5fBmCQEH6nbMpKZ/jmUog1IzO6fSF28TWIdXim1xuJz0+ffOOggpEo1NOSGB/ds9bv6aWneru/h1UrtKDA0ShpM7Jy7WUKQGySYStxiCeYSaqxveuiovqtXIC4C2VaDQ0Ez63Qtw13dsChO4VhdVsNJM0+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onlineschubla.de; dmarc=pass action=none
 header.from=onlineschubla.de; dkim=pass header.d=onlineschubla.de; arc=none
Received: from FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:45::10)
 by FRYP281MB0517.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:44::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.17; Mon, 26 Apr
 2021 20:23:02 +0000
Received: from FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM
 ([fe80::cdcb:792e:c36:b5f5]) by FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM
 ([fe80::cdcb:792e:c36:b5f5%7]) with mapi id 15.20.4087.025; Mon, 26 Apr 2021
 20:23:02 +0000
From:   Paul Leiber <paul@onlineschubla.de>
To:     Roman Mamedov <rm@romanrm.net>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: AW: Parent transid verify failed (and more): BTRFS for data storage
 in Xen VM setup
Thread-Topic: Parent transid verify failed (and more): BTRFS for data storage
 in Xen VM setup
Thread-Index: AdcuC0blJlFiU0MzRl+vvJbtaBo5jAADVKYAAxxLewA=
Date:   Mon, 26 Apr 2021 20:23:02 +0000
Message-ID: <FRYP281MB058253BA2379782E2BC21A86B0429@FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM>
References: <FRYP281MB058285E8F1BD4B521817F6CFB0729@FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM>
 <20210410194842.71f49059@natsu>
In-Reply-To: <20210410194842.71f49059@natsu>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: romanrm.net; dkim=none (message not signed)
 header.d=none;romanrm.net; dmarc=none action=none
 header.from=onlineschubla.de;
x-originating-ip: [2003:d2:1f0b:21f0:4440:6526:1c9a:456d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8801fba8-41d9-464f-9fb4-08d908f11757
x-ms-traffictypediagnostic: FRYP281MB0517:
x-microsoft-antispam-prvs: <FRYP281MB05170EF2CE81F583CEEE3628B0429@FRYP281MB0517.DEUP281.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SvlDDIb5IcVdQZPfubAv+rvZtflgaM3VnXOacKfp4I+dspvO6wc4dQ3zJOaYzOGE+0v5mHJRBJcIXLRL2fKy8Ra/Dyr9/MoJstykd57W3sIsR5X/jhc7KRAgrOUao6GbK5QuI4BRUtdZsnx6bE6OMwFAN5YDr7yl2WtNC3OPXcVuW0+BgNmPO1BSjhNgoqXR/WTjy81GYNxga6YrAtmL7JGirXM+NffF4YuVrjgzXRiMwI6CexkT0NAQbv24sHdOSoSGXO8V5s7M0PBYWQDqG90L3uqvvaTEZzg9hOb/SvW9ezuQKTLCNoFu8nl+HPGdXdOqJT7vtZmC0U1rBsl8gowZQAZKDfktacIbrXIfgpDWLNFSApmGtYG9RZNhBVDuCf0YU3Hm3SNz5WsI1QVrep7DR4Vx7cTiNDsi/Z77rOwL5JLIPIbjA70+7c8Cx0aWKknwjMrcKt63JSPrBKeCEJ6VFtgRs2ZfZxrR+CkqnX3/+6/YhB/KEoIvEj6IrlQ8XhMG/hVPuc75ObfgcHARkQQWMYyPF2vW4c5FA6vXLmwG1mcuhMntIqwf8Wqo2HiOQu3wHfhyzHiCxKmhNPr6z3CUZc1peKV3+IQ1fNxSASA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(39830400003)(376002)(366004)(34096005)(136003)(396003)(71200400001)(4326008)(33656002)(6506007)(7696005)(52536014)(38610400001)(76116006)(586005)(66946007)(66556008)(66476007)(64756008)(66446008)(498600001)(5660300002)(86362001)(2906002)(6916009)(122000001)(38100700002)(186003)(83380400001)(9686003)(8676002)(8936002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VsL0rSu89J1PkpGTyDciT8CQA/P/m7Y0qQjzwP9z1P+NWgjB+2r9RPVAGKzQ?=
 =?us-ascii?Q?viG9AjldK/midb9E53WgjURiNK0SeuP4p116oNjZ/xyUmRyb9vTS0PIHuoWm?=
 =?us-ascii?Q?JD03d0PZl2WF/FNFKEOzH3sbxHn2I3pePDbVOgipc6+tmE3DE84e/0nTGlq+?=
 =?us-ascii?Q?RVjBkujPzvBzjEDvyfHN33zi8n9+XqNX74aNutEKtcmQqSG/qouVuAxzTVgJ?=
 =?us-ascii?Q?1BoifWIMd7NDv1Yw7sti+NNN4mvP/ZDwH/WR/RJOV1apxKqfsHGymSFAo1dB?=
 =?us-ascii?Q?MqmBqUM5v6o/195Jj/ROQcqTkPXbWut9wiIIL2Xp3ec9W7LvxO3Kx3rFwD1Y?=
 =?us-ascii?Q?+OAsmTFVDwlcVHRqJPdcuVF5OrBlE/RpW6xmOESn7TizVHOZTMoTBqVHjHnr?=
 =?us-ascii?Q?EO4FPZ/pjdANXjH13P4WEQy5TtZyBljijlwfPjv+7rwFIliBUVtsyQfwly7L?=
 =?us-ascii?Q?2Wo3PtLrA+UfXLOCMoMnSKLiifIEZtymSwORRgO4hc+DkXzLZbrH9aGo5KHU?=
 =?us-ascii?Q?D5wp0heIYb8EJWjuErwgNn+fW5LdYqlDUXhJ/tHHXF4bNBy8aTWQ4jj0akM8?=
 =?us-ascii?Q?sdEpgdXLCJ7gN2eUrp/ZsbXlkVr36RsnbhFgO+yS0a/711sU8WISLTBPh5d2?=
 =?us-ascii?Q?vWZRieccWoIXIoyQXz78pkhHM3Co4whBERp2SQMNOPDhxGXrzNoAIkYhcLKH?=
 =?us-ascii?Q?a3MuVgwlpjv1FKSlG9AKAQQ4vKAvPGeP23dINdCWbjhM4Gbfs74upxvPYAaV?=
 =?us-ascii?Q?yB55MY7TnOqSiAz9fFRz13D4TNqt4HBL57jLktcrwLL6/EsdLKqog+995vdJ?=
 =?us-ascii?Q?RN0zQuCYzKz33BSv79/g96ua6S3WCZ1AzD+pKoUzgXz+uIT2D4rnANSxlIrz?=
 =?us-ascii?Q?Sqc/OiEiEkTIelLCvJq6RMQaJ9eVYHieMqoIV1g1AoaqqPSyztXHPHYgz2GF?=
 =?us-ascii?Q?fqLgKLuvyc4zJYIesxzJvHu5ilTx3I+ZSTpSCQnXRQS1Vi7oNtfJdCL1b4c2?=
 =?us-ascii?Q?ufsTLA+utSeT4e8Key2uEhqf/+sjvXAiDIu/KPL+nme/XH+rYrHFftXItUtZ?=
 =?us-ascii?Q?+aHZ/LCO7jw+IVZDADpaU+ynWLOn3U0Jv3fhfTpXtzoQqeDmGWJnt1xPUify?=
 =?us-ascii?Q?sYxP2Vw8xj3iCr9bsyq9k2MEWtIOj4EtWj2Mrq6YLdOAGveE9UYkFiezLQJW?=
 =?us-ascii?Q?syhRsNQKrJv13OaRMCgzS4K1L1rxWQD/KWXKPKACBawA5S21AZepT+Kk7WYR?=
 =?us-ascii?Q?AoCGgvOu+IQTLjJJ4PX2sDslgk0BjRS5KQP3RpkmaEInMjTxA6DdOOQ5B39Z?=
 =?us-ascii?Q?jEu0BTbig4cZCGhGHfsfzvsoALddn2rOEBT3xNvbL5TupiBOH+3M0jQ8P7By?=
 =?us-ascii?Q?DilYFYg=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: onlineschubla.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8801fba8-41d9-464f-9fb4-08d908f11757
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 20:23:02.0996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bfc8b046-4d00-4e98-8679-43c06bdec9db
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zV5fad13dn2IQSfqRObS+H+nNyHSpERBHyDZD2WtRehaNCrF5oA7yCjZYXaIU3igJvOp3NNJRSzZIpheMKPstA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB0517
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Von: Roman Mamedov <rm@romanrm.net>
> Gesendet: Samstag, 10. April 2021 16:49
> 
> On Sat, 10 Apr 2021 13:38:57 +0000
> Paul Leiber <paul@onlineschubla.de> wrote:
> 
> > d) Perhaps the complete BTRFS setup (Xen, VMs, pass through the
> partition, Samba share) is flawed?
> 
> I kept reading and reading to find where you say you unmounted in on the
> host,
> and then... :)
> 
> > e) Perhaps it is wrong to mount the BTRFS root first in the Dom0 and then
> accessing the subvolumes in the DomU?
> 
> Absolutely O.o
> 
> Subvolumes are very much like directories, not any kind of subpartitions.
> 
> Imagine you'd try to use the same ext4 from the host and from a VM guest,
> saying "but they both store their data in separate folders!"

I just wanted to give a short feedback. About two weeks ago, I did a clean install of the btrfs and since then paid attention to not mounting it (or subvolumes) twice at the same time in host and guest. I did regular checks, and so far, there are no issues with the file system whatsoever. Thank you very much for pointing out my error to me!

Best regards,

Paul
