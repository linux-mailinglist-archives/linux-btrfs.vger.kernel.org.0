Return-Path: <linux-btrfs+bounces-15700-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A66AB133B1
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 06:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777031896445
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 04:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8035520E71D;
	Mon, 28 Jul 2025 04:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HuoUjeId";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hvDVWny5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1F81C36
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 04:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753676560; cv=fail; b=t1IgIJDAoQohuw/NOruza5oq0U7gNzi4835n8Gx+tfoOKwTY0ftcgYLCWqqVab9anKZU5A/CzQAEixmbv8MOFtani8nsQwjnlkvLrOI2FSEPZyKORJO1JFsTcpMt80PWBaVAW8z8tQZ5oe0yDBqOYGugK8fIl5GOSwJTlrRKVzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753676560; c=relaxed/simple;
	bh=vuX1KWq0ToKQHL5BSGtGI5xZ07kz2r5yYn99AFT9cfQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ACpw4ocLDTclV4W5uD1AXTaCvP+6tQ4s2Z28UDZWLbsceZQTL1wVoHnfiL/4lj8O9UExEZYX6tRy2lwH6WVBQkVYxrEbZIIT433PFtyM6diFz48Tk17bdmUhGvj2DA/T9zxdKcRCySpDC/tps896P3/uV7kQn842SZu8AqjIa8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HuoUjeId; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hvDVWny5; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753676558; x=1785212558;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vuX1KWq0ToKQHL5BSGtGI5xZ07kz2r5yYn99AFT9cfQ=;
  b=HuoUjeIdtjWB26GkAsLTsfpk/1hxYN2AG4NBe62086jr255nb7QcEDyA
   EdrMVep33Su+xGEX0nWbp0EeBO0oRYMMzPospo50bJJRqSZnj6BtO5kTi
   leiI57OXk97Mjb6CW1/RplJ7xG06Md1UBkiMi5RM4C9EqQjoAZM8oPjYi
   COi+dpfa6ahILJ+ZN0h/P5r4hJbW1LbmtiKCNl5YJUmRfOKOxSNsrwa1G
   coDtnlN9zO+YVvCrwSIklibYZP3rmhV9W61eDeTMiARATvN07IfeIqvMJ
   yF8/N1ppNyiQjMnkOZunSrVqwna4xIoZPtiVTvh5QZZKjsYuILGBxeEgw
   g==;
X-CSE-ConnectionGUID: AczJFVLATyiwPGf5j3XHUQ==
X-CSE-MsgGUID: ETW0BT87RX+7eX49ezbRSQ==
X-IronPort-AV: E=Sophos;i="6.16,339,1744041600"; 
   d="scan'208";a="103687447"
Received: from mail-dm6nam12on2060.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.60])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2025 12:22:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TyozdCqEtx1mzbn6dnPAVwfxDurUhKkxq6FthiFH5F/xKTZ8BOkJ1FHmZhUXWlwzpo/xGWOlIo6CmP5QjFbqFusYUzpr6DxCUTmuLU8NqDbOGE/BeIYK/DnukyezN1/tWdfrn0QHDwwoopooEyDBx35w7kO2SPAEty2eaqsO0os2dfkhaqv/9a24w1UREBDAZDcCQyT28Z6BCg/gE44EiUGRno3881ksLpbeDcQhHznn7F2+hUxd1gb2CfWQdYwkY2O/IoB6ckwAYr3BsOg1Cqglhvec/aYq7RT02359EaIbftFewm2+yRS4f35XIdZn8svuQ1ZqdGguWy5p02Hh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuX1KWq0ToKQHL5BSGtGI5xZ07kz2r5yYn99AFT9cfQ=;
 b=RP7Apw1gDMACOvVJTuAwLyynsLIC3Kvq54MojtZpSbH7AlfZFx1SXq1zVRtEVT8l7OAKrS9Enc2WzRlLfA/3X65gH1Lz+JMU3kGi3KYLMjJCo3HDtOl7peqxJLMQwctqNDcuFImqoi+Qn16qwqqG9QdDATMaoWUakJk31QzFQHeM0RPxck290UcBMVob1XpKE6vIQSh+awHQnxQOut3nfh0AsM/6Dw0Lpfd4bWmVsHpnL4iNrKjX4HwzkzE47y4sFXWiwGZ7POMeI2tP3qNuJIMgT/BpQjcSKfVOWDhlxGoZz1/fMNC1Eg7tbjVXZxnHdH/feelmkA3jQUh8XvwC4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuX1KWq0ToKQHL5BSGtGI5xZ07kz2r5yYn99AFT9cfQ=;
 b=hvDVWny5FJK5IyhyL94nDFJjrVy1Evu/DgpkpzjIxOn1Q3zdWRGlCiiLNrp25f65F4gtWyEMf+n1F1LKh5Te9EHjRnFDdI34iBiaXIs3EdTr21oiYBeLxpFRFnN5Yn6Lwf5XXdLxEmTgTAm7AppIlpiMAlGPfioXf6vCrgBHr9A=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH7PR04MB8974.namprd04.prod.outlook.com (2603:10b6:510:2f7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 04:22:27 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%4]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 04:22:27 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>, Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: skip ZONE FINISH of conventional zones
