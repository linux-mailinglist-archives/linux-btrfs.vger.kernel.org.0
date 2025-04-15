Return-Path: <linux-btrfs+bounces-13034-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A78A8A250
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 17:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220D23BE80D
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0548B2BE0F1;
	Tue, 15 Apr 2025 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="IEmFpEdb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7551AF0C9;
	Tue, 15 Apr 2025 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744729138; cv=fail; b=crph6G+QheJ3HS+5Xjin0rvG5xeT52Jq4nkIDTM+vx3AVDPiZSSD6iOsHI7LWTEOYN0f/rZQHx9aMTJjLue8fyCevaK7HKYZJ/9hFMj79/LigRfgbvytaudg0TEQWVY96X5DejswN7oj3wYjWzkeZc39W27LkqSZGRa8Yl9933Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744729138; c=relaxed/simple;
	bh=tOmA+QNzYR/BaM/oIUzYDWl9RWmFTHoc1ojTLhYjoOw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=sHjSUL5sEicuei0y20eOoO1OEEphNL6gZBi9qSkcZKz3t1MSB0cXy0iDpGQ11DbAggC0YXZ0FT5x2Fn+PM+toY9/bU7wbr4mN0aWbxl/oQ44fJHaRKJ+/xhw5W5MqfckRmiAL1FuqjhMU1CZzfLun+RFXdRLBM6+OsoBQ8DUlOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=IEmFpEdb; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FC59G6032285;
	Tue, 15 Apr 2025 07:58:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=tOmA+QNzYR/BaM/oIUzYDWl9RWmFTHoc1ojTLhYjoOw=; b=
	IEmFpEdbogNqXGQHPRANpkXf3H1LiRjXAcJ8AzpDKN3kuINM/GR0C95MNPgs9XMR
	j9B8Zh6z7N4egDmvQZgjS6eydH7xUNnZgK9Svr7Uiuixrr++skxOoO7IW+FAkEiz
	k6NOD5TlDrrE7TZg/4W8w5SMVPkPb1hhrhkMTYKewvyKSVW0bl8kYTBxEL58Ve1z
	n7DZblbZ4WfQReXbo4Zm75XluHOsYNoHX+pMyt59RiWYP4nOS+6Zr71VtwhS/ueB
	7V4yy890E3uD+CBQBB9pW+87QhDZ0Gl2m1EJsOuynS8Fqf95U2khBuRcTeF2y556
	UkkxtT/v/9JlkAZgJf13DA==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 461ne11s2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 07:58:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAZ2EKYCpGlLiyO/W/LLvT+zOLXiDOQHl3lNnKaLiKgZV+D5xlrAx4KUNib+egxMkAKBnJRWiCEuyOahtqtiHCtJzIwhZyddspr7WF82xu0uptQ8JQSSHjwmeuYHt5Y5Uyxa8Yo6AB7dbY3p6gJ/JPj301Vdbi8i9doFHcKqPV1R6l1TGkiFag+jbz4H26CpAx4E9M6LeNMgnvixsUixsdFKpA1Fny/LZ+TPYI60eu+uNw3l3JQt3WoBnxF0DKGpy0fqikzQLjpL7TVq/rFh9e0ngAXbH6CrhKZ5MPboY1TdSKiHsmjWQSFAicllrKw7YZR0v1u9KbKXVl99z3T2Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NKH7xxDhT3YgZl9cfeQ+cgvAh9r08QSpjZaY/UrVNM=;
 b=McpEQipAA2FGtysKAZBTYYJ5s9HZtOOAMfxkfqRP6lob6QnD+eTyfPN9umT60fGK+2zBbrp0HRDmru7rjkZ858IDWQZ/IPYbE+OyCZ4Y6HuXn2Imv4tGDzBoPuWMtyBGQh4WAoXa/mpDgteyvXK4ifnrI+VWV2P8lcI7a7s7k1+24cia4I5zlTvlJvDwxCoaup10ejo8Zq4gTEiuZJpLdJXYm8g3CUFYPSd81KQVHT8/9a0NwYq4Zu5N3M3vnwH4bbN4KE/5jOtLaxsuyFi9jjFl2VPl5ANz90/RcluIVEr+UjmIFvYKHj6x2DIox4VyKJD1aHJo9/rj16P+oGrI2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4732.namprd15.prod.outlook.com (2603:10b6:303:10d::15)
 by MW4PR15MB4666.namprd15.prod.outlook.com (2603:10b6:303:10b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 14:58:51 +0000
Received: from MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::f3ab:533:bb24:3981]) by MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::f3ab:533:bb24:3981%7]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 14:58:51 +0000
From: Nick Terrell <terrelln@meta.com>
To: Qu Wenruo <wqu@suse.com>
CC: Daniel Vacek <neelx@suse.com>, "dsterba@suse.cz" <dsterba@suse.cz>,
        Qu
 Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@meta.com>,
        Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Nick Terrell
	<terrelln@meta.com>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zstd: add `zstd-fast` alias mount option for fast
 modes
