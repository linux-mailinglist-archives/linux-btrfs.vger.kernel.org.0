Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756FF529B38
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 09:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241860AbiEQHmD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 03:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242805AbiEQHlg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 03:41:36 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51671C1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 00:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652773293; x=1684309293;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xkxsIlh9eqQ5IGDXzS3sBqg+RK6BFe2eV1oluXL+6S4=;
  b=k/tBm9/BK4t9ucb+AYU972v5KwduolNATUFmE54iTH4RFzpWmMjwlHkw
   igW2s8gilOWlIehKHbwfLhXDkPOWVCWXTfp3ccyJXaZbPt2yU1NMTUcbv
   KBRWRBu8XCzh7ovFl3+Vg4hkn4cQC1w4UeI+4R+l77L8ZmHsawYQDkJ7c
   amHi/qt9dmxKGDHBG80DYh9iYzAvnCIhAtCHLzfLiyAADXGfW9fg9BIR8
   /OmP6sie3GfxZtnc+iH9SU7HcI/Yy76ax61H4i8+lpU4UXricvIH3Aoo7
   ZaWuBlYQX70Wbrr6uhFKJlBe9DIKLJs8/9r06nVAo+4tU/CsKoWhDXIkg
   g==;
X-IronPort-AV: E=Sophos;i="5.91,232,1647273600"; 
   d="scan'208";a="205399943"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 15:41:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbS3iIal1lE4BmJab4PBKdYERpYDAWQIaVr/iWnSYPeGghjc71GNsNUsUW5CbJV+KrdQ0mjINNEumZ02/VBYg2x0442MSNf4YyZcKLVcuJOJwUa0w0eyPAxG61oKM2EJnmzDJLvCaLqfOvIBzzPaFxFu33RVvPTGpfrX1NNSlhO3WvAS1ERPBYXgN51BEX/zrptVVw19Xr7yN68mqj+5wvYXM18DKp0LAf1jCzyK9FvBs6nfYcj2VnsIt6wrFyGr+4Nj8x36U908U/7rqmF5USHB1xQ8TpR/PJy2KTcuI2bVWhV98+aoar0brd0XwxuYfU5i+ft3IkFPvcqlltkAYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLlVJqcWPFT8KTq0hSkSUeIvh4U0zq7FVSVkaDBykmQ=;
 b=iDC9RpL8PEu5LPlnpUrgYklxj0mRDPJbBJX0E2pov26c366lF2dI1dJevKWImFKKoH9+Pk2R94uDODJ/sluYF3tAdK/TbzH3io2ysoiyj0ch5JfNUxyw5CH92aOLFqf0lVmY92V5wNUB4wn6GEWrCrmR7qedjNTjrOYf1K0Ecx38OlZyB7wQrmXoucTW7xE5pEkZw/XJTShF+SzmZwwR1BApF6k5yHW2rCtOqCjH0keOrg78Rze26pKSQCbVwhkjkyNeMt6NCJqvw9RqBdu/gfOF/IBDlkznPGLrkUcc1cwDsBi9AMSZcSGaXffNH7YqX0GzEg81c9kLJJpLtp6Scg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLlVJqcWPFT8KTq0hSkSUeIvh4U0zq7FVSVkaDBykmQ=;
 b=cQ4kWGe9mfxgCLrjoIbKwm7vyyRvgHITAaHmEb3QA5m0cNxhmTSRaq9h4Dy2ThddHnD22JcLpNXtsWrB5kk4BbLOVXKuq5w1i6hLxM4S5S5Uuy+7LIQ+EVOrsOJ1K/lrPAKilB3hdsHnKeX1rllUv3f19vPIvHwGRXGt9QnNokI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB7131.namprd04.prod.outlook.com (2603:10b6:5:246::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16; Tue, 17 May
 2022 07:41:32 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 07:41:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC ONLY 0/8] btrfs: introduce raid-stripe-tree
Thread-Topic: [RFC ONLY 0/8] btrfs: introduce raid-stripe-tree
Thread-Index: AQHYaTGyNcHorGSGJ0SpCqziAWVW1w==
Date:   Tue, 17 May 2022 07:41:32 +0000
Message-ID: <PH0PR04MB7416D75883472A9B4E33BF1F9BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <64227525-4507-9a04-942c-e081c6550f69@suse.com>
 <27870f8d-0b6d-f2a4-2b69-c2d001dd0855@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 961bce6d-cb88-408f-e995-08da37d8a9d1
