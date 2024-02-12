Return-Path: <linux-btrfs+bounces-2317-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C914850FE3
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 10:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D0F281FC1
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 09:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C4917BAA;
	Mon, 12 Feb 2024 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dmZleNm0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gmeNi6Yj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899A25680;
	Mon, 12 Feb 2024 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731133; cv=fail; b=EgqSEgs95VeWycjsrG7qMzBymSdNSBJsDbiMO+O8NuWISCjOW5AHVL22ZZIyB42GkH55zt9VLVZuGR21bon56sm25fiLngKPNsQXocXmsSNMD/rhwbH1Td2+tBY6M+k0sKQvn+rSRP6Plj8/PNQcufp94dAi/y7r2T4FZ14clkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731133; c=relaxed/simple;
	bh=fxmTNSUvGjAd+BX2nVw5tcVH/ZaNMxxaXwnnI4kcNes=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TvcGtJnC4edn3BKH2ytk76PBpawASgCO00l3+ckOfBbRSZ2OQqS9lVLCfCcoAuJZDVR+/qJtpinAwR7UMDRm2QfIpxKMwwU70V9bmaUoT4grx+zyCO+nuC+/RhBLW5eGbabwhMk+8dMnSoMKQHvK4wJW8840xyn0dz4w0cIOtco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dmZleNm0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=gmeNi6Yj; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707731132; x=1739267132;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fxmTNSUvGjAd+BX2nVw5tcVH/ZaNMxxaXwnnI4kcNes=;
  b=dmZleNm0UmQ+qFa9rKzbJfbJaNHShusxk/bnKwyVBpVURx0uVCSLB6zP
   HZc9XuwBdEWroG8h63avWiJ2S4oSZKrVNtZmbcaTcH/tGetk+GLMvw5U6
   1rQl+rTnjXTg4pEaQ+hQQwrXQmp/9rc2RdjnMPpQR1mG1G6M4q84JJb+t
   5kONkE4X74VQ9plvbrpAKZFf0q3eSUTRsjNo/03yx5U0lPvP5KaJHYJ+z
   J93BbqFKWgbs3cwoJ3YZAoZE+BTEFmu6IZOPY48bMn/evfhZR+SipVFOZ
   /9LjoCWMYArm0MOBWuFKvGZj/zd4ZlxqWCxq4gc5HHlhJS5BG78NuhOrO
   A==;
X-CSE-ConnectionGUID: W7RsDj4QSSmbvGVZ9Av7qg==
X-CSE-MsgGUID: V75VhbxqTquBctFEcTZjHA==
X-IronPort-AV: E=Sophos;i="6.05,262,1701100800"; 
   d="scan'208";a="8952348"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2024 17:45:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijlVA5X/ZvEVHmj4FlMXp9i8WQWTLcbqUrHLwkWiSjWgBQa+rEvQS2u3YfS3CNYqnX3bhtaC49+2h6gNQ3F6PQcTH10hc0V1zY6jTs9PLhYGiHVjbj+925wrZPd7PTx7VZ3mprQEBMnSJXZPkkhDDsBMKDkKPZhsGeZP4bfdbNu1SiIAgGp90xeb1wJta6uE3BDdsOazVYn82qg9IHDLqTIZ+92rjEBwFzlmGok3eMWJA7wwyfhDKaSNFBMxxWxMYChqqLRKnzPBi0TpwHv+z22+jEa+2PEicd3xabCPt3+SwVFfRQDoYMHIixqKeFoM2sfoyJKpOHS3X02vn7el8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxmTNSUvGjAd+BX2nVw5tcVH/ZaNMxxaXwnnI4kcNes=;
 b=oX5ckFKaeR6r7ORATt8PdFgIXxx2LpEVQiibu5GIDZDHd+MIwQ+3nXOOnQSw1GYt1gqdCNAOGYtG/TxZsOhO8zrAIwkL8udLWRE/vWPaQBklTiYjqMDZry5sm0WBFEU1RSSQ+WFnUlS3Rd5wBFUSg93regJqqQvcZNxeWWvvA1Uh0LOMdYPKedrQQ/lhMZwmnbJApCUUNYjhlXIyKONBaiDvbyWZWjhuWAWXDUuku/iXnBVsq27f+QEvgffeDRsFeIrYPxkkJNMLRCu06E+FSmejR7Z1YPGEhDPjoU9EtAlgLg0lv6cdUEDIhf8Q4Rb8H0uxHcH+zpQgVB7J5OD2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxmTNSUvGjAd+BX2nVw5tcVH/ZaNMxxaXwnnI4kcNes=;
 b=gmeNi6Yj0JjvrUYDUULg2EWvA8Du73Bh6TiKUrnNK7ab1NHyEr12FL3yGbGy5WRdvRZ7qDHuesf6hSSNRNpwosJ/Uj9y+WQzTibhMkpOdfzwCPF3OnJg76lLhfHEaolgyINJqVoxI5EaQ2PyrU3f0XsqrDWg+rPLHKg+kcUuySg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6494.namprd04.prod.outlook.com (2603:10b6:5:1b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Mon, 12 Feb
 2024 09:45:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%7]) with mapi id 15.20.7270.036; Mon, 12 Feb 2024
 09:45:21 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: HAN Yuwei <hrx@bupt.moe>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] btrfs: reject zoned RW mount if sectorsize is smaller
 than page size
