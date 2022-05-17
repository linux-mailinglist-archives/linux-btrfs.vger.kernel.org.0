Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3438C529B50
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 09:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbiEQHpI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 03:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiEQHpG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 03:45:06 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2441C1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 00:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652773504; x=1684309504;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bzWP9jjT0997pqT5mAb3c1zaBxBR+PP83MIBa1Pn3dA=;
  b=CBVAyz5VnhIBJDuOps2y0T9MqFaoQ53J8bmkVzxuSedN6MXRtrq6srJh
   haHNE8H22SiCxgHQR7xgPI4qDFhog3CqeYJ7U37/0O176VPQ4BtAoWrX8
   NwHqoQG+cSBoJduO6BeGT2RJ6sqEmo9DJW0WPrAzc9tyP9zXFDte0FVlW
   W0uwQgKm4D2XYZcjfAVkJ7Wyxy38UXHaPj7Ew4JGQxg58LdbK2Bopv5yc
   SqiCQOLsnPgVnd92QxVVR++EYkeSYZf4iK1n7Ut8Kz3L2XwKW2zKjelur
   KKL9vUrWPxKJJ8hKdHexN6ew7IGasoWnQSUqzsgRIKgijLXLRBGnPWnqd
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,232,1647273600"; 
   d="scan'208";a="205400227"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 15:45:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeB9aqYR9ir4w4wIMIQfXDX64BOWIpWIdBP5+PFle9tBsqLVkqFRLD67H8b7aos0fL4cL8Jl4EHuBDK1iltrM9SyRxdszHQi5rKMQexW/3KAhCj3dC42uaFf4rQyOy0+eO6ETVRVh1uKyPlcXApBHGOPpv6LSTR+a64/af7x1rPPL+NQurhGdDvs8Vjpiuq5CaaYXqDL4iP/82l+hGrlZFAFUGXisbC/g+1SHv2Rjujaf1gshp99TV1FeBTqCH+9FUqd6Np1F7K1tpvkKCFeSbxGy/XaRe0mpc0qJxECjPCobVC08GIOjuaxfF864PwKjmIWYno0cn8HXVg1gZz4VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WPN7MEPPUL+QySyWkiV/lrkMv2b5b7nSOvl/8FSWx4=;
 b=EkOW93eiTOznkoaLDQWCvPh4YClwWBclRSlV8yhCC6T9DBsbCGEoL6YmbfZK9UlQAuh+BR9HMRCaM9JZ4mnzdfJR0Pm6TkTnezZdvPbDDvCfeDHsfUwoO1Jcy2Rn51idFaStVOA5EnYJwehap7lTLGPX4aeIYAlfZdh2cb0089Ugp7GdrATrtivRi0vaZniRci8/B0AvFE756xrHlmUSC5FvQV0gMW+bky3fTgSiOBZ/cGKbZE9NVEwLNN7qjuftZMz1rvBQ0E0s2PqoVj3WMCtXLBoP7RP/ECjDruBChgbhErgrXG1Eh8PRS0iTELxTeNsOyFHLpDS+V4ezNe//kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WPN7MEPPUL+QySyWkiV/lrkMv2b5b7nSOvl/8FSWx4=;
 b=FLdjJhNae06b+U78o4YVNVbVhH2xSxCCnEQh8HZjdCK4EC0NWE2m/+FagTb+Fzffn4REJxVCsqCPnBFuAiItS1TkMs4kIQ5HkqtUrP6MwdW8DtcsnKf/5A89+NIBVOndEXCzXWdHB9UEJ1+rZWLbVEZf2LEdTXXCiHJZc6vJvbQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7928.namprd04.prod.outlook.com (2603:10b6:5:315::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 07:45:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 07:45:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC ONLY 1/8] btrfs: add raid stripe tree definitions
Thread-Topic: [RFC ONLY 1/8] btrfs: add raid stripe tree definitions
Thread-Index: AQHYaTGxFQxgb+dZhEeF2fZUj1kr/A==
Date:   Tue, 17 May 2022 07:45:02 +0000
Message-ID: <PH0PR04MB7416044172EDAE0F7E17E3959BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <06a217ce02243fe88b9649d689df89eea7a570c7.1652711187.git.johannes.thumshirn@wdc.com>
 <cf5f8445-a622-bc8e-bfdf-8084a00e87ee@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a95623fc-19ef-4a74-288b-08da37d92721
