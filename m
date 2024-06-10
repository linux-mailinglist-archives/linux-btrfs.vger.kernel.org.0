Return-Path: <linux-btrfs+bounces-5596-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FEA901D53
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 10:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50B11C213E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 08:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4136BFA5;
	Mon, 10 Jun 2024 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XDGTkEr5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EJaNUrKK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C6B57C9F
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009632; cv=fail; b=NeqzjZW27BObixSNRrPaXOHORKgzWNhByJuZCzHqxXUq2qqa6AxQ7GL2wpHxBpPDPoIgdZAFBBV6T87vPzyJJiqpFiBqLz++iYUvBlugJMZFWxDLE81yL8sulz2AwxWYJ7ob4ON8w7aPniShrKg6cQ4CgqAYyYUILQCNLhrqAV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009632; c=relaxed/simple;
	bh=Xu76IUOUZSnVx0qZ6Q55ga0WXWjz38WkPs+YTjRvHdI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jZiGoGsmf8pM7hWwykPjV8CnYVDDt8xXgYYgutW4qufhD2KS0ydFrKxwsOrEGFzW0ekMw434PZ9wN8gJaFY1CRfbAE/K5XqP1+GjTw8r+yQTcayn7QWmJulpHtwD3g9b4kGN6Cv71RXEf/dr7oN4+uZ8VNLcDB+oHdN5z8Z2MAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XDGTkEr5; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=EJaNUrKK; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718009630; x=1749545630;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Xu76IUOUZSnVx0qZ6Q55ga0WXWjz38WkPs+YTjRvHdI=;
  b=XDGTkEr5dRRx+bP4V7TOrqcTnP9vmzzwwkwqmvFRuPtlH13dOE9cb3lA
   wikTC85CwyFUKJ90PjqoBlM9p/FagNrS2paWiNuqqzRalTM5BpOxQulng
   tAMbNHG+t7yHAFG3L/aP27wWQ1JDIPAqIgBu/1NE8D26ECczpSqMiUkDy
   oK8iazfxpEZW6r+V7c7O1DhaSP1sJIHtJnwsbkvogbG3OgDfRj2Mmozho
   cUGvWlZZ1byP7fdHtL0iZZUFcC7AtEnKOi56/CfrL9lk0kUftlZrDTPDf
   POxYUY1SHfv/Yd65NngCEA7WEAXIBP/zDAF6cGj9HdlOAAL3M0Nvfo4F+
   w==;
