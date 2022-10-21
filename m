Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEBA60729E
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 10:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJUIlb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Oct 2022 04:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiJUIl2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Oct 2022 04:41:28 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DEB24E3AE
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Oct 2022 01:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666341685; x=1697877685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qWCp9FVtfUrBpXuEHgLM0Vc1nNKu4v3WAesWfQqxTOg=;
  b=TJ4oYecslUwJMEm8Fka6RN0x3MP6JyMNI9vo4M1jeVIeDS+B0q8WqZuS
   lOLscYiHznOaJZxZ5oF2+z+viER0hatd8qjAdIIiQbExZE4+fJmr45vaB
   TWJPklch2+mLS7mAzUwA2b5lRcAjjFKnHjdhOA0GSqz3CNriRLzcQXU6N
   Eeg+ojfqMmUHcOk5UkUl40taZEnr36l4nm/VK0SSUFFB6KbAb5p98Ko3d
   WcB7kHjPiL6Hekhy8D66Q/12ZLdmr1te/7SpNlw981N4rR3mSINatrQtZ
   SSsnXsF4NXWZ7jLoluG4kwwRoh3qAVcjiHQKQ7lVpbTKIbgk9VGH4j7G7
   g==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="212731183"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 16:41:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0jnntKR1lqA93cQKMHPB1zG/mUaYPB7QXYhSaP7ciir/gYkGsLasVU1L2PgwIJwzm7/sHOerYth857fAx1zJjUVwkzxmQsCFkcjZPS2u6EX6F+4kV5ypXVo+D2HgWU/Lx2Ht2aMBSX6iJtYREHcn+VY3LQuBNqDap/7m+HfwKaxfl3PlJdpFLn5VMbEF2EMJUEe6Q771Xfk6/1urRVv/BncZnoAI1AELkakuptaSfeWJSZnKnIaqPdug+1S8pTCDjO6cqteGeH2e1i2g+mw34PWrnljnKu3Cbwfg0YFM/ii3Afyi70WxKFKy6eSSH9wtLS3oRSs5O3u0vuYWkTMPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWCp9FVtfUrBpXuEHgLM0Vc1nNKu4v3WAesWfQqxTOg=;
 b=Ipm+66eMAYZiDpWNRHwL2tqpfA13EKzT5iutc+PikxrelKPOYqdkNYybMIgbvDq1kvt8IWxATELKTWmhfJcF65v3XQx/jQE6xFhcaw1JLDHvf1sNkddjM9dVz+J3M9tkgeIRDn2tb4hdEDc/CsC8k83lHM1B2DaVirBLcpagUoUOCcmV7UGhWQWds/hbmcyRYp6+Vh0nvhTcZNxQ3LyKy+LlwHAmhVOZgSK6m8CcU9otQOILMwiZn7a34n1g8ewYpSnhAWP1UWodjLLIdzMtVx6egSMu3pFTLeXJBFsR8IpZNlnhAgtStRu+6IYBisGrClGzOshL1xZlKS1KX45phg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWCp9FVtfUrBpXuEHgLM0Vc1nNKu4v3WAesWfQqxTOg=;
 b=AntEdXgegxOODCn/ZRNgi0QNEllMcprJiuDCyIguczyMV+pCuO9uDIftjqXjEf/E28V34XttgolpGI3fNQGbiw4qFfRkA3fTQftdZYGLK/QsBN67F2ZfJU1DGIQYhXoEhBJH93T47fVcuf7jEub2Iig5OFFtcxQwn+4XUCgnZvY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB5297.namprd04.prod.outlook.com (2603:10b6:408:d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 21 Oct
 2022 08:40:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 08:40:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC v3 00/11] btrfs: raid-stripe-tree draft patches
Thread-Topic: [RFC v3 00/11] btrfs: raid-stripe-tree draft patches
Thread-Index: AQHY4h9e5Wh4AG/Ik0+aVBfWG5u1aa4XcO6AgAEccwA=
Date:   Fri, 21 Oct 2022 08:40:47 +0000
Message-ID: <c5f76fbb-dcb0-db95-f0ab-6863f9b62dcb@wdc.com>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
 <Y1FscZgAqwVx7Jtx@localhost.localdomain>