x-ms-traffictypediagnostic: DM8PR04MB7928:EE_
x-microsoft-antispam-prvs: <DM8PR04MB79287917C467362C1590EAD39BCE9@DM8PR04MB7928.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ewBcP46nd+2SIb/FT4TVsaiZPjjftS3dWwk2dubljiM4lhfKptCr2rSOuzZU/h7frrnZURUaS/N9E4cvZdwzZhtnZ6I2CdFkiEHA9Uw5uKWEsu4A3toUDAQUFphd9ifpFQCfNqAjJGfXzWAbB9pyymsX6C0NxscN8yKF0pWE8VjMaQEHswpzJlFLiADRxrlxAffBmlmYMgzgx/OE/5vNxDZPnG1UQAjK2L42aysX+2mEEWoDGCkEsasFzN5F34hzHhnlb49pTNqzxAFCfNqLUCRupcZg8ypclQtm3p5bBx3b0Bma4YrdgfX37IZkuExK5WpKSc/IItTYEDmETyejXaN6Mkza+t2hyf1W5zaaUggpWMDpweRxxSp1P+vnMQY/LrhvsKt1I8rOZdhFsMxH2Xl2sbl3V08vpi+CoB173x5I2DqHOjEm6MTYUNLLXX3drGk6dWEykHwBWZp1936mef/iQaLSFYFn3AxKTowkEQXrcc2I6jH586o4vMc2bwVnnjXN/eozmiY/boQJVmnvUY+gkPLNwzT8BX0zKzLDifbce1ZpQHKvLFFF8fLsqtoPKd3E6o0+JDrS6rDh5NnguKQTZOBgzOvn22Mxlo+mDp5G5n8cC0tJtGdRaRDhaf4F92yVqcOEmKG9lxP/SbUtg5ie4wYM6lbh4yoUluomafTytL65wVSLMSgUmfPy1oagzY7+4x4+3iwHyeNhgoQxlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(2906002)(38100700002)(38070700005)(186003)(7696005)(82960400001)(316002)(110136005)(9686003)(83380400001)(91956017)(86362001)(71200400001)(5660300002)(508600001)(52536014)(76116006)(66446008)(8676002)(64756008)(66476007)(66556008)(66946007)(4744005)(8936002)(53546011)(55016003)(6506007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sQEUVKai+psPUZvpCuIcfoRp2VkA9WvL4OSji2PaL+1EMRnKArJaMTvY4Cdu?=
 =?us-ascii?Q?ZDen3tWX1U7qL11yOJPNxyEmxEnYEER3Gjn9acWzZ0okw5t+HHVIC0Y/H2QN?=
 =?us-ascii?Q?eYZWdl3zh/UsqrBmSrRgv54t+t/Ei5/2DbiVUSAorlV4Q3qFv734TeEeXI/q?=
 =?us-ascii?Q?cXNf5qbnM82im2JRv95zWs6Mhg0KX7Zd4YEiC6ASHRBSUjrDhl8d3VZXz7zD?=
 =?us-ascii?Q?O9jlp1J+SDnD7c5UuYfLiErnIT/rDqHQCs7sq8cQ5OMF/DudaRmqTNjzw/7C?=
 =?us-ascii?Q?tLIwAYDyoez8Cmaf9+b8mLNVo8PObvbRBEz7ROeanNOBF/mmGUN40z6Y280J?=
 =?us-ascii?Q?1/9weTB6jkJWnu7XpkiMx1vfSGI1OHfSGE5jhpNOuf5WpxlrqN8wXUAjUBNt?=
 =?us-ascii?Q?iba18qMEglGsBZxj2MRt5Lym8L2RERzGbymY28xxixhXatgVfa3Mp6CaVQKP?=
 =?us-ascii?Q?DbrGQ5YVKTxcwXuzmJ/mlyIQYJ83DNp0YNfNm0wR9xGnae5PdftqpvlmblSO?=
 =?us-ascii?Q?5akU/J8JxkFeMcvO/Wc7orZDW7ym78alwSGKROGvcn9X3zTV7Nb1MBthTXO0?=
 =?us-ascii?Q?exajTkXaVWRj6+WWaciihRRovEUoZmZEqxDP2mhSCMv3EqNN4XoketvOHj3j?=
 =?us-ascii?Q?lbzbGxRJ3Ez8AfU8L8j9HPwDEyKDgtzRHqxzmaEdIkwJJ8XigPwwE6eeO3Cp?=
 =?us-ascii?Q?mxzh6x1KneRWxeDRkPbMlS6Jg8QiHPqDXhEsWTNalLJFA54w0j0h0Ikpl8fB?=
 =?us-ascii?Q?7pQmXOftF+Oey7uASQAqCrIMTQXH9MNH5dl9yhbQWPH4Nw1l26pxRH529CXE?=
 =?us-ascii?Q?r+qV1E57C2s1r4zULNMOJG7bnNyaBElHl1GN+HITaPReV8mqfinNbdEEEoEF?=
 =?us-ascii?Q?sCUxtgzOZnVEfSv2R8Jq8N5iiYoxB2PF5TuvJMv9M0KjFfcbD2j2uqjGnh0e?=
 =?us-ascii?Q?xzZbYBTzkacQvZQJOpV/EeSU4UMOuiZyELpZsHYoBeXQIgSPPZXHFJYbVZeM?=
 =?us-ascii?Q?x1K7XMby1EcyJpaX/cFSB4N2NLQoP1JswZXkzG2UOoBlRFlettGXvizYjcWS?=
 =?us-ascii?Q?7iKiNRxb81QWWOCDC2ui2cGrXEq3J65Ri0mDj8CWlDCCV0oUkxqMhSfAPcE7?=
 =?us-ascii?Q?kRtU65ZSxTN/L7FDpGRZ+gmT9RM91Br85qE21U5f6ZVxNhuUqWpkQ9qM0F0P?=
 =?us-ascii?Q?0n6HfTDrBYB+btkQat3/oGn2A5AzyUVaFd0El0iIX6EvNVr0M/GNQwuZDGYw?=
 =?us-ascii?Q?Cn9vKzlgMAQzjnphmMtOmR5P1v+KwKEBl69B8XgXcF7iG+lpWG+hXetoyhAf?=
 =?us-ascii?Q?POOj23QZU3W/GQZ5+k9u3fUqgazDsa8xIpq+ftOL/sMoq105AremBMSipPJb?=
 =?us-ascii?Q?px03TIFscay5wZuVdSRIQFg/hZ91rWNEvoDpLghE4VwKJ9GMXItLHk2pmf5f?=
 =?us-ascii?Q?aLutjj2gp7PKkRUY2aZLZu3S+OPMkfn7F3YqPEl/p1/E62YJGfQAdB01/M7X?=
 =?us-ascii?Q?Pckcj8zUflnlK1hAo+DjxvkIRJWCKC24QyDGD++91yBkB7OIhM7IccZ5wcd6?=
 =?us-ascii?Q?idQAc5As/L8lu7gHJGNzhPkWTQxlgFok7xXAE5kk+l3CB6qKXZNm7j1A7Xmc?=
 =?us-ascii?Q?sRDCJGTVR/rVeIfuTp1+//r9RDnCqiFipAn2+SQdWX10wddhuOeZXpxspjE+?=
 =?us-ascii?Q?xkpP7+IgC1vTW0mV5t2Mk4q9gh7g34/m/qkkjjxb+mQpsLCKZmFb10k/PJ32?=
 =?us-ascii?Q?iDf+89DbdRBaw6ULvCH9vVxqqkRv2MwkEk0AoHfPSFBdszvtyr6Gq1hqgkBr?=
x-ms-exchange-antispam-messagedata-1: F+/UF6kB/QCcCH8qlSm0jNaaPtW/kqryrmLGBQDn5n3KW+4D662urRxb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95623fc-19ef-4a74-288b-08da37d92721
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 07:45:02.9637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +dz5wItyMFec4glj5NC3Le347Hgo79z2i6/NoBlGBQJ5IqGJtLaBsHgnq/CNeTCpSSk9dbocwjjGrx+HpLAsK+2/rxiTTfSgIpX9zdbAn8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7928
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/05/2022 09:39, Qu Wenruo wrote:=0A=
>>=0A=
>> +struct btrfs_stripe_extent {=0A=
>> +	/* btrfs device-id this raid extent  lives on */=0A=
>> +	__le64 devid;=0A=
>> +	/* offset from  the devextent start */=0A=
>> +	__le64 offset;=0A=
> =0A=
> Considering we have 1G stripe length limit (at least for now), u32 may=0A=
> be large enough?=0A=
> =0A=
> Although u64 is definitely future proof.=0A=
> =0A=
>> +} __attribute__ ((__packed__));=0A=
>> +=0A=
> =0A=
> Mind to mention the key format?=0A=
> =0A=
> My guess is, it's (<logical bytenr>, BTRFS_RAID_STRIPE_KEY, <length>)?=0A=
=0A=
Correct. I'll add a comment here.=0A=
=0A=
>> +struct btrfs_dp_stripe {=0A=
>> +	/* array of stripe extents this stripe is comprised of */=0A=
>> +	struct btrfs_stripe_extent extents;=0A=
>> +} __attribute__ ((__packed__));=0A=
>> +=0A=
=0A=
Another question, should I add the generation to the =0A=
btrfs_dp_stripe? And does someone have a better name for the struct?=0A=
