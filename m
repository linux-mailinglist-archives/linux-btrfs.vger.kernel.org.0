Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339C06C315C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 13:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjCUMSk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 08:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjCUMSj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 08:18:39 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502BF32CC7
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 05:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679401118; x=1710937118;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=mZNOTVHSmY8E5ZgdR/nCiEOGdLij+X60TaungPqagV482JUK/OW67yhd
   Vrqzp6UbTfFhy53axaY7Pc1l4FdzjRLIxVvWbTcF+X5Wpt+QSXNqof8aA
   RDxxdpgV9m/PHh7xR88dMhAGnDM4JRGC2CbErMZNfUMdimpGm96WVZOna
   pMjjPI6mPHEH3mT7PzuJc4w2H8a7bO8E8UTneWTueCbEpiTaDDiahxb/X
   8FVbF1zDNxjunfUkamsHUm0WPsPr3qczWV9id1ZateGYArWxqSQ6bHh4c
   sILAPAekOmpufWm5XK2xO6745gNL5j0gd1dY+tsgoyp+m28wq+Jj4Cnor
   w==;
X-IronPort-AV: E=Sophos;i="5.98,278,1673884800"; 
   d="scan'208";a="224419408"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2023 20:18:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3FqKAj0mDzxdOe8MhqCHsBRZB5Nwk0yJV6isHXLENSQrdSiNBgVvPm5F9sbX7dIMdCinT/H8uqxnoAf8dV273IrXPz82o+TFJ6saREYpBuHQ96iIB/gTgwTf+5QBXfeJH7Q6AydVce8NhccHq/qTu2dCx1bj77lCV52zNagsZSY8ekef90HRj2WY8ioXww/+8EPW0syxwuKuGiTdDtlspFn9YFZuZIqJaqnZQJaUqXt8Z5FPpsla0kLZXiZaO+hdYJN55cc7aw81mPSCD73xKK1k/jKhUiQutvDJ8K2BbG3lvFFTq56MrmEiHDJduq89yv1XRTbcoy8v0t4KEpUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=CsYqPhaFZmO6NyvxY8x20AkbdTu4vmqa45CnxFzm2y3xwi5YdnNRJTMv7oHcngXflZUVeOJSJDv9tuzg8CBOCTncSarXqaLxJxLfcYfveT3HkHWIsjsQDLFiBTamdZE0DwY7ZvySmJHybcf4ltFY1WN4uGDlkCB+qT5/JlYf01rFdWe4n0FM+btDwbl6Nf1Q+9qEVcgYbyGQwW3vIMyQ9urkGlORjqriaVEsAO/nZSGAUdeAsteBvpiuHJOZ2dC2Ux9HppD1GgQHWM3HPQcJLaX6Bj6/0sAU6xdiSwwbIMVzAlNQIAZeSn3UTsrhK7Yfclxw/wZ33cfws4iEeFwTZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=f3wBwXccmhhBKYxK9sEprisP1caJDE9IWFZI8jE9xaG2Jnda6UaGxyTm8hZTuh7yhlNP2Yd9QRYmF98INs9fURVmbspKl6/Lj/zwABLLUBlnjmtCTP+ZqpyDLueeSY3eU4Nmsyeac1h3F4YyELz4OZN3wxHrlwoP8qP2cUHkAZI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7882.namprd04.prod.outlook.com (2603:10b6:510:ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 12:18:36 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 12:18:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/24] btrfs: pass a bool size update argument to
 btrfs_block_rsv_add_bytes()
Thread-Topic: [PATCH 02/24] btrfs: pass a bool size update argument to
 btrfs_block_rsv_add_bytes()
Thread-Index: AQHZW+ZVoDxrddI4TkyTmgVra7nwI68FJreA
Date:   Tue, 21 Mar 2023 12:18:36 +0000
Message-ID: <686c0012-2115-be4d-119e-15dac778686b@wdc.com>
References: <cover.1679326426.git.fdmanana@suse.com>
 <4e7abf7599f8d809dbdd5f9f25f376fcd1ed83f2.1679326429.git.fdmanana@suse.com>
