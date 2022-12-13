Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E1464B0EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 09:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiLMISD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 03:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbiLMISC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 03:18:02 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B763110B
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 00:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670919480; x=1702455480;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mhiB4c3BaMuK3WPiwi7QoGfFtuUktlH/XLORdr5fQIM=;
  b=dT6Mo3gFX9xf8+t4mnBNUm218HV0OYn5GJ4tRKAYGcjs2ORURNuW9XHo
   AdDpZwDEpmZHWbfGbK5Erl37gNNdIhx8YrxDdlIGBdUjitxxDGOgNF1D1
   gWCQe47FqGfDwq1hSbvs90O+CCz8MmrB9g1H3v51Lgt5MxVpj/4trSirL
   66OWLeyosQVjxcLXn4QQl/yG7RNAfONmHMBdja4GkdF0qTiyEga2X36gk
   O/wjp2/xm5mjouhRsUIpVuGk1SJfzaFKOOCyEVXENSCabPGl8UqaYO+Cn
   NEUmww+XGrbEso4TExNRHwnO9P0U+S5OvBN7MOmXlrlcvARk/MXaV39Fm
   w==;
X-IronPort-AV: E=Sophos;i="5.96,240,1665417600"; 
   d="scan'208";a="218775553"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2022 16:17:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwX2pLmDd91lM8qDLcnvYLrqI6JQH6jp02wUDpIxPA9Ry2K/48Uz2CFvFrOtBV92NQPDKZH2Y91xH6AsMbUiBAv7Afg6EA6fTLUO6iAsVrirmZ8gBH2hrGDTh0wmnyV7wKq127c4BfwyhwEhJFKPSq68PRqaukpfOs6yY5PKFmmoOJukc7p6KhE9bbb0a6HV3aD/P+2NucSa9BHk4mvcc1zpd7dKMAj04b90/w9V8LICKWlYRL1FwrUKvkfaNazrU7RKv1kAB5yge4am7TBJAmpjF4R2WjMO7pParCqbioY8EMAXcAaXBiLaMurWF54egWfj9g2f5KAl6O6dU8+9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhiB4c3BaMuK3WPiwi7QoGfFtuUktlH/XLORdr5fQIM=;
 b=mVqq5Pkr1DxPZTKPFTMliQW0wavolB0XEOAO9Nh1yisamanGhdohJzjhE6Ak8ljbTJOnwyIqx4JQgxMudAXaU37OBW5rLID8jvp1xa74meTEvBdkaogCmxFD6lK0BivESNc0YnxwCqokpZdzWItclQz3BrgOq5Cu1HGOXCbo6VGC05kw32DljdQ0gaT6bUsTkLHdVbp6hDvdx2EWP5iSSg3DeIFo1oQl2glKYIEzPHyYsCDjZYBXqBOSEpwj6vtddPDYSnSmXY9wkglNhJW6X9zd2Qzl9c04P70PxdBOmYcKnAvMHUFBkYqDtBHemDs/jdyOtC893YuuUtd4WQ0mXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhiB4c3BaMuK3WPiwi7QoGfFtuUktlH/XLORdr5fQIM=;
 b=SoeabtuyO5mwlQq6CbMKWNl7WzqoLF/s9JQS4TOgweyNepAcSWyvNEPv6zNU0f8Z2WIZ+1jceRtB3sO4MgOZWeyMDtyja79Gja4ad6mKA27jFmH1iyjZE0skEbL1tS5EsuQOjLl/N2xDuFrJjbxBrNRJjwu2jgr4itawL6l08b4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB0410.namprd04.prod.outlook.com (2603:10b6:3:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 08:17:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b%9]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 08:17:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v4 3/9] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v4 3/9] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZCkdbJyiBsduuyEOE+tpnuJRQAq5qqwSAgADXPAA=
Date:   Tue, 13 Dec 2022 08:17:57 +0000
Message-ID: <e9b049f8-2e88-5ba0-f4be-63a3fcbf736b@wdc.com>
References: <cover.1670422590.git.johannes.thumshirn@wdc.com>
 <238cc419b3cbc18c4a93ad7827d33961fafd4196.1670422590.git.johannes.thumshirn@wdc.com>
 <Y5eAp1+zNz2bv9dD@localhost.localdomain>
