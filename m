Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B406071D1
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 10:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJUINr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Oct 2022 04:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJUINp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Oct 2022 04:13:45 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B7824AAE5
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Oct 2022 01:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666340024; x=1697876024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tiI72q4oi6aZR9bRjZWOOGKwTHl+FodzS10PDb3kKDI=;
  b=E/NKdZJ/WeNrLrGYTZ2ML/hqvMQxqLCEtNuygiNbnVH9ROUDs+DHjSii
   xPgf8Tz2LLcCh5D2VHVgnU7ixqX0P1EVDoN8zygwcgusC92WlqRNyRK9r
   EuJ4iwJ+HHMouHuOFCeGSGOHUTptTjeH81pXWJg2b+xFrxPN6XrA/ukna
   kzTLHIPAohRRN7YeR86RjGpumrtCNMiYbIDYPWI2uMr74NSZs4usWHX5Z
   St5/A0vHDjLhq0OtD/Ds+1KhPFKLoA5Xnmb/PIgg3oRRnThLZVYYB0zpa
   5WQo0ui4NJYW+Dom5m4F8U4FlttpNfxdfkLJoi65omJertkzz8M7Un+b5
   A==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="326528837"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 16:13:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdTcYCgPbyCuhKtx9B3LE8rwsnK7m5WSmKWM+S4CRmi+O/CBmXgWcy3NcIcraLoin/rap/EoGSg5WzJKPgDNNmfMU5EWcipIcTz01bFYXHMCThcM5iGlTKBRdgOnXqakuERp2izZA5A5tINMXQghHk1w44UJG0OesdOELIJIBFvKWOA5TmFjxAlaOImuiSJqBAntN/y/XpCZsWl87JVJneBDMUGC63hseoXllHhC8zBfrRPJ6ChYKKX7UXhx7z22GqYzFzZxNVxIpQPsEDlA9GyLrOjPg1DaQPGka+dd2i7f/HuqifiDoQ/i18WJ7kbVuwd9L6IdAVFhfMZ9DjiHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiI72q4oi6aZR9bRjZWOOGKwTHl+FodzS10PDb3kKDI=;
 b=ZsJ7BOIUG/+pmkqaSZ1UM92fkAsvKjN7IKLOaHtsdn5JDcSLvusL+EIEsf2qR2VGcrKH43ivoY2g9BP6F2ISVXpvq73SOAjFsdOOAD3cERnkt7EZiz8Ep475SJQWjUSMOE6d6riNaH3AbMABjFwgAhJXHJDRnwwepBpP5QSFzU1NmcWOqBi3/+mmbK98DqGbwdMxZenBGlaKfQiH1kbymZmb3zZpxTxh5rBZUqQ1vwR2n3sLGO0yM0hKolTLmigpTv9CKnwUCH/eazpgTAACQ7YuGFM0uu+g2QzTjx9mdGXmBISN3NSW/rVKGIMo8Js6vG+KdFrkccnDLdaNPHUrIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiI72q4oi6aZR9bRjZWOOGKwTHl+FodzS10PDb3kKDI=;
 b=bgZiob3B9PB4C20aV/ZGl2L+akoEWi81lBPRvPZLVsBjIogQ/xQ0+rk2GqR3QPPszwSJIFuHpTeV1ilxLQRFt0H44KER9oOuWM6StcPF5dv4CFYMYOsUlQ6Sw8v3oI/GH8WjWhZOgcqWkn48BdT5oo1Z0yybuyJnFf962xJbvI8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR0401MB3685.namprd04.prod.outlook.com (2603:10b6:4:78::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 08:13:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 08:13:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC v3 03/11] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [RFC v3 03/11] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHY4h9gWnRLrGBDPESyeY0MCi10lq4XbWaAgAEYaoA=
Date:   Fri, 21 Oct 2022 08:13:41 +0000
Message-ID: <5a334a79-b557-b9eb-357a-f17887a16ed0@wdc.com>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
 <5c8b4c3005d7c02ca4ab76a1802f14137ae47bda.1666007330.git.johannes.thumshirn@wdc.com>
 <Y1Fpe1ATGwW0o5J3@localhost.localdomain>
