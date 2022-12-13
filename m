Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DBA64B0EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 09:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbiLMIQG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 03:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbiLMIPy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 03:15:54 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807281740A
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 00:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670919347; x=1702455347;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o1G2pVOnnVbxMckYaN8ym8V3Xpr42NRyCzl+YhwrTn8=;
  b=mhwMmZqzZFLdV2GVS7tgKYkkMBAXu+/lLtiUDgm+pY+eumAuumFEbHIk
   04o/dMyIQlUQjW8NtfaWXq0/jUN5GkWdeeswgBgjK8Q5wp4QejyULKkKG
   arm9SsCyaMzZGxiqRWfMX582w82OVTYEbnzt/hpctOb0zMRVwfyZHjiRv
   r1vLbw6z8JWQUi0JOJiJRuPSriiY9MEsQp8gzY1/PDy+aMbxZHu67UPj4
   fBxXXwYNqzNzT7g0ck5nGlkyIcgwLWgRsn8gCjxpPP+lyK9W8IvpT9oEc
   JnGJhta0mNR0bdCTPubb6AtzxGwWQJISbVE5aD1GttjOht3GDIJd1cG2T
   w==;
X-IronPort-AV: E=Sophos;i="5.96,240,1665417600"; 
   d="scan'208";a="216723583"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2022 16:15:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=od9tx8EhFA8BV8amJmPFqwuU1RfTjVTDE977+v25i0Z1v+YcvGaQpDsHR9ERyatHO7w/JzCUUJ/JtK+7p6fHaD5VSLa7DWX9TRQ2PJ5vlhdazWTC0BL4LBd8TIvC6QpeSZtwt2dAIZaYMxFfQDhnbrVZh8pUm8Uai5puBVgoKweLhCdZU2VfhrHCLFyXU9l8nzgHktxhRoxzU/Tjx/TAKRfbZJDcRsx5/4qQsqBK1yO2RbSolX4jeUXw+unAx0dJPwa2eD9fKrMK9BZ/UKI9LlbjfLt78deV6r9nRhMHsifq/j34/HGcUiSndeERjusisK44ouNOwy4afyg2xTGPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1G2pVOnnVbxMckYaN8ym8V3Xpr42NRyCzl+YhwrTn8=;
 b=HagcM2RNrRUYYK5Ve58f5/pcVMFGAQ9qThmOD1LZvbSlslNcQOgAjtfgA2UZi/Aq7zWtCq5VqWdk9dHrhYlKwv/vpo45R+r8t36ES2gYQBJs7y1ZZoPVqXOJ3k+Ouig+AN4frH2DPr8CwOH1emldonjmeONoLucGe10woysh0fBFO9Hb/8r2RWZSCnS/ndT53UawzPin5hVaCqdWnJKaO61HJnhf7iXl15F+hOlW+eDG56s1yLUENcY56+TqlNpPM0CTIQughCtMNhAMrdbL/qyWKbVZG6wN2trd4DiXHwFyE4xgJss9U48Gof4n1sbJRZUn/jjPrE3wxlBDCeED+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1G2pVOnnVbxMckYaN8ym8V3Xpr42NRyCzl+YhwrTn8=;
 b=e5I68wKzm+/c18uaAvcQVG/asxPj1sPB4RO9wkROa3c+GlEB1ifAsHUB/su9aI8OnckAaYWW3atRI9d+6QfW7XR1o4sFj0vqEzydw5QYRDaYQZoDemu0TC7SXM3xl8utWWZ1iwCTatcnmYPLF0/LXk+U7B2eh3GogI5Sd8v+4ZA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB0410.namprd04.prod.outlook.com (2603:10b6:3:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 08:15:43 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b%9]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 08:15:43 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v4 3/9] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v4 3/9] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZCkdbJyiBsduuyEOE+tpnuJRQAq5p4G+AgAGhMQA=
