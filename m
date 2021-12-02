Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEC6466C17
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 23:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245266AbhLBW3S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 17:29:18 -0500
Received: from mail-dm6nam11on2138.outbound.protection.outlook.com ([40.107.223.138]:9985
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234846AbhLBW3S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Dec 2021 17:29:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6tIK0HXuYOdvuK5a+D0fu5ksE2ytOGfCfrtxgHFfCUH3OGMBU5oxYeJVR50yzVaxauy8rjdr0ZMP2KyDU2G7uoMP0cX77mFRNjH9U25F/dWDLboRV57DsuBI1MSCwYx55pN7qmY3MKclFdEXpayDc34UfGMRm79GoL86+N2z9KiR7BEh6TGA9QCq71cpciTyeEGyseZLH1q7s56LE2SCxzk0C8X2boNBDOv3yPTnM5soGANw04wuD5AnnegqJJITS+WkvSYmcP0n6Ko2ac+v84a9nCSy8fqMKnyqpVCwIkryn+jz/TZHOntDnv0SAd8vZ9BP9Z27MLiGDWQtWpDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ob8XEF4tGTou63uJKWZMrMzbIpWp5EstDETiG1Yoyqk=;
 b=RxTWMoKK1ghD08HSoutsAwOCWQrcSmcIoyYSwjPvnH/7zsMwnzfeuaqEvfZpLVDSs0dNLambm4/Ie6D+2cuvaA2s1Mez6RtumV/2RdxWa2y/zkzIietsF5/5xg6D5FW0K/PuhgSRz9YggPaR85fjXRjmQ9MD1OaddBSws34pWqFjus735aeaRtzBZgipeCJvDvyOAgtA8xgLCgLiOD9tzukEW1q264hXvXRs9+TpN4q2l1bPhvhjPZDTwm/PMg6oOXx9juYGvqB6JgJP6aJawvxDy7fKlm6of8HbEYfLtLM2EhJGclapRTFOz5d7BWc93Cx7S7bKwT7rXAETG9lMCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rollins.edu; dmarc=pass action=none header.from=rollins.edu;
 dkim=pass header.d=rollins.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rollins.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ob8XEF4tGTou63uJKWZMrMzbIpWp5EstDETiG1Yoyqk=;
 b=RE8Zb/moC3ONsK0sihdu7zyl4QLr33LJKiQU7aUTPlGAR+R3SS3lMTLfV/VjpwZ59eObrt8ul6nsjvM5WtZ+ASlaKcqrG00Y48yHINakrdifvKvBp5ecWGXAVRFxV+BDSQdsSN81ZhhkPoEeOLQIlBVlSxXyPrgeuji8IseZyek=
Received: from DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:32::12) by
 DM8P220MB0406.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:37::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Thu, 2 Dec 2021 22:25:53 +0000
Received: from DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7488:5485:739b:c303]) by DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7488:5485:739b:c303%9]) with mapi id 15.20.4734.028; Thu, 2 Dec 2021
 22:25:53 +0000
