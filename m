Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBD9649E54
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 13:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiLLMBN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 07:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiLLMBL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 07:01:11 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619965F8F
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 04:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670846470; x=1702382470;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=m5IJpaSgjjnF/wvTpac1lim49emFAtChFlzvNOt/XLU3T7q+prlHBnlg
   e/Q82ZTwcIix+KbwxoguyxcEhJ7TaSgrlp+0yCxC/KGHmG2Uz67mWslUD
   8FNexZ/FLcvmz3JqZFOVfXOy9u04x0j2xOr9kHgoCXIsrE9nqnjjNDrzx
   VAFrolyL4X0s90RpFrOHThoBC6aQ7bAA2yW4Rw2Cz80g49t7a5ShvMeWe
   BKMcX0RmGNyxNL/be3brEqf1kld2/4GzKuiSkJfI09s6GoLCRdKKre5Gt
   LFr4lco95M1bkznjI3gySjduS2X2SNBoXDVmw3K5u9vAv9aSL7En+oxQn
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,238,1665417600"; 
   d="scan'208";a="218438113"
Received: from mail-dm3nam02lp2044.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.44])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2022 20:01:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZybgsGaDUu5Z8y/nAYZXrK//r9aDq8ivG5wCMLczsUJ2XFMWzaLlFuNVZ5C9YSAskfqNmGeuHFYnTtj6Efwv818bPPJ9c9GKmKffnbiqvh9lAT9JYKppadzMOIQ85Dg193Z3wfe3+ioVAak2g2uMuYEUlfjw4M0covrRLEnzygae0pvjlKByLHzssfXyujKBzbHeBxYRJ6oUXWBlcrXQrdjcOz7XgLY2AIke+iwO8X6c75iIz01mOT2+qCDNGTVtwbs7sErQJIZXuGKdEv5g4PLyl/wHkPiJHNtswvIRDSPvBup9qUGokWyi7lufsGszjbVRtOza6SQaOmuq4wnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Oko6rduVRHLkyx8iIsgeMkcRDM2AqOg4ioVqQFHNGO7BrjJSCk/Wgk3aTR3Yp6kmhs0//RQuFwwdUa7RCtnDFWPAqt0Gd0YXmEiBUxEaRv7Gg/SXSOS+c+PnFaV34C4G94qAo3Iq/ha0yvrMU0Jo9Ygnfx6DFDMPvUlekKbGM0g4yk8bsAOcWiHLFxglUEwmSqcMpYmcOE7Nn/N4f63JJLENVXhdHhzLUvBVrr05HWy1LbSrK+OmaYpHN3wJ2jGhj4ftRMjvZBgnA8gHv+szRS1ciQI+JO6/ixoAbKkDUdREfGpD9RSSC3zJ4Z/76ltL8YEItaGXHFleuG4QihKPbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=sjaxUEwjdsxYX/CEMv8/VA8oauXD67r82C2RZL3btSeEmLU2u38091H4PmX6VCXz6KixbZMAgl2fCd6iw+RZhb3nmjQF+rPdVB8cT1sPwV9yDSEAsFesK+RjV9StTtmhZooCOEguCEqOOyhRT02TJBaPAa6JEGTZfHgiIrh7Dlw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB0827.namprd04.prod.outlook.com (2603:10b6:3:f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 12:01:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f66f:ab77:6874:af4b%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 12:01:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/7] btrfs: pass a btrfs_bio to btrfs_use_append
Thread-Topic: [PATCH 4/7] btrfs: pass a btrfs_bio to btrfs_use_append
Thread-Index: AQHZDfyqIqVlTdUol0O3pkvMVPGXCa5qJtoA
Date:   Mon, 12 Dec 2022 12:01:06 +0000
Message-ID: <9a99c988-98db-5d99-8a08-a0ad1c047cab@wdc.com>
References: <20221212073724.12637-1-hch@lst.de>
 <20221212073724.12637-5-hch@lst.de>
