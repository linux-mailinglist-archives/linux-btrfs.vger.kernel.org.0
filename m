Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0808A769D1E
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 18:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjGaQtP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 12:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjGaQtN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 12:49:13 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12B5A6
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 09:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690822152; x=1722358152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=kft03QD0iywJgtO/Lx+nM7wVxIy87dQyZjP86b8jJxelz3DXrUxnBub0
   FFt1wOjYByM8vBbkYNL6uKRfoO2uj1ik9t8mf25IRUaz5zHe1BYgi+Rh1
   C0PrfsZGpRCrv+c5f0YTKz8vjBJjYnv81bQSkUczHnzT/CLxfYX/Ftj4F
   XE07N5ChPmLO8UZ9vwixe+eu5J4C9l6dDlT2TebZ+7wi+7oM61S3OmE9M
   +0tCW5XPpfkEd1LkB1cB2C8YlsgMS6XbIOUNxTYNsrvxv1Gp9zTdeqNfD
   M0r1okgHrcxZGj+oTTLR1h7vgdINvRB6s+hXZ8XYJXVA4hGZK6devriu1
   A==;
X-IronPort-AV: E=Sophos;i="6.01,245,1684771200"; 
   d="scan'208";a="344764168"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 00:49:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDAAAKmBpF6tDsIgwfTjGo8KNzldgNuhU0v2FGNqyQmkVohMcEyk/hfpI5i0hoDGKLIJwFrPwEdtwLyy2gbXMcbY9dAXeZ0eIWhTrCQmjgefe7jfY1gFy7aNi1Py2W3sjwC+b3VAf18VTbZK43upABZBurvbYHOL03r0QR2YWXR1eAk7TUquhITXdZvGhxtdeAWvp7eAF1W94La1++tA1Em9altwktzCEgNerC/PvN0FqVNFKc6QutF/k9948ZePocU+x1YVdieCmR0LlUjv8YG2mdQkjComX+scwZ/zZEH3jIdSoKTd2JEhrpnITFTGipzfCvCL0XPsMj4BNxPIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=QnftMH6e9AvD/dvvLcBNBiOCjb80DoxgEIKLTRkfhVdh6XAPz1/2k9uxJbeN9wx5Q4m+KBm+tewEjoA63cOjBK/imQNevHvGe+6WbHD8e5UHSWyag3epg1XNE6/++mMvxmzu2Lytb9maw5PROy8WX6LsHc6R9p0pREiLpiiF0Y7wLcAhyRBY23nGl6jaa4jQfYVm554rtNs8u4xrtNnO7ExdRS/oItV0FO0q61Be00CFOL88in2WFKK/aMFKY9kijZWjGR6diXSpSPcWylKoasCeH8F0FCDhPYbs+V3rXzU0VkBXw7wyn6Fo+jjQJUZBXrlfO8uFqUHxjQ2jBCNC5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=P15r28cmA96v+awAOpBjHJYiy8IVO09FySUqDqSrvBaa9BGWRpaHEaioSxSbWGmnIfXY2j0m0qy6aZMaXL9dEACu8ESu0zk3OOoAFsqGGqE7Y++BgOUQpnyjomy23Bn/Df6bpkKWSdlfgqKYmtPIMNBRxpDyu3dtuVaBpDoUSMs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7153.namprd04.prod.outlook.com (2603:10b6:303:67::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 16:49:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::732e:8355:706d:ba44]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::732e:8355:706d:ba44%3]) with mapi id 15.20.6631.041; Mon, 31 Jul 2023
 16:49:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH v2] btrfs: zoned: do not zone finish data relocation block
 group
Thread-Topic: [PATCH v2] btrfs: zoned: do not zone finish data relocation
 block group