Thread-Topic: [PATCH] btrfs: zstd: add `zstd-fast` alias mount option for fast
 modes
Thread-Index:
 AQHbohZYYy5kzhLcC0OWpc0QE7SIYLOM71MAgAAVk4CAALqTgIAAHMuAgAKXRYCAElwbgIABXy2AgAC6woA=
Date: Tue, 15 Apr 2025 14:58:51 +0000
Message-ID: <BE89F6F9-FDE9-4DE0-BED0-ED8F350895A8@meta.com>
References: <20250331082347.1407151-1-neelx@suse.com>
 <2a759601-aebf-4d28-8649-ca4b1b3e755c@suse.com>
 <CAPjX3Fdru3v6vezwzgSgkBcQ28uYvjsEquWHBHPFGNFOE8arjQ@mail.gmail.com>
 <b1437d32-8c85-4e5d-9c68-76938dcf6573@gmx.com>
 <20250331225705.GN32661@twin.jikos.cz>
 <CAPjX3FfVgmmqbT2O0mg9YyMnNf3z7mN5ShnXiN1cL9P=4iUrTg@mail.gmail.com>
 <CAPjX3FfOJMFC8cXCqLa2yS1qSYmhu5cjV__+7xVRFGuKu=RqiA@mail.gmail.com>
 <f6b92c77-d702-465b-a36a-93c42ecf59a8@suse.com>
