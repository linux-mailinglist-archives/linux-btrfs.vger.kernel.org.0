Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D393E6B2303
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 12:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCILaA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 06:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCIL36 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 06:29:58 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19516270F
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 03:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678361398; x=1709897398;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gGC774sRsyf13yaRtLnUIA6nH29pQT9EKnoIIaINNDs=;
  b=TZewt4dLoaqdPd4suCbjqyXGUaljP/M44glT9IYlQHNI73Ey6zvDVsQK
   sxEkV7hpSVbX24U/OLFyk/k9Uk36mW+BHNgXND7H7vqgq6aOxp8pgG82y
   7fFJQnRqW4W+CTvDwnN189ajyP3OFoHKgGrMwEP9M8JC6oD5eRw7TWmnM
   Kp8DYf69qjIc7uXmnNEowO2VbY+/FuS2WxGjIOHkZRESJ9IolDRRvHpEk
   OQNf1ANmBPCmEOlsV87S7qq3V2qIcCC7oUYp8IqlU8oCx3a+a2nx6G783
   D+xLKTX7AxqCeNuuHng6yd7+epuU0gMhtqPbw6czDKNfj8MxCIEqQQtM3
   A==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673884800"; 
   d="scan'208";a="337211209"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2023 19:29:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPPGuWbLG1rRrb+NTQfUNQRBJ1+2d9kzHUGnZ2CHYTPdRXzUP/OHjOssQDAchbPQdGVBZeAFbQMDULTjsHGzvloZIU7cAL6gW38Ywb8YQtwKBKoBik6PEcXg1uNcr7KUZcU3h7Tlc4jnGxmoN2TnDIRwCj9Ieanges2TI6QQ3r84jPf/2WCdovOCejM4OPxAc19EzKWUgrOvI4AwI3tF7T+hNsBSvS4L4Q+l6EiYEhLvXOqOPzaVJ0KAQiuUtWJLXJVcd+EZyNJt9hOpjEEJyPbdSgAYLqdk2fQnBL9wJ9qns5jDux3VFL26rljW4Ut5uSHcNBQUdmLyKK932A6t5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGC774sRsyf13yaRtLnUIA6nH29pQT9EKnoIIaINNDs=;
 b=hCfNR0jO+hVbK/bb5iXJVFjLZvWrtjJYAuTYZMj2htYNHnT/Vv1jeP9dKMU8zN+p7QnsF/zmXMlvZi4KUOtcEuQOdPLLWSo550ieVibzBWHF4HthGjMjuV3zn2Xez0Zg1/09X4FrUvKdaG/m2ZWEcGJxbGMmSg8svXSgAfMpSpxtNIVy39Oq0nwUJx1fwG7XnN5BCkgSklG84WcQPvXJIww3DBGL7YPQx0ZITJMtVJntHa2D5dp5747U21AnrrzHuHejipXIJxKifhHtTPApXFlbR8ihmfswSS/Q7T0cVqCAMAIKy6FDCJ7bbQx5qmcUecw8pDs1GK3oJyl7chc1gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGC774sRsyf13yaRtLnUIA6nH29pQT9EKnoIIaINNDs=;
 b=N/PhWMOFc85r2IUCBCwBV65AlB94IxIMCRLvnaCe3WGIzgh3wvwXNT8YgzgY0FxW35KwxkzHf86vMxmKmM5i8BuR/AoMOZD2MmKgeYdWnBuwXoTGryqD/JeIDFTIm1Euj/SUyPrU7ilyVd+gJ38hvh58sKkGZX9a0v7T8TH0JAw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5785.namprd04.prod.outlook.com (2603:10b6:5:161::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Thu, 9 Mar
 2023 11:29:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 11:29:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/20] btrfs: always read the entire extent_buffer
