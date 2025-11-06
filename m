Return-Path: <linux-btrfs+bounces-18762-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1042C39B7C
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 10:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F383AA192
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 09:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F8F308F3A;
	Thu,  6 Nov 2025 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SxR6LZ4f";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="y7rFCQw6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59B4271459
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419696; cv=fail; b=PqU+EseP0QrNm/UqUiycxk+/8qSfLpQtoLwg8EqlRWRpCDEQ+kqtcO90XcwsW4ELBqJq9fRGXDnZK9fNLdACztqf2sI+Zm7DFQsHyvcL1aBZrGEU2+VC6LtHpCVIx+snwTD2xyHnxanl18lntOj4S5LIUP7yYj+ml6lIxVbtxHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419696; c=relaxed/simple;
	bh=oIJd2tVSUJHvgpt4xbHHHlTeuTU/CQ5U4G78mALHBtc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OGCHav3M8HCYeAzNRVqzICcXZvTRY5E56FtGV4vw9XmF8BSRGd42YqdAxg9BrCdXV/QQM/zYWu8b1O4nd+MgJy7lWBGw9iB5mnPIWGQ+VIYQMuTeedd/d/CibEZVpWTuzYOqHMmVVPX+R1ACREynNGB7NsCOGdSfo4xM6XdoL0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SxR6LZ4f; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=y7rFCQw6; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762419695; x=1793955695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oIJd2tVSUJHvgpt4xbHHHlTeuTU/CQ5U4G78mALHBtc=;
  b=SxR6LZ4f82fQ0KuVUbYx1OTO5/V6BvOAaMNwbIEOLQsufSZGsTUPS22p
   SzhUIUKLhRwV+MjHpissgeP5olBH5CUPKJqn8jNVeoB0DpUwlL49gQCwF
   03q/dpeOx3DZ6QJypmPHBFJkUX98nL2j0kPgX4A6nmyCOd5tL0u+pNCUS
   1QUgiVreRovwEEngsLEZGekYIsYN2855iFbuDhnV5DjvC9BslfXEwzUXg
   xXIHlItN4eeVDm+2JVhlStG07VLc6b1Gsa1AqkFdpbUVDHFD9GBfeZ085
   H2gPj1GdOw05zQOIhQKhDBHPO8YYL8Gk6lrNpfWG3opsLwFve9PIlL5pv
   g==;
X-CSE-ConnectionGUID: 1hdwVkkVTsir6p1yXlcTpA==
X-CSE-MsgGUID: tj0N3gldSxmJRhhLBHJe2A==
X-IronPort-AV: E=Sophos;i="6.19,284,1754928000"; 
   d="scan'208";a="135552127"
