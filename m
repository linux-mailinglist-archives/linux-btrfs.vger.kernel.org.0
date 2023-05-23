Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F0970DA48
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjEWKUo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjEWKUn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:20:43 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C62294
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 03:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684837242; x=1716373242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=nbQeH4BJORIL6VZtL8WZ9KSWHmqFunk8EhKeocO7phFU/Rbd14GANDgB
   +1/tofssGPSspYurHjaT5uI/n3nnxZN2tApB/MoNWf6SCDhSvJlg2e9tP
   kamyU6Wtd1ahQ5yKVFPz7f6G0fem7QMm5fUCBtzwQtlP5duujjfd65txE
   hUN4F2rBzGIpfv4KXcNIWUuw9Pp/cx/EKlNiHVru9DGIDcuraCZ3f3lZp
   F0JwoDvRJducYl7gHSn2pBE6KGbt4XzU0vx7vgxkzUTXupTbbRLZ9ETyZ
   upx188831Mk9VYTXJ090LUdontcuBdC/QFKlLXWkOYHa2qkWfeAZwDl2+
   w==;
X-IronPort-AV: E=Sophos;i="6.00,185,1681142400"; 
   d="scan'208";a="229602097"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2023 18:20:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GB1dpJmylI6yOEZH+YhwxLrC4i7rqE7CkozH3WL7ISoJsE3FV5mAhveOu3Pe3J3V1iU/aHXdY5PXKbuwvIol6hD6kX9FE7wR20sIrQqfqfl3Ufqvvwq2MxZKC+VLfrBPIwqlcdxTM4asFj3Zu1YXYZnH64TK1C+u0+6RArPYGCFMx8708o2Lh2ahKEI19L0kFzor5D7be9Gq2wmnrTbLt5vumwLi0PmzBPPeIMfjHaYHY//OuysnMemEdotAwJX0pwqRKzBGvevIaxMriTWRzb9A6XalEBdu/Cb+dn6McGFzHJWeMVDMZxXsP6kCRfqq5Tecv/t/+dOrHuQ+4okBiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=MfRJvh4A2I4pmq1kRn+qVnY92WurmAHZUbXFl/FCvBxzufe7WzjoKthPn0ENTWZHc8BXnln5cQG8IVaEG2zZE/cigEaZys2Sy1ZxYebBEVTW0IU1OJq+3AgIaK9U0sOSCMs1DuaLSYiHlLv5hNy8A9OIeRwjmaBTEM0lPXykQE8xuBXYFnNtsFeKVuzTi5wMGAtrpNwkxHzjYepJy+WPkyrhEOwBndZyuVLrWRGpdBbv3l+y1alskTyM63ThFFGVR3q8HfYJI9W63I8Ee/pZgX05Ju1Am4IXTbkrpxz+IPMGnfxr3ELqvfe4AvWQ+Ke7GO88R4C6vFKPe7TgDhJa2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=O5pbPk3z61Qqrb+f/t3AsM/5s/EIJFErrhzv6vf5Rjlgksw6Tv781w4FH3TylMtH3v150AwZpsuFILKH94F6czjnbOYaxbJr6b7VqpWzc4nMhNp4xDEw4VBLNxOnUfbnbwVCTbRqUe73Ki51MZzt0gfi7YK89/Fj9a2FGzPWDkA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6762.namprd04.prod.outlook.com (2603:10b6:5:24f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:20:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:20:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: remove a pointless NULL check in
 btrfs_lookup_fs_root
Thread-Topic: [PATCH 3/3] btrfs: remove a pointless NULL check in
 btrfs_lookup_fs_root
Thread-Index: AQHZjVJ/JWcH+IRxyEaj1rMdXQBkuK9npcWA
Date:   Tue, 23 May 2023 10:20:34 +0000
Message-ID: <c31776b8-fa0c-28da-d18d-d757333e0316@wdc.com>
References: <20230523084020.336697-1-hch@lst.de>
 <20230523084020.336697-3-hch@lst.de>
