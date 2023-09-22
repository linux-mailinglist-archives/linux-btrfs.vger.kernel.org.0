Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D1D7AB223
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 14:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjIVM35 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 08:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjIVM34 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 08:29:56 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCE299
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 05:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695385790; x=1726921790;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=aD+KFUdaBSl/6zHkxUN2JsJ4JY2K59VUMzjlH7KkOWJATWWJicYxQyR0
   1Apy9Er+TOfZBMejHTFo5bSoszGgg1+5ZuKWG3ZIX25MZ8RYA6jyzTymo
   VwVpQJ1cO/snkjtrHOfggttRG0+tcH4AlU5Zm4LX662lIO2EbY0mgdGjm
   IsT6jOsjHmjqd8hL8llsa3BkX0+eoUHIlR5odJC7YywWk6tUkuyALxl9F
   1jOL/HRHbQuJWUYxIVpl0nXmooSn2xXgQK1S+IpdMruOshmkm0lLjLlGF
   ImcyX/rtH1zS+TagrlCYSZUNHAKj3G8IvLtJbbVxzED51jhdfwMK21Twc
   Q==;
X-CSE-ConnectionGUID: mYgALJyxTz+ha2O81j8WJw==
X-CSE-MsgGUID: UFfVSwKdTdWK0BjllJFdbw==
X-IronPort-AV: E=Sophos;i="6.03,167,1694707200"; 
   d="scan'208";a="244948209"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2023 20:29:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mdfyadyu1WoXFgzAoHPXiQSyOTVPsxAys+/purYiHXtapyoo0Rucj88A+xUlB0WAI9Ct8qcL9tJkM7rZF3DI9saiGNc2ZyHO3MrqqjIfpQv9AqbQbHC6q0xZ1JytDfJUflCA4Ews/CneLh22dTkdFxxMhtN7sv3NKIElR29afvVxps2U1i5GlKD2YMrpWJDWfntmM/we8GJbMr4h9I2q5Cu4Xm3QqpCSBEwR1wjjVASb5WUudW1CJZ9vA9JZg2lLBTBKx2fKU6FFJqS8vY0iEOOwTuwq3LOBz2NyhYOMplwSKaj5FPzFmwZ0ypQVxeSReA2xPxxi0D/H8Im3WXO/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=hCLTH4qjhy7ochq5V/uHVYKnTSIDMlKltiWaphLL7iUJezAA17q+23vaLGfevsum7+oSOlh6yD7sULEjrNObpywShrdyn4cjaWF9/hQLbI1sG6n7vUHf80aChnr+W6T721jZZRNTHC0jHCDeV++ymzJAYhUWWWDwsyTYDZMn9zZAbN5feBTSLyXJ6iZnhoieRxdd834sjFX/w02fB6zWfR7WkPhUV4wDRgOCo606xHLw/7GaJ1QZjceIBcZKNrxuqUh5poulumC2Xf6OGUOW2THRLz+nkr1g3fxVsyVMkxKH3OXBfdDP+aOUPjwV1mWnspEVwLHlRQTXI3QsGx5vMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=gBOe/mTIp1UrrYfQpGj4S3E4ybEfuBdyNLW4bEgyFwf75pS7maENDfpgV06+80c2X+wOQFf1xWTdWIbaOApvWfNc/7/cEjulhGLsI7Q6bJZqGF5X3tu8PjB2abWCc3ebO3lwo+nYiswixPbZFqVCGDSEyaoXOKaBpExFMRiDlsM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA3PR04MB8671.namprd04.prod.outlook.com (2603:10b6:806:2ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.9; Fri, 22 Sep
 2023 12:29:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 12:29:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/8] btrfs: relocation: use enum for stages
