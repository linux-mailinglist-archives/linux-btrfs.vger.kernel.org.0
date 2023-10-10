Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E297BF628
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 10:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjJJIih (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 04:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbjJJIiW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 04:38:22 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A042712
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 01:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696927033; x=1728463033;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RVysmoiP3D3jnqNsA1U2moMTR0XnMqPw8bvJDTZ3VnE=;
  b=d9awoLzMlk3MMX0NZu6UQxfM+UECMah1bugrCxZYtyDNHB7BwEZT6aZ0
   uNO1hDjXcheG5J8TRIp5MCFBlr8jpFdXby2SzKdif2RN+u5MgEk3vJ+zf
   ZSYWLCy6Yb2TEItrvuhUu2vtWc+fnumSu4+iu+saTDIb8pdni34hiWM08
   XO+UpnCEIWexEa/28PX/8zFaUbw2mt15MUZu5IBAerI3St7BSQp4Uz6v5
   bB+WcK9NmYdhn1KKsFLAQdvCf9LoiuHETaE7DKAGWY/rNJvkJZsKrWfrA
   VYEf7ZEK0gfxoUU0Qx6A8WbKYrmYBXdr5YH31dSE5b70U2/0wEGlxGlAI
   g==;
X-CSE-ConnectionGUID: XQsa3lL7TKWSrvvC962arw==
X-CSE-MsgGUID: sVMNtmCFQDiWf1FR8iiA8g==
X-IronPort-AV: E=Sophos;i="6.03,212,1694707200"; 
   d="scan'208";a="244274867"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2023 16:37:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxFCFBF1hI6equTgedMyZvtjbA5zksc+AU/XX3yC52lCZrV3oj/fVkH95PcqXj45k0I2DNJBJ2Tc76nj9DV1K1kQftgh2eTwxj0qr954yhsNvEccjIEGNHe9ilB7pDEwnPvonkLXNsmGTFYvE6fNyosfuuCNKcmkdHocubSSX8zPdKAF8ipG85sdTgX3Te8uRQWaPehWzSGVeWO1qFy6p6wsJ1r4LwJaKheKyEiaDekITgHN5OJeyIUifX0gOv2CHDLbOewYre1mRj5fHsukZtSQlAP/68tvBk2wLmmJYR06iqAOJlLbuNuEyWHqNWUSV4PBnKkmEJWaKaBSu7XOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVysmoiP3D3jnqNsA1U2moMTR0XnMqPw8bvJDTZ3VnE=;
 b=cZdGXy6wiSs30YFNjAZ9iTQjJX6QJMBK5F8yiGwwtypgbQDygpuPZP5/245Ooq5kpSmdpfH5z9uiJ93dEKH0L6IlfQVap6j931dFfL1B0/TcC9SxZZlOZ0pUmrnCnGSNwdpsL1N1fJOjnJSadJ4r/Fopvg3Xpm/oagANGMJB+5uCCrWpvBeBLZqA9xbtOfsIGvafR9Cd6LmBB3Hcz8XLrGooXV5iCOFTCmbhZzK4CALVn3i3MGNZhQGh5GVPomoJeXwFgnyacN8mbxPdI++3d/iRkvtjgl7Xd4B3K3N4HhvEj6ucx5y3qbb9pYRkQBNkHvNL/W7U9OzUL1cF61r6Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVysmoiP3D3jnqNsA1U2moMTR0XnMqPw8bvJDTZ3VnE=;
 b=icVJEkmO32Wifc+ipBZeol2QXQ4gsOicpXRthcJyvJGml+AcZtG3Su8UYjm14j9dA5lb4Vrg8VysCvMScZL0b3THjs+kFvk9b251drAHzAYHXvv6PeJfQRvSny/37SFgssLTPsB08zSsu6UQoBZZqKjxfgMIFuSCQ9xs42TBjlI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6477.namprd04.prod.outlook.com (2603:10b6:208:1aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 08:37:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5b7e:bd22:eb0a:2aa6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5b7e:bd22:eb0a:2aa6%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 08:37:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: perform stripe tree lookup for scrub
Thread-Topic: [PATCH] btrfs: perform stripe tree lookup for scrub
Thread-Index: AQHZ+sm8myxTfirAvUSr8Efh0dGx8bBB7l8AgADF+AA=
Date:   Tue, 10 Oct 2023 08:37:10 +0000
Message-ID: <77b7ae4f-d353-46ee-9b35-f7eb64bba110@wdc.com>
References: <4895772fd73872ee2cc23d152e50db28a5ca5bbc.1696867165.git.johannes.thumshirn@wdc.com>
 <cdfbc6c3-d43e-456f-9616-441c3b50a1dd@suse.com>
In-Reply-To: <cdfbc6c3-d43e-456f-9616-441c3b50a1dd@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6477:EE_
x-ms-office365-filtering-correlation-id: fabf04fc-df5f-4f84-eae5-08dbc96c187c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7BHQUnOXHusscXNJwqFxut1yIMRHMXMLN+ANQ7TbSKB0gJyYxbvNymyXtLOKheAGLfvlUxXIPhmhYBxf06KaY93XQSMxJlH9BXUDxYYsmUJ2MdvU13vlF/VraQwKFCNg2pT7QUmIqlZiIQ5nFhOwTAOyx4wCOTOk7O0npr771VKKP1EjXkjpyVMeb4ZJlQvHpPjhNjAkZ2IqEZghJeEXNrNNh8p7NRdFdXxhT5Zlmf9prataoViFQbrdoffL+hy3YqqgF61K1oDdcjXe7wNc1Stz+yC8GtX6gfXHwgb5l2ucot+VsLnevIU5dTKdI7IV8B3XpGVbJaKA0GrDbMdLNugHu9laa1TsyXjTY+AzcTO9kzjv+10OUtFM6buuOSPfAfDN1+I4SDCspV5k6np0gfHUmTvsuxSQobP/DfBy9zQJNYLsTHjtb2grhjjTDTOKP09Ty+NZZu3gxbQz5qDzVayOmR+GxEdwtKOZPKyqVBfAw5KVKeSKo4L0koND10znNo7rBFS4bl67q04aKxdwyd3ft9W8K5y+i/bsN3R6A9+ZG/+foXp5TnTSfiDwarZsI9EMem69TazGgZXe53i4ir2aApSExR9ZnjOtAO1YNhdyASkIJJRnUswFa28R8Oj+hr/XZ/QOKsa4rN6iGQppV2e9Mojfcr/BHwHFKxMEnMj2s58b15/aJH8Ec3XcXox9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(31686004)(2616005)(71200400001)(53546011)(82960400001)(31696002)(38070700005)(86362001)(36756003)(122000001)(38100700002)(83380400001)(4326008)(2906002)(8676002)(6512007)(5660300002)(478600001)(66476007)(6506007)(316002)(6486002)(66946007)(8936002)(41300700001)(110136005)(91956017)(76116006)(64756008)(66556008)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVo3UFV4MTBLQVZBRFNSRDhEM3VXTm5Vek5CS2VqR2YwNTBaWXFiVDg4YnhP?=
 =?utf-8?B?Y1BNd3pUc0NXSnVnMlRKN2xxd0M5UmpJNEQwQmlWbXBXZno1ZG16T1RERHVD?=
 =?utf-8?B?UThBUVlmeTl1RkZEejF6SFN6MDdCNC83VHZTYm1JK3Vya3hPK3RxemtYb2Yy?=
 =?utf-8?B?blZqYi8xOCttNE5nM3l2bklVMStsb2VESytwdC9DWUdIU1NNR0hWMG1wOEU0?=
 =?utf-8?B?cFJiWDFsd2JIcmFjYkJodjBVeitsQ0RyU3Vwc3B3QnZPdzJ5VFo1VWZzV3lk?=
 =?utf-8?B?dUliMllPMWh3eTVnMUp2VUZFZDlRZ3RUdzV2YjMxNU8rQzZqdUQzQUR3ZS9y?=
 =?utf-8?B?T3pUSGZKQ3lzNkZoTS8rcDF2OWlyZmFuTnFiOWMwV2hXd2dqU1Q0RG5XNjF5?=
 =?utf-8?B?cFpud2dxZEVZTFpSakZhdjNjNk9rQmlNWnNkdWR5NmdudG5ZREdLTWw2bWFh?=
 =?utf-8?B?a0dBRCtOTDBOeE5ua3pLZkhhT1VaTWF4MmQrTHdkYURhRnhMbmU1bUdtY3FY?=
 =?utf-8?B?eXhDUGhVVnhRK3krbEhFWTU0VUozTXBUOENGRUlsRGYxQ3ppVGhKTjVCZ2ty?=
 =?utf-8?B?NjFjdm1GdlRMdkhOVzFhaHdObG5xeTlwZnQrRkYrbHF5U2phUGxtTlo5TFVJ?=
 =?utf-8?B?K05MTlVGQkZaK0FVS3RReFNhMUJRdzAyTFBtaVRBUVdEcHpmT2pRZURZNFk1?=
 =?utf-8?B?d0F4RTJBejBNTHgwWmRvS0RmWm91R1RWMUMvU0tSeGFaSDltRTRxRmMrNkhH?=
 =?utf-8?B?c3JIcnhub1llUHhzSTNka0J1Q05IZDV5Q0FiMnlJN1h1VDJPVGNiMTVjdFpi?=
 =?utf-8?B?ZkZBRnRZRTIyaHd1c2FoYUhsTTFURHdRMjMyR25WUnhhVWpRdmJwL2Rxb0pz?=
 =?utf-8?B?cHJ0VCtMaWtFM3FyRXNXVS8xTXNoU1BBVnhqaWh2Ky9qRXRpTGI0OUptdExY?=
 =?utf-8?B?cmJRUDlmaG51WWc2MUVZMWhJTFdqblcyK0YyQUdpVmFRWGk4TDEvelQvdk55?=
 =?utf-8?B?VUx2MGxwQkcyOXlRMjY0UTY1cVZ3TG85TzkrSXFza2RzVHY2eWh6U2R0Yzkx?=
 =?utf-8?B?WTFrWU43UFZqNVdXUTFOV3NhM21ZRGcyeHZCYUlDaExzN0tqMzY5WVpTaU9u?=
 =?utf-8?B?b25nbC9mNkZhVVlrYXBvK3h2K1hVUU1kQlo1MkxHRzhDdEltcUd1QkYxTDZr?=
 =?utf-8?B?K1p0aVh3NytTd3o5VzU4YzkrVnlSQlBDS09BL01lUlljRFJ4cG00bm1LNkFU?=
 =?utf-8?B?WmwrYzV4SEN5SHo0TkJmdW5kZUNjUTZkYk14My9FcVV2NUZlZURjNWFGOFVH?=
 =?utf-8?B?WVJZVmQ1VTlRVGFydE9xa2Y3Wng2L2p6NkpQcWVsMWw2RDRRV0lPcFN4THZx?=
 =?utf-8?B?N1IxMWdnSGlaWjVSTExOUlBETEd5aE5LMVlWbnlFVSsrR0FFMWZYd09qaFd0?=
 =?utf-8?B?TkF4NTFLdUZOclhqcEtMU0VKSlRCR1FXNERDbGpZd0lpdVNjSktENDR3K0k1?=
 =?utf-8?B?c2lieTRSYTZlZ2hhaDhOd2FkYnlNekdVTVoxSDBvRGpjSUNVcHorOXlxQlFs?=
 =?utf-8?B?aC9NWlR3TXFVby9vd3lHZ1o1SEwzQ3JwVm5jVGxnRlY0Y1U3RTRHaWt0eElZ?=
 =?utf-8?B?LzNTUWdNZmQ5ZHd0VnRTNGxzZXBiK1VrdWRjYktaVHhSb0p5c0dLTUwwUG1C?=
 =?utf-8?B?MnEvZ1lYUEZPaXVtYnUwQ3R0bVVVZ3JQMVg1NGNFamd5ZVZaNitHQnUxU3o5?=
 =?utf-8?B?aG1CWEZCeTN5MElTOENkTlNYZzBrOXpJT09oNUpCYnlreFN3anlZSGF6RTVI?=
 =?utf-8?B?V08xQ0NSQTRwQXhWb2ZUdU5ZTUx4dzZYSWp3Sm9YMldxMkxDRi91dXhHdGZm?=
 =?utf-8?B?TE5SMTVueVA5c2RLaWd2Z3B5RVB1M21kb3hiSXV0N01qM25ienA4TkdEY095?=
 =?utf-8?B?Z2FqWDBMc1hlSHYyaEhKRDVrd0ducEVkam0vQkhsY3FIbVhFMk1tWDZoak55?=
 =?utf-8?B?SmRVcXRjTTB5b3FrQ1NLaDBXajhiVFo3dy9LNVkrQzNpZWw2blFRSzduV1Ix?=
 =?utf-8?B?UUhRdG1sRjU5YzNJV3labTY3RUVaemZ3UGVxUk8rSFdrb1RJbHhYeTNVNXVk?=
 =?utf-8?B?VVlVZHB3MFczNGtLTi8wQ0p3bURoemEycWY1dms3TlJIL3RCYlVqQzluM241?=
 =?utf-8?B?SGZKcE9pZTliWWk5cUZvMFZnbmdqT3FiSUwrQXA2ajVBRFpJOW5yVzluRXNK?=
 =?utf-8?B?bXBDKzlUcSsweWNvSXVFWTVlUzl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CAF52005AB84845BA5C6DB288306731@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R0QDh/eDvWWJk6HlVeZ8Y3sJr9TsqBnpUlCM6d30odjsG/1EQcEN/hDXMU09GohDS5Cci6Zfap3fZvW+gMtrOFgWZxv8umKZTo/ztanHstT2mBv2m+8+Y+DvcjMAxmJ1yRCZJfB0yosXH5t81diW+oUy1v16zvadjL7eSIEOMVfPnkcWEeg39nIKnxx6En8U3oNbn2hxZ+keNXdzTvjuzb6ptEM/LvX0cz/Clxcm9DNtmk4VzfFHDA0HhTK+ozFTgetSrsoxU4z0GSutf+CFmij/D2IUsHt0zO7h/LN3MmsaxFOd5k+AKeT1GIHXdHZEibkeIVTbuUmfsXS+kBIhB/QYKIYuvy3Sw1kCeqLa+gGOt8iiFB9NWc/6+V662CESAhpgFze4Mps0XcTHYWIAjkzcwnQWM6k05eGIAG91v97Lz77J+yPH+yN+IGfP0or+DxA0yuF1b2T/0A3acG8BY+pba+1UNxRPIc/FfhwhTrIhBdm1rgWiratLYERfRHOe5gjx2PelNu4h1XHiqPTNyxOnZtBbQT7lKLJk7M7Z8alAjSOKSxe1kZxqOlrs0nLMHSGFzVAwq1uBzovoRCrVnLCBdyg6V951SrdrMvTYcKUmwdcQVtYLynlrPQ1OGO+RhXwfTjX62nQyjZnbf7yLX6jRUespayU1GJZ8FDn7eQtLSvgEKobfWajKjYwocLUHMOPoZwdVcUU7qskXpn/DPiYg2JTJz1c5uoIRBaMxannSS0CYX1nvzv1Ug0ECgadqOMgBBubAUHIRr9PGG52ZwIt/zSohPuepzBfjwtlZhp4OZLDeokRbqxFIOW7UabAz8Y3X1GWM6RWutSy6C6ISRg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fabf04fc-df5f-4f84-eae5-08dbc96c187c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 08:37:10.7230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PwYdMMwZ3EnkhA1U1IZoDQPFPwl/ko57d2FjcxpbcUTXjZzla/ol6hEhzvpo9KfEkAJbl2vdiyBcWchxjvv3g5LeKPJqWge5ekmxwLctaMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6477
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDkuMTAuMjMgMjI6NDgsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiBPbiAyMDIzLzEw
LzEwIDAyOjMwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiBJbiBjYXNlIHdlJ3JlIHNj
cnViYmluZyBhIGZpbGVzeXN0ZW0gd2hpY2ggdXNlcyB0aGUgUkFJRCBzdHJpcGUgdHJlZSBmb3IN
Cj4+IG11bHRpLWRldmljZSBsb2dpY2FsIHRvIHBoeXNpY2FsIGFkZHJlc3MgdHJhbnNsYXRpb24s
IHBlcmZvcm0gYW4gZXh0cmENCj4+IGJsb2NrIG1hcHBpbmcgc3RlcCB0byBnZXQgdGhlIHJlYWwg
b24wZGlzayBzdHJpcGUgbGVuZ3RoIGZyb20gdGhlIHN0cmlwZQ0KPj4gdHJlZSB3aGVuIHNjcnVi
YmluZyB0aGUgc2VjdG9ycy4NCj4+DQo+PiBUaGlzIHByZXZlbnRzIGEgZG91YmxlIGNvbXBsZXRp
b24gb2YgdGhlIGJ0cmZzX2JpbyBjYXVzZWQgYnkgc3BsaXR0aW5nIHRoZQ0KPj4gdW5kZXJseWlu
ZyBiaW8gYW5kIHVsdGltYXRlbHkgYSB1c2UtYWZ0ZXItZnJlZS4NCj4gDQo+IE15IGNvbmNlcm4g
aXMgc3RpbGwgdGhlIHNhbWUsIHdoeSB3ZSBoaXQgZG91YmxlIGVuZGlvIGNhbGxzIGluIHRoZSBm
aXJzdA0KPiBwbGFjZT8NCj4gDQo+IEluIHRoZSBiaW8gbGF5ZXIsIGlmIHRoZSBiYmlvLT5pbm9k
ZSBpcyBOVUxMLCB0aGUgcmVhbCBlbmRpbyB3b3VsZCBvbmx5DQo+IGJlIGNhbGxlZCB3aGVuIGFs
bCB0aGUgc3BsaXQgYmlvcyBmaW5pc2hlZCwgdGh1cyBpdCBkb2Vzbid0IHNlZW0gdG8NCj4gY2F1
c2UgZG91YmxlIGVuZGlvIGNhbGxzLg0KPiANCj4gTWluZCB0byBleHBsYWluIGl0IG1vcmU/DQoN
Cg0KSG1tIGluZGVlZCB5b3UncmUgcmlnaHQuIFRoZSBwYXRjaCBwcm9iYWJseSBvbmx5IG1hc2tz
IHRoZSBVQUYuIE9uIHRoZSANCm90aGVyIGhhbmQsIHRoZXJlJ3Mgbm8gcG9pbnQgaW4gc3VibWl0
dGluZyBhIGJpbyBmb3IgYSByYW5nZSB0aGF0IG5lZWRzIA0KdG8gYmUgc3BsaXQsIGlmIHdlIGNh
biBhdm9pZCBpdC4NCg0KUmVnYXJkaW5nIHRoZSBVQUYsIHRoZSBLQVNBTiByZXBvcnQgcG9pbnRz
IHRvIGFuIG9iamVjdCBhbGxvY2F0ZWQgYnkgDQpidHJmc19iaW9fYWxsb2MoKSBpbiBzY3J1Yl9z
dWJtaXRfZXh0ZW50X3NlY3Rvcl9yZWFkKCksIHNvIGl0J3MgdGhlIGJiaW8uDQoNCkxldCBtZSBj
aGVjayBpZiBjaGFuZ2luZyBiYmlvLT5wZW5kaW5nX2lvcyBmcm9tIGF0b21pY190IHRvIHJlZmNv
dW50X3QgDQpkb2VzIGdpdmUgc29tZSBoaW50cyBoZXJlLg0KDQpTdGlsbCBJIHRoaW5rIHRoZSBw
YXRjaCBpcyBzdGlsbCB1c2VmdWwgcmVnYXJkbGVzcyBvZiB0aGUgVUFGLg0KDQo+PiBAQCAtMTY2
MCwxMCArMTY2MiwyNiBAQCBzdGF0aWMgdm9pZCBzY3J1Yl9zdWJtaXRfZXh0ZW50X3NlY3Rvcl9y
ZWFkKHN0cnVjdCBzY3J1Yl9jdHggKnNjdHgsDQo+PiAgICAJCX0NCj4+ICAgIA0KPj4gICAgCQlp
ZiAoIWJiaW8pIHsNCj4+ICsJCQlzdHJ1Y3QgYnRyZnNfaW9fc3RyaXBlIGlvX3N0cmlwZSA9IHt9
Ow0KPj4gKwkJCXN0cnVjdCBidHJmc19pb19jb250ZXh0ICpiaW9jID0gTlVMTDsNCj4+ICsJCQlj
b25zdCB1NjQgbG9naWNhbCA9IHN0cmlwZS0+bG9naWNhbCArDQo+PiArCQkJCQkgICAgKGkgPDwg
ZnNfaW5mby0+c2VjdG9yc2l6ZV9iaXRzKTsNCj4+ICsJCQlpbnQgZXJyOw0KPj4gKw0KPj4gICAg
CQkJYmJpbyA9IGJ0cmZzX2Jpb19hbGxvYyhzdHJpcGUtPm5yX3NlY3RvcnMsIFJFUV9PUF9SRUFE
LA0KPj4gICAgCQkJCQkgICAgICAgZnNfaW5mbywgc2NydWJfcmVhZF9lbmRpbywgc3RyaXBlKTsN
Cj4+IC0JCQliYmlvLT5iaW8uYmlfaXRlci5iaV9zZWN0b3IgPSAoc3RyaXBlLT5sb2dpY2FsICsN
Cj4+IC0JCQkJKGkgPDwgZnNfaW5mby0+c2VjdG9yc2l6ZV9iaXRzKSkgPj4gU0VDVE9SX1NISUZU
Ow0KPj4gKwkJCWJiaW8tPmJpby5iaV9pdGVyLmJpX3NlY3RvciA9IGxvZ2ljYWwgPj4gU0VDVE9S
X1NISUZUOw0KPj4gKw0KPj4gKwkJCWlvX3N0cmlwZS5pc19zY3J1YiA9IHRydWU7DQo+PiArCQkJ
ZXJyID0gYnRyZnNfbWFwX2Jsb2NrKGZzX2luZm8sIEJUUkZTX01BUF9SRUFELCBsb2dpY2FsLA0K
Pj4gKwkJCQkJICAgICAgJnN0cmlwZV9sZW4sICZiaW9jLCAmaW9fc3RyaXBlLA0KPj4gKwkJCQkJ
ICAgICAgJm1pcnJvcik7DQo+IA0KPiBBbm90aGVyIHRoaW5nIGlzLCBJIG5vdGljZWQgdGhhdCBm
b3Igem9uZWQgZGV2aWNlcywgd2Ugc3RpbGwgZ28gdGhyb3VnaA0KPiB0aGUgcmVwYWlyIHBhdGgs
IGp1c3Qgc2tpcCB0aGUgd3JpdGViYWNrIGFuZCByZWx5IG9uIHJlbG9jYXRpb24gdG8gcmVwYWly
Lg0KPiANCj4gSW4gdGhhdCBjYXNlLCB3b3VsZCBzY3J1Yl9zdHJpcGVfc3VibWl0X3JlcGFpcl9y
ZWFkKCkgbmVlZCB0aGUgc2FtZQ0KPiB0cmVhdG1lbnQgb3IgY2FuIGJlIGNvbXBsZXRlbHkgc2tp
cHBlZCBpbnN0ZWFkPw0KDQpJIHRoaW5rIGZvciB6b25lZCBkZXZpY2VzIHdlIHNob3VsZCBnbyB2
aWEgcmVsb2NhdGlvbiByZXBhaXIuIEJ1dCANCmN1cnJlbnRseSB0aGVyZSBpcyBub3RoaW5nIHRo
YXQgcHJldmVudHMgUlNUIGZvcm0gYmVpbmcgdXNlZCB3aXRoIA0KcmVndWxhciBub24tem9uZWQg
ZGV2aWNlcyAoYW5kIGZvciB0aGUgUkFJRDU2IHdyaXRlIGhvbGUgZml4ZXMgd2l0aCBSU1QgDQp3
ZSdkIGhhdmUgcmVndWxhciBkZXZpZXMgYXMgd2VsbCkgc28gd2UgbmVlZCB0aGUgZml4IHRoZXJl
IGFzIHdlbGwuDQoNCg==
