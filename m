Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66806FCA91
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 17:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbjEIP4j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 11:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjEIP4g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 11:56:36 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E574F2D58
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 08:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683647793; x=1715183793;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=FROO93vjdYzM81jyBYEI95SwENnS04FTRDDgArxeUx9CIlzMbKaqdnyc
   eE+zYNqOfqHpcBaK70JidFKKOPQS6mjKoiG49ouEQXzO5ff3GHl3XXK4C
   i16EauBAgNNQtGlRROfA6F/iKWJ46I3EUEbd+IE2RZ5uQwqyFNTIncNGg
   82Q1k7VPJSWncSLH/kmmjfzT8TgA2dpxZ17hK5StGWE2PJ6syNgi+cqFb
   gZieo17OGao4M0hCo+rnImOq0HwSSjU9ltNC6ccuz3JueGuxxji2IAeaR
   ew9qajD9JpHNuIly0EkuULP8QGn6jRn4/SJXM81nf8lOQ7AuQkh0xd3rR
   w==;
X-IronPort-AV: E=Sophos;i="5.99,262,1677513600"; 
   d="scan'208";a="235220755"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 23:56:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJm/n2CQbj2uCo7dJHKakCiAWfg/BECS2pGkBrO4BaEntGMcqueHzhhgD5DDQZUDAxalptaGFqxHxdEDBIBdSnH+smD53sWAt9vQ+qjszbd2IAcqPcCwg4tQ+UBh7E1hofOk6390zt5OIS5bKqROQRqnQdcgaeWL5KDnHC9gnX95rLROR4foaoDVYPOlGF9FLcSAQHAle+nEUOy6ZcRUwhq/MMjr0BMYgLVIZecjV66lTi64TqaxN5AGhFiBrNz/4oFCMwUVJpDI3Z9dFy2l7SPWb09lMmTLVfuUC/+AZr28RIdbqKK7wfZLfXo8m8ff3OWuFk5Tj4Jkn2q6UXPWTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=c/m6r5wfVNFon0N+pGqfotrtPVmvVKW41eNefoTo3MWZ5OC5WIwaom+LX5P8/ZF1yS0ppbZmxCc9Zu1HtPmAsQXw/dUg78qhTXoC7Knz3TPASeooCestaMm5S4E3wHHro8pPRFSvKJUVYMI+FtmrubxsrmC7vLb6ZIL286GFtI3wuJMafgdrEncnN1uQGEWvoGJhmjD4PKXtXmnB+FUCRK2zdpRP7W5DuDghHoaM9ytuBuqOTsSpZXxBlXc9fxacp/YrtBzD2kx8LU93V+AnXQQkHIUHr0ybc2vdY0s5IzyDI5iRwmnVc+oAgrWn7hyGrq49XBXGVHAljZxk6jIyPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=cRG9eyJOhSO4LtZqeVIgM8NVGaazcMZYv3ZwoU29ZjBAZsn1+jyrB5VvaqDJ4fE5bW9MUPcJqs40SaNd+49LZf/qkskP3KMEAFKv7FXIBotUgbH6JTb8kjen+gFjizCogyU8jfH1VoJF19u6ApXZooiCLdElFc929aC5HuvYqPk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB7024.namprd04.prod.outlook.com (2603:10b6:208:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 15:56:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 15:56:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 21/21] btrfs: use btrfs_finish_ordered_extent to complete
 buffered writes
Thread-Topic: [PATCH 21/21] btrfs: use btrfs_finish_ordered_extent to complete
 buffered writes