In-Reply-To: <Y1Fpe1ATGwW0o5J3@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM5PR0401MB3685:EE_
x-ms-office365-filtering-correlation-id: b3b89a5d-e8a1-4102-bcfa-08dab33c2a7b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lV+kb4VbYDRnG59fwUdzI0h5N9PEu5hWPP/6nSuICVfUYNw5CsqE44nesrnrblTNSmc3/DQX+GJSWWANUOU3BMahbxGKDMZ3ih8f35iEKTygPHoeeZKCpVdsJkmPyU0Hr4pntnB5yE0o07YNZ5jmnpll3+9VWWf2fIbfx6XRehuoBVcBDrQKEgqILaulpJ82Pc+yScdAOgbp09obLTpULMMzBKwJeuaKQpgT06i1BgGkXMMJ4nUUwoQSEkpJHRJYgMsBLSwCavFAnYd3HkUo4kERvNTElAHgrJ8qvPnrBg6TwKDmm3fVuqNH3AybFoY8ggPG2BQzHiHXZawfgBJ2xj5QR99pNXsTrC9q3u6RzpN8zNcKN4KA3IzAfuvja3U8jv4XUbIlfBDREtI5NlxMPTV6pB1i2XXMyCuxqYmZ07OxJs4VXs3ZD6hsLiOiHytIYHmGqKAb1lOaGXlfNkMKFNvtNekMQ225wY75UyZlCdGQEI1ISXaVso+HBimcv+VXsDHRaKFt71TZ9SrJXoU7LN0VDlQTSmaoFIQjcEArNpTaHQ5iwaVoSyTMt55DEI6Xn3ilEg9rum3CSssyrf4IBNSHV+tLMHwTTQIueNJur2KN2T4oEIPyVTekSk+kWdCoOsJVuyLXvb36KbVLLbS+TWKENyXvLHOftMcqSv5JcmflCtYzxs9TYxCVgu1mR79c2J9Jjb6rrv2z8vRR8Y3l9tJnSLucdVSryMGhDzSwuc1zeXpkcr0FRn5iIMDT2vUg+IMPj6oev/9E46/PZyzhYvDbqXpPNx+hefg8+TYdzmTeGJEDdXGcbWVfvpIIGtb9QQj4IqOx+u3iwq34hfngFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199015)(5660300002)(31686004)(38070700005)(2906002)(36756003)(4326008)(66476007)(64756008)(6506007)(8936002)(316002)(38100700002)(8676002)(41300700001)(66946007)(91956017)(83380400001)(6916009)(122000001)(53546011)(31696002)(66446008)(82960400001)(76116006)(66556008)(6512007)(186003)(86362001)(2616005)(478600001)(71200400001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnpEWmlsOHhFdnJtUGlLeHp5YkxQayt3eW5sa3JPbkV5eEFUSkVBTjAwRlF1?=
 =?utf-8?B?RlJUdmlMRExkZ01XNXNyT0dXSEZ6cDY3Sm5ZekQvVHBzZGl5Nm1IQ0ZKSFVl?=
 =?utf-8?B?cHVJajVvdXpTUStxekRmeTJsUFdQTmxmclhpZmtPZzVqUzFmU3RCdW9YbkR4?=
 =?utf-8?B?L3ZyclByV3FyY0ZvemJGN0FmT3FjVGhyTzJpWFlLdDIybGdabm8ydWZDampY?=
 =?utf-8?B?T2ZYRzdEZVVUaDgrOG56UVFFYlZJNGdJRVhpMVFFVnp0T09kdmdCa1FvckZp?=
 =?utf-8?B?VTNzakVDTXF6MWxpS0xhM3R4YmYwT2ljRFMwOUY5UkQyYWRnR2VRRjB6Q0U0?=
 =?utf-8?B?UnMwS21tMWpPQVNQZlZTTXBwR2lycGpOUVFkb3R5UkYrQ3BjSGMvWDBYQ1pj?=
 =?utf-8?B?ZGVDYzFGWXFFM05HbmlvT0RPNEYyU0V2NWlBR3FkVGMydzZ3a0VWN3duREtk?=
 =?utf-8?B?QzZRVkNseDEwZVJiNkZhU2FpNGUvNVFkT2ZtMktIQXNQbVdOekdtTDFGWHBi?=
 =?utf-8?B?S3FCSGViOFJLdWliSFBGL1QrelFaZzJDUHVmMENLdFVoWE9qaXVoakF2VnI1?=
 =?utf-8?B?cXJzbHU2N1dncXZ5MHNvMWVMb2NDNkFaYXJDbzRmbElheDlnT2tTQmx2TXRW?=
 =?utf-8?B?Y1Y0UVVuYzRKWmhHdEt1Ykx5NW1SdjNFWVplUkJTcUJOWHFVVmlpZU1uL1dQ?=
 =?utf-8?B?RlZEckJ3M3NHRlJyU1FPWVFkMkFob1Q1OUJGU0pVV3Z2ZjdTM3FIMFBvS1Rr?=
 =?utf-8?B?RU9TOFhDZE9DWnAyZUhGUHJ6ZitEcFBxeENPcW1jdkVUV25ZR1VndDgxZStF?=
 =?utf-8?B?YURLN3d2TmVpc3o5NmlWbzdEWXFKb3NDZk9SVkxCSWlEOHVzLzhFbFc0ZnVB?=
 =?utf-8?B?NEJMM0xucmhWSlRWSnhTZjltUCtEZ0ljYS9JOFhwR3pFU2YybXFocEpqSTBX?=
 =?utf-8?B?aFdpN1IxYzJVZFY1NnY1TlRCdENkYlFjRUFKVnNPSzhtSXdjMjEwQlZ1cHZu?=
 =?utf-8?B?bjEyaXFSWmhROW5iMGNrOUF1Ym1lYytxSHVNM2xERzdRbmJTcmh6U0pUR1lI?=
 =?utf-8?B?T3RIdE55WE1LZTNYRVlvaldrL3NQaW9rT3NLYW5nTUJLaUoyNXF0dEtudyt2?=
 =?utf-8?B?LzJkZ1hCWFZ4R1VxK3d1dlJoZlZCQ3RIbkErUUR6N2N6NzFZM1Y2cnNpbEt6?=
 =?utf-8?B?SW90aUNvdFB0cVRYcFplVHNYS1VjdHhxTzFvVWllaW9kcG9NZk5KRU9JY3Rj?=
 =?utf-8?B?R2JjeFBONmhSNVBpY0s3TU4yMXk5bkprTXZlVmZ6cDJnNVFrMktIUmlxREta?=
 =?utf-8?B?RWVwSjZRQk9DZk9wditlR3ZBRC91TUtvaHRsQk9pL0dWZmdyRWFnSnlVanVN?=
 =?utf-8?B?SkRSQkxZNkI1RkFHSGZ4SXMyakJpSTFPdVhzKzRHOHNFSDBFenhqRzl1S29E?=
 =?utf-8?B?dk5uMksvOXJEL0REOGtEaFRNQ0JsUnNFYXdMM2ptU1l1VWFTRDhmNGtZOEla?=
 =?utf-8?B?K2JsUFg5SGszOVFUWXo3RkI3RGw4S2ZoOVZSRFl5SnY1bUVaK0tXT29PT3FO?=
 =?utf-8?B?MmlLL3VZaFpPWEsraVltUFZCUkVyS3FySjRML1E4aGRVcytPTWQrMFB0YnZ5?=
 =?utf-8?B?M0p6UmpSM01iamN5aHdSTFpPZXdJOVZOdncrU055eUd4M1lMeUo3eU1PaDF0?=
 =?utf-8?B?MTZ1dERWbmNQTUFlTTdybUtIN1lNdCtXR05BZDFEVVpwVzdibVpqQ05WaVVM?=
 =?utf-8?B?ZC9JaDMwYlBDNjBUVEJVdjhRZUF3T201aEhDb0dkWHM0Z0tWQUhFMW54ZjU3?=
 =?utf-8?B?VmFZOG5IbTdQaVlqT3BPK2JvaEt6M1JyVW45Q0MwdG9LMkRlV3dGVG4xZXJo?=
 =?utf-8?B?dnZGajRmTnh0UXpNQmp6OC9kTFk1dXcxbG0reCtiNjYrdS8wbjVUR3RhakVl?=
 =?utf-8?B?R0JMZmZ4S1V4Q0N3WVhzdkRaVFdlSGFyNW0xaG1ZTEdKNDFTZnF2WGM0VEg3?=
 =?utf-8?B?bDd0N3FMTnVVUDJKNytqU3gxWUNXMDNiZmE1U3M5cU5UVFNGa2lFU3JTb3dN?=
 =?utf-8?B?QUxvL3duT0pXYTFWMHZtanFQRHdvV1QzbHZBODVWVSs1VTEzTnEwdVd1dHlQ?=
 =?utf-8?B?SHZUYVYyUXl0UW5xS0IwS01OVDJKc3Y5aHBVVDh6TzJSckdwSi9OaTlYcFkv?=
 =?utf-8?B?MWV2cE5UUDFWRlNyaVhMZHlMZVh5aGxQRnE0cFNmbW9zZVZwOUpPNk4vUTd3?=
 =?utf-8?Q?4Ahd3ZDgQ1J/P4qTL3rgSeZutNTyqQIlPM4PNNJCOY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C5E9E7EE408944187C17498658B3B56@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b89a5d-e8a1-4102-bcfa-08dab33c2a7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 08:13:41.8196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kA7OXFYKurKomuKuUgdmncE8Ic9HModIxTtJDII7RS+5rnhnIvJnKZk94MZ+qBm+5DEBwK5nQgnIYyiO0Nv3qdXaLYDPbaXrZzge9G4SUiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3685
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjAuMTAuMjIgMTc6MzAsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPj4gIGJ0cmZzLSQoQ09ORklH
X0JUUkZTX0ZTX1BPU0lYX0FDTCkgKz0gYWNsLm8NCj4+ICBidHJmcy0kKENPTkZJR19CVFJGU19G
U19DSEVDS19JTlRFR1JJVFkpICs9IGNoZWNrLWludGVncml0eS5vDQo+PiBkaWZmIC0tZ2l0IGEv
ZnMvYnRyZnMvY3RyZWUuaCBiL2ZzL2J0cmZzL2N0cmVlLmgNCj4+IGluZGV4IDQzMGYyMjQ3NDNh
OS4uMWY3NWFiODcwMmJiIDEwMDY0NA0KPj4gLS0tIGEvZnMvYnRyZnMvY3RyZWUuaA0KPj4gKysr
IGIvZnMvYnRyZnMvY3RyZWUuaA0KPj4gQEAgLTExMDIsNiArMTEwMiw5IEBAIHN0cnVjdCBidHJm
c19mc19pbmZvIHsNCj4+ICAJc3RydWN0IGxvY2tkZXBfbWFwIGJ0cmZzX3RyYW5zX3BlbmRpbmdf
b3JkZXJlZF9tYXA7DQo+PiAgCXN0cnVjdCBsb2NrZGVwX21hcCBidHJmc19vcmRlcmVkX2V4dGVu
dF9tYXA7DQo+PiAgDQo+PiArCXN0cnVjdCBtdXRleCBzdHJpcGVfdXBkYXRlX2xvY2s7DQo+IA0K
PiBUaGUgbXV0ZXggc2VlbXMgYSBiaXQgaGVhdnkgaGFuZGVkIGhlcmUsIGJ1dCBJIGRvbid0IGhh
dmUgYSBnb29kIG1lbnRhbCBtb2RlbA0KPiBmb3IgdGhlIG1peCBvZiBhZGRzL2xvb2t1cHMgdGhl
cmUgYXJlLiAgSSB0aGluayBhdCB0aGUgdmVyeSBsZWFzdCBhIHNwaW4gbG9jayBpcw0KPiBtb3Jl
IGFwcHJvcHJpYXRlLCBhbmQgbWF5YmUgYW4gcndsb2NrIGRlcGVuZGluZyBvbiBob3cgb2Z0ZW4g
d2UncmUgZG9pbmcgYQ0KPiBhZGQvcmVtb3ZlIHZzIGxvb2t1cHMuDQoNCnNwaW5fbG9jaygpcyBk
b24ndCBhbGxvdyB1cyBzbGVlcGluZyBmb3IgaS5lLiBtZW1vcnkgYWxsb2NhdGlvbnMsIHNvIEkg
b3B0ZWQgDQphZ2FpbnN0IHRoZW0uIFdoYXQgY291bGQgd29yayB0aG91Z2ggYXJlIHJ3X3NlbWFw
aG9yZXMsIGRvbid0IGtub3cgaG93IGhlYXZ5DQp0aGUgYXJlIGluIGNvbXBhcmlzc29uIHRvIGEg
bXV0ZXggdGhvdWdoLg0KDQo+IDxzbmlwPg0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgb3JkZXJlZF9z
dHJpcGVfY21wKGNvbnN0IHZvaWQgKmtleSwgY29uc3Qgc3RydWN0IHJiX25vZGUgKm5vZGUpDQo+
PiArew0KPj4gKwlzdHJ1Y3QgYnRyZnNfb3JkZXJlZF9zdHJpcGUgKnN0cmlwZSA9DQo+PiArCQly
Yl9lbnRyeShub2RlLCBzdHJ1Y3QgYnRyZnNfb3JkZXJlZF9zdHJpcGUsIHJiX25vZGUpOw0KPj4g
Kwljb25zdCB1NjQgKmxvZ2ljYWwgPSBrZXk7DQo+PiArDQo+PiArCWlmICgqbG9naWNhbCA8IHN0
cmlwZS0+bG9naWNhbCkNCj4+ICsJCXJldHVybiAtMTsNCj4+ICsJaWYgKCpsb2dpY2FsID49IHN0
cmlwZS0+bG9naWNhbCArIHN0cmlwZS0+bnVtX2J5dGVzKQ0KPj4gKwkJcmV0dXJuIDE7DQo+PiAr
CXJldHVybiAwOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgaW50IG9yZGVyZWRfc3RyaXBlX2xl
c3Moc3RydWN0IHJiX25vZGUgKnJiYSwgY29uc3Qgc3RydWN0IHJiX25vZGUgKnJiYikNCj4+ICt7
DQo+PiArCXN0cnVjdCBidHJmc19vcmRlcmVkX3N0cmlwZSAqc3RyaXBlID0NCj4+ICsJCXJiX2Vu
dHJ5KHJiYSwgc3RydWN0IGJ0cmZzX29yZGVyZWRfc3RyaXBlLCByYl9ub2RlKTsNCj4+ICsJcmV0
dXJuIG9yZGVyZWRfc3RyaXBlX2NtcCgmc3RyaXBlLT5sb2dpY2FsLCByYmIpOw0KPj4gK30NCj4g
DQo+IEFoaGggeWF5IHdlJ3JlIGZpbmFsbHkgbm90IGFkZGluZyBuZXcgcmIgdHJlZSBpbnNlcnQv
bG9va3VwIGZ1bmN0aW9ucyB0aGF0IGFyZQ0KPiA5OSUgdGhlIHNhbWUuDQoNClllYWgsIEkgaGFk
IGl0IG9wZW4tY29kZWQgYnV0IHRoZW4gZGlzY292ZXJlZCByYl9hZGQoKSBhbmQgZnJpZW5kcy4g
DQpTd2l0Y2hpbmcgdG8gdGhlbSBhbHNvIGZpeGVkIGEgYnVnIGZvciBtZSA6KQ0KDQo=