Received: from mail-westus3azon11012048.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.48])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2025 17:01:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQ68di/TzESjIFZoi7zTclncQjRzBsg8QwXp0y+OJOD3Mj4HaxRWCg2yx/oYNZeT62vP9GZmJnTB0C/mvzKy7y6MDIGO3Da0+quSyqolUw9QszGfol89LoM0L7CQFUth650nRJo6GT/PLjYBrAG977RKaCyE9t/wsL8N5Ox9U8wDbO4J7VTg1J7g+STgj+BbizX3xZ3TX+dcEt9cDkWyhfM570/2bXoMj8O9QpyLGXBbgpOsNBMPALQKZSzP94r9KuqiatnHn3uvNL9Y/xVnK3U4aw4oYVIciJG14K5RHheBmrKCM71fK+4ZfQHh/3cRmFrywyraBFqA00lePHSMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIJd2tVSUJHvgpt4xbHHHlTeuTU/CQ5U4G78mALHBtc=;
 b=P3Lb0zTdODyqDVTwLDdnFBX9Yy2aOk4iVUlRPS+FwXin9JEfldk5tggN405X9YasQOF+sOdTKpGMf0EvcOGjy0uBixxJNcsL1RkYYbbhRhUwfakvoGk+4V5tjCsE0HfG3Fd+sl01T8fs3gTAO+qGYR9YCEolEoDI+agL+PayCIVjVC9VCwFaiKRcdogbfEH8S/uAKHsju30EbUiju4Qi2Y65T51HVNw7pjfI6/CjSbrEjX1AQOecQ4yjGDZrsd+AUxK9vQgcAeL9LgGBnHyst7NQL3Q3EaIEW2i3VktzqP+GmYAFQ9/96ZWUOmRJy9oO5GpdPH7gZAKx5kervzC8dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIJd2tVSUJHvgpt4xbHHHlTeuTU/CQ5U4G78mALHBtc=;
 b=y7rFCQw6+3Fc8A4kM8QyPi5E1rd7h6IvnaZ2IAOrbKI6gvIImky8J2CknxgPHM/TCcg8c0TxKM+41iDxm7s7au3KSUyTaE3P/dhOQnMoy9kGD+Nzui0PQiCwZokvzh7UXiS/i8xjEnHvHtJF1BhYmS+n67tv+iyc+oSKQWo7Vr4=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by IA3PR04MB9277.namprd04.prod.outlook.com (2603:10b6:208:528::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 09:01:32 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 09:01:32 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Calvin Owens <calvin@wbinvd.org>
Subject: Re: [PATCH] btrfs: use kvmalloc for btrfs_bio::csum allocation
Thread-Topic: [PATCH] btrfs: use kvmalloc for btrfs_bio::csum allocation
Thread-Index: AQHcTp5ADr7g/ZAQWkeNSBWn12KoprTlWqaA
Date: Thu, 6 Nov 2025 09:01:32 +0000
Message-ID: <f8425395-311d-4e27-a7da-46cc0ef35ccb@wdc.com>
References:
 <22b5e7a4dad73b2c97069f34910a56fcf58d5f6c.1762379016.git.wqu@suse.com>
In-Reply-To:
 <22b5e7a4dad73b2c97069f34910a56fcf58d5f6c.1762379016.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|IA3PR04MB9277:EE_
x-ms-office365-filtering-correlation-id: a6643d71-8acd-4413-73df-08de1d1314a8
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?N0VvcmJ3MWdCRUxHbXo4NEdlSjdFTjVKUy82L05TRzRDeWNrWmFwR2RNR0dX?=
 =?utf-8?B?YURVQmNuOENJMTEwNnkxNEs3bzZyL2I5dWpPUzVIRXp6bVRId045d3RjMWJa?=
 =?utf-8?B?YXZKRE92dlE4WWE5QWx3SjRDbXF0dzA3aXB0S3lqcG5wNllRd0dTTnlEcFZa?=
 =?utf-8?B?WWhDQzRaWGtVU3Y3SU0yeTNmdlVXdkpyTytIN0ZMZ3RQc2MzckxHMUFMaGtI?=
 =?utf-8?B?c2dkOWsxVG43U1lwamZSZjlpZWdrZkxGbWE5c1FsTVhGeDFqNmpkS3ZzZFpS?=
 =?utf-8?B?ZGg5djNIdEljWEJSTFNpdHlyTW5mcjFZdEhtQzdNR1hkcjI1MmxRV2kvU3ZN?=
 =?utf-8?B?b3I0UEYyVWs1M2RYaXF6cUxJVVpsOGx1b3Rxb3RjWUdYejZBVjBjOU1QUmRy?=
 =?utf-8?B?L1h2T05oZ1JRbzd3QUE0NVlYb1c5YlpUdmIyUHBlTmEweTVYSzVRMHQ5Qmpl?=
 =?utf-8?B?a2tmRm5YODlINHRtV2xSN2ZxRkZDdWxsNjFyT2tmNWEvN21vWnlmNkQyOHhy?=
 =?utf-8?B?U0J1SEdTTzdjeHBCSmprQWZBbWhPWHo5Ry85RXB6eElxdlFYNzFIM2w0Mmw3?=
 =?utf-8?B?WWJ4T2VaTTZkQzVhSmpsdm9STjNJM0lsdU02VWc4b05kNlpyT0hWb2FoaDF0?=
 =?utf-8?B?Wm92RWVJMzB3SVE2UDUxM0ZRd2lHaWQzYWtRZ1ZEMnV1K3VZZHpFUXVJT214?=
 =?utf-8?B?Tnp3UUNrYTVXeUZWNnl5NUVWNUZ1TldJd1NCaUFETFNSY3lSTmx3Q2JxZFFw?=
 =?utf-8?B?OTVBemF1TGhQcE5FdHJaenpuOUVKdnFTNjNUZ0ZoM1MrK2JzaXk1QzZ0dmtj?=
 =?utf-8?B?QzlVUG5SaTlqMWJtSFdzM1ZJaUtublJZbmRlMGNscGJzZ2U4aVdOUTVZVUNH?=
 =?utf-8?B?WmR2MTJtUW44dURmUGhMTTMwQ2Y4aFkxc2JmZjE3VTVjUE9HbFQ2dDhjMXNx?=
 =?utf-8?B?YzZ3WmZTcm8zYzVLZkorOFFVa3BVcEdsUS80SFdJU2pVL3k1TTZEUU54MG1v?=
 =?utf-8?B?Z3JZM1RGUHJoRkVVRFlTbUIyRXNWS1BpUURYK2tGUy94bnI4Y2lUYXVIOEJ5?=
 =?utf-8?B?Nm12MThpdEc0bXNqVFlwNzJpQVIwMGhod2VLeWNpU0MxbEoySExHRFk4V0tY?=
 =?utf-8?B?UkU0TlBVTGJ6ZmhaeUV6cWZwOFVNY0k2VTNjdmVzVHpxbEtPNmNmRG13RDdu?=
 =?utf-8?B?UXhOU3Fub3JFYzhLN2tUT2JaODREZXprcDZNM3FxanV3K0d6dnJybGRvWWtt?=
 =?utf-8?B?cU9zdjd0clJXRmJmakNaKzFFNHJxQkVwMUpnZVJ6dDBZNjlwN3VQQm4xZ3Yy?=
 =?utf-8?B?bFpERlp6S2hGR0pTM3RHUE5vZFBZbllyU2JWNklqRjZuM0h6OHNEY2NuN0d2?=
 =?utf-8?B?QmcxQkx3MWJEdG94TVJlSFBXWVpBZ3dhVitKL3VRWDhJb2xBbG1iVEhudXRz?=
 =?utf-8?B?ZFNPb2lJNEFXcDMyYzBQWEhhenI1dnJnZ3JVbVBNTDBOc3lSR2IxbEpsR3lu?=
 =?utf-8?B?TW80YXBvSnNUcktMQlJ1RHlobWZvV01waGV1YXdiR1BHS2FuaDdkYk1kamlt?=
 =?utf-8?B?QjR3V1Azck9qcVpSU1ZRY2p6NkNiTzhkaGF2WW9mTk1rKzZnOCtoeUY5aUg4?=
 =?utf-8?B?WU5QcDArSTRlQVM4REpYUGoyMUJZNHYzM2w5amFqTkpDeFZJQk8rWTJpMkZW?=
 =?utf-8?B?VnBzSHpNTWlEM0treTRKeFJlMDBtYkZnWW9xTVNhNHRlZEk3NlovKzlzcVBj?=
 =?utf-8?B?UERiYW9NYVozbDBrUjdOREFQMTluQnN6VFRlOTBhVlVRWkYzeEU0dHgwcUIr?=
 =?utf-8?B?cXJnSjBXbGIyUDlPelNaalhmMHlUS3dHNm1vcW1xLzQ2cnZIRUFKZlRpZG05?=
 =?utf-8?B?cWNKeW1jZ2pMRVBuME0vM1hYak1XRzF6SzhZTFVXcDA1Z2trVHBnejkxejlj?=
 =?utf-8?B?OGtid3dhQlJSMnFCU3YzVTlhY1pDOUhHNVoxcWMyWVVrWDlTeGxySFRuRjZR?=
 =?utf-8?B?M2NOOG1BZ3Vob2FXemFwOTIxRmNrQmpIY1N4WTB2WmZFN3ZndklNMis0L0wx?=
 =?utf-8?Q?0fdN2C?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RStobU5iV0xlMEF5RTJJZXFMQjRBYVN0YmRsbThyM1hYMU9lbDI2T2ZoanQ0?=
 =?utf-8?B?NE9lVlNlU1Z0bmQzMFE2a3VRbm14aExJR0xleSsvaDFQM1UzaWNkWFZPaVRD?=
 =?utf-8?B?OXNDd1NJQUtLUjBqR2NHK2tiZTIzSE5TcmlmcVpFZnFhTFFoTXdPSkhNbjZX?=
 =?utf-8?B?WENVdmJxN0VpMWZQZVptd3VVN2k5dVAvUWxLQnh0ZVZDbytwVFRsaHFRbmMx?=
 =?utf-8?B?cTZNdHVtOEJ2RDdPenkzM2hER3QxVjNML0pSZVVmcVREK3d4MUJWTE9qQjh1?=
 =?utf-8?B?WmhiRTlKY092MUhjRFlxbUFlOUJEdDZzNVUzSHJIS2ZwM1RsRHh5blVZS0JF?=
 =?utf-8?B?R2RCbC9hMmFBK0hZREJMTjFzRmpGMndEd3l3TkVWdFNtLzl6em05dHRzWWlX?=
 =?utf-8?B?TWFaUkNqdlVHd1I1czNKbEVVWTN3bFZRSHM3SVJ4VzV1TWZnLzJlbUs5dXJp?=
 =?utf-8?B?NnJscE9WZjdUVUhUYjFOanA2Snh0cGdwOVdEOEJWQllDdjIySDRrUkhGQldm?=
 =?utf-8?B?bkYzUGJJS2hteXVuQWRMNkxuUUMwTXRvRGQ2TVI4Q2xQU0ZSL3pWYlIrb2xS?=
 =?utf-8?B?NDFDMCs4blp0c3NadmxXMHpsSHZrVFNXWVovbVFWWm52ZEpoVGl4eUZmZGRB?=
 =?utf-8?B?TlUrQll2TExQSVdraW9RbE52aUJmZVlsczdpNmxYM2FvS1ZObDl4Y3ZidUhM?=
 =?utf-8?B?YXg0TzA0TGprMzJEREVJc0N6V243My9weUluSVFQaFFvcTFLenNuSFNaRlAv?=
 =?utf-8?B?V1lYTkJsZXJSNzhXQ1laRVBuS2xTM1p4aVZXQ2VTa3lNYU90ZTVsdXVMWG1G?=
 =?utf-8?B?c3pBWFBOSy85dzNsK25XVmtLcTBpbG5UNGtIa1pXK1ZnOXRrc3J4UU4vcXhl?=
 =?utf-8?B?OE5RM1NtQnhxNlRaQWlYWGE1Yk1JclU5UlB5bTl1bnFhSkxhc1plL1c4TTRk?=
 =?utf-8?B?YnJlL3VEanRCRkZxSWZaVnF0dGZqQnR0N05ubGpqdkdRc3VzNXhNVjJWZVlI?=
 =?utf-8?B?bE5wZ0lJOFNGRWh1c08vbWQyUjM2bWxVZDFodjlsZTZqaHhGZnl3RFN0alds?=
 =?utf-8?B?Zzl4NXlzM1ZHbThSOVhRcTI0UTBFMklIN0Y3dEdibldZeHZMRXBaTUxzN3ZH?=
 =?utf-8?B?dWpURXJhVEtTVXNQOTRQckRtM202NjVDclgycWx4L3h0eFhaK2hjNFZoNW0x?=
 =?utf-8?B?YURrWGZ0ZVpiOEtUSTNpT29wWHZEa1J4ZFhZdHBYYTZpWkVpRytjUnd1NktE?=
 =?utf-8?B?OXYyemR0cDVYNElvcVNnaG1TYWVqRm5EY3JqbEpKcWFxTmR3c3k2cm83V01Z?=
 =?utf-8?B?a3JWSERYOVQraVNaQk1OS01mZjhhMkgwSmNBSmVyR2dIRkQwK1pNSEdnczB6?=
 =?utf-8?B?R1hhWlJadU9sK29PRDRBbVAvRThRYVp2MmE5czdKM2M1T2RVOC9haDIyM1Rw?=
 =?utf-8?B?ZzdhVXZLRWJ2emt1elBvUWxTaTkrSmlmTmVrblV1Q0pZbGVXRG1sNmlySFpz?=
 =?utf-8?B?a1RWcktXM2VDV254cnFuYzU4RVRQVXM0OVY5OU00U01sQncxNVFjS0hlK1Nl?=
 =?utf-8?B?bTJVbkRrREYzblRCM0x4eWtocDZFbE1lK2JWZTFNQkVTZVI0ZkM5K2w1MFI0?=
 =?utf-8?B?TjlpamtWWWJlZ1M2YVBaSWVBdkhHTTMvMXdZenlsWldzQkhZNFdrWXhsSE8w?=
 =?utf-8?B?S3I5K21FbEFqL2RBS1BDajVNeGppVkNJV0p4M0lUV3h5bkFiQnlneXFEdzly?=
 =?utf-8?B?NGF0SWpBam9na2RlOFBaMVpiRnlWNmhwRGZZQUFYcGtSeDBoRGFpWVV4ZFBt?=
 =?utf-8?B?OUpmOUQwbHBkZWNsQVBJQVJ4NTZNbmxXaGZrR2NqMWJYeG9Mek1vcE9leFZz?=
 =?utf-8?B?bVdIVVFKVzI2d1ZVVEhYSGZSVUVGL0NYZ1ZKWGdKN0tGWmh1TzdKWkZ0UzJk?=
 =?utf-8?B?Y0hiZ1ZXdU16R0pCNTNFdll0bUZCMlc0T2hORzJjTyswWVpMMVc4TDNoOWRy?=
 =?utf-8?B?eEpjYWUvc3JhS0FHYWIyNmIwbWVIR1h2SGx6WnBVcnk0aHNoU1RXTTkrbEg4?=
 =?utf-8?B?QkNuTzY3Y2Z5RTFGa09VRi9tVk5CS0pyVnNiTDBqVlp0bXlEdThWNHo5K3J3?=
 =?utf-8?B?OWFsMG41RWVSZUhRSGQ1cC83V1gxdks1SW8xZ1JBQTIxM0hOcnQ0QkozR0pF?=
 =?utf-8?B?MnBpVkxaaENNQTAzRkFFVy9uUDlwNFErOGhUcllwMEF5bGVWbGhXalRrdDB6?=
 =?utf-8?B?RkREN21WdmV1TlpBaHNOU0paUHBBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C40C8A9B938B5840B466A12F7D4BD11A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+c47TRa2gdj/NVkUHpvzb0XNddeo2g/oqAgeYX4M8hKabrx7lxxPsVej/kAdDILV1HWK5aTzRI2+a2K6wHz43dqzY+w6XuBRhGLP9o0Qc5OWJqmdBs37rkfuemhJaaZn4bcV0MVehb+cCr1JiVyOoRsjmByUHyYkweblihYlYDPzI/57mQh5Ks6b6ZQL2TVBNdBlQPynPxJyvMR3HozoqV8IZjCbyWQGZA0lkmSMakd9xdkrrquGerro8swNlJUWvGIUnZoRYcpUvTQvr03OAxsRuCpS2wh7tuwpPBntpSPFAv4cSZ+FmO3vC8V8yOs8hknrRC0zgl5E/kFZynJKF2911OhIXLe5qAqOI6IctF1ApAKDAu/mDrOxKfWyZ48hllIdc8Blarl7z+awwdVZ2aUJIThqFC1OCTS0ETTF5+FvVpS0iQGioWLUotGGr7aPhYOlZZ8bRCZUxQ3SuDtF7HoyNwv1ZraniftYDxdjO6NRKqMqVI7bPvDZo9HUZ8ePvJpzle7/Ehi+9Ki5XS5tjHqMtS4u4eSW+C+/28Zj0JlXhY6n0KCMxTBi2OeZg6BX0rPQ+gs6EEsbZv+/dSst0co9jAncPFsDfEpcqq8qKfLzkBcGFVVHMsBKkpK5dyNf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6643d71-8acd-4413-73df-08de1d1314a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 09:01:32.0778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLbF9h/w5fkRpDppN9r+GR+GM/uzsiHY8I8biCsf6qTXApE8LtqtxNAl//qyPhEI6W9GH2bkQPj6rN7i0v4PYoEu0SYaSHLG8Law7S6+7IA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9277

T24gMTEvNS8yNSAxMDo1MCBQTSwgUXUgV2VucnVvIHdyb3RlOg0KPiAgIAlpZiAobmJsb2NrcyAq
IGNzdW1fc2l6ZSA+IEJUUkZTX0JJT19JTkxJTkVfQ1NVTV9TSVpFKSB7DQo+IC0JCWJiaW8tPmNz
dW0gPSBrbWFsbG9jX2FycmF5KG5ibG9ja3MsIGNzdW1fc2l6ZSwgR0ZQX05PRlMpOw0KPiArCQli
YmlvLT5jc3VtID0ga3ZtYWxsb2MobmJsb2NrcyAqIGNzdW1fc2l6ZSwgR0ZQX05PRlMpOw0KPiAg
IAkJaWYgKCFiYmlvLT5jc3VtKQ0KPiAgIAkJCXJldHVybiAtRU5PTUVNOw0KPiAgIAl9IGVsc2Ug
ew0KDQpDYW4gd2UgcGxlYXNlIHVzZSBrdmNhbGxvYygpIGhlcmU/IE90aGVyd2lzZSBzb21lIHdo
aXpraWQgd2lsbCBjbGVhbiBpdCANCnVwIGFmdGVyd2FyZHMgY2xhaW1pbmcgdGhpcyBjYW4gb3Zl
cmZsb3cuDQoNCg==

