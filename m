Return-Path: <linux-btrfs+bounces-5182-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D899A8CB864
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 03:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B9B1C20430
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 01:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9DE182B9;
	Wed, 22 May 2024 01:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jVImPj44";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qrEMTXN7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA6923D0
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 01:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716340234; cv=fail; b=syPRgW8CrWztDJfHD00Sdf/DBxQXOh7npOQXevT55Zein3EokbEQC+tPVqB8Mke+qLiJRgU0YiZUxcACDDpbr6gURTyZhWmwqvupM9sRtORTnaY4bptLmkecaxoPQBEPNEV4g8ucp1Ns88Z30bcJF0ClKEnrO49TIxEV/svJp+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716340234; c=relaxed/simple;
	bh=bi+QHQVk2eGsqxY0WgdSfakixMlSp392Ll0TRDfTiKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gNP0tLNadwysuhnj6IZtxMadd6sG2LJkdhyfjijMsHhTZ+o4oLentzHnlX6TcEjlvO0VG5pipIdTHav7FjV7QnMd4OkCnp+aS+K7NSDRcQ+Cmay2lAO1VdIjO+q3HZZ9Up2+1DzVLnSIwhHWpdkiE81MgGqzm8M0sDV1ASZzPFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jVImPj44; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qrEMTXN7; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716340232; x=1747876232;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bi+QHQVk2eGsqxY0WgdSfakixMlSp392Ll0TRDfTiKw=;
  b=jVImPj44S7sYYSmp9FP/bH1z8BfBfSP3Vh5Etglg53bF6B30w7P3+Gq/
   I+FQMh4fzUGwMB+shdTbO+AuV64c3y/oaHShTk4Q/KJDJROHt7pnkbNQN
   3A+Yv7ywqdcN4NPtqAO2Hn9DqRXv4wBffmC64B1T6cIkn+daOqEZ+k+F7
   1TKrihYRhKzkQY0YNl/vPu2IFMgrTxS7kHxilSL2OKyP6ytYCPP7l62Dn
   gvxnJjNT0DCTP1noL74O30B9orlXnI06/53ECbgITt+CRxSm+2uFLJjjd
   7I3GpsHKWLpV6IFadiFgAPQIUc5PvP5FS2mgHHE+32ZT46O8+LuD73+l+
   w==;
X-CSE-ConnectionGUID: VAIXo9r+SImIsIgSNW21xw==
X-CSE-MsgGUID: QfaxzvZITtmjkdSxlqlQdA==
X-IronPort-AV: E=Sophos;i="6.08,179,1712592000"; 
   d="scan'208";a="16894409"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2024 09:10:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBK2ogGOvuX2k+mwff4AThf9gqdypsdv7bMPO/IBWjCF3WTH3ubj3mycj1GXjuWNdqU1jfgfUsC82gANwLCqOrVNxDf1nv693cRmrbQ4PrTsWN2736delI/H3Cfvq2Mvjkr423Uxo6ziBuAgOy6ari4B68+asV6KGiK7uoWjlojv4+Bzx9VLZSTsV+i8EXt1zi6npAdUyo7C4jzv5L/jE0hNt7SLpbo2JagPoB1LzHKg8TzoOoChPygY2sjE4zhDrfHWIQJyG+SVtfALqSWjBKJFF+tdHnUOyZW+DXz1fSj2W+xNvMMqfcyoK1Lnks92xV0Ygp6P3mnwJ24bicoMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bi+QHQVk2eGsqxY0WgdSfakixMlSp392Ll0TRDfTiKw=;
 b=juFjv1UK/ceiiDv2YEzaWKgoXoI1M2qtsdioXQ/VADxr66CQgBEg5fkTao8GBcxcam5sqg7ynOehO7kOUfVcqNwyy8jkOaNr+w+uF+neJFPE4xuiQIGHQZhbvHU620OFdyRArRmCTeA8aYDEqbViodBLrY/X4S2AMzTnDnlqlSdmL+yGZzS15aTPa19OfHf91gmJIZhXuGCQnctmNzZRq8rdjAtxkCOGFLoXzQ726jBll3oMZHjEmyvPxDi4mRLMvv6/NCoLyFWnn4vX7M5R4VtvfvB1xSVM1FXP/bEdf9WyJcY5aJFeHz3Dx1fgyTVHpXvkGtue3geEAe9BTilhQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bi+QHQVk2eGsqxY0WgdSfakixMlSp392Ll0TRDfTiKw=;
 b=qrEMTXN7at4hrxVTAhNU2KhGqqgf74HFw3rwCRMRqpsG8gMawZAz2J1UZ9G8qpnPmJohiEjZRP1q18+RZc0hYuhddu8gYqLKB7235YGX64RTrugEQ9B/Fe7Vezd78xuR/SuQQeJ3/TcsOf2VU16nbo7JhtsauonHkQk4dkb6QZw=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BY1PR04MB8749.namprd04.prod.outlook.com (2603:10b6:a03:532::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.18; Wed, 22 May
 2024 01:10:28 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%6]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 01:10:28 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