In-Reply-To: <20230523084020.336697-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6762:EE_
x-ms-office365-filtering-correlation-id: b5a9fdf7-033a-464c-fef6-08db5b77582e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D3kzm3QtcYbPyjDstCbXtDiPHlWGEVucKw1Sf30vFEegGJyH1stVRkLYl2WEm8XKnD8IpWu/Ik5iuHzeu+/RW52orXr2GFfvkyn5vyiFYEsI9qjp9YzqpHYO7fAe03O0NadpKvfnayXqlgtOmj+azeh8POfCT34boOJIcaosKMH7zkala8YRou5qtfdWfi0eqEEQwFjNDtQWS4FBhQr60VNAfG1llAxQtSes1vebeDwiCZf7aqAdZOY3MmkDKfukJZ3iIM6EbKyVpW+EfsYhkWW3vKBNfcQM0k+/4zT7sH4Q1MEmOtszO04E+tUyj8yUihrZXN3PmmGS2omeQGzci3zh9EZ6uEjy8bA1kvmUpGRvyf58XfO4oL479muauRtzLD35xh+Q3/3k9/AS5oM6jaw8UEU4v+4UgvxpJK1R9K2hPAUvo+LazEgY/+exrgZmmIN6LJJBA3TO69srDkyxTNW5dGo7bC4yrmECfc3L40USiNvKR58Lh6pnh2a9GFyYlIC0UjSSPZYO4mBSK1QYPtHxV5eI7negi3nAnd24Vp2tzruJl093C9dAMLiEHAzLG4p39PoftbqbVEQwunBiytkwRix4UC7+0hUusa/I1UdSZBjYTTsQh/0LuYdLKG+UVTPnSfHNEaK9kRvmSA2DxulKb2IQJgX9IKp0kX6eC6rew91LwtrAZkW4ecm4XDdV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199021)(6486002)(41300700001)(31686004)(31696002)(478600001)(110136005)(316002)(71200400001)(91956017)(4326008)(76116006)(64756008)(66446008)(66556008)(66476007)(66946007)(86362001)(5660300002)(38070700005)(8936002)(8676002)(38100700002)(122000001)(82960400001)(6506007)(6512007)(558084003)(186003)(2906002)(4270600006)(2616005)(19618925003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHlGS1hITlE2Nm9rUkpHckp2Z2ZFVjFSa2pMUld6UXg5QmhsNTN6TTRCZDg0?=
 =?utf-8?B?eHdlZFY2aUZRWUNmaWZXUjIxc0VBaEVTTEpZZlpwL1BuQzQ1TGF3NlhEeDlQ?=
 =?utf-8?B?bExheXZPK3cwWWJENC9hNFRTRERRNzgxTTR3a2trNUNFMnVic09TMVp5aUZL?=
 =?utf-8?B?cVF5emRTS3UvMEdCNklXTEhYMWdscUFSdktCeXdpY0p4bUxMcG9lcktBSmlm?=
 =?utf-8?B?ekhxQ3JVYk4zSGtGOFl2NXFKT3A3TE80RFIxU0N6dXNhUldBSnh1ZzFmTUZ4?=
 =?utf-8?B?NDhPVzA5YmFjRklZdlNkb0JlRmErTnFZblVpN2lpL1BLc1NwMHdIYXpEeEhn?=
 =?utf-8?B?UW8zb0FWcHlCVWF2dnUzVDduT200WENIMmdXQlBzOXRMT1BmUXpweVVHSGtX?=
 =?utf-8?B?UTFyUEhpUGZmMHJaTUsrbEZNODNSalNWWDBFVis5dXhqVFlUeWl0K0VHYm1J?=
 =?utf-8?B?dEFIS0c0Sjh2MGdLTUxVY3F6NEZKQlNCcS9ZZFlKNHNEVWk1SlB3bWJraGpM?=
 =?utf-8?B?MmtvMEhBeU5BRThvczJiT0pyTE9KSGpySllxS2ZaditMc2ROTDk0RzV0U3NU?=
 =?utf-8?B?VWxONHU1N1A4dmt3QVc4ejUyeUdnYm1vUEU4akV5cEUydUQyT0F1eTZLV1BF?=
 =?utf-8?B?WGhVZ0hPRXAvc3dCc00yVDNZekgyb2VvK3YvS0Y1QVZUZ0thQU5KNEdwQ1gz?=
 =?utf-8?B?cS9QUEVWaHNSTmRtd216Ly9EYUtFWE1ZZEdHb0I0dzJnMS8xeGI0ZUlOQW9V?=
 =?utf-8?B?WXpZSkxJaC9nUFUyQmN5MUMzMUQrNVY5Wnd1KzRlR3U1bWZDZE1RUUo4WGY1?=
 =?utf-8?B?L1orWEhoeXVXODJJcjNSYkozYllvbWh2ZzFMcHd6VjU4eUVWYUloUWxYRFN0?=
 =?utf-8?B?WGduQ1Brdm1KRVV0L2dacC9aL3Z3aWw3Vk9hQzhHVzJodlhUZExVTmsydzhO?=
 =?utf-8?B?dUdmWlZ1Z3lwTW5wOHMwck12QUhMOEVnSllXRS9BcWEzVjhpNUpjZ2ZRSTlN?=
 =?utf-8?B?bWR2NjAwZHlGZWdLY25rZ3FUZ1dVMjF6K1dKSTcwUnFJc0NjejZlb0lUOXZy?=
 =?utf-8?B?bzI0dVVZYkJlZ05UbkxWaTZNMGc2QVc0aUs4Y3BZbDNGNmhSZWhSVTM5MXhn?=
 =?utf-8?B?MGh2ckNxNFdhRW1nRnJGa1VIVDgzNUt4R2ZNMHlmYWNYRjFmZmhkMzF4Znhh?=
 =?utf-8?B?S2hjRHRrY2Z5V1N3c0IrVDFUMVVEc1FwRURKYmlHWVU4YzhHeTFscmMrcFdV?=
 =?utf-8?B?MHMxUkZBV2VHNU50WFJ3WjRjdE94NEpTMlR1VjA2eHA1Umc5NzZYRkNOVHNk?=
 =?utf-8?B?am5yWWgyUURVU2R1MWxWMFMvWUNNb1dNVUZkaEVhWnh1TDBlMFljTEJOQndu?=
 =?utf-8?B?S2hIbTluS2xWaklMQ3BGTERvbEZwM01hcGxhTTRTendveUtNL1p4WVBWTllL?=
 =?utf-8?B?Z3Y5cExub1hGMFRTN2lKMTVlM3JpUmF6eVgxN2VCTWlSSUpmVld0SjZ5Ui9Z?=
 =?utf-8?B?L1hWa3RrbWxhYzBJSXF3ZVlBd3JXU2xpV2VnTWd1VVNVZkNENk8yOWVNV3lt?=
 =?utf-8?B?UXM3ZXhOeTlTdEV1SEVKemlvY2Q0UkRWOGhWZTVvdUFqaVpzUTBlZUk5dnIx?=
 =?utf-8?B?VXBuMG04UFZLOUQ1YmhjUTV1cW15NnNiZ0c4ay81NTVzNmxHdXdhYWsxR1lR?=
 =?utf-8?B?Zkl2clVlOCs2SzB2eFRyQ2cwMlVKd3hzS25FMllMT2JyMnVYR3gwLzFiQ1RZ?=
 =?utf-8?B?RFB1WkhRdzRkRDF6SEp2ZndqNERGczBMczJqeE1BdWdibkgyY21GakV5WTg3?=
 =?utf-8?B?YnZuR3lKaVhwUS9PR0xiTEtwb1pnVlBpa245SXh2cE5vVHFVdDZOTmNMNGxy?=
 =?utf-8?B?V1BqL01UVnhOd1E0eC9vYVIybWhua01wZlZDa3FycHRlUHRyaHF2TGx3OG52?=
 =?utf-8?B?Rktid3UwR3FJT2dJcWtFWnA1a2tZRk4wR1dSRks2YW0vRjhvekg4TmJsQkN5?=
 =?utf-8?B?NFYvTXdCSXVVWFpMT1FJS2dtUUdEOVYvbHc2YWp2Ly9TMm9HdDdTY0k0c0tw?=
 =?utf-8?B?d0F6OWxFTTNqditvVTd2ZXdFSmpzcnVLUGZTc0lGUVp3TGVzKy8zOEF4cC9N?=
 =?utf-8?B?Z3pHRzM5K3NtcjBSenEvVW9ieGJKSUJxWVdqNFQ2eGJzYWtjSE55ZjFtUGRi?=
 =?utf-8?B?cGRYREx5YmlqKzBFTWlMeTZYcEVsSUdTWitEeFYvajhURU5pMjJiOFBlZ01H?=
 =?utf-8?B?NmRhckZUdzBQNlYyMFNGK0pxTkV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA32AF8D6A1FC342973A4F3BF06CE118@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 65+Nzl1U0JtLLjVAes0WZoGZq9KZWVXl22KXJVZvT1+Ih9a0aeK5I98XJJDJivAhjhRcLhfakCWy8rx44fITkvNz09VTP/BvufD/PxOdFcysS20UeOJyWxzPDLVTqNnlDcrUcLY1s7Pbf2+SsumVtgbAp1VXMPb7sxsBUH8KZ+qmAHeWtigRtFlFiuIkDZQoHyxl4ka50IWvzItdZIfE2iYsxtGJZz9tC5b45v+bHN0BxFe0Ekyjx1oxoYjEv/p1ZzMrWzFuSvlb+/r5OyvvE6PluHdwxdyP8B/7m9ZD39BzuScXVAkNSuyJM4ZRalzX8YDPZiM3tkgUZsX/sowZzPSrHZ9sB/+G+C3+N6cYj0ILFtelxYIAsvi8x5m7ihqX+KpTjK0qF6+oi1xVevzQn8/CAxiFcq9sCYznlgjZCKpKBsBwOD1FuiXFssopIUf0OVkFz4hMaRru+HGaAxScnnl1dpKnFt9/Tv1lgIOyHFo0f41Tec8kcCtr/dMOtds7s9NU+lPvkIZHxGm2chNHLWUpLTmd62zbmUawHub/4oTNTWlWR4miiE4YxXtpqib4uRNiwIlGGAGZ1FXpqVn2FwVKb0cSs3TVVlB3jTfU+xDiunRPBFwqftayNOqFeA5Iqss0gkuyES4u2PuaX/S7XCAq3lPH5V1yzXTmg54aRTPh+HpStZn/X4tD7pQkOcojeG/hQEFgLHb62ewpiy9dX6pJcQ027dU8tdiUCgbIQC/YipbJkH0EGF+ZBLKg3chhEmVVmDORmyHnXALXjsEUbgKo+WQDEUO7Tnjzsx6hM1MCzsr1Ezb4Wki5gTU/iQrzdM5vDKm/A/2aISGVz3n/BY5KkjVOowfwVF8CMpVOOJre4Q05/R8xPxvCDVmgcFqe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a9fdf7-033a-464c-fef6-08db5b77582e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 10:20:34.1555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: al8/jW8entU1ULHAj0JVDySG7LYWcpmYyHrUNiixrxftuSsk50weL7XSLq27rs1HO7r7daK25gzxmil8xk2F2VQxurBE570OT3PzcIHGUeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6762
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
