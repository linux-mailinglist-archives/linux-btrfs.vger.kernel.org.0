Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D4D633B9B
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Nov 2022 12:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbiKVLmg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Nov 2022 06:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbiKVLmN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Nov 2022 06:42:13 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9105F54B0B
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Nov 2022 03:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669117193; x=1700653193;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DNm3+gqB41AbjGam6IA2JeZCrygZxPiBKODDHAI0Ojw=;
  b=dRcRtWlFKUslbkAd+vrXfxi47dsbQ2Uv9ytvf6c5SrjQCQZldc6/G7a/
   DNBk+pt0BSx5MUeGPcNGtGRJA2BR+8qhRMZTnXUNAPrjPvITzMaSPASP1
   7m+WhFRdIhwUGfSOtlzsP2FInh4cHEN9Vd4/c3urfdRiyffNVZdf4LLEi
   tDDm1h4aG13TSNo5BOZyv25ZxUhZdFtNHFO9cAbQ+1QFewuD9+p27AshD
   5TIlUvOJXkDP4k0SbJzbhWSauRgaEgPss+AMCtpY23Vi4fdOiw+o/dUtU
   g/m+3mhStVtg8lSZtuK71U34NNmDTb4Fic42CbDvRgUZA7IWxR3dtR7Bw
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665417600"; 
   d="scan'208";a="328987878"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2022 19:39:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQ0Ws014rU9l3c6XR7qqBJerb49WmQxN9LHEx3OsWl92C95pEYC2qi/ZQEmXukFA/ei3d+FW7l9sgZyHOnZ0OUNBS+KQ/NCiF9mLta1TgJl79Q7MIf56cOnJRU9uIMlpH9vZnzZIzghmIFEQX7ly00DKBhLJDwqI8kySM23dotX3fzkJrDz5OWz4ptm4B68FjVd660IDTibfkFsEtlka/RWjAHfbpJWkJbs7wxCgXk7wzaFA3w0v4j9c/BAuvJBOw2q4uLmSIgeCqkUJ8cjpozVlDrFncTQzTbN5GreysP6OvXP6CRWdcHBF2lJb23/5p0c6JSMCJqnYs3szGxqa7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNm3+gqB41AbjGam6IA2JeZCrygZxPiBKODDHAI0Ojw=;
 b=HboXWe5AKwv3yIoYQR7bHIlFDmMkxGVy6tPKW7+hTjd96hL1Ejqb71TxVEyNeLhKAerzw1+WYvQIkqM3kQrZEVuhxOFSa+tyV7+XNQ94qU2XBnF/nyCPiK+Nk3YBZSACWwRQR28NI/PNYPVe7z1IuE55k9OTbBiKQdYY/wB1HmYBP1YMNWGv4mKCVxVCCLKRHjSFDDSGK2gaO/+YTcOQGvSaag83L3s3D8TphoEbUe7d2IUvoF+lbbDy/w3Huhk6do0R33eRk9vUaLK8AZaDKmYk3heTsUKYZ/IDNVIuKvfNIky11Oa0LyUMvfQV6D157DtNpv1Nde6/+gG4wE8veQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNm3+gqB41AbjGam6IA2JeZCrygZxPiBKODDHAI0Ojw=;
 b=jLDdyHQIs6R+F4dlMtqnfcNdm0Ks1A14VtbaEvqB0qqveY7vL0uESX8/5tkmaAL/oaf66591gckGcqOYzYEEPhCiZhmaSHMgwrh/+EHW0/fDMrOXSQ6buREB8HhdIn9Oge4IWXusdQYaiuMAFkIhNrCByrSsit0vicScOhbBK48=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB8054.namprd04.prod.outlook.com (2603:10b6:5:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 11:39:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a%7]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 11:39:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: don't read the disk superblock for zoned
 devices in btrfs_scratch_superblocks
Thread-Topic: [PATCH 1/2] btrfs: don't read the disk superblock for zoned
 devices in btrfs_scratch_superblocks
