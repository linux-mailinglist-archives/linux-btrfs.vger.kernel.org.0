Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7F164B17A
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 09:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbiLMIsf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 03:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiLMIr4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 03:47:56 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C3717A93
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 00:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670921273; x=1702457273;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aYVdbX9CacgSHL6Xu9w1kIAHblt0m4uRYw0mmW/5XNQ=;
  b=IOvSwUvRCnIVpX8lo498zbRyynrZFrejMC/ODr68xJUr/VTrifk4waqK
   TaXQhOLnw/fyeJdzXD/myrJXW3URb7mHGGWIgksnx/yBeg7Jw5AaN0DQ2
   BAvu5NehjGh3FoKEc8tMfO/KtHLqpCVZgay4kyT1ByB2ePeXKGEzTd+1Z
   je9frgIfQ7Y9wSt8uoASry4GhxRtui23lhAttAs20UXdt3b4Drer4Rdj+
   f5CqR3aYxCSeiISlOt0Z/cZ6PEw3+Iu6dM6H9sAhZUJ6t890GqVud1SKx
   BeCgQQEyC6zWDg5e36thXTPM+U7IRlCDtjMlMTyLC2QC1HlrI7tFr+c6u
   w==;
X-IronPort-AV: E=Sophos;i="5.96,240,1665417600"; 
   d="scan'208";a="218522063"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2022 16:47:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYvY+2TEo98wFOZbQSYhPu1E894JjNE3vTI+AbLI0SAtP/6X3T0JtTivYhZlfGAM8U5r7aYZNGHb7rb88xaEpoXlLG27kWHH6yZcHXoSCM9LEGOYXEStsvlf/hEFSSBYaNqnF79k3eburO2pvlTWhHRkLBdW1KbxZdvlgCJzQ5R1P/nOefN55p9AvsTZ1X97lvHBjLD8DfsJ7zN9Bo08sNwbjcqLK4cDHcWjfjlxb7DzeM9L5puuaVqxlVNlROIkNtjeB7VK+v0aMoLgsXaNKSM492yOPIXvnQMdxLNfUJCRfSAMw7Ue3yxr19IxiHMjnpn5SMlH36CJ1TF9KGWfiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYVdbX9CacgSHL6Xu9w1kIAHblt0m4uRYw0mmW/5XNQ=;
 b=TzGZDJtqctUwhLnjFFIIgoLelVWvBPQNspuws8cNXp6y+X/JsrRQdim39Q7FexNA+MmGTQE4B7xdBINy3C3GmBFfSn72e3k1DdU8qQKPbqxu6NmVIf/1wN8I4tx5iE54AA5JpXf5rfYb9FwjGmW3sykr/YrJWKbjNbu16cdu4+RedqB/XW9iZEhVUpkiOymBXGNkzmVGnOld9FYLVCArVoh9ogH2yk1n7XmLjyLeKehcqFxCH/GNxJGd/lYqJ963DteAt7nAJEkJE4CM5/qCBo41jE+jU4dFw+1kbdA9V6WQdv+MJqpqnDZH2eDOsbhVesMVMZkaV7lvnhFP4LKuJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYVdbX9CacgSHL6Xu9w1kIAHblt0m4uRYw0mmW/5XNQ=;
 b=U2a38YSJ5EhLjnPpRjbn3MA22hfVdK9k97pyWaL4RBqja9fu9vspL4niPShMqTe3nzNPj5rmQiKjkNHqVo2ob9y4mMtcMGADnZry7cNMVohKeNAmTcpQ5BdjLT1O4YY7xDImvBlZdFn3BcoObDKBhec8yf2jr2byvkYXrNkO3Aw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB8389.namprd04.prod.outlook.com (2603:10b6:a03:3d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 13 Dec
 2022 08:47:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b%9]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 08:47:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v4 3/9] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v4 3/9] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZCkdbJyiBsduuyEOE+tpnuJRQAq5p4G+AgAGhMQCAAAXygIAAAwYA
Date:   Tue, 13 Dec 2022 08:47:48 +0000
Message-ID: <008a8c15-6ebf-d5f3-f64c-8e53d8bfa889@wdc.com>
References: <cover.1670422590.git.johannes.thumshirn@wdc.com>
 <238cc419b3cbc18c4a93ad7827d33961fafd4196.1670422590.git.johannes.thumshirn@wdc.com>
 <Y5bWt7ENo2OkKK+v@infradead.org>
 <e69f2a95-3802-d8f7-2415-5320903a876e@wdc.com>
 <Y5g5q1O4dj9e04E4@infradead.org>
