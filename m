Return-Path: <linux-btrfs+bounces-2152-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8A484B25B
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 11:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77E1BB26252
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 10:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDEB12E1E0;
	Tue,  6 Feb 2024 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Gvz/kcYb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aPmU8rnc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7712DDB3;
	Tue,  6 Feb 2024 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214700; cv=fail; b=nNGIOXWAoTpwPH1HE5th51I0p8s4cflBa1gUXhYw2Hc2IH7qPUC6oCThKQ6auy0KQ6MPu0e3WihTfDu6aglUwtgLL7pM89OlC5QbHBWUouduKiocT0ZfQxVeisLdHgF+m27pGZXVEEKDMPG8SNiAqqiNcVmEqRsGZNz7CjL1QXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214700; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qwgjrqz7pzzj75yCk5GKn+OxGmscJYMhtBIdq7JXHv3Hzz/O84xBu7xLRBMEQ70QJ6iyxj6gAyKzwj85KWplDN5IdN3ykKwrtAuHmCrWpcRMli34w2XiThi92VIVDf8+zV2aKbU9uZspr4ShivUIfMWPUURPxwuoVnw86UQse98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Gvz/kcYb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=aPmU8rnc; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707214698; x=1738750698;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=Gvz/kcYbabMtdcSgx0J0xazGcW7cUG1i3FLnvpoCDaPu03+bxARx/It5
   z+UYj+musFGE15KogooIPw36zrGDDgerqbNv0oPVVU5j/avp8BdAvQbra
   cp4YIMwo82nuBmoJD7gKwC9QMtCOeokvHzfqRds4OeH8mIe6nfx9ZEMEZ
   TOEXIPbKUAnX/+RhAyJW7pjN3yI6P7dr4sOoYrpKj9c+YUdOVEvrbsarh
   BTUk1tjwXwrefaofPF2BK8buiAJVlIileKRIUokqlh6I9PpOMOp6aZNIL
   dAKfVIfiBrvA7es41Muq55shegSUz3edoqDiXYkg+i1G3a/J85afL14YK
   Q==;
X-CSE-ConnectionGUID: eCVO/dU9Skm0O+ca1KBJZQ==
X-CSE-MsgGUID: 8fUOw209TbqjAWZt4QLqYg==
X-IronPort-AV: E=Sophos;i="6.05,246,1701100800"; 
   d="scan'208";a="8850917"