CC: Qu Wenruo <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>, "josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [PATCH v5 3/5] btrfs: lock subpage ranges in one go for
 writepage_delalloc()
Thread-Topic: [PATCH v5 3/5] btrfs: lock subpage ranges in one go for
 writepage_delalloc()
Thread-Index: AQHaqOFs5z6tA+7MAUmGvzzVgUkS6LGhW0gAgAAJbwCAADS5AIAAre8AgAAwiAA=
Date: Wed, 22 May 2024 01:10:28 +0000
Message-ID: <wymoqcgf7wp4ntvnd57iiohspzbwatawtzfv7qwgbcav6jpstn@lj75v3apavo3>
References: <cover.1716008374.git.wqu@suse.com>
 <b067a8a2c97f58f569991987ad8c3e9a2018cf06.1716008374.git.wqu@suse.com>
 <7oxv5xm6n4yg5r523pzm7hxql5pihrfylrducrsiwlk5k4jl7a@wxvlrl6w6cbu>
 <30371f39-18b1-4c3f-af31-b4927eab99a5@suse.com>
 <tdxf76yhloruo4pubudlhr2p4xf4spvmhrfsf56jfzxh544id3@fcaaplcp6vwp>
 <2b26245e-7602-4a00-b79a-eac481708ab3@gmx.com>