Thread-Topic: [PATCH] btrfs: zoned: skip ZONE FINISH of conventional zones
Thread-Index: AQHb+9cPPNvAD6SO60qxWhkojKuE67RG9sWA
Date: Mon, 28 Jul 2025 04:22:27 +0000
Message-ID: <DBNEGBYGODPD.39RBG6DXDLW0S@wdc.com>
References: <20250723133810.48179-1-jth@kernel.org>
In-Reply-To: <20250723133810.48179-1-jth@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|PH7PR04MB8974:EE_
x-ms-office365-filtering-correlation-id: dd0ee2e1-f2b6-4804-e1a4-08ddcd8e5c95
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UzZyK0J6VXZ0YmwyU2U3cDBWYkdGdFA3WXpLNTJZTDNXR2t3STJRQm9jYmpP?=
 =?utf-8?B?bmZRakIwM1lkSU9aR0hoZGdWZkRHRG90d0U1UTlGaUMyK3J6QisrSTBIWFFt?=
 =?utf-8?B?QnFDQU9ucjdsbko3RWVDOXh5THo5L2k3RFJFV0dQY3ZHZFhWelBQcFB4Zkd3?=
 =?utf-8?B?bzVqWGxoWDFOaFl1NDVoNlhGdEtmSTcyemI5Q2dic09XWUdVandubkQyWjhG?=
 =?utf-8?B?YnRmMGRIQzBpdFB2bk1wUTBiSEJFSkNDdnZLeXB0LzhEbHFEZGJKQUd6WUhy?=
 =?utf-8?B?ckxiOC95NG4vem12UXkvM0htN3RnNWJYREl1YXQ3eU14VWtmRTBSMWJNWjFS?=
 =?utf-8?B?cFhUUld5NVNGK1YxUGJLMGh6NmxHWDAxRmhPeUU3RTQ3c2E5VFBWVEFlWUZ5?=
 =?utf-8?B?WGJhb2xKa3RNcWIxaWtqQVFTZ2F2bXZnU1AzK0pSYzFPMjJTaDZnT01hdmdi?=
 =?utf-8?B?OGJwNU9US0pmbzhxS3pqRFlUeU9WMGlXZklKSTV6eElIaWh5WTVpM01kVHA5?=
 =?utf-8?B?YjB3bEpPclY2L2p6dFJDSDRIVWRHV3pYOXdGSk00L014d3lkQTh0MmJSS1Z0?=
 =?utf-8?B?MEw4TzhDU1NHdVZnV1JUZ0Z2UThRREFJMEt4ZUZyL3ova05TT3d5STNSZFlk?=
 =?utf-8?B?aVp4TEJTN3VXNStoTzBnMnp3VG1SQ1NkMExocGVRWUh6ZU9uQmptMkZqN2dO?=
 =?utf-8?B?dnhjSHFRaFNLMzAxNjhPZmkzMXZHeXZPdVNFVVh6bjYrZjFPUDRucy9KSDRJ?=
 =?utf-8?B?bzhzcFlmeWwxMStiaHl5bllLcVhPa3FxTkRwNlBKUHkxaDZHRXIwcVI1d0Qx?=
 =?utf-8?B?c1EzcmI0Q2RJb2VVTUIvdFM0N0xrREE0dEJKbUMya3FKZkFTekppZUhpSjg3?=
 =?utf-8?B?bk81bnppN2h6TXVjQ1lpdTN0T1ZMMGpoY1ppc2tRNCtqNmpvUnp1YnM1anR2?=
 =?utf-8?B?amR6MEUxdFNhNnQ1UmdMK1VvaGpZRTkvR1BkWVpCMjNmMTZvemhNT2hTMjZa?=
 =?utf-8?B?RWt1Nm5MWU9yNEJyemFVdE05YzV2elVNdnRNZXhTM2FqZ0oyUnc4VE1tRjkv?=
 =?utf-8?B?ZGR4OGVQQ0Y5ZEd0bUlsbjZISEZNb0tNaWQvbVc5TGt5T1NzR3h2ajN4V0dM?=
 =?utf-8?B?bFUvV0JCOW9kRG9nUXdpZ1NGNjFuYjBXckJuZWNDcGFNZldtZzVzSTV5T2li?=
 =?utf-8?B?QTRhZEN2UmhTMi9wUlk2d1JGSU9XeVMvUS9wUDQ1bEcxMzFqM3RQdnVKZDRB?=
 =?utf-8?B?T2RQTnlEaEovTXB0bkdDZ1FhTm9uTzBKaVZINnVKMThZYlFKdEU3RkVSVm05?=
 =?utf-8?B?TnR3YnhqZXR6UDdpb1FTQTVucDRvQ1pJNTloaUdYVmRrYkVuYktSVURNSkpQ?=
 =?utf-8?B?Y25kOE9PbVlmdGduYWFIOVhub2RBcVBYRmpwSWZGdmwvUEsvMVZQeHQrNnpn?=
 =?utf-8?B?eXJoTEtBYnBad1lnT2tWdTRJcytrWUdqYzZpYTV5cXdONGsvUCsvVHZKRTNu?=
 =?utf-8?B?WFNyeDNPdStJL29iNGFhRlNlZWF6WGxSNitRdytjakFmSld4NWZXbnZLVUpS?=
 =?utf-8?B?V2VEdEUwc0xhOXZPZXhYNFFMUlRiam9Va3NsbHVRc25JeHB3S2RBTnp1anVF?=
 =?utf-8?B?b24rRFMyL3VreXVCZElndnZPQlJxZUFOemtGN0NTRC9icmR2MVBWYzN1VVlp?=
 =?utf-8?B?L1M0SHFTTmJUS1FvSWtnTjlIaFZRN2hIYnIxSURjdzR6VzNDQVlRanR2REls?=
 =?utf-8?B?LzhmT2dDWThSNTlZZXRQUU1ZWWh3SWRjNXlQa3ljb3hwM1ZXWVY2MmUyc0JW?=
 =?utf-8?B?V0VBTWlDQWgxR3g5WEk2eVZUb3BndDEyR1VJQUlvWGpkdjNvVk16eGttMEZw?=
 =?utf-8?B?WW5hU3orYmgrRlBVUGcxRGhXTUQ1U1BOaHdEZ2x1dFdBcTZOR2xxWmgvMGRL?=
 =?utf-8?B?dW1uQ2xaMFo1MjBNaDVjSlBJN1VYZjBDS0s4VmIxWkZld1hLVWFrcWZBWjJa?=
 =?utf-8?B?RHdVNElkVFp3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXlhL3ZvNnJTbVd4cUczT0FnenFGcUhoZU9MY3AvUm9FOGZ0dmsxSmtNdEti?=
 =?utf-8?B?MzlNbk52bEdrdmhpZ09tVnZqS2U4bE02VGc2Y1h1ekpDcWJHUmo1RklabS9v?=
 =?utf-8?B?UTlRdWZibFRGejQ1TlF5UnJ6M0dXWjkydUhDOFdZV3F3S2dOUTBXTVNPR3NF?=
 =?utf-8?B?ZzljVW40R2szMUpSNFFINHdaSEFVbGNpODN3OVU4Mk5zUVpoZkcyOWxid1Ji?=
 =?utf-8?B?RGQwa1NMN2tpeGM0QkhSa0tQU1NrYU1YQUY2c1lSdi9KbVNydUV1WEpPSDJm?=
 =?utf-8?B?V3ZyYVF5TmpWOURrUndOVkc4cHBuemJjQjljRFVhUUtBbW5XZjVBVStpMGh3?=
 =?utf-8?B?Mk42Mk0wdmJNZklTYnpycUVzbXNvUVlKMy9TdTdEZ0ZpaW92VXRjb01LN24w?=
 =?utf-8?B?TzZGT25nTGhYOVlkY3lSa01LNXBFaE9QZEFVM2s1VnhVc0lFcXNKSFJrRGhw?=
 =?utf-8?B?ZjJ5TVZ0WVd4Y3pEMHhwdFJmc1d2MWkvNVMvWDEwSWFhbWcwOW45Vk5leFZ6?=
 =?utf-8?B?Rno3cjVzYzRibWVISWtSdVZHZUNsWFdOazkyUkNVRTNPT2lvWEN4WUNmS29w?=
 =?utf-8?B?S25pbWNJRjFUOTkvZkRsTG5Yd05YL1cyTXErQXQ0eW5IVTE2Sy9yZXREWjc5?=
 =?utf-8?B?TWR5TUExOUsxVE1neHdoZEhwTVZxOWtubVpTSjRBck0yM0VMSDc1YmxENVdn?=
 =?utf-8?B?ZkZKKzFiOTZubWM5dUpybGQwYitCaWFVM0ZHdlhnenJBK1BHaXNIR3VDVnAy?=
 =?utf-8?B?aWlmUnRNbnNjRWY0Tm0rRTAvNXMxNTVaMXB3ZHJBbjR6b3dycHdvVCtlUU9Y?=
 =?utf-8?B?YTM0M0pLWm5FalphV2tML29ZZXQrQTdIWVk1eUZhWmpWYVRHWXp6RWErNXh5?=
 =?utf-8?B?U1Y0YVF5WHpSQ0dFaHdaY3VzMFBNbzloRkVFRERFeFRxT0t4MWFoTjVTM0Fl?=
 =?utf-8?B?R3FnckRvaVQvNG5TdEN2UDZORzcvb01YZmt2Nlg1VzVaMGlTUTErZURsaE9s?=
 =?utf-8?B?Q0FCSmU2MkVlaUdwZ2VLMUNIUWRCQ2JxTWtWT3JOU2pyWTdsSWhPbmwzYjl1?=
 =?utf-8?B?c1NGS2JFWlJQUmoyUUxjVmZST0xjbDJtZERFMFB3aWNEd3BNMGlvSVVzVU5I?=
 =?utf-8?B?V1YzcS8rZ1h4QURWTGJJRHhoSkltTU9DMVBBa1lJRXNjbUhLaTNIMlVVQ2hN?=
 =?utf-8?B?SzFVMEtHbE9OM3gvMXdlOStLcllYazdtVnZVUlZaSzRoaDZYbzJsSU51VXVv?=
 =?utf-8?B?VUQ1bVhYeENRTTZsZWVTVllRbEtEcmpMM0xGeWU5U0RxR05JNlhvRW1HYnJw?=
 =?utf-8?B?MEp3VTVyT3NFSUhRQWkwYTdsQTZxN2xJTGxiOEowTWwwS2NnVy82OHRwaGFY?=
 =?utf-8?B?dU5RWTQ0cGpNWHJML3B5bkt5cnp1SnNBWlNKa1lndjhOanpDK29OSjgzNnJE?=
 =?utf-8?B?Y21Ya3VOZWw0Qk5OZnBPa3ZNSFl2QjJ2RDV5MEYrU2ptbk5XR3hXcXZ0Ymxo?=
 =?utf-8?B?SnFBS1F3U01GNC81cGpxbHNyRyt5UitwNUxxeVB3S1o2YkIrMERTQjcxdFdC?=
 =?utf-8?B?Zng3VTJMUXJseTl5L1FKNm5kaklqZ3dGTXpibEg4emliQi9YZTI2bzUwQWYx?=
 =?utf-8?B?SVpGU1NBRXRhWTAzZDN6cHcySEZUYVJWN3dWK1l1cjJBUFhnSlhOOXV5OEI1?=
 =?utf-8?B?SkZsdHhRUnhXT3d1T3g2UlRoMGlzQnFrT3h4V3lFelNSTGxrWUNaR1VzUW9P?=
 =?utf-8?B?a1JXMWFZZTkyTVJJZXdQUHhnaHdPU0xrbGdlRXF4VmU4dko0K2xuWUc0YmNF?=
 =?utf-8?B?ei9QcFM4U1BKbXcxL2dmemhJbDFpMDJ6Vk1FTW9FZUtNdDVUQlZEbGtzWTFz?=
 =?utf-8?B?c2hqd2x6L3hsSlptckExRndXdk01aDMxbHNoZmpuaHo4Yk8wc2dSQ0cwMWtr?=
 =?utf-8?B?Z0JDYm1DNkJRbmtPWXJZOGVHVWpYQm5FRmphRDNDd0R4Vmx6dHR0aDE3QjZI?=
 =?utf-8?B?a3FzZlBBamF2WDdXbHBiMjRYWCtkVGVCMzJkYStIeDNER1hRN1lPT01QYVcv?=
 =?utf-8?B?UlJhZ2lQSjNDdVJYSlk1cmpoR2hNUVVjL0ROblp6RHRMYUJ1OHdmOWpaOGRF?=
 =?utf-8?B?aDBZa2JGRElPUGp1bUZSVW9MSElkWEEzamxFdCswdVdvSEVDcjVJZUp4R1Vh?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED0EB024885C1B4AB979CB073EDE36A3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aJ/GGfFNiMO1P2/162Sy8Ip9nwU3HiYhle8aHFcklMkJvSci02ro7xdUWcuHqVbpY/6UNN/u+dFNRi3aePtrXBZiPtWsGtdzSlzVcxB8J0VnhukQTD8xSIOo+sZiMWpp7AEHBj/qt49cL+gCU9gTfS1qaMnFiRjHS1X9eVq7JD9Wq+BRpAbJCm/B0mtjJUS0k1jFnQI5PzbfrHeXdh1xxls1R3FvkIcQRXVTnieOsik/oXnsI3/+HjilGbgq9UykAxTVB8phiBPte6HYUVLuaknodfxLfL1SehzgKzAoc4Wik9jKLyt1alMk67t2X6owisWGC5VET7c6lb2Zm20+l69X+oq8j3xvTriwn6pRQ7hqxZtd6FjeptbNj0NAgNeFfwfaKGIrTtfiL1y8cusAeUpAMu+AJMoUS0SjfgXTGzkWMEik+F0ThLy7slEoq9WcQ3wxaPG9NbuXlzGAt7N92QR9M4yEGNy9zQcHYnIsI/gMwtf4LSdIsQVKBzHhqpOrhycedJMDOUQB2zOGg0UHcfAPpz5c4NVjR/KXBelQu1f2gaUKzZkv47j1Txn4b87eRBJioaJKzCIFxlyezwaDmrxHmocx6tDa1yh91c0z2kwtmvrphfDxjWDC+vq8bBMt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0ee2e1-f2b6-4804-e1a4-08ddcd8e5c95
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 04:22:27.8785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4XNySa3AyNFeGcq98NRxnHfXYHnlOkQ9WIMwByEkilirhMHBaSxztteA9t5fahOcuDqgSz1MUMzfEeR8PmMzNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8974

