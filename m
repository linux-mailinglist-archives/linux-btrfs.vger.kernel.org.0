Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023CB4E4EFD
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 10:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbiCWJN2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 05:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiCWJN1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 05:13:27 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DA970F67
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648026718; x=1679562718;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rTNdkNa4c6vJhJ1/3niH9d2Ya1xEg7lniNqRlexf+jo=;
  b=nDlArsB+CZKXyE5SlGCP3FBPEfVHUorWO4cgRnImj8S3EABPRK7XphBW
   Tc3LAW4VlO8LXSkDU+/F75uP7KI83MS4XTScjfRLZZCewPrMZ3VBWuFqR
   PYYRacyX1sHFHEMj1gLuo06Bp3LtGdwk642jVpymtsJC6U4AAArmv/+SV
   kPcE+/WLH7/5ASUgWf6qhhjMxp7y/xTWYtGdwkSHF7cOnB5uXunJNar98
   LtITPV5VFw81nU5eGrBdjRZYwy8dnG0H9Roe1azD8RkaHUHG/5DiK4uup
   sWYmPryn6HooZX0rBbQKpwKut8AQcf3CoWgXc1pCF3KPBPWWrwXMeaUEW
   A==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643644800"; 
   d="scan'208";a="300197423"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 17:11:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0euHajPmSzAotVYePBXi7qrxJCCzUao7FOSpDKuOzkOmfqCiEM1gLJIHQ5oT6HjhWCPTxDxvJnAircJcYOsCZkIRn9HRFhZ9tKijC/yDli/IJ5ZphIOVrSWA1xgtA14lxU4+nYUx0SNO8CmCldx5i7DCW59BQ3lJx0bvIqPfG14OYXvDZNoKcZ7TnR7NJtkVs1Am3pS+QUtfP5ngEKUoxj1i8uF815zDZ9nfdE6QzI7Vag6D3iq8CdoU6NDmtd3cIg7Y8tyXuAcF0K9eiItdJ1icNv/KGzyqxiGKXzPg1qp8PEUmTZvZnpLpD/qiJHJWYKayuvFXxuhwdcuXyNO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFwVy8/zaasWf0x8Ly4qyFBrBVvta9JuMduhu3Iwe34=;
 b=dNSP+zNVOzzgaV9AfjOW+CLDBUEN7pxg3UZ+AN+Dr6GncAoRWm6rHHqb2OP5PN2OtwfnKsdtwpGt3lsNcbOM/61zwDH8bgocr9lNHYCw9LageUaQgPKukknEfpBxyZVN2NBlV0+wSMFpNxtOjlU+X/P9/9tpua6O6h0rdczuOtQ2/t8d/94GkQKBYyJeJ7/e1sH4raGB5MBwRHvUWHcte1sOXljd/fjT6Y4HZZA+OaWLGWRwk1hFAV8/V+sGee2aOfr/nT2gkZipB+JtzqkWkqaY98zxd73MMRtszZ0QeazKquaQ2jgDs3guahbVb0ntE1qosDvNzduNK7D0gGoVDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFwVy8/zaasWf0x8Ly4qyFBrBVvta9JuMduhu3Iwe34=;
 b=mr8nbqR9AbBGY2nPKop/mRvoRvcwyjy0lwb++SxsCPgUVdCiCTf9aMsn3B1vucIqVA3tzSNl+f5zrvAkGSSoHf7NMZ+/THiSsYr1dDQ+Iq+ckAVhk7G8vVY8XxJf0mN8Dhz5aR5f560NR33H7KLLciYgMuS2fD4Jc3pRS1ZM6O4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7942.namprd04.prod.outlook.com (2603:10b6:8:1::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.17; Wed, 23 Mar 2022 09:11:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 09:11:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        David Sterba <dsterba@suse.com>
CC:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Javier Gonzalez <javier.gonz@samsung.com>
Subject: Re: [PATCH 5/5] btrfs: zoned: make auto-reclaim less aggressive
Thread-Topic: [PATCH 5/5] btrfs: zoned: make auto-reclaim less aggressive
Thread-Index: AQHYPT7Bez0AiBAkLkKxIm3VhJQQ/Q==
Date:   Wed, 23 Mar 2022 09:11:55 +0000
Message-ID: <PH0PR04MB7416CD1BC88132E22790A1869B189@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1647878642.git.johannes.thumshirn@wdc.com>
 <CGME20220321161435eucas1p28901f03d0533ae246f51a3b96bfc07b4@eucas1p2.samsung.com>
 <89824f8b4ba1ac8f05f74c047333c970049e2815.1647878642.git.johannes.thumshirn@wdc.com>
 <f4e4a70c-0349-fafa-8375-8c4177a3e260@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d79e554a-339f-4eb8-49e4-08da0cad2d27
x-ms-traffictypediagnostic: DM8PR04MB7942:EE_
x-microsoft-antispam-prvs: <DM8PR04MB7942DE142BB6543BED1E63BD9B189@DM8PR04MB7942.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ImuA9Fvx0ceae7hmWospiGUwm9SLwGFrRc1nx/l7UpxK+ogq4uaZsEQLKUvjgRciz9DATByRx7QAg2rkvQ4/VWtDaPBvtx/S9KjDn/IsBVepldx27wEbA+dhR3EqXftEvuk0RY3Yda6hqUoRy1PZ9IZ8oR1s/wCgVZj1nW04jmtD3xsCtkQqmMmQQBPHQwKcEtpij7By6o1RZ4hfLPsFcNLfchu6JomXX3n6zF8aFi+zTPnabxf935KITKzDV1jiGo5oEYFauSXJXkL3apoyPg4c/1NyQy+uDwMZ3K4FhpZLjPnAUZxprK9+HAaDyqnJ2SgaOdSquKkh9uVW4RbOVgClCnN11U791HoQsQ4KDIkwRRSyDvf9uk9X4evxPwIljLKV/YyX7p7yAwj0GD7UvvvIs4+J6mnGPu1MqmBGxgrlSQ4E6sa0lc+UPFvAFqiVickGK7hEDtts0RbNe6HWgrBMr7tH7ay5GYh9uIFKNHksR4BAlzBBhCb/sVkchtvo6aXYw8iifUU72tbIEwlpmruyElpfwv/Ztsjy/dAqJ7HkYnabfmXGaHdtdw7vqLPy5TqUKeFukDU1WK6+JlEsrMO8Yn8gDZ13T2PFBI9EK4OUVDVvF19NcSO3sXnVl/2kS6TeCw3HisORc35pyAg+YvYpdxJuvoxn2MvYKWGDunnvtwbaWepMNHke3cD3ecHeyyEp4AEaM1/PCmVv7R704w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(38100700002)(52536014)(82960400001)(38070700005)(122000001)(508600001)(54906003)(110136005)(4326008)(66446008)(86362001)(66946007)(5660300002)(66556008)(8676002)(66476007)(64756008)(76116006)(91956017)(8936002)(71200400001)(55016003)(2906002)(7696005)(6506007)(186003)(53546011)(33656002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2ktsqcKAqya3KuDbEbB1c0L3wTbijIXAZfmv39I/FFwmSUuDQ+iPJwp8yonh?=
 =?us-ascii?Q?BdqNw72RjZukzaWRdPGaEbgrKdEw382p5fSLqI81/+GX8VkkkTbKKi2yOLU5?=
 =?us-ascii?Q?8tkksV163Pde/yK/ewpTBT/52zhnMU2rMunqyHjdYcMaNnL5LaHaqyLLARBN?=
 =?us-ascii?Q?9JVp191UNIi1rSkwMzdT0dC45xJsWDTly1WK9LhfLzIO3vgMb2dwEgdeOLX4?=
 =?us-ascii?Q?Q16nxZ8EWGPAB+tJxqlaEqC6NYXjnWaFlm91imapqkloZsWZG6aS3yJXVjmV?=
 =?us-ascii?Q?HzVUITyOumJCKWonyh+0rUgfzwCGt5jrf9zJHIgmdIZg7QAhJVRC6CX91hqS?=
 =?us-ascii?Q?8RoDtz9vuEAu2x5B5mrTOgzM1JkOWLjpnCAKRSlobXC9i764g2w/+G49nIq1?=
 =?us-ascii?Q?777tXtQYytEii9+AGuAlIgFIvTbMT+oXpunvGXmsHGtvD0vTqh7E+wUAMLTr?=
 =?us-ascii?Q?g9Iclt/wEdLdMYkCJvi1C9Auc6pwlc/Uua9ocE395T7dD5P9PCzeOkBOxaTt?=
 =?us-ascii?Q?RS4eGg4I1JZNiLDBco8prrY313XxWtFRMOpPWyQsRqvMo/TiaeBvY0dWl0Jg?=
 =?us-ascii?Q?SsiLtUn2omjIbiG/yDP9pmPpxFJofIFsm7ACNKSlnKOGxXMswp5VlSCBGiZY?=
 =?us-ascii?Q?y+MWtbzNigNTcDsDw9bFu2MMnNGjCWhVG/D55K/VeSRZ8jm2pntZwEcRbFzc?=
 =?us-ascii?Q?iB7AFNKhgD0ZvUuGjF1EzYKum8qw0NWn05WLm/wRVm5jxVEyhcH/o9lk1cqY?=
 =?us-ascii?Q?WURQqI4vK7/e+E2ziuNyAlDvXfJemymocRKfW/J3VU4pjLaYQu5cI90DLkcq?=
 =?us-ascii?Q?9WNLZ2pIQxAYamY52sBxVAESzrZqB0tpOVr5l+rYXRiguHPaItO3rl0t3LzW?=
 =?us-ascii?Q?23LEGkZRIbrckJ0s7OZkcNbpFFk9X7ovPgU0a8VozZmpW2LAgcdpwbKTchYw?=
 =?us-ascii?Q?BPlkC6D/qBMPRbOVRwrwdyi/lrM89Mbqvo5DjKdYlzTg0wgtYkvA+sIq0ojK?=
 =?us-ascii?Q?7kIt+KWaQsYyHKK06sDrFHY6vAZwCC2TievyvSU4RPLwOGHmMUgxiY2MAX1V?=
 =?us-ascii?Q?kdX+s8tlciql0FAcTuCN3/D7x2K7+th6MWCcpoudOISKS5U60a6v1w61VU8x?=
 =?us-ascii?Q?1nKTtbhNAszHNMtRawaiBh0GbIcbNmdhfn4U5mJECPEWCEQFAIo5B70aSstt?=
 =?us-ascii?Q?vlgkpsoR+geVVcTI2363qEb9eWePPC4UI5Rgwu9K2Z/HNPjOPhVOWb35I2Fm?=
 =?us-ascii?Q?+i27/bGaG6AJ3MbzUzPKyWEx31VQRz6sGEHgfQrAplhnzTjrvVuvdXFBEwXJ?=
 =?us-ascii?Q?BcistmmtM+UiY+v3fKLuSdPwtk8rFVwpvm24U711aPwdDTwnbAuL2kDzWdA7?=
 =?us-ascii?Q?P4y1HNHoO8VxDUdnXSl8ORFm04Xiz9odYpq3h0OQ7bouYSs4HFaIbs/n43cH?=
 =?us-ascii?Q?MBJ+Jas107dG24Be9XZVHllTc9CNxxgrqgCorMLYHX9glh4eYqoobpKjaVZN?=
 =?us-ascii?Q?qLkVGAOkYijDjsIH8Me3qMH2pOj6siw4MxPCQI3R8WJ/tR/UKO6+UBXmvF8V?=
 =?us-ascii?Q?G3ynTqyQbQO5BACYWiE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79e554a-339f-4eb8-49e4-08da0cad2d27
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 09:11:55.1521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0JowK8lz+mfuKYbLKSW2xPveQcf7AgfiaWVdgDAGDY8ovr1qjUWxBDgYke6liTazf1DXfGdwmfMeRTctjHCvWqxder+W4TjsAhDLut71Qrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7942
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/03/2022 10:09, Pankaj Raghav wrote:=0A=
> Hi Johannes,=0A=
> =0A=
> I tried this patchset and I am noticing a weird behaviour wrt the value=
=0A=
> of factor in btrfs_zoned_should_reclaim function.=0A=
> =0A=
> Here is my setup in QEMU:=0A=
> size 12800M=0A=
> zoned=3Dtrue,zoned.zone_capacity=3D128M,zoned.zone_size=3D128M=0A=
> =0A=
> btrfs mkfs:=0A=
> mkfs.btrfs -d single -m single <znsdev>;  mount -t auto <znsdev>=0A=
> /mnt/real_scratch=0A=
> =0A=
> I added a print statement in btrfs_zoned_should_reclaim to get the=0A=
> values for the factor, used and total params.=0A=
> =0A=
> When I run the btrfs/237 xfstest, I am noticing the following values:=0A=
> [   54.829309] btrfs: factor: 4850 used: 19528679424, total: 402653184=0A=
> =0A=
> The used > total, thereby making the factor greater than 100. This will=
=0A=
> force a reclaim even though the drive is almost empty:=0A=
> =0A=
>   start: 0x000000000, len 0x040000, cap 0x040000, wptr 0x000078 reset:0=
=0A=
> non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]=0A=
>   start: 0x000040000, len 0x040000, cap 0x040000, wptr 0x000000 reset:0=
=0A=
> non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]=0A=
>   start: 0x000080000, len 0x040000, cap 0x040000, wptr 0x0001e0 reset:0=
=0A=
> non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]=0A=
>   start: 0x0000c0000, len 0x040000, cap 0x040000, wptr 0x000d80 reset:0=
=0A=
> non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]=0A=
>   start: 0x000100000, len 0x040000, cap 0x040000, wptr 0x000000 reset:0=
=0A=
> non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]=0A=
>   start: 0x000140000, len 0x040000, cap 0x040000, wptr 0x008520 reset:0=
=0A=
> non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]=0A=
>   start: 0x000180000, len 0x040000, cap 0x040000, wptr 0x000000 reset:0=
=0A=
> non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]=0A=
>   start: 0x0001c0000, len 0x040000, cap 0x040000, wptr 0x000000 reset:0=
=0A=
> non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]=0A=
>   start: 0x000200000, len 0x040000, cap 0x040000, wptr 0x000000 reset:0=
=0A=
> non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]=0A=
>   start: 0x000240000, len 0x040000, cap 0x040000, wptr 0x000000 reset:0=
=0A=
> non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]=0A=
>   start: 0x000280000, len 0x040000, cap 0x040000, wptr 0x000000 reset:0=
=0A=
> non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]=0A=
>   start: 0x0002c0000, len 0x040000, cap 0x040000, wptr 0x000000 reset:0=
=0A=
> non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]=0A=
> .....=0A=
> .....=0A=
> =0A=
> I am also noticing the same behaviour for ZNS drive with size 1280M:=0A=
> =0A=
> [   86.276409] btrfs: factor: 350 used: 1409286144, total: 402653184=0A=
> =0A=
> Is something going wrong with the calculation? Or am I missing something=
=0A=
> here?=0A=
> =0A=
=0A=
Apparently I'm either too dumb for basic maths, or =0A=
btrfs_calc_available_free_space() doesn't give us the values we're expectin=
g.=0A=
=0A=
I'll recheck.=0A=