In-Reply-To: <f6b92c77-d702-465b-a36a-93c42ecf59a8@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR15MB4732:EE_|MW4PR15MB4666:EE_
x-ms-office365-filtering-correlation-id: e114b580-ddec-4970-66e4-08dd7c2e08fc
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VDM3dzM5NE9GaW5aOGxwUUw5MmNHTDZjTkdscGtOcUxYbmlhWFNKOVJFUzAx?=
 =?utf-8?B?ZUo0UlJZa1NabmxkNkZJNUQxV1NQNHRJZysrd3ZodWg4QkV1QW9Ic3FPVllu?=
 =?utf-8?B?eEllVkExcE85VXZtL3BWN2xXclYvTWZ2U0RXUDZIRG1McVpIZ1pSNVZhb3Zq?=
 =?utf-8?B?RG94RmQ2RStFRjJHSElDMXFEMlBSbWJ2SnhOMXcxSDcyTzAyQm8xYythRW5k?=
 =?utf-8?B?dTZsNnpiL0V3S0NzZEE2TG02TFY0WXNueWg5WWkzQ0hVSUJSVlZCWDQxM25T?=
 =?utf-8?B?elYwZkdDSHVrZWtDUVRhU3JVakExZjFOY0pIWTBYc1U2SVk1YytuWi9VQXFJ?=
 =?utf-8?B?WGZBNVJjN1ErQU5VOEhVQUZUaThlbGtISHNWU1hKQUdUMnozMzYwdjRDSlNu?=
 =?utf-8?B?dGxtN1J5RXYzb1Q0c2pWMkVmclY3RUk5WndQMksweTJ5amFpRlpPYXcxQ09X?=
 =?utf-8?B?ZjgyZWNJNlBRL2hKMDh4U1AyaE9PQWl2WjRYQXY4aUVCSjJaMFhDdk9GTGlB?=
 =?utf-8?B?Qy9MWXBqTi9rcy85Rk5sN3FYNTc2ZjRGcjg5ZjRISzZ5aTYxaEQxYTM1bUlr?=
 =?utf-8?B?bWxTZzNPcU11bHRZMTRMeGdPeGlFQmx5ZHlvSVpuS1lrU3kxODV1VldYRnNx?=
 =?utf-8?B?K1cvTURuSnYrT21uMDlpendTQTBBdkNoZXp5Wlo1NzVrU1VsVmZJRi9JRWVq?=
 =?utf-8?B?bUhDdC91VGRSZm5oNW5TclNGQittSFRiWTlYd0x3MlVmSTNSa1VON3Jqc1ZK?=
 =?utf-8?B?dkFhTFVqNFFxdndDZkc2QmZCT1VnMXVQa2dmZHJIZExqUnpHaVlFUWtkQnk5?=
 =?utf-8?B?WEVqTkRrVUFUQ3pLTzNFOVVRY2JRMVM0MUlOYkk3SHI1Vndka3ZpM0YyVDBZ?=
 =?utf-8?B?czFuYkY2MDNiRkpESlcyWlRQMktMMitTa1dBVWJWL01MK002c3BPQXVORHpL?=
 =?utf-8?B?M2poOXRZL2VDS2x0LzZMVVdkckxWWjZpNnNSaE5MWnBHUzhDbytNUEsvTjdh?=
 =?utf-8?B?WGVUbWY4aUlqRXZBTEJZRndIbS9hTWdPWVNHaW9sYVdrZERhU3ZwK0dFSWpl?=
 =?utf-8?B?MDRaRVZKNVVoSlpMU3p0S0xndjlWUW9Ka0xVYThFUm5mRU11Z2J0Mm9HUUpK?=
 =?utf-8?B?eS9BWUZtYW5PYnFPM05qOVFYd2krV0tXdUh3dDFmWmt1NmErdHYzQ3BVdzdi?=
 =?utf-8?B?UjlzOW1abmxvTUg1ODhXTWx5ellZREZKTSt4OE1jOThKQWc4UGNoZ2pDSVh3?=
 =?utf-8?B?UTBQU3NJc1J0TXQ5UlJ3MDRwMy9ua3dpdEc0andNQ3JGOXpmYTRGYUQrNDRV?=
 =?utf-8?B?TjJqbzlPME5vMElyR2NRSms2SmxrdW93aVUwb3JYeFM4NFVjdGgxK29hbzFL?=
 =?utf-8?B?bWZGWjhKQXdTYklybjd0QXBHVDFXd0tmVU5ONTd6WTRVSkE3M1kyMDNHS0NZ?=
 =?utf-8?B?bGhKcytwcmtsMlZXMVRmbERaRk0yRHQ0eWxTZHBsMXFyeS9XSG55d1Z2ZFBh?=
 =?utf-8?B?eDMrdUdKdEFwTno3WndSY3NCV1FUSTdpNGlVY09zWFcyVUs1L3dhNUhKcVc4?=
 =?utf-8?B?cW5xVWY3eHlPNzdjdnNrZlZKa2RZbFRTTUxZa0s2RzhQMjIvNDI2NnJiQ1dU?=
 =?utf-8?B?OWxsZ2RxajZQbDE2WWM5T1ZvYnV0Uk9MNkNHdWdDZ0pCVlJ2RzR0MXVsSG1K?=
 =?utf-8?B?OXljdGVCQkJ5WjFuYjRZUkE2c1NXblJtUkpTcXFvMWNmQnQ0V0ZrTkNQN1R3?=
 =?utf-8?B?eXBUUXVuc3hiMnljNjhUVlg2dXdXeU1GZWpyVzJXTEN1ckY5YkZMenhZTkZF?=
 =?utf-8?B?RDM5aG1DNUhzVkNXUDNKZXFnRVBPS3dEb3NwMlo2enJHeWRGQzhxUGx1aXJ3?=
 =?utf-8?B?K3A0empqdnQ5Zi91QjFqeGM3Q291WkEzbnU3NzhZdUZyV0kveWhVUXpSU25j?=
 =?utf-8?Q?OMh9LYGY25+An+5WzGvhvjL+bOAg89Zn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4732.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aEZzVUlYaWtXci9CblhGLzM2NHdIUVZWYzl0c09FaXdldjVxaDkzdGVmMENN?=
 =?utf-8?B?Wm0vM2J4QmpBZWlybnNxS2twZHdCZ1o5Zi9wVGJ5Y0VJcWxYTHVYYXJ1OU1W?=
 =?utf-8?B?TDNQYUlrcHZqSFE4ZGUyTUk0QUtKRVE5N25PRjZhSHp1cUJBMnBMQ2dSOUwx?=
 =?utf-8?B?OEI2TlVrSnl0M2g0RGhzbHUrVUdJajhrRUJWMll0eks0WUsvcXhFOXp3T0JO?=
 =?utf-8?B?eFc0MVFod3N2MGtBdnZneTBQVkR4amNUOFgwdGNvcnpYNXVTcHIwSExydHBH?=
 =?utf-8?B?VGZLKzAyUVlGemhrZTFYUFhXUml1VHd6YzJWNlpRRmo3NUEzN1MwbVg1aURv?=
 =?utf-8?B?M1hRd2kzaUZ3K0ZMWEpib2pZSGJrV2syYmJhL2dpL2xubHYrSHdDUzh4K1pP?=
 =?utf-8?B?VUI5TUhrQktjYWxtek1pU1phWFBKODlXRzZMZkFIbU1kMVBHMXB2ZWtsTDU0?=
 =?utf-8?B?aW9KOVMzc1NtZ0hIOGMzUFNqTGhhVllDTjNScTcrRnZIYS9SYzIzakRJWWxE?=
 =?utf-8?B?cHJudkZMU3FodHY0dy95UjZmc3VLcmVVaUFTMGZHNzdiOStOZGErRS96WlQ5?=
 =?utf-8?B?cjVtdFhxbGdUZ3BLZk9uQnVGMHVqM0ZxNjZsUnBtRWFvMEVOSDVOVS9PcTZr?=
 =?utf-8?B?bHAzYTJ0WE42TGZzN21iaDROcVdxKzJIQjVwZmR0Y3NCczNtQ2VtbmlOanEx?=
 =?utf-8?B?aFpEalBvS2dieVA5eE80cXJzZ2hXOWNOSFhSbkdTOTE2Qjc1ZHdkZThHZExt?=
 =?utf-8?B?cHpDcVRIVy81RzYxeEJ2UUJja1paS0t5RzRsNVVuY2ZNa084eTh6VE5jQ2FP?=
 =?utf-8?B?R1JpRTNOR3FsbkxOdGg1ZTY1T3pPTUNpbzh5UzRndGV6Q2lTaTR6QmtZcUpB?=
 =?utf-8?B?Q1RYd1laK1hDdFVKcXBlYlR6dkJLa0xnTjZLSHg5QzI1VlBCcmo0RkMvRU5k?=
 =?utf-8?B?b2lZOFNzUzdEbkRXejQwUDBNUzQ4aXV3WkV4Zm00dHNXMHMxNzFKRXl5S1Rs?=
 =?utf-8?B?bHlCSDh3NFJzSjh6YlNNdnNVTHdQU3FocHFuajh1SzNmb09pcFN0d2hMWXhY?=
 =?utf-8?B?VHo3OTZvb0ZNVVZDT0ZWSHQ4UGFacjZ4Y1A0ZHp4L1pTZE1mNzBRR2d1Wmxn?=
 =?utf-8?B?K2pMSzN2VzlIcnRXSTJFTjhtL2hrSlBLTVR5ME5xdGNNcXV6YTFldG5TU1U3?=
 =?utf-8?B?TmVGbHJTTzBNVzN3RGZhaTdWc29hRWlyMVRVdUpvakFGTVpBRG9iMkljb0Vp?=
 =?utf-8?B?UWNnL3lhUXY1eHFldXhSVko3aUR4T3JHbXVQck1jZlEzQzNTK3ptNXVUT3BR?=
 =?utf-8?B?MlE5dEFqY3YxMDhkTFE3bWc1bVZqcFNZVTZHNHFLcjVkbGNRZUNnbjhZZ25T?=
 =?utf-8?B?MUN6TGhiTjdZOGN6SXlSNU5MWElvV0VwdFF1Y0ZSd2JCWmhXdEZtckdzUFFz?=
 =?utf-8?B?Y0ZMc0ZqNTBwUVpvVXh0N1JoTUp3bEpLZkdRWGNldDdmRVVZSDhCbTFJallB?=
 =?utf-8?B?bkJHNDVYbkp0VTBTdmNIMlpkcGRKSnFOSysxRTd0MjJFc1R0QmkvK1pJNGgv?=
 =?utf-8?B?MWZkdU4yVXlLUllJYjVnajlieGpRUFJQWVIxS0Z2VVVhSDAxb29JUWdyZDB2?=
 =?utf-8?B?dUZsZ1VBRXhpMllXUXB1VEtIdjd2MlB0MFhMcmxkbUZVQ05Sdm9BSW9VQ29F?=
 =?utf-8?B?bFozSEVIN0p5NjFrOHZXblM3MFlGbVNTTHhpWE55ZmtBNjNUaE9FYjF3dit5?=
 =?utf-8?B?OTIvQzJPR0grYmpBZDc0alFsYzQ1Mm5MYXhXK0pYS2sxMXo5aDk4VVFRMWtW?=
 =?utf-8?B?RHRuSE1FY1JSZDJQLzBTTlc0QldQaGY3MTVsTzVBUitpQVplNHN6UTFFczlN?=
 =?utf-8?B?ZmlScUwyTjlZbVNJa1JuUUFWWmxFR2k0Y3Y0MWcwM2k5R0t2WUJuQ1UwYnRp?=
 =?utf-8?B?T01ld3Y3SDdweHFzMEI0US9DOHdMN2dLcXRnaTE2RDc0SSs3eEg5OVp4SDc3?=
 =?utf-8?B?RUpNTHhFK3VrSFVRSDBuaklUWThONHYvemZIcWFBQ2gzZnAzMU5Tak5mRS8v?=
 =?utf-8?B?MkcyK2VJTkEvRGdsTUpDNkxtZXBDQVhaM1FsNzNVSVRpRWlQYzJGUFZtRXBM?=
 =?utf-8?B?OW9HQU9UbVQ2RURYaXFxWHRTWDlzV0N6cC9QbTdXY0dCMERpTWdyQzNFZm9s?=
 =?utf-8?Q?gWUt6QSUL54HGEuQb01ybas=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4732.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e114b580-ddec-4970-66e4-08dd7c2e08fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 14:58:51.7495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: de9dthyfMpKDj2n2eFbFez0UVhOZwomEqmWARPTkoz1+RbXOKFVwl1TdpZwBgXV3QAa78OMJ0N1YK/skp6YBbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4666
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <06DC83FB2C04FE48993264189B1E43FF@namprd15.prod.outlook.com>
X-Proofpoint-GUID: HVE2ZRFJMUuFihmAdWaOXQEZGdilBLWj
X-Authority-Analysis: v=2.4 cv=FfU3xI+6 c=1 sm=1 tr=0 ts=67fe742f cx=c_pps a=uuboLt+qr3MZZMeqEnD08g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=TJ1helccAAAA:8 a=NEAV23lmAAAA:8 a=iox4zFpeAAAA:8 a=rS-HvqRvPkmjRo7KKgUA:9 a=QEXdDO2ut3YA:10 a=AblZ_v9dXwsA:10 a=1reW4qy83QYD4J8wWhho:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: HVE2ZRFJMUuFihmAdWaOXQEZGdilBLWj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01



