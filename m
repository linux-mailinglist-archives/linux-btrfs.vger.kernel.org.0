Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFCD55C1CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 14:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbiF1HPV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jun 2022 03:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238901AbiF1HPS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jun 2022 03:15:18 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963EF2C136
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 00:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656400517; x=1687936517;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=d6Od6PgaRlwuJR3ikmKMLhbp6saizRfmZXqgqw+RKPI=;
  b=ljxV8dmbEANVw4/VOK5wEDcPviY/++8y7esDt4YqILYfPFY7ua8WLMAr
   ZWDA6lNNKt4Wq1TOcIerrYAly1puup5K95BW0v26Ok45cX93KRCGWIT5T
   vuYb395l64w0NBZ3I6MmttryvazK/3K7xa735HcwI68ElIZ+U/tYBUUNP
   iMZGyBh+2iOIv7Qw77b9knS/fWuYPQodLqRNuD1C+Tv81QNFgjO/770U6
   fnJODmfJVzRKT4U4lnw8/pDOEDn3f+qci9inKX2pcfmA7gJ67lYjgq/45
   JyyqiyN/jC0D7wvhG4gIw6XqQf9Yb4JDt7mRNgCbOuWCCbvE9h9kREP+J
   A==;
X-IronPort-AV: E=Sophos;i="5.92,227,1650902400"; 
   d="scan'208";a="205001012"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2022 15:15:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaNMjJo2EpnEAdhb+L8Gb1ZfrPhFNDgD+ok+28Gqxgj/ZIalK1YB9WD2tjm1SbelhCke1qhQx10XYMzGuLzjN6cbTe0yDutzQcdMFiAxIbbBKXkewV1RhkBpUebnlev4ijR4zlp6u7EzRG0u8S1MrVFXOoakrirwNZ1gW8nJJL5BpKCiodRiePzeXDWnL7EOFQ56IrQgl+SLtk0sOfa3v6apkX1ZA5pRvWUXSx2YsgopVRs+2Yq4r3pykxkbcEW9BD8IE/vf+1arCgN2KBP1yiXDAnMmJLqVArZtJEKlVAm9I9NlcCBCFbUWiUYks9dZhLar0FN/PK2KkKOUgjPFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bo50WqQwJugLtoA6t/f3jf+WQqFsltzSipdULbk73HI=;
 b=h+7IGgcd+J3NNWKVI6N2i+PBy5q76taj//YS+d/TUCAlG91AlFdjPpSRXo3fEk5lIohA4ycAtZn6PaT7AvrE8jysXMMRBcE9q/IorYgYNIfmf8DlwUMm2aw0CiD/TAz6ZTvU00e0vZOlvxQ7ZNvJFGAJZ2hs0ZGLrYWQ9dYsPfpv7jFsu7HOPNcCHrEVmQokpN95IiuE5RvAjNnZgbbXx3SKDDBTasVG1obBjLOk3Q2H7jnKOj2LWCE9HcCF6hN08c2W7zCYO/ZffKJGtuHVjDJ5G5Ootq3rfKKf5y9vdgkPljX7DzIQCwAZO3N33Q39tmVNftv4xOZ2E3P1jRCBuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo50WqQwJugLtoA6t/f3jf+WQqFsltzSipdULbk73HI=;
 b=s64/dOFW935zpyECOLw1k3HkUs5C/jwy3PzmNEwUmh7TnZ0WiTzxa2XDyYFTM3ZpRFGzMb2701WIQzw9r7HjXAGm6LKHKqLeLMIbft/vOxYw7yMN5w//hVFZrS4XZCL4oB5FGyoEsLxSUMmE4DeHM/qNlkJX07THVasxLykgGT0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB6071.namprd04.prod.outlook.com (2603:10b6:a03:ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 07:15:14 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d%9]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 07:15:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: use u8 type for btrfs_block_rsv::type
Thread-Topic: [PATCH 3/3] btrfs: use u8 type for btrfs_block_rsv::type
Thread-Index: AQHYh9Tharb9bw36dE2PvHRW46hatA==
Date:   Tue, 28 Jun 2022 07:15:14 +0000
Message-ID: <PH0PR04MB74165A85F6DAD1C596F1F61C9BB89@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1656079178.git.dsterba@suse.com>
 <2ff62613189d8f58f8da90a1558ad5726172057b.1656079178.git.dsterba@suse.com>
 <PH0PR04MB74165896B1D1967356A84A7A9BB99@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220627164018.GZ20633@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 394c9c22-6cb7-4e17-176e-08da58d5f26e