From:   Charlie Lin <CLIN@Rollins.edu>
To:     "rm@romanrm.net" <rm@romanrm.net>
CC:     Charlie Lin <CLIN@Rollins.edu>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Unable to Mount Btrfs Partition used on Both Funtoo and Windows
Thread-Topic: Unable to Mount Btrfs Partition used on Both Funtoo and Windows
Thread-Index: AQHX58t5+GVppLc5S0ePxfaVV1jvJQ==
Date:   Thu, 2 Dec 2021 22:25:53 +0000
Message-ID: <DM8P220MB0342912966C295206FF80725C1699@DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: bfd8008f-29d8-9c06-6f69-4bf250eeec80
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Rollins.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ad9abf1-e961-42ee-bebb-08d9b5e2b3d5
x-ms-traffictypediagnostic: DM8P220MB0406:
x-microsoft-antispam-prvs: <DM8P220MB040607FBDBE0123EFD52E80CC1699@DM8P220MB0406.NAMP220.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ObRX1K9fewyCwL05aQR0hMtC/dJr2oqu/3gMxU+cK6G4coE2CcKLaqXoCv33sldGhX8iGDGjn02pTwMlaQh+hFknCUWPQjd5rkMlUdrFa1yuOQwRJ6GGfThT3+52xM4ELW7H0ulI1O/Vk0+Lkm+9b8ICCeQPxdv7fWjvEuwWpEgxD+UTCgRqZTNPTV/NMAYR/2vVvB5ZqHjHkIcVgxXBU7Ep1HO+Vz9OU+Ixxp4YEyOYZet2RbvX5wIRZ3r9XmgF8mGk9uCSH2kauS/qWVyxo7FXLIU5YJtnEs1t7ofnZcW/Cdfjh+CqybWYaKd0HaqY0wNAd2h3TFq1SkQSFr/qBvOhTzsf7b+XvG9kOPoChXAle3dDCipWK5LI0ezs4fylhF1O/4xiYolI4ckXAAiz252ZDDoMZrEFMXk92fKhplqJ8JWgvS8ZwDwQ2fVnYYPqTI7cvdG+g6nRNDUsY14Wrx6M9mh3ACh+OoYUKvwDkHkehfsCtGptaLRE2yGqSr3APaFeW6sjGwtcjRvc1LqzWKH/Ipn6v0NVRHutk5Rs6d+nU+MmOZ3lEiR6RdkxQUqzDoU0cJf0D5Ie7IWMM71XMEA6MoI0wd/xy76thNOY4YI3AqIkzmDhp2cDS67DeKTIQRUgbZXUYY+XVkvyFJYZyY6soRamSXZr3GPEk49WAcqnjOrGQVxTQvsOl3nSyH0l7j5vBtD/D0pCdYkD1xKPwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(4326008)(86362001)(6506007)(8676002)(316002)(122000001)(4744005)(71200400001)(7696005)(786003)(52536014)(91956017)(66446008)(75432002)(9686003)(66946007)(66476007)(64756008)(76116006)(66556008)(186003)(2906002)(508600001)(26005)(38100700002)(5660300002)(8936002)(55016003)(38070700005)(83380400001)(33656002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?P9RyfNX0b2s5XI1e9smcUU0N4zsiK9suInklwoiIbhhjXjEjuIM73csyW6?=
 =?iso-8859-1?Q?Fhcpl/1guoqbMohuKlCZoPRbtCrULAiWG+R4Pn1+h+7OTJ4P267xDEHOk3?=
 =?iso-8859-1?Q?wX36Xd96dO0JN1MtJmetYMK28y41eYOf6B3JBvOsNtzTSXOnpWNYvaTTeW?=
 =?iso-8859-1?Q?/dv/5iBd4PQ0fNkH7yTcTW0m0JkyvDEs7v5G9XRSMSSjzrmK3M44em0v8w?=
 =?iso-8859-1?Q?0as9C/K82lz7exXzI7H4LAsZWFqcE96J3AiEG0SePdImwIq1uvVLoaFBxf?=
 =?iso-8859-1?Q?Vo2XEVyuH6AXoU+yuZI/6iPm+Nby5sWyvoYYJZC3CpSksqOgYmQ0KmD2Fj?=
 =?iso-8859-1?Q?h3jRIDtnNnsgcNwMzzAJPdJGBhippBS8Jli6Fyvb6EHfKzqsxPFTolXAAj?=
 =?iso-8859-1?Q?qf3zWAJhqCh438CMx+HmHl6pqnQZuRa5BIFKa6Y6ZhkRFFPvM8t2SgWO2t?=
 =?iso-8859-1?Q?DVEYj+AX0tINEPsLDY6Ud2MLKRk/e3BQQgxon2XPlT5JkbPfUlUwKOBgZr?=
 =?iso-8859-1?Q?m64RhiCna6S3BWpX+obXHgkwuuJK3DWwUoHYDxgbv/jnyI6XDFfqTaYfRc?=
 =?iso-8859-1?Q?8pJcPygwlPSp4MEpVKyxNHtJaGvDfC4fujSrQ1fN9+VQIRkaaMBCWLy7jL?=
 =?iso-8859-1?Q?KPsYYg5N9yUwPydfU8Xrca9bd1HnZM55Md75XuZa6tYv01tsZRoDVWAQpu?=
 =?iso-8859-1?Q?XF6glF1QQ3Nj2pLu7YGV0Q7v9HtQnnyeTW9HixUH/AiXlh9Oxo/T3pj9Yw?=
 =?iso-8859-1?Q?mHDqL4DVZaE/MSMDuyqMJGKk0m5GW5C3EHRSISokPEe9lhPIksYuwXBoV8?=
 =?iso-8859-1?Q?jnz6X/e30WPbWcf8Jb0rDLX0HofDU2stu68fw4Sxi7L4oR30+XOWYIGNJx?=
 =?iso-8859-1?Q?tYBDr9zEoJjoW/TUFhkNCBEdPeuRr+KKNY7X508hQoq/Ae4QuA5eVCieG0?=
 =?iso-8859-1?Q?wykyGWcCGIo+Y1CBcuvO1CdEv7XbLDCqUeoAV5AsXislk7hJhj/YWhswfv?=
 =?iso-8859-1?Q?ptOI6o947aa8zOn2pJ1V8ZZ9IR/j1bBwU2EZlIOLwD2FUoWELZd7DEGgEc?=
 =?iso-8859-1?Q?y+bFH2+QNaNxE3qBrh98UKH9IAJ7N48OScDo5sEnM7L90Dpte9Im/ANhKi?=
 =?iso-8859-1?Q?P0WzIiicjpptYYcGEuUSmNbl/08TTr7shwbOGp4jbJlSwFGWS6hNYaYH1q?=
 =?iso-8859-1?Q?BUiz36pZksendjSufavfnijFZFl13XyNo2yndoMBlyeDsUjUNi2hNkXoaP?=
 =?iso-8859-1?Q?gLzWQOh3+09+Ia8zPblyzkmAkXvl7pE7avy6/j4MiMQUhh1T/pKZwqTt/1?=
 =?iso-8859-1?Q?/amXw73jgX8UUyEnpZrIcp2rNEJHpR4M191JL5VBsP7yOCzIoSMXz8PSSz?=
 =?iso-8859-1?Q?30Cs2CRl5dUIyrsJu0Qoeuh5yVXqw+69+sEd8dOl7nObtsPE8EQA8z9bgR?=
 =?iso-8859-1?Q?2EwmzxR0BXaLcssutOQNH/1M/l0NGm8Ka+qlq84ZRaoAXCWC/GI+QYkl+g?=
 =?iso-8859-1?Q?U5P5zGmZ/aeQ0xKO5vxt+DGgAy+yAwW33KDxay54IOk3VXJCD2uLJhZSAG?=
 =?iso-8859-1?Q?1HcpRvyuThssPcCP9ljSHsKQfw3qXEDbl3F9m3vZ7Ysg0c88FaA0hJl7RQ?=
 =?iso-8859-1?Q?/2QLRQUHkEMOs1CI8/QcaHhNLROoEgiXW4qjtrdLvJM6fqSG3Fth0+Bw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: rollins.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad9abf1-e961-42ee-bebb-08d9b5e2b3d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 22:25:53.3334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b8e8d71a-947d-41dd-81dd-8401dcc51007
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zbvzu8tHD65/Lu3CKfZzVYoiTyE0/erqQbpy+FtUB8TTTtfH7sFm3pNzmPZtcEiuSWYBn1/f6EJiOrCOfLKVbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8P220MB0406
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

=0A=
I'm actually dual-booting both systems on my laptop ie (Funtoo's kernel and=
 initramfs are on the same EFI system partition that Windows uses)=0A=
=0A=
Admittedly, I configured Windows to mount those Btrfs partitions at startup=
, and for both OSes to be able to hibernate, so that I can access the affec=
ted partition by hibernating one OS then resuming on the other. This worked=
 well for about three weeks.=0A=
=0A=
Anyway, are there commands to try to recover /dev/nvme0n1p{6,8}?=