Thread-Topic: [PATCH 04/20] btrfs: always read the entire extent_buffer
Thread-Index: AQHZUmaKkYmnhQ33W0yPlvAlHDSdvK7yUCKA
Date:   Thu, 9 Mar 2023 11:29:54 +0000
Message-ID: <d2f3a67e-cd76-5d02-e7f1-9e7cab1a31ec@wdc.com>
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-5-hch@lst.de>
In-Reply-To: <20230309090526.332550-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB5785:EE_
x-ms-office365-filtering-correlation-id: 2ad02e92-7225-46c1-4f3b-08db20919ae9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6f+2mDanNcPDpj4QEjQe+dn9lHNR8ORZFBa5jx2Uuix2PBI5nwFoZ5nqsVfx8JH73eDi9IleRxlPVou6n24CjOOJnM7H1VYQR2WO1FdZHutcdan+VR2CI/8iFt/bZjgj/LSlfOYwT32k6KDsp5kdD2tO7LF0j2iDUhLSsewQas3wSGIEiP8kxH6Oi2pA4PnQcWMg5tryF+Xmdmyzyu3rFYQ5q8XE15qeDUl/u4t/wnHOVuX/J+kOLiTyHqvFgGBpiECiDw+kLiP8m7D7ACWojnOTtvwSRfPA4ePppwtnAsDZk6BvIU+lHLdStbfwriFH2FF0jcNIUSjppQKiVgnQJyIOWfQuH53pBcYLbUgmEmT8Ck0Sk+jiE1lY22mEnk33pjamre3ryJkOAB1SdVXRnV9MY4VnDu1mK5Z9nAO7OGyAGmAT+VT10TlO+NV67bCLztWx0PTOO7QySoduJR/g2WuPd2pA8Bcp5Kzt3HZdktH+1fxwAKJGhIu+frU5d7LNCZzzjxSpdOS+g5EwWwr4qTHe0JwzqRE09+1EArP49oOU1iPDC8M50GfuxbsPJJ/iDxxOUlboDKXhwKKwIaB6AMSwmU5jUcUX7gbv7Og4DVWH7A0rRRjIBVFNOTkllellSXMshksR2aRIaNVHCxCz4UciTDrLF8Ec2DqzQJ+Fq9Ua3hKb0JvX2nDd2e1n+ipdQlvPTxayfm5vxG+6n4LAiHnv+i2EEj8LqmOr7z5uqbqpTj1JKP9oxoB78Y0Syywn8L6EfIEiYWY5stY0yeWXWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199018)(76116006)(66446008)(4326008)(66946007)(66476007)(64756008)(91956017)(8676002)(2616005)(31696002)(66556008)(6486002)(36756003)(71200400001)(86362001)(83380400001)(316002)(5660300002)(110136005)(8936002)(38100700002)(478600001)(38070700005)(2906002)(186003)(82960400001)(41300700001)(31686004)(26005)(6506007)(6512007)(53546011)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUFtRDJVdGFXby9BR1o1MDZjQ1JjOWJKZU5hVHpGakt1djhoc1VDOEhlNXVt?=
 =?utf-8?B?b1l1NCtpOHRaaWhiRmViK0lEUkRWK1J0Njhrc3Vib2F2T0JIR05NcHRGeTZq?=
 =?utf-8?B?dWZPcXZUTnpkeXdvVlQ1b2xkaGc5MHRxaC80QUdpMHFwZlRxbW4vREt0MVFk?=
 =?utf-8?B?MGg4ZDlzNXJIdlRWMVR6aXJwQ2JDUEl4dERxQ2o4VTBiUkJuVWsvSGR0RGJp?=
 =?utf-8?B?SFZualZ3VzkvSnRveDExK0VHOTBRMnBhRTlZelBNZXZKQnZzcmI5eXBFNm5Y?=
 =?utf-8?B?REdBODVTdVFjWjVFc3orbkl1VTNUek1kQ0Y2R1FzcUhlbUlvSGdOc1hKTFVZ?=
 =?utf-8?B?QnR6WkM2UDNMUXFhWXEvZFdzRGh6b29xNitWc2J3RnJvbUJLQkFNNGtjdEs4?=
 =?utf-8?B?MzJ5VVdIc2VNbEo2RlV3c1RTckxWcEV0NEM5cjZIdEhVZFVUZU11Y2tXZURO?=
 =?utf-8?B?bVQxeUEzQjZSK05lVFZMVkhpYlNEQkhidFdETUxEUml1NTkwNGlqRVA3eXUw?=
 =?utf-8?B?Mll2RDVaaGhTakdlZXhubGhGM01XN0xaeTRGckdTbTFKUFVVWkpNRzhSYWxs?=
 =?utf-8?B?UmNUWlU2bE1NMTdQL1IrVmdRU3UrQWNCYmIzTjBqcGs4eFVuOTBXQlJkMTUy?=
 =?utf-8?B?a0MxL25GczVXYTVqRGlTeTBmVnFsSjBOK04yOHVIZGdGNlJpNG11eGlzVkta?=
 =?utf-8?B?VS8zNU56aG9DTUpvOVM1SjloRXZubU1CbWJHU0R3ZXJ3R3JDRnBMVUlHUzZl?=
 =?utf-8?B?NTYzcXJNanU1Wk55bWtpQ1dwUVN4U252VSsrSmg4YnRjUE16R28ycW41ekUy?=
 =?utf-8?B?cmpSUkNnVlNSU1NkTUNEYXhKOU9XVWlEZ1IwbWlKVnMvTXFPTDdmU0Y5azh1?=
 =?utf-8?B?NmNQOE42UDIxL2o5a2ljYUF4eWpVVnZ3RWJxTG1EZWMzc2hvZ3oyZnJ0aS9G?=
 =?utf-8?B?N1VHUCt2VW1sZVNEYUF6VnV6WWlWWXh5SXVxUVA0cVVtQkZud2Q1eVdIc0Ra?=
 =?utf-8?B?V3lPR3dJbUFRc1RNZ2htMFpNTGxrOE45L3l5MVB0Vmk3eWZtdnVsVmlIdG1p?=
 =?utf-8?B?Vk4zN0JycVg0TDEraWxYUzBYMmNPNWZlaWdUWlE2KzZTaENVbzM5L0hORHNs?=
 =?utf-8?B?bS85VVA3NGZkaW5aZlZHQnRsckxlSC9mM3Z4dlN0Vm9JY0s2aEhTZVNrMlIx?=
 =?utf-8?B?WWNheldMVXgySGduSkhDM2xvbUFGSThUMEtPOGIrNXlmMFpzUDZkdXR5ak1V?=
 =?utf-8?B?SnhPYU9rdTR4ZjZ2SG1ROXloYStpcSt1TVljV1pPN2xOWGFnVjBGc0VoUjRQ?=
 =?utf-8?B?cDU2cnFPaUQwRzBlK0ZKckt4dHdLR3BYTzJVOXpkVXUzRDVPb2RFQzNFYklT?=
 =?utf-8?B?eGlBTUVDZVJhY3NBTHN2YjVEek1ZQlJHSVg4Q3YwT1JCZVVaejNnRmRJbjBo?=
 =?utf-8?B?TjhHaENGaGNLbjBnKzZDNWMyaVhEcmw1QUprTm5QQktqK0RkWERoNjRYbGpw?=
 =?utf-8?B?dk1hdnpOaHRSYjFaWDZlMVFUY2wxdG1iT0Z4Sk1BblNsR3VqYURBdGRrNEZj?=
 =?utf-8?B?K2MwdjFtZTR4NXNISU5vQkEvQlQ1bXFrWmtGS3ZWRy9OTnM2MEhma2l2U1Np?=
 =?utf-8?B?RDY2bk9XZVNmT0hrTFU2MWJlWCtWNUVNQW5QbTN4amhsMnNsTEdpQk5LYWpL?=
 =?utf-8?B?RXZqWW5LSG4xclNQR09oL1d1cDV6N015cW4wcTNLNUlIY1pYNXRKZkRkV21N?=
 =?utf-8?B?RENGdGRtb25ZemFyQUd6bnBxN3BjVkpXQ2F5dndNK2xsTHAyNDJsTXJzNVM2?=
 =?utf-8?B?WTcvbjhWSUFjZjNpbHdvZWJkMFMwdzgyeUlyV3NjNjBIZTNaQzIrdllyZjJC?=
 =?utf-8?B?R1lyZlBoZC96bmllVmhpNnZOQUFXQXFTMExNanpvZ3l1cEdhSm9LV2hUUHpF?=
 =?utf-8?B?NFBRaVFkZkwzTjlXdWFWMDRra0xWNmp0ajh0SDNxazE2L1JHUVRyTEtwZW5P?=
 =?utf-8?B?QXVuNGZNQU5NNE81dkpKc3ZONmlUODJWdldUbDgyemZmVFJXTWdsenErRkJD?=
 =?utf-8?B?aXFDdmF4aGZwU09qT1N0R3lXMkVHY3hnamJiSXh4dzkwQjdRS003VFBIb0d0?=
 =?utf-8?B?YlVPQlJtUis4Mm1IZnNrazIwR2pnMnpPUDAxWitERFJ2VWY4ejU4YnpzdVBH?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFD32B9EA0A5F54E94A3805927E7051A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fY0eRNh2r0lIe8oSjd0PnnxmB24BA4nCkQB6JuXPZcuxZdF1suSCwulIQNldPxkgmL08+KOaK4IBHKEDdQfydR9aWYXVEG95/FYaxjBTdSoadDW0VR1rICF+Dwdw3b/i3NA22y4/062RiS3Jncg/CJxRQZYEjxJFKyxG93fKXajX24rAmAX9Pqo4vTvP1CDWzD+CTmtk9PNR2yUDk+etfgQoxA2F14Mouh7tcDf9AsOzeliOi1WTsWarn5mZLtpElM+ZeK6/2eHyEGRV0pQ4vbZOBIf32KYb1M2NcGnGTyRY4gFL67rsOOfz637qoN7+K9nu6vp94gLyHjHFXEoXeerdcOUUlE0l0wk7VgYcBtHqcpqi4DwblLFaQ4fuXV3LPU13SKuvbaM+fWCRHjo+dZnPZNwEayUgdmkwY8rbR2TniQBbMjBwgHR1HT0bOki0FkGxxFZmnWB5ICd/266CUAmEWO2yXFFaNUXmTXvH9UQvIC9Fyf/xCvd1fiKoZ9do0XW6/wipHJrz9o/RvJopw2IS3KP63tRhkYr3pm+KdeKyIICjbf1g1dOYlGwoYT+hz+2ELRto2y3TLw741Uki8KxOa0YNexD5nzjxXoamHzlwvsezkw9TC8mr+7sncWyzJS6tdzAgvfna7DWDl0O5MTHcd1+RI5kB5qNBfeqVpmmXRjhoh6z1fGBt4oKPFGH9oqta7+Py2W1LTqGacjQH22X4jttdyivhTM9qi78oS/t2l3jyr1jqcAXYN3R35nzqTiGJHkujamFzCPtA3B0ew6bb/0juZ4byJgpXuvXtlU7AYsV/A9Y3ZcWxFIYJztmAV64HAu1gBBHv6bbSpauOlJEwk7v7qNovBZ4PO+ozow7xublOxAJjHMi4kEblN7A7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad02e92-7225-46c1-4f3b-08db20919ae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 11:29:54.3761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AMSGvstiR7s6YA/96WaQtK/WbINkcJv3FhDWCbcU19wQuyhyc90wnmUCXvthndVK5O6q/hGOQo0B5rDoU+A0apNgafmVqEfjBrjoq3C2uNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5785
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDkuMDMuMjMgMTA6MDcsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBDdXJyZW50bHkg
cmVhZF9leHRlbnRfYnVmZmVyX3BhZ2VzIHNraXBzIHBhZ2VzIHRoYXQgYXJlIGFscmVhZHkgdXB0
b2RhdGUNCj4gd2hlbiByZWFkaW5nIGluIGFuIGV4dGVudF9idWZmZXIuICBXaGlsZSB0aGlzIHJl
ZHVjZXMgdGhlIGFtb3VudCBvZiBkYXRhDQo+IHJlYWQsIGl0IGluY3JlYXNlcyB0aGUgbnVtYmVy
IG9mIEkvTyBvcGVyYXRpb25zIGFzIHdlIG5vdyBuZWVkIHRvIGRvDQo+IG11bHRpcGxlIEkvT3Mg
d2hlbiByZWFkaW5nIGFuIGV4dGVudCBidWZmZXIgd2l0aCBvbmUgb3IgbW9yZSB1cHRvZGF0ZQ0K
PiBwYWdlcyBpbiB0aGUgbWlkZGxlIG9mIGl0LiAgT24gYW55IG1vZGVybiBzdG9yYWdlIGRldmlj
ZSwgYmUgdGhhdCBoYXJkDQo+IGRyaXZlcyBvciBTU0RzIHRoaXMgYWN0dWFsbHkgZGVjcmVhc2Vz
IEkvTyBwZXJmb3JtYW5jZS4gIEZvcnR1bmF0ZWx5DQo+IHRoaXMgY2FzZSBpcyBwcmV0dHkgcmFy
ZSBhcyB0aGUgcGFnZXMgYXJlIGFsd2F5cyBpbml0aWFsbHkgcmVhZCB0b2dldGhlcg0KPiBhbmQg
dGhlbiBhZ2VkIHRoZSBzYW1lIHdheS4gIEJlc2lkZXMgc2ltcGxpZnlpbmcgdGhlIGNvZGUgYSBi
aXQgYXMtaXMNCj4gdGhpcyB3aWxsIGFsbG93IGZvciBtYWpvciBzaW1wbGlmaWNhdGlvbnMgdG8g
dGhlIEkvTyBjb21wbGV0aW9uIGhhbmRsZXINCj4gbGF0ZXIgb24uDQo+IA0KPiBOb3RlIHRoYXQg
dGhlIGNhc2Ugd2hlcmUgYWxsIHBhZ2VzIGFyZSB1cHRvZGF0ZSBpcyBzdGlsbCBoYW5kbGVkIGJ5
IGFuDQo+IG9wdGltaXplZCBmYXN0IHBhdGggdGhhdCBkb2VzIG5vdCByZWFkIGFueSBkYXRhIGZy
b20gZGlzay4NCg0KQ2FuIHNvbWVvbmUgc21hcnRlciB0aGFuIG1lIGV4cGxhaW4gd2h5IHdlIG5l
ZWQgdG8gaXRlcmF0ZSBlYi0+cGFnZXMgZm91cg0KdGltZXMgaW4gdGhpcyBmdW5jdGlvbj8gVGhp
cyBkb2Vzbid0IGxvb2sgc3VwZXIgZWZmaWNpZW50IHRvIG1lLg0KDQo+IEBAIC00MzU5LDEwICs0
MzU4LDggQEAgaW50IHJlYWRfZXh0ZW50X2J1ZmZlcl9wYWdlcyhzdHJ1Y3QgZXh0ZW50X2J1ZmZl
ciAqZWIsIGludCB3YWl0LCBpbnQgbWlycm9yX251bSwNCj4gIAkgKi8NCj4gIAlmb3IgKGkgPSAw
OyBpIDwgbnVtX3BhZ2VzOyBpKyspIHsNCj4gIAkJcGFnZSA9IGViLT5wYWdlc1tpXTsNCj4gLQkJ
aWYgKCFQYWdlVXB0b2RhdGUocGFnZSkpIHsNCj4gLQkJCW51bV9yZWFkcysrOw0KPiArCQlpZiAo
IVBhZ2VVcHRvZGF0ZShwYWdlKSkNCj4gIAkJCWFsbF91cHRvZGF0ZSA9IDA7DQo+IC0JCX0NCg0K
SSB0aGluayB3ZSBjb3VsZCBhbHNvIGJyZWFrIG91dCBvZiB0aGUgbG9vcCBoZXJlLiBBcyBzb29u
IGFzDQpvbmUgcGFnZSBpc24ndCB1cHRvZGF0ZSB3ZSBkb24ndCBjYXJlIGFib3V0IHRoZSBmYXN0
IHBhdGggYW55bW9yZS4NCg0KDQo=
