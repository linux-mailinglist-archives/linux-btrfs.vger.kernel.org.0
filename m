Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1B576B47A
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 14:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjHAMPP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 08:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjHAMPO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 08:15:14 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A671999
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 05:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690892112; x=1722428112;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=E8nBh81mPEU1zTMLjzQX3PemOItvXbNLbph4pynzgLqcIU/jwPmzOIq+
   dld1HoY0fweWzXwj4/yvAQ35NThoZdjVPe4+XGKYMZyj9hvfnoSRsDRka
   9txrHXkdDvE0KdkjkKR1zL8WDdgi1lD3yZDupK7oph4da70LWDud+oEzM
   7luEcSbzJVGMl11P6sy10tjLtQClaQIQlKXqNQOUDINZuPc9d22hYIsBg
   NBfzigWF8jK6Redu5FSo9iSmWBe2l1zqz4m36JJOkE6rgWhrQXyc+PLWb
   XsN1eTlz5x2R2QH88s9fBaqmE0+tBW0T/4jN4C4Mz77IWjgM9ur76zEo3
   A==;
X-IronPort-AV: E=Sophos;i="6.01,247,1684771200"; 
   d="scan'208";a="344884633"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 20:15:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdA7xu+FT2ffykr/VElgqlHghok4MJz3HvVrjV/8HiD6hweYp30SoKf1IGufKl47fUSvYd25htxEcrbA1I0ELoL0Lf5wF5uRg3JLyFWMNXykUC5YSXv+qxGYyeDYaWkXMWLjQH2aZPKxj16gdEJZOTcHJ2jP5Jj/zZb3GffllHaixQrWT7Q4RehomVCdgrPLEp1Jk13Yl5ilJ4tdBINRXzxR5uBOCyewkhHPgwSXhtHIsQCaPG7YJCK1lfVB47BuBm2cIFykmM8Atxfv+H7vSvMlkXTzPgR0MCrlbiN6wZRgnwi1uxHh4oyuYhSrfmiotlTo7gWSXdHNrFrbSZfg/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=IJhyIKZw1nlERNWRsy5+IQ+ftE/kS9aE/Of7GH0QXcpXiB+PP0QfGRgzTX2fau2XySqipAAFR0Lnl7yfk016YZniBq62IEAuIYT/Qb5bC2NVViHgjg2dE7cxCgwVwne9I+CxvuwBXhrpIKdFTME3T5wxW548It3LcffYS0qrTjsvlj2Jh+IIzRJ480g8P4d1m0AdZhV44C2dUEGiaioc1PTIjf0LSOCQjTOyiYx04mdiXATmNrr03xOHkxZBjPsTBb49k95Qc9XdFp57qF3lnNQVx9EwTfLUkgfX+zhrpcjJxNlmEXUGcGqYz0Q628zZsXMVOVy5oGgy1xCweEm9nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=N0lKMCsFjefqHTvTEQBN1kcXaJ0lpG/xtw7w9pOi9GPOz5TgpJdWAzeoVYD+UbfX4fy0PS9dMgHnu07Hvc2d3Zx3rI/WSrIUfxg27O7WLW/w15Wg4aSsTNKqs7H2nZOtUlJrdWcd4/f7CtkGFWfkpYmbuadXWvZh7HkRomSnzdk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA3PR04MB8593.namprd04.prod.outlook.com (2603:10b6:806:2f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 1 Aug
 2023 12:15:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 12:15:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 05/10] btrfs: zoned: update meta_write_pointer on zone
 finish
Thread-Topic: [PATCH v2 05/10] btrfs: zoned: update meta_write_pointer on zone
 finish
Thread-Index: AQHZw9NWPWwNCWaJu0iDx7dmbWXVTK/VW/gA
Date:   Tue, 1 Aug 2023 12:15:09 +0000
Message-ID: <a15825c3-470f-8f6c-6d8c-3781d333662d@wdc.com>
References: <cover.1690823282.git.naohiro.aota@wdc.com>
 <22b2378b5f33e1b7f244f6a930f1d01821804893.1690823282.git.naohiro.aota@wdc.com>