In-Reply-To: <20221212073724.12637-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM5PR04MB0827:EE_
x-ms-office365-filtering-correlation-id: 8b271f7a-407e-4c05-13a0-08dadc388d22
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BDnETbO8OeWzcf5VfOYukAg1Bc5qOCvGAT7YBXjkPAYxHdIy5kmJhrRuDzkMSujBIHWUDAkYUPpKvq5Q/5uGHiR5w59C59O6NLjAQJZwSSl7cYVufAJ2UsqmRzfgFXFvbvqb9KLkIdKjbPqeze7Za8HFd3pWE7gtE7sFG40RGEbt1enaGKWpkYMo+79pFn+S+p5wZop5nVL7IdulEVSVoRvAoMnEtZK3ktzgN7uSfI1XxnWjtJkfIu54k/EVTxU0CG882kZPQLNnOT375O0cC414IXra1nCSvSey2Ptylnr/cJKwrIV1E3x2MvoZjvpPOl6hCe2s4r6m4Kwx3cjNh4kjIGTUqh6DEv4jF0a7pY1ga6DGMcO8zW6RdPrP8nDan0NtTmbwD8UK4P8p2ZAqawjxqayKozpGna7JIfy9j+lczMTSlT1UY3x49iGy06Ab4CygxrnfDFmlrkWgm/gdpE6cvuOkgm2mmH+w+5toFSto1qnIHGP56J0b6rsi711aV8RNKOkWEx+qZODdkrW/DzwmPB9Kjfm60wZTO2T5SicsTrrIj+rzGCotJjKw1QdGa2/63Tl5jAjo1c+joqQEg9jxBEtQwfvuZuM1sN5NSnw+BVF2PI8ljzkqOWUxBtKRZ6rSC5jpW+cTgLf7QuTc2eGmt8Tm/muBeqS6K4DFnPROX0Uh4lDumto8rAyubgmKIp7302UTBOQjj3xLeY+wMZbtxupmWqgS1FyHzvkpv+rFLvDbplYLhC3YrpYM22sSE0DuKD45ynYvlYWJ+6ecWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(91956017)(31686004)(36756003)(558084003)(38070700005)(31696002)(86362001)(82960400001)(186003)(38100700002)(478600001)(4270600006)(6512007)(6506007)(71200400001)(122000001)(6486002)(2616005)(316002)(110136005)(41300700001)(64756008)(19618925003)(4326008)(66446008)(8936002)(5660300002)(8676002)(2906002)(66556008)(66476007)(54906003)(76116006)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDJWeUp4MllMM1JLZkYxd25NV1lyRmIyTTdrWVB4aEsxMDF5RXRkQUxhaXdk?=
 =?utf-8?B?M0t0QVR6bVhNckh1dWVzOGg1dDFNekNKcytUeTYxTnk0VkR4amVPYkJLMCtW?=
 =?utf-8?B?aHdOc3E3SnNjaTlpanJRUUZjZjBDN21PaldpajZuMXBTQXlqZEg0OWs0WGsr?=
 =?utf-8?B?U0NYeWxxNEpqVi8vS3hyQk4vREJmRVhyQWJzNDk5RjI3a2pzSmNId25jUFhh?=
 =?utf-8?B?cmJjeWZrOHBFVmNyZ2dJSGNVZ1lpM3Nsd0hUaEkrOGEyM1hIWTFueE9BZGd0?=
 =?utf-8?B?NFFLcm1QUnZYZkM2TlNXTThoVFRiS1RUdjV6aHRnaXJxVTZlVjZRajJVamY2?=
 =?utf-8?B?L0dHbEhqdjB3SDJDd3k2VUUxVzB3a093K0g3RE9HbEFibW91a1ZmWXQ2QzBm?=
 =?utf-8?B?bzd4anNQcjlRSDJKK0p1MlYrdlV4WjNiOUFpYnZXTjY3RlI1SmhRVXlpaFRG?=
 =?utf-8?B?SnU0ZnY0Q1RoTG9hR3llMERjUjdSTkZwdEVCMGRHRkF1SllVRHRuWFpTeXlO?=
 =?utf-8?B?QldiZXRmQWdkYmRFandvY0dpWjVRaHE1WFgycEhXaXFUMlBEZ2xNQ1lvb0F0?=
 =?utf-8?B?czYwZDNnOERMR2UxRWdGWDByOWU1WEs4MkhtVy9lY1Y4YkExNjBrVVFFV2No?=
 =?utf-8?B?V0h3U3p0bXlSWGpJUFp4TDc1VTZsSGVYaEZRVEg3VmpVSWw5MVlrYVY2MG1a?=
 =?utf-8?B?ZkMwOEx5WlNQSElBSTdZN0pMNkZkTW03WnNMb3B1OUdrSXdNcjIySkt0NDVH?=
 =?utf-8?B?dHJYS0tubEVJNXlHUzY3QWhjSnJVYnV1L2JkYTJ4NTB0aWowbThPV1RTa3Nm?=
 =?utf-8?B?N2MzblpHT3RnQk1PbThmRytiU05DeTJvZG5WSkI5SkpTY3pJZC9ydW9NeDlW?=
 =?utf-8?B?dFU4YjAvQ09zcGs0bzYvM09JekxLRnMza0tUUC83YVlyZlFLcWFuRitrdzho?=
 =?utf-8?B?aytIQlN5NExMZzUrK0dIZEhJcXBubHU2c0pKN1VLTVEzbjdkZFl6OXlQYTVT?=
 =?utf-8?B?NnpjQUtTVnZVWUJMWTZOeGplbC90ZTBYZDVoNVA3UyszTUdnMkZyYzB5eWJ0?=
 =?utf-8?B?dFlPTUE4S2JXd1pUN0l2am5oMnVId3hKUnZSUHNySTZQaWxxcE1jY2ZhWGV4?=
 =?utf-8?B?czQ4NFM5QlRJdWxEclJzd3IrN1d4Q1JpSVU5Z2JQL0hJa1lqN3pGM0UwTEhl?=
 =?utf-8?B?eDdjMjVjNGEvbEJFdXAvOGsrOWNDT0ZnSEd5UHREYm90eEdqUzMvb0dEcEZL?=
 =?utf-8?B?Y1VQdTVBUGtyOUVTckFEdlJmUndDY0NINXdCbWMvOEltSjBCU1hFWEpoZTZT?=
 =?utf-8?B?cmtqR3BTcGlSRnpwZUp0azg2eWxRN1daaGttTTVHc0w4K3FBMy9sSmN5dnU2?=
 =?utf-8?B?N1hZbkNCRGNpMHhCc1BLenlQMjVtaHU2M0I1NHFKSC85RFdTTUkrYkNyYUMy?=
 =?utf-8?B?dFBqZlVjL051WDRRd2E0TktLaTF6UjNlVWk1TWEvTForSTJvZzZ0bkwrUnZi?=
 =?utf-8?B?NEt5MUE2UHAxd3N3MVlOM2xDVEx3VnBlelhMRHFlckJ3dDR6aWpHY1JMZXNn?=
 =?utf-8?B?Nk4rUFBOd1dTdU9vckxqZEVoMGo2UEkrNmRKTWpLdkw3OFZoVG1vSEJlS0I5?=
 =?utf-8?B?YjZlTlB0OHVxMkpqUzJBdEplSzdzWFBCZmk5VkdDWHBZQXNwQ2tlbkNiZ1Bj?=
 =?utf-8?B?QmJjaVh4M20yaEY0YnZaTVROYkNKYUJuUC9odWVGOHBtRTQ1U2t2UllDSWtN?=
 =?utf-8?B?NDAyVDM5ZW9wY2hrZ1QreDhGZkpJcmZSNGVURnVkMy9uSS9iSU5GcGF0T1JN?=
 =?utf-8?B?Q1lCNjVPWk1IVmpoWm4vT2ZGZ3ZjMG5hc2VvY09RUmRCWURPU1pVSGQzN2dp?=
 =?utf-8?B?d2labTNoZ213TGljeTUxKy9zU2JBcXZaQk1VSStFdVFsSVQ5Q21LbDJ0SGoy?=
 =?utf-8?B?cGNSelpMUUhlMGlNaXpEOTZrdTVmOWtCaFIySXFCaHBySXZlbXYvaUM1eGNq?=
 =?utf-8?B?aVUwK2x6QmN5eHZSZnpHamt3VlZXNytBY3RUUHNVUi8zMUVXMVl4WDNKMUJ2?=
 =?utf-8?B?dXhyY1RZQnQyTTA1TWJFZGF1Q3pNTTJ5TGhITk5XdVFZUGJsRjVLdDJNdlpP?=
 =?utf-8?B?U0VDZkRzeklXd2hEbjBvYVJmRGY1SmN3a3BuTHIyT1ZRbFR0T2JESktkcGdl?=
 =?utf-8?B?NGtIeTM1MUpFNFRILzZGcTZpcWJHVTFKbXNaaWFHUzFiRFVIbDhvWWhCTExN?=
 =?utf-8?Q?EKF38VBV6Z+34NEjGuCZVbsWDGeBwwnmyCxVTz3L+g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E3D23A15E704C419C8B4AA2ACB7F78D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b271f7a-407e-4c05-13a0-08dadc388d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 12:01:07.0290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rTSnAlpuctQv1ouz0QsWQfbY5KOtuvJpn9YInyp/VVso+e/eiMHAv6r2eOleOgax78shQn/nQhnajwigFlRbzIsr3Yv69u0vQeCUZAsS44c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0827
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
