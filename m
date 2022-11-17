Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060E862D426
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Nov 2022 08:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbiKQHdI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Nov 2022 02:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbiKQHdG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Nov 2022 02:33:06 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3830D65856
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 23:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668670386; x=1700206386;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=TsHXKXgHxEv1xz5EJHsPZABQkdVZQP6tRz3wGdGH3Fw=;
  b=Qj7yiDz8VIBOWWA/RecbfBsPfgSx/ByCDhsGmBxRctv73jBm5H1h8dFQ
   u2XhIgfFTjs1X2HkoJYzcImhNNfKjj/hZSN9/JXlQ306hH9beK5+Agqd6
   CT4PFsV1CqacX6GbkPWFL9Di2OtLCHty+mvQwuCiXpdWBBXzrkG07C8ud
   a8Qe4m9bq4GWL2uyuM/G99o523v1cNNX1pcgns78JI0Y0TyW39PSILtpu
   fpm1jxoUYPuopQmPgPgAG+P9oXsaeJw429yuACqd19aPUwDQhaZiRMEez
   CrJVI+cQwzK8CM7fysJ3OtXpULCvCsm3n2ALrpVSn4DEgiOUKhbp/1rvS
   w==;
X-IronPort-AV: E=Sophos;i="5.96,171,1665417600"; 
   d="scan'208";a="216495052"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2022 15:33:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n64U2Akr5Dozbob8N09XQI8v+u1uZ5yoo7PrPceuazarvmSVtBUdB7NBSEMHiadinLCyyFC1Bk/pRWyUsoF9R8RyVSnGqgdhXgEmQAdl09jpd/WfB6Ut2Smp1GRiaeIBynlSn89j0/3z2M23WggVdF3KlMR6DNaFKLx5lP5t0CBNlo1+zigjo3DJFYI5xvOaxVKQJQkNYci2Ng/7n5CRcmxo4ZIDIPgQCScynSh2+6lrVp/hrXllpOn7wpqjCC1yLa+H/IGxXJlJQN2XhUMc+4gwqDPsCnJT4M7YL2UJF8kgtCuFhu8i6eUVEoxqFEIwLW/HMQ1YRhGzjKWKSdK/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsHXKXgHxEv1xz5EJHsPZABQkdVZQP6tRz3wGdGH3Fw=;
 b=ZtZQwmuAXhq+UpywdILdeyvpE7npIQpfVDAPvPplc1RkObvCk71jWPB5jYdz7y35k/7OFIsj1GR3dqSB+K8qybYDi42XTyFKnC0QEYt5onvCNE4Z/BZQLZv2sHbjrmlVyrYRCD3bFlOyWNZVvC2Nzp85w30QX6rzVVBXQbrvMurD7nbBCkHRd0t9Wvgl7pR491SN4+2E/H5nHC/pvfdaAbPBx9CR/i10xMK8oVqdJtyNm5AFo5sXU8U+jmSGo9BUtXjVxrsbUs45xa9vZ7fzhDH/bc9TXMQZ8ezmHm5l1JyLZKlIamurhdhtCyYOhJEN3IwQwkHHLwnteE3UCgLEgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsHXKXgHxEv1xz5EJHsPZABQkdVZQP6tRz3wGdGH3Fw=;
 b=AAkVwX4Bn7ee5yoB/ioOWcEWbisanc20MCC6NYvuKm31nXa7Jv4Tyc1RBwDclzhyVixKSKEu5SdToZVqJcXVnkmGu0EUFdgRFhTesdoYp+JrjR50euYluNKRyZCsFMtnsviKZ33cL6v2TYh/xjrFZnNxD7x6aLTYn/Sjr+5BieY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB3889.namprd04.prod.outlook.com (2603:10b6:406:bd::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 07:33:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a%7]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 07:33:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Boris Burkov <boris@bur.io>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 1/4] btrfs: use ffe_ctl in btrfs allocator tracepoints
Thread-Topic: [PATCH v2 1/4] btrfs: use ffe_ctl in btrfs allocator tracepoints
Thread-Index: AQHY+fC+ayX86cQqLEaTC0oRk2kuVK5CucOA
Date:   Thu, 17 Nov 2022 07:33:01 +0000
Message-ID: <4f48f8b8-879c-3b18-b402-1bcedd9e2daf@wdc.com>
References: <cover.1668626092.git.boris@bur.io>
 <ef44014bc0c5599a0cc7034d9912a4151e3c8e3b.1668626092.git.boris@bur.io>