Thread-Topic: [PATCH] btrfs: reject zoned RW mount if sectorsize is smaller
 than page size
Thread-Index: AQHaXXKqf8otZhTTV0aW5Mr38f8CiLEGdX2A
Date: Mon, 12 Feb 2024 09:45:21 +0000
Message-ID: <11533563-8e88-4b4f-acc3-0846ec3e8d1f@wdc.com>
References:
 <2a19a500ccb297397018dac23d30106977153d62.1707714970.git.wqu@suse.com>
In-Reply-To:
 <2a19a500ccb297397018dac23d30106977153d62.1707714970.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6494:EE_
x-ms-office365-filtering-correlation-id: 36a36739-fc3b-4fd2-e9ea-08dc2baf5494
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qobqBvT2/Rbj7K1IFNI8lwgPCivER9dxLZRQ6e9obsb84p18MCwV+sX7mX5fRcZyeLPFEfLFp0gRuD/di0NlnV/lUjyOm7twaWoo8MdI6VgR5ctYMDQGQScFl5WfcnqlRxZj1fcIQeuJNtdXXAeMcj6P+mU9F/dAgvmCbV60+BShYDd1cuD5EprFgRsqFIGlgEVn05zMNWHjSAqa1Qai6NOlC55ocKNt14oPkbt0N2PG5yKq6ig3JnR01G6ei3+pUy7O2gbI7KkEWsSzR4+6vj7sJ3yAu/FE5bLLmOiDeneY1xkCfbMoSbCK+JTXQfQE/297qdb0mw1AtIGWzBiuhpSTFrhDwh6DmLxBVCkEUtJV0qhifyDfnqG03hCzFrfAhMpTbHIlLS2VQX5Aj+kq0ThowW3GjDmFbAbqIDj2DDaL0Fmy5jnsRyFtulprMAlcSaixF4Dzt+pJCNNWiPGoXTtrgEOiroljwYSBgQZSdhjsXHZEFQCYpyXw77iQpo0oOE5NS/Ddx8tYo+fkI8+ea+crKlXeAj2x0Pk1HzBQEQy60bv/i8p3n+DjQBP4Px18nuDJU0WqJx0A4Tp4SYHZThjgFrIFgbGVitR9vUP6u8s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(36756003)(38070700009)(41300700001)(2616005)(26005)(478600001)(8676002)(76116006)(83380400001)(66946007)(66556008)(66476007)(66446008)(8936002)(64756008)(966005)(5660300002)(4326008)(54906003)(110136005)(71200400001)(53546011)(6506007)(6512007)(316002)(31696002)(86362001)(6486002)(122000001)(82960400001)(38100700002)(31686004)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzBhdm5hU3AwQUpNaDl4OGZMdi9FWXZlWDBCa3VpTEEwZVJLcmp0KzE3bXdW?=
 =?utf-8?B?RXBRR1NoZEFzbDc3WVdHM2t3dTdqUnpjZCtLWThRRUJDZEtobUx5aXVkVFU3?=
 =?utf-8?B?ZGZaU0t3YUpZNzN2RXNoZDhyTy95bmNhRlFWVlZIL2wwUHlQa25lMWV6emc2?=
 =?utf-8?B?K0UxL0Zab0ZleTlIS3RhTzdWZXhOQVRLNmVIM25ZZmJvM1NvVHFDcnR2dGlP?=
 =?utf-8?B?c0RhNnM3N29OcDhpV1VtNjQ0Nlc2OTlQQUc2U1ljVDU2NkdwcW5iS2VUajJD?=
 =?utf-8?B?aEl0TG5jQ3VKbEV4WjJSM0tEZzNjSEFEYjlhR1daSkt5eTREOWhmcDk5Mk1r?=
 =?utf-8?B?WFdQNzNXY1hEc1VKNXBDZ2VzeTRCNHNHMllxODFlTGh1KytnYTBBZXNrVzFP?=
 =?utf-8?B?MERhcjN6L3U4VWFjRmI5Zkk0cUp2UGtpeTJ6UE9VQkQvQk1XTXd4NE1jSE91?=
 =?utf-8?B?OE9PdEtRL0VrWGZMWU9vTmhFSDRnUVo0akI5aFp0dittZlRtRVpBVTIzSnM5?=
 =?utf-8?B?UHArdWt4d2ZOaTFIckNXRHU1VG1lQjJ0NGdZOVk5TFVzdlk2K3hSU2pDL3NU?=
 =?utf-8?B?a1lyZElXUDA0UDV6MGZkaWFTY25NT1hwOFZpS2xrOTdvdit5VktFUHNBUW56?=
 =?utf-8?B?dGtBSEZvMVp0dWl3WHUyUHJrZ0xqQTlRNWt2ZzFUcVY5K0dVempJdjFLQUpa?=
 =?utf-8?B?cjZicHNSVzhNaWpxQm5DUlJZZDdFbTlINkpnemJudlZHL1JQbk1LU1c5NHZy?=
 =?utf-8?B?ajFobGxadWJ4UWRPV0g1WW5aYldvMWk1Kzh0RXo4NndZanB2aTlQZWhCL1FM?=
 =?utf-8?B?amNPMmlmbFhCNHdnWlhaL0tQdG00NUZncFl0S3NRcFZua1ZYdlVJU1NiTTc2?=
 =?utf-8?B?cTdKcGVZTWdRWGY5Rms0MXZsS2RVZmJvd1J6VmcxV2lMNGphb0NwKzNwcno5?=
 =?utf-8?B?VXpzNTRVdmF1dy9kRW1NS3BVTmk4SjJGQnEwL3dQNUhTVWRPbGxGL29kbjRE?=
 =?utf-8?B?NnRhSjNDd3I1VVNzRm04UXFiR1c2VXpUK3RCL1lCdldYcEFCUmVXaWg0RCta?=
 =?utf-8?B?V1BGWFVGdE16WGNOU3hFM1QzRTkzM2k0TmRBSmxQQlJ1MUNaYmVQSFh2dU9o?=
 =?utf-8?B?eWRvYUY0VDVaek9Oa2FMZXpqUDhvQ3d4WGp2d3ZsVk5zcWdrNDkwT0FvanRW?=
 =?utf-8?B?L1hPbENoVU5vVkFGTXFWdVNITmw3aXBNZ05wL0FvMkUwY3pmV0J4aHJrdVF6?=
 =?utf-8?B?WitvVXBHMmM4T0JUN1NqTUNhb01jM0ZZWFZlbGk3c2ZHZ3E1WTc2Vnk2b1VN?=
 =?utf-8?B?Nm13c3NnN0dUNG1YaVo4ZkVmVXNyc3YxeTNvU2ZYK1BOTXMwV3dmV2cxeXNs?=
 =?utf-8?B?YndGc2N5Um9rU2w2ZGkvNU5UYTJZTklCNVVtOEFyYThSSFNrNDBUQlU1Ym1G?=
 =?utf-8?B?WWdUaFlaRlFORzNWaVdIeHdvd2hkMURPeEtTTUQvSzZlVnUxRUlIUHAzL29K?=
 =?utf-8?B?UFZoOVcxa0x2RXJBL1c0NW9mUWpoYS83MG5PaHZMM3I1SlFodVovV0tqV3Fa?=
 =?utf-8?B?S1ZDUXZKVXdVdm9may9NY2pBQXF5K2hlRzRQS3YrczFMMkJPV3lzWFhWVFBM?=
 =?utf-8?B?eXpuQzJLdTUvVXZ1NGk2b2xIMHFxY2R2S0lReXMraE9BcGNYMXNXRXFxaHNh?=
 =?utf-8?B?Wk55MW5yRmJhelJmRm5IL1ZaY0oveUFIWE5OMGhITU9GRUpZUFJyNkY2ZVkz?=
 =?utf-8?B?U1BoMU13WTZ1dWN3d0c0azhRUnFLdGRUTTFMQW8veFViZHZ3SHJvNDJBLzRp?=
 =?utf-8?B?S21XQlNlNTd0Q1B4dHppTEZ5ZllRRjRSQUxzdFR3Rklvc3NUSmExdE11THRq?=
 =?utf-8?B?eVlkZG4reE8wbTU0bXdIQVdSdEVWcFBjU2wvWnppSndzaWdsV3JVSm93ZjQr?=
 =?utf-8?B?R3BYejJReEdXNDdUZ1RZUEZjMENBcUFteTMzeXhUOGJ2ZTFsV2MxajZtRGho?=
 =?utf-8?B?K1UycHNLK2U1N2MyZTZTdTZBVXo0Q21vUHBNY1ZwcFQvV2hmUFp5VEFodlFu?=
 =?utf-8?B?aEEwWlNvaUUvL0swRlI0NkhCZ2xlcHUwZkltd09lSTlvYUthemloMTBFN1R2?=
 =?utf-8?B?Z0U4K2hEQjJFeDhtY25QSFNkQ3ZCdlFWODdsUGxvT01LeWQyOTJNamRVM2pR?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC3587BFA10F244F8DE51D8D5C31E072@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3u4Of8r5qRmIehYzY0oKRfM01Atupxm1wqb1QItIQdsrrt81kMlHWeAn9aINBo5Qhrz9cpg+/nqEolvbjtkIVaCFWIxjT8IrEms8qQ0a+EgfxF8IXtYWDm2rGmbj0+x3EYxmUNT3pdRGCdNJtPAq1v51aEZ9SKjqVMzONjduOPfWjC+5dSbes+08qhyPI+a1BlfXDkNbDL4bwwOzv/VWPDhWWQb2D9Or4IGsO7XC29GyAjynX04pgpYAdE5KiaDXhrzGIdOgzZmStubzZZK2izhgIuImdDYlebck2I8OgrggDELXK5xohhSImuzdRgku8zKjiLSJhK+ODBDi6SURiBPj2NsRM36isF2LoUs4MNeXBBfxjPAxBfRX/NK7b1ydB2gRbA4g2desRyCOSqhEum2/HnqmjWRfjypYHbZZMdNGpoT3zKyWuPCgAKkfIghXhftJnQZX/ySNuKvdxPsvFUDGREbVXGvpq9pIvjytrluCkCA3iVGmkGGIexosW3zpdfsfEmJGvx8uz/gvkNOVtfJCjtquBjC/vB34gCRTDTcJQNnyEuL1V7ASqHudPfVU/LnB3wR/xJdNjuSKgPYH2z1Ayzb8A1cdk8LXEX+cc8GI6UmhoWxTOtiQs1qEtSAo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a36739-fc3b-4fd2-e9ea-08dc2baf5494
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 09:45:21.7477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KpKz/ZBVPKMlgrIlSRv0ih7HdznknjMzcXCFd5evAGjRnXqeBlhMVspHzZOTBUfcrsSamPh1PQ6Fsq69dOYrYbXQDmm9MXP/upZSBSBhFEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6494

