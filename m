Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD0062D950
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Nov 2022 12:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbiKQLWY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Nov 2022 06:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiKQLWW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Nov 2022 06:22:22 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98422C647
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Nov 2022 03:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668684141; x=1700220141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=JuDQ5STTCz12KV4t20sUg0iGtdJAYXyv5EtYPhLHFBO3gp8W9bRZ0+eh
   YSbABFqsIHHDb+6+VPzAJuQeQylQNdj6p1jvvHwU8sYDKUOjq2pSVxQx/
   SIABcCgd/plurP6WplFJUfUmt06fG8ay/XX1t2qCXLxE0DA8U13bbQACX
   ZG2afeCYQy+H+pXQjn13ShWzED0hhA5YUgTQrI3+sbMtGCk+wl+rtuML1
   cimNywAwZA4h1VGYczy4Qivmj6+vI/IsbSp/n7bqa0wxVfKvyF3SeTejC
   ufXHUBMKgF9al6CGypLvvhs9Ifr9wDDOrTMaRd1nDFlqnm/q7y4bc6dbM
   w==;
X-IronPort-AV: E=Sophos;i="5.96,171,1665417600"; 
   d="scan'208";a="214772047"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2022 19:22:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeXEYxUUfk/CaE7kf+gRRK3/OPqZ3i1ljOeUXqzVwGCYEDB5OVmRVH8r5OMSvDmt0tA5VPy4ymklkrwy6OWAzJ3DGIg/P4Q6J+fiAnEm0zdcKQyYVeILClQA3hQos9E/ntUrbj/vEi4hCc3wRsZulAFkRm8h63D9Skom7d5e0T2AUWC1jy8Uk2ZdqK9ZPy1mNi5sY7xqVYW/JFBkIW1duTLvNdTz9FNYS67wAcGB9ruRG1Mk+gH0utA89p2HFkMAc2NmmmrjpW4bt3wwYRL0XL7dpz0VMqWbSB54Q/yP3fiM+QkbavzlWXSSt3ysdBbsDfiMvxP1PivoCz1IpUC8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=BBahf//P1QaTOwwiVYcRwE0ZRhSnZcGfAGCI2kxcXhdJla3CmyiwI40cdl5o80BnyZh09xq9N3tjJlwB1pAVrgndIi2fBoR6YingWLYRSrFEBVdp3u+JgG1Zd8YYWLyFUNb1mCJ5yAXRxLCJI05s+xUEK4ECHybY0Rat0pz3OVJMK6dJFGJLus8hJbqLmXhQXkqYJgc5MLmJRlEw2Dxp60nlbOdH6yBI02fDADpYGw+iUcA/bE8VKpwE6haWll4EcPFrYHEG4TpYERto8MaQkeHyGQN3z/GQIpQjrypkFGq9ju38yQJjU7jVU+7WJXzr2yjHeTqdR4U/v8pnf24+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=jYp6DFvtX89TaNFFfYxP/tkTEfBs+HeWvk3z8kE0digJbbL4p674mJt8POzsAC3teGg4vv08XMa4UN+FQRvvAKfAhDixH7/UwhDambCQ6jGCp31TSZnb+rJGQ8Lii9Wc1jtqiKl4hgi6Y3w0Ve7zLJQkQB1pupLCUOy1+ShF1Ew=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5324.namprd04.prod.outlook.com (2603:10b6:5:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Thu, 17 Nov
 2022 11:22:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a%7]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 11:22:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 03/16] btrfs: wait ordered range before locking during
 truncate
Thread-Topic: [PATCH 03/16] btrfs: wait ordered range before locking during
 truncate