X-CSE-ConnectionGUID: CPrsuUo2TPCCQyN5mnLHUw==
X-CSE-MsgGUID: mvXsEhVhRpSjUu8Kxocvuw==
X-IronPort-AV: E=Sophos;i="6.08,227,1712592000"; 
   d="scan'208";a="18669136"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2024 16:53:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tk7sM17/jssoVpEf3OHG6xgStix4muCDsnC+AR8JRXdMk5I3HrFiWq+q29PuTaIYUk7P609hepRcD1mdb/v5jnoyTLctASLeRvqJcxQH91g06jD/kcKbzmyw+EDIQn6RQ00Kv3F7OPgGscEYyaxWdc7vzvizfdq/F+TA7n8ZIrCjxZeV75JLDNspKwWNCIN6rEq4W3ygcd8q+4nJ/H3eOPnerlKuk8yrIclndrBX3sySudDXOFfWQvDtqABNXQ94YOVyaM3djqXIzR0X+06+0qCdBu2J0SbJKV11l3E/hqMyfv/fg2cV+QrHXkgrF0iUuj5sTp/VpjCOAifuP29Jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xu76IUOUZSnVx0qZ6Q55ga0WXWjz38WkPs+YTjRvHdI=;
 b=JbwcGtAlR+GynMyQ/9juHFAsQXs8V7JHMw/dWyTC8jYv1PCeTgi50+1qIRvPNJTSVX9Wt/lSJsAP0XVTteyqadG5+wh5r+p4o835aIjsbnuUuI8h8sDoV8b6SVvvf3dON3/Um5FN2e0xWlfOoqrMAdds19CdLb91aCS4thJu9XtyiOIeCOwqNV8Qk5o7/A9ItNFtiZ4hjwYQC2KY3PdXuuWDOahaqgtf9+MBTpELf+wx4GwgrkJ4Wi7ImI85qV3/7CO+EhLb6IFSiYWOy5MZppq1xNU7w6G5+ewJGAUXKrSzemymLR31ffwffDzhB4NyNcw6MWphAoBum4Uv8ennzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xu76IUOUZSnVx0qZ6Q55ga0WXWjz38WkPs+YTjRvHdI=;
 b=EJaNUrKKBLyOEJQVfWxrRm6j7/SLjq3K/nlELTKA2sAtIzxp0FnGLVOdBFamxuRmQvoUBcw9bghC+PUoj+QYmAIRuOzofmYvYZKewOEOForsPDHanVXO0sbygLyUwKDP/u2yKSjOYYUw6QquX22OqahmuMG8hxNNbAKnIm7kd0E=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7721.namprd04.prod.outlook.com (2603:10b6:806:14e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 08:53:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 08:53:40 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: HAN Yuwei <hrx@bupt.moe>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [BUG] unable to mount zoned volume after force shutdown
Thread-Topic: [BUG] unable to mount zoned volume after force shutdown
Thread-Index: AQHauhQr6SuMoAb9C0CqQJ5ZLB9fJrHAszeA
Date: Mon, 10 Jun 2024 08:53:40 +0000
Message-ID: <ab92f3bd-c1ca-496f-bcf7-d806459d9ce7@wdc.com>
References: <CD222A40B0129641+992beaf5-2aa9-4ad4-bb3f-ee915393bab1@bupt.moe>
In-Reply-To: <CD222A40B0129641+992beaf5-2aa9-4ad4-bb3f-ee915393bab1@bupt.moe>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7721:EE_
x-ms-office365-filtering-correlation-id: 789f56bd-80f5-46db-b4a2-08dc892ad31b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGRPK3djKzJDZGxvR0FiVWVCekIzcGUwQkQrWTNwczNkOUxJeWMvVWRSQXll?=
 =?utf-8?B?dTR5akhaY25PVkVYelZrSVRsNTFqZHpxejJISTE5dlVJeXBDcituaDJWcUgz?=
 =?utf-8?B?TlhqS2crbUE0enkvMUt0YUMxRm0rZjJsT28wYmQyZTJvR2orcGFHTTlYUjVy?=
 =?utf-8?B?STBpNUUzczRmSTRQZFBYN0dvWFJvZVdVMDRGSzVyeFBzb3h6TFEzUXlMZGhR?=
 =?utf-8?B?SWxnYWhxdW5JZUMxaHUwdnhSenBwNkxRZWFnVEpiZVlvQ1Q5V3AxUlRrdEdk?=
 =?utf-8?B?L1gxY2N3N1lmS3ZybFQyOGV3Q3NHVUdacUF0RnZBNFc1N3MrS1pZR1VMR21p?=
 =?utf-8?B?NVZxbS9OejJIZUhJMWVWSVRyUlpHNE5JL3UvWDZxUnpsUUplVVdsVkRUUGhY?=
 =?utf-8?B?emJNbGxVMXZIdFpMRGMrUkRycGllK3J3cEczUEhpQkxoSEN0UjFRRlc2bFc2?=
 =?utf-8?B?N3Z0RlEwRDJ3Rk53SkVaS3l3Z0Y5Nk1JSVQxMWFqQ1kwT0VQaHBZMXY4SHNk?=
 =?utf-8?B?WmhRdGFzdWVWVGtDK1d4SlY4amFyN3IyL3pUNjBLbENDSnVla0ZRQnlvSnJE?=
 =?utf-8?B?SStNbjNxNmhTblVHdG5KOTdrYUJIZ2VDZEplVlhsZWFIT1ZveHY3NnJOdHJP?=
 =?utf-8?B?Q3BCNUNrYnRjSE1FZ3kwNUJ5RTg3c2U5QUp5NlgwbUJ2eFhJZThZOU4rOVpQ?=
 =?utf-8?B?dm1OanY5Yk10dmpVbzdvQ3hVTkI0NExrTVl1ajdFVEF5TVREWHcrdEFGd0FL?=
 =?utf-8?B?ejIvNDNYUkJubjdZNHplLzNtdDFqVktZZlpFUDhFSVEyend5dFl6ZHd4VVhX?=
 =?utf-8?B?dXY3MjdHLzNXTmFXUEVLQUFQU2xTWUxtNGVhcHJOSDVseDIxUlFhY25NZVBO?=
 =?utf-8?B?SkE1eUwrUm5kNnZpQ1U3ZVgxVFJOZG9TV0VPaG1qY1NsRC9CSTlQOGRsQzJK?=
 =?utf-8?B?SldQUlI1RUxCZ0liRnlmYUJDTER3THhpcVM0eU1OUUl1TmM1czJ2dXJnalpN?=
 =?utf-8?B?aHZjV0RRdWZYamtGRytCdmxKMVp6SDYxSVJLN3R6OXRrbWFyQ3lDNUc5OXdn?=
 =?utf-8?B?TW5DRHBhR3UweVFGeWd1VnhmSFFrRm1uSUl2enhEMWZBcVEvWE0zSXRGdEdU?=
 =?utf-8?B?eDZIT2JFRzZla25ua2tGd255akw1OWorQ1pQVEo0OTRPQXVtMkZMWGFUL1pN?=
 =?utf-8?B?MGRHbzNUbVFtT2FZQVp5eFYzUis1WURORG16eFRIUXp4STEwZzEveWlTcVd3?=
 =?utf-8?B?SW9tcHRBQzFLbEYwWDQxK0JoOXR6eUlQdTdMTzQ2K0h0a2JvMmR2YzhrczJZ?=
 =?utf-8?B?enl5YUFkTmhHajZLejNEc2pUV2ZVYk1sSE83NzlMYVdNMmVqK1BReEU2TGoy?=
 =?utf-8?B?VVRIYUVDWHV5Mmx5WXFiUjhxWGxxK0k5Z0FYajJnMjdCb1dSNzluQi8yQ05v?=
 =?utf-8?B?eVZYcTV2cVcvYi9ERkpzclZRMUhUQmRUdTRpVkMxaWpOMlVnT2MvSlRUeTIr?=
 =?utf-8?B?ckdnVWpvS2QyZThwODNrUHJFd3N5R1FHYlVOMWs1dk8rdU5xUlNiUEhUQWRC?=
 =?utf-8?B?ckd6ZEc2c2pYWHNhOVRaeVgvQUZPTCtXNmlFTUlLWXhURFhVRUNJREFzMHA3?=
 =?utf-8?B?RlNoOGdKL0F0MVlMcU9NK0IvKzMxTFFZbTZDTmJpZEVodDNOenBGRHdpandk?=
 =?utf-8?B?YkdYNmVaQmpSWXRjaXJNSXNhRGpHTTFtVE1XalRYK1JnRW9TdENLcW91M3Yx?=
 =?utf-8?B?Rk5McS9ueFVJcGpMSGxWZGYvUmRLVFg1MzFVSFljSWV1aE42ZWkvWjFRL3M2?=
 =?utf-8?Q?F+ewqlHWvy2vnUBYwevGFub3IAROzh8ydfgwQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RCtwWE85Mm1qSkxubHJacmJ4WlZUVnowaDFzTjZuZ3BjUDk4azlFQTdEcldZ?=
 =?utf-8?B?blFTZ0RxUG5DMWd1VUx6WEh0c1pmL0MvSEhONS9KQkZPTW9YclpCR0I5OE1s?=
 =?utf-8?B?S293TFRVMmtub2o5dTFtNjBOelJMK2IrbzZ0VFFIZzJpVDJadm55Tk1ndi8w?=
 =?utf-8?B?dHpDbWtNbVZiSXVBM2c0OXZlVnY1OStEaTlDd2lGVy9sM05ZNVZTM3dnYVBl?=
 =?utf-8?B?QytCd1VNajlZUkIzK0NzNmZ1YWxaeVJnUjlCblM4NWJKaWVGM1RIMjJPK1Fq?=
 =?utf-8?B?Qm96dkRhbTFXSFpqM1A3WU96VzhDUVBVOGp0RHBiYldQZlo1UjJ2c3R3ZTNV?=
 =?utf-8?B?MlErVENWalhOZkJaRG5Pekh4SW1yQ2hWd3ZJWnZidGZJQUU1Yk12SmxHdDBF?=
 =?utf-8?B?WGRiS1lWYTBscXBTRkswcDRuM3V4VjgwSGdaakhjVGhYUXU5OG54ZHk1VGVK?=
 =?utf-8?B?N0MxR1VVaHlhZ3VMZVVqdXhnRHZPZGF4V2ZCVGw0RncyUG5nbFErelVDSUFG?=
 =?utf-8?B?bkUyNXVKS3lJVWFXTDdxL2NLaDg0Q0xYRHUyeWEyOFJmM0kzOUh5cXFIUHZh?=
 =?utf-8?B?TUtySmxENUtxcUN4NFVHS2RlVmRMTFpVTHBtbnRzeEg4ckxEMytBSlR2VlZ6?=
 =?utf-8?B?dFYxM1grUGNrSWdnbUp6aDZ4Sy8reGgxdjMvaVhBUFFIM1hSNldTUnRGV2p3?=
 =?utf-8?B?ODBxQ2RpOE91NHEyc0IrVDVTMU5Cd1VlQ3lJV2lmTGdscmZDb00yNlhEcXBj?=
 =?utf-8?B?ZmNGZ0JtY20xNFNvaWttbTFjdVlHWjNYYVBGT3R3ZnpEb29KK3ppUkVuK2dR?=
 =?utf-8?B?dk1VTFhOTHFHazZIM0diUll2alZrUkhOOEJqZE5Zc1BWN1FtNkhlUUV5N1lM?=
 =?utf-8?B?aElsZ084aHZBZUtUQmt0Y1E2V1BUT1E2S0J4T2NaVm9yTldjVTNSVjBZdEtM?=
 =?utf-8?B?WFlsSUIxVVdjQzNjeGUyVWpKZWFPU21EOFdTOUR2NU5xdFp5aUNWVHNzcVVH?=
 =?utf-8?B?VGFLdHp5UXdWRTRDQWN1eDZOdmF1Uk1ZMTJJclNLRXlIbGFmTWdrcWlRMktx?=
 =?utf-8?B?QVh4Q2F3TVNFR05YNkZnL3VROTJaMmZkL1JSUnFrNnNqRVRHMUNuUW9zQTN6?=
 =?utf-8?B?RFVVbHVJR3pmSWgzeXFvT0pzWmhMNEw3UTFCd2ZaWDdISit0RExycE01SFNx?=
 =?utf-8?B?T1VLcnRVenhBdnZQMmk2M3NDelBwOG1pNFA1NWpOcC91RnVUeDB6bmlHYkJQ?=
 =?utf-8?B?MGdJTml4WkVseHJjTE5KeTl2dDIzaEN5ME4rMm81NFhuRlV0QXNxY2c0Wk5v?=
 =?utf-8?B?UStLZThmWFlHZGsybXFsZnVTTVBzdmZCQ3dDSytTVGh6SDUyQzM3QzJSWC9B?=
 =?utf-8?B?MVpMcHZoT2pQOEllZ0JEVVJZL2VvWGprTlg0V2dzK0MyeGJrN09rRHNXWTN2?=
 =?utf-8?B?bmV6a3EyeXBBbkNZb29RK2lIQTRUTGFza3lmajQ1Y1JEcmtYWVo2T013d2hG?=
 =?utf-8?B?N0thU3hUSUVsRDlLZjZXa3JaTlk3ZThRSEg3NTFQRzFKQjR2aEh2c3g0SzBH?=
 =?utf-8?B?M0ZKQzQ0bnIxSFVFWGlPSGo3eVR2c2x5TEdQckEwcytwTkV6aHhoMXNhaUw0?=
 =?utf-8?B?RHBiV2w0VlUvbFZHdjNFcEJydHE0MitTdDVmZ1VkQmlkNmY3cHRGS0VFK2Iv?=
 =?utf-8?B?TWFNZkMrNHZydGlFR1Bva2lsYUo5cXIxd3BMNk9vRGtJd1lFVldXNEJ4dG1M?=
 =?utf-8?B?NklFaDNzaHBIVUpSeWVNSTVOOWpqbGJsL1ZhNmpLZXY5Rk90UXpPRVNIcU52?=
 =?utf-8?B?Sk5sbjJ1Skw5bHdzNDU2M3pCY2g5SS9oZVdhTEphWUJsRGRHUkVMZE1zUE5k?=
 =?utf-8?B?UGFlbC9Pa3ViSXZFZEZVTmkyN3JGajZyZTdFbW5Hb3ZtU21SK2xCTFRTckpG?=
 =?utf-8?B?QUhBaXk0UEx5OFRxbVJmMTIwRGtyeXVnRHZHTjQ2L05BNTJwbUxVczBvdzU4?=
 =?utf-8?B?WHoraHhMbWZUVEZmd3hLUWI2Y0FzS1dNZnJCNTA2YkJuVWRLYXNRVDl6ZWxn?=
 =?utf-8?B?THVjS3dDWWxkYWZITVlDVnErdW9UZzc5amJQS3BLMEl2MVFZYmpvQXk3K2dw?=
 =?utf-8?B?UlpISTJxU3FjdnNGRXNaQ05icWRJWVBEbXVnTGpzZDJWcnRJTHY5TW5XWlAx?=
 =?utf-8?B?NUdDY3gzelhKeWY0NktsWTNCbmJZck15bWh1T1Z1cytZMW9HSE5VeHV3US9U?=
 =?utf-8?B?eUF1czhXeURnSk01alp6TTlubzZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3255F5BDF0C3B84DBD5914EAC4F8F125@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0w9tDTasLtAWsQjb0LoeGbgJLyKOOfX0DIUdnqTq3rjpUKTiIJl0svrlgUJlZDoHOCzGayo69QSej551TyZQSbFCtpUMaGnoaw2dQy4bWBUh+aGChQFW8a7osn+AlWi1pp25gZ9KZvyG8dRMt/umh8m5Xx+3F+FIJhcaSOdOwop0M57xvRJEPbaB8mihnb4T4Pr8AVu7sKcvuRvc0qqCTWAneJZAUYL02iqbbi49SfOcUvCMrr20CRE8rbuTfwBj77SheSzJdb9auGPRr8+//7ZZxAXL5NhMzfLAb+gY2AeVDwz37oJEu2A5m/ynnJFKLF6jUbLnwCzdbtpweJnclLSD1VWqav2wrMYdcLLc6/FJYmDDesryKV7qVQXBRl9NRrQODx4i0O1MCcrg7PatGOXjTq12E6e9vcCVd7fzKfoYbT9NfcATXblkxEdb4vEhrrZHffJiSY7PYAmlAqG5jt669n53NY70A6BVXo2yvlTzd6rg8No9Syrq0LMbF5m1wx0t2H2nFPPGm28qV5vSZMRV6rsDGxtcdVFts1BlFXPxTB/P6d8ZLwlkcfpnFkhdHe8rVBWqL2JSpk9Jrqf2YeObmbNgSJXxIC+uz6WgShU483xT7ToQGDmN8LV+auzW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789f56bd-80f5-46db-b4a2-08dc892ad31b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 08:53:40.3006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1zIjn0XbVz7+8g3RQplgspOSA3Cbk0HwS9beOmnBxbo55x2TjjpPv4GdCl0+zYRFdTZt5FBrpy26HW8iU9tMu9bXM9conwom6H5iCRcXpoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7721

T24gMDkuMDYuMjQgMDQ6MjQsIEhBTiBZdXdlaSB3cm90ZToNCj4gSSBjYW4ndCBtb3VudCB2b2x1
bWUgb24gbXVsdGlwbGUgem9uZWQgZGV2aWNlIHdoaWNoIGRhdGEgcHJvZmlsZSBpcyANCj4gc2lu
Z2xlICYgbWV0YWRhdGEgcHJvZmlsZSBpcyByYWlkMS4NCj4gSXQgZXhwZXJpZW5jZWQgbXVsdGlw
bGUgZm9yY2VkIHNodXRkb3duIGR1ZSB0byBrZXJuZWwgNi4xMCBjYW4ndCANCj4gcHJvcGVybHkg
c2h1dGRvd24gb24gbG9vbmdhcmNoLg0KPiANCj4gIyBkbWVzZw0KPiANCj4gWyAxOTYzLjY5ODc5
M10gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYik6IGZpcnN0IG1vdW50IG9mIGZpbGVzeXN0ZW0gDQo+
IGI1YjJkN2Q5LTlmMjctNDkwNy1hNTU4LTc3ZThlODZkZjkzMw0KPiBbIDE5NjMuNzA3ODAxXSBC
VFJGUyBpbmZvIChkZXZpY2Ugc2RiKTogdXNpbmcgY3JjMzJjIChjcmMzMmMtZ2VuZXJpYykgDQo+
IGNoZWNrc3VtIGFsZ29yaXRobQ0KPiBbIDE5NjMuNzE1NTk3XSBCVFJGUyBpbmZvIChkZXZpY2Ug
c2RiKTogdXNpbmcgZnJlZS1zcGFjZS10cmVlDQo+IFsgMTk2NS40OTIwNjZdIEJUUkZTIGluZm8g
KGRldmljZSBzZGIpOiBob3N0LW1hbmFnZWQgem9uZWQgYmxvY2sgZGV2aWNlIA0KPiAvZGV2L3Nk
YiwgNTIxNTYgem9uZXMgb2YgMjY4NDM1NDU2IGJ5dGVzDQo+IFsgMTk2Ni45NTM1OTBdIEJUUkZT
IGluZm8gKGRldmljZSBzZGIpOiBob3N0LW1hbmFnZWQgem9uZWQgYmxvY2sgZGV2aWNlIA0KPiAv
ZGV2L3NkYywgNTIxNTYgem9uZXMgb2YgMjY4NDM1NDU2IGJ5dGVzDQo+IFsgMTk2Ny4zNDY3NThd
IEJUUkZTIGluZm8gKGRldmljZSBzZGIpOiB6b25lZCBtb2RlIGVuYWJsZWQgd2l0aCB6b25lIA0K
PiBzaXplIDI2ODQzNTQ1Ng0KPiBbIDIwMjYuMjg3MzU2XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNk
Yik6IHpvbmVkOiB3cml0ZSBwb2ludGVyIG9mZnNldCANCj4gbWlzbWF0Y2ggb2Ygem9uZXMgaW4g
cmFpZDEgcHJvZmlsZQ0KPiBbIDIwMjYuMjk2NDQ1XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkYik6
IHpvbmVkOiBmYWlsZWQgdG8gbG9hZCB6b25lIGluZm8gDQo+IG9mIGJnIDUzOTk4NDc2MzI4OTYN
Cj4gWyAyMDI2LjMwNDU3Nl0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGIpOiBmYWlsZWQgdG8gcmVh
ZCBibG9jayBncm91cHM6IC01DQo+IFsgMjAyNi4zNTI1NDddIEJUUkZTIGVycm9yIChkZXZpY2Ug
c2RiKTogb3Blbl9jdHJlZSBmYWlsZWQNCj4gDQoNCkNhbiB5b3UgY2hlY2sgdGhlIHdyaXRlIHBv
aW50ZXJzIGZvciB0aGUgem9uZXMgbWFwcGluZyB0byB0aGlzIGJsb2NrIGdyb3VwPw0KDQp0aGF0
IHNob3VsZCBiZQ0KYmxrem9uZSByZXBvcnQgLWMgMSAtbyAweDI3NEEwMDAwMCAvZGV2L3NkYg0K
YW5kIGZvciB0aGUgb3RoZXIgZGV2aWNlIGFzIHdlbGwNCg0KVGhhbmtzLA0KCUpvaGFubmVzDQo=

