Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0682860DC16
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 09:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbiJZHaP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 03:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbiJZHaL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 03:30:11 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E2010B69;
        Wed, 26 Oct 2022 00:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666769408; x=1698305408;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=drBGQfazUcY2K/YXWEAdjScdAeQeWW7XpCo026DU28E=;
  b=j/eJLBc0FSkPjWzT8MsiQGSlMnCF/sGEBHafRiBcIXJ/r+u3kbaLSl1A
   G/Eobn75p8vVx8HeaiX54qU5yWVxl43sqIgehXTQqTCAZ9axvArtQdLmP
   OkP+Nd2As7FMnJfr48OQ2KoA77+GfuNXgT0Jx3qPodXlV8jooKtT+3HHO
   ZnLTgInH0QISjLWYiT1qIjeofbYucKGYtmGnsQEUQPzX8yAOh5PrnJvHy
   K0QNmZsxQiG0rFXRC5Wm886cU8HeZVMvlp3xtDeDhikgSHrO7V2K7ACqn
   hOGE8PfWr0krMQ0mO+nJXjrHUfypIr7v3J+Fjqoxl+XOHFShenUSeRBhW
   A==;
X-IronPort-AV: E=Sophos;i="5.95,214,1661788800"; 
   d="scan'208";a="213064112"
Received: from mail-dm3nam02lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2022 15:30:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+Sas5BIO4yBgQly1BKbHkqvkihmE+ga1FJwVg4h9Hz3EgTvby4ytGK9ho3Y2LRyRWo2xJQQO+XX0Okaav+K0PE/7o0x39PLmW1Rn5/XFvxpgFNyxD0qVsjReI3il086WgR6NoljfVQKQD6tM5wZdh/WCkhsVFWcIK8tefv99IhLED0o9YjSd+ArVpdCDdig6bZBoe6ExZqa9zuNpzs7estcmaL0Df6xrWp7vofCnfS+8qk8t4rI770r3ckOG57KpjbTBge/ItKcLkfrDzsTW4zWnjHyQ02Olhbyq5avZSQKn52smExmTxmvM2EtbRIpee0ILDjNSL5uWrzDZa45qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drBGQfazUcY2K/YXWEAdjScdAeQeWW7XpCo026DU28E=;
 b=IEgZCZ4Nux5lnbQzlkI1cSyf81j/LrcuAfq/fN0cRF+P4l1xY+Usjy1+Cg0omR/3iss0WFofNOQ4vSbErnblf71f22N1K00/0RpxQ1z5RTw1wIxTHeAwd9apdPePn9KL28MXjUOgL19jaeB+d9gXjacL6qPr0Kw1tRZP8IW3lQPvxIQ5dTRu/faI0m0/e9DkBT5XoQ1e3pOoLQkY5w3DRFZGhiDNxaBih9cdKfmbAN9+/C/W+jc3FfU4bIkMyqDc9iOHHRFd/Q+OnXWhi/GlFEuMrvPsXpDt2VmMKJS2qTG4DDJsopYo6ouy5u2slz68SRsxWHq9BVGPs49st4J0jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drBGQfazUcY2K/YXWEAdjScdAeQeWW7XpCo026DU28E=;
 b=tFzT9dvoKy7wSboVHJ2891VNAorjgDEWivSeLZI+w2NM6fa+ZZi34KZ6lPvXJXeoyxWaLIZqDYE9b6uxhOQ+nYhwzL2RsMx2fBs16EpSB7rgbq0Yxz5QOk+x6bhOi6yhDk7tedvq7V3Dn9ohLLAZyqjL5cRbHuTrqol6Dv8IIPY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB4207.namprd04.prod.outlook.com (2603:10b6:805:32::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 07:30:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Wed, 26 Oct 2022
 07:30:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     syzbot <syzbot+858534c396b0cdd291d2@syzkaller.appspotmail.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "sweettea-kernel@dorminy.me" <sweettea-kernel@dorminy.me>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] WARNING in cow_file_range_inline