Thread-Index: AQHY+RxlEmy/M2Fq1keiFlJSnT4Jva5C+3qA
Date:   Thu, 17 Nov 2022 11:22:18 +0000
Message-ID: <38e82f01-676a-4be9-f43f-609c69314e83@wdc.com>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <07644d32ba3e517e26199b4b78f81636655a7702.1668530684.git.rgoldwyn@suse.com>
In-Reply-To: <07644d32ba3e517e26199b4b78f81636655a7702.1668530684.git.rgoldwyn@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB5324:EE_
x-ms-office365-filtering-correlation-id: 715c8562-f117-484a-74c0-08dac88dfccd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ewhZ9d9Ukm2hgZLy48RLudQmOULT52web7E0lBktUepdvamZC3HmH8MyBP/iCsbalBO0hxikqtbkQheX5yIOP5m4hl0J1CIMSNNIhfL7bgf0VW89Kpa9P1IHDf9ZXx+NZZj55vXn7JbEYaJqM1G+H319cdK1XA0gIufpmUtNDfcqPJA6K41MOuRrx3EQxlKQ/q76NIG5CmB7HEM00XP8niAkNXEljdY+11CogKHuLp+BBKcK/3B14t7Csv2Cm3IxCdLW3YdpDZ0tnvPmEDb8we8cZ6rL9rVUnGfAzA0xKx6crthvpq+0N9hEQrZKgLRNn6Ovvgr5d68livXdAFpn1xpQKr8n1XetlAAT3Los7NwS+6vKOaVpJzUxtyFz7HQSPmdJlqMRDfqVsdUzihjimbCVe8aYYkIcx01R5ynIcA+wPCp2eKiF8jgL5LEkEI+wvAM+3TbzCNKq4/4KiBMWzNKhUYptih4PZeojhNDYfiTDJ2onATZZ9Um9IbU9+AH2ssK/IUW1m/G9PIqJTBFDB02iaU1dAR7qEiIZXOvmDOwEcmHNsFkWbA3V7OvzhfwYkV0AHNGUj7f9SxTqim71IdDoDGJuUU9oFSAjKUGOJkZ4LChuUNtcng+aJOmALjSrAzgBPe0JwSHpTwEJ8NTFxXMwrl938geQ9Jozu/8XbL0D6lqoGfv3ffUnuRNuKOlxxOPDDdzY2DJMbStPHNWOJILRBST45bv/h1H3+CjKo2bSFjjvWd9ZvKy3/ahEV2bFFEqmDzX2JCBlRj82snAoVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199015)(2906002)(31686004)(91956017)(19618925003)(66476007)(66946007)(5660300002)(66556008)(8936002)(8676002)(66446008)(4326008)(76116006)(64756008)(41300700001)(6486002)(71200400001)(38070700005)(2616005)(82960400001)(110136005)(36756003)(186003)(6512007)(4270600006)(26005)(316002)(478600001)(558084003)(122000001)(86362001)(31696002)(38100700002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU5QU3RVWk5rdEpiL2kwZjVlSlhlZHRWcEZnZE9EUzdTOEJMOGRjeU9BL2s5?=
 =?utf-8?B?eXJ5QUFlcVNxTkgyeXRhT2VIdE55RmllNnlHTVhRZXNZaFo3T09oeExVcDJ6?=
 =?utf-8?B?ek1XdldIWGk5YWRYUisvRTlraUFhb3k0LzNLRlczblRycE91QzdkUS9MMEFI?=
 =?utf-8?B?emp0VTVlOVorKzVMZktZL2kvaWNVbUcySmdDTDA1YnYrRm8wZEI4ay9ZRkYv?=
 =?utf-8?B?RUtYcFRURExvVzNIWnhlWFRiTkVmM2xHYTVHNmpaVWYrZEJXTUQ0MEFMOGVX?=
 =?utf-8?B?KytjTnFJS1Y5dzUvWmRIZ0xIK0NUVWFJZVcwTEdYZUpmTTdyZDV0MnFwK0dh?=
 =?utf-8?B?aVFrUVF0UVRnWjNxMUZiUVRLdmMxazB0L3dFVXB0eE5QSk91cnJ4QmtmVGcz?=
 =?utf-8?B?QW1ZVXhOYkJUYWZkS1FUblc2QjFmZHJuK05ja2I1ZzZLRWMzdk54d25OS1Uz?=
 =?utf-8?B?Sis1aDhZSEg3TXZtMnFBN29Eb1pRMFFFQXBMOHY5RWNWWGVHU2xsa1U1ZmF0?=
 =?utf-8?B?a3hHRGs1OENxQUtzN1hzeUx3NFltQXpMOUVJRUQ0aXNVQmhjM3UwdXpHVHVu?=
 =?utf-8?B?eWNzbEVJSmNOVTJoYmx2blZQQU5hMm1DcFZiL1lvMUNPZkNxQmVMUm0vRUFN?=
 =?utf-8?B?dis1alFoeGMvc0R2TVVZV055Ny9hbWoxQUkyVTZWWTFFL3ZWcUZRVHFWbmN1?=
 =?utf-8?B?TitZV0lFZW1la3pXcG81eWxjRWE2WUhQRzViL3JRdlV4N1dpeUZMamFraEc4?=
 =?utf-8?B?ZC9INkZFSjlMeHlSZSswSEVjL1l5VmsxZ2Z1TjJDOE0zUFFDK05vbXFvVVRr?=
 =?utf-8?B?cVBmVVVLQkRnV1UvY29kanlFRGpvYjVYNFJIOHRMRWVJd1M2ZzZ6aGdDN1ND?=
 =?utf-8?B?Y254Zjh1WWgyS2pNaVdnRG0wd3ZHSHQ1bjRGY0dqKzdJSWtkejc2K0NFaFg5?=
 =?utf-8?B?QTZnUVFML2FTMXpiVmlsd0lOakR0cy9sYXVyOHNNa1hiWEF4M3hpQis2cGl1?=
 =?utf-8?B?QnNyV09vYmZjWmovc2JJSEEyYTB1UENVVDQzV01nbjE4K3hNUlR6T0dncThm?=
 =?utf-8?B?VGNCK1Q0anpPU0VjN3RtNWJvUHFPZjFxSUg0RHZGVWRxRnVacHA0bXgyTzJW?=
 =?utf-8?B?ODZZT0kzajVRUXNVTVBGS040NVd1dDFYa1Yvd1ZjZWs3VkRncnhSM25sdDcv?=
 =?utf-8?B?dEFuWUFsNUFoSjNFODhSa1hRNGI4S21pSlppNWxkblJFcHZWS3VEQVlGaWdF?=
 =?utf-8?B?Tm5zQjFTQVdxdFkzcUtGZlBpY1JGNzd4ODhWQXJoUGtiaU1VRVEvbWkwS3Fq?=
 =?utf-8?B?eUpxaXZPdjBVMng1bXNlUXl5SXVTV01SNGl6aHdyQW1RRkliS1pqN3VRbm14?=
 =?utf-8?B?RnBzd1pRQU1SMVBreDljb0dOdUVQZnhIaHFIeE1hdm96RVVjZ3dFQnQrb3Yy?=
 =?utf-8?B?T1lYSEkzSFRBVFhJT1I5cmZaY0EwWFBaNWhNd1pPMzZRZnFRK3VzQXJvUVJ0?=
 =?utf-8?B?UTdNckNtWnFvRTdORnA4ZW9TOGNkVGtFMWJVZDVuS2N3YlFXeVAvUXp0Vklt?=
 =?utf-8?B?T21DdDF5ZW16N1ppTkM1bHhpSCtBclVZNEUxL1lzNjFIQ3YzaC9vQjA2Q3Zp?=
 =?utf-8?B?TjhLa2tYMXZvbUhSaGF1c3c1OWtoN1JZV2tXRlBVWWMzZWkvZVRva2owRlYr?=
 =?utf-8?B?Nm5kL2puemhtOVYwRDZrZEFaTStsUG5xSlhHVjZPUlJuZUVTYW0vRU5SV1JY?=
 =?utf-8?B?UnkzSzhTQ0xmKzNRY0N2VmNNajBaNUR4a21DVFYyOTdvUWNiSGlFbWxGaFRX?=
 =?utf-8?B?UmtLOUNzRFFzR0N5aW1VUTJhT0dMZnl2d1BPMmRLOVlmL1o2d0Z5RXIrU1ZX?=
 =?utf-8?B?NWY0ZXhmUFFPTUU2TWxsY1EzQjM0aitUNTlOWUh1WmpJYmdvbWxJdmRwSkVh?=
 =?utf-8?B?eTNEY1psS1J1dG5aQnRVVVdEQmVqK1YwZGhNU0ZBWWhSa1VpTmlYUFMyZ0FU?=
 =?utf-8?B?RE1lczhqdTVvVXJXcmxyZnB6SlgzRytWcHlGT0tHdFlDU1Z2NEFPcWdUUDNV?=
 =?utf-8?B?QmZKdzV5cFcxeGlNckt5MnorQUNpZHVlZGdCRlQ0WXZDaGFGam42b0R6cCtm?=
 =?utf-8?B?NGU4R2JpUmdLT3NoTklSbE1lRlROMEtzQ1dRK05pbDdwSm9hNXIveWJLeFUx?=
 =?utf-8?Q?1fgmHHq/ZZVBK0wp/sFgNQ0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBF0222218F1664C972C4C8AE8F9AFCE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oRLRrxOgYwVD4Iw4sVk9N/L94CxujkHh8oDdrOUGlUBtKMn/YumY/a2Pb6Nukl3hfRlORDgYv6LV83ngMwmPDtf1saEPqlgVKpozoETnIdbZL5wSlrNo5h+qFq92x3J0dgMCLJ9HSegSnyekdnffg61FTL3dKVkusRYHmuDJ/ItVa504zvbFO3xP52KLXkAYN4h+DXIjnw2edqyqSrNvCsv0uKEA/Cp7eHcSLJNXF7pPJYo8fvshfld9GLoYJ0QFxNTODwYUteHElXjhJMqKlD94ni0KIvy/8LtTGbgUbxewtnBAwMGViKV4X48A+yJSvV3+ANGylHzEiBaOsuzws1DMM4QZJ8RmGpy6H+kBRWtVEQwj+9Vxq3B57TmiXNzPsZWhQCcLxHW7v3x9UHyudHnW0Byf1kXjtwsSv2mOVWXSGgvhAoN7Hk9kgCOODssiJTlJJdquJ4rksxWABOlV5tNHnFmG9waDQFRc7B0L6pDR7rGzyt9lPZnKQ4L038MbGCQZH1oSpoYzGEDx0XiouJc27+Zlvsiv28rneudQ+NKu+fD8n63UN5xcoY7zLq/djpH/i2uu4n7WKVCnQQzUbFaSZUvak0bXDntoQfBZ4LtYqeU3k+ww1y1NBVq+yrHUFPW9gytJNPDtDFpsMaZyqsPlJLmZsQ4qQB8Bh2dkoYd6A3+BeytI5hs85UsztZrZpXJIMTaIelRZ9woR7tLsJNTKaxZkENkIcIeTwMeLyOXYAsIHAJRkF8S/Qc7pABKScairtkZQw3l31ZA9mtf+n5gqTn6H6+0Cwl5ytzyBo3Sy0XXywijoiHZC3ikUfiQZQdHU1hmgSj8P/pAhBqfxQg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715c8562-f117-484a-74c0-08dac88dfccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 11:22:18.2988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2hWObAYt/0e1f8MSKs/M/u6omc4AF1wI9+JW4jQ+/8nB6sBpw6WLRTqrju8isDxwqWmXBhN1wsZ6oZJZLQfClGZTu8drfFNH3UXV6Xy0v4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5324
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