x-ms-traffictypediagnostic: BYAPR04MB6071:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oHXFa8IzsuV7TfJntbXzkP3F1Af+kimk6IAXrqz8bqV0UNIDiaBXe/PSLEHN9mvzpG4+EpM7+hFa7ay/e1EC/yHkbKDqvIvNEb+E8Z+mwCJD2oaCFi7nKEysPksYzS0L8Kl/rc7itHiavLSE8NrsTEemIcfOVtkJyNaXwPuSRqNQooPtpBAAWAMtTyecLWu6ZY48tLXz7xwTdoE32iZbfg799wgDDTZkOo9GUrOTKrRns1eS+MvU7qZVvj32Y/kpNiFcNL/sdA3QkxlECXsG9HdhdkpP6rcNyLxAzXbu5cQIOERZWKZwDcZw9be5191KEco4bbeVe2UC4OYeNDiLhiCD20aPg+NYWOtQqVt42xg0N6CYypvAbjPKD+zpgP/DveOOT9U3s7RTl/UuzUdxLRc6KwTbOmsubJk4JoubodtkyH5Xukj/mdA7v5PNpcEkCbQb5pcX3Y+ekWOkxExe/WwBP18Udlt5pQYE4dpA4MVC1McKAJdH/9RKUEMXnj1sxDhRWcaPkSzAntS8AW+l+JWgNmyIW/oAL+V1S6AmpkIn1OMqXjF0klXNYW/2Cn7SPZ9/RbeZJA/LYJqBZPt9n7AfJjrfZv+S79aNiTGCpa7tDi/5gpIUwEpES+WU8mYII7ipwg5nDifLPh60YZ7RMH5lGv1y2uBj2nsK5mPOVpVM00+pocP96AK9yZO1fsoDKiM/OEPliZTcbpv3y5B7yshm/6LZ/nbcOtuFGg0pv8IeqRxEe9Omtq9k0mbIwts1oxmeZ+YxCkV6MBMUbNYHTmV/DdDBmts/eosdH7rUUHA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(53546011)(4326008)(5660300002)(2906002)(4744005)(8936002)(55016003)(52536014)(186003)(66946007)(7696005)(6506007)(83380400001)(316002)(64756008)(54906003)(33656002)(122000001)(41300700001)(66446008)(82960400001)(478600001)(8676002)(66556008)(38070700005)(91956017)(6916009)(76116006)(9686003)(71200400001)(38100700002)(66476007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FeN2Y1YG9GGfe71M+BjPn6B43xtT5lcVGhKzyDvbjYgjzp9wOFTTIS11Ut3n?=
 =?us-ascii?Q?pUASrarqtILd4FxyiiMeo0Q8K6wPmBxrSi0yq82U+o6Jl5bMPccrFf+CuW4G?=
 =?us-ascii?Q?jbrfN/zdEyLnZPSt/+Cu7zL+84Zv2rEUFt5mBzhIWUDZ9rewDItTAiHGzezK?=
 =?us-ascii?Q?Lb4Gaqu33boyzhMa/xsrjsAzTFWKxWJ/n/WU2/fF2c/YA0YujWaLHzXgtPCw?=
 =?us-ascii?Q?1hvQa99ndh02rV+iVMID+hyWy4dld0aSQ+jYiB/VpkEPNQ9J/85QSqje4+Mt?=
 =?us-ascii?Q?MWg15l7PeDknS5m+GdNGEk7Fs3KdqinZcDU9H8ey/o9rc+Ttd9O3iwyOIJWC?=
 =?us-ascii?Q?tj3UDE5IHSLjuqCSpLts5bottn3+3cTdllcRKGHbZ3GoXQ6+E2zHdNDvaNkY?=
 =?us-ascii?Q?f9lsK1onfTZ1C9t9EPFmRZSEF125dERMHx9hJpzEQcKTIiJxYnwU6I7IEyyi?=
 =?us-ascii?Q?4EGXZ220so2BjxLbkoDUTbHgjBZWPxmeZxvwK9hzgEtfoZCcNROpE0+0W1u2?=
 =?us-ascii?Q?dxINRHfvPlFxnGZsKibJ7aFiJUAyj5pj3NToWZrSb2nCzkEy6P3qlhtYbO+y?=
 =?us-ascii?Q?WzxuD1rYOOo/8hUDcx6bCOBYNsOUL1zEJddKkQAzZs7E+93v7jShBCJNwu5N?=
 =?us-ascii?Q?snaFnREx2FG6tq+0Agk4F8qqgwo3Ex4F58s7810jthztRq+o6eLHIR54dlCM?=
 =?us-ascii?Q?HPYrZfoFygwwRnWwJx9Whkrk5/LSVgXvSfJbiZ4PQegU8SpBJEdcUAJdAV7C?=
 =?us-ascii?Q?SwlAJ7/2E4sp9mvjbiqeBOMOBUH0xxahfn1bcYYfjq51ma8U5Fv/9j7lWhOO?=
 =?us-ascii?Q?anx3OQM+5dkkVkY2C+jFlMt0j+Qs2NdMERYV5Ec0pZeTQnrCmsHLojhebMk+?=
 =?us-ascii?Q?wio+Ovjcrdujj+osh13CPYE6pk+cdWS7iNll/VsWA9fFSEqEbybhBhUEgA81?=
 =?us-ascii?Q?G0C2tYGDCzC8KSyTW30L1k9BofS0DewCcjCKpG53E+s1cLzzd8K4aDXixgy+?=
 =?us-ascii?Q?+HOyzRTVNdzWEodzoVGseM3CT9Aszf4137M/VwHCO4LTZiowPJyoPWV8P0SK?=
 =?us-ascii?Q?45kAAoj84v/LAHAwU+SQPWgAz3K/gVkSS6b7UwZ4FrwjS+v+A0Sw7hCzPE6w?=
 =?us-ascii?Q?3ocwyc/Scf9SqrgdEZpB2AvxfZPM7GhxHZG4bU0UIqmuF7JvY1TEgjt9T92z?=
 =?us-ascii?Q?qQ/2l8pJeVQhQ3FB+pk63tVroU3iso/dNE9vhrkeHyYIXqoIVr9UnGXtMMa/?=
 =?us-ascii?Q?E62CVTBFcamm1GVZLjnqYQuKoCVd557dJ9wpM8hLFp/TMG1aG+p8pMO+oEPV?=
 =?us-ascii?Q?elcHxr8L/FS/xVhGIVb07KmYyvoYJInZLSfO8BEqrvPs6DUVqloLWbIiwXF9?=
 =?us-ascii?Q?N+FlKinajkqZlmJLrp780znBkGZI7EYpeOt936HqgoL3x3txw7OqQNGz98ns?=
 =?us-ascii?Q?QohRfldD9D1CKRHm8DsKHKDIImB9Idy7+p8xZJBrxbRlMnnv+uUCDERC/e5/?=
 =?us-ascii?Q?9vjWXbUPt6QGW9WX5v9bPkjHd7HTLSxPxpVlfudnNX6YC49WVLSippjrYr8y?=
 =?us-ascii?Q?XzBhDL7locks3KUL/EXf7tHQbg6pPmmtUTAlxhA4xk+y3z9eUhWqxlqGTWOZ?=
 =?us-ascii?Q?T/tP1noCdD4BwL9rbyx6B/YKkHMHGnv5E5qyGDu/dIOn/0Pu7fQ+I55Ah5IJ?=
 =?us-ascii?Q?BTs0vxG9Iu2RSJG7jTfzQC5s1p4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394c9c22-6cb7-4e17-176e-08da58d5f26e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 07:15:14.4301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cDt5J4gN32/HVCxIdpgmVulMyGnAc7+BDX6lVNXPJeH/m2h/qZZ+mbgcQW1PJT1Z5+NQYUIU/BgFU4brJCH7nvZAG4OZMfzwCxy5hyNkBy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6071
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27.06.22 18:45, David Sterba wrote:=0A=
> On Mon, Jun 27, 2022 at 06:51:30AM +0000, Johannes Thumshirn wrote:=0A=
>> On 24.06.22 16:15, David Sterba wrote:=0A=
>>> diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h=0A=
>>> index 0702d4087ff6..bb449c75ee4c 100644=0A=
>>> --- a/fs/btrfs/block-rsv.h=0A=
>>> +++ b/fs/btrfs/block-rsv.h=0A=
>>> @@ -27,7 +27,8 @@ struct btrfs_block_rsv {=0A=
>>>  	spinlock_t lock;=0A=
>>>  	bool full;=0A=
>>>  	bool failfast;=0A=
>>> -	unsigned short type;=0A=
>>> +	/* Block reserve type, one of BTRFS_BLOCK_RSV_* */=0A=
>>> +	u8 type;=0A=
>>>  =0A=
>>=0A=
>> Is there any reason to not use the enum?=0A=
> =0A=
> Enum would be 'int', 4 bytes to the space optimization would be=0A=
> lost. Enum types can be shortened as=0A=
> =0A=
> 	enum btrfs_reserve type:8=0A=
> =0A=
> but I'm not sure it's an improvement.=0A=
> =0A=
=0A=
Using an enum would give some type safety (I think -Wenum-compare is =0A=
on by default in the kernel). Packing that enum would give us the 1 byte=0A=
size you're looking for.=0A=