Thread-Topic: [syzbot] WARNING in cow_file_range_inline
Thread-Index: AQHY6L/Hbx5HDeTB4UuL/UsfzzIiK64gSASA
Date:   Wed, 26 Oct 2022 07:30:02 +0000
Message-ID: <b9fb66a0-5516-d1d4-34d6-da91c60c56cf@wdc.com>
References: <00000000000080bb5c05ebe34a4d@google.com>
In-Reply-To: <00000000000080bb5c05ebe34a4d@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN6PR04MB4207:EE_
x-ms-office365-filtering-correlation-id: d5587133-00f3-4970-6735-08dab723e520
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LuXQn0KONQsMk8oZxtp+Iy4semT5ZPDxNflGJusbKlJqJPFOc0furCUOEgfBpkEG32mRCkS+NKlQDgS7kUok7eXYD0+HMmaNygs3uNUeLqkCkDEEMh7jox6UPFChoafEwp/wixocgt+CDGEVh9afLpnhjyZ1W5lAtzEImVYDD1onQw5FLF7Prj21lVMmVAkunOmLV21yhtF2t5ksHOhnc324AvNPmO7JcBUEr94WjmckKXTzPebRZr1H4qUBWltPkU9ofWE/Joo1P7Atd+gmRbT+DUoz35cA3y0gC077Fri76bXfIwOzd/fP8QMvqIgJ9MQMakJRtoMPBXIWyOmxKARliuioZ/5KXxpJ/2QpSQXlLHKaob+/0yah+s1Lm4pmJF+sbFTduBnxJmbi42lDobQ1u9oX30EQrj5gngsf+JZYy9e8xPKc0lsYaQoNRToBHgmkaMgO4D2fFnWAjFyYUIFPVfns6V32S2G4DgasOTqlqpo2eevZyY5tSrwA6ylyqSKblqbqaC0EfOmKA8HASoslgYIvOCpCtU1VnEwcWf/OttEXIifFwR64JTu9jK2Q13lUdqjVWvxMpBjJwus5nI/teouZsSM8JGlkrn4Th15gpQP+rVozUOTgvyPCSBqDI6iFV4h+y1qsk98w5xX/BRiddaCV1dgm3bUPQ6b8BqK0oKRZN29emDlKRoV/mFJwvNrpfB0DMF/A2hey3zwMqkCLWY3Iy+G/vdfcufJ32l/dw/zWtch0lStE1W9FaXthwQ2JEJFTt7YUF+tg1DQqifKQXHfnFOd3osY06gGVh/OmzSUZ4RdnsHVgSfE9HO/WZqTc4TAu78oAxZTWiU6ufWvj8cv2lrk9uydBEuczWE/PyRnd/HxHO/7e8SJSXndeChyKfOgX0VJmC0+Cqxe7B7AOdroTc99URtvWHpwNcyY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(31686004)(66446008)(66476007)(64756008)(66556008)(8936002)(41300700001)(5660300002)(45080400002)(66946007)(91956017)(76116006)(8676002)(6486002)(71200400001)(2906002)(478600001)(966005)(53546011)(6512007)(6506007)(36756003)(31696002)(2616005)(316002)(110136005)(186003)(86362001)(38070700005)(82960400001)(122000001)(38100700002)(83380400001)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3AxQWpuSDBIK1ZGTkVNRFExNEV1TFM3WllUWFcrbklsbWU3Y1JPbWpEbTZM?=
 =?utf-8?B?eXc2SHpTUXFrM05OeGh3MjA1UUlsZVNQVHRaQUNPL3NuYXlOOFlpc0hZb3dH?=
 =?utf-8?B?dW9nT3RnYVpZVTBOYXdCdEdIRGdVQTVwWklBOGR4QUkzN3RHRE9OWklObW9L?=
 =?utf-8?B?NFZGcmlEMml3ek5kc250ajNOcFNzR2ZuYm1zUkRrYks4bDJRNnJQRFpxY3FT?=
 =?utf-8?B?WjJlWmNsUUFUT3c0ZlJyWi8zeEt0UE9zUFB2WmdVb01YWXdDWm1mOHRNQkph?=
 =?utf-8?B?N3FTblBabkNUOFNpbGdGRm13QlQ2akVtd1MrNlN1OUhTdVYwdjZvZDNqZVY5?=
 =?utf-8?B?Vi9DbURWZzAxbU1nSzZENFZHazlyYmNGc2pjaFpSWGQwVmtJS0Q3eEs5Q2RC?=
 =?utf-8?B?R0liQk9BRlgzRkZGVUFuRTdUMUVPR2lLNWNFZDdnNnB4UlFWRkg5Z3hENUFL?=
 =?utf-8?B?UXVKK0lzN1MzS2dYbFlTU21aMFMzSlJVYlNFcjZxY0FsM0VFdnREQmNNTzU0?=
 =?utf-8?B?R1hURWh2dU4wNmdEZWYyeUljWUg2YzVORkRSWTlzMGwxbm9QK2oySk43TVpu?=
 =?utf-8?B?a004V0F0bFc4VXZkeSsvQW9RTUFlZjcvZThtNHlIVEVjRjYvcHM0citjZEdG?=
 =?utf-8?B?Yk5FMmJiM3ZjUWtmNW1DZW9jNkhNczZ0aTJHbGVwUWxqcVlYVWJiaXF3dFUz?=
 =?utf-8?B?cHo2Kyt3amF6UU1ZU1JWcjBGb2Z6MG91bFhJOHVtMVh3ZWlKcmNScVE5YWRZ?=
 =?utf-8?B?SUV5UU96VTBGRlNIdWVzZzlaa0I1WmNkUENOeGNJd1NFMkJyRWJEcC8wdFhI?=
 =?utf-8?B?UHpqVUxhUEtHcjU3c3hVVnUxKzBXVHdXWnZJTDN0d3pTK0wyTkkzc1ZpTWpP?=
 =?utf-8?B?WVNOMjdDL21NNko4VmlkYTFGQXNKYndBeSs0R2FDSkVVV211dU1lVkNwYiti?=
 =?utf-8?B?UGoyTnRPTTlaSmh3WHhMT3o5QzAwSFgvTEkvcWh4eXArb2p4eGVvQlQxR3dj?=
 =?utf-8?B?c3p5RUJEQ0JrUUhROXVtK1dYcTR6ZmZJQTlaV0FBUmoxK2FkeTU2Y0diNzJo?=
 =?utf-8?B?d0diUU9XenRTWUJ1N0lWL0dXMGFqNVNrbXRBOFZsUFFwN2RsQ2cyYW5Rdmgr?=
 =?utf-8?B?cldlZGc2QlpCdjYyNVhuYnl2bjVjU3NBVlVZR1JiZ0VpT0FKTWlsRDJVVDVK?=
 =?utf-8?B?TE9aU1RqT3dWZzZZaStKQU85NFd0SFp5NS9MOFgvODJ4cmNRUWlyVHFTM0cw?=
 =?utf-8?B?bjROc00vaVIyWGwwMEdFeFJ2dlRYZjVBRXQ4N3ZNZmlOR0hhTVNTMjhsS2lY?=
 =?utf-8?B?bDFENGRtcE5nbjZFcmE5M1NTdVBNYUx1MS9GWnNpTFRYYjFvNGNoc0YxNzQ5?=
 =?utf-8?B?M0k2aGI3dzBPanJCNlZWdEZoZ0pGTWpPbmZjdzZOK09aN2pOU0xZWERveU4w?=
 =?utf-8?B?ZDhidmo1MzdESDV2QW05S1AyMWxVdUg1cU0zTGpSU01LOXF3bk5Rc09RcnFE?=
 =?utf-8?B?OEtBbzErdXJQZVl2bGRuQ0R4V0wrQUtUUjVJSnlWWFgzdTlTRWJKY2ttaUIx?=
 =?utf-8?B?Y2JNR1RHcytXVnRUMnNEY1hKK0tWMmwwSHd0Rk52djZ3VHZVUkdSZlRlaENX?=
 =?utf-8?B?YTVpN1JDc3NSbTZoVjhWTG9PcGFOQTV2QmlHeEdBdVh3UCt2VHpMNG9QWDV0?=
 =?utf-8?B?SFN6dmoxeWJ6Wjdsd0Y0ZWFJSzB0cFQrZlJpNFAwS1MxNnE4c0lzdzhLUnBt?=
 =?utf-8?B?a0c1OUYzWDRJT1NZU0xKUVlRcENMWWVPQXZjMjhKZ1FNY0N1ZVhKY2gwWnAz?=
 =?utf-8?B?M1ZnRHZxZDRTZFF4WDhIampXYmVySjZRbzhzQmdpN2ErWll4VStTd0pNUjlx?=
 =?utf-8?B?ZzhiU0tDQnZua1RyWnh1ZmFETEkyOXlHR01DVmdWREw1RjdXZFdZVy9TUnR2?=
 =?utf-8?B?S21rZnY1MjFXcE85OFJzUDVZcmt1MC9xem5PVStiUjRia1E0OVBtb1hhQW9h?=
 =?utf-8?B?em9PTnB6RW5KMkF4NDc0UXFHa2NhTzRXc3B6T3F0d2FTUCtSOWswM0tYODkz?=
 =?utf-8?B?WTNtYnQwdTVrd1dTa2c2VjE0SURxM2FHYU4vMEVPWGErc0IyUFFBTEg4ZEFp?=
 =?utf-8?B?OFFqbmwrejE5aVJZYkw0UlI3VHg0OWp1Q1krY3psbjUxUXpLRGgxdzdqOFRF?=
 =?utf-8?B?UlFuOUYzMHRRSWFYSFQ1UzAxMVZxbmFRRy9tNitWQjJKZWp4NnIzeFlQRThD?=
 =?utf-8?Q?juJAxd8PZYXGiEVUdJsTRjW15Sy4z14gG+GQmkeTyY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B8F83BCFE792A46925F7FE83F09C5A0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5587133-00f3-4970-6735-08dab723e520
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 07:30:02.1877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TI8p1MR0hoJ9+oH9Z113h8mq6Nx74OQFXnaslOhizvx7HWB9HjWK81fAYPboaMnWpX8Um0EUSUoHIdR3h98XpJrQzPWtQt+YD8ecbcaxkVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4207
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjYuMTAuMjIgMDA6MTksIHN5emJvdCB3cm90ZToNCj4gSGVsbG8sDQo+IA0KPiBzeXpib3Qg
Zm91bmQgdGhlIGZvbGxvd2luZyBpc3N1ZSBvbjoNCj4gDQo+IEhFQUQgY29tbWl0OiAgICAzMzdh
MGEwYjYzZjEgTWVyZ2UgdGFnICduZXQtNi4xLXJjMy0xJyBvZiBnaXQ6Ly9naXQua2VybmVsLi4N
Cj4gZ2l0IHRyZWU6ICAgICAgIHVwc3RyZWFtDQo+IGNvbnNvbGUrc3RyYWNlOiBodHRwczovL3N5
emthbGxlci5hcHBzcG90LmNvbS94L2xvZy50eHQ/eD0xMDkwZTgyMjg4MDAwMA0KPiBrZXJuZWwg
Y29uZmlnOiAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC8uY29uZmlnP3g9MWQzNTQ4
YTQzNjViYTE3ZA0KPiBkYXNoYm9hcmQgbGluazogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5j
b20vYnVnP2V4dGlkPTg1ODUzNGMzOTZiMGNkZDI5MWQyDQo+IGNvbXBpbGVyOiAgICAgICBEZWJp
YW4gY2xhbmcgdmVyc2lvbiAxMy4wLjEtKysyMDIyMDEyNjA5MjAzMys3NWUzM2Y3MWMyZGEtMX5l
eHAxfjIwMjIwMTI2MjEyMTEyLjYzLCBHTlUgbGQgKEdOVSBCaW51dGlscyBmb3IgRGViaWFuKSAy
LjM1LjINCj4gc3l6IHJlcHJvOiAgICAgIGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gv
cmVwcm8uc3l6P3g9MTZlNWE0MjI4ODAwMDANCj4gQyByZXByb2R1Y2VyOiAgIGh0dHBzOi8vc3l6
a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVwcm8uYz94PTE2Mzg3YTE2ODgwMDAwDQo+IA0KPiBEb3du
bG9hZGFibGUgYXNzZXRzOg0KPiBkaXNrIGltYWdlOiBodHRwczovL3N0b3JhZ2UuZ29vZ2xlYXBp
cy5jb20vc3l6Ym90LWFzc2V0cy9jMDExZjdlNGU3NjQvZGlzay0zMzdhMGEwYi5yYXcueHoNCj4g
dm1saW51eDogaHR0cHM6Ly9zdG9yYWdlLmdvb2dsZWFwaXMuY29tL3N5emJvdC1hc3NldHMvZDAx
OWM0ZWQyZWQyL3ZtbGludXgtMzM3YTBhMGIueHoNCj4gbW91bnRlZCBpbiByZXBybzogaHR0cHM6
Ly9zdG9yYWdlLmdvb2dsZWFwaXMuY29tL3N5emJvdC1hc3NldHMvYmUyZjQ3NDU4MGY5L21vdW50
XzAuZ3oNCj4gDQo+IFRoZSBpc3N1ZSB3YXMgYmlzZWN0ZWQgdG86DQo+IA0KPiBjb21taXQgY2Fh
ZTc4ZTAzMjM0M2RmNTI1YjhkMDVjNThiNDYyODI3ZjEwYjJhMw0KPiBBdXRob3I6IE9tYXIgU2Fu
ZG92YWwgPG9zYW5kb3ZAZmIuY29tPg0KPiBEYXRlOiAgIFR1ZSBNYXIgMTUgMDE6MTI6MzUgMjAy
MiArMDAwMA0KPiANCj4gICAgIGJ0cmZzOiBtb3ZlIGNvbW1vbiBpbm9kZSBjcmVhdGlvbiBjb2Rl
IGludG8gYnRyZnNfY3JlYXRlX25ld19pbm9kZSgpDQo+IA0KPiBiaXNlY3Rpb24gbG9nOiAgaHR0
cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9iaXNlY3QudHh0P3g9MTY1ZjEwZWU4ODAwMDAN
Cj4gZmluYWwgb29wczogICAgIGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVwb3J0
LnR4dD94PTE1NWYxMGVlODgwMDAwDQo+IGNvbnNvbGUgb3V0cHV0OiBodHRwczovL3N5emthbGxl
ci5hcHBzcG90LmNvbS94L2xvZy50eHQ/eD0xMTVmMTBlZTg4MDAwMA0KPiANCj4gSU1QT1JUQU5U
OiBpZiB5b3UgZml4IHRoZSBpc3N1ZSwgcGxlYXNlIGFkZCB0aGUgZm9sbG93aW5nIHRhZyB0byB0
aGUgY29tbWl0Og0KPiBSZXBvcnRlZC1ieTogc3l6Ym90Kzg1ODUzNGMzOTZiMGNkZDI5MWQyQHN5
emthbGxlci5hcHBzcG90bWFpbC5jb20NCj4gRml4ZXM6IGNhYWU3OGUwMzIzNCAoImJ0cmZzOiBt
b3ZlIGNvbW1vbiBpbm9kZSBjcmVhdGlvbiBjb2RlIGludG8gYnRyZnNfY3JlYXRlX25ld19pbm9k
ZSgpIikNCj4gDQo+IEJUUkZTIGluZm8gKGRldmljZSBsb29wMCk6IGVuYWJsaW5nIHNzZCBvcHRp
bWl6YXRpb25zDQo+IC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiBCVFJG
UzogVHJhbnNhY3Rpb24gYWJvcnRlZCAoZXJyb3IgLTEyKQ0KPiBXQVJOSU5HOiBDUFU6IDAgUElE
OiAzNjA0IGF0IGZzL2J0cmZzL2lub2RlLmM6NDU0IGNvd19maWxlX3JhbmdlX2lubGluZSsweDg3
Yy8weDlhMCBmcy9idHJmcy9pbm9kZS5jOjQ1NA0KPiBNb2R1bGVzIGxpbmtlZCBpbjoNCj4gQ1BV
OiAwIFBJRDogMzYwNCBDb21tOiBzeXotZXhlY3V0b3IzNDUgTm90IHRhaW50ZWQgNi4xLjAtcmMy
LXN5emthbGxlci0wMDA2MS1nMzM3YTBhMGI2M2YxICMwDQo+IEhhcmR3YXJlIG5hbWU6IEdvb2ds
ZSBHb29nbGUgQ29tcHV0ZSBFbmdpbmUvR29vZ2xlIENvbXB1dGUgRW5naW5lLCBCSU9TIEdvb2ds
ZSAxMC8xMS8yMDIyDQo+IFJJUDogMDAxMDpjb3dfZmlsZV9yYW5nZV9pbmxpbmUrMHg4N2MvMHg5
YTAgZnMvYnRyZnMvaW5vZGUuYzo0NTQNCj4gQ29kZTogNDkgOGIgM2UgNDggYzcgYzYgNDAgZjgg
ZGEgOGEgODkgZGEgMzEgYzAgZTggZGQgOTcgYTYgMDYgZWIgMWEgZTggMzQgOWMgZmMgZmQgNDgg
YzcgYzcgNDAgZjcgZGEgOGEgODkgZGUgMzEgYzAgZTggODQgM2EgYzQgZmQgPDBmPiAwYiA0MSBi
NyAwMSA0YyA4YiA2NCAyNCAwOCA0YyA4YiAyYyAyNCA0NSAwZiBiNiBjNyA0YyA4YiA3YyAyNA0K
PiBSU1A6IDAwMTg6ZmZmZmM5MDAwM2Q4ZWQwMCBFRkxBR1M6IDAwMDEwMjQ2DQo+IFJBWDogYzkz
NWQ3YzdlZGJiNjMwMCBSQlg6IDAwMDAwMDAwZmZmZmZmZjQgUkNYOiBmZmZmODg4MDc3ZWJiYTgw
DQo+IFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwODAwMDAwMDAgUkRJOiAwMDAw
MDAwMDAwMDAwMDAwDQo+IFJCUDogZmZmZmM5MDAwM2Q4ZWUzMCBSMDg6IGZmZmZmZmZmODE2Yjhk
M2QgUjA5OiBmZmZmZWQxMDE3MzQ0ZjEzDQo+IFIxMDogZmZmZmVkMTAxNzM0NGYxMyBSMTE6IDFm
ZmZmMTEwMTczNDRmMTIgUjEyOiAxZmZmZjExMDBlNjY5YTVlDQo+IFIxMzogZmZmZjg4ODAxZDUy
NDAwMSBSMTQ6IGZmZmY4ODgwNzMzNGQyZjAgUjE1OiAwMDAwMDAwMGZmZmZmZmY0DQo+IEZTOiAg
MDAwMDU1NTU1NTg5MjMwMCgwMDAwKSBHUzpmZmZmODg4MGI5YTAwMDAwKDAwMDApIGtubEdTOjAw
MDAwMDAwMDAwMDAwMDANCj4gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAw
MDA4MDA1MDAzMw0KPiBDUjI6IDAwMDAwMDAwMjAwMDMxODAgQ1IzOiAwMDAwMDAwMDFkNDg0MDAw
IENSNDogMDAwMDAwMDAwMDM1MDZmMA0KPiBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAw
MDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAwMA0KPiBEUjM6IDAwMDAwMDAwMDAwMDAw
MDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMA0KPiBDYWxsIFRy
YWNlOg0KPiAgPFRBU0s+DQo+ICBjb3dfZmlsZV9yYW5nZSsweDM5MS8weGZhMCBmcy9idHJmcy9p
bm9kZS5jOjEyMTkNCj4gIGJ0cmZzX3J1bl9kZWxhbGxvY19yYW5nZSsweGVkNC8weDExYTAgZnMv
YnRyZnMvaW5vZGUuYzoyMjI5DQo+ICB3cml0ZXBhZ2VfZGVsYWxsb2MrMHgyNWUvMHg1NDAgZnMv
YnRyZnMvZXh0ZW50X2lvLmM6MTk2OA0KPiAgX19leHRlbnRfd3JpdGVwYWdlKzB4NWQ2LzB4MTRk
MCBmcy9idHJmcy9leHRlbnRfaW8uYzoyMjcyDQo+ICBleHRlbnRfd3JpdGVfY2FjaGVfcGFnZXMr
MHg5ZTcvMHgxMmQwIGZzL2J0cmZzL2V4dGVudF9pby5jOjMxODYNCj4gIGV4dGVudF93cml0ZXBh
Z2VzKzB4MjI4LzB4NTUwIGZzL2J0cmZzL2V4dGVudF9pby5jOjMzMDgNCj4gIGRvX3dyaXRlcGFn
ZXMrMHgzYzMvMHg2ODAgbW0vcGFnZS13cml0ZWJhY2suYzoyNDY5DQo+ICBmaWxlbWFwX2ZkYXRh
d3JpdGVfd2JjKzB4MTFlLzB4MTcwIG1tL2ZpbGVtYXAuYzozODgNCj4gIF9fZmlsZW1hcF9mZGF0
YXdyaXRlX3JhbmdlIG1tL2ZpbGVtYXAuYzo0MjEgW2lubGluZV0NCj4gIGZpbGVtYXBfZmRhdGF3
cml0ZV9yYW5nZSsweDE3NS8weDIwMCBtbS9maWxlbWFwLmM6NDM5DQo+ICBidHJmc19mZGF0YXdy
aXRlX3JhbmdlIGZzL2J0cmZzL2ZpbGUuYzo0MTQwIFtpbmxpbmVdDQo+ICBzdGFydF9vcmRlcmVk
X29wcyBmcy9idHJmcy9maWxlLmM6MjAyNiBbaW5saW5lXQ0KPiAgYnRyZnNfc3luY19maWxlKzB4
MzllLzB4MTE0MCBmcy9idHJmcy9maWxlLmM6MjEwMg0KPiAgZ2VuZXJpY193cml0ZV9zeW5jIGlu
Y2x1ZGUvbGludXgvZnMuaDoyODgzIFtpbmxpbmVdDQo+ICBidHJmc19kb193cml0ZV9pdGVyKzB4
YTZmLzB4MTM3MCBmcy9idHJmcy9maWxlLmM6MTk3NQ0KPiAgY2FsbF93cml0ZV9pdGVyIGluY2x1
ZGUvbGludXgvZnMuaDoyMTkxIFtpbmxpbmVdDQo+ICBuZXdfc3luY193cml0ZSBmcy9yZWFkX3dy
aXRlLmM6NDkxIFtpbmxpbmVdDQo+ICB2ZnNfd3JpdGUrMHg3ZGMvMHhjNTAgZnMvcmVhZF93cml0
ZS5jOjU4NA0KPiAga3N5c193cml0ZSsweDE3Ny8weDJhMCBmcy9yZWFkX3dyaXRlLmM6NjM3DQo+
ICBkb19zeXNjYWxsX3g2NCBhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzo1MCBbaW5saW5lXQ0KPiAg
ZG9fc3lzY2FsbF82NCsweDNkLzB4YjAgYXJjaC94ODYvZW50cnkvY29tbW9uLmM6ODANCj4gIGVu
dHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDYzLzB4Y2QNCj4gUklQOiAwMDMzOjB4N2Y0
NjEyYjA1Zjc5DQo+IENvZGU6IGZmIGZmIGMzIDY2IDJlIDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAw
IDBmIDFmIDQwIDAwIDQ4IDg5IGY4IDQ4IDg5IGY3IDQ4IDg5IGQ2IDQ4IDg5IGNhIDRkIDg5IGMy
IDRkIDg5IGM4IDRjIDhiIDRjIDI0IDA4IDBmIDA1IDw0OD4gM2QgMDEgZjAgZmYgZmYgNzMgMDEg
YzMgNDggYzcgYzEgYzAgZmYgZmYgZmYgZjcgZDggNjQgODkgMDEgNDgNCj4gUlNQOiAwMDJiOjAw
MDA3ZmZmNzY3NjkyMzggRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDAw
MQ0KPiBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAwMDAwMDAwMDAwMDAwMDAyIFJDWDogMDAw
MDdmNDYxMmIwNWY3OQ0KPiBSRFg6IDAwMDAwMDAwMDAwMDAwMDEgUlNJOiAwMDAwMDAwMDIwMDAz
MTgwIFJESTogMDAwMDAwMDAwMDAwMDAwNg0KPiBSQlA6IDAwMDA3ZmZmNzY3NjkyNjAgUjA4OiAw
MDAwMDAwMDAwMDAwMDAyIFIwOTogMDAwMDdmZmY3Njc2OTI3MA0KPiBSMTA6IDAwMDAwMDAwMDAw
MDAwMDAgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDAwMDAwMDAwMDAwNw0KPiBSMTM6
IDAwMDA3ZjQ2MTJiNGU2YjggUjE0OiAwMDAwN2ZmZjc2NzY5MjgwIFIxNTogMDAwMDAwMDAwMDAw
MDAwMA0KPiAgPC9UQVNLPg0KDQpOb3Qgc3VyZSBob3cgYXBwbGljYWJsZSB0aGlzIGlzLiBUaGUg
cmVwcm9kdWNlciBjb25maWd1cmVzIGZhaWxzbGFiIHRvDQpmYWlsIGV2ZXJ5IDE2dGggY2FsbCBh
bmQgdGhlbiBjb21wbGFpbnMgYWJvdXQgLUVOT01FTSDCr1xfKOODhClfL8KvDQoNCg==