x-ms-traffictypediagnostic: DM6PR04MB7131:EE_
x-microsoft-antispam-prvs: <DM6PR04MB71311E764FCB1D9F92F31F299BCE9@DM6PR04MB7131.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FI7J2ydg4maQinDqNEyW0e3aTMMDci4fXWPxRV739tRO4DCzKkM2bL6bsKzj6Sinm94gnVfzfweniCdSL/XLVSET5bDxmChcVW15QfEvyTqeTCH7vSjaWf9W/077RaJUjc4ZIZWPNwkGPjy0Nhj7tdDNFj6UYTcZL4VijzIsV6aRLoyeltqZ3kcjgaus8/3huvnsFG0X4Yp2kl+g2y3Q90mcSkrC6B8BGw8MBXbPQQAejX2bjF+yfZsuz0hlqohxfHAoDVrP41KSmhjKKRH0scnRRmxI/NYSH5VaykXVeV3DXwLICKfyhp2hxXZZ82N5fxySDg9j1ZxmjCt/Zx68+Cr+R6YqD9mmtyuqUeJOphBG/XRqtDUlZrpTzBBcTBbMzlkb3tShnnYFJHVRr5Lxo3iTf9b/C0F22nj6BQIM3Kq2eR0AH0UFK6HzLhuUPDRNR48IX/QSD5p0Ei2xHSmSUPGkzrM5nVO5DMqtKwaCNJwukatYZYJPVf3odJ442AANhJGaDnyF7437w9TAd+YBxE0CHTOJyCmAqLW5By25N9q7RLobp3+oGxjHmNaqPBPVmmJFIoIYcPtcI5SAfYFykrdwTpqRzYGiT9bsOo0BHSIqhE3FGRYtk1ObPiS5zHK1YcCx5wYK+9mtBtt0qDVpeAxnBOcimt+vy18lUWwubRYUPB0PXshA4g2qNA+8KicJc8Wm29CVyv78RN7LN3E4RQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(122000001)(38100700002)(9686003)(38070700005)(82960400001)(186003)(316002)(110136005)(83380400001)(86362001)(7696005)(33656002)(71200400001)(508600001)(91956017)(52536014)(66946007)(76116006)(66556008)(66476007)(64756008)(66446008)(8676002)(5660300002)(8936002)(6506007)(53546011)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?zXpOnelM9cBmzO71T/NHJcEzp8FEn0Lc7mFEvHrqoS7bP92zFa3ZItaqtSXb2/?=
 =?koi8-r?Q?WLNtmBwnyl81FREJXLvjy0TjqeWf5OsWNB2oodAJyk+z8OKz2gfpHNlf4wT908?=
 =?koi8-r?Q?CwBeq9z597JmaPbIdj751wlyOtojI6KXMQWu0gIwPQHMPyqkRT5qoYiE/q68H/?=
 =?koi8-r?Q?irE8rj+lijFBPwSgM0jp4KoDBtMMrhuq8SBDIIDSzfsRnXN2wmggWHgIiTsoow?=
 =?koi8-r?Q?t13HtVtAa4TodVjXtflkSqDdSNN5nRbcloW6dcEVH0DZXMm+sqSZGAZoWPPt7/?=
 =?koi8-r?Q?9jTLsinRHfSSuTaYOHah0D+vcjZNEtfOWqclhjViPrK5v+JdsNQEnHeI85Exya?=
 =?koi8-r?Q?g2AFcEWpqI9QMpNfphf4EFs2Kf8dz1JsO0w7Kh9A5cyI38ZEqOKQPeieJSFYJK?=
 =?koi8-r?Q?jXZ51ymdqIoRc8bjQhNGt3ZI3DouxrQXrefmrBKpoSxd5flYC6kDG57xDU+Aiv?=
 =?koi8-r?Q?1cErv69Cy2MwuV3/BC4Ojb4sb3GPUvkx9JyZeMpRFm9uBfBZzgxSInm59CJZzN?=
 =?koi8-r?Q?Ot5p9bImJJFNFLL45paK+bOaQTfqLxsiOFPTQxgWlB6EJq3C/cVW17vIPY24Nf?=
 =?koi8-r?Q?BZ2jDlzAsTgA+jk4Sht83p94g+hFfQyoTrhf7e8AiRuCNqFf32HI9jGNgB8n//?=
 =?koi8-r?Q?00oKci1eG/+YEkez/avKmWxvTEuH/WaEtQ+p4OHcvU/9fGOybh4o3/xsvfIgF9?=
 =?koi8-r?Q?I5MRDEFihdeAbeKG8a2Ezoov4VZB5BvNp6sbSHyzSmf7WnHWt9TaYl2mjMvUJN?=
 =?koi8-r?Q?97a8g+tKdnoWWU3kLsCHvs9TCp3oCwA+cwCqOhYCWHlGn9XiW7ITRLEZm7HsXH?=
 =?koi8-r?Q?/pHVLHd8DKCq8ft1tQm2S7qhFe1xsyksRCaA8xJGdeSlIOvJbkb9QYy94GqFh6?=
 =?koi8-r?Q?GPzjAw0T4fW6i32YL/EGBacMReYX8iKVzkszi74C8DWwaX2F85UeykHlMoeR3t?=
 =?koi8-r?Q?3kezZxMTb2UYlr3ilbcW6JlQKBXJsjwPB8y90MOTTl01a1EG7nCoze0q2DbeTv?=
 =?koi8-r?Q?dg1BBuokfE1IQz3qsvHpGzgcVF4wRLr/MTpYkVRpvAw6rTDMrykL13fmId9oar?=
 =?koi8-r?Q?fPYWdwd4CcB3HW+wvETKdseCIsgVwiXTnyBxgExuMOHrLux7IvtfrZroPy9rO5?=
 =?koi8-r?Q?2V3BQj6Z87UvziFVHJlMj270ytt4CJ0Gca9bgOfJg3ZpwEGb6BJrRosCfUEVhZ?=
 =?koi8-r?Q?+qd+AnKGecwVpL6fXOEf5eECVnA0TYXoyWB/bHDm1mk0qGXIM8h15oPNWVoKEn?=
 =?koi8-r?Q?J7hAJpdOX7VhwbhD5eBCXVoVbMlpCIZk8Nfs9GHU0Yw5hoxcq1OLWEvQ38ZRW4?=
 =?koi8-r?Q?Q1ARZuq4bdmHrdCpmLEso6b5HSsUTrRBe5q/Wv92LvPlbeoZFbpHRRVZIgfiIa?=
 =?koi8-r?Q?ixEtWjigqBowqez35GVSLZBEJiYfGFo0Qab8buw2WiHUL10AeK8KMkUg4zmswf?=
 =?koi8-r?Q?x85j8oXcjzCkhkhJG0yBv1oG7Pys5kFBkNNPPjk+CuB6LVQHExozZLolokmw4S?=
 =?koi8-r?Q?B75pFV+HYqHrxekVkYlJFacMi+7oEHUc8eQN++IchlBXPkQ8bdUnq0k3beLJTk?=
 =?koi8-r?Q?F+aFMJ3mEdHwSzNbBbTxGPIpj5GXPWeiJPJ2sQamRAGTuINJ9KJ7uMmz2szB1R?=
 =?koi8-r?Q?eQNK7+IyBNfQEF8CJSMqH6K4R1bGUzwaD6YJYYkSnCxh+c8muO58WYIhQsOmbk?=
 =?koi8-r?Q?0NxrUwdzgOxExzlVm4SOoRm+qGBjd00Xu4QZssWHpqzeJCfLD/ChIdMeLcAcOQ?=
 =?koi8-r?Q?UF?=