T24gV2VkIEp1bCAyMywgMjAyNSBhdCAxMDozOCBQTSBKU1QsIEpvaGFubmVzIFRodW1zaGlybiB3
cm90ZToNCj4gRnJvbTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2Rj
LmNvbT4NCj4NCj4gRG9uJ3QgY2FsbCBaT05FIEZJTklTSCBmb3IgY29udmVudGlvbmFsIHpvbmVz
IGFzIHRoaXMgd2lsbCByZXN1bHQgaW4gSS9PDQo+IGVycm9ycy4gSW5zdGVhZCBjaGVjayBpZiB0
aGUgem9uZSB0aGF0IG5lZWRzIGZpbmlzaGluZyBpcyBhIGNvbnZlbnRpb25hbA0KPiB6b25lIGFu
ZCBpZiB5ZXMgc2tpcCBpdC4NCj4NCj4gQWxzbyBmYWN0b3Igb3V0IHRoZSBhY3R1YWwgaGFuZGxp
bmcgb2YgZmluaXNoaW5nIGEgc2luZ2xlIHpvbmUgaW50byBhDQo+IGhlbHBlciBmdW5jdGlvbiwg
YXMgZG9fem9uZV9maW5pc2goKSBpcyBncm93aW5nIGV2ZXIgYmlnZ2VyIGFuZCB0aGUNCj4gaW5k
ZW50YXRpb25zIGxldmVscyBhcmUgZ2V0dGluZyBoaWdoZXIuDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNCkxvb2tz
IGdvb2QgdG8gbWUuDQoNClJldmlld2VkLWJ5OiBOYW9oaXJvIEFvdGEgPG5hb2hpcm8uYW90YUB3
ZGMuY29tPg==