Received: from mail-westusazlp17011010.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.10])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2024 18:18:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d531AcveL9NxqyX+E27js0tTzUfv6GMF+Oihi4ApETzbpnxs3ZuhplT89Ek1IP2pRP2EE+OtPzDZHBlHeYho8/jGQqx5aFaJclWhhhN5y/rhVNfNvErajfZ+LRyMMb5ypLq59/pR8lW45795bCFi9JMSHgm25LanZfjdFWKmnbSYD5OR+ynBtbsB9rYSdhAHqm9NJAJQl2jmEX+RU5SUq77UUXh5u5JIUn022tXL+ylbQKUnXO2kr/0OFVmjdGr8LwjyupJyJ5IeZAUdkoXqANOZQlNU1rEjrgOedQmwqrgpQaW/4zyhmCmiVZcZnFQ91ZOE3lPNydbWUC4x6BRMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=U7vE647a1SZ4wvB0VilGICjKn2TvPpYTaXXM7PDEwWDeRuVWta4OFyyaXBSckoKPBg52P2WETk6UK4aKSmJJBKDAd9omYLDaFOqMfeaJMfdMJCv4jW1ZDNo9OdvkpEE9IDrPShP8eWNa8mziIzMS2xalL8laxnj0brZ5o6+EreXYOQbdNp5AEhLYzF8eOFUsLq4vcxpNLT9EEMx0/GPxobxFcIRH1BgqtEhwNuJJyOqQmuuGKaRwON7+W46MqVkh3lJ5LaLm2U8fePKOlcxo5pP/FoYqoTd9CcOuARcitgdQpdLKM7paWEl38Jv61S+7ulCMtO8/e0ZpGzcKlP3saQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=aPmU8rncWfz7haWCCg4AyjjuLSX7tBuTKxbha0jrrP8bcwvbAQHrbDKkw96R83UofQrjazZU9d38nMaR/COLP0mNPdTGf/vehJ7BWjIlAKZp4pOBI7fucoYmiovlEJ8mLCuFaGPHZGHbGiCSR5ayzW3auF1eoRTNE6vHDjcxg4o=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8115.namprd04.prod.outlook.com (2603:10b6:610:fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 10:18:14 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 10:18:14 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "lilijuan@iscas.ac.cn" <lilijuan@iscas.ac.cn>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "dsterba@suse.com"
	<dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pengpeng@iscas.ac.cn" <pengpeng@iscas.ac.cn>
Subject: Re: [PATCH] btrfs: mark __btrfs_add_free_space static
Thread-Topic: [PATCH] btrfs: mark __btrfs_add_free_space static
Thread-Index: AQHaWKC4y7X8W1+7vUqlpCk/aiqYArD9GlQA
Date: Tue, 6 Feb 2024 10:18:14 +0000
Message-ID: <02ad4dac-1f10-40d0-b1d7-3ed9798b9055@wdc.com>
References: <20240206015600.115756-1-lilijuan@iscas.ac.cn>
In-Reply-To: <20240206015600.115756-1-lilijuan@iscas.ac.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8115:EE_
x-ms-office365-filtering-correlation-id: 3d7c1508-d290-4ae3-7986-08dc26fcee1c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 i/CJN6aFbvu/YlBmIxr+UcMPl4KnrVqvi/FbekuhQ8thG629ZWDkS4EGLVsR16vE65GScJGfhUjCJG4J75XJtTt38irBpqaqvj4qjQHSCfSH1pDBkMyCC8yqImNhHwZO2GdDozj18/gsEz2i/sn2o0ADRX8fEtxT7Cf6SEBWDEnBBDXEFNzTm3/AYg+FkmoiXzODatOPmxYIqgIradDTEF0EmuHPutBJd2DHq/QFLNKlPKfo7RPkTr/qkYvKAsIrzyV4CjT4pAx9cKOs9y8uSwZ+kESm/r2hRBHmBnNQTS/b3UfMvsisKFRh4sU44boCgZNhiiLKEqwhE9eugCDwfIjzczzNRzK1RM7osiU3uvEUwcTecAbxaqgrRGcD/zkbiyw6zRRF3ciNmSa8iI5OpKB1ydmn5NdohDaPe7Et89Au5kNLfy1zPRnh6v9OZfWPAWOT1r7FoZO7Vo1Y+wb9ty/qnqRK+Fk7bpWqezZytsCNVJPM85tmWOrNnYCPzXS8qN6bcguFeCjy31WpLnkji32qK0zHKJ3nG9sP5qm0AgP0CC7jKUOIyyrVj+sFXC+ewYmqjW9iS5FULxDEdOZkWglLYIbvCdv3k9MMv4USHM9sbQ/wzFVfBs28vVxK9DiTTPUnw3RixdyiKLL5j0js9VNlKC9Cug+luUCNISOgCc5feSy3aGNC9t3SJ2O51Gzw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(38100700002)(82960400001)(6506007)(122000001)(26005)(41300700001)(31696002)(86362001)(2616005)(558084003)(8676002)(8936002)(4326008)(36756003)(6512007)(71200400001)(19618925003)(4270600006)(2906002)(478600001)(6486002)(5660300002)(316002)(66946007)(66476007)(54906003)(66556008)(66446008)(64756008)(76116006)(110136005)(38070700009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmNiRi9vdlFNTmhLb0FhSWpPTUtWQ0M0TmkxMWtDVHNCUFBVbUZkRVlFQy81?=
 =?utf-8?B?VzQ3TE8xaWhLMmY5L2hKSllEalZ4RVFVL0tiUkg0NjBzc2tIbzg3eXA0TTBZ?=
 =?utf-8?B?WHZFN0tLMnFUTUtJRFVwend5aXc2Q1NOMWJ0S3ZPNG1JeHNPQ1N0cng0YmJw?=
 =?utf-8?B?bFhoS2JyMklPblhpRVFONkhVK09vekRFUWUyS2JZam5NL2FrVmNseUU1NHpn?=
 =?utf-8?B?QllSQWtYTjFiV1lieWJwQjdiSElRbmFCamg3b0dCSktNczN4Nytpa3BuYlhx?=
 =?utf-8?B?YkhPMW9BYWNCNG1zK3FQSi84TjZhNWFlM2ZoVnVtRy9TTEtEQzc1RGZ1d3Zz?=
 =?utf-8?B?a1oxZHpxZTRuUm00KzNmZzRSS3U2M2ZPOHNvMjVlaU1kN0NWaFVneEZPYUVu?=
 =?utf-8?B?K25NbW5vZGRwZ1hGb2lNUHFkMzB3ZDNhNkZ4WDNFTWl4ZkhyekRCN0sxQVNO?=
 =?utf-8?B?K05CREs5VVRjdnJ3dzlkaWJHa3VjUldydW8xbnYwQnJ1V3k0QWRTWUN3dEt6?=
 =?utf-8?B?NHBGKzQ5dTFNalJsckFtRTlSMm51SXM4V3lvMXJkdkhKbktmdXlBdnNVQmlD?=
 =?utf-8?B?RXduRmpTZXN2b2RDUDJLUm9mbDZBeE00RHZBKzFwVmJYVUpBaWJHUjl1dGJY?=
 =?utf-8?B?dHk5dXI1eUlZQWU5R2UydUJ1dVpNaHlwUXNwWDdqOGkxeFRIM1ArUjlTeXhm?=
 =?utf-8?B?aG05aXRhU2xmWFF1UG9Nb3ptZVNiNnEvVzNZSjltV3Y4eDV6bmNCZEdKanFZ?=
 =?utf-8?B?ZjR5QS9rU3BkbGl4OTAzR1hkcVpjbnFXTC9GeVpqTWoyZHZPSmNwcmNIRlJ0?=
 =?utf-8?B?RlRJdW1sVzFlQ1JnUEluc0xNV1llRHRlWHRBczcrQkdiaUxnUEhhKy9IZWhU?=
 =?utf-8?B?M0dzak04bEhIaEo5ZS8wSzJnUlJyMTBxV2gvaklZWmdNdGc5MWhYN3AwZ1hm?=
 =?utf-8?B?dmRFNXdnelMwMWVhdy9EVmxGQklqZ0p0bWt1aDRJUFRzcklUUjhUcXFZOGlk?=
 =?utf-8?B?YTM4YWQ1dHlvb0dZK2h0bElsQUxMUFUyemlkZFhkY1ZIVG9HZElTbXlUdGhM?=
 =?utf-8?B?WjRtckVkbWlMdmhtVlhtWEdEbjg5N1ZJa0p1K0VYRlVpdnhlQlFLV3ZlRTYz?=
 =?utf-8?B?WmdNNGtOQ0wzbXplUFNDOHlGcEMyY0VvY0E1a3Q2U3VSckdGODFSVHVicGxX?=
 =?utf-8?B?UTllSUJBWmM1SjBiSDdtVk9wTldOSC8wSThHTk1GbEoweWRxN1lLOEYwYWJ1?=
 =?utf-8?B?eVBsT09tWFk0VmJMWnBKaHBQNEdoNDJ1OEdoTVhTL3VHbmNZQ2dRYS82WDZU?=
 =?utf-8?B?U1ZzYkl4elFFY1E4UzdWOEFwMlROaEZsaGxST2lLUVZNN0FQNnFDSmtpazBP?=
 =?utf-8?B?WDQ0eVdyU2NQZXFLdW43S21TRXRoZGY2bVhHT2NVdWZROWdrdm8zQzdES2Fk?=
 =?utf-8?B?dEYxUkI1c0VMeURGMTJ2K0M3eVczaUhXY0lCVTZLMWNXQklqS1pQbG5vbGs4?=
 =?utf-8?B?USsrdEQzU2g0eEtrVFdkVVBjSWZJR2lRRjlKQmg2ZWxseldvczl3TkVOdUFS?=
 =?utf-8?B?VFowbXJFY2RaSmJNZTgrclc1a3phRGpRUE43WDJrdWxjNW8xZVhzVTU2YTNK?=
 =?utf-8?B?MGdDRGs4RkRJUmNhSmNIVjR4bFlsUitwRHpPV2x6Rk0rcDJaVm05dmtmeXFx?=
 =?utf-8?B?K0IwMnhUaFMreVo4dHpuK1J0L2w2RFMzNHJ4QkQ3bEFDRE4xMWhuclh1dXBE?=
 =?utf-8?B?anNUTkg0dkpGWjA5UUdQMWcwdUFtNzhINi8yRE9CM2t2dDhHVmtFV3VsL05s?=
 =?utf-8?B?bXpDZWc0ckNPa0NZU2Q2L1phS1Q2RDdwOEpWcmhYdUxZNGI5V0xsRVJ3ZlBK?=
 =?utf-8?B?TGJ4bXlvd2dtZnRLRGFVcFJDY1RpMG45OGpRay9GaGVtY200WXg3akgrdkxn?=
 =?utf-8?B?clFLUkNUdklmMHVjMzVtdFgxMklwSXBQeEs1NmlPZHIxcmFZaElxRHpXckl4?=
 =?utf-8?B?RnVpeWo1K21Eb2tkTlRYYjZNSnBxSk1mMVlkbGNYV09jRkdWaVlJZTMvUDl2?=
 =?utf-8?B?OEp6WWZnZWExUDF1c0hxMzY0aEx2aHN2TEtMUUpLS3ovQTNZVHhnbmVNaUVG?=
 =?utf-8?B?c3YxeWtGK1Foc0ZFK2pNRTZoVjQ1cktsdHdxd25JN2h4N0xXOG1jaE1WWEwx?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DE049471267E8409BD48C014114484F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PIxTy7VPD0xhSii3D9XElM1Cip7TC2/YT6alC7hiDk1y0D62klw50Al82hWPss6kcyq4w/ecdvBryCv/8kAEZA3+O6SrsfjaBdyMCYHg918VbW3FUc6yJF/XKoO79u+uuco/etkb5VsjSSAh0+ZtKITrT8tmu9ge8c9u0jqRxh2TqGEt9PuweDpND8V79KR0kWlOM8lspTO1K/BFn/WxO6u8peddIg9BZi8TfL6iNMHmR2NbtYhYBmaw60jc1snD7hOauZcLsq1d1KrAWtpgGbk2w54yuvyaIH9BFRACjGMiViS0y+hWOH30hJiFYq4q/vEPN9ksn0D1NGQBCe14kyr/gLyqh+G6f6lewzeWxKW/hGR/erlQSzydQjDWucj5wPhjOrv3NAvxAeBeViO097avJgThow30XG9XOra64Wignq48Hm4cLei4Wj5iIzkJo84kz/rTKDS8ZyInWa9fLrD2sv8VUu3kludgmnbjer/r0AdLfNGHk5G3ToGorLtkJYGBfYhGx3I+LGdmrj94B9RK6WL+yrwJw+0ggHIcuwjKRoIz6Eq0lOCAg+bJau/gQy4CfEwfIpgb5PvtdxlPLxToCvJ8dYwB6IqphnnvZidB0r3Xx5/xjwij1zVF9zeR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7c1508-d290-4ae3-7986-08dc26fcee1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 10:18:14.7766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+rKS+vy17V98NGBXFGEj+9N2Qh1KLvBWCkdSA6gc0ydocs+juNwvaNR+2TqWgu/IQh0VRIcvp3QSUaA+8z8kXdSoVbCuEkMHo+ek0SqR40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8115

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