Thread-Topic: [PATCH 2/8] btrfs: relocation: use enum for stages
Thread-Index: AQHZ7UXlSVAzIAtryUGPn1Gr59UUUbAmxmaA
Date:   Fri, 22 Sep 2023 12:29:47 +0000
Message-ID: <d800df2b-856c-406e-9af2-04c9757a9a58@wdc.com>
References: <cover.1695380646.git.dsterba@suse.com>
 <e20220675e8d2501f4b98bae12a105615abe634b.1695380646.git.dsterba@suse.com>
In-Reply-To: <e20220675e8d2501f4b98bae12a105615abe634b.1695380646.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA3PR04MB8671:EE_
x-ms-office365-filtering-correlation-id: 1e30e60c-113b-4fd2-f28f-08dbbb679c0c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e8Aa3tRjEOjv7CCuNKLC98iXXRrkGT3cVWc4ePm/iyzWJ76NWlNNf/oPLMpUrHsQrnEhXs9388Sdi6BoIbn3AFkxS4XAtY1Iw7cwdYRN2GsTRPKgm6oJhZFr4YCnZcgcWVHUxxRV49HTZBN6nZPUbK0hCV5cjeW6Zdfr0EGmZSQ/XwH5i0DDtG9K/C0OgPgLkI269/XGodJG6xqDzNdSwDhcnjD/e/dIthm2E3qZZtvzm8/rhseoUvXxhcVrP8d13bHrPlUa1zMR1NAdEwIwKBD3+6oRRiAbLkuQSZhWxdzuZdfsZ3RYpZS8K0mZFV4GVDMqpkC124ntfxnSEHrMA+gtj4O2eGWa0u4dUy44lqaAErGRYLrd1HmgmGrUdRbe4KeoglX4IUzhFlattH/q6U+l7AIzG9Ymxmp5Yi7leObv6Izsbcii7MQ4pA8RzhOu/jtQKusrXV1UX08FHFiPrFO0uCRWHzW3um23CwRSN9C5SmefaaQollSDH1gSn+CS8ow0mfA6+eWO3xYbCjXhlCzMZFsh2zs2ct7+x9/W5L8dI1/Tn0JIuebK5sC5TVqE8rnyBMwPhUru3/UoUm7FSGRYHg5HLlW3G0mzC7iMRKBwaoRp20xvJqeXVrLKrYR7WSzMOaOM6pSrNKcdTZGcOg0O/x5r+EZJbL4RXJ9oMIL6/17NDmmbhdI6Qb5da8d+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(186009)(451199024)(1800799009)(110136005)(76116006)(66556008)(478600001)(66476007)(66946007)(66446008)(64756008)(91956017)(31686004)(558084003)(316002)(6486002)(6506007)(8936002)(8676002)(5660300002)(71200400001)(6512007)(38100700002)(38070700005)(2616005)(86362001)(31696002)(41300700001)(36756003)(2906002)(122000001)(82960400001)(4270600006)(19618925003)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUpsdkl6cE1rQmh5RGV3RGcvRnFycGlxMGY2NjIzZEZpQThnTFpsT2dNaXpm?=
 =?utf-8?B?a0VQY0ptMStERlY2OUxMYlF0MW9xcldKM3dtQm9odElMb1l0Z1BxckR2TTVn?=
 =?utf-8?B?cHZDUmtaZStyNWo3bVhYYmprOTRUekgrMHE5Tk1kN0tvaXZzdW1oTzJ5QkV0?=
 =?utf-8?B?TmhWNzZGOFllbmxPa3JZandpK2JNT2Y2NGN0bVJMMjZEWUp3ZUtibUxEd2ww?=
 =?utf-8?B?c0N0WElBejlaN3pxdjczbFdSTTdlb0lFNW1xei9Qd1FPSEJoZk5SNTdqaVNE?=
 =?utf-8?B?cG5URWhSU0NodkllVkt1c0R1d0ZUTnd6aVRRTXF4aXc5eFVQSG5BZ0FFZ0Qy?=
 =?utf-8?B?cUZCZ0NSSEZiNnorOUF2QzNzOEE0bkVoZ3g0bUk4M2VTSTRmRVFZeDl1QWhO?=
 =?utf-8?B?UmtzaXYwR2xFREt6MzFhb0F0OHQ1S2ZIbE9GTXNGRm90WGVPajdMN2hOUCtr?=
 =?utf-8?B?aFhHZkVuSVpma2Vvd2FxelpqZmtvd0E1Ni9aUlhSUUY4SDlscC8va2J5ZW9s?=
 =?utf-8?B?V1JWTTJySUVjdmM2d25aNkI1Qzd5OFJORm9Ld1hLVlEyNzhOL25HVys4c0h0?=
 =?utf-8?B?Z2hIU2VsY29zcFZ0RzhrSDMvMjk5Vkp3R0ppcDIrY0dlUDhTblFYQi9rdTRp?=
 =?utf-8?B?T3ZhWTYrVkJuMGQ3ZXljZXNKR2dIcERlblpmbDcraHF6VTJ1QzhaZ3UvZC9s?=
 =?utf-8?B?Rk9vejZOaDdXSGZCWmRMRWt4T3hhZmh6VTg4TW5uVGI1NGcyczFsNzFGUGxV?=
 =?utf-8?B?Z3g4bEZ0NFVzNVdWejgxWUZ6SzdIUk1ZUjBwREJUc0diRmFtWlI5SndCakNj?=
 =?utf-8?B?V3NnajhCd3hIaEVVNVp1L0lLOFBkNzQzdWhSWkpXOHJ0TEQvMmV2cU5qU0pL?=
 =?utf-8?B?cEJadVRiM1kwRWdoek0rcXdhc1JWSVIxaGpodnBJOUlEWE03S1VmVXVHREc5?=
 =?utf-8?B?eU04R2FLUXBnRG5hUWh0dTc1QVc4ckVscVFueVJGWGE0MXdJbmVqay9CUm56?=
 =?utf-8?B?cmtBVGJvYmJVZ3FRbUZQRGdIbGhiUlh3MzBUWkkydVUwWE94ekxhSmg1UElH?=
 =?utf-8?B?R2srQzUxWjhnRVlGOEJoRmRCUG8zWWhVLzZlYkttL2pJRTZ2Z3VVUCsvd3Z0?=
 =?utf-8?B?MXZXZ2d2R3VydFNkc3BJTGNxU0pRYmh6eXh2S1NlSmtMbDNWNWYwYThnaDQ5?=
 =?utf-8?B?U3ozbC80VUtCeis4d1NQeTRYVXliL01mM1VxN3MwYXorQVVnUGJ3c1pRUU9H?=
 =?utf-8?B?ZHdyTTlXTG5jNDRtRndjQ0szSDZmRVJhYU53SEwxS3M0dkNFWkhlTWhrYXl1?=
 =?utf-8?B?U1NjVjRZS1BRc3dJUC9YOXFGR1BJZjU4N013VVdsRFVxYkFsUEV0OXBIaWps?=
 =?utf-8?B?WXdnUkloZ3FpTVByZUZSL1ZQeVZMYlUxNllXM0FXNFBTVkRSTkZxOUZCdWxS?=
 =?utf-8?B?VHRCUldEb1F3YUZJREFYUStvbzc0TXVVWGlGYTRqMW90RXJOaTNibksrSjQr?=
 =?utf-8?B?WUlvOHJkUVFabWlPemlkOUNEQ3k1dW0ybnR3akVpL2Uwc1kyVjRmVEN3OWl6?=
 =?utf-8?B?Z3ZqR2R0eEJreXVXVHAxeTM0VCthOXdyU3IyQ3grNnlsQXVWdHdycHhlQ0xH?=
 =?utf-8?B?SlZWSEoyNm01aEJNdmtQYUVoS3pDeVVzZjh6U2huZmZDKzFLZ2RoRWNnZG1a?=
 =?utf-8?B?ZzJXVVdWc21nR1RHa1pyMGo1RDhCcUszaTB0UG44M1ZQUzJNUExtTFB5cGJI?=
 =?utf-8?B?elJNWEhkbVQyQ3Y5c2xhcDJOZEVUZ1BsNW1ZR1FPOFFXTmFzeHY2b1dVMGp0?=
 =?utf-8?B?UzdsS1ozVmRrRmY4SU5XRkhNejJqL0cyQ3VUbWpMcGZvUzkrMzd5bkNLaVFE?=
 =?utf-8?B?R3FvZ2lvWnRJV2pPc2Nidzd5YlZ1QjRjd1pCejlITUhLOEdEMFJBb2JaSVhE?=
 =?utf-8?B?Yys1dU44OWpEbExaV2JDZExIODg3QzVjM2NpY3BoMG94SUh2bHpZcWlWU1Qz?=
 =?utf-8?B?cnd4TkFmNVRqUnlJQ21zUmRoc2ZkaHJ1QWtTdVB5ZnZnYXQxRzFqemtwVHdy?=
 =?utf-8?B?UTRscU5LUFVUK2dKSzdKK2dMVGg3QlZhQnVBMDZ2UC9wYklKdjRCR09GY0o0?=
 =?utf-8?B?OFlGNkRhcm5DVG85ZnNnVy95SENDd2FTWVR1ZW5sUElaUmxVaEM0TThvMTFT?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD52D03C847B0D4086C857D19780A618@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3nZeZa+CbyfhsRpxAw89nFgSwd+Km9VDQOoQs22NvfALT7OXNLC8z9oU02QwBE7a4ax02DvtdQzVvOl/FVKe3BEkhrmGKlwjBQxSfBwU/8mPqjpcgNnynTi9lCacPFS5AG3GMyij3yx6ZGZmSS4Tof/V9nfYYta7whBXcfBEgLF0Qv0YxYtc0QGc2wKkpsZehhKLAnqcsVSS/tdnPNxnsXg0+U+5/QAJAk1GuMOfMoeum0M9cVMUij/qGCJEkZ7nIupNpnnaKA1u5LnYmz3746TzZKceJ1LW8UAZSJ5rIb/qZycq2HNwTGVrtmSJGQ8WM09/MZGSjmuawvj6ivmIBUnEYLLEF5TCOUSjUF96YgZp3IKWymuDv7DQfuvqkm3FTd539fHlfrE4iebes+ilJ0Xy8AJ1NqcJ6++qhiFCm/IdTxq42isGbUbFSl3bOZLFVazWH5aSJr5TwtlIOSb30rCGST8uTqLvT0nZ8xWOaIj54voaEIBPpGNIeLQAGd6lbgSw9d3D4Umeu1m4UuYSbkTbSpEWdVbzrywFVouO6Rg7qLhgJlLeEDn/Vs1WltpJRKPH9UJs3WSx74ctiu9IcueqfKanQhSs1MFCtDVmJ9f01ZBW7nCFe20QcTY2oSQrkBNHDxSQOABrCXdW+tGmGkQ6wYi9w2uVu+S2g8pusn8ENMUq36nsTF0hh/fAhoP2ZwBtgGxlSzSeY5neqWet3vnPhmFyOSbl4VUqGgtmdAXoU/8wmTNdYc1TywGWUo4Bm2MNgILxTcQc0jOhvOihCNDFmM3DwKis7r5vEBPwHpAqVuAWojFXyaLG+bRrp9zT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e30e60c-113b-4fd2-f28f-08dbbb679c0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 12:29:47.6866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WGUJc2D9ISmIjBDhIRZlVhZ49DyiXkRrUshWBqs9OhxdUcUOs8ry3ZE9vamp/qOzSAx9rJ6ZESUjPLr8Lnd/8SX5qvr95gbA3pexdkvINA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8671
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
