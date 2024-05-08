Return-Path: <linux-btrfs+bounces-4843-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 600418C00CF
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 17:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF321F272E7
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 15:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF08F1272B7;
	Wed,  8 May 2024 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SMFZH0NU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Bitj2wnT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38969126F3D
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181613; cv=fail; b=aZeZyPrXuITZA5ZHxT7T+ETP2i/4C7WQOvVhO9sKnp3TZZ8xYhAmL0UeUZP4V5VQ5f1DM+xgEHD45uKmOInGWHHM4abr7i8Q45UmEzPIvhPYWQabokaiPo8xXSJwbzk/xqGWdDPPHB4l1ViHTocktl/A467yN4hf47VyLKepu0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181613; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=upktDBZssuMl3hKjIirPuKJVPIyd0h8D2HrRRqUE/ybvt+TVWeWA/EiTBOGH4Oq0dj31HvOtu7AyL/F2IvjXwtZYJGmQ5e4omMNuXfSOkXYRJ/wIj+KHHv25Ka4W1k7g+aue7tTFi+6yawUQqH1PeUe6ExgyC7LQWLAgKf8+34w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SMFZH0NU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Bitj2wnT; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715181612; x=1746717612;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=SMFZH0NUb84ryeUWj5720l78SHVQROoTJ/TbZ8GMd9XxEaaY9bmAKhqs
   eLDeuOqK/e9CzFaPAVE1GRF6WL24zMA+ReZd/9KKQQWZUynzlc8gReSeL
   y3LToXhqjCr4Ye48YusohTF7U0T/32SgSu4JJJEnnMlHpwY99JcFIr53L
   R8m+1Uw9ejupK75Vvd+JUCLqeFgb8CaOIRVAVpmc5qSWW/Gy3g5tADruy
   ZuvtWyWYFIkzxTWYX7M/rGN1aKvMObwaHtiLdiJHw9pvXXlag6CczoZcV
   nhqNWfJl+pZZAP7fRZvzI1Z+uyVr++HAgb/3WN7+RAiIUyVWzoShxze7P
   g==;