Thread-Index: AQHZgceHTnlazOUXTU+WC6UT+AD0bq9SGhQA
Date:   Tue, 9 May 2023 15:56:30 +0000
Message-ID: <898100e9-4daa-ae32-86a9-26eda291853b@wdc.com>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-22-hch@lst.de>
In-Reply-To: <20230508160843.133013-22-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB7024:EE_
x-ms-office365-filtering-correlation-id: 6e949d94-01e9-469a-fddf-08db50a5f49e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ea6Xe0k/Am6PhgxEIkROGqclC4xH70iZwQZTf2MVZDuDagzMr+75tqOECH1HA9xDd/8fLVEF+jMMkAjnHZuQIhkq58tthm56XWvorx/qeHp3UVi6d6nzT5OgkHeGpzXH/2BX7d/3B8tGDjujkHmM7I4HHzWlcvxaCnXOL5PcZ1nGyyD9zq/yKXat8mGXVEMgajWdxcAuEgD2zop+fTHoxwHzjasm7rzcQJ0Id6C83acs5HoL4w1uE/KMKRiH4qfoDGk3HvzNVRKJ2LB4NwwgDpMa8vgsi4/Zx4wljx/pk7iKTbLC9lMbPoJVS/2vL62QKDbi1n6ajVN9SeB+4fYeVDNfU0mvyT9gwEoENTVWbSO4FZpNw7spCci65d/M04qiYhOVOeNmRZ3u/GM9AyZBSSfH28ZL0h/eF0jn98nITuiMbdwn9Nx2P7uKBpQkES1xxikoHNQWg/ijKSv6qNVVEIOeiZyMZNicOjYuU1/61m8zMZOZ0AlICdn2nXsj+Za4rHkuvY82yipTXb8CD2ZX7wLOEtXEBhQqW3A9/oPndxqdSkUFSkTdQ4Tjq064jaHtxGvQO4DP+2vF5BBW/mRNqrCv31SgpIrI1m5WMD05Pkm2Wl/ucWJ5lyXiohnWe3MlFapnfLkhZfjdTx4Zjs836dczkNJI+3HJzxYtZj4hIcO342jOlw+z9CizuNVOWNub
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(31686004)(558084003)(36756003)(122000001)(66556008)(38100700002)(2906002)(316002)(86362001)(8676002)(64756008)(76116006)(82960400001)(66946007)(4326008)(8936002)(5660300002)(66476007)(38070700005)(31696002)(66446008)(41300700001)(19618925003)(6506007)(4270600006)(6512007)(26005)(186003)(478600001)(110136005)(2616005)(71200400001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODFOSWprMW9WaE8rM2k3QlA2N3FXb2JaZVhNSkFuZE5UU29VdXN3d29UQTJo?=
 =?utf-8?B?bXl6b2twVi9BY2pkeTd6VjVzdnR3RUd4UTg3NU9odVBvR3ZiYmxqSDBISE5r?=
 =?utf-8?B?UFNJNy9DNmtpcGE5M1Jwd1FQNW9PbUJuek5kR01DRWVkUmF5NE0wVXpnMm5N?=
 =?utf-8?B?eGdwNUhUbldEU1ArNVo2UkI5Q251RE1RZVYzSFlEd3ZWTFY2WnZEYW5MY2tp?=
 =?utf-8?B?RDVjTTRwTEhNRkZRYUZmQVE1bkEra3VqaDBmdUhRUGJaT05RWHFjQk8rWEFt?=
 =?utf-8?B?MmhFbDdQWjJzSGlmS1FNL3YrZnhQb3djN0o1UkZyT1h4WUE2WndpN3lYc09i?=
 =?utf-8?B?ZU5CRDRMTlJvelhNeWJoNVJrd0NNcFRBOG56cmdtWUlRL1NleDAwOWNIVExM?=
 =?utf-8?B?ZElkRDdXcTBrSWlhRGtCdE8zWm1KS2FCY2JZUzVGK29BRG16cnlmakFtVERk?=
 =?utf-8?B?UUkyS1RzMHQyWnpFUnJYWDJpVzcwb1J4Yi9lMkxsa1VFSVRlL0RCUGpCZWpZ?=
 =?utf-8?B?NmxtYktJVWVVbk5jZWxEVy83a3ZUSS9Pcm54UEx2alRqN2dJb1pIcGJ2Q1Z6?=
 =?utf-8?B?VXZVeEVQUzNLYjU4SjJTeFhtSmovbnQwdmZKcU5RQ2R6NHI5UjJvUG9wSmlJ?=
 =?utf-8?B?NjdNZnUvSm4wZTU2NGptZXQzMDREZFRBNzN0T25oRkdOaisrWlhteGVLRGdj?=
 =?utf-8?B?T0g0dDJHdERxMnE0N1AzQ1FLM2IvK0RxeTJyelo5aDlqVmx5WXEvS2NtSUxF?=
 =?utf-8?B?N2E4eEJvREFuV1J1L2xWd0pOV1BiVkdCTGtEY0dvN25DMFdLOXpGTlNUekpN?=
 =?utf-8?B?M2FOUUdrMEREN0lHNFJlQmJhZzk4d3JOMncwd044RlpPRXZ5YVptMHhYek40?=
 =?utf-8?B?QldHQjQwbDNhTnNWRmpUUU5DLzdDcTdHNU10SkNtZGZYVnpON2hpVzFRSktV?=
 =?utf-8?B?czhyNjRqOE5FSTlZZXlraSt3azBWa3RsaGJYcGtpeFlqSEZ6anJiaTB6c0NO?=
 =?utf-8?B?MUhuUE9lbnhWYmdUV2lNWUc0WHlocnZaeFFWRDBFczd2SEFyaE1lbmI4K1lp?=
 =?utf-8?B?NVZuZGVicEhGWjBWbGRxRlN5RDJhS3BxWmFnallXZ0dpRkpOSEQvV09xSzJ2?=
 =?utf-8?B?RFJDeUdqbG9UM0FKUWhyZGphZW1oSFdBSFBYdnJYTFEwODdjVCt1MDcyR2dH?=
 =?utf-8?B?aXYwRnBhVndtaHZENWdGeElZQXRCSFlvejU4VFJTMEt0eFNVeVhMNm03Wm12?=
 =?utf-8?B?Mm4xcWtOUkpieHNqYkEvNW11TlZ1cXpBam95akc1cHZDUmZ1TWNjUGthTjdP?=
 =?utf-8?B?WkgvUjFDUnBRYlVnT0N3WElvUGM5S0p4TG95UXU5Tzk3WWNqRmxtVTRXTUxD?=
 =?utf-8?B?cEhOcFNXTkZsL1h5TXJzWFlPQ1VndHdYUDVwRmNOVkVBdyszVzFPMFpuSVdB?=
 =?utf-8?B?VE5uYmRLdVV3QzcxYkJ3a0pPTXVmM3hZMlA4Q2lCN0pnc200U3dGOHV0d05K?=
 =?utf-8?B?N0JNRVNtMjlsUFNqaTgwaTN3UVpwcXZ4SGpWdEZ0Y3JOSndwY2VDTFBsUDNy?=
 =?utf-8?B?MGtxUWR0VFpDWno0bzlxOFBINmtySXFvQ0tacXR0ejl2cU9VZU9kbGU5NEV5?=
 =?utf-8?B?MzBXdnpXN1VJSENrdHB0cEttNURzMlcybU96WGZBcENqeURFVE1qVzk5S2w5?=
 =?utf-8?B?bUswNEtNRGlIZ1dTWGxxWmV4RVpGTDZaMXZkeUh2NlJUK0o3N2FZRjc1VXpw?=
 =?utf-8?B?aUsxMnZ4dzNnYlJ4Und1TUFFdXhML0xKOHhkZWZBeWNyc3IwRW9Cd2N6MzJJ?=
 =?utf-8?B?aWtFUm1zL1VRZExmdGJOWndyelMyeEdHMWk0V3A2eXFRQU1tLzRDQlJGSzJH?=
 =?utf-8?B?QkJsKyt4bWNibjF0YWdseVo2SkxwRkxZMHhrWm9xdXVhZFRJN2U1OS9GL0ps?=
 =?utf-8?B?RzNBRDlwVTduNUIvdmE1M2RTK3BDalVFMmlmekFRSVk1MDljM3kvdXZOaFkr?=
 =?utf-8?B?dG5QYnl4VmNMT3E0WG5sdkZZMGRnd3hzNHIyVlFqdHU4c1g4RWpiQjdmbXFz?=
 =?utf-8?B?aDZBQld2OUxNRHNESlp4bG80ditrM0RRQ3ZlbzJFT1FYaXcvNWw2V3ltYy90?=
 =?utf-8?B?ZjBxb0VrekVQTERHeGRsZ2cyNzVvc3pTa0tydFpDaGQ3TVR5cThtQnlWVzZa?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE34B3F6AF165E4FB1BEEDB416EACB73@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jcjImCmMGYDeHVOeHTG3UrcwCHbq3+3yvROQJeJPP2kgSc1wamSANtR33eZB61Eg0/gOF/iE4Eegsb4Ajv02G+CTn0BQI0G23kpOjls3IflwIFKtHgAxbjQIvYkl8G8DU1gRsdawdEfeFOkMFOLSdg+BHBX2dLBJtWAiKYkM1enZ6ThI3x9IILLiCE1KJ2Fj6WAQECEg9aTz5gc4PPhiXINOJo4vgbZYJpk+fThrMuG1FHbFz9YLUtBIDVDBOFAo7vI1KuJJZ/6egsMfjLZK2OGNZwgIuuU3sG/2rz4ywb17m+RNG9MHFJthy/HrIvD0lEO4QK/glnux5Et8R+Vus8yzaGsXwUnY3yjf69P742/+tvRN5sfdIYAigafYl+WhniUgfnR5HynVXINLP/RoLYptBO5OPmN1lH0UqwgVbobk44EHbP3wIjrhfm8Dj9mguH0c+PBsw+CSYpLsmCWl94CXQC1A8ZisZWAnSmafbh7rRe6OWS5nSg2GMyzCMspP4YaqLr1gz6jCPQ7q/WZFMY7yMk84hMYz1TxDurxtN9Vz6bq16c4/bFJFHrOdnNESOlCEub3A48CpFilzIuO0Psrsr17zAjCMtphhhb+i2zog3aZ8KLQd/7YgNLUVEnjEjYx0lMm2qrObSlPmflpqkFqbBQ/GQechycZ9elbFKQcq1YI6cvKcCoQnd7odCrwBk6w9qZw1UE6eiO2C/GWZkBjf1jyikTKvLJK/ytJs3cSUyP7MmShLQwKNClGITbN/jnlZKwu9eZhYRsBWyWsNuBGV+ymLqi5mWHUwNYreNSgfoSPSB0IRd8pVGQLu8Hk451C2AIs72mNE+21/QKj7gsZI+qduFaaGnSqVZ3X0t2Z4mr2+GxwMNV5gimS+uj/S
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e949d94-01e9-469a-fddf-08db50a5f49e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 15:56:30.6769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iEiqk/9RvxksejNwFc7F36MU9FM/0YY+m8+7rM3sqSkN62V7rSfY3HLg+M+4XLUCQ2lV0r2RsbnevJOyFa5ywm4EGX/aoq5CIklglSOBTwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7024
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
