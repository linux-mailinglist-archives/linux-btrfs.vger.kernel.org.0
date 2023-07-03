Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6759C745B05
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 13:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjGCL1I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 07:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjGCL1H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 07:27:07 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD6FC1
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 04:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688383625; x=1719919625;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=fUmjFdEMhclJplWoxVqqE9+ZRTj8tpX1286Eog79kmsDCC2MfCCCJ9su
   kA7Xj9pC+SOq1awRqHqVxDYfdPP4GYIQZx7PVQzuh2uGZMKKwQlHd8cSc
   U/izpCcxJ2dfl4nTyBvCqMcuXjNTpd88QHVK54kcusya5aojhTVnRAF4g
   QGMEicaBmR/yJlKNsxQyAxcxSIzt0kbbW7EWkTUtamtuy5FKF0dD0rdAd
   /bIypcEaVWsjf+Epv80tG0VhWiQ72lai5DlhuMoWM3JfN/oOtLBluZo7Y
   GyWzZqKh9U7Vu4cFqhBhrdbYzFRmfieuBkqhGtrPry6O1YAG9AuIH7ym5
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,178,1684771200"; 
   d="scan'208";a="235473675"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2023 19:27:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2lGPszLPWCiH0kQACaWkE6mKNKUfVu+yTyrtGuDU9MxMubXZ2cB3CWVXcS47i5g5Cz2RNdvE95gBlkz4dZ8VUndmL7VcFTuOLhRYG1q9Z1NwQv/iRhRwGUb1xuX0RAu2eybkzfJ14TbuZduUZN5X1L2dGNTLuo98UXoV2zNAbyoG/6oyaxdDzLgFFex53sYO0FVktzR4kwqTD/OZ5HVhaIU0jevkBQ95W/WXKERWJ9OIp/GNuql7iecKlEuRP23kshSVWe/P4hp0OimnzZrGtUlmaO2yPiQXGuJwq9JxLCDAaNHcBsRNYxrPuIBhiaELm7leePr1RLTzs6bbNcT/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=nhq5NOVTkyzCcACYs2NqdltsdSIvVKafQr1J5v+iOrk/H/M6Mk6pkaUMU92YlDtYsIXoOokwMfaaIl1k8JGdlD9G0Kg2ayBTd8Gvo1R76GT353HTs7waC4yr+lxqv8JuV0ApTDj1uam4sk7d8Z1DN8weo62vsTD8/vDxexdiURdvAFJCIiRwfpjy2k3f4ZaUnfSrHalGUMAt86xANDJbpFdu5p374MKhV48xUGcsu26IHs0ssK8U+B+rz+iIbRqJTKOV+D5a4UzPRpw5oNlpE7YSmC1/wqWC3chZfaJr/VNq9KljKu0B6KkmzP4zsOGRVee9n8VugLW+oQydWx1mOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=MF2ECWtu1QlIVwwaMfuTifZE8v6KeAzhOAjbl15WKXNeXgBoo0A9lBdkNt8MwEvrn36clt6l1TCD13QTPKxPPHdK1w1eyomSMgoOHSbC16rej3sf2HDqfZjBtyHhLnI4ZqlEIv3iNikvxb/74XhFMJO+jMflQoxqcxOIboVen/s=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7498.namprd04.prod.outlook.com (2603:10b6:806:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 11:27:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 11:27:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix leak after finding block group with super
 blocks on zoned fs
Thread-Topic: [PATCH] btrfs: fix leak after finding block group with super
 blocks on zoned fs
Thread-Index: AQHZrZ4CW47WEmPIhkKXga3YmPaHaa+n51cA
Date:   Mon, 3 Jul 2023 11:27:02 +0000
Message-ID: <5b4d19b3-d082-1b0e-764a-280681bfd77b@wdc.com>
References: <92dbe59fdd79544067340f09449e6fdda0902ff5.1688382073.git.fdmanana@suse.com>
In-Reply-To: <92dbe59fdd79544067340f09449e6fdda0902ff5.1688382073.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7498:EE_
x-ms-office365-filtering-correlation-id: 3fe837fe-a5fb-4f91-37ab-08db7bb86c47
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cfWiBaG+onOGb5X6pRmxbMlo48GWLtHdZU/cJXeFA/OeX/PTMCZyWZIAUIfst3JP+eJ1bFZIvnAO9Be5PTi9F1+S6yeBNHdFholxtE4LYrvDAvWp8+/MV6je8JnjXXaXDaMt+ePKrldEWusshBxl6YvmUtWuwCxPfEhi0WSzzSkkwfOwygbtHeGT0nfHV7h1ofvJ8wxYry6hat8hH73OTpQ24tld8S0tqK7GjGwlz+HZsydYk5UJCmO1t5BAfOX6pZ0p8uwqJAO96uUrRdQLqrk5PxGnqVPCL5D9dq7thkqPzYW756tf7ijbMQT4w7fStqcNHm46iXCnvZj/nm2bdobQ0FTaKGcKLyVZMSWye0Bj2/NNrRCyb5edOwfoejpHrFjCESWLd/JMVhjTRtcZ7SoZH0z3LrTkqrhCJCFonKJDGOP+WJrw4c6y9eJVqeEJry2yPwyDQbwZaC26J5cThnfKnDva5gBAmua3Y0Yr7WQG5n687ofJp0YHX4yYQQfrglQ9fATbsRGI+hyrtPJVifn/e9gcL8PbaT4/q0ex7iBpVsIT+KBk2q9wgxt8J0WsSZ1/Y/OvJLdzDCY4ycp3rrlylglgmTm0rVO6+nBU/O7Z+wXmwR3QiUPrFaxA5p83hiSrvpEOPgl7TgHMSi5sNfX2nUCelNdr0A/RLve7TNgIPrpDd6TKJ1EteK9Ti7fY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(316002)(8936002)(38070700005)(41300700001)(19618925003)(8676002)(110136005)(122000001)(38100700002)(66946007)(66556008)(86362001)(66476007)(82960400001)(76116006)(91956017)(64756008)(36756003)(186003)(6512007)(66446008)(6486002)(31696002)(478600001)(5660300002)(6506007)(2906002)(31686004)(71200400001)(4270600006)(2616005)(558084003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T254YUN6ZVRPNStUaUJsVlJxYVVPSTNvcjJWMzlKM0NIOE9ZSlkvcCtzNU1y?=
 =?utf-8?B?SWdwUDArSnB6VlZ6a0ZDMWpXVGEvVFBhbkMvTWU5TDFXRTdrTXRFbDhHR25V?=
 =?utf-8?B?ajRWd2ZLQTJWRVlnWWU2RVJDYnViOWE1TWkxQzhndGpOUjQ0dlI0WS9kUU1V?=
 =?utf-8?B?eEFDWGJ3SkNaOGNGamdBKzd1K1NEMFEwMS9FTDVVMDRUR2ZRV00zNXpHbWsx?=
 =?utf-8?B?UWVhM1pVeFowSlhUemhseXZ0THE4Wk12c1JLazdPdllwOUhrWFhpMkZmZ0dy?=
 =?utf-8?B?d3B0VWthcjg2K3c3OGN6UlVCbjM5Z2lGQ2F0MHlBdVpSUmUwUDh6SUlVS2Z1?=
 =?utf-8?B?ZDJWRDNLVTZSUkJYYWlWVWp3MExNdFUyOTdWOUpTZTJRdUJ0M3ZUOUNMU1pT?=
 =?utf-8?B?dC9abGt3dHQydm9YMG1zRm9lOTFQYmlRTjFLaWtNZ3Y3YmlMazFab3hjWHF5?=
 =?utf-8?B?QTEwWUdOVVdneU1DbmdjWGFKdnFCN3ZyeE4vTUt1Uy9mS1pEcndEdU45ZzlS?=
 =?utf-8?B?M3N0d1FUOVMxR3dDTFN2RFpPM3R0QTJoWTM2WGtyUmhjVGwzSmEyOG40SVJ0?=
 =?utf-8?B?aFlZaWxwWmRveFlVNEt0SU84cFY5SUdIaUQ5Z045bjRTdmQ0OVB1WDlHbkI5?=
 =?utf-8?B?bytwejNkZThFREZ3Myt6NzJuNVIyNkhXQi9HdDFENjR5eElNcjJ0UnViNXpM?=
 =?utf-8?B?cmRtVEMxQmxkdjNUQzhBS1BUMXIyZVA1bXNxOXNBc3AxN3J3UU5ZUWNPY2lQ?=
 =?utf-8?B?RnJCekpaTk9uK2tQM0hWSTF6S0dQb0RIdjhDY0RPcU1iOWFnMkkvWTMxS0lz?=
 =?utf-8?B?eGRKbTVYOXB2MVFuS0tNWjR3Z1lYMzNGOVgxS29SQkVnM2pqUURCYnJzaklD?=
 =?utf-8?B?RW1yL3VhNllhVmZxSEhCU1owU2hRRmcvOEJja05WcDhPNDZWU3hwS0E5TmtM?=
 =?utf-8?B?eitwQW4zTFFuc2JkK0FESi9MZi91TkpzQi9XOXBFQ1drQmZ0K3BNcHRJWTB2?=
 =?utf-8?B?Z091K1Q4cHpFRU5MODBZV3hiaTYxbmZXd05oc0prdERBTjFpb1Jydk14NENJ?=
 =?utf-8?B?NDNoNGJSYkNQc0E3OGJkYW1HWDdwT3VuQjd4bVZNVnhxOHRmWnNjOHZJM2Jm?=
 =?utf-8?B?am5ONWFKMVVpRUUzaUszSjdiSU91WWg2dTQ2OXhBZVVzbzRLRGx6UzdUTGlX?=
 =?utf-8?B?eUFoSEJRTWpqMWVJQStiUWxLci9Ua1hJZ3F0MkRGM0lKenQyMFlJU2lEdE85?=
 =?utf-8?B?QVBuWkl2QmhkRHE3TEdRWnZTRUpvU1U2V2s2dlB1dnVVVVdzUDF5cmhHLzJN?=
 =?utf-8?B?SDJqYk9VWkZPUFNvVVJOa3U2Vyt0aFd0Mm5CMEZ6YmVzMEkzUWZUcnZFc29E?=
 =?utf-8?B?aUxoOEhmYlhSWk9nTWd3K1cyV2ZmRlJwK2Y0cjJYNDNZUHhlWGxLbldORGky?=
 =?utf-8?B?cXBUY3E2V2U1NzdHUURuTzNSeWQvOXlmaG1GQlFiWkxEbUFPb2Eyd0tCUUMy?=
 =?utf-8?B?RWtSbGs1NG1ycE94aGxHcjdtZUdDSE82M0EyNHM5eXRFbDUwV1FFNWZNOTBa?=
 =?utf-8?B?L0dhVEpOaFZabzhzRVZDbzRIb1BxVkdwS1J2MmE4ZEh1Q0FpMS85a0tOSk05?=
 =?utf-8?B?UXRhNHlhTVNURzFiUjdNTnBtdG5POG5HRXprV1NySWdIOGsvUWVVSWgwN0NH?=
 =?utf-8?B?T2M2aStqcHAzU3BQbyszUlJGczN4SFlDVWg5STJNbEJDeGVKcWlnVHNxa0FC?=
 =?utf-8?B?RHR6SnNFWWQvNEs3c2x1R3V4ZTdZZVFISkhiU3FlSll6U1JmTnVZUGFJV2xy?=
 =?utf-8?B?emxyOTBSZHVtc0FTMzA4SFBsTUlWWk9RM3dBRzFkSFRMdGt6ZFNoSjU5RW45?=
 =?utf-8?B?b0I2MlpHeHlPVE9WOGVGNm1KZFhETEtzbHBVRzBHclZUSnVFdVlOUDQ5TGxs?=
 =?utf-8?B?S0pIa2ZxYVl1ZjZrdlN4cVQvRmV4S3BDT085Qk5wYko2Q08wSEhmVzlEWDZW?=
 =?utf-8?B?bXphbXZIQStwTk1WRmRtV0MvVXVkMjhHcjA3MTZqQ3Q1bmNJUmtOM1VrRmcy?=
 =?utf-8?B?TC94dDhjOHFsTXh4VlIzV2diT1Q3NjMzc2RvN0Y2SCtGcTVHN0ZxMndpZU51?=
 =?utf-8?B?eUJpTW8yRGE0eDc1K3d1TWxHdVAyUzdabjhaSkhuSVgyd0RQcitMRVNhNFJU?=
 =?utf-8?B?eGxrYWhXRUdFVjNvdFA4RmhrSS9tYU9wd0hkNkFDZnhJbnBVYXRZLzJOdW9T?=
 =?utf-8?B?OGc1WjFycTFYdm9qZncvMklZZmFRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BED8077BD351B4EB979A70656E3BA58@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lq/ruqGRjUkM9WzgHHS2dwoWR0RzN4KgkePAxH4CjKP0Ygp9FXwNidotdOFvAAXifP82AuUWDYd1J6QGVP6NUGZuhiT561Z9sCC4riCf/vnV8hO4AxIrld+RmFsaVTySTsRT2Y9In7bolnI1oa/UQTioNBkX1AlQeV2w72Jcu6DcaXNWwjIG7vstIPjDBimbePixlvSscxH56hpFnT6QdlV5G5LqYeFR1bLNd3oqPW+38J2DDQRNuvx8d/Lp0kGGK0z4KCe6/TneUX/yrXTvm2v3X0Mq+FefYBimrpFlXtcmAnEsZXy9e6KPWuoO+sQvApWuEqk3PG4JekiIQWMHxXNkAbL7QSkXlA+7l1X9nFE/wJP7v7y0kSI4iaJim6D4nWQCHb3nvFlmQjJBuW0W/YXn0tGKjKsKvgW3zMkIoUkpBD8AY/6JLkTGPXNn9/GZNBrSR6R3GgdMRr1JAN7GZV/bP+O+Z9xZX6Xvz374j4f+j4JV3fogqmff7ukc/4LRvPTrHs0Yyca+k+Vo+9HkismLDvu0jjUdU+zsTdxjfrPOLwkbDUuOLMuUuO/lX83D1k3ig/rYha+aKnpEFbhyP6eEOZcYaWl9hU+PykKR5VUj7RqLSrZCFjlsgdUVKYh/87CdH3SLxym5GrQIH3JWCaNbtw3pxspEh0CN53rXmidxLRsg4SXpjdO3ywyH2DAfedEysgwV7OWuQwfwM9kQgEoXKmNNdNKyLGHvIVgmm0IsAXcr1KhLI344MWRiLIjSIJ2i2xovFA35CSzAiX/VKUxtOOUeuwOcb5lcrGKQqZjIbbd6KhLYENiWrh4PqTLe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe837fe-a5fb-4f91-37ab-08db7bb86c47
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 11:27:02.3258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rkk4mU/jVXCqEOsy8MWqXn83uQfkRkhrpmSzBVw39BPprC/xWaOBUpYua4JvnH+47km9bqcqs/lS2VXPgmkzDRshk7D5/4E9IN+lYU+95i0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7498
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
