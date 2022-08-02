Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB6558801F
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 18:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiHBQSO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 12:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbiHBQSA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 12:18:00 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEFDF0E
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 09:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659457067; x=1690993067;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=DqkjrdlvyXY7+3rUsdDKg2h4qTENoQDJ+azZoqmJWPc7+GsFXRxCNtYm
   sA0piM+L2WWorTv2f4dWK29WCdQxRDkw0nKA9V6tP5TEribeXa2UitpQn
   ljJCJEHpYRac69Dn8NZqHvTg8YfMQfQWFCweIHzFff9neNTeTCS12fua8
   hnzUAWSWK//Arkjsv6nI1MTXiPGMa4cswvzj07y4bTtsRGo4hlakgfR34
   myyrvF710L0KZkvbdIkgWUox5LNrlKzBZW24QkqF4xPxrK2wizK065M1b
   5NNK+hoVdx7x4HoSpH3e/YY8XJUtdzGjyGcjb69iR8/Yclr4Vnp2h1aXv
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,211,1654531200"; 
   d="scan'208";a="319698038"
Received: from mail-bn8nam04lp2049.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.49])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2022 00:17:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LH1rQrth2OvKOuS3KauixPcMzulgku2VXuxOSItWXXDwiYsY1yswpgtpKSz+whsmUyjqHB1WwX9/18o0iU8R/6Ge1fDf/CDh8Omo0RZPIpBEDOrEHHIJee/kAdkGEjI1fyYUHEdz7NdQ1YDrV2m3IEuZLa5Ee6AlHAp4t3ZwuzW2Q1XoObuZdp/ZR1i+6BSiEp6VFOswZqNHTeRmgEn1vr5xWkTncpDPL8xDhrnUYvstPcHA/i3Tbi8pkHSy2z3fMQySNKp4/tIUzGicTtNds0w3Tos5FbuZ6alLP0r0Up0eSa+K13KLXFO8aMjGk+IqKl7GEkBsmu/u+TuO4XBdVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=RKhw01Gh9X36KbJH6Crlp2TrtpIz40WYbvRnbkWomBwbjs1QVPyv8MpMMmZPQIUWn6Jge0xWuScIkUyWGeX7D7UG4n9RWaxymBk3uooYcrQPRGz2cOJdl52a2pjE7T2Cd2ZSdi+DYt2Nyx9oJQRT9t3W13yX0V/rkDgUSfVMIgzsDHcKTrM3HED1+KWecOah1q3CAIbcYvmn6PaElrJfis/mAt72eYoQ1d6VqIY/lXFdGQrrIq0ReP6C2U4EaGaA2uweqjEi2QcvXVxxxUSpu8FN2J5BTTSkGqFDlruF43T6Ty5Agynm9JMYTYPy8aFMZL4kbbctuKXW07iF9zDriQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Go5wIda9Gh8U4/DZNyxigEigIsYF4RNauvT6Exox9e9AwEHaKk2tcp3S/cdgFQqGVSHTrjJYGnq4U6L1pSfzj6Rby/qb4BU6yLRDSAGkv7PNbf1Kpxhiz2L+vpV9K0E79p/7joH5P0NoAiVsxH8N+RxBrp63zKUMXOH0W+3qYDM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB5990.namprd04.prod.outlook.com (2603:10b6:a03:e3::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 16:17:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%9]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 16:17:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: sysfs: use sysfs_streq for string matching
Thread-Topic: [PATCH] btrfs: sysfs: use sysfs_streq for string matching
Thread-Index: AQHYpncE46Zpud9uGUm1hLedTx8EBg==
Date:   Tue, 2 Aug 2022 16:17:43 +0000
Message-ID: <PH0PR04MB74167A82718CF7B4124A5F9E9B9D9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220802134628.3464-1-dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07b0f68a-fa81-42ac-413c-08da74a287e9
x-ms-traffictypediagnostic: BYAPR04MB5990:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BqkovizXh9RIjEcg3QevgLbuEsynlC7Gd12NzOrNr60/DnkXfwkMA4oTRdLibjgLywvFCexlXlUOP37H7XKdnjkKNHe8yKA3avYVrX0jVEvxYNL/nITQKCiRlT9Y3ekVa3HfWTB9qGep2b3XPWnrvZxV4d7JPUdMocDXZ6DXKHuy5ox9Nv/dc+9ZyztfQPaBG0Zy4BEnr1dkM5vKPXCQM9ObD52rrGSGPux095kyNWRnVqoIby+St5zfCYyA2WL5WB7ojl7rYvKKqfZnTWzw3GW+8uRZxHnoPigQiGqgxI1lSE4LxtyhTllPzrrZ9LDrCjaNQkXHjHn0shcL7EillcEI8m4CbjiOVF9nVQrHbuRXM7lItKF0Ba5V99mYkqtqO0T+qb7/o1ePth7WOPmnlqrCOCMrecfMvnKeF9HQI/nDdwl35eUqh3BCLWybFkXDPgtoWVznq1Of9d1Q0tkz0mqJv+PGhvZoWow2YmnciVYbrr2KARI3En56NLhy2kARCySDlybszrxHcsfuz8rJ260oi6W8FRamtNPVmIeqnd4SdgRYiy/qafwLu93u+iB2FE26LfrWUMOZ6VqW2we3E/qRrpOfNMU6w5o2ZtI9PigCrk1OhfYFuT66HHS7+VbQwKGQtQ487nOLYo3wvnaZDk+/w+fOuMGlvXembClOhBZnYxTb4L6i+GigkNI6VxgOIyVvGhXf6j2E/RE9vY3dGYiMj8aJM9Wz4JS2N9LYzoUP3FByGjWvFnPI3L4vq6IkPdt+gQ8aRu9d8zagx9XpuZ73jo6TWFdKJqkVlAVuJe7BkL+k8cpfjKjLTY9yq4lM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(19618925003)(186003)(64756008)(8936002)(52536014)(66556008)(66476007)(8676002)(5660300002)(33656002)(91956017)(76116006)(66446008)(66946007)(2906002)(558084003)(55016003)(478600001)(110136005)(86362001)(6506007)(4270600006)(7696005)(41300700001)(9686003)(38070700005)(38100700002)(122000001)(71200400001)(82960400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tR++xTS+OuJvttczX8dofhnYg+jq1bjh0PoJ7xwRc9b3ey5u7gdtErV9i7Ee?=
 =?us-ascii?Q?JvpkCoEQ/l4XmB8DE5z/PMvA41I8VLvNCY0ilQkagKkTLlxPkFJKeqMePE7n?=
 =?us-ascii?Q?dLXR/c8K/Vji1mW7BGBqqgz/ZYcf+ampD8YAsfmzSdAFHtrHfqKlForHQrNh?=
 =?us-ascii?Q?DDPBbdTFqEVRStQwT2gJNRnHepoQ4JA8a9/OqItIlhuuhseUsjLOLECl4SPf?=
 =?us-ascii?Q?8U8jCpfcqooxM63+atwYRm2Tr4Gg0AObYBwiLzUi0nNdCviTZnFTFciBz5f2?=
 =?us-ascii?Q?sAP8Lom+AMRUFQfYm+iHzQ942cRIvrDnrgoj8Ugqq38VVZEDjFRXogo2bdAy?=
 =?us-ascii?Q?HYZzeJOU9/aa4qPiia9Cs9EvVYYI3jc+b7AvCPqFzZKyDXORPmP8Xd4GCCV7?=
 =?us-ascii?Q?Gs2Ehw7ucm6b5SdJ1+yrpW29Ij1smB2IsASoe2FYppGnyD7GSDGB8veek4lu?=
 =?us-ascii?Q?ryuKhOg4OsifGrireky3jf/bGNuHXgYkgDrua06MzanWw3RG7hWvT4Pa4uLE?=
 =?us-ascii?Q?LVEsxqAE4+O3vFlsOGU4ZH+9LhYMsGwKdJlqc9cXisGHDSHf4h2M5KJff3+R?=
 =?us-ascii?Q?7TzW9DVI/nkC/C4JrFEtNZU8ZmXxjeOUvA9xYB1v+PJKgRArxAqBq+/2oDm+?=
 =?us-ascii?Q?igdcIOkhTZC6xDBfr358HpH8uQT/v2L/vu5/VNdRCltLlTcI6dAJi3ck6hAP?=
 =?us-ascii?Q?VEVTmxrHueEvpQQT2kg6i2btm3AWwd/su3s7xlBHkDuP4zrfdGNHsJHBPQJE?=
 =?us-ascii?Q?iUIpikeMxycHNIATOoNTSvxD9Oek63ThPSFcmFAwMfMJr9yfBO9Ndh+fhgOR?=
 =?us-ascii?Q?KQni4/dKZB1O2JJu/2vfsito7BsPBB9z6PX1ax5wI0PFnbxrFvE8zWuOsmnT?=
 =?us-ascii?Q?dqe3iONh1G6jvTD4lxOqIy+4FaTim3jUQVl9iF7a9rK+RvPIbkcR9wZPVoik?=
 =?us-ascii?Q?nw5wknqNWxtU1Pw+jKKm3VvuipKgRot9vQUwjslrVohzQyw9VX3XvRaD0jWc?=
 =?us-ascii?Q?HopkWKA9i2r+m9oCYgXiP6UpCZFmPXJ+kfgdb1l9M94Kg+h3LbDw1f+1PBDX?=
 =?us-ascii?Q?J2mpltIg92r6GTd/0di/g9Cyq1KEHJMyHxYnXmFcn1+wrDguYIxG+plxScIh?=
 =?us-ascii?Q?1iRla4Yr1XKE566DnXLTIsOLOyi77mAoqfNqlBlN0C+Hl+0BXskGGyHpO2q9?=
 =?us-ascii?Q?1u3Z3D0stRnn/m0/yU9acmYnBofK0XdhwihlDhzO4889A9w6Pf8AHDHp221T?=
 =?us-ascii?Q?5G4PmLFQ/E5VzVMVXDjeBblv1byDr8BTYTMc2HJH4gFzSOxZQZtIfvMblAGt?=
 =?us-ascii?Q?W+rq8LkxOqW8pF4t1cFFejBGK5AoVervTnlVH1SNj/EI6E2zyrz2ET8kXSCn?=
 =?us-ascii?Q?UZh0v+CEBDdJ2WkyDi8YEcjgyHJfEKcqmdIjMmKt2oCHJY/SWLfvXnHiqu16?=
 =?us-ascii?Q?3HMZJmSx/8yuZmvbcs/rARfNeJ2ud2/uNxiKxm7YtzbU9a0PNQIHTATKPR2u?=
 =?us-ascii?Q?53yxt6L40PZjZ0vjz598r7n2zhmccYM8C2xRoQYOPceQbE0h1vdnXKzb3mMO?=
 =?us-ascii?Q?dIGoxzlvfFWTeGjtqnt6maQqJT3fzg8X4Po6/gtBtljcN357Qif+qQN6hWyo?=
 =?us-ascii?Q?Q/wsh0VfJd8AU1oqJF+6hWYfjcooqfU6WXT9M4LZfwEzZyjuDqcn3n4UDn0I?=
 =?us-ascii?Q?bieuJ6xBNKW07lGAUgIbY5u0QyE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b0f68a-fa81-42ac-413c-08da74a287e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 16:17:43.9612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GUKbxhmJhMWXtL8L3lfh325L/1VZc8Iy2xuzpmR3CiNcEsld3j4AuVBqaYSnZ5XwYPUYmQQDGkMa5jAbQog4YJBwrDdvOmVJ8QuFvbBf1xY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5990
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