In-Reply-To: <Y1FscZgAqwVx7Jtx@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN7PR04MB5297:EE_
x-ms-office365-filtering-correlation-id: b199e89f-fee6-48e7-f57b-08dab33ff34f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ou1eVgAsK4X4kuFGwKCsUhRDdEo8iPsGJTHG4/Pga17jWrvREs5JDQWq7UC7RsXRAHq3j0pJCfa2Jof6CH4YdrI9X8ffuuScA2YWPqhCBdn+on+DBOrFCQ36TL8EMSshVIw65avHqdGMcAO2J/yJOtt+Z+FmQ907dcWSHmdvgnR9pPWN7VMJNRpwTei143GP+rNrvESspWq0ye1qMJXs9JFQGG57YiKZ0370mloR35n78N4E/f7tGIhpb7NxTjiRjZBpzMPrMbkLpQY/o6bXrP5dBSUg0TOGcBme6TFHtCNowzbp2x8Q5m+sy7iwJ2Eb22W5va1GFTDdI840RskZhuWTwEj7B22ezemuRvUuOwXybfoc3WbQfSCcPjr7nLmM0oH40HM9lD6SQa0cZjkqgR/T1wLDGj5yyDTWRRDzrFztmYNtNeZwsAwzKhLwVUWLG/+X8zJUJLxNr3F+GaBYPte775mQWfW/RA/81OSg3TacUyvvn0rTfvd3nCUwWKK32AUNBcsbpPHFv/fI41CaWlg7iYC+3iaAkPeq+fsVX87Qcf1hnlobtluLKQXIxGpBnpi0jITXGHPgSqWnpGY1h54+yTF0/6Vl7oeJTklWQgWjOjBsrEp8xlc5x8lh+mr9qy4kmC5po0gC63bv22qOwX2FDm8UF+PS0kOb80dAdYXT5/4+Akbg0A3xUdgoHWAR8x0AUEC3vNdyAFIUqzKbvgTzgMIZItpgYoCE5w+VOL8rJjznTl2HvxqtgzMgnZNT1n3WE+hkVrq3IWhysvdWl7yvkvQA/y8Qu6nbScex6XXHNQ4twnGYB5EqtNLMGOgxoRYaHPO02NOvpOR+GPKUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199015)(86362001)(38070700005)(316002)(66446008)(66476007)(36756003)(6916009)(91956017)(478600001)(64756008)(53546011)(71200400001)(122000001)(76116006)(5660300002)(2906002)(6486002)(31696002)(66946007)(41300700001)(2616005)(6506007)(8936002)(82960400001)(38100700002)(66556008)(8676002)(83380400001)(4326008)(6512007)(31686004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXRmVWI5M1V3TzNxTk1nem1aSjZwT0w5QzBmT2UyVFBFNkZKWGtMa212ZTJp?=
 =?utf-8?B?dklMN0dxMGZwMUlqbm9SUXZxeGNkTnVUN2R6aWxObW9uN1ZyUXlFYkxMK2l3?=
 =?utf-8?B?S2ZsOVBOZ2J6Uk1VMDJuYlMxK0pPNytrRzYrejVzVzVlbHdOYkRIcVlERkE5?=
 =?utf-8?B?VElUa3NkbzdWSGgxVko0bHEyQTJ6Rm5pQmE4VDJrRk1LR3hXWE5zTElZcDVj?=
 =?utf-8?B?dW9RRk9YNUFYNE9BRFZldUY4UlZoa0pPWW85REwza0hUSS83dksxUVI4NlYr?=
 =?utf-8?B?OWNLdCs4UW4yL3duRTM5NjhUS2ZEbWxoS1p1Q1o0MUc4bEkxK1V3dHA1VXNo?=
 =?utf-8?B?dHJIT3E5N2cxTXFiNE94VW5NSlpEa2tLYWMzWVkyd1hRTTE5dUhlbFljNHpk?=
 =?utf-8?B?TjZEWHRXWGdycUFsUEdHdXUvUzM1M0gzWHd5TE1kZzVEUEMxSW53SWVCaW03?=
 =?utf-8?B?WWoraCtUYk9wYWVuemd3VityaDBTejVVaWN1VXRyaHhLYjVrNjE2NHV1T1Zi?=
 =?utf-8?B?YWNTOW54aXQvSm9vRVhDVHpObDNVNUJ0aUJqblJHZ1VyZ3ptdXRsSndkWUI0?=
 =?utf-8?B?SWlrRFFYcDdwbG4vaUowcGo2UmJuT1FjWUlvajFtTlJuTDU1UlU1S0t3cnZV?=
 =?utf-8?B?SGxCc1Z3eGdFbzRPUHVCUVB3YjhyRVpyN2x6b0U3VU1IMzNCeFVPK1V0TWkz?=
 =?utf-8?B?MVlEd3lXdXFNSE1yZFJiaFBLOUE2dkhzSmVHcVAvZldtci9rUlA3U1VsNlI2?=
 =?utf-8?B?UkMrQXdEUXVFWTNrSU9SdkMvRXNONlh6VnNGVzdXUTZiL2VQK2tjUXA0TXll?=
 =?utf-8?B?QmxPNDAxWHBlM0FqeGdPWTA0YjBoTHlHN3ZCbEh3NjFjZnd2YnRZSXNSYlYz?=
 =?utf-8?B?WWZtVkdSNXdBMnBoWFpXSmxGSk1BaXk1OTJnQW16R1MxeXdqV2FoSEFsQVdm?=
 =?utf-8?B?dENBa2UzdzRGcTIxcXc0UkQ5RUdKY3lOTFN4bE9VdngwWVJjN0s4VGd2Zncz?=
 =?utf-8?B?NDhKOTZEbVMzakh2cVQwY1VjZCs1TjdaYkZvK3p3UTlaMW9PdjFuNGs1Nlo1?=
 =?utf-8?B?M21IbGZOMVB4MWhnNFFIZUxleUd2OXA3Wk5BUGJJTG01YmJvcWt2OVNlQnNl?=
 =?utf-8?B?N055dG82OEVQQ0xKVyttSGNoTTZ6cUVzejJzdFhzaVhzZjRtZHEyeUh5bmRx?=
 =?utf-8?B?U3VCOGo5OE5DUDAxSjBBdURJdUVsM1hwdzk5NERoUmxKaUNSM3NmNnozRFNV?=
 =?utf-8?B?cmp1WnZTaHcrVkl3bXM0ekthcUg2NVVMSk9pT3BJRnR3MGU5M2hIcTRGZmM1?=
 =?utf-8?B?eE9iN2hVb3dDbWVEN29oTEZjYXMzRDNtWlZZa3JuLzZCRkVLSEhCbHJyWnZ6?=
 =?utf-8?B?NlJoaVk5M1hUT1NCTlhvOXVmOThQL3p3WUVxM0E4RTBZbEp0bFd5S3Jkem5j?=
 =?utf-8?B?SE8vTW5zTlgwa0VqMC95Zm12bkRTMmZnYi9UMk45c053TWR5YUNiNDF6MWV5?=
 =?utf-8?B?a0t0WFpoVktBQVNJem5xWlhoMEg3VU5zR3R2WFVDaUNtWnFLVkExaVQ4bCtG?=
 =?utf-8?B?Y2JUOTFLc0hZa0JDUGpYdzhubkxzMEhvWi9YellXRXhSVmFmc0h3SGRyZCtn?=
 =?utf-8?B?T2FLdENySHlDS3hVWFJFMFFhbVhLVVJiNU5yNzlzUmRCYW5QaW5rdXNFV01z?=
 =?utf-8?B?cGpTakIrT0QwODg3bTFOZmU2Z2RWMXBGWG9NaG9haHJMeTROUCtNT0NaODRa?=
 =?utf-8?B?N2JwVk9Fb0prTFYyekErOVptRmJ0NHlXZTZvZmNJSk1VNVBaRGphcXFxSjJI?=
 =?utf-8?B?bXJOOThWeFFYYkU5djg4R0VxdlhQUTAzdUdlOHNPbHM0YkIyeHZLUWxtbEJV?=
 =?utf-8?B?QUhieUszYzRVRTh4WkUxMkhKZThmMFZ5UllsZno2L0ZhRlpVbjNpcEdqbjcz?=
 =?utf-8?B?WkF0WVV6eWlUT3NYTG9CQWhSSjloYUliQmwvY1lrMnc1TUMxYWRKekhTWDFI?=
 =?utf-8?B?Mk8zSXRKWnVSazZtQkxGa09JamRWdDYrajVlTFpoTXVvQk8zOWFLLzhZb2Mw?=
 =?utf-8?B?VUhtMFdRZ1RjczJHMW9BdHhhNzVUdW0xZE5UWWdmSFFjVEVQYkZpSWRHeEU1?=
 =?utf-8?B?NTAzMWQyWmM4RnpkNUhZRjVsSFFIZnFVUGtOaFV4U2cvZFo5a2FYQkpNeFFu?=
 =?utf-8?B?dm4zVTZYbEtzTTZKNUQwdUZrcTFLL1hmUk9Wb2ROYlZGakh4YWtwT00wdUdp?=
 =?utf-8?Q?ceX15i3owI4ref4PBPNAxsy/rzUL3mYY4ZiR3gyErM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEA901E8233ED843BFF920F2CF13C4CE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b199e89f-fee6-48e7-f57b-08dab33ff34f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 08:40:47.2136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBBvj+aZjH3YNMuW71WXTaVU/hOoaXMDwB5HUhjiLYyY2dM38hx1xU2GSaIo6ahqEprOijBEjIkQIa37omwSBQaHs/ynzWW0JskkIsj8vmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5297
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjAuMTAuMjIgMTc6NDIsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPiBPbiBNb24sIE9jdCAxNywg
MjAyMiBhdCAwNDo1NToxOEFNIC0wNzAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiBI
ZXJlJ3MgYSB5ZXQgYW5vdGhlciBkcmFmdCBvZiBteSBidHJmcyB6b25lZCBSQUlEIHBhdGNoZXMu
IEl0J3MgYmFzZWQgb24NCj4+IENocmlzdG9waCdzIGJpbyBzcGxpdHRpbmcgc2VyaWVzIGZvciBi
dHJmcy4NCj4+DQo+PiBVcGRhdGVzIG9mIHRoZSByYWlkLXN0cmlwZS10cmVlIGFyZSBkb25lIGF0
IGRlbGF5ZWQtcmVmIHRpbWUgdG8gc2FmZSBvbg0KPj4gYmFuZHdpZHRoIHdoaWxlIGZvciByZWFk
aW5nIHdlIGRvIHRoZSBzdHJpcGUtdHJlZSBsb29rdXAgb24gYmlvIG1hcHBpbmcgdGltZSwNCj4+
IGkuZS4gd2hlbiB0aGUgbG9naWNhbCB0byBwaHlzaWNhbCB0cmFuc2xhdGlvbiBoYXBwZW5zIGZv
ciByZWd1bGFyIGJ0cmZzIFJBSUQNCj4+IGFzIHdlbGwuDQo+Pg0KPj4gVGhlIHN0cmlwZSB0cmVl
IGlzIGtleWVkIGJ5IGFuIGV4dGVudCdzIGRpc2tfYnl0ZW5yIGFuZCBkaXNrX251bV9ieXRlcyBh
bmQNCj4+IGl0J3MgY29udGVudHMgYXJlIHRoZSByZXNwZWN0aXZlIHBoeXNpY2FsIGRldmljZSBp
ZCBhbmQgcG9zaXRpb24uDQo+Pg0KPiANCj4gU28gZ2VuZXJhbGx5IEknbSBnb29kIHdpdGggdGhp
cyBkZXNpZ24gYW5kIGV2ZXJ5dGhpbmcsIEkganVzdCBoYXZlIGEgZmV3IGFza3MNCj4gDQo+IDEu
IEkgd2FudCBhIGRlc2lnbiBkb2MgZm9yIGJ0cmZzLWRldi1kb2NzIHRoYXQgbGF5cyBvdXQgdGhl
IGRlc2lnbiBhbmQgaG93IGl0J3MNCj4gICAgbWVhbnQgdG8gYmUgdXNlZC4gIFRoZSBvbmRpc2sg
c3R1ZmYsIGFzIHdlbGwgYXMgdGhlIHBvc3QgdXBkYXRlIGFmdGVyIHRoZQ0KPiAgICBkZWxheWVk
IHJlZiBydW5zLg0KPiAyLiBBZGRpdGlvbmFsbHksIEkgd291bGQgbG92ZSB0byBzZWUgaXQgd3Jp
dHRlbiBkb3duIHdoZXJlIGV4YWN0bHkgeW91IHdhbnQgdG8NCj4gICAgdXNlIHRoaXMgaW4gdGhl
IGZ1dHVyZS4gIEkga25vdyB5b3UndmUgdGFsa2VkIGFib3V0IHVzaW5nIGl0IGZvciBvdGhlciBy
YWlkDQo+ICAgIGxldmVscywgYnV0IEkgaGF2ZSBhIGhhcmQgdGltZSBwYXlpbmcgYXR0ZW50aW9u
IHRvIG15IG93biBzdHVmZiBzbyBJJ2QgbGlrZQ0KPiAgICB0byBzZWUgd2hhdCB0aGUgbG9uZyB0
ZXJtIHZpc2lvbiBpcyBmb3IgdGhpcywgYWdhaW4gdGhpcyB3b3VsZCBwcm9iYWJseSBiZQ0KPiAg
ICB3ZWxsIHN1aXRlZCBmb3IgdGhlIGJ0cmZzLWRldi1kb2NzIHVwZGF0ZS4NCg0KU3VyZSBJJ2xs
IGFkZCBhIGRvY3VtZW50IHRvIGJ0cmZzLWRldi1kb2NzIChhbmQgc2VudCBpdCB0byB0aGUgbGlz
dCBmb3IgcmV2aWV3KS4NCg0KVGhlcmUncyBzdGlsbCBhIHByb2JsZW0gd2l0aCB0aGUgZGVsYXll
ZC1yZWYgdXBkYXRlIHRvIGJlIHNvbHZlZCByZXN1bHRpbmcgaW4gdGhlDQpsZWFrIGNoZWNrZXIg
eWVsbGluZyBvbiB1bm1vdW50LCBzbyBtYXliZSBkb2N1bWVudGluZyB3aGF0IEkndmUgZG9uZSwg
c2hvd3MgbWUgDQp3aGVyZSBJIG1lc3NlZCB1cC4NCg0KPiAzLiBJIHN1cGVyIGRvbid0IGxvdmUg
dGhlIGZhY3QgdGhhdCB3ZSBoYXZlIG1pcnJvcmVkIGV4dGVudHMgaW4gYm90aCBwbGFjZXMsDQo+
ICAgIGVzcGVjaWFsbHkgd2l0aCB6b25lZCBzdHJpcHBpbmcgaXQgZG93biB0byAxMjhrLCB0aGlz
IHRyZWUgaXMgZ29pbmcgdG8gYmUNCj4gICAgaHVnZS4gIFRoZXJlJ3Mgbm8gd2F5IGFyb3VuZCB0
aGlzLCBidXQgdGhpcyBtYWtlcyB0aGUgZ2xvYmFsIHJvb3RzIHRoaW5nIGV2ZW4NCj4gICAgbW9y
ZSBpbXBvcnRhbnQgZm9yIHNjYWxhYmlsaXR5IHdpdGggem9uZWQrUlNULiAgSSBkb24ndCByZWFs
bHkgdGhpbmsgeW91IG5lZWQNCj4gICAgdG8gYWRkIHRoYXQgYml0IGhlcmUgbm93LCBJJ2xsIG1h
a2UgaXQgZ2xvYmFsIGluIG15IHBhdGNoZXMgZm9yIGV4dGVudCB0cmVlDQo+ICAgIHYyLiAgTW9z
dGx5IEknbSBqdXN0IGxhbWVudGluZyB0aGF0IHlvdSdyZSBnb2luZyB0byBiZSByZWFkeSBiZWZv
cmUgbWUgYW5kDQo+ICAgIG5vdyB5b3UnbGwgaGF2ZSB0byB3YWl0IGZvciB0aGUgYmVuZWZpdHMg
b2YgdGhlIGdsb2JhbCByb290cyB3b3JrLg0KDQpXZWxsIEknbSBwcmV0dHkgc3VyZSBJIHdvbid0
IGJlIGRvbmUgYmVmb3JlIHRoZSBnbG9iYWwgcm9vdHMgd29yayBpcy4gQnV0IEkgYWdyZWUNCnRo
ZSBleHRyYSBhbW91bnQgb2YgbWV0YWRhdGEgZm9yIHRoZSBSU1QgaXMgYSBjb25jZXJuIHRvIG1l
IGFzIHdlbGwuIEVzcGVjaWFsbHkgZm9yDQpvdmVyd3JpdGUga2luZCBvZiB3b3JrbG9hZHMgaXQg
cHJvZHVjZXMgYSBsb3Qgb2YgbmV3IGV4dGVudHMgZm9yIGVhY2ggQ29XIHdlIHdyaXRlLg0KQ29t
YmluZSB0aGF0IHdpdGggem9uZWQgYW5kIHdlIHJlYWxseSBuZWVkIHdvcmtpbmcgcmVjbGFpbSwg
b3RoZXJ3aXNlIGl0IGdvZXMgYWxsDQpkb3duIHRoZSBkcmVuY2guDQoNCkNhbiB5b3UgcGxlYXNl
IHJlbWluZCBtZSwgd2l0aCB5b3VyIGdsb2JhbCByb290cyBhbSBJIGdldHRpbmcgYSByb290IHBl
ciBtZXRhZGF0YQ0Kb3IgcGVyIGRhdGEgYmxvY2sgZ3JvdXA/DQoNCg==