> On Apr 14, 2025, at 11:50=E2=80=AFPM, Qu Wenruo <wqu@suse.com> wrote:
>=20
> >=20
>=20
>=20
> =E5=9C=A8 2025/4/14 16:23, Daniel Vacek =E5=86=99=E9=81=93:
>> On Wed, 2 Apr 2025 at 16:31, Daniel Vacek <neelx@suse.com> wrote:
> [...]
>>> I'd still opt for keeping full range and functionality including
>>> negative levels using the plain `zstd:N` option and having the other
>>> just as an additional alias (for maybe being a bit nicer to some
>>> humans, but not a big deal really and a matter of preference).
>>> Checking the official documentation, it still mentions "negative
>>> compression levels" being the fast option.
>>>=20
>>> https://urldefense.com/v3/__https://facebook.github.io/zstd/__;!!Bt8RZU=
m9aw!7KPURbKO2g65XCAyShKtwZo6K7VjTovi2iOlXsfo1zUBg-bqxGY6TFndfisxqKk_kQzI$ =
https://urldefense.com/v3/__https://facebook.github.io/zstd/zstd_manual.htm=
l__;!!Bt8RZUm9aw!7KPURbKO2g65XCAyShKtwZo6K7VjTovi2iOlXsfo1zUBg-bqxGY6TFndfi=
sxqHPiTlxm$=20
>>> The deprecation part looks like just some gossip. It looks more about
>>> the cli tool api and we are defining a kernel mount api - perfectly
>>> unrelated.
>> Any feedback, Dave? I tend to drop this ida of `zstd-fast` alias.
>=20
> Not Dave here, but if the future of "zstd-fast" is not that clear, we can=
 definitely wait for a while.