In-Reply-To: <Y5eAp1+zNz2bv9dD@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM5PR04MB0410:EE_
x-ms-office365-filtering-correlation-id: c7294f0e-486b-48c0-040d-08dadce28a80
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tIu4+5WjfDjGuYklMZQ+AI2/166wTEfsUim1zAWwkfQxemkGQLYNsoRLnZZtlt5si3gOREm6XYjYX+85Hi6QXf0RoJk6CGEA7vFtvATt9Fbkj/u72LUCIBzsb1caan4LGnIqZxmsxmO0va3IWIcbNwyhDk7k6YrokFx29NFRWj252JYJbOLBUf5C1V3U5URNYrEeImUvq3dNbkg9pEGai/DC37MvD9xO3eWn7dmUaReBuGdasydOZ+uOJpyVocci1n8a/8O5s12rMS+hhFlJxL6IND+fZ9uuW5siPuFJ/WM8GFyL1IgwGH6mpqDncFle3YSnd1eN1KqNwj3+Uhg5MaiCa2Mev4NXjmi93LpkgXx+FDOwtnyB7p8mTNYaWziD9IDXlBFwIVxqmnqYVlhqJzPfhyDca7D3dUV9mWKNZVDa5gGOHPHnysUetGwhdM/xSPT1Ml++xhIlm8o85VN/PBnhipR24Hk+VQRUFuNE9FmVzzwrBmSUTgsTMW61eXi9StjelQ5hRNBvfFcFBpsT7CNUoIezf0EZJpRI9IOoaIeMP/cvpOihNGPFl5feFOJOBUGS0Q/oGMNfk1W1Dd8Ar/Dy1cEEp0ZvdqI/WrQo6EdxkUDRfZlLzT+p6kZ0rpmrqrJWOueyE28FxvrqrSQD+kzOXlt5VA45OflPb6AUWq59P0T2sFav7zu1UL26h30AWcX1CSbo6fKmgXzdZPGyexIBWBJnMvHMGomJatJoLvKGeRh6lLCYG59uK6OxEmflWYxttPDg78n/QeywGbuU5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199015)(36756003)(8936002)(2906002)(82960400001)(316002)(6916009)(558084003)(186003)(2616005)(31696002)(122000001)(6486002)(53546011)(38100700002)(54906003)(86362001)(6506007)(6512007)(478600001)(71200400001)(41300700001)(91956017)(31686004)(66476007)(66556008)(8676002)(66946007)(66446008)(38070700005)(64756008)(76116006)(4326008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WStvMlN3V0hueU90Nnd1bVppQkdKa0tXaWl3NCtFbUFhdXJtcVlWdlYvanp4?=
 =?utf-8?B?ZFZmd1BjNWtFM28wRjRwZFc1bGFMN2RuN3ZzTUNLKzZjZDQxbDF2SmoxV015?=
 =?utf-8?B?YkZyaHFQQ3cxYWM4K3M3VGxNWGdxYk02eGp4dDlMbU5admlGM3lUYjA5ZnMx?=
 =?utf-8?B?S2Y4WnJBNkowWXRNakZkQXBqeDUzVFM0RkVNb1JyajVhR3lhU0pFWVRBQ2ZI?=
 =?utf-8?B?Vnh5K1BxaytYQU80NHVTY2NmeFBGU0MzSFRoTXhUOTVtWW95ZCtCVytwTkVC?=
 =?utf-8?B?MWppOXorYXpiV3AremJqNXE2UXY1NTQ4NTZDeXVuTEVDK1BLV05hLzRkV1lV?=
 =?utf-8?B?OWNiUENsdk5hTUtOY2VOZ3lvTTFIZ3dxUVlBK1VSMFB4RjZ4M0JQVzA3SGR0?=
 =?utf-8?B?VFpZYjBTSGtPUUpzV0ZGaWtJNGJQait6UENiSWJIT2tlZnAzMThrV2VSS1Nu?=
 =?utf-8?B?M3ZGSkhHd3BGV2JqeXVwdUV5UmpTbWttQTFJdktJdjRuZFdtV3YrMGR5RFcy?=
 =?utf-8?B?RFJ1UFF3YTBaM1FiS0Vhd3QvT1A2b1AxN0w5dlR2cXVlMGlTQkgzVjdqb3I4?=
 =?utf-8?B?OW5xRWprb1IyT2crdlV1VXk0cGlWbGFrY3g2QVZpZFFaNWxIU3Ftek0zTzFi?=
 =?utf-8?B?SElMZnVIbUx5bm1EL3JTbDJ6NmRmQVUyMmp0Tjd3UnNxejZrWXVPam5KVDlP?=
 =?utf-8?B?cFRadnFKUDE2Q3ViSE1IdFVkOGFWVkJ0L0RIREo5U3VoN1hhNmg1VHdMLzZH?=
 =?utf-8?B?VUxPVWRIaU1DbVdiMXU2ME9TcEhkZS9PWUU2Rk93TjkwaHlNbElwbnc5UW5m?=
 =?utf-8?B?akY2WHBPRWFCd2VrQyt3dmdSNTlKZXJMNVpWUml1NDJ0YVBtaUl3Mm1QNUpk?=
 =?utf-8?B?WTU2T3NSNHZObWZyZzdLbzE2V1VEMTdraEJHaTFKVXhnbHl5U1dnakZVVitN?=
 =?utf-8?B?aW42ZnppeU14YnA1SlFrQjVIcngyWW9Vc3FnbEtNLzMwSzNmUSs1aEkzcmFm?=
 =?utf-8?B?V2ZiM1BjUVd5RWtzL0lHNW1iSFBKTXdLVWNJSkI5SlZCMTE2YUk4UE5UVjlB?=
 =?utf-8?B?Y3AvTTJIbVM1cmFFY3hrRk9LWWI1SnNIRVkvTVpZSXE3YjlUNTVOVlorRWhu?=
 =?utf-8?B?ZjdVNkM5MzNiam85Q25YSmwwczMrbXZwMmxEekhWckl0ekhDZHZqV3lLS1dR?=
 =?utf-8?B?cTJORnVpODA3Y2ZsWWl3MjVNb0NyY2lEaW93c3ROdkxRbmVHS0JOam1aN3Ba?=
 =?utf-8?B?bDU2ZVFlbjdJczBHUklnc0lxcklveDJCQzZ2UkpxTXF6OVFaSDU2U1ZXTVg3?=
 =?utf-8?B?TUNvMU1EMEtNMFNLbGREbUZXTTd4UXRqNzJTZk14S3ovYTBFMG5BelZ0RjJn?=
 =?utf-8?B?Y1NLc01QNDJPb1VXTEVVTGhGVXpCbU1KYXY1OUY0NTFqTVRzbnVMcTh3c0hK?=
 =?utf-8?B?QVhtWG5renZ3Qnk3T0ZFTTJ4TUhZcy85MDhZejF2VTRNTnZCNnNQMmhRQm1D?=
 =?utf-8?B?TEJnRFFSNkxHSVV6blRZcUZQQVMwbG5jenUvM2hpakpqbFN1UDVCNWdwcU9q?=
 =?utf-8?B?Q2F2bGJtVytiNCs1UGdqNXRvZjA1c2puQWkya2JSa1NJcFJ3UUt4WmtVM3FH?=
 =?utf-8?B?Sm5aSzNvNUVzTmdVNG9jT1poU3FaeUNzQ3dsb2pLWVRmM2N1azhMaEZBMWl4?=
 =?utf-8?B?ZUQ0SVJkYm0vM3dQOVhIaXp6VlRYNTRoSGo1NC9sb2hMRG9JOVd1eWpNMklO?=
 =?utf-8?B?dm03TGYwd2t6eG5kZmZxVDdrck5wS01mdXdudGlLV1dpS01iQTRpaTNGT3do?=
 =?utf-8?B?amJ6NnhwNStQVFB3VkdXWkZwcWtkdTN0N1RqMnlrZ3RocUYweE9Ca3BwVzFz?=
 =?utf-8?B?ZjJCWGxkWUdoWFNhZjVyQkhoa2NJZ3VHb3loMERWM09LUEdzRmdqSzd4Tm00?=
 =?utf-8?B?SFY0b1RYcXhXS0x3VnJiUFJPMzk3Z29id25weHFtM2hZTzFkNEZmRzJHdlRB?=
 =?utf-8?B?SWlTY3UzQ3JHSW1oS2dIMnhIU0dlK1FFZ3d6S1RFRk82a3czTmJnN0hQb25Z?=
 =?utf-8?B?dzMzVUR3S3hzVkN3TCtVb25RMHBKWWRsenllYTUzWmFrRXA1Z01vd3JOS1hY?=
 =?utf-8?B?RkduRS9CS2t0VjFBZElUWUJvSS8rUGN2RGp0YnJ1VUo0bXhZV1phcjNCZE1s?=
 =?utf-8?B?eVAvNU1ITWdCWVFPTithV0dUSmlySzFPMURUT2VGM3RhSHNwZm4wZTVQQldK?=
 =?utf-8?Q?fOW0wrXG46ssKWBg4NMs4pw5qQJ4HKcqAKAfIJk4+Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <500E1ACEBFD83342BDD31B8CB59EB69F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7294f0e-486b-48c0-040d-08dadce28a80
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 08:17:57.0555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 02C9vpdcSD6fsdJCbVaIk2jy1nn5HE/fFpr+Ejp1+9r3vKk+6YbdAKlSDXtNa8+GF2lR2emUi5xwMbqx7jC2Etl0GCxyrgQ1+C3o3BIYNwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0410
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTIuMTIuMjIgMjA6MjcsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPiANCj4gV2hpdGVzcGFjZSBl
cnJvciBoZXJlLiAgVGhhbmtzLA0KDQpXaG9vcHNpZSwgZml4ZWQuDQoNCg==
