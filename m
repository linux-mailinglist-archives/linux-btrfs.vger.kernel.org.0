Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7B27B7F8C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 14:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242445AbjJDMpL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 08:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242439AbjJDMpJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 08:45:09 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C1AA1;
        Wed,  4 Oct 2023 05:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696423506; x=1727959506;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8cgBqqAD/8fWIjQFqpvDhmWiuVgxx+fnWAYmCPHWHCw=;
  b=aSqbySZ4nBs9EQ+6kEkkgZRzo0ALj6YQntjb2xdBUHi2c1LoJQBqA8tx
   daf2IZXmvO0xb3+/wEDg6PBf4wlUuPkKGR5DbQ2KcjK0KsTUKZ1uZL6W3
   lIY368hecCaKh2jCcTITwd+qfMfUnZyqLBx/DoFmIe2tfx7R7LzUMjxY8
   ljvZMXOIZ4Grz7my5b3BE0eFVJph5SlzYS4fgUkHWIdfjWfb1mHZnVb7g
   9gx4QOMG0Z82jYu0YEc5/eKFov9VBlf7A+fp8g04FZRhwbGoSD4yP71WG
   pE6B5s+BOQx5lHKxdGRLs96t6qc/26diIgEnW5mG0PBbVWPxwxEcUEHSi
   A==;
X-CSE-ConnectionGUID: KsDI0H4+S1+9J/FVw1Nh6A==
X-CSE-MsgGUID: 2HWaHaj8QZG/MlDiSdRB8Q==
X-IronPort-AV: E=Sophos;i="6.03,200,1694707200"; 
   d="scan'208";a="250148825"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2023 20:45:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVSrdzFV53XaoxZiMGtdG43aeswZ8e8Ene74KWooK2EELM3v6unajgIWXFlJuft/DT71Efst6PNyyPc8cYEJd1DC65SqTDw7Sx3bPk7vtpwbWBvW8C4Giij5BY+SCvHy7XUsbQxoB8d+5R5Tet5NfRf3Cp9NYjDfvYeXfaGzIS96kP2fygc90Blu1j1fPEKOZa2fxKtOupmFtFadNsr5fftHtoz/Q9VIFUU5nsZc+BAeL+MhGuTpl2C6wuu3tSsXXSn3WX66bSKyEqmP3N7IuBeOsR7uZJOHbpTejdfoiG3kFBo1BZ2yR+baaGstjGxTf1BjstgclFq73eUehWiXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cgBqqAD/8fWIjQFqpvDhmWiuVgxx+fnWAYmCPHWHCw=;
 b=Rey9Q9tMvYNUoYWKYs0YZX3wQglkFe8pT9FH3gPuf13Yj1MnrXHw4yIaK+l+nIvN5uoGsIDkCyMSYTiYjfdaKbXpJOXa58mqLtTF21Hprcy/8aJQCVN2sRL3ACTiVxzQt25WrdRGvX5yB6CgSKPRvRKj9zR7ekYMt+FCyg6lNaFDc2+PiRqAjcg8tUMOD+EEt2/FMnKP+uFufJ3MRuH/X/gemgBigCgV2WPmuwRMvGCsve4Zrac6N7NEsjPjNIS9Rl8J3I//3pjm4NBXALHuAphOORTPV0byfZvHbJKeWH9tJpL1SASMstdaOV0SMmvAckZQo/mBa36zG4vOXr7+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cgBqqAD/8fWIjQFqpvDhmWiuVgxx+fnWAYmCPHWHCw=;
 b=X9ibCo6BqRXnbJUCmslMGJEQ2WbGEXxm50qt7+ZU5FK1vcuYdoVB8xM+K5k4RWT60Bin0sz7sgCsgaH7LVf0bNHVGKMY1/bqpLRdlg96WFNUCtpNY71Ha5rGYnc36c4SOKnN3pLarS0yQtuRGn59Cq1p/sNLM5IgiK8IRXMrRbA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8508.namprd04.prod.outlook.com (2603:10b6:510:2be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.39; Wed, 4 Oct
 2023 12:45:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6863.019; Wed, 4 Oct 2023
 12:45:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Qu Wenru <wqu@suse.com>, Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] btrfs: remove stride length from on-disk format