X-CSE-ConnectionGUID: LNI2O1PMQCizaSt7jWxzAg==
X-CSE-MsgGUID: GaI8rfNWSTmZugG1YQlFKw==
X-IronPort-AV: E=Sophos;i="6.08,145,1712592000"; 
   d="scan'208";a="15629548"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2024 23:20:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyWWqmw5myoLSHlA8DA5jiJmxa+aDwSzMi4eQRW5akwqLCGpg0jACoA1674hYMnDfp/6e6DKKHymqKg7Bi8uTIubNS2HfMBXyDc7YLQ96o0oGMzqMfNBXHx0fz6otSjHtVPefmCTSEaC+j1+BId42NPvpsFrUdKVlQJ4SXjSp/JUq7qCNbRG6TsQZGDRl2r1f2qNrgUExYoixtE9+GWTWmLkI9OzCfMSdcFUg1bHpO9GeS7m31pl4cR8qEq6r5ciYXj3FnDeAb8JS87TiRtrH0GgBtpb1F7QpUxDmfOT1TZ4a8B5sk6ik1bDVwmbZCoRYHEYtejMjPLIXE4UZiNTHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=T6nhRTDog6t3zGfbhKRscqkjfOF2g6BxqWd5JJxBIVezmKiRUrmGB6HZmXHzleCIr9KKS+8+ttgKubSIhp72khQWM+Pn4uEgrssHj3GBR4BQK0uHpt0jSR7DrCdEdCxbwW8nRbTvNG8DzRqjWyj8ZmXl6gIydPZ9R3V757Ma/8C/5jb6W7R4BTmZ3VIKeezFqWcXIC64vpKv2uYjBNHXaKTjTbyrgBgoOmvzaM7OfB0jebK118Hzpj5OCTYH5dyIM5LY7p8m4xJcd1GnqNXbBeP3y/0M39Ia+Lyck5MgmyF2P/yV1KoDn1hbVbi5bp5346FctvdQGlGapF5N6pBf9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Bitj2wnTmmXKgyQyDAjH1NJNjF4AZJe0HFkVpJHzuXBRUUu9AfqctpUqZmpl4wbOWqRQY2e7K0DdanxicuchGw4UUEFp7bMe7Wjka9iOp7qPJMb0B0oZWyxY6fHD/nnoAq7ebXlCw/M58lgTdVW09tNDRw6ZeDTI9/VHw5VwTis=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by IA3PR04MB9303.namprd04.prod.outlook.com (2603:10b6:208:528::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 15:20:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 15:20:02 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: make btrfs_get_dev_zone() static
Thread-Topic: [PATCH] btrfs: zoned: make btrfs_get_dev_zone() static
Thread-Index: AQHaoTm+cimSKbnscUi6iYPHct+TBbGNc/CA
Date: Wed, 8 May 2024 15:20:02 +0000
Message-ID: <4ba7a6db-76e3-44b8-bf49-67e0836127ac@wdc.com>
References:
 <5609a1191a2bba44aef148a56b67c313b7713a41.1715167141.git.fdmanana@suse.com>
In-Reply-To:
 <5609a1191a2bba44aef148a56b67c313b7713a41.1715167141.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|IA3PR04MB9303:EE_
x-ms-office365-filtering-correlation-id: 94e24da8-b0b2-44cb-14a7-08dc6f7254f3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?VUFjOG14TDFKdG92VlZjNVU3enlkUWwzVlY0cmxrdmNQWDNLS0NtZUJQc1NZ?=
 =?utf-8?B?WHJUcmZUR05BRXBKTWJabVdBa0IvQm1RUDU3NVkwaXdCaG81SlhkRlBkSUJq?=
 =?utf-8?B?Mmc5d291K2J5M0diNlQ2a2xNVDZuUnl2OHMwMTFxZXhhYnNsK20wdXlGODgw?=
 =?utf-8?B?SHIybFl5V09tMjV4VXVCSXBka3lwU2hNT3k0cCtNYk5ERU95VDFrY2lBcXVs?=
 =?utf-8?B?azRRWkdkNllieWRzczRDV0VISEJLNTFSdDBXYVZvOXkrZitYQi80anZEdHJ0?=
 =?utf-8?B?Z0ozcnBHWXFkeFlOd2VhN1FhamJGSHJPQjJBaklOS2k4YzBobFVDM3l5T0hU?=
 =?utf-8?B?NjJNWWpwYnhiWWtOQVp5M2lGZUlBNk1ZSjhIRXdoTnhKcCtXM29SOGF5alpv?=
 =?utf-8?B?VzBRU0c3WlBIbXM1Q0JFYUZ4c0h3clNhaEx5aEl2NDEyRVJJNytzbEJvOXVK?=
 =?utf-8?B?VVplazQzQ0VEd2k1aDRWSitXSTVPQ2ZYMG05YldyeTdPOGk5NFVUUTN5TG0z?=
 =?utf-8?B?NGZQcVpocEVGT2dMLzNuUTFPc25XK1JaRkVUYklKVkV6YSs4UnFielZvSFJH?=
 =?utf-8?B?MGhBOWhZUGZvMDNqQkZzdjNleGYzUkxaM1l5a21aRW9uNWlqSVhQU2gzNHQ0?=
 =?utf-8?B?STJSK2lENGk3d0M3Qlo4QU1XbnNhS3dXOHJPc1N6TFE5SnE2V3FjM2FIWmVS?=
 =?utf-8?B?VnAxbjJ2MEVyK2ZITmxUUWVheWZzcCswTWpVSGZYQXN6N290U2JNbzFUU1R3?=
 =?utf-8?B?TzhtWWdGcmFIRTZmaVFCSklCcVdRb2FPRVFSMTZVMmFlMjV4dnA2cnRQNllp?=
 =?utf-8?B?WkxjbWcycUNYSzkvK3dSTkJyTWJpQ2huVGlTOG5JaXcwdmJxYktieDNHUWhB?=
 =?utf-8?B?VVRnWlkxZUl4ekdhOGx6bGsrbGVMQUlTblZTaU96K1ZWZmdJa1FZMjBLOFpL?=
 =?utf-8?B?bU9oR0ExL09rZXBLZkY4NWtnM3pucm1iWWdleGcxa1o0dXhOYkdibHNyRlIv?=
 =?utf-8?B?ZzBlTXd3VjBOOVNMZDY0Z2g5QkdPQ1VXMEc1WDFSRjR0WEwzR3hGNHZ4aDhM?=
 =?utf-8?B?NnRlbnVHUXloVkNCdlRDdVBlSG1keUlYT1p0R2dJWnV6TWFwSlZmak1sd2hR?=
 =?utf-8?B?dk5uaUF6TisrS1FrZ2FKSXFYU3dld2tJSkhBSklPRUhHK201Ulh4dlhqNFNO?=
 =?utf-8?B?a2x4WGRQaDhVUXBZZnlIYVhmUTQ3Z0ErTFdjTWcrTm11S3JNZWtjVGY1d2R3?=
 =?utf-8?B?ZkdGWmt3Vlg2V3pyMnk5VnhNSHFHMG9LM25jZDNGVGtKNkRZdW5Xd0wrUys3?=
 =?utf-8?B?YmYwUlh0Y0UxQk9HeE9BUTMwYS9LeitnVlpycHpMbWtHM09wNVBOcmdDSnNE?=
 =?utf-8?B?ZVBDWGJxT3RKTk5DVjI4QllUTENVMDYwVHRiV0Y3SEN1MWhqNFVRMW8xNEVZ?=
 =?utf-8?B?YjdQUTc2VU1SZXBsMmtFdlZabzdPOUlpN1I4RWN6MEMwUmxwUWZKNlVCTEEz?=
 =?utf-8?B?UlZKZk14bXdGcG0ram5heE1EYTRCanIxRVJrZ0sxdVRvcmNseXFub3FFVW1S?=
 =?utf-8?B?WTJhdGdnWEZHT3hhYW9NZDdUVkJUWUh4MW50ZnN3NUcrRmpwZEk2VUhMZW1r?=
 =?utf-8?B?M1kvRHMwOVVZZjZYUVF2bUUzbTYrekNMUVhGY3ptMU5QcVNqV0JrTzJrUnE0?=
 =?utf-8?B?MFlGeDgxWHEzZS8vV1ZLUStPNXdkNi9MZ25uN1JYS21hRE9PSTJyeUJYYlBz?=
 =?utf-8?B?UXd5MFgwbWZKQ0cxMTFuY1BvUlA2UE56bzg2UGFaRmZxSGdrYzVtUEFjallK?=
 =?utf-8?B?MEt5Qm0vSVZiWUpudjhldz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2tsYllTVWhhVmtKQWwxK0wvQ2tMcDFlcWxtdkl5Q0NvOUxLZ0s0UDV1bUIr?=
 =?utf-8?B?K0pKR0laeWdXS29MZXBoalozcm1XNVVseUh4TzhURkpROG42b1Ezck9hS1dE?=
 =?utf-8?B?M1hDNHUvancvUG8veXVISTFjV0V6clh2TXpMWUZXMDI0amVIcXpteTlJZ3kz?=
 =?utf-8?B?VFY5MzN6dDJDS2dOUjJPZWY5U3dEdVBkMkVYNFh4cFlnb1NYcEVhYkp0eXJV?=
 =?utf-8?B?Q3VvZnZkbmVub1lybHlOdGt6UTExNEswQWhiVG5WRnlkTFZwVkpCdUFDL1hF?=
 =?utf-8?B?Vnd4bDgxYmVHMHBPcDJwT0E1clBiZ0hZeDltakJIMGRiKzh3TG4wVlhmaGlv?=
 =?utf-8?B?N0NWVVA4L3dHZ2IxMlJ0OFR3ZGc0MUo4MUF1V0E3SDd4RitHalFaUDdjQWx3?=
 =?utf-8?B?M0pFdUlFU3d4RE5VM3l4WHhsbGdyS3p4SGc0RTNTd1NVclFpTEQ5L1AzM09q?=
 =?utf-8?B?Qm1XWWZGdFhiRm0wUi83ODJUSVNvS1UrREFxT2hpeC9ISnc0SmNGZ091VHlL?=
 =?utf-8?B?VGNqcEZQQTlDNE1HUkNDVmp1SS9GdDBYK0x4WjNFOXFjRG01SG5JUDdoMnZM?=
 =?utf-8?B?WmZlK3JzZkxEZzRON2MwRG5KQVJMYmsyMThSS1R1RTlFbHBtT3ZjS1RTbTZE?=
 =?utf-8?B?aVJ4b0dJdlZlVGZSSDNnQXpFREMyaWdTWnlBVlZmaTA1UTVEZ0tyM3VuY0Jz?=
 =?utf-8?B?bjY4M1k3TTFFanZiWmpIamhHZ1AxVGxlOWxJeXpadVVqWDMrekIzRmp0VE5L?=
 =?utf-8?B?bi92eWRONTBQRUZMK0NyZVZNM3hpUmllOEJHMjFyRTFBS25vRW5ZOW1WYnpK?=
 =?utf-8?B?RzlQQzlBME4vSWloSzgzUDlxYk5ZczluVVV2cW9NWUYyMVJwWkZsVGRBSzE3?=
 =?utf-8?B?RzFFajYvNStsVVZHY0VjWG5UOTgzMDJKaFA2OTNTK09xTjhsVU9LbjRPK3ZX?=
 =?utf-8?B?ekQ2TTZoRUx4ZXdVdUlqN1NJZWtqeHdUSGU2ekdVRWxFSjB5REhiNGtxQnpH?=
 =?utf-8?B?ZGRmeGorV1B6V1NHb04wSlMwbnZkNjg5QzFLNHNaVGFFMUtiNzBUNFprV0N5?=
 =?utf-8?B?aVhuZTcvdlR6eTJnWU0vVHJvSW9TTlNjZm1uRmpaek1teHZSZ2dVODduamd3?=
 =?utf-8?B?QUx1RVF2RGdycEs5WThZbWRiQkxLTHVOYy82Tjk0WFF3c3hpZkVtRnNmL2dO?=
 =?utf-8?B?dXVkZmxTcXNuQTA1cnRpVG9XUnBNL2lYUnVCRkNYTDBkZUkvd202MkwzakZl?=
 =?utf-8?B?TW8zaXhSREMyVWJFSi9QZkhGSDVYYWwvME9nMTExd2d0OXVOVFBacnBDd1Jt?=
 =?utf-8?B?enBWSWhJWkpjakJCV1ZZZ2dpRmdWTEdkQ1kzOG94NWs2U1BPeGdhMGdUcS90?=
 =?utf-8?B?RHN4WGZvZGZONWJ0N1IzNlFoaU9IZkJybjNtWWpUS0FRNjhYSldKNGs5RnpB?=
 =?utf-8?B?dk91MW04Q240cEkwcG9tL0VwU09PNFV5ZURhNDV1aU9mTkZDNlkxU0dacUFE?=
 =?utf-8?B?TXZ4QmRibkx3bXVWYnNCR0prR0V5RGtRK0RhNFBMTUNKU2RQRHkrYSs4a2kx?=
 =?utf-8?B?YXhEQ0dqdWdNRXAvMkl1TndLRjJVZHB5N1FwYU1CNHJaVHQxUUpHL3c4Z0NB?=
 =?utf-8?B?NklobXpqOXVmZ2Q3NjN1c1E2NlRab1pBTnNSUmVEWXJZMWZwUDRxaDlHeENq?=
 =?utf-8?B?Uld3ODhuZWFBNmJKdkpBQjdxVXlQSkQ0N1lvaDBVd1EwYlFZVVJkcDhBNnpF?=
 =?utf-8?B?WXpLVk9EK2ZPdmszaktnKzJlcXo3QnBjSHJHclRjY1hOV1BSUGl3K1pGNEJU?=
 =?utf-8?B?VkowWXQ4RlNuM0NDazEwZ0piODZxaEk0T2c5VHpCdmhpa1RMRWNwWHY2dmpm?=
 =?utf-8?B?OUhiSUpoZTdCL0lwZGRwczRLeE5GV2pKdFMzZGVMTEdjK0VWU2I4YmNlYzlj?=
 =?utf-8?B?Q2tUVjQ5QWFzV0ZDWDRpcXZBOVVFL2VvK1U0T1RuYXVmeFY3TDNsTkxYUVRi?=
 =?utf-8?B?S1JyNzZ4MElJdTl1MGE1NGh3YXczaHFETk5nZUxSOUVOK2JpOG1mcWdMcVIy?=
 =?utf-8?B?dHcxNjV5QzVwdFpSTlVYR3lIWjMrNDkranFRQTRiZDJZWDBIUUVSQjJScnV0?=
 =?utf-8?B?Nk1tMVZnVXhaMHBHQUhMQTNTelBreXJMeXZFeGZCcXIzNjlFQXhGdytGUC9X?=
 =?utf-8?B?Mm9LcHN2VTF2SXVrQlZPVzFMczB1WWNpUkxDeTltN1pGTXhMczlHMEMrOTdX?=
 =?utf-8?B?RndjaHR3aXZna0dhVktGR1ZrMzBRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78DE3F8E0B61B84B97BAE77F18DBB07E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zHPAfchC8YV5I2UZOrglvRfGwIQma/7DamRQX+N6T/lMVu9mX0W87x//f8F9jyB8yb4EX4bEUj2b+vLJkQC27uPgp56oqeMR8S4w1P5aQOGYqrI5XE5t7Wgb2/zd3YDMAzkM25M73kIW3zFER9HWKiJOBtx7Wdl/1aadEsM6KurI3JQ3ehFdwInmdmHevfcHOm7LkWJfEbpGab7EKiUB/PHXbAA4h2ChtpbP9Vcpb8sDdc4c4qivn56yZdq+Te5/Q8yCqhYu7GpMo08lww1G7bABlJHZQKO9PH9z1cuscRlBPha4Qpyu0x1bHJ5sa7YyG0lNUqOXxrU6h91TVhEjJeqNA8Rfdcn08R3zR37ENVpH7KTnBKQUrbWRbIrDgbTfwbOQ/TOxEPXGrCi3Ep9zwYHdkFps/GKapfZlSSTr2jwORr6eEYRmUSAsHjYIesddsc3ifOERfVL5eUcRYai0KnQeAt0z6wZrAXZ6Fj3YRdRNSN8M2oYwUhsAj5IcT6FO6YRRMSB+ceX1hqcnRIbIY1JwP81gO2BZykTGC7+jIaIFYbSqieYPbAswUPXpaQ8fQowtsG6/iEyvSHqbphDzXS8oowBfA90JqKzjoXOR48pNCB/pqZ8mun54YzFQsDCV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e24da8-b0b2-44cb-14a7-08dc6f7254f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 15:20:02.1523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lzffvEVz0JU5uP0IfehjYSI6CfD+G3Id4NJ0arNWJbj30pNXsqP2c6ovxAhtmXVnQHQSisjYBa48T2x/qI8Rj1/bNoPBtarHc/hPXK4G6Xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9303

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