In-Reply-To: <4e7abf7599f8d809dbdd5f9f25f376fcd1ed83f2.1679326429.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7882:EE_
x-ms-office365-filtering-correlation-id: 32740468-5b97-4799-f954-08db2a06654b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9MsCBKgQLOYCzSOheZwsEXjDa8290S2BU32ydzQcXZ5szMInPNpQs93QKBjYSmcF6kqvGtyRZjmrAedTwXcxxnUAoX6bkQH8e0j+VrWf78pgpiQFj8UDt6hTu6XE3e24OCfOlXDCp+3HIy+Ipjssz/Z1QNTrAURPHrWKyL9WTzUKCruaSi+EADh78jhLnGNoOZBlOqgLkgWtMg+Hv6+I7+mvujQqKr3wwsd105/ucgE0UfSo7AcbnvttKZd6xr2J2Imw+Xe965gtnaaLrfE+M83Z7F5q0ByqY2GPILpa0t6C1F2P5I6LmDDTBBvRzkBN78W5DT6Sh9duoxgcNYbSyGkOoOKgtTAXI1zC9nzVoiQ0GR2mUUpWVMZoTiGLvE1/XljhR2CBw2Ww52dz3F6rK3ZTGsuwth/eFAZarRWiRDylFwPlR3XH5cwJW8C4JdlYZw1S0Ct7p4HdVF0Ew0DZgrb+C/RQ/BJi4+LrKJWR82SfpKqqg65gbntjpsUHH+EgMoMxdBBsALEghgbdBxqMSfixQwOiUAi1Oah6Z52ih/UF2MX1hjbwOijGXGsq9l2JoDdRREMx0qau9lHZYFsJkrZiwfGBXZBDp3yQPmV6dzDrEHZ0vKGqOaUFKX6H3TOiaGSLBkE1QBlB6qqHA6AkQT+9Mh4nw0NiYEDxJHJiv0YMV/g/l6Vl5JyFjR++XnclYekvvklDlUxCJnr/XYT4YlHl5JoS9/HusoJ3Cfn1FRvUpwYUWfEJEix63OIliUcY3eYTj554usogqQSzqjW55A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199018)(86362001)(38100700002)(19618925003)(31696002)(71200400001)(122000001)(558084003)(8936002)(66556008)(110136005)(316002)(76116006)(36756003)(66946007)(91956017)(66446008)(8676002)(41300700001)(66476007)(64756008)(5660300002)(478600001)(2906002)(82960400001)(31686004)(186003)(2616005)(38070700005)(6512007)(6506007)(4270600006)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RER2LzRJa1hjK0Jjc0lWNFVsaE9RNmFmWitxYzVvdlpBb2pCS1F5YjRoMmpS?=
 =?utf-8?B?WGorR3FVeUpQbk0rV2paeFlmSlE1eG5TQmpXZmMvbWhwYTBROFJGMVp0dmdF?=
 =?utf-8?B?Q1BKNzZMT1BNT09udkZGK3E2dVZjSldoM1RzamtPT0lRVVpYMFJnMExGUTRR?=
 =?utf-8?B?eWdDTG9Jd1hGeTNCMGdYTWU2VGNSeW9NYVdkVlZkSnp1a2dGcWJXTnFuR1Js?=
 =?utf-8?B?cFV5SHhJbGJHeHREOWRmMTUreTBDTWhZTW1VSXhSS0hyL3laNzZEWWh5TmRo?=
 =?utf-8?B?OEw2R1liK3JXUUpXQ0ZUcUovaVhQTEQ3S2JhNUkzcmV1MmFZSnRVeTN4Nyto?=
 =?utf-8?B?aENDbUpiY2xRY2VWcWl0U3FNaXE4cXRxYzlVcHhHZ1lHQjN2V29GaTRXaE16?=
 =?utf-8?B?QXQrY0IyK2xQaXhiLzUrN0tqbDI2RTlRbjNTd0JLVjYvc2w2TGE1VXpTb1Z2?=
 =?utf-8?B?NjIwZVpYZm1yS3ZvcmVKV1lwQXcrL0RVelBCdHRTcWsyRUREc3l2aW1JYTA5?=
 =?utf-8?B?anlqOWlRRFBrTVVrcmxuWXNUTyszUWk1R0FLMnEzRGlYUFdWS29nd25aZUFm?=
 =?utf-8?B?Q2ZTQ1BGNWx5YVpTeFBqUEE0ajhTcURyRm9QSnNPRGw0MTVPZGlBZmEvZGZr?=
 =?utf-8?B?dzcyRy9ZSDVPSDN4a0dUZG1GMm9VNGJpM3FWTWRnSmNiVzFrelR6THhpWms1?=
 =?utf-8?B?Nm85WWJrY1JwaTB2ZzJLSWhNb3lpNnJyVFRWVXJMcm5CeGI1MVl1WmlDQm5u?=
 =?utf-8?B?c0VqbTVhc0o0VVdDM25hcU1kN0k1N1BIM1N0Z056OThkQisrM3JzZm42MGxj?=
 =?utf-8?B?dTFkSmd0dEN5QzRDU3pnclQxS1Y4Z1l2aHU4eVYwVWJSWWdNVXVVM3E3dEZY?=
 =?utf-8?B?eENvb3lPWE03OTQyMGErWDVUR0JRNlBvNWlMOG03c241R2ZMOUdZRjZ0N3Yv?=
 =?utf-8?B?WkI2VENHZGJ0bE1iR2VLcXUzck13bGFOYTM0MjZOKytTbGFuZ2VBaVE4Wk9x?=
 =?utf-8?B?dlBHZVJHRUZKVDZYclFVOFlvV2R4RVRCNUdVYXorb05EblRzTDRkcnc3TnpV?=
 =?utf-8?B?N3AxVlR6bklnNk1zMmM4SXRtK3NvOUd2SzdFMkkzSXc5N0VVeHc3dlVDMWta?=
 =?utf-8?B?WGhSRER0VFdiWjUxTENmNEVuV1A3V1FsUmtRNG5XWkZIdWIxdHRuVjhXQ1ZF?=
 =?utf-8?B?V1Z0cnFoMjBPbGxVUS9hL3k5TTMvNTVpQ0RMV0M1cThjYVpBN1hQZk9WMGY1?=
 =?utf-8?B?bkY4UEJ5MEZYN0pWb3JLbHBySURzZkpZZ2JpWlhhUUtabkN5NEZzbHlsZUNz?=
 =?utf-8?B?cXFxYzBDVUE4SEhVeU5laHlKenJ5SFh1Qk8wTW5BTXNlRzQ4REJ2dUlkUVJD?=
 =?utf-8?B?Q3dzeGNJditCKzhrSlkzbXJYQjVDcEY5VWpOdUtiMHp4UFpDVXRiWHJSMnhz?=
 =?utf-8?B?eXQxWldWZFAybzNiQ0tQSEJiSlpFdlVReVg0VjltRmk5MDVRRjVBNkE3SjZ4?=
 =?utf-8?B?ZTZLcGQ5cElSTGxuQnRGd0tCN2hHejY1MTJSRnN5NVFUUzFLdTkxZ3FwZzV1?=
 =?utf-8?B?SXlaVVF2cVlQcC9zMWRVYW1BWG1NZVdXbUR0VWhiVXBLWWo2d0gySFViZ3d5?=
 =?utf-8?B?TlYwRy9mV0FDeVRER2dlNDhrQTFwNlY2dkoyeUNQMUVQTUo3czZLdFlSeEVv?=
 =?utf-8?B?Z01ZWWU5M2h5VERHZjh0dGdQcGhSL3JDcXNsSkc2NE9iYS9aWEE1b3BrUUZL?=
 =?utf-8?B?Tkhrc09WRWJpQVFYem0vUWo2VUJSVDY5clVNMXplZVJHRXh3SFV4NU9QeXYv?=
 =?utf-8?B?UjVuc3k0UXc1T3lzcWJwQWFVYjhxM2lkK1FpZXAwdGE2bytlbDlnSlNmQTdR?=
 =?utf-8?B?UXFGNzlMUUYwdlAzc3dMalE4K1N3RnZHcHRQZWlSSC9KMHVWdXk0QWxJdktw?=
 =?utf-8?B?bXNvQmZZVzdpdjkwRDdCT0c0TUtnTG1paUNwMnBXSk0ydE1xb3JWVDZ6UnVB?=
 =?utf-8?B?cGR4b1RDRWlGaTd3VTRFNFNCbEo3ZHRrOVZGR2U1TTN2cHhvMFBCWkxnaXo5?=
 =?utf-8?B?TXFncUM4LzFWTDBneWJRdWV1WC83TzdXZnVxWitKM3BNR2huVDZGVU9ucFJx?=
 =?utf-8?B?Y3JBaDZWTHBIWkNOeHV6YlBjSVVzMGllWFZkeDVCa1dYMHJsQ3c4UDN5TGxY?=
 =?utf-8?B?WEplMDhFb2w3ck8yY254aWFHcFcwOE14TjRrSE80UnVSQlB5eUFnWW0xSHE3?=
 =?utf-8?B?T1lockhUTzh2TmtHWkMwQzlUMHlBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <986D64419709174EA792A7CB0A2A05C2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FHmrRdaUcijJOOgYwqD+L2hvJ1Tc/56mDGnFutwiUK80Fkx7zqFnUMYrx+KnXseGuPHMtEJefPBFSDwuHFpfyJc4ZC7b3bPlxL4xIibppu33poYxVY7+pGCplrWEIXVHAydAaECVtM2bgajpGvat8HMmW9WR1NMzG6syxv1mycpi0lfOLdI0wV907pOeHNpSn334xCWK7E/Bt/n1THYDRF93wSjJLuFftXr+2OVWIB7ruXekoviQ9Vc84OT+BzjAY/Yzv9vYbdIfi/NB2G78D+rdZ/18sSZmiiTFDHqdiimXmzHSTBGOnGj1/kIe0f2J8zy5ZxjaMH9hjywWk3tMJaCvy9iC+NUrvr2qjboJ1AnrermD6hMyoP+lPTogRJOgglMio68CiTwHg++hJHVKyYpBA93w1IEzAtcBuhYLqaYAzt2u58Hr3YRFizc1yIcSHfvjwWVy5v3W99nGWnpQot0oZ8Z8PGqrckfBe/9MFGVSqhTRdA4ujYg3/DsF5B5P2Skl7mSMnq8nNUPUzJSY/Yp7+k5A2OANBZTatQhbkCBQi1Grqen3/uxQw3JzTAorq4XlZRTNTJ7fWMso0lmEtN0WM1i5ps6vina5nvN0nCg+3EBXQt2uKVgEpKXk+geq3cfvKSlqBP06pKilLI1FoGU6TUo3gOI6nvIrCFAGu94gBJLD2kGCZM4qUoALdIsTK4JvYrDHBZe1TbuRqP4Mdqf2TEt2IFPriOXebEgATcZBLvrYpQElyYRhTQ4GOKaYwRNozsu5uoNV3fcaxN69evS+8yjU5MQ86U3AeTlWohk9nuplyO5ijvHWxcWNNUmF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32740468-5b97-4799-f954-08db2a06654b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 12:18:36.0392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vB3xGUnoB5TeD6Kdrb//oTbAjv2vLpJ5UqaSNtPJ8W26PiR7sIEwnewxX4+hihSPSPtehn+lDqCeV4dEBH+dXZScikEjpaU9iKUxT1L5/F0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7882
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