x-ms-exchange-antispam-messagedata-1: SiZAzf+1YaKDO/1GDQoWE/Nt8ci+jL5O6iVhF0nxu8LsYhuHrzaWLhYy
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961bce6d-cb88-408f-e995-08da37d8a9d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 07:41:32.7760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oh4Ed0Tqg4/FZXfzPxKwowD6gFn1Qnh+TA85AZRaytNuBseG7HE3g8gEeRSgKTFtxFNSpiLt47D2P8G11guvi4nN4Wwfy4EEH4bU95mVjfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7131
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/05/2022 09:32, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2022/5/17 15:23, Nikolay Borisov wrote:=0A=
>>=0A=
>>=0A=
>> On 16.05.22 =C7. 17:31 =DE., Johannes Thumshirn wrote:=0A=
>>> Introduce a raid-stripe-tree to record writes in a RAID environment.=0A=
>>>=0A=
>>> In essence this adds another address translation layer between the=0A=
>>> logical=0A=
>>> and the physical addresses in btrfs and is designed to close two gaps.=
=0A=
>>> The=0A=
>>> first is the ominous RAID-write-hole we suffer from with RAID5/6 and th=
e=0A=
>>> second one is the inability of doing RAID with zoned block devices due=
=0A=
>>> to the=0A=
>>> constraints we have with REQ_OP_ZONE_APPEND writes.=0A=
>>>=0A=
>>> Thsi is an RFC/PoC only which just shows how the code will look like=0A=
>>> for a=0A=
>>> zoned RAID1. Its sole purpose is to facilitate design reviews and is no=
t=0A=
>>> intended to be merged yet. Or if merged to be used on an actual=0A=
>>> file-system.=0A=
>>>=0A=
>>> Johannes Thumshirn (8):=0A=
>>> =9A=9A btrfs: add raid stripe tree definitions=0A=
>>> =9A=9A btrfs: move btrfs_io_context to volumes.h=0A=
>>> =9A=9A btrfs: read raid-stripe-tree from disk=0A=
>>> =9A=9A btrfs: add boilerplate code to insert raid extent=0A=
>>> =9A=9A btrfs: add code to delete raid extent=0A=
>>> =9A=9A btrfs: add code to read raid extent=0A=
>>> =9A=9A btrfs: zoned: allow zoned RAID1=0A=
>>> =9A=9A btrfs: add raid stripe tree pretty printer=0A=
>>>=0A=
>>> =9A fs/btrfs/Makefile=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A |=9A=9A=
 2 +-=0A=