Thread-Index: AQHZu6bw5qk2kTDQa0e0oD+fsiIp7a/UJooA
Date:   Mon, 31 Jul 2023 16:49:08 +0000
Message-ID: <acce8f27-5d79-a1d8-37a0-8cebb6f849e1@wdc.com>
References: <a57f943e28a5bd86cddcf9d0839b124880f2f6c7.1689924624.git.naohiro.aota@wdc.com>
In-Reply-To: <a57f943e28a5bd86cddcf9d0839b124880f2f6c7.1689924624.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7153:EE_
x-ms-office365-filtering-correlation-id: 3c5dc399-58be-4586-37a3-08db91e60f69
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K2FuBdnNtF4mG8aWh9i8YAjoK9yAxoc+xa9NAqscLgJuAJTMEVNpKNwNLVpPz9rFyixVBJLf52k/gSexCPYAKSOVWPT1f1Vf07FYZTWyrvh/RHEpB3Fc80OIFRrQqMHvkxnCln935QZRvM/lWT4D+s10qqo6IO06WCLV5nmhGrVHJp/C1QRj19QGnftxYeB/j1u1414FLTX6u47QKrA3WNw6nsoYPRo05qVdcqwkBrvWEYeiEQJOQAHSox9iHdB82NWVRWePSo3xPAbeJo80AGqZAt8v4HVPYOC3CqPbL9h54AxeoqHQtu+gxc6Vdv4JKFH33AACSKeA9dbhbk7KAooXlmLlax70FERS3umoKqqI/glgJZX0vQzPQxs2b8banodmnYaVTnWiezk2yH62roggyVEQah/zPnjLPbXjU+ENeXxG/OdLWb+5Cl8MpoVQsML/uEhHeBpbANvvbZUK1FSppNIlMV++EMgHvFie95Q52+VvY5kVNnAENF2HAZOurOjb7Z6BiJXLokosVOTIAL0kNraJsLqv2iMomKkGj9d4+9ocL4tkQNiT1pN9ut0D3VQ2rzNVhwE5YQhUMXVpH7ggyoljIPaP35YHGDh2auq34rag246c8UJ5u6/uUopSiu23KTnEsekNgSQLqxpH3zclpu+b/f3Gfnhkr/2UX7AOMI09CCuFcOZ/S6iT/YvZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199021)(6486002)(558084003)(38070700005)(6512007)(31696002)(86362001)(71200400001)(2616005)(36756003)(4270600006)(186003)(6506007)(26005)(38100700002)(122000001)(82960400001)(19618925003)(8676002)(4326008)(41300700001)(91956017)(8936002)(31686004)(76116006)(66946007)(5660300002)(64756008)(66556008)(66446008)(2906002)(66476007)(316002)(478600001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE4xTGk3eEJLT3BmdWFHVG9Kd2FDVlBteEM5RGx5cVhZb0IvbFVJS1E4Rlkr?=
 =?utf-8?B?UjB4Wjh0SVZWM3hTWDVYL2t6aWpuczB1NmJpdkgweDlTSWFxbE9oQVk2dlVZ?=
 =?utf-8?B?Mkh0UXd0aHVqaDIyYXh4UE9xSWZnbS9LRVlhUFd0Q1N3ZkZwbTdzaDJkT2xU?=
 =?utf-8?B?Y2o5ZTQvclNpQVlDYWgvMjQ4NXJuOC80TlFOaVlwOHh6OFlyZlE4RG56d0or?=
 =?utf-8?B?UkpCTHVRWldSc21nQnVGbEVFNlJvTWkxaFE4U1pYZWcybHFlZXk5amF1dkhZ?=
 =?utf-8?B?Y1hlUFY5MXJ5bTZuTmJtNk1USUh0RG43dkVRbEFuQy9Wa0dDMXA1enJma1JX?=
 =?utf-8?B?RjV3aThQK256cWZ4OWJnYUhrK2xJWjV5MG5hamFWTllnc0FLWUFMQmhKMk8y?=
 =?utf-8?B?TEN1ZGhiUmhSQkVDbHZwaTBLeGtJVGRZb1E1UUpOTUlpbjVOd09WeUFlcUNV?=
 =?utf-8?B?U1o5TTdhVm1oczNCbnh3ZFR6dEpIUmJEUnVwZHgzZkVIU2lZRGpvZjRRc3hW?=
 =?utf-8?B?NTNBbXNNQlAwSUtadTd0aThURktocFVIZFpOM09EaE1nWkNXSUsramdXWkVW?=
 =?utf-8?B?UGFydkhjTnVBaE9CK2JKYjV2cmhDUWJEM2h4T0d4RFBoRVluKzZINnhPaS9i?=
 =?utf-8?B?TXJhWGk0RFA1U1h0cUJaTHlsN1BRdEQwQmFKSWpNRnU0bTI5SHZHRDhLQ2cz?=
 =?utf-8?B?Tnc2T2R1ZUFydkdZZ3VBRUc4aC85MlF5TFVkeSs3VGxNWTJUelF1VFdMMVlu?=
 =?utf-8?B?bmtZWWpBaGJ5ZTBGL3RkaHJXKzh1RXJlem01UkpGVytXamF1NlpaM1J0MjZa?=
 =?utf-8?B?TUJSVy83Mlh5MmZlb3luYUNaZi9JQUhmZGMrY2ZHMS9HOFBSOEhuNkp4andW?=
 =?utf-8?B?RlJEeDUzMVFBVjN5OGJ0ZXVlYmhreWROVmhjRUlDVUxNYXF3RnhoRE5IclJr?=
 =?utf-8?B?Qyt6cFRlVGUyYXl6aUNCY080SXFFSDhXL3daUVNMYWt2RUF3NnIrcVRZN3lt?=
 =?utf-8?B?MEo1dEYrNkVHRVNIVmF4aU4xL1k3WGhSYnJHM3RmWVM5b1pOOTYxZ2lhVzFQ?=
 =?utf-8?B?UC9OOFV0SmowN05wK0xKVy8wNGRWY3RGclRJOUpJZmtCT0Flb2tzQWwxQXdQ?=
 =?utf-8?B?cSt2dlRpa1hOMUwvS1hBd2o4NXBNUnRyNTdVbmI4RmtWZEp6NW10RENYOUxL?=
 =?utf-8?B?TnNGb1U1anlZd2didkQ1ckt5QVpOU1dVRDliSTBSK2E2VllBNkFNT2hEUEd6?=
 =?utf-8?B?ZUxmamJ1dGNFQ3RNdFRFOTFNNHU0NUMyOGJhZ2tXZFR6VmZYQ3VzdUpvVno0?=
 =?utf-8?B?SEpXVjA2QXYwejZGM1l3RFB3SzhYNHBhaTl5WHdlVDFsdWZzb0kvTEJuSDJ6?=
 =?utf-8?B?NTllOU90YmltcVRQZzhCWEdCV2hvVDluK1VCdnpaQ3h0UjF5dDc5YTVHTHd4?=
 =?utf-8?B?MHd5UVNRTjUwM0NvTGZndkRqZmlUeUQyQWRSbVhDazNvZkVwVU5qSEtaODRi?=
 =?utf-8?B?ZW5hSDZXMG8vNWQ3T2M1THNnb1RQRm1kdW5LRHdFNHhDWmtuaUFtZzc2NStQ?=
 =?utf-8?B?d3I3a3FkTDZxaHl3WjJXSkJVTEVHSmZ6NXBLMnpHN2cvaWN2bHVPZURaVFNS?=
 =?utf-8?B?K2s5RnNLcjZWbGlaSitITG9jSkxUbS9NNTBMYzdGSHdoREl4Q3Jyck1QNndk?=
 =?utf-8?B?dE40bUJwQnZZaGovTHNPbHFqZ3RScklXRVhnUzArdUdQb2VRdU1ldDY0c3d2?=
 =?utf-8?B?OUxCZTc3YWl5aWpVSEdiaWFyMzJFaUswRXc0VjROZUdIcWxFaURTRU5FSDZ1?=
 =?utf-8?B?bG8rd2hKRXl5dU0rY1pIbVprVnc1N1h2ak9GbHZrSlF5akxreDhNTTdMR01K?=
 =?utf-8?B?VGhoN2xrTDdRd09oNk9NV2l1SWd5dXphSEd1VHNZOXhqZlV4NFZsNzE0V205?=
 =?utf-8?B?WmFDc05WWldPSXptalNmUFJHMUFkUHZHbFVGdnNia3kvakdvNENzREtrRkdS?=
 =?utf-8?B?cFVtK1lhbnRuV3FaaFQyd1RWRjdzeTljQXFRRG52Y05DZE5BNEIwUmhjek52?=
 =?utf-8?B?Tk9tL0p0NmtpL2c4Z3k3YUJ5S0NDbGd1VGxLWWFjUXFSNkp5YjFjZTBSVWJj?=
 =?utf-8?B?S0gwK0daaWN3ZEY0em5MZll1cXhwU1NZYk1OQnM4MXJ5OGdDeGI2aURldkVW?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2AB372D3E31BE4591D1D666E8C8D4EE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oUCp+7N6a89IUC20+KzmJ4V3RgQCc+IK20vjJCOWOuunC9hm4y19/6Y13FKDVtcWIMCFxoaxNvegVwPvec99dVez4A+tbhYuL1nR8HAUOHNg+elR2ZUAY41Yp5s8cTsvGWzQUigEu568r4TCR+froECSh3/q5HpqqHav2rJpwMlJPt01WIcG/XiqZlXQi0hXk/rLTfACuHc6zt4Zz0+cpN/RD8IUO9lQq438kLncQoQfYK2FhFKvDgCq/MHjYgbR3QXEB5o1IyhI6ms0hdenYwxKf6+Rk3iOM2emZ3JwdmYEP1D4Q0xSfIjT0aMOYxFFS0Rx1kKy/Pw5CY49zoMcc73T1feLgesL4N4Ug0GUZ+naQ+JhFROGFmB22ugSPhzQEmFtrFVndkF39Z1qSVKpFAg4osaUr7elE1LCz99ojZY93aE9qy+CHQQZo+dkU97qVB+vSQYXVq7ARyBDItogJus+ghH+dXj2g8O9FQjTYdaeysPchCyxKfETo4IATf2iL/6ZEOmHy5yMlc03Y7cKhqXyT0QK0i5gTWcbYh8VTGXY0hvLrnjY8I/4ErAZ300A99AqqiPHLDdX+3Ya5lm2twESApJQoTaVDIoOHEJ88uxY7A7JTUFW/gs7bW4A6hX5TAqzfk5haRmJtwJbm0lBIwEokXS0Qzq6SO0UJHJZ4KjYq96/sq/snmHMfj4913HB4+wlUD/9qVQRAV2NjEYkjfk+tdDSsIhPPh3QdE9C82yugXjqsNEty6L85m3TetX+yvDuWDf/zerIrZs07IuooOymk7T+rWxlLxYe3+EjNfM5dwPtkqMoe0UuIYs+sswc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5dc399-58be-4586-37a3-08db91e60f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 16:49:09.0058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fe6STEp9L4QDkJ/sZ0i5ZH6HvY7n2MHjQxCSeT0yYnS8T8kmsqKP+jy4ybXWGoi0opU8sSmZml8PDhPRtrLE47j9R57fPkviB8J32RioTIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7153
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