In-Reply-To: <22b2378b5f33e1b7f244f6a930f1d01821804893.1690823282.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA3PR04MB8593:EE_
x-ms-office365-filtering-correlation-id: 01ae5d03-a97e-451d-d146-08db9288f2f5
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +4L4LXt4/JcLJCbbMekcYOHxEKsI8CgwaA0tkfiPCMOfvHlSoNIS4Io8Hy27ikTlyPSTLo5DpznDRv2ncyoB57x8w6aM+FA4ZXVw7SbHsb4vEbfv3nQtftBH06OG20NJNrW6D3Kq6ATyXHk57TGKwYzSyZQJsV04SjhediQHAvn7HMdpLsxJVnj+63oPAjbIGSwvWXaIUhpTYRF4I+G4iNZsl2ECtXpogIcrN52X1sHy2mLq2SETg6bSnIUdCHJCbpL/s4jwlNix1LRRywcj9M4/sLIlHs5oN1OJkiF2CI+XIIK857TW7nCob/j57WA1xFuwAgkG/aTNdqK2I+1q7Cm73/uVWmAdXFqFs8oKU3sgouI6FjiVdlsMQBiIsx+lBwAaLwYVqy1pg87hmzA2kUCFB5ScYijB4q0uW4zBnF8g+bjHzOO9/xhdexECe9djgftJcUZAj95ogJBMv5CKJyw3p3DaMeiiqsK+aH4qdjLFmNRa10WIZJEVyUIDJiygjKPClZl/DaK6ms3ayOPbE6xnyys9sX7TlLT0XrrHtPtPX7UReZDsRHza9+ubcQEQE9Dc2nX1sLnQJr2tClXsdymt5SQXQJekmPSgRGT4IgRLcKhjHxc0uLE/MVTNk+qUsB3dVWZEVkIWKDvg5ZF3npJtKP8uelETNwzXDCDjb9qhm4QkjNoMKiufryN7yn5v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(6486002)(6506007)(2616005)(26005)(4270600006)(41300700001)(186003)(110136005)(316002)(122000001)(82960400001)(71200400001)(86362001)(478600001)(54906003)(31696002)(558084003)(66556008)(4326008)(64756008)(91956017)(38070700005)(76116006)(19618925003)(8936002)(66446008)(36756003)(8676002)(66946007)(5660300002)(2906002)(38100700002)(66476007)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHVyWTExZEpHYzRFdm8zRE9uN1orcS91bWJ5RENoSGhEUHBMQzRHRzA1NGoy?=
 =?utf-8?B?RDE2bDhWYlVyUXJxZVZmYTZkZnJjVWs5eDF6V0xvd2g1RU5OamFwQmpBa3pn?=
 =?utf-8?B?TFJ5bFBmQW1WV1pCSmJZNS9DeFJYWEwyYXFEVm9jTnFrUm5XWEl5dFhPbHZJ?=
 =?utf-8?B?Nk5Kdm9UK1hJd0FLWklSWGMwTXhoZVB5Mmxnb2NUcC84YjluU3k4YlNjQ0sx?=
 =?utf-8?B?dnF1ZHBpN0p6SzFENVVUQ0ZVMkplZ0VYU3dkRUZ0R0FZbmREV1dNRUFCMWxO?=
 =?utf-8?B?c0pRejRzNDhlSWFnSU15Zzk4ODlXVmNmaTQ4UVdGU2N6aXhtUTlZc25MdDJ6?=
 =?utf-8?B?bS9TSlhwek03WDRoS25PbDU3aW4rS0lFSHNjbUtEQVZOSmpxTjVBU2Y4VUxG?=
 =?utf-8?B?U2syKzFHMnh4a1lyRERwdHdiS01QeGdzSXowUDIyeXBFcXJrYUFFNEp0bXVX?=
 =?utf-8?B?N3lkdTJNRzJ1UndCVnJKcnlXYmFYRmtXci9jYVlYbHFEbmtUcjNRTUpZWFFO?=
 =?utf-8?B?S3VmRmJ3UHFPN2doMEN5ZTBYZmpROVQvcjVueDI1SHA1ajVBdW13RGx6L3BZ?=
 =?utf-8?B?YjJsZCtOM1BxQUwvci81OGs5WnppcW1qVENtTXB3ajQ5ZDErV3drS3FEa0xR?=
 =?utf-8?B?b0c2OFViRjFaS2x2eDREOHdoc1NLcTk3SzFvVUJ2OGpkUWs2dXFkK3lFRG8w?=
 =?utf-8?B?WlBxQjArODNSVUxWdU55Qi9qTWNXOE5qaVN4aGY1b3RLdHBBNUFNckQwaFJx?=
 =?utf-8?B?ZUVQODI1U08ybGNuckRhZnl5cFo0SnBpRWJBaFJLY1FRdFV3eENvWllkMUVT?=
 =?utf-8?B?NHFvRytEOG5mMW5MU1hWc3p3TzNpb3d2RlhoM1FLazQ1VUZqNFRsM25odlBW?=
 =?utf-8?B?cXFUZUJrY3J2eUNSQ01Od3NBa2V4SWpkci9oZjg0WHdZSEtnSGZWT2EvSS8r?=
 =?utf-8?B?SGJuaVNoNkFhb0pCMnpLMm1tazFPWGY0NVhxd0tGNFBDaHV2OGFFc21CTzls?=
 =?utf-8?B?SEpSU2wzT1FXWTBtNkZ3cmhpVVlBYWlQWUxDV2FwbXhSRXRjZnZDOWNWN1o3?=
 =?utf-8?B?UTY4TjlmblR1a0hCYUtSS20zV0NVQUh6MXFOeDF1MzJHaS8vRUI4eXhJakZS?=
 =?utf-8?B?cnVpUFo5SjcxeWRJaVZxSmF4MWpLRlpxaTFGd0l3VHZIc3ZmMjFWR0kySkZz?=
 =?utf-8?B?eS96RFBUSlZJYjFzRHE3RU9XcHRwbW1Zci9xOHNrZWtXb09NbWJBb1ZjMW96?=
 =?utf-8?B?YkRpSG9uNFhXQklCU0ZUREZoSGhTTjJ1eTNiRVJUa2pTS1VHc1lUbC9iSmY3?=
 =?utf-8?B?QStNY1F2RTI2NkJIUG5QQkM4ZXFlOTlpRzNMcGl5L3lLVE91bzBGWUFSeFpR?=
 =?utf-8?B?WlVRTDFvMHBBRHRuQlpIWVhVUGtzM3A1SitDc0dBb3dIOU5xOW9qUFF1QU8v?=
 =?utf-8?B?aWlDNnZGQmZxcjJGM0x6aWc3NnIwelZPT21DM3p4djFWZEpHcDBpUG9QRXNw?=
 =?utf-8?B?cEFEWmppVjlGaExab2kvdG4xYS9wQmVObm1GK1NRRnU0aDdrTnJ4M2ErMk9w?=
 =?utf-8?B?R3p0ckI3ajVTeStVcjhkR3UreU90TUVZakxxTDFBNzJNVmc4TjBIalhseml6?=
 =?utf-8?B?eDZ6R2xOR1kwWG9RYzNqSE1xRG5DSVV2NHFBUVdUOWVUUnpiRVZFSGEwRFA4?=
 =?utf-8?B?Lzh0ZXlCTVU4R2oxaTlHSUlLY0RIL2MzK09sK1d3RC84VnpDVTRad2VDVTdI?=
 =?utf-8?B?V1VvUE43eUpCU1FKaUxuSXVZU3VQU2ZiOWpYMElCQ2FXYUdSZU5DTWMvOGFS?=
 =?utf-8?B?bVVSSjNCaW9RUS9oL1dqcjU3eE1UeFFSY1ZuWHltNlVPbmxiTGhJblF5Q3hE?=
 =?utf-8?B?QWFDazNwbDg3b0Z6OXBhcVRIczdlL1pNM1RJTFpOQWRHc1U4WThYZnRzdGZ6?=
 =?utf-8?B?N1Vnellxcm1ObTBoWExnMUhPNzZuQmhxS1EwU0RyTmVIUGswVE81Q3B1N1lh?=
 =?utf-8?B?TVlDUTBDZFFaZFpOUzhFcW5SYmFVNHJ2UGFXeitnTVA5ZldVbWFHRnVWdFFl?=
 =?utf-8?B?cGVvbTB3eWF3ZFAvUC81L05VUTliaDR1NzF6WlVUREVTa0lOaTl0WExIa01v?=
 =?utf-8?B?YWVBUDNGaTlEcGtDNzNhRTFyeDBNRXd3MndhVjJyejAzS0xINkxNM1RWemVy?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B579C83DC3E3A48B62823BDCE4DBF25@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s3JKIwq+TAE9cRxjYyfNnZDgNLyT62CX90R1Vuc+vTzh6WT3vFtpHmEv6vhO7XiqSjfJt4EEGTipmxKIgDG28CgUbFBHO/V5XQLBrlRBieDKR+09UtSF1Q2MMEEXPh6wHVrVhNTSByexV5TMUZZheJ73F1W/9nGNPMcltKkSCxDGyKwPsOTa4EBf8PDuF3msNScuQ/jlsDYvzDKKRDnaB2OmubY8QwzibZPy+1gWKGi4TxAy9ekqBA4nLJDjC9nVLysTlgAPOO0kTzeLcu/slGWpvNXij9s97rVMciNhTYOAkkHMDrgmJlHaGKLcymBX+AnKfPgnphDBkWi43zT6XABbgV/M3P1nSEKnQKGDTRYG/qslcCMCBp6Ti2vBE6UTo80KeZws9rQMlb/6hMkmOvY0eXeszFoXNcphmqiQEaWqEFoRrKagQQozFamNCk6PxwRhtBOtyI9L9WuozPi8iw+c731ib0xOhUVc1l3Z7wuLz6MK0fZ9TK2pliMWVuYe8/uhM3U5q+qK9pER/Zt8ECA1sbpXP2BpOrf/5xKvXi+yJ3L17vLZHRI217WaCSYrjNIngazyXVeCKlaW8ikcuvx3c35EgqJia2atyv1neIujYwEYwN/uknc48X9+BgC0xiEVA6Tu5xFg5tHQo68ZTyjKedBvGU55ClbR6YlYrlyf2SI+dc7P9IjT6Ws9/0A0zj4pQCNShrHfTpX8qSEGwnRumqJbSz3Rx/OwuH7h/k+uw36ghWjMZNkZDTrLH/SKHCGwBKS7hHgckgy7SmJIaPdLC6jGRhSAQonJOP1I76PIqtMQoaonV6RAP6KJNV/2pv1ZjmUAMI/SQMHHTwMftjUNoSeqLUe42rN6ns3DCzefmxJC99q/LGGEqtQ1ibT0csQroyJuep1z4wyr8S2NYQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ae5d03-a97e-451d-d146-08db9288f2f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 12:15:09.2409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gimd8zZax0eWY+5fcIBxAL1mPMDlUxg693tYKBHswWqUUlxMvideY0XAKJhhlHn5WUWYiOIDgGUkZ+n52Vp9qT0s4Kfpf6W9nKpINIaUDPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8593
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
