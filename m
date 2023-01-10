Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD5C663AA2
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 09:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjAJILn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 03:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjAJIKw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 03:10:52 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B69F4A94F
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 00:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673338210; x=1704874210;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Gf8exK8751JZSyTujvZrCFaD6A8Pc4UTFcFnCeFmdBfQn46d0WSE4s4r
   9oJoGJ3wHoDcxxZ8jwUabGkIvVhlhAtURkfxT5vsAK45NZ1rN9LiOwzom
   QgGyqrDItw3JHeSoPQie8UD2RRtBbIb76yzqqFgtd7qT+5BJVlehwXoDR
   8n+8JReYG9u7b1DgvSsxSB847yO+Mk6e6s8Enj71q4A0jdJJnUhEAeBgv
   MdG8C/hiVYJL+0kAmqjrjSThOQwIZJ8HXdcp3mHCv7sFuj8Oxw6ESpxVf
   SefPqrCldrkJ82CbR/7/BLHCnSs551nK33TKzHCLpPlG54VsNmcskNx3u
   A==;
X-IronPort-AV: E=Sophos;i="5.96,314,1665417600"; 
   d="scan'208";a="324722369"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 16:10:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAC/24ixln4GtmlDv1taWsJXpc7S+Usdxbms5tYqTBof1M//VCqCbQ283Y1VhH3vnBzC/yZkSmOCfdFA4hqA52WQiN2n5tcPb8afckuN9dAsIQr4j+iuW0t2IuwXh7r94Z8Cg/ap8nj4tk3/8acf5ae+degCYUEUhZDRPBWEDpPVtTzkAXVxjwTQkoJ2i4HB9lYWGgz7QTpPfNNjH+i+ikymOCqEGpd/RX1z0IOoV8KGSQg8Lu3Kl144RPttjXCfYRU2jHU5fX8bjy7wuqTslK0iAUNrI4oVprMjWGwSzS1ZPbSj78NIJgdbZet5p4Wi6beicTSbEOWqIjkYtSVfiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Kk64B2zc4b9FR03wsbTNdEGEd4Ld9IdmkFnBOrg9YlkDrkRUCC9DZhx+MXvzRdGOD7nThSK6u1weh6M8m4zP25mzVbFOnj607DGwNx2rJo/+rdvR8PMPgvLH88cr2fEt+Q/4LT+bLLN9Teq69FZJ3up+CZ/vxI+mC1BsU0iMOpF0HSeyg/067A/x25je0AiXp+xedlnVhXfq9DdAUA/wSuSe29QjPi7a+Uzl57emL23d9KuEBJpSBpo5BlkCuNpD8+LZhY17wyYlgucASfrnrw1fECGL9CzZXOrs4/mBoJeFEyCIAYujtfQ4pRCWI9lo1h1JXupdowkRJACi6q05Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=uFPX7D8C6PA1LswQ8ePMXBDT2MSCH87T93H+chufuRwQB8cOJvk8N9yGRaTcIR+DTA+TtvgcXAPzNJx6QPBTl5HQSaORfZNMPL+Er/Y4gUP57H0YKlmyf1bbTHmZyw+fd2fUTK0ekJuPwy8m6WVMmjXFkE5zu2Ex9d9ZlfkNnvE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5641.namprd04.prod.outlook.com (2603:10b6:5:161::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 08:10:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%3]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 08:10:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: enable metadata over-commit for non-ZNS
 setup
Thread-Topic: [PATCH] btrfs: zoned: enable metadata over-commit for non-ZNS
 setup