In-Reply-To: <ef44014bc0c5599a0cc7034d9912a4151e3c8e3b.1668626092.git.boris@bur.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN7PR04MB3889:EE_
x-ms-office365-filtering-correlation-id: 82a3b874-50c1-4ff0-b2c2-08dac86df518
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rL8u8jPr38AqrykCUgCz6Z3nrTdN1Sf1AWthtpssaWavKAkwB9Eu/2bO4U53zaa2ZW8dy5yzQyJagt6fICi8qtlOlUNWsIeShQG60Y193tAZ7Wol01rDdDf/Tz4cOaPKW9YV04nBkv9HwoFITqmXA5VYVeQ0N4wAuKWmaoLjwboAjqMIBpeLss5uVx5TQb8FkqGwoUezbz98knNlR8xV28G+OUbKEO+2Hk2A8aRk2VCNxgI/Cqve5yAgkd4qD/wBBjZm3xe+KR7yB9qNIkhD7FKEMIG+kbX13kWQyXfw+e96Ute7HiXHePzLy/ScedqRjKRTelKTmht0ycNMZP4wy8cij/ChS+wVw3J7/2NR6kwC+Fx4V3565P7x30qbnHGwRXfVR7QxIWmLWgx6OMfNLMSkOaLrtJWQRJQQSeX7KEIqLCG2kSm4V4xSblssKR43hxnkfvjto6MfMdvphb6T0JTi3ya60Q6wbN/00pJ4Wsz6GfH23US5jFk6x/k9CznLNPjoNSo8wxoHjtd6ONjojY13JDYXZm9zjQcBawzIyS91cWI6ViVf/v/FaMAt9VKyKdiiYYlNM3CHQXZuQ1GiVAFZoX+9qWMtPzYsK2xZCg8b7NJvC4fhgBpk1/pvJA7/Bqocli51OywKQcIdeZUrmrLPZZoCDnqL55XwSfG5t6TZZmDt1Hl8DmCnDtKCz5O2fSeNvUKU4EgflCkL22sBhZ7+sQ8qoAAft69kGajvvIHKbwgxWxtavJokdhlg3azWuIzo7TSqjrpkyPxdJfkuFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(91956017)(76116006)(64756008)(66946007)(5660300002)(8676002)(66476007)(66446008)(66556008)(4744005)(8936002)(36756003)(41300700001)(2616005)(186003)(316002)(6512007)(26005)(122000001)(86362001)(38100700002)(2906002)(83380400001)(82960400001)(31696002)(71200400001)(478600001)(38070700005)(31686004)(6486002)(6506007)(110136005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3lYaTBrRGtPV3NMWjhyUHdyTXFic2FTKzY3bnhIUERubEszSHcxL1BKNDhT?=
 =?utf-8?B?Yk1jTDVINEZ1UENobkpDREMrSTVaem12R1pIYXplWnVzVGJKK3V3MEN2MUxN?=
 =?utf-8?B?bE1xSldNNWhBQk9xWEd4MG1wdGpkU2FvakFQdEtOVVB1Z2dZWHhubkN4MTNO?=
 =?utf-8?B?YnV6Q3dMTm0yV0JEUXg2cEx1Q3BWaDBINzEvQmpTNUNQZWNTWW5kbFh6SElI?=
 =?utf-8?B?b0xuL3RqNC91K1NQZ1ZIcE1KUEhSKzJGblVmQ1JkUmZ0N1ErZjR6dTBuemEy?=
 =?utf-8?B?Z0hpZHdUVHdwaW1LeGtZckhRc1FCZmw3ODVXYzExQm9sTmZrUHJrUW9FZm52?=
 =?utf-8?B?b05VblQ2K08yRmZMNE04SE5nMnNYSTQ3TTJZYnhDamRLSG5SVDhCUVB4ZXNh?=
 =?utf-8?B?b3ZFUzdVR3ZWZzl3L3F6WHlIMlNXc0VFR0RadS9JWWxQT29kK1ZhVGlMS0Nr?=
 =?utf-8?B?SEJ5WWxzZSs2b04vZ2dVZXBIVWtlS2pUa2d3SjYyWVB1OFE2RHlTeEpHbUlH?=
 =?utf-8?B?ek1EWmNUWmkyNlRPN0pCN0dvY0MwVG0zcDhXVmdDVHhwUWVnTUUwRW96Ky9j?=
 =?utf-8?B?b1JoWXpFTWxIQzhvUlRMaG9jM2NabEZlaXZnSUZuOTZVZnZHNFZSU0NLck03?=
 =?utf-8?B?OVVsMFhTV3RPWDRxdmV1RFlnK0VVYUxmU0VOMlhsdWJuYS9wU0pZTG95VkFz?=
 =?utf-8?B?T3pJWnV2MmZLcG5nUzZqODUxaFJlb2tDOE1UQkpML0crVXB2bHNYWU8yVlFt?=
 =?utf-8?B?U2dFNUcwcFJ4OG9MbXhNTXQ4am9qS1gzMGNlRGtTL05yYWxCbGRBS29BNWE0?=
 =?utf-8?B?OFZuNjl5YVVUNmd5Wmlhem5hNzcxQXlQTTdkNkpYMUgvbmpiNHY3ZUJPVHU5?=
 =?utf-8?B?TnBONGhtVTVOZkVLYlpOZ0VYMmZNY2YrU1U3S1FSQlN1bFFEZS9xemFXOEkv?=
 =?utf-8?B?V0prR2ZwM1VVMkpoTWFUNHdMRnh6Zi9xQmt0T213b3RHc0UxOXBSVDV0YjdO?=
 =?utf-8?B?SWpIZVJMTlRybFZXTi9YMlNNS3BDWkh6ZnkxSm9xTmEyVjZHSE5xTG1Fbk55?=
 =?utf-8?B?WWpMbFNqMnA2QTg0R3JyeFlDdWpyVHYvWHF4bmI3eXcvWHdFRDJCdXFRUmRj?=
 =?utf-8?B?YzhCclpSSGJ5ZU1jV3JCU1F6V1FhNzdFQ0ZwVFpRbWdack1EYmM5QUNFTHRZ?=
 =?utf-8?B?Q2pLVDd5M1JYQkttcWo5ZHRBK05ZOXhYTGppc0xNMnRZdEdjN2M3TGlHUURI?=
 =?utf-8?B?Y3BRSVJXTnJrOWsvWTM0a2J4U09lWXBsRlF4OEFzRDNqOGNXMlBOdHdzRFpi?=
 =?utf-8?B?aDhmL0tFbDI4cWN3VDBtMEswTFYzVXJpZFFyS3EzMWx2S2FZZjE3d3FGTXNI?=
 =?utf-8?B?K3dyb0xIWVZJUW5teFNDazNvUXFaY3lxbHJpUUR1aXdzc0lLZVZFYldFOEd6?=
 =?utf-8?B?SitUZ21ZSnZKcEpGbGl3WEpsSmk3QWRJcXJLczJaaThHWUJibXY0U080MFoz?=
 =?utf-8?B?L1NSbnBPUmtUdm90dHpVbmhQZG5XakNGaXNlTk9LaGpwckp0cm9sb2tHdU0w?=
 =?utf-8?B?a0dXWEsrUUtJVm1XYUdQRkQ3TzVPZGJoR2ZBMTMzRHo4OUlZZUhjUTY2QUZU?=
 =?utf-8?B?aTZEcDErVVlJdksxQmJtVXNxMUFBTkxoVDdDY005MFprOEp2WmJTRHZYR1Yr?=
 =?utf-8?B?N3d1dElpcjRPelpGWm9xNk9Hb0VhczhrUGxXb1kyN2NBUHZLMXYyMEc2TVMz?=
 =?utf-8?B?eWppZXlLV3FvbElscUE3Q2ovS2N6K0g2Znc4T1NhczJoSm9vbkZNbS80WWVt?=
 =?utf-8?B?bW5TV1oyMWRGSDhWaW5jU3R6dm5LdDVUQkx4d3dpNlg4bFJXZnZteFdWWHJ5?=
 =?utf-8?B?M0RNYUJnR2QzUnpyVnBjMXpEckRiRGJ2d3VYVXl3eGhybHROTlUxQk5sdDd0?=
 =?utf-8?B?WWlwR2dzQ3dCak1SSEl1Y0Z4NXJWNlJWL1dWd01sRk5WZEZyeFRuc3Vpa3ly?=
 =?utf-8?B?b0Z5Tk9KeHpqcG1hMGpoRG5Cd2ZEbTZwaXVWTU9NNUdBS1BWQzFvT0hmU0RE?=
 =?utf-8?B?RjB3UkZiTzNoZlZXVFE0cVdSL2RJNlNFclJjMklmcmxTczc1SDdkVzJPZk5v?=
 =?utf-8?B?NlhkMGdFcG9yUWxMY0RGa3UxZHJTK1V0SG5UU3FVQTBhdHA4dy9iQlViV0hY?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEFE1EE1AD4038459AEA95203476E99F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: szgX23+1UlRskEXRops6gN99sGGic/fgb1PQafWJmZYmTFVyc0LCFUzqjXBN4swAUWKLjmVW9SDyEaue2XKk1oNi70DcpeLND99mbHGY7tvbtTkUbbiruzxPGBNyajrityWyiG+d/s8UZbiHCIIJk70LTE/rg0IEooHQ4jVi3U1UXj8HB/zVeSDBsTUQZzo90WCmJoboBYFM1KF4P/qyCGpo+YIcaHcH3q9NKXHyw0WpaCKtsjTjeUbg1WWrTJoLUegtCtiHM5XUGXZLeXERJu0vJiY9t+cRI/VDIFGb3R26V6O3x7GpBzHJAd2hGpRp0R2T0tZrujjsBy1iMvFS9zYt2lls1z8NP5hyCcooQGwHzL/ViVKhTHBlSJuVYxy+QTVRwlg75paKSuml46F7wign2F5To83lZrZrLnJAow7nHgFqxSUiv64rMhvgl4RBZXiFZG7seUprSSjo/mZaFq01ah2wWRTC3q9NWinEpc4BDBEn/+gJJCMNHE2CdsiNvXkdMrybCcK0hgf+wF+eRzDzDP8b29r0K+/kW8qOBeXzn1GsEZcMBljFC6UIApWZrzmwg/6peE9bBKjnfjYQPO7wgKnwNdb94Vkeo3ItMzSoPGKhw+1YgcZd0yPCYV659qL9AcOWPHi11l9Qef0xe1c6inxas03UVio4eSwBSRZlt1GO2L2lb0DUrc0krfRpl5AU1aIM2hHD8y7BlB3xhQSSVzcFQnBRSQSvGxPJi/+Zj+RwdJlBeyahn7rX4uKFmLnZ9t8bfcNTzkO5r8TEnFxkqT2rAiUbLS2Xvmf3LhErYaBI9ERoj5I4bFlwoBqq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a3b874-50c1-4ff0-b2c2-08dac86df518
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 07:33:01.5216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKnxhNXIDJZ4GqLRlH7yP/9c5jWuAiE7p1wHLEHimQnKO89Mx5QZ7aZHRNGmo4mx+uGC0yM5ci4iEVRBHX33NlU7k37NA8ptLtdVEQHAoCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3889
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTYuMTEuMjIgMjA6MjIsIEJvcmlzIEJ1cmtvdiB3cm90ZToNCj4gKw0KPiArCS8qIFRvdGFs
IGZyZWUgc3BhY2UgZnJvbSBmcmVlIHNwYWNlIGNhY2hlLCBub3QgYWx3YXlzIGNvbnRpZ3VvdXMg
Ki8NCj4gKwl1NjQgdG90YWxfZnJlZV9zcGFjZTsNCj4gKw0KPiArCS8qIEZvdW5kIHJlc3VsdCAq
Lw0KPiArCXU2NCBmb3VuZF9vZmZzZXQ7DQo+ICsNCj4gKwkvKiBIaW50IHdoZXJlIHRvIHN0YXJ0
IGxvb2tpbmcgZm9yIGFuIGVtcHR5IHNwYWNlICovDQo+ICsJdTY0IGhpbnRfYnl0ZTsNCj4gKw0K
PiArCS8qIEFsbG9jYXRpb24gcG9saWN5ICovDQo+ICsJZW51bSBidHJmc19leHRlbnRfYWxsb2Nh
dGlvbl9wb2xpY3kgcG9saWN5Ow0KPiArfTsNCj4gKw0KPiArDQo+ICBlbnVtIGJ0cmZzX2lubGlu
ZV9yZWZfdHlwZSB7DQo+ICAJQlRSRlNfUkVGX1RZUEVfSU5WQUxJRCwNCj4gIAlCVFJGU19SRUZf
VFlQRV9CTE9DSywNCj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3N1cGVyLmMgYi9mcy9idHJmcy9z
dXBlci5jDQoNCk5pdDogZG91YmxlIG5ld2xpbmUNCg0KT3RoZXIgdGhhbiB0aGF0DQpSZXZpZXdl
ZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==