In-Reply-To: <Y5g5q1O4dj9e04E4@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB8389:EE_
x-ms-office365-filtering-correlation-id: f886546e-4dfe-497e-9376-08dadce6b66d
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hnl1UyeOVzpVkypKYu3hGv27KoAsF0bmyMj86/d6pyHUHZFSYu+xfB/RNOy/gfU2Qas6G4Z+lPszDKXImte1cBT2Oq1oD5ohnuviuy5NLMWSroOnp8eRLn0bO1BcxVvYjISsENSbJzYPNJy13OnzaHg1TFMALcpUH+Xrp67VB3fPWPKy33wH3bhJ98dFx5rsa53iEU7pfnVn7fMYvx6FlmsE9imbNWf+J+345U38sBemaqPe42yUsU959GbOTrvAxm7aOcDyrfF1zH74Ey2Q6CZnfDamde9phnBqHGR99QlE1/6bSNSYW2cIkihXkPcapB7tvcPcaOjZpqepEPMierygVB/tmaRCVz60x9mFLEqR+kllifT8y1iZUx9B9VUJxSOEIF7J1Zs/52mYUANY8It3y1dZQROKx16TEZG2HIE7v9qXkCHWhllEFRZ/+AoyuHv1sCCVoJps9F95rCJSrym1GH+TI39xXWUTODoj0Urus4W1JCGajGUhfKqjnVoZq6zT18LTAPG5OlCPRiLhe2ayByMsw8QE7EoVKp9I6zYqa/A5trizAewbN6eGE9a03DhgUyZ+h4tXwzI7aQyk7AK6JkWgnm8zDFpjER8vOsLpf0pMMY42A772La0kCwGW0x9wxtJdDPIK05SX6Z/JoIplqce5hWfEidAi9vEkyECWm6Wuh/DrP/265/JDM5JRDJgQxKB7bzcAEtAGrKf8Wmm3az/YQ9RcjYqz0aOd9YgJWkmqqbKKwf028UNz3iUOn4ua6bg7qVja9HDXO6hO4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199015)(122000001)(66946007)(91956017)(76116006)(66556008)(82960400001)(64756008)(38100700002)(66476007)(4326008)(66899015)(316002)(2906002)(31686004)(66446008)(2616005)(8676002)(54906003)(478600001)(6512007)(38070700005)(41300700001)(186003)(31696002)(36756003)(71200400001)(53546011)(83380400001)(8936002)(86362001)(6506007)(6486002)(5660300002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmRKU29Oc3dCaU5hS3dwT1ZwalRWS2t3UXVoVmdWK3NVaTFxMEhiT05ubUdu?=
 =?utf-8?B?Q096TWoyR05SVW0zbFpvY0Y2TTF2aS95ZWFyN3pIVUxpV1kwZEtZcTlqS3Rl?=
 =?utf-8?B?ZzN2Y2IxeDZsektxM3dROEQrQnlEN1pmOEVOUjlvN2tUYlJaL1VvbHNNOURj?=
 =?utf-8?B?QXVSaGhmNkl3V3lvOHZlR282bTNDYlN1cGlQOEVtNDdrYTVEQlNWN1hvUksz?=
 =?utf-8?B?TXZSY0F4RUpXZHYycHpCRGZtSDN1RHZmRWlDdHBuams4aHY4UFp2L2pFK1Zo?=
 =?utf-8?B?K3EzME1YSlAwUHRhQy9idTlsUjdqbExTMXgxb203QStXTTZQdytDUjNWUzM2?=
 =?utf-8?B?UXBwek9oY2hKeW1aTytMbXQxRWh4NlY0ZWRRZENIWFNvOC9jLzlwWDJxbUlU?=
 =?utf-8?B?L0w3dDJUWHpFN2ZUMmM0RVRiUWYzQ202NjRldjViSGR1cW5yTExaVnpUczd0?=
 =?utf-8?B?a0ZqblllV0hZVzB1Y09ua0Y5SkRQUlpVYnhUdVdQb1QrelNCRU9FVXo5MUtR?=
 =?utf-8?B?aVEyREVtdVlMWldUdzE2Y2N3M1B5cGROM2gzZnY4UlNZUTJRY2tsTjhzTVc4?=
 =?utf-8?B?M3hjd3c1aVllOHd2d1AzYU95TlA1T0IvSU9yR0FNNnlBS09LcDJ6ZkorWDNt?=
 =?utf-8?B?d2xpakU5Mmp3dFpSS2hSRFZmL0lpeEZHbURiMnRIa1ZVWGRGUkpRL04yV21w?=
 =?utf-8?B?V2lBUVNSMW9wMi83VmlUT1pwVjNMRXZkVFhyWjZQTUN6TG1WdFFQTllFVlBM?=
 =?utf-8?B?Y1l4dEVRSUlrUHdJNnJxYWZRNDM0V1I3RDBXYVd2ZFgxZFBYMjM0VnlnMXl5?=
 =?utf-8?B?eGZOc1VwSkhsbzN6ajFqS080Tk9IRjBrNUlxZVlkZDd2NFpzemFycXNuQXBM?=
 =?utf-8?B?VGZrSTNTM2k4OHdkeXhnSjNuM2k2amRodEpWM0U5dlpTTjR1UWtnYUlNVDR3?=
 =?utf-8?B?eStzczJEVkFuakEyYlNxQ1BIa0hCR0x1RU5ZUC9XQitLM2tJRTljdkdUQjBz?=
 =?utf-8?B?eGI2MmJjTTNxd0dLZmg1R1gvTnRVY1JNSm9WMm5pVCtCMDZMZkFURCttKzl2?=
 =?utf-8?B?WWVnSGNyMTdOL2F4YkZJcWJpVjRJcmtkRWtmS3dMcDF6MHBxQjloOFU5TXcx?=
 =?utf-8?B?MVZjMmdUSWJQL2x3M3VYRG4vRDh2aU9QN21vRzFNK3hmbEkrcktFZDc3T3Qv?=
 =?utf-8?B?MVJ5K1lscE1SbFJ0TisrZG5vY2Y5UWpzNnozTmZaYnArWGxKSS9qZ28yWjRr?=
 =?utf-8?B?eEZiV2NpR0VkZHBTcWRtSnhhaFFmZHRMUjQ3SkduUUdoZ2VROGJJbFVYQlhO?=
 =?utf-8?B?bU1WUEtVSCtmQlU3SUZuQVJTSThQY0ZjV0UycFZPZHZoaENURDJWaFhLSmxP?=
 =?utf-8?B?QkxLb0I5Z1NJQXJNNERweUw2Z2xyc2VNaUswODV5UStaa1BMblhwdmo5YW9u?=
 =?utf-8?B?QVhNTWF4NXNZQ0d3TWUvRHpVOEtpWUtrSm4zYkJyeXA5Q0VOVHVYOWNETGNa?=
 =?utf-8?B?QUc5Sk5xOGVLeDM0RFVHbGpUQUlRZGJlb1ZFRTkvM1lwOStKSW9GcUFKUXhY?=
 =?utf-8?B?MXkrM0NVbE1Ub2Jac2RZUDlHeWhkWFFmb3ptTFVVVGs4bmdTd0FmdzF3TGpk?=
 =?utf-8?B?SjhQYnEwV0pkck84MFRLZUl3V0l5aWtnU2lVSWM5ZkhnVlZBWm11VW9JNGJX?=
 =?utf-8?B?ZUY2SWllWkp2dHM2OUVaTHl6NzZCcG1MRlVWWjJpWXhvdkNGbFdqTkpPNGFN?=
 =?utf-8?B?S3RoUENOYXVuUHBlZlVVTlNERHVHeittTW9Ncytsb01abnBOeXBYS3kxNERi?=
 =?utf-8?B?bVc1WjNZQU5yTTFBc2svVkVvUVpSM1ROWEptL3NieU94NzM2ZzhnRTFzeVJz?=
 =?utf-8?B?WnZqeFkydEhHUUFPc0JkUlhQMmM1clMzdVBYbHJ4cHlac1VtV29Fb0ZRcldR?=
 =?utf-8?B?dEJoZEZuUGUyL0xEOXNpWFVITEFUNUJlY0h4dXpEeGFhZENrSEpJaHUxNC8x?=
 =?utf-8?B?MEFDL2VGWXFLYk9tOElHT1hOQ0d5cUhkZ0NnaGlETHBkU1BmMVBzUkxEb1E2?=
 =?utf-8?B?cEJBUklUeE1HTnBEVEtQb2M2VGN3TG0ra0VSYXdtbEkybFNBY3d1WXVaUWN1?=
 =?utf-8?B?eDJwcm1Dd1MyN1MrSkdyN3hjL3B1eTI2VENNMVlxTW92UUlsblNQN2xtRktW?=
 =?utf-8?B?amNXejROVEUwVWt2OU1hdUptYmhXcUxTd21mbHhrR2JtYWFhYUZvL1I1UTBF?=
 =?utf-8?Q?SMMgX9wzBoBxijYFLp9xqsk0o0RSeSUNgE7EeH1OYo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <696A16AE8BCFA140B85261DE83CC7151@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f886546e-4dfe-497e-9376-08dadce6b66d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 08:47:48.6944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rIBjH8nuTig2NWApgM7R5flLflvJNV5NqMrLPNxzB0XG7R1lazUCJksPiwoueG+RC3VdQGLlhL6LpYR+JRs+Fs/B4tQyL/2b2c1Mait+0Wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8389
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTMuMTIuMjIgMDk6MzcsIGhjaEBpbmZyYWRlYWQub3JnIHdyb3RlOg0KPiBPbiBUdWUsIERl
YyAxMywgMjAyMiBhdCAwODoxNTo0M0FNICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6
DQo+Pj4+ICsJaWYgKGJ0cmZzX25lZWRfc3RyaXBlX3RyZWVfdXBkYXRlKGJpb2MtPmZzX2luZm8s
IGJpb2MtPm1hcF90eXBlKSkgew0KPj4+PiArCQlJTklUX1dPUksoJmJiaW8tPnJhaWRfc3RyaXBl
X3dvcmssIGJ0cmZzX3JhaWRfc3RyaXBlX3VwZGF0ZSk7DQo+Pj4+ICsJCXNjaGVkdWxlX3dvcmso
JmJiaW8tPnJhaWRfc3RyaXBlX3dvcmspOw0KPj4+DQo+Pj4gVGhpcyBuZWVkcyB0byBiZSBvbiBh
IHNwZWNpZmljIHdvcmtxdWV1ZSAob3IgbWF5YmUgbXVsdGlwbGUgaWYvd2hlbg0KPj4+IG1ldGFk
YXRhIGFuZCBmcmVlc3BhY2UgaW5vZGVzIGFyZSBzdXBwb3J0ZWQpLiAgTm90ZSB0aGF0IGVuZF9p
b193b3JrDQo+Pj4gaXNuJ3QgY3VycmVudGx5IHVzZWQgZm9yIHdyaXRlcywgc28geW91IGNhbiBy
ZXVzZSBpdCBoZXJlLg0KPj4NCj4+IEknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgeW91ciBjb21t
ZW50LiBJdCBpcyBvbiBhIHNwZWNpZmljIHdvcmtxdWV1ZSwNCj4+IG5hbWVsZXkgJ3JhaWRfc3Ry
aXBlX3dvcmsnLg0KPiANCj4gTm8uICBJdCBpcyBhIHdvcmtfc3RydWN0IHNjaGVkdWxlZCBvbiBz
eXN0ZW1fd3E6DQo+IA0KPiBzdGF0aWMgaW5saW5lIGJvb2wgc2NoZWR1bGVfd29yayhzdHJ1Y3Qg
d29ya19zdHJ1Y3QgKndvcmspDQo+IHsNCj4gCXJldHVybiBxdWV1ZV93b3JrKHN5c3RlbV93cSwg
d29yayk7DQo+IH0NCj4gDQoNClJpZ2h0IG9mIGNhdXNlIQ0KDQo+Pj4NCj4+PiBJdCBzZWVtcyBs
aWtlIHRoZSBjaHVua19tYXAgbG9va3VwIGlzIG9ubHkgbmVlZGVkIHRvIGZpZ3VyZSBvdXQgaWYN
Cj4+PiB0aGUgY2h1bmsgbmVlZHMgYSBzdHJpcGUgdHJlZSB1cGRhdGUsIHdoaWNoIHNlZW1zIHJh
dGhlciBpbmVmZmljaWVudC4NCj4+PiBDYW4ndCB3ZSBmaW5kIHNvbWUgd2F5IHRvIHN0YXNoIGF3
YXkgdGhhdCBiaXQgZnJvbSB0aGUgc3VibWlzc2lvbiBwYXRoDQo+Pj4gaW5zdGVhZCBvZiByZWRp
c2NvdmVyaW5nIGl0IGhlcmU/DQo+Pj4NCj4+DQo+PiBUcnVlLCBidXQgSSd2ZSBub3QgeWV0IGZv
dW5kIGEgZ29vZCBzb2x1dGlvbiB0byB0aGlzIHByb2JsZW0gVEJILiBJIGNvdWxkDQo+PiBkbyBh
IGNhbGwgdG8gYnRyZnNfbmVlZF9zdHJpcGVfdHJlZV91cGRhdGUoKSBhdCB0aGUgc3RhcnQgb2Yg
YSB0cmFuc2FjdGlvbg0KPj4gYW5kIHRoZW4gY2FjaGUgdGhlIHZhbHVlLiBUaGF0J3MgdGhlIG9u
bHkgd2F5IEkgY2FuIHRoaW5rIG9mIGl0IGF0bS4NCj4gDQo+IFNvIHRvIG1lIHRoZSBidHJmc19k
ZWxheWVkX2RhdGFfcmVmLCBvciBmb3IgYmV0dGVyIHBhY2tpbmcgcmVhc29ucywNCj4gYnRyZnNf
ZGVsYXllZF9yZWZfbm9kZSB3b3VsZCBzZWVtIGxpa2UgdGhlIG1vcmUgc3VpdGFibGUgc3RydWN0
dXJlIGFzDQo+IHRoYXQgY29udGFpbnMgYWxsIHRoZSBvdGhlciByZWxldmFudCBpbmZvcm1hdGlv
bi4NCj4gDQo+IEJ1dCBpbiBnZW5lcmFsIHRoaXMgbWFrZXMgbWUgdGhpbmcgb2YgeW91IGFyZSBy
ZWFsbHkgaW5zZXJ0aW5nIHRoZQ0KPiBzdHJpcGUgdHJlZSBhdCB0aGUgcmlnaHQgcGxhY2UgaW4g
dGhlIGJ0cmZzIGNvZGUgW2NhdmVhdDogIEknbSBzdGlsbA0KPiBhIGxlYXJuZXIgb24gYSBsb3Qg
b2YgdGhlIGJ0cmZzIHN0cnVjdHVyZS4uXSwgYXMgdGhlIHdob2xlIGRlbGF5ZWRfcmVmDQo+IG1l
Y2hhbmlzbXMgc2VlbXMgdG8gYmUgYWJvdXQgdGhlIGZpbGUgb2Zmc2V0IHRvIGxvZ2ljYWwgbWFw
cGluZywNCj4gYW5kIG5vdCBsb2dpY2FsIHRvIHBoeXNpY2FsLiAgV2hhdCBpcyB0aGUgYXJndW1l
bnQgb2Ygbm90IGluc2VydGluZw0KPiB0aGUgc3RyaXBlIHRyZWUgZnJvbSBidHJmc19maW5pc2hf
b3JkZXJlZF9pbyBzaW1pbGFyIHRvIHRoZSBMMlANCj4gbWFwcGluZyByZXdyaXRlIGZvciB0aGUg
Im5vcm1hbCIgem9uZWQgd3JpdGUgY29tcGxldGlvbj8gIE5vdGhpbmcNCj4gaW4gdGhlIHN0cmlw
ZSBkZWFscyB3aXRoIGZpbGUtbGV2ZWwgb2Zmc2V0cywgc28gcGlnZ3lpbmcgaXQgYmFjaw0KPiBv
biB0aGUgZmlsZSBleHRlbnQgaW5zZXJ0IHNlZW1zIGEgYml0IG9kZC4NCj4gDQoNClRoZSByZWFz
b25pbmcgYmVoaW5kIHRoaXMgaXMgcG9zc2libHkgbG93ZXIgd3JpdGUgYW1wbGlmaWNhdGlvbiwg
YXMNCndlIGNhbiBleHBsb2l0IHRoZSBtZXJnaW5nIG9mIGRlbGF5ZWRfcmVmcy4gU2VlIHRoaXMg
aHVuayBmb3IgZXhhbXBsZToNCg0KQEAgLTY0MCw4ICs2NDEsMTAgQEAgc3RhdGljIGludCBpbnNl
cnRfZGVsYXllZF9yZWYoc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsDQogICAgICAg
IGV4aXN0LT5yZWZfbW9kICs9IG1vZDsNCiANCiAgICAgICAgLyogcmVtb3ZlIGV4aXN0aW5nIHRh
aWwgaWYgaXRzIHJlZl9tb2QgaXMgemVybyAqLw0KLSAgICAgICBpZiAoZXhpc3QtPnJlZl9tb2Qg
PT0gMCkNCisgICAgICAgaWYgKGV4aXN0LT5yZWZfbW9kID09IDApIHsNCisgICAgICAgICAgICAg
ICBidHJmc19kcm9wX29yZGVyZWRfc3RyaXBlKHRyYW5zLT5mc19pbmZvLCBleGlzdC0+Ynl0ZW5y
KTsNCiAgICAgICAgICAgICAgICBkcm9wX2RlbGF5ZWRfcmVmKHRyYW5zLCByb290LCBocmVmLCBl
eGlzdCk7DQorICAgICAgIH0NCiAgICAgICAgc3Bpbl91bmxvY2soJmhyZWYtPmxvY2spOw0KICAg
ICAgICByZXR1cm4gcmV0Ow0KIGluc2VydGVkOg0KDQoNCg==