>=20
> It's always safer to adapt when the terminology is mature enough.

Upstream refers to the negative compression levels as fast levels. Both bec=
ause it describes
their aim (to be fast), and because passing a negative compression level is=
 hard in the CLI where
`zstd -1` means level 1. So the CLI says `zstd --fast=3D1` means level nega=
tive 1.

However, on the library side there is no "zstd-fast" concept. You just pass=
 a negative compression
level to zstd.

Other libraries, like folly::compression, also refer to negative compressio=
n levels as ZSTD_FAST [0].
However, this is only because there were pre-existing "enum" values that as=
signed different semantics
to levels -1 through -3, so we couldn't just pass a negative compression le=
vel.

Overall, the concept of "fast" compression levels meaning negative levels i=
sn't going anywhere. However,
neither is passing negative compression levels to the upstream API. Both ar=
e valid.

I'd lean towards just referring to using `zstd:-N` because it keeps the use=
r interface smaller.

Best,
Nick Terrell


[0] https://github.com/facebook/folly/blob/5237d93b450bfd9170c4746f00aa583f=
0e662c2d/folly/compression/Compression.h#L113-L125
[1] https://github.com/facebook/folly/blob/5237d93b450bfd9170c4746f00aa583f=
0e662c2d/folly/compression/Compression.h#L446-L448

> Thanks,
> Qu
>=20
>>>> We can make this change before 6.15 final so it's not in any released
>>>> kernel and we don't have to deal with compatibility.