Thread-Index: AQHZJLmXWjl3R09SnkezjrW6t11SPK6XTHIA
Date:   Tue, 10 Jan 2023 08:10:07 +0000
Message-ID: <913f6cb2-58f1-b857-6878-91b3e2eb0e5c@wdc.com>
References: <e0290c4d7af96991ddee4442a1c602cfb3a79ba3.1673330455.git.naohiro.aota@wdc.com>
In-Reply-To: <e0290c4d7af96991ddee4442a1c602cfb3a79ba3.1673330455.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB5641:EE_
x-ms-office365-filtering-correlation-id: 35079e55-660d-4c70-5e87-08daf2e21610
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: etU7rSIlIuDkcmydWurdBW9o9LyhVBKQ5iBxXqs/jsXJlPM2uTjKPLd4z7z1Go2v3d+ujBwWSF/m20pdCU6c3RcuwZ00ezLsrTVAYQonnnB+FLFRVo1pLDB4avYE/CMgwwRdVchxFvV+7tWV7zKlnA/THY2FvhTEiIc3Fc2Oxmsp+k8ZJqbVt3b3zFLUtd+gtRegEf3ywolVLGJ5mXkR4wHAXQE8mzDX7vRxTR2rgeb7f4YTRFv7GuwJjIABH6NRErIynvlrQQ3nmkD5wNjs6EtK2ZNfdeyUAiPrVhxYT7LEl5Nvpq7hTlGH2FP0ETzTkWhu5QtIBNo2tA7SX/MgdHxgdvevKAiVOAaedmOFZ8LdkkdqwxmUHgiDsgJPwFu8HN1THZPHFvsDkEQSnuzSk9xL05r5qiE0YsNeYCocbVy4HxTebaQVLVZlqhns7/GDBVtpfx7+VJcbAlTvN02a67Bn7c2VySZJ3+nz3vxpqW2vJbjFFkkcNgzd5iOQTCoicO2cO7OIq5kHj0u2VZQ3iadMU2yy/k4ifJNB1hpU/da0hXLaIY+tPRv3weVUTyH2qkb7Zh+CdQcr4MPHw+x0FwkjMXhvcnsYXhugYaVd8MIKF98y3SWAkOzbFUFENRbWnZdnI+pgG/UQlfe+Tf2G+9rBBQA9PAkdPx1pBHOqpyvKWJDEv9o4BuAqk1/tL6tzEPnES65GxiPZRTD8bHnVJSJbcOxlwsl8DCIFBjk/SX4tIGK3gt2pMBl8mb9cMT6YSY8H148DTjawfgeL6qvwwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199015)(558084003)(8676002)(122000001)(38100700002)(2906002)(31696002)(86362001)(76116006)(38070700005)(66556008)(64756008)(5660300002)(19618925003)(8936002)(66946007)(66476007)(66446008)(6486002)(41300700001)(186003)(6506007)(6512007)(4270600006)(2616005)(316002)(91956017)(71200400001)(478600001)(110136005)(82960400001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnQyVjlHV0RPU1JlWmdzQStORGJoL2ZlMVU5SlhBRFhXUGNldmpyZE04dHl1?=
 =?utf-8?B?S1QxVExGaVVKMFBmWlpiWVJXVFVZMU54ODhoeUlJY3I2cXNEM2w2RHRrNkxF?=
 =?utf-8?B?SkFnVVJ0cmtUb0ozUHYvN2crNTZmelM0VVVFSEx2VzdqczNLSTk4ZnpVYU1Q?=
 =?utf-8?B?RlZVSzFaRWdlcFRkNGRxaUJFcnZLQ0E1WHF3WUlTemhGWnJkaWZnUm9mSDFL?=
 =?utf-8?B?ckZvaDF3dGV0em1nU2pJQ1RnODNsb2I5LzBzQmVicmNtQjdMNG5YUS91azBs?=
 =?utf-8?B?WHJWbDRlVkhnVXJLMFBOL3FQVldHYk9uYms4ZmtXNGI1cXMvRVhyQjFpTmhz?=
 =?utf-8?B?eit6OFFyMWJ5WGthY21tNmM4VGo5RGUyT3VaNFNMRkVPTnVYSHU3RnRnYlVL?=
 =?utf-8?B?Q3dqb1pnVEFrWVM1bHJ5cFd1eG1IUDh4ZUdoNzBDdzdJb2hXWGFjdWh5WmFG?=
 =?utf-8?B?UXUyR0Z3TDMwbGVzbXYya0o1RlRQbFlmVG1vZjNxdFFQMkJUODkvSXNVRGd0?=
 =?utf-8?B?NXFITHVsM1Y4eHBYN053bmo5aEI2STJ4d3ladUJHR2FjZ3pRQnZvMEFWZWlk?=
 =?utf-8?B?Z0E2RlJzY0ViQXNEaktmVjZmM2tjUUtJUzI0ell4SCtIenlaV2VjaEdLVC9m?=
 =?utf-8?B?VmlJallWSHBjQkZ1Ykw4NTFNcVhoRE9nSHNrdzJEWEtHZXY1K0lnYVdXcEZH?=
 =?utf-8?B?SXlBa09WVmhSS1dPQ0xyOWRjYzMrdHdtSkdvc2o0Y1Z0NlB4bERyTUp3MXNp?=
 =?utf-8?B?ZnVNcTAxZXp3M0NjRHIzdlBkclVkc010ZDlGRERrK1dQY0RjR1JVaE5hOGls?=
 =?utf-8?B?aUlwQnBaV0VVYW43K2l0alNEandFN09sT3YyK2lNNEtXUmxHSTdMZ2xVdzJs?=
 =?utf-8?B?RGRWeXpWRi9pTjJZN1E0RW00MFdnTTNPYzIyRnliNHVCRWxjUC83dll6U3c5?=
 =?utf-8?B?dGhmU0ZFZ1VDTnhpVWJRM05XU09hU09qVGdieGw1K1lCeWI4UTczbHRYdURp?=
 =?utf-8?B?aWVVaFArdXN6bkdWUXpueXJ0WUEwVHU4bVdXZnFtUnhHODk5NEF5dzcyb3NQ?=
 =?utf-8?B?aXFtcVhyS1FPdkFpR0ZZcGF6dXpFSU9Ydnc4ZUw5dnhXdS9QWUFWYjlMY3Nj?=
 =?utf-8?B?OEp6eWxZdm1xallyWFRNYVYwOExNc3dNbzMvYWdmQWRDSkJMMkRVc0FNQ1FH?=
 =?utf-8?B?TVpzYkhwb1ROM25SZmlzQ1JwaVBVazdLWUFUM1NEOStXY3R5cUxuYUh1ZE5Y?=
 =?utf-8?B?b0ROYi9hM1IxS200SE5ROGJrQWdwYkpwbExqRFVSOENySGdwMWxKb25jMEJJ?=
 =?utf-8?B?UFpVVjBDcm15Y1NtVUV1TGhaaWdEQmhPdFFMRjBtNnNaSW9CV20zUkJubzhJ?=
 =?utf-8?B?Q2U5eVJIa2E2OU83dFNmVk4xSlZDNUxoNiswTThyMFlvMFVlcGFWaHp6c0I4?=
 =?utf-8?B?aUpoaE5EQTZrb1I2ZnVnZndtZmZHaVNDcmduWkhuMmtpT2NuVC9DYWV4c29D?=
 =?utf-8?B?eXdyeFc4dFJlQit1eTJHWTh6d2NIbjgvUXB2cmFPTWMrbUduYUZOQ1E2NGVl?=
 =?utf-8?B?cHhUdkt3bERNREdncVk0UlRabXk2QXVvS1FFMDBpK1NvNDljUTZ6MEpUckpM?=
 =?utf-8?B?bnFwRHRhWGZvMEpLT0xYdzByc0dxb21pS3JpSmZIcmdYT2tqcDBBQXloNEdM?=
 =?utf-8?B?ZHREbWc1N2lLYUIvRXZkc3NJZDlJdWNCY1l0eWZPeHZUUkdoblYxNlB1d2sv?=
 =?utf-8?B?N0FhaEg4NjJUUy94aVRJT2lyaCtVVjVSdzNHNHV4TXd4WCtyd1F4OUNxMVhh?=
 =?utf-8?B?OEtnRENHN0o4NEs2Vnh6WEJrWDZNOU13RDRmMmZJV3p6YVpCaFNaQ2lTQ2Rl?=
 =?utf-8?B?VDhJYVdWTEJGNE9ybUdBQUZiT1N4SVhTc3h4Qy91VkRJNTBKcFE4ZUVGZXpN?=
 =?utf-8?B?Sy90bXJ6alg4TkZFcDlwQmV3eWlRVTR3WENoK3hlZTFwTUt3YlFZdHFBZGs0?=
 =?utf-8?B?Q21zcFI1Yzhxc3JVL3QxdWhyNzdwMTVBaUk5YU9aS1lBeWVEblNDL2RuOHFq?=
 =?utf-8?B?eVR3VGZ4TEJ3WjgzOGUzditlK20wL3Z3RVU2MmVWZWJyOXh6SUdYZkRNSnoz?=
 =?utf-8?B?dzY3ZG1NRktQNkpKZGg0aFlLTkVmSXhVWm15WkZIc1RaSmJ0K0Nhd2Yybmxo?=
 =?utf-8?B?VTcvcml6TTUxZHAxZjloVjArb2RqQ3Uyc1RVMzF6bmJicmE0QlVqNmZqYmtp?=
 =?utf-8?Q?Nq3BQ9kKJXSdL1Re9Ku6BUgLqX1PPZ+jNgOkm96uVY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A0B7AB7F76E8646B4C991A563FEF9C4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OamZrVfJSF0zYGRxbSfSPu4FVTnLYmYpLUMdTocGKORIssyv7wYzTUN3c66/qG/HGGZdi9/nuKEVOKBUm1YgibEd6/wQ2SVNhdxrL1Nzj3jrjCEmfgBaLwUEQQTNlaWQC+ENd02bplGvzTHECt0PpAU8ENydKBNILmtX/yWLYrPX3A109+b/9H/kLzlAz39eYvVqCdt512IoFFBJiepZH0Fy2XcvdSqW53s2IVTyGyrVPzFWCr28lLupXCu3IFiG/h7ugK2O3P4UMOtoPR5f7bq52W5LIyxfjm5A/Z5iTfxZPCLjkEUDJTz55y0ewxagLP9bcngKxZucoTaDIjbtUNh7R7MRaSyXpQxDr6EhAgEvS8LQ7Qs5x88W0df6K74ch23g1zFJDsABTqMm+5QDyZBoTsK40Q0A9ozAOFUbrnAbuMU8foHKzkVpnzEIBr2vu5HNA7xPOx+pF4ALFPJ1i2QT3z7EDCq0PmgA3CfpsBvYx64zXKnzKQHUZofi9sP4jmVKUbp1iq0YM8pKBn5EOtCVMhs+wSLrXVSJSd1DZyyb08UX3JLsodZuLD+dUef7kgCfeDyb+V2DGQarytFmzDA6ciTgCr5JcFjjW/QcJRqW95CQjE2jYhAbBqLSSCJxlV2KhGElneDm3KafunCUYhigGZ+d8ZdWzvPPbj93O0ahziedGwEoIgyitqepXLxFj4cbFPu9Rcti+T6uXMYlUkC0z8Ms8uz99HEppLXmdPbdFlIxCsNAQF94I+BAHjipvTM1BT9LOzrM+uG4W1BSaA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35079e55-660d-4c70-5e87-08daf2e21610
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 08:10:07.2423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8PBSKKfSPuz+AvtWfs95pk3qKlmYjsh5v6o959Detvms70OBLkKbjAz7u07UH3EyCZo8ZsX4TWVKr/l8EEvfLebpdxjqfPhb145E039ybgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5641
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