>>> =9A fs/btrfs/ctree.c=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A |=9A=
=9A 1 +=0A=
>>> =9A fs/btrfs/ctree.h=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A |=9A =
29 ++++=0A=
>>> =9A fs/btrfs/disk-io.c=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A |=9A 12 +=
+=0A=
>>> =9A fs/btrfs/extent-tree.c=9A=9A=9A=9A=9A=9A=9A=9A=9A |=9A=9A 9 ++=0A=
>>> =9A fs/btrfs/file.c=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A |=
=9A=9A 1 -=0A=
>>> =9A fs/btrfs/print-tree.c=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A |=9A 21 +++=0A=
>>> =9A fs/btrfs/raid-stripe-tree.c=9A=9A=9A=9A | 251 +++++++++++++++++++++=
+++++++++++=0A=
>>> =9A fs/btrfs/raid-stripe-tree.h=9A=9A=9A=9A |=9A 39 +++++=0A=
>>> =9A fs/btrfs/volumes.c=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A |=9A 44 +=
++++-=0A=
>>> =9A fs/btrfs/volumes.h=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A |=9A 93 +=
+++++------=0A=
>>> =9A fs/btrfs/zoned.c=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A |=9A =
39 +++++=0A=
>>> =9A include/uapi/linux/btrfs.h=9A=9A=9A=9A=9A |=9A=9A 1 +=0A=
>>> =9A include/uapi/linux/btrfs_tree.h |=9A 17 +++=0A=
>>> =9A 14 files changed, 509 insertions(+), 50 deletions(-)=0A=
>>> =9A create mode 100644 fs/btrfs/raid-stripe-tree.c=0A=
>>> =9A create mode 100644 fs/btrfs/raid-stripe-tree.h=0A=
>>>=0A=
>>=0A=
>>=0A=
>> So if we choose to go with raid stripe tree this means we won't need the=
=0A=
>> raid56j code that Qu is working on ? So it's important that these two=0A=
>> work streams are synced so we don't duplicate effort, right?=0A=
> =0A=
> I believe the stripe tree is going to change the definition of RAID56.=0A=
> =0A=
> It's no longer strict RAID56, as it doesn't contain the fixed device=0A=
> rotation, thus it's kinda between RAID4 and RAID5.=0A=
=0A=
Well I think it can still contain the device rotation. The stripe tree only=
=0A=
records the on-disk location of each sub-stripe, after it has been written.=
=0A=
The data placement itself doesn't get changed at all. But for this to work,=
=0A=
there's still a lot to do. There's also other plans I have. IIUC btrfs raid=
56=0A=
uses all available drives in a raid set, while raid1,10,0 etc permute the=
=0A=
drives the data is placed. Which is a way better solution IMHO as it reduce=
s=0A=
rebuild stress in case we need to do rebuild. Given we have two digit TB=0A=
drives these days, rebuilds do a lot of IO which can cause more drives fail=
ing=0A=
while rebuilding.=0A=
=0A=
> Personally speaking, I think both features can co-exist, especially the=
=0A=
> raid56 stripe tree may need extra development and review, since the=0A=
> extra translation layer is a completely different monster when comes to=
=0A=
> RAID56.=0A=
> =0A=
> Don't get me wrong, I like stripe-tree too, the only problem is it's=0A=
> just too new, thus we may want a backup plan.=0A=
> =0A=
=0A=
Exactly, as I already wrote to Nikolay, raid56j is for sure the simpler=0A=
solution and some users might even prefer it for this reason.=0A=
=0A=
Byte,=0A=
	Johannes=0A=