Thread-Index: AQHY/dF2+W6nzBY5eEOQx7yrd0ZGc65K0p6A
Date:   Tue, 22 Nov 2022 11:39:50 +0000
Message-ID: <245fef19-0ced-6b8c-0a92-6fa50a9071b8@wdc.com>
References: <20221121174749.387407-1-hch@lst.de>
 <20221121174749.387407-2-hch@lst.de>
In-Reply-To: <20221121174749.387407-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB8054:EE_
x-ms-office365-filtering-correlation-id: 49c5930e-add4-4168-f520-08dacc7e43f0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TgDO3eg9PIVAFr4m+tG7S4w6PcungIZjfWeYXZN3B/TyoPWRenalkIiNWjSpPqP2du4+BLvbfv4wXxQRoGaVkVLNjy+8q/nBph5WCHJY/pMfagWzZGbFxJoNpPiut05R7/mxsdJF2HMLDDHx32/YLtFpBWF/wfkisraBTgM4TP3k89Et5F5UDXNMgTYBi14UWPP6R3bRhcji3nFMgXtDjEy9EI/MJvNw97HLgsdybLUFszKOQCqPDL9EfXJ94GVdTlui5UKZdQ6X95fACHZcHZbdYNbG9Y1DF/P4nJyogTCaxWvWuK6RDQhkPonPqqq93CRJ1iGaGth+C6D8wneYHVN9zGieTbUoEnSJKoPZu6FicaB+mlNSgg3F+k8eqEVlXR8CsdJIiJGxNFX17Dx9Vt+ZJXNOYgPdKpZYTsuoxu6MhM1xoeuS5opfADoflZZ/lgdM8jrIjS1NURq1VHNXEZSHjPkQh8B5eKfJjHOz+8COp/6AIiMg+qp8ctrYt+LC0ORWvru2YaB+/JOjHta/wdHq4bDS9I4lAoWqLboUOtw6B8SKExMLEBVm5lXfHigdsQ4JvfZXBk2mCBkpSLVhglYmJhHHZswBXMJ94RnjPXufGFGBb3vqWmjYJXn96K3I+XohM/hBaAYKBprYv1N9QZA1THOUcdfvrdxLlIi5vUxzTk9o9iDcRUMGjFNlQtbKsoroKBZZbNd0L1BZmK6C86yOFedUgpeVVIJ7Sa+4+jyiUtvjUyzP1w1jgS3WkMrslvZDVxfg4LTn+P4qUqcFZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199015)(83380400001)(38100700002)(38070700005)(86362001)(8676002)(2906002)(31696002)(82960400001)(122000001)(8936002)(4326008)(66476007)(64756008)(316002)(41300700001)(66446008)(5660300002)(66556008)(53546011)(6506007)(71200400001)(6512007)(186003)(110136005)(2616005)(76116006)(66946007)(91956017)(478600001)(6486002)(31686004)(558084003)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uit5UWw5cEpyWENjSGFSWEdLbjk3M3F6UDA5WFFGa3pXaWRyU090alhtMUgy?=
 =?utf-8?B?a0JBeTZNVHFMTWZtUUM0UDd6MjkwQmRsU2xIdWdhUU9RcUd4MTU2S3R3Smhz?=
 =?utf-8?B?eWVyTmxXTUxXOUJ0MUxncWM4K0pUWEdLSElNN3FTcUVRMHdva2RjVUY2Ujdo?=
 =?utf-8?B?L0x3dURXU0k1MVUxWDYrUitJbDZ5MHFSbk5oc0NDR0x5NzV5eUJSYlA4b1o0?=
 =?utf-8?B?YWUzZEJ3dkhoRG5vd2V6TW10d0UzQUVSZjlEMERTSnUrTkVJKzljM0ZxYVFX?=
 =?utf-8?B?VTJ5Rlg3SjI0a2ZyWnc3dHpGMXlGa2xOYU5yd2N6L2dMVTZWdk4vTWh3UkRw?=
 =?utf-8?B?UUE2M0hXanpzWWo3S2xvam9VVUhuRjRaQ1V4SFdiNjJrYUk1bzgzaytyMXFI?=
 =?utf-8?B?S2pmSE5kWldsK016c1JodjVEZ1NRYzhmWEV1cFpMSGdmUDB1SnptV2ZOTHFL?=
 =?utf-8?B?aVBkVDl0TDNZckNyY25UekhVbE15aG1qeSsrMHFhMm1nTVQrZFYzOVM4YWlj?=
 =?utf-8?B?VUY5amhqMTdmeEtRM1MrZUgydnNHOXppcGFrdHJxeDFMeEF5ODZSMnlMK1Bx?=
 =?utf-8?B?ZHdPK2JMNzZIVnVOVTRYRHNiMWZNdXlNdFI2dWV2NmtaWFVia3hPdjV6UG80?=
 =?utf-8?B?dXhWUkZsNHNSa0JEUEJFelJFaWlqVGxSUkJzdDdUbWl5QXBzVjdyQWJVR2No?=
 =?utf-8?B?WXlvRUdBN0U2RG9GTnRGRStNZWdBZUszQmNxVDdpVzNDMHJIOVlqUVNhVXFK?=
 =?utf-8?B?THJBdURyUGtjRjJxck9jSXFZem50emlLWnprWTFHUlZHMnZtQ0xTNGZ5RGZY?=
 =?utf-8?B?RXl3Q0hDM3U5QVc4Tlk4c3dKcFJMTFdKeEw1OU9jZldONmJLcFNEb0sxRUZs?=
 =?utf-8?B?enlLZXo3Sjc0QVltVFBTcWFTL0RJaDlNcCtMekhOR0pCYStPT1JMenBHUm0x?=
 =?utf-8?B?TmRkdnkwa0tIczFJWEg2RlBCTmdYd3RaNXhqcDNhY2xqc3RoREdPZy9KVXRU?=
 =?utf-8?B?bWlOVXRENzNsYlRhWXNpbml4dHRRd1IzdmJBa3EvS3lINWVsRUh4OWNuNG15?=
 =?utf-8?B?aXk5WVJ6TlM4RGNqM3ZGSGVOc0hqdGU5VVhJMEhSTktTQUd5N1ZxVVFKNDho?=
 =?utf-8?B?dEtHSWdYUzdRTG5xblpjZkJIZmF3OVUvNmhaRjVoZnMrMEdtSnNzckNWcTIv?=
 =?utf-8?B?UEUvb3FIWG80SlZ3Z3lVOFd3TTBRcWNNa2xIaHlZV21ON2tvR3JNZTkrRWl0?=
 =?utf-8?B?TnpzK3VISnVqOUJYRFpHUkFkRG9hdXBmR0Q2K09XM0hiSSttYkljeUxDdHoz?=
 =?utf-8?B?VmlmajdIVlQraEd1cDZNSTNCNmE0RDJIYk5BSVFIRFpKWGVQNnlLUE80VE1n?=
 =?utf-8?B?czZzQTVVc2lZQmY0czVzZW5pTTJyTnVBSHhTS2dlSElqUktka09QYlZSK1Zj?=
 =?utf-8?B?WWdSQjRmVjFmejhuc2VTbVI4aVRGYTg5U3NzV0crY2pnS3lBQ1pIL2k5czky?=
 =?utf-8?B?amU2ZWhuNVcwQ1Q3L3FCSkZsV3hXdzNiY0kwTWsvMzhYbWtZeThKcE94eWpr?=
 =?utf-8?B?NVBaMmF0aUJtNmpRQXlqc3BxeGlDQUZUOHRka3VqS0FWOUpDUjFHVnExQVo0?=
 =?utf-8?B?ODBLaktCbU9TUWhXUHlHT2FPb0FIc2hlMDV0d1RvMlV3dk9pVzlqaDhzMGdJ?=
 =?utf-8?B?dXd3LzZkTHpCUnR4aG5iaUZhMHVtU2kyekxvMTQvcnJLa21LNXJSVHVja3FI?=
 =?utf-8?B?OEgxT3U1ei9xTjlLM2phR0FSUnNlZTZpbzY4cVRmS1B2YUJMOEhUVkpsRUNX?=
 =?utf-8?B?bkhqQXNFd2xDRW43UDNQZEZhNldtT0VRanYzUVFiYWJJSWxkOWhDU0haaDhh?=
 =?utf-8?B?cXdQdmJxZCs2L2pJcEFsdEt5bEg2RWNNbEtXaDF2L01peGlSUzhxc1g0L0NF?=
 =?utf-8?B?N09DZFBFU1UvZW03UjlLWUlHdTBvNExBa09CZ1ovdG1mWjUrZ28yNDRYRk15?=
 =?utf-8?B?WlczSVh1WktHL2svT2ppZlRYR0ZGSitYZCt3NGk4S01WZFJwbC9sZU9KZTcr?=
 =?utf-8?B?SGpVYUhGT2VydnFtdlI1cnlGVVIvcWgrb3ZyeHVscGhpaEVNL3NYZjYvVDNy?=
 =?utf-8?B?Q1U4RkZYQThMK2ZGdHZxVDFUR0tDK21VclpMR3g0L2dnRm5NRzgzU1VaTyta?=
 =?utf-8?B?M0dwRnd6V2VDUEhjMDQzNHRYZmF2OGN0aXhqSkY5TFlWQ3FtUTFTOU1MU3dk?=
 =?utf-8?B?TVpiSmc2TFhrazNCNmcwZlpGWDR3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E099E6B303AF4439E7277930EFE3688@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vcWqa2oTwF9185J2sLvrm52SgmQooXsHcNeKAInCMXCdP6UF/z7bOj+pbp2uHtSEFguwkIUyLtPMv0haRus9LBrlczFztjhAJRHtaK2DsRX0sphIQhXEFuWFK1KLuLilgCEOw0sy3iNfkUiuoN63RKG3fwFymTl5HeQ11QD8USPYGuLB1uAGUR3FRH9mxUWNAkMn9UO3lF0b3nP7tQA4517xYvipVQ7tLLYSworgmgO77vGWYjZu2IGR7J7D4/++PJZzly6FdeTIXvUmN9AbpIApJMWNpigh70IZWc7UsA6NWWBCLWpbbCsDNCA5fUHiBa2xYZch99Ii9NNHWw5IFGXg47wrVTJyDyxAE824fcrFmw0iUR32jY+ahnkZk8PQHc+NlPySfKa+dLTOexYaUrSPY0v8PYV3OJ/uWQXCHxpE2973oCcVHNvFr7QkBFx3tDQpz6PVT2VYNdoXqtaBkQKpynR7KY0+D6+lq0k4SwnHZeNyZEjT2yqQNlWznWxnForAWIyig60ZFUozt7n324w7f23LbyDRnfg32dvBdHb5fFJp6Ft80QHeedPpUHLxttwLOsrrT/p7iHk7dF9hQukHZ0W4tFuXNexKMT4guSbVhMBTYxHb0o2wwwPTsnJh+nKSlmjnXeEl3V5ZiX1ot/Xb1ScJJbDP6xYQ27O3z+pCtksT274R6ZqC+HpjXGL3sLv5VzcaQVfUHMBhuBmk/4iXPiVw334r8BrA7E3u/hFymFmWsqH6hELnLFnbemktZzpTxzMoLZ122IBzUSMXXGDM/5T2UNpNbf5dCsmuK8WyahXsC2iKdbLMlLsZkpuOYMy8hgqWjHa9H2G6T4ZS5G3cfwrwc5xbe+vT25WuD5LY+MlMKGD6BDzY1NXjVzr3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c5930e-add4-4168-f520-08dacc7e43f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 11:39:50.3532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DAnnTbERmQnlvJ7lAfjngS16gY1L/HtbQpZtXze2DywXG/IuIEhc1VusGYIBWbhZnxtGMHcq3GEF5qvMtxy8bJY78bmqZlqtCM7JozZQ3Kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8054
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjEuMTEuMjIgMTg6NDgsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBTcGxpdCB0aGUg
Y29kZSB0byByZWFkLCB6ZXJvIGFuZCB3cml0ZSB0aGUgc3VwZXJibG9jayBmb3IgY29udmVudGlv
bg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnZlbnRp
b25hbCB+Xg0KDQpPdGhlcndpc2UsDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxq
b2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==