Date:   Tue, 13 Dec 2022 08:15:43 +0000
Message-ID: <e69f2a95-3802-d8f7-2415-5320903a876e@wdc.com>
References: <cover.1670422590.git.johannes.thumshirn@wdc.com>
 <238cc419b3cbc18c4a93ad7827d33961fafd4196.1670422590.git.johannes.thumshirn@wdc.com>
 <Y5bWt7ENo2OkKK+v@infradead.org>
In-Reply-To: <Y5bWt7ENo2OkKK+v@infradead.org>
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
x-ms-office365-filtering-correlation-id: 27d35784-b0d6-4e6a-38d4-08dadce23adb
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8BJWtaOrJ9UERekxVlOynP0AJheIphV6lC6mpkCQHnX+rY9iFA9tTQKy9Gbn9us35WOrQAq382WkGLE4O4XWhNONdbLrwHbJEK2BR8FSqb3GWh1hbZlLnWsBq+9OVGBncGFnLS1cclBhlOkYGZmbui6PXBtgiy0Aua6ctXwWhofOVleLHmczfmQbYl3GhQu2fIW9p2tOuf3TKKgzmpQO04eR+JC6xwSz7t2AECI4zi6ucC4HH4JuhPsDcSUMuR2XWEx4jiPzyuszefYodPKcrv+5Ch7vvbeNPfo/IfRLQZj+WlgMSlvz3p6A/0Zu4qBqIijRktdFjKCtZHpI3PcK5dx7pLVM3j8cdbhEMLSqRz1MP2TzemWqcXHJtpQfu5f14yU+bXAgQl2z1Dfa0A8nqpnrJzInlvG/56ySCTkVTZxHHnkXtShb4Gl8a8HZZTiumEmqyBSAlDEm9qYOTQJzSw+RJkLsrMM/w8Uw+SeNqAWNFLoTjtT1YHYh0S9ojkmvU24JRG8G26IhopQD4Mbnwgk/fYD14fqwR8wazgE+sGX1rsBr0alg1g65So+c8UjERcelwCtompyfR7aGs8vw4KWD/fQuuNUS8qrAqRO0lKIUtmSeCkvzt/px/ukKh3mwsoNp1D4acfBU2hwKjYjSgd3FHHGmrnUvD5KHKRUk3RUh0EXA7VcdyO2b++DvLZcTzN3MIydfRSIceTlpRrYGxj0g4mN6OS24fr03vLksgGZf9CN21Gt7XxuvZ5LX21UU9pABYgjqKuVl6IoKsjOSeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199015)(36756003)(8936002)(2906002)(82960400001)(316002)(6916009)(186003)(2616005)(31696002)(83380400001)(122000001)(6486002)(53546011)(38100700002)(54906003)(86362001)(6506007)(6512007)(478600001)(71200400001)(41300700001)(91956017)(31686004)(66476007)(66556008)(8676002)(66946007)(66446008)(38070700005)(64756008)(76116006)(4326008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm5tU1YrZmNPeFB0UW91aDJlZWxld1BYUHpiSmh4UFJNTW9zSVBqMkRocUVw?=
 =?utf-8?B?cVBzODBuajBFTVNxMDlqWlp4V1VST3BMTzBDSW1JaVpwZGdpTFhXL0xOUWwz?=
 =?utf-8?B?N1Y5bjUvZlFhaXYxaHJKMVFMMnJKZ2NzMld5T3lSd1lUa1VpbUdrUGpsSkR4?=
 =?utf-8?B?ZEFXemRoc2QyeERJUCtHNUpRTml3VU9BVGhuUFhvQ0JYeTBZcWNPWUlNN2kv?=
 =?utf-8?B?ZXhRcDBOSk02YThXUUVJRDRDc01aWVFyclloYXVMcjhpUGE3S2hMa2FJaDFz?=
 =?utf-8?B?ZmwyaXZTU3NGU1lSSGRHYW5tbG15dXpBaGNLWS9OMjJSdE5iNklYbVg5TW1r?=
 =?utf-8?B?NkxZckwzSHdwU1dVQzhDNVdKWTNwUUY5dHc5dWVHdFpuL3RYTGJBb2g2Nkkx?=
 =?utf-8?B?YS9ZOVllc1JDNDNVR1JZMisyUjlNdG9iVnlkUjE1VnU4WWZUdFYxUlRNWEps?=
 =?utf-8?B?OXZaMWtJb3Fmd1paM2pHNG5YaXVPWnc5Yjl4U0NpVC8ya0ZpYTBRYWxNZXdG?=
 =?utf-8?B?cHdBUndiMDhQUEYyRStTNjNCeW9iSWVqbU14MDhiQlg5aFdLa0paYnZtOWNl?=
 =?utf-8?B?NzQyVm9oS0VSVldwcVNWbHhIajJtd3g5Z3BuVHphcVlHbzROeFZNbzQ1bXlE?=
 =?utf-8?B?cC9hbGxyRGdPV3VOY3ZyYTQ3bXZ1OXBzNVFTTi9jV21MeG1RV1BxSktiZnpC?=
 =?utf-8?B?cVhKaVJ1RXZwNVpaQ0lQYWRjUGlQYUUzclcwNWQ4NGljelNoK3RKbG1SSHVL?=
 =?utf-8?B?MHNCSlV5WEVIdUNscUpUNUp6bTEwN05QaG1id29td00vZlFmWDIwTk5CZGUx?=
 =?utf-8?B?RThSNUZ3YVkxQVovM0UwNStEWUFSTjZDUW94aXpzUVZOdE5BYTg5a1p6Z0tm?=
 =?utf-8?B?Y0p4OVBBejIwZHg5WWp3ZXZER0hPSW1BWUJXQ043dnl0WlBWVk00Tkc3VjVQ?=
 =?utf-8?B?amFtU0dLb041YVpoNndxS3B4dW5ydlVGY0VEWk9iNDE5ZFJ4eERvem8rRWx5?=
 =?utf-8?B?cDBqQ2Z4R3d3dVVPK1hKUXkzSHpGMnhndTNPQnYwTHplZzVDMnBhWW9GeWxU?=
 =?utf-8?B?Z0FwbnlZTXYvK2NmT3BOZmF3Y3lVWVRSaWljZ21DZGQyUzVXdkY1UUZJdFlt?=
 =?utf-8?B?dm5DN2VLTzcxbjFQZ3RGVFZkc1NnTEZEWHRnY0VmSnhJZGxaKzBTMmQ2bEcv?=
 =?utf-8?B?bkdvMnBvQU5meEhHMVl3VXhEOVMwaHZxeElBWnVTenpWVGFob3VKamJPZlhT?=
 =?utf-8?B?RnVMYnl6N1hRbmNjZTI5K0Q2RS9RZzA1QUFSM3dmVHJHTmFvYm05QkFCWEFj?=
 =?utf-8?B?VEx5VHJRSlc0U2dyOUdVUFBwT0p1RXhVclNoektGNGRHS0FaaDBhLzZSc0c5?=
 =?utf-8?B?dkZ3VHpkMFRuVFBqMVB4dCt3S2VNalF4ZlJEWmljQVEwdTQzR0ZHUDdCLzdi?=
 =?utf-8?B?eEtsdTF0MW9PRXFJN0lkNlVJUnRWamlIS3hnVHkxVzN0TkxzdjQyMk1hdHM1?=
 =?utf-8?B?MU5WSlZIc2lNYmQ0MW9zb0JqTjJPK1F2OVVXTHhFdmY1c0kvT0s1dkdoZkVv?=
 =?utf-8?B?YW9FZnAvQzhzd1B6R3VwdTQyVXR4SWhHSU5sSlNrK09NWDZOeDdpR2JsbUlT?=
 =?utf-8?B?eUZOdncvZC9yNGNwRytFNXV0emduSXloU2QwdDg3bXIvc3c5REcxK3hYSEt0?=
 =?utf-8?B?T2hldGx1Ti9yNXQzSGxmazBqenF5RmMwaXAyaHQ4ak40dTBrMzJoVHNkcWI4?=
 =?utf-8?B?RmhvUGtnRW1rY0dYcDNQUEI5NVdyYVl6YkpEMGI4NHdWdXNlSnRyME5BR2hB?=
 =?utf-8?B?ZGQzZFpxNnVUY29RVVB3SjB3V3c5YTFsU0kwdldCYjFFamtQNUVMNDdoeGpt?=
 =?utf-8?B?VEdRT0I0UFA2ekZ1YlNaY3pvWUVFSHZSTHFMYlI5RWNCSVQwM2FtQktZeEVv?=
 =?utf-8?B?OXdrbDhpYUw3V2pQdG96NEFOT2EvTlJ3YXdwY3JwYy9vL3Y2NXBOK1d0NmVx?=
 =?utf-8?B?UytoRml3MkdKZExrZFJoYUNZMkMyZk1ETzlXWGJJWW1PcGlhUEJSZmZCU0xo?=
 =?utf-8?B?NEowVHZMRXdUSWhpSTFhYmNoaXJYeTJ6NlY5b1R3bFFuZFRxc2YyREJiTXhv?=
 =?utf-8?B?b2dWclA4Q01lREhkZERYTDRNdWZwSHRKYTREbjI5d3pnZWdWVHVCMWFrV28r?=
 =?utf-8?B?YU1qZTB4eUxmcVVyQ0gyakhrT1dxUnAwWjZXY243eDkwbDRXb0NOZStzUFpz?=
 =?utf-8?Q?LGJNzbirAdOODQylvxPUTGkeLWdK5Qt+BFLTrIeWwU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCC8F3875042EE4F8302C38EBF460C0E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d35784-b0d6-4e6a-38d4-08dadce23adb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 08:15:43.4354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nv2ZuEtI1zwJVu9dNFBXW6CBX3rhLpSh+QI5bZ2VpWOW/lEdN6tOzoxff1a0aqx3OXxveWhzRU9sUawMheTcuUBR1t31zYQYPSDrVstQfHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0410
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTIuMTIuMjIgMDg6MjIsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBXZWQsIERl
YyAwNywgMjAyMiBhdCAwNjoyMjoxMkFNIC0wODAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6
DQo+PiBAQCAtMzcyLDYgKzM4OCwxNSBAQCBzdGF0aWMgdm9pZCBidHJmc19vcmlnX3dyaXRlX2Vu
ZF9pbyhzdHJ1Y3QgYmlvICpiaW8pDQo+PiAgCWVsc2UNCj4+ICAJCWJpby0+Ymlfc3RhdHVzID0g
QkxLX1NUU19PSzsNCj4+ICANCj4+ICsJaWYgKGJpb19vcChiaW8pID09IFJFUV9PUF9aT05FX0FQ
UEVORCkNCj4+ICsJCXN0cmlwZS0+cGh5c2ljYWwgPSBiaW8tPmJpX2l0ZXIuYmlfc2VjdG9yIDw8
IFNFQ1RPUl9TSElGVDsNCj4+ICsNCj4+ICsJaWYgKGJ0cmZzX25lZWRfc3RyaXBlX3RyZWVfdXBk
YXRlKGJpb2MtPmZzX2luZm8sIGJpb2MtPm1hcF90eXBlKSkgew0KPj4gKwkJSU5JVF9XT1JLKCZi
YmlvLT5yYWlkX3N0cmlwZV93b3JrLCBidHJmc19yYWlkX3N0cmlwZV91cGRhdGUpOw0KPj4gKwkJ
c2NoZWR1bGVfd29yaygmYmJpby0+cmFpZF9zdHJpcGVfd29yayk7DQo+IA0KPiBUaGlzIG5lZWRz
IHRvIGJlIG9uIGEgc3BlY2lmaWMgd29ya3F1ZXVlIChvciBtYXliZSBtdWx0aXBsZSBpZi93aGVu
DQo+IG1ldGFkYXRhIGFuZCBmcmVlc3BhY2UgaW5vZGVzIGFyZSBzdXBwb3J0ZWQpLiAgTm90ZSB0
aGF0IGVuZF9pb193b3JrDQo+IGlzbid0IGN1cnJlbnRseSB1c2VkIGZvciB3cml0ZXMsIHNvIHlv
dSBjYW4gcmV1c2UgaXQgaGVyZS4NCg0KSSdtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCB5b3VyIGNv
bW1lbnQuIEl0IGlzIG9uIGEgc3BlY2lmaWMgd29ya3F1ZXVlLA0KbmFtZWxleSAncmFpZF9zdHJp
cGVfd29yaycuDQoNCj4gDQo+IEFsc28gbm90ZSB0aGF0IEkgZG8gaGF2IGEgcGF0Y2hzZXQgdGhh
dCBkZWZlcnMgYWxsIHdyaXRlcyB0byBhIHdvcmtxdWV1ZQ0KPiBoZXJlIGluc3RlYWQgb2YgZG9p
bmcgc2VwYXJhdGUgZGVmZXJhbHMganVzdCBmb3Igb3JkZXJlZCBleHRlbnRzIG9yDQo+IGRpcmVj
dCBJL08sIHNvIG1heWJlIHdlIGNhbiBldmVudHVhbGx5IHNraXAgdGhlIHNlcGFyYXRlIHdvcmtx
dWV1ZSBmb3INCj4gdGhlIHN0cmlwZSB0cmVlIGVudGlyZWx5Lg0KPiANCj4+ICAJYmlvLT5iaV9w
cml2YXRlID0gJmJpb2MtPnN0cmlwZXNbZGV2X25yXTsNCj4+ICAJYmlvLT5iaV9pdGVyLmJpX3Nl
Y3RvciA9IGJpb2MtPnN0cmlwZXNbZGV2X25yXS5waHlzaWNhbCA+PiBTRUNUT1JfU0hJRlQ7DQo+
PiAgCWJpb2MtPnN0cmlwZXNbZGV2X25yXS5iaW9jID0gYmlvYzsNCj4+ICsJYmlvYy0+c2l6ZSA9
IGJpby0+YmlfaXRlci5iaV9zaXplOw0KPiANCj4gU28gd2UgY291bGQganVzdCB1c2UgdGhlIHNh
dmVkX2l0ZXIgZm9yIHRoZSBtYWluIGJiaW8gZm9yIHRoZSBzaXplIGFuZA0KPiBsb2dpY2FsIGlm
IHdlIGFsc28gc2V0IHRoYXQgZm9yIHdyaXRlcy4NCg0KVGhhdCBjb3VsZCBpbmRlZWQgYmUgZG9u
ZSwgc2F2aW5nIG9mZiBzb21lIGJ5dGVzIGluIGJ0cmZzX2lvX2NvbnRleHQuDQoNCj4gQWxzbyBy
aWdodCBub3cgdGhlIG9yZGVyZWQgZXh0ZW50IGlzIHNwbGl0IGZvciBlYWNoIGFjdHVhbGx5IHN1
Ym1pdHRlZA0KPiBiaW8gZm9yIHpvbmUgYXBwZW5kIHdyaXRlcywgc28geW91IGNvdWxkIGp1c3Qg
dXNlIHRoYXQgYXMgd2VsbC4gIFRoYXQNCj4gYmVlaW5nIHNhaWQsIEkgdGhpbmsgd2UgY291bGQg
YWN0dWFsbHkgc3RvcCBkb2luZyB0aGF0IHNwbGl0IHdpdGggdGhlDQo+IHN0cmlwZSB0cmVlLCBh
cyB0aGVyZSBpcyBubyB1cGRhdGVkIG9mIHRoZSBMMlAgbWFwcGluZyBpbiB0aGUgY2h1bmsgdHJl
ZQ0KPiBhbnkgbW9yZS4NCj4gDQo+IENhbiBzb21lb25lIG1vcmUgZmFtaWxpYXIgd2l0aCB0aGUg
YnRyZnMgaW50ZXJuYWxzIGNoaW1lIGluIGhlcmUgaWYNCj4gdGhlcmUgbWlnaHQgYmUgYSB3YXkg
dG8gaW4gZmFjdCBzdG9wIHVwZGF0aW5nIHRoZSBjaHVuayB0cmVlIGVudGlyZWx5DQo+IGFzIHRo
YXQgc2hvdWxkIGhlbHAgcmVkdWNpbmcgdGhlIHdyaXRlIGFtcCBhIGJpdD8NCj4gDQo+PiArc3Rh
dGljIGludCBhZGRfc3RyaXBlX2VudHJ5X2Zvcl9kZWxheWVkX3JlZihzdHJ1Y3QgYnRyZnNfdHJh
bnNfaGFuZGxlICp0cmFucywNCj4+ICsJCQkJCSAgICBzdHJ1Y3QgYnRyZnNfZGVsYXllZF9yZWZf
bm9kZSAqbm9kZSkNCj4+ICt7DQo+PiArCWVtID0gYnRyZnNfZ2V0X2NodW5rX21hcChmc19pbmZv
LCBub2RlLT5ieXRlbnIsIG5vZGUtPm51bV9ieXRlcyk7DQo+PiArCWlmICghZW0pIHsNCj4+ICsJ
CWJ0cmZzX2Vycihmc19pbmZvLA0KPj4gKwkJCSAgImNhbm5vdCBnZXQgY2h1bmsgbWFwIGZvciBh
ZGRyZXNzICVsbHUiLA0KPj4gKwkJCSAgbm9kZS0+Ynl0ZW5yKTsNCj4+ICsJCXJldHVybiAtRUlO
VkFMOw0KPj4gKwl9DQo+PiArDQo+PiArCW1hcCA9IGVtLT5tYXBfbG9va3VwOw0KPj4gKw0KPj4g
KwlpZiAoYnRyZnNfbmVlZF9zdHJpcGVfdHJlZV91cGRhdGUoZnNfaW5mbywgbWFwLT50eXBlKSkg
ew0KPiANCj4gSXQgc2VlbXMgbGlrZSB0aGUgY2h1bmtfbWFwIGxvb2t1cCBpcyBvbmx5IG5lZWRl
ZCB0byBmaWd1cmUgb3V0IGlmDQo+IHRoZSBjaHVuayBuZWVkcyBhIHN0cmlwZSB0cmVlIHVwZGF0
ZSwgd2hpY2ggc2VlbXMgcmF0aGVyIGluZWZmaWNpZW50Lg0KPiBDYW4ndCB3ZSBmaW5kIHNvbWUg
d2F5IHRvIHN0YXNoIGF3YXkgdGhhdCBiaXQgZnJvbSB0aGUgc3VibWlzc2lvbiBwYXRoDQo+IGlu
c3RlYWQgb2YgcmVkaXNjb3ZlcmluZyBpdCBoZXJlPw0KPiANCg0KVHJ1ZSwgYnV0IEkndmUgbm90
IHlldCBmb3VuZCBhIGdvb2Qgc29sdXRpb24gdG8gdGhpcyBwcm9ibGVtIFRCSC4gSSBjb3VsZA0K
ZG8gYSBjYWxsIHRvIGJ0cmZzX25lZWRfc3RyaXBlX3RyZWVfdXBkYXRlKCkgYXQgdGhlIHN0YXJ0
IG9mIGEgdHJhbnNhY3Rpb24NCmFuZCB0aGVuIGNhY2hlIHRoZSB2YWx1ZS4gVGhhdCdzIHRoZSBv
bmx5IHdheSBJIGNhbiB0aGluayBvZiBpdCBhdG0uDQo=