In-Reply-To: <2b26245e-7602-4a00-b79a-eac481708ab3@gmx.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BY1PR04MB8749:EE_
x-ms-office365-filtering-correlation-id: 3c156981-10a9-4f4d-171c-08dc79fbf830
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?NUI4S0VwcmJDTHdaQ3IwOHBLTDBmdjk4TitCU0NBK2RLNnczb3JpRUxKdENm?=
 =?utf-8?B?UTRlbEN3TE56RXh4UVpNWTFnazFKYkl5WnQ4OXI5QUkrZjlYaE1TMnhubEYv?=
 =?utf-8?B?LzlFTFdTSmlKNUJVOTloYklmdkFMY2ltbzMxNFMrOTk1MmZMYUNlQi95UHRU?=
 =?utf-8?B?L1YzUDNiVVE3SlV3RXhHN2pzYjg0aVNkOVg4ODMvNmtpdVdudjFBV2JVMk1W?=
 =?utf-8?B?dFdCSzFpbDVIMERNUTRteGhFQWZDajBnUW9kd1ZEdytzTDlUQ2Erd09WOEtI?=
 =?utf-8?B?Yk1qdk0xanBEYlZUQy9QdFgvSmlyb2NVZ2RjTkVJZlQ3NTdMdXZBQ3U2Tllj?=
 =?utf-8?B?Z1R6NFlQZS9mYjlPcjVRZmdhaTBlQ2x5NEZETGViSHlFNGg2T2hsUUs4cmhO?=
 =?utf-8?B?cDM0dk5NYWhlRERQNzlMUTFTQ2JjQmtoODVIMHNiUmFJWU5qZ2NaMTFBaDA5?=
 =?utf-8?B?dzMvc1RiZk5VbDJPTExvT0x4Q2grYW1OWUxXMStXbUxkMGJzQWZyS2xQSER0?=
 =?utf-8?B?OWRoTHc5Z1JDbWlJdTE2WitSTzZ0bCtrd3FMN04wMzEvSzEwYndVa2h2Tzcx?=
 =?utf-8?B?cUoyU2F3SzNSelBGSm0weEt4U3BEUUg0Q0VSUGdkb01DT2tjVTNwOWZDcFV1?=
 =?utf-8?B?RkswREFuMGE2RmZlZnZNTG9SYWpoM1pQcHhRU29Hd2xEa091eDB3S3BLMkRK?=
 =?utf-8?B?MU5DMFdHb3VwZWdpTUFySzRUK2ZabzJnak9QUjVSQXo4YWpldk83c0RKb2FK?=
 =?utf-8?B?YmFxQlZQa0Fuc0lsSE9ndTFlU2dnZ0l5L2xHSENmSkxoRk1NU1RqY2RoVVM2?=
 =?utf-8?B?ZERkWVljTjE0akdRUXMzcDUvSmFzZ2RDWG5xVHJFRGhIQnJJRi9XamN3TjNl?=
 =?utf-8?B?bmxCc1cwOFdkTnlsRFFscVJqTTNSUGVUWCtMd1I1dWpBNVFGT2w1NHR1K0Y0?=
 =?utf-8?B?MTdnekZ0dzdSc1BpN3pkcUdEcGQ1U21iQlVwY0orWW1nL0VvZ2hSM1NvL3A4?=
 =?utf-8?B?aWliV21iM1B0K3IvcVEwREVlWWVVRGN2NjVZQjlUZEx0OVUyaFV0NzYwQW4r?=
 =?utf-8?B?RGFrWXcwZWVqa002azhEQWFyRTZIQmRINXRseEtmNVQwNWhGZCtiV1I1OFgz?=
 =?utf-8?B?dXVuMGR1U1lPRWdRNkxNdll5SU91K0FkYVVwSTlhY0lDZHFIRXQ3dUxhNGxW?=
 =?utf-8?B?VUJJRDlTUjhDczZ4c3poRDllZDh3cm16dTJOUlAvU1M0cm94RzFicGIwMWRv?=
 =?utf-8?B?aGloT3hOd09ET2UwNXFvUDRoZTZiSmNvT1VjZUdUVEN1djlFc0ozUWU1cFl5?=
 =?utf-8?B?UzBoRngzY2hPeHIyVVZYQWYxQWo3ZUtqYzVTRnRmaXBGSjJwZGp5ZVJCYXV3?=
 =?utf-8?B?SWZEQktncEEyZXNRRUNBenUrNW1iaWdwb3ZBaE44TFROVHVLOEhHRnlEclVj?=
 =?utf-8?B?TWpkZEttMGhwY0VqYTB2L1doUWZ3Y2VYME5lOHZNYlNNLzVzN1pZQUZqN3lF?=
 =?utf-8?B?RjlrcGFubDZ2MDE4WWxNbGVBRHpHSzBoVXlaUndnNElSK0RTVTY1cGJUQzNu?=
 =?utf-8?B?cmhURkxpMHlBSGpkMHE3d2dKa05CUkpsN2UxT2RNK3d2MGgxY21iU0NqZlpJ?=
 =?utf-8?B?SkN2ZlpXMGtiZ24yVHBzTWpTTVJVaWIzZHVKWUxWQWtick1kMk5heU9NcnRp?=
 =?utf-8?B?ODlHQ3dlVHVmYkJLSUtzT1EwVzZIbDl5K3dodXNaMDdMVTFaYmR0OFBYVmxv?=
 =?utf-8?B?VTc5ZVZlQURwVW1iSDlqV1VEU25nT3RhLzdpWHd4UUVPVVl6TWRDa3YrQTFN?=
 =?utf-8?B?NGdyQzdKUHhlNGV0TVBZZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UDZsYytLdjBpb2ozRUw2a3FrNXJNUkdYQUZzNW50NW9RTFlWdEtWbDVMVUls?=
 =?utf-8?B?N2hwUGt6eXZIQXpwNmZHQ2FKUlA5KzREYkZGa2ttYXNCUTV5b0ZXYk9DcTlI?=
 =?utf-8?B?WE9wanBVN3VjeHNsRmJJK2p4TmNYWVJtekhBUEhJQmhERjh1YjVNcm1IUGVi?=
 =?utf-8?B?blcyVnAxQjNaZDgvU1NmOUlLY0NEK0tkSnEycEhEeVVmb1hTbTZvRDRLVDhZ?=
 =?utf-8?B?MC9yb1d6U2VzamVYaVNNdUorT0Q1S2ZseWM1RktTTjAzSGJWa2U3YlRTb2cw?=
 =?utf-8?B?dmFIWjRLbVV2NjdaZXh2N3ZIUnNvUkVVdzBvL3VRbW9obEEvTUd6YzFVRk0r?=
 =?utf-8?B?ZzJJSWw0OXgzOXZyV1ByM0JpTnpMNDhMTVZKWUJJWEhnZzRaTkNiQ2xlRnBE?=
 =?utf-8?B?b21BejRUT28zZUlaT2J6TG9EYmIyT1FvTjZiQ0piWmlpZXNvSVBEZFVqTEp5?=
 =?utf-8?B?VXNHSmM1UEozUVkvSUFxSDBmL3RzZmlPNmdNa3B0OXhLb1o2cWNZeGJOTzFr?=
 =?utf-8?B?V1dIa3BKNWZINVg4RFhjUWg4Yi90SytjM3VOVHVVelpYakNCWWUvcjFseHdq?=
 =?utf-8?B?L0NaaDF2Z0oyajFDVDBmZWhGalZGMHAvUWp2SFExTWRPOTNObXpNang2RTBR?=
 =?utf-8?B?dGxUZkRzc2hlS08wNTFqTUFzZlY0YzdpMnpqSTZ1YkVHRktTSER2ZG5ZcVgx?=
 =?utf-8?B?R1o3eHNPNWJ5eDF2Q29rYUdFbThhVkswaVU1STdRT2dnR2h6c3ViUWRBZnpC?=
 =?utf-8?B?SlNVQzFRSS9VQmRLcFkwUnlURnFTcDh5WEhKeDBOWXAvU3pyTFE5MFZBa2Zi?=
 =?utf-8?B?NXQ4VC9rLzl6dWNoYzlEWVE0ampLWmdnUUEreWMwajBOa1plcE96clVHNmZW?=
 =?utf-8?B?MElvbGZZNnhmK2JkSkUramY4VjBpclNqWDVIYkNnTnFDTS9jemVZbThnVUFK?=
 =?utf-8?B?aVR0QTVGV01vdVlGZC9CUlhVUWYxcVRkeHdRRnRtTjJNRXFuOVJMUGsvOWVM?=
 =?utf-8?B?TUZRenFya25DR2o0czJUN1UwdWNRUjB2aEsvbnJ3RDl6RVVKL21lRVQ2UXdM?=
 =?utf-8?B?czlJRjdteUtNd2E2S2lEdDVXRGFHdVlpODFIWVgzcE0wL1dkOERTa0JPZlB3?=
 =?utf-8?B?RUpoYzFHRzJaMzJ6ektnNzlVYnB6UlR4aExRNG4zYWRqU1dpaEdRVC9hS0xh?=
 =?utf-8?B?YzFsMHRkSGQwblhKZm5TUWF1cDhVMGtIdnZXbXBEZFM0TzlyZ0psNHA1cUF1?=
 =?utf-8?B?ZUZtR1RXWnU2WGVYNy8rN0hQUWFxM0xNSWxSbmxxWmtucnZ2eTVTNEFyQkl0?=
 =?utf-8?B?bHhkeFNiVHluYmIza2MxRzFqMWV0bGplNmJmUnZGMzRkOFFxMTNlbUlaMk1z?=
 =?utf-8?B?NnlvUTZaWXVNWVBpOWE2SHBMRHQrV003YWdOSDY2WjAxMEkrYkFoUm1zZ3JL?=
 =?utf-8?B?Q0dRL1plNUY1MGg1cjNZMkxndTZUV2FQSHgxbktJZkFwbUdQZEdPcDNnelh4?=
 =?utf-8?B?a2c5SS9XRlVOMVZ3ZUdnYllHWC95OVNEOU9MU2puNDJhSDYxcVpYUVVlWkQr?=
 =?utf-8?B?QVV3TUxvOVV5cGg0RG1KdHkrK0ZBSTU4MGtLMmpEQWcvNno2dzZWNnFsdE40?=
 =?utf-8?B?MGpFaHF6UEV2NTJubGVsRnpBNVRaZU5WWC9hM3NPb3RaOFlST3B0ZDI3NmZL?=
 =?utf-8?B?QXR2OXpIcjlQZkN1M0VnVDllSEdMWHBHalZsRXA4Q1d5ZllMUU5qY1lFYSt2?=
 =?utf-8?B?ckVsZVpTdDI2S0NweTM5YnhuMVg2bmgwbjl2dVRWUE1wSXF1NzNaUWhRdUtH?=
 =?utf-8?B?S3B3b3B1TExqaHVNWGI0R3RNSDlHdHJlWFFSTFQyc1ZtaHpOMTZ0OWxWK0I5?=
 =?utf-8?B?MktLMHBkZDA4b0ZQZWhsRWQ1VGcwVXJCc1pMM1lZUE1vV1dzTWNFMlJGVk1m?=
 =?utf-8?B?Z3FnaHQ1c0E4UE54SVNZK1ZFam0vV1dJL2V5VlREOTFTcUJYUWVRNTlGZkgx?=
 =?utf-8?B?am94MVYrK0dVVmw5K24zWUhrbFVXbG9QZk1zQlQ1cjZWb1BmdzgxcnprclF3?=
 =?utf-8?B?U2tUMGo4WWVYSElKOFFZR0NqRXIwT3loSEJTNUlvamdoVTNwc3pud3ZBbnI4?=
 =?utf-8?B?TllIN0tVSDJneXV2eVZqTkNBWTIzSXVoeXE2Rk5qRVJodVRneFkrQXY4OHAr?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A77DCC30F559854FA0AD247EC8EF33E2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U7KtDMnM6dcS0X3XQJpk8UgwPcjOVU2A3Myg4MWgKvp7wAaYOUnUut+mlUU0BBgT6AHzqGFJr7Xqg0H/EeWO7ALmjUvL+qLAL68Bl6AuO7Bk796euSHazTRbJtAqiFB/QM1rENJ1SNBgxbNiWAZtPcJDe36UNSXzZ2hCR6H0L4BAzteZCzZgrdW0WFdT1KuBFCHb4IvM9gOZSSJhsUu+vvL/HJx11qdGpwIindgz4gx6FQvvrBx3ScZXpJZLfDLYqrYQGa0pcxV3uNW67FUimb2m0yQPUTvoKhcEDLPErRES01ZquaNvZkSQBOFOC6Fsn2cFl9XN0X+flzR/TiUr9Cw5+R9+L/N6RviPlAJziPUnrZ2z5o/QGm9WQQ4ry5VxvaxzSC9dUkS829kexqLdHIT8kWoqCU+IE9eunlphCYPY/OQg5nWcvsZVpfO6xmogVvCE/bBFfz6YOlSImayTH6KKoEoRufQhhvON3DVQvE2TaE2F/IZn/KAjTMvSelcGF/OMii9qyCj4YdpjCfEnmcjxRew0Y9gA0dCvpN0+EolA21wACsO8NiVCn1skmDqdBm3NF5Z+OhRC9/2hV6u/X3dhLzQNx7EAInji9DL6EWF+pClwJ7B7odRjFCa7a43j
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c156981-10a9-4f4d-171c-08dc79fbf830
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 01:10:28.7394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cyoWPTIP/aqjMxqs9tPT5Wh4uY8fgoQvdJ7lyLoN1UJ4TkG1m1uyXgKWSfkPztl4OesFiJpgTBelpXv6RkVVpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8749