T24gMTIuMDIuMjQgMDY6MTYsIFF1IFdlbnJ1byB3cm90ZToNCj4gUmVwb3J0ZWQtYnk6IEhBTiBZ
dXdlaSA8aHJ4QGJ1cHQubW9lPg0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
MUFDRDJFMzY0MzAwOEExNytkYTI2MDU4NC0yYzdmLTQzMmEtOWUyMi05ZDM5MGFhZTg0Y2NAYnVw
dC5tb2UvDQo+IENDOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgNS4xMCsNCj4gU2lnbmVkLW9m
Zi1ieTogUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+DQo+IC0tLQ0KPiAgIGZzL2J0cmZzL2Rpc2st
aW8uYyB8IDMgKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2Rpc2staW8uYyBiL2ZzL2J0cmZz
L2Rpc2staW8uYw0KPiBpbmRleCBjM2FiMjY4NTMzY2EuLjg1Y2QyM2FlYmRkNiAxMDA2NDQNCj4g
LS0tIGEvZnMvYnRyZnMvZGlzay1pby5jDQo+ICsrKyBiL2ZzL2J0cmZzL2Rpc2staW8uYw0KPiBA
QCAtMzE5Myw3ICszMTkzLDggQEAgaW50IGJ0cmZzX2NoZWNrX2ZlYXR1cmVzKHN0cnVjdCBidHJm
c19mc19pbmZvICpmc19pbmZvLCBib29sIGlzX3J3X21vdW50KQ0KPiAgIAkgKiBwYXJ0IG9mIEBs
b2NrZWRfcGFnZS4NCj4gICAJICogVGhhdCdzIGFsc28gd2h5IGNvbXByZXNzaW9uIGZvciBzdWJw
YWdlIG9ubHkgd29yayBmb3IgcGFnZSBhbGlnbmVkIHJhbmdlcy4NCj4gICAJICovDQo+IC0JaWYg
KGZzX2luZm8tPnNlY3RvcnNpemUgPCBQQUdFX1NJWkUgJiYgYnRyZnNfaXNfem9uZWQoZnNfaW5m
bykgJiYgaXNfcndfbW91bnQpIHsNCj4gKwlpZiAoZnNfaW5mby0+c2VjdG9yc2l6ZSA8IFBBR0Vf
U0laRSAmJg0KPiArCSAgICBidHJmc19mc19pbmNvbXBhdChmc19pbmZvLCBaT05FRCkgJiYgaXNf
cndfbW91bnQpIHsNCj4gICAJCWJ0cmZzX3dhcm4oZnNfaW5mbywNCj4gICAJIm5vIHpvbmVkIHJl
YWQtd3JpdGUgc3VwcG9ydCBmb3IgcGFnZSBzaXplICVsdSB3aXRoIHNlY3RvcnNpemUgJXUiLA0K
PiAgIAkJCSAgIFBBR0VfU0laRSwgZnNfaW5mby0+c2VjdG9yc2l6ZSk7DQoNClBsZWFzZSBrZWVw
IGJ0cmZzX2lzX3pvbmVkKGZzX2luZm8pIGluc3RlYWQgb2YgdXNpbmcgDQpidHJmc19mc19pbmNv
bXBhdChmc19pbmZvLCBaT05FRCkuDQoNCk90aGVyd2lzZSwNClJldmlld2VkLWJ5OiBKb2hhbm5l
cyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