Thread-Topic: [PATCH v3 4/4] btrfs: remove stride length from on-disk format
Thread-Index: AQHZ9phJA55XF0qqwEmp6QEZd48zgrA5k/+A
Date:   Wed, 4 Oct 2023 12:45:03 +0000
Message-ID: <c7693811-4f31-44a3-9b1b-3af0ec3d8bf4@wdc.com>
References: <20231004-rst-updates-v3-0-7729c4474ade@wdc.com>
 <20231004-rst-updates-v3-4-7729c4474ade@wdc.com>
In-Reply-To: <20231004-rst-updates-v3-4-7729c4474ade@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8508:EE_
x-ms-office365-filtering-correlation-id: 09485e7e-3371-40af-e28d-08dbc4d7baed
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M+0e9axUqfUjg9comyuqeChjaBZqP4/wEosbSSMLj4dVxSGrzexQ6Wvszu9tWq/SxxAWsiP8RigmcGhFrbd3ArQuVo9SojrCg52m8vciQsllRWLaPTZ5l6/nUKG4LX1gRbkaEHdFrhi8qOyG6gsezWZlmBNC0IFMz5vV1dB/ddjSTreJy9nEadysL2a/fiG5HmjAHi/8pIvx26CwSywt1DLbPphyzeoMVXI48VRM1Lu2qXFtLBHjUXve5LBAxIX7bTD5fC59IVTq2RAbR65dSXq2e7B75whxLmlPThqy+u1xa3juM2zbzCpS76w3PivGdbtMi72xYwHaSzI5qTK2NuK3rR5orseNedZbF8eJZj9VYAWWwkLKHxuyCwleOyDNW6qsbGpWSU46c/gt6YhFLxvs+HlRmFIfbiNJI7HJ/YsmOr5jmlg24axpbyga+1Vg3SeUHFT4uB+aPBrFE7bsnpvz0fLoZ8eikDg6yKWpcy2kMNUAq3cZ6Wy8owTM8r7ICOUUXcXRFntZ2aZMGdGcymG+4s07BsoB8xoyoX8d56JOz3MunRfz9igQTZEpe1qzKkW5iTxhPNgkiX2oQWK5FXphNtxYfyCkwA9nPXYgT2OpRECfxqBZcf6tqFE0h/U6XsGbDrzLMjlgpp6yjj8ssjU5zyUFolvda31BvnEJEZ3fXMd+8SA+ty18EtqWqSKb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(478600001)(6486002)(6506007)(71200400001)(38100700002)(558084003)(86362001)(122000001)(38070700005)(82960400001)(31696002)(2906002)(316002)(5660300002)(8936002)(2616005)(26005)(66946007)(6512007)(41300700001)(54906003)(8676002)(36756003)(76116006)(66556008)(4326008)(110136005)(64756008)(66446008)(91956017)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MC96WlZjQWhyZGN5b3dMOFo3N1Baak5xOFhId3ZyVmRlZnlvVlFMZHQvMDJG?=
 =?utf-8?B?WnVhY2QwM2Z0MW13S25PS2hIeStObXJ2Wk9XNUowZ0srRlBWUmFHMXJVL0Qz?=
 =?utf-8?B?Sm9DODFaZGhBS0JzTFpaaFI2aW9sZXloSnFlTDFXcWxVMUdJK2wrODVxNVVV?=
 =?utf-8?B?Z1RVSzlwWTROcm0vcnlJelBicTRrK1FKclk2eHNNRkRFQjlnZ1ZkQ2VoSXF2?=
 =?utf-8?B?TXBWdVNleStIUFVGM1lRR3V6dGZhYWdNTTM5MzVlYVNZUEcvWGJuMFNqRUd0?=
 =?utf-8?B?VWVKeVVNNGM1NzUzVW1hUXNyWUM5eUZxVTBseFQ1cU82SGd3WTMvYS84Uk5v?=
 =?utf-8?B?cU5lMlNlWWpKMUNFL01ueG0zamJmclRNcGVQa1RrcXNjUmt0amdmOFY3Mmdu?=
 =?utf-8?B?REJya0lMN0RxbGI1anpURVdsZk5leEJocURpQlR4RXhUbmREbWpYQmRBVWZI?=
 =?utf-8?B?aWtRMG9kcU1yN2IrS3Q2ODA3ZHF0SVA0dlFFMzJ6SWZIM0ErdVpYT2U2NU0y?=
 =?utf-8?B?WEJmK1VvTm5yRlF0aWhCNE1pNXRyNnJ4UG1kNHFpY2pQbWY4S0RRSEsrbm1U?=
 =?utf-8?B?aGMzczJRQjlGWE9yNWsyTUd3MFQ2YmtvWk9kVWp4RytOS0FhWk9sRzFUMy9n?=
 =?utf-8?B?VDdQNy8vWC92L0I3andiMUEySnhNMDdscE9acUlYNXluZjRVOFlnV2dlYVlF?=
 =?utf-8?B?M0xMYWpxUFVwemVEcXNRTGxxeFA4VDNJNDVNUjVGY2FmWW1vRlZKMFREZTdr?=
 =?utf-8?B?MmNLZmlHOVd3dHJPaWF4ZFhDcCtxTFFHQzFaUUkrb1p4dGYyOVZzU1pIQUF6?=
 =?utf-8?B?SnpPVVZiOERDcTZHSmV1dzNvaVRNYmh1RjJMVEdHelBpQnhwREpWMWdlS1VX?=
 =?utf-8?B?UWh0bERqWHhDemt3KzRsN1FrQU1yTHZYWkdsK0NCRUxHRjdTNlFFWVlxb2E2?=
 =?utf-8?B?MFhsd1pIRGNUUUZMbmxxQTVvbG8wdU10U3ppVXVPd1pNOHFCRjhpWU0wQTJX?=
 =?utf-8?B?d2MzY2djby9qZnBndFNVcGFZSU5ybWcvZlRmcWoxSkF2UDUrRVpBd1QvQVQ4?=
 =?utf-8?B?Zy9YdnFadVZDUmg0Sm5hQlFWeVNEc2poQng4eDJBM2VDajRSUEFwOUhUUGFm?=
 =?utf-8?B?RXBLQ2NqZHN2alFwTGxmdmkveGhKZkpPSCtLSThFYVVFc0pTOXZ6Ni9xQXR5?=
 =?utf-8?B?elF1S2VNaVc3Q3d4VGd4MmN5V3M1TVBnYlR4MkVvaENNbDY4UVg0WjV2M3pl?=
 =?utf-8?B?SVdsRXdaYTBZaStMcUxwZG9FbmRrOHR5aDBDK1NyalR6dTVpT3JXbVNIMk9E?=
 =?utf-8?B?bmF1c1RXSk5XbklENGlnL2hkS1dWOWtYN2hlejQ0NkZCNnR5VE9nRWswdTJV?=
 =?utf-8?B?cUxtZmtCMnR5SnFYS05WZVlvVG1kT0RaME5hUVh2dUdtM2tKcVlUc3NsRDRo?=
 =?utf-8?B?a3B5dWFCK25WVGY2MHhMZjdXdWJNdG4vbk11QUZjcTEwY2xzZWFLU09wRFFx?=
 =?utf-8?B?L0N0d0RwUnd4c3pBcEhlSkJIUE5uQThFZUh2ZUhvZ2lyMVNTWDFBeDU1Umxx?=
 =?utf-8?B?eUNrR2NQNmVONkE1OE8yQjIvbGEyY29QemgydDNLVTRwam4zRDUvMnFMS3JY?=
 =?utf-8?B?YmVDTjcxYjU3bGdsdTFuWDNSV3VNWStOd2FkYUtrbFhxMHFUMkEreC9ncE00?=
 =?utf-8?B?eFdIZTl4bWpBR2owUmw2aGQ1djQ4RFh5eVdzSjBSZ0ZPVVBSVUE3bmJIVU9L?=
 =?utf-8?B?cnJDaGhzOUNEU1h1RDY2SHpJYUo1Y3VOUTNtNTJEd3ljek9kZ0wzd1dCTTBR?=
 =?utf-8?B?dDgrMjZQK0ExWHI2Z1pSRCtBNlNyU1AxbFFKNXFTZldPUUFRZC9sSU5kZy9T?=
 =?utf-8?B?VlU1Rkh4eUdRTDh4ZTNRUzJKU1paYXYwUVJOMTAzeUxHeXJBemxYNUEzeVlt?=
 =?utf-8?B?eDFXQ3BOU055U01XU3RJMnJYSXYzVDhvSG9nWGFDQWs3ODVNc2htaXpXSmZU?=
 =?utf-8?B?em92ekdHQ282U2owOE5ZdSs2NjFlUDlhMkdvMUtvQWhJY1VFZWVMbFR2TFpt?=
 =?utf-8?B?ZzhGZnYyVzhMeFFXcUw0NHluN2ZyZFRPSVZXYiszYU5yOUROOHhhQkJhQkdj?=
 =?utf-8?B?cFllMkRDNzFrOFdna0xUNlk5Y3JielBmZ0JaYURzNWJhc0dJWklmbDhRWVlx?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7B931DE1D5D994BA8ED09DFAA4DB371@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iXTcvieQVZshxzGeAZR2jYFVJGAYw8oprSDUbjAdeWjdKfnZmueArZFbqpeqJwLTK01dBHY02alldFUB12t0oKmohkfiKaT8KHpl9heQ9IUUmHJXb1rDRKgCr8GdsqEE4PkjW1qvWmvU8+jwX8YKssL1Ohm2BbFaEeGJ0pwQmNbcVQGOvdQS5rLXr5ic8EiIP4KQNf+FGEw28sxzM0P+ji5a6Uaq8T2o3nBc6UrmaeJVeuOy2QWIq2zqJSb1ffGong4+gfa6xYGwbPfu8WUsRvCYhHgfre3Xfug2PQXrVSZcbmMj6IoB/FIJdLURxh+mcdG41hRMI7rNeHlmCaB1sxo87XOmNv2sZcvD+CUVH2Y7cDJjtgRDyBzrXceyEwEyB1IwHDClALcQ9jKHyJ/cstFaWciCKcnHeMf1ZFnp2TaCymLK04YfWlsn+O/Dzctj7Bn/h3KVysETKEb50rVeq2VqUYhx/GkiLZbohpIKysxLaT7yevOFpA8pfQ7Wo75GmiwPOWddl2/EHeFQo5URmCCtLDVsyb+fUGbHyWkxRKVrD5X2Rvu8wD+BFWi4QO1rb9qclNlHuJIjWdr+H9Y7iNHDsqCpflXRSVrQuepOlBeLJsKqNgfA9YLM0SD8s0GITzUn+LtJclPaxD/boF6l1eQC+Fg7VJsWF8twDj+oZ2m5rBPULIgSa1VfhvPR/JjVLZTGZIKGWPgIV8O6OkrcRo0xewcCixyXXtiZl6Uh+MaVXYLbFvjjSJsMtopFPmsdb3ClJi6kJRFbgajfsjC8i8TuTa5ZKF4DIQ5yDhVrP4nD+PekQc4RiBTb74rfk4H+WVeRMOGPvD8wCo8XewDVjPhn78KhBhgsc59kPJyZSvMW6uAJbWWf1X4t+OtqX5uz23MjR9Qqw9vlsUnqAhdDYg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09485e7e-3371-40af-e28d-08dbc4d7baed
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 12:45:03.6189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WEuM3/kHeL9w/ethi+e3Db4AAy0MYYm198jPdDP99+26e3ol8XUWBz9maVWmuAsbmpq7Yl+zikwk1oAJcCgCGDD32YEAOvOLbtjTTqls1RM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8508
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Rml4ZXM6IGNjODViMmNkYmYzMiAoImJ0cmZzOiBhZGQgcmFpZCBzdHJpcGUgdHJlZSBkZWZpbml0
aW9ucyIpDQo=