T24gV2VkLCBNYXkgMjIsIDIwMjQgYXQgMDc6NDY6NDZBTSBHTVQsIFF1IFdlbnJ1byB3cm90ZToN
Cj4gDQo+IA0KPiDlnKggMjAyNC81LzIxIDIxOjI0LCBOYW9oaXJvIEFvdGEg5YaZ6YGTOg0KPiA+
IE9uIFR1ZSwgTWF5IDIxLCAyMDI0IGF0IDA2OjE1OjMyUE0gR01ULCBRdSBXZW5ydW8gd3JvdGU6
DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4g5ZyoIDIwMjQvNS8yMSAxNzo0MSwgTmFvaGlybyBBb3Rh
IOWGmemBkzoNCj4gPiA+IFsuLi5dDQo+ID4gPiA+IFNhbWUgaGVyZS4NCj4gPiA+ID4gDQo+ID4g
PiA+ID4gICAgCXdoaWxlIChkZWxhbGxvY19zdGFydCA8IHBhZ2VfZW5kKSB7DQo+ID4gPiA+ID4g
ICAgCQlkZWxhbGxvY19lbmQgPSBwYWdlX2VuZDsNCj4gPiA+ID4gPiAgICAJCWlmICghZmluZF9s
b2NrX2RlbGFsbG9jX3JhbmdlKCZpbm9kZS0+dmZzX2lub2RlLCBwYWdlLA0KPiA+ID4gPiA+IEBA
IC0xMjQwLDE1ICsxMjQ5LDY4IEBAIHN0YXRpYyBub2lubGluZV9mb3Jfc3RhY2sgaW50IHdyaXRl
cGFnZV9kZWxhbGxvYyhzdHJ1Y3QgYnRyZnNfaW5vZGUgKmlub2RlLA0KPiA+ID4gPiA+ICAgIAkJ
CWRlbGFsbG9jX3N0YXJ0ID0gZGVsYWxsb2NfZW5kICsgMTsNCj4gPiA+ID4gPiAgICAJCQljb250
aW51ZTsNCj4gPiA+ID4gPiAgICAJCX0NCj4gPiA+ID4gPiAtDQo+ID4gPiA+ID4gLQkJcmV0ID0g
YnRyZnNfcnVuX2RlbGFsbG9jX3JhbmdlKGlub2RlLCBwYWdlLCBkZWxhbGxvY19zdGFydCwNCj4g
PiA+ID4gPiAtCQkJCQkgICAgICAgZGVsYWxsb2NfZW5kLCB3YmMpOw0KPiA+ID4gPiA+IC0JCWlm
IChyZXQgPCAwKQ0KPiA+ID4gPiA+IC0JCQlyZXR1cm4gcmV0Ow0KPiA+ID4gPiA+IC0NCj4gPiA+
ID4gPiArCQlidHJmc19mb2xpb19zZXRfd3JpdGVyX2xvY2soZnNfaW5mbywgZm9saW8sIGRlbGFs
bG9jX3N0YXJ0LA0KPiA+ID4gPiA+ICsJCQkJCSAgICBtaW4oZGVsYWxsb2NfZW5kLCBwYWdlX2Vu
ZCkgKyAxIC0NCj4gPiA+ID4gPiArCQkJCQkgICAgZGVsYWxsb2Nfc3RhcnQpOw0KPiA+ID4gPiA+
ICsJCWxhc3RfZGVsYWxsb2NfZW5kID0gZGVsYWxsb2NfZW5kOw0KPiA+ID4gPiA+ICAgIAkJZGVs
YWxsb2Nfc3RhcnQgPSBkZWxhbGxvY19lbmQgKyAxOw0KPiA+ID4gPiA+ICAgIAl9DQo+ID4gPiA+
IA0KPiA+ID4gPiBDYW4gd2UgYmFpbCBvdXQgb24gdGhlICJpZiAoIWxhc3RfZGVsYWxsb2NfZW5k
KSIgY2FzZT8gSXQgd291bGQgbWFrZSB0aGUNCj4gPiA+ID4gZm9sbG93aW5nIGNvZGUgc2ltcGxl
ci4NCj4gPiA+IA0KPiA+ID4gTWluZCB0byBleHBsYWluIGl0IGEgbGl0dGxlIG1vcmU/DQo+ID4g
PiANCj4gPiA+IERpZCB5b3UgbWVhbiBzb21ldGhpbmcgbGlrZSB0aGlzOg0KPiA+ID4gDQo+ID4g
PiAJd2hpbGUgKGRlbGFsbG9jX3N0YXJ0IDwgcGFnZV9lbmQpIHsNCj4gPiA+IAkJLyogbG9jayBh
bGwgc3VicGFnZSBkZWxhbGxvYyByYW5nZSBjb2RlICovDQo+ID4gPiAJfQ0KPiA+ID4gCWlmICgh
bGFzdF9kZWxhbGxvY19lbmQpDQo+ID4gPiAJCWdvdG8gZmluaXNoOw0KPiA+ID4gCXdoaWxlIChk
ZWxhbGxvY19zdGFydCA8IHBhZ2VfZW5kKSB7DQo+ID4gPiAJCS8qIHJ1biB0aGUgZGVsYWxsb2Mg
cmFuZ2VzIGNvZGUqIC8NCj4gPiA+IAl9DQo+ID4gPiANCj4gPiA+IElmIHNvLCBJIGNhbiBkZWZp
bml0ZWx5IGdvIHRoYXQgd2F5Lg0KPiA+IA0KPiA+IFllcywgSSBtZWFudCB0aGF0IHdheS4gQXBw
YXJlbnRseSwgIiFsYXN0X2RlbGFsbG9jX2VuZCIgbWVhbnMgaXQgZ2V0IG5vDQo+ID4gZGVsYWxs
b2MgcmVnaW9uLiBTbywgd2UgY2FuIGp1c3QgcmV0dXJuIDAgaW4gdGhhdCBjYXNlIHdpdGhvdXQg
dG91Y2hpbmcNCj4gPiAid2JjLT5ucl90b193cml0ZSIgYXMgdGhlIGN1cnJlbnQgY29kZSBkb2Vz
Lg0KPiA+IA0KPiA+IEJUVywgaXMgdGhpcyBhY3R1YWxseSBhbiBvdmVybG9va2VkIGVycm9yIGNh
c2U/IElzIGl0IE9LIHRvIHByb2dyZXNzIGluDQo+ID4gX19leHRlbnRfd3JpdGVwYWdlKCkgZXZl
biBpZiB3ZSBkb24ndCBydW4gcnVuX2RlbGFsbG9jX3JhbmdlKCkgPw0KPiANCj4gVGhhdCdzIHRv
dGFsbHkgZXhwZWN0ZWQsIGFuZCBpdCB3b3VsZCBldmVuIGJlIG1vcmUgY29tbW9uIGluIGZhY3Qu
DQo+IA0KPiBDb25zaWRlciBhIHZlcnkgb3JkaW5hcnkgY2FzZSBsaWtlIHRoaXM6DQo+IA0KPiAg
ICAwICAgICAgICAgICAgIDRLICAgICAgICAgICAgICA4SyAgICAgICAgICAgIDEySw0KPiAgICB8
Ly8vLy8vLy8vLy8vL3wvLy8vLy8vLy8vLy8vLy98Ly8vLy8vLy8vLy8vL3wNCj4gDQo+IFdoZW4g
cnVubmluZyBleHRlbnRfd3JpdGVwYWdlKCkgZm9yIHBhZ2UgMCwgd2UgcnVuIGRlbGFsbG9jIHJh
bmdlIGZvcg0KPiB0aGUgd2hvbGUgWzAsIDEySykgcmFuZ2UsIGFuZCBjcmVhdGVkIGFuIE9FIGZv
ciBpdC4NCj4gVGhlbiBfX2V4dGVudF93cml0ZXBhZ2VfaW8oKSBhZGQgcGFnZSByYW5nZSBbMCwg
NGspIGZvciBiaW8uDQo+IA0KPiBUaGVuIGV4dGVudF93cml0ZXBhZ2UoKSBmb3IgcGFnZSA0Sywg
ZmluZF9sb2NrX2RlbGFsbG9jKCkgd291bGQgbm90IGZpbmQNCj4gYW55IHJhbmdlLCBhcyBwcmV2
aW91cyBpdGVyYXRpb24gYXQgcGFnZSAwIGhhcyBhbHJlYWR5IGNyZWF0ZWQgT0UgZm9yDQo+IHRo
ZSB3aG9sZSBbMCwgMTJLKSByYW5nZS4NCj4gDQo+IEFsdGhvdWdoIHdlIHdvdWxkIHN0aWxsIHJ1
biBfX2V4dGVudF93cml0ZXBhZ2VfaW8oKSB0byBhZGQgcGFnZSByYW5nZQ0KPiBbNGssIDhLKSB0
byB0aGUgYmlvLg0KPiANCj4gVGhlIHNhbWUgZm9yIHBhZ2UgOEsuDQo+IA0KPiBUaGFua3MsDQo+
IFF1DQoNCkFoLCB5ZXMsIHRoYXQncyB0cnVlLiBJIGZvcmdvdCB0aGF0IHRoZSBmb2xsb3dpbmcg
cGFnZXMgY2FzZS4gVGhhbmsgeW91IGZvcg0KeW91ciBleHBsYW5hdGlvbi4NCg0KUmVnYXJkcyw=

