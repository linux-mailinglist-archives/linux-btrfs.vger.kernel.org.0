Return-Path: <linux-btrfs+bounces-13139-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A3DA91E3A
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 15:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020F9464011
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5A124DFEB;
	Thu, 17 Apr 2025 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="BOv1xFUx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013062.outbound.protection.outlook.com [40.107.44.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAA924CEF0;
	Thu, 17 Apr 2025 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897138; cv=fail; b=pUQb3vuGflRu7dAsZPtik3m56IWx/1zAQZGVKHRnK5J/LJCIB6jjRiGkMNyA40H69SDBISedg9M/bzflWQZ9g0xPIJIN75PViTgL1ULYrh6vTNycl8DjUuS4NH8/g/bH+3gufh1eSoF+CmNlSYS0wp803+ecj2jNqb8ZLFjqR08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897138; c=relaxed/simple;
	bh=NsvoW0gkHYwlsawayUO2en/Y+B0+NJy/YposZJ+9w5Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hkx5THp7R689txied8G6Z2QJIEw+3+dj5Cw2MCZlJG8k8dVS0ifF9lmQNa0jZ8w7Ra5BZJoQ8mYPZpQ3/2Grq9ertnSJBujHKnyV1DHQ+W4XPQFya+LKSRmIvRYkJcv9oTWTQu9W/k5j/S08D3Mrgi6PnqM2ythWEb+JOymDvsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=BOv1xFUx; arc=fail smtp.client-ip=40.107.44.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBqsQHcEN+idwcksbvlDBPJAiB+8SoHS7zaXziOXkPkavRGZOv21xUFUK8gceyLVJuKhSy/bg6ZLP3djTSlrpF5SakRQNIPpRmjuDB9dULTy8C7avH9AWhzOR2OXYoTd+8tHYAblxmEiFSgJ+8eSGhrHxxmi5uJsgpuwvBZ0PHbHyeObn1KtVYBbWM8QYUf8IlXWzaMxYCmc47/4ez7lBWIERUEHyvfoNsT7eewghbEJnDSEVQnZrkkJyp1VAFsG5c9x77dtR9MIpQVlgUJ1WM6fVOKmcNbBHM9GBAvHKWllGIDQQHCBEhc0ZAI2aJsRQIhkXVLXzqCpPPuCDtH5fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsvoW0gkHYwlsawayUO2en/Y+B0+NJy/YposZJ+9w5Q=;
 b=r60SHP1AqqkwJiGY1uWORFJkpB/dVYwayOxgNw9pa+MSUewjNQXl3zG5GD64XYbH6ErNPwXxNMqujjb7dry/LjyzO5wlUJwDOcgvFWxZPD4NZ2dr178UfhZ0LV0ALX/bbszoDgv8zQtsDcMM3V4PtxMcmn0GdykmeWYae/3hH9JAofm1FVDSjlKf2GfSpTKxXZdExN9MoKzGJ/KlAhUF3pWktm7WgVylWM68OQ8T+jJUatGOq8DdWSxKJf+y+9TgJaPH69FvvfhHkJDq4qHGePAkKh1YlNoMrcO/XiHNxpqCSDRZXf9nhm4ErQZ/B/rBwFMHrV/qGZfKB1w6mwwQ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsvoW0gkHYwlsawayUO2en/Y+B0+NJy/YposZJ+9w5Q=;
 b=BOv1xFUxolIJ3WzkleZ4oyQSG4ZwFxcfaqho8iE19G50YMmXqcvCDV17GCegwboUSKEF5RktpoC5JRWyGk0xRzQ7TvpWqIyWbmaVx01u83Ka5Xrvq1jjkqhaG9ntvJSShqiGTa4B+rTn6sFcmNjskAAl8Uhr6tmQcj4C/V+moyHv7kSWH1lRTADcnxHTPmJVNp0NjY8n/7bxDUQ7JFSHmetCw6URhSSN5Btl6fAtDHEuBPmxCGv1oCXAWSqlEmcZ/Qedmi3nJgM3NI+YhVvAqz/849+C+WOEga5onHIIi8g8F5luAPRvB+mm9MLggoR1REweJQt5n5TNSlmQ9g6ySA==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5294.apcprd06.prod.outlook.com (2603:1096:101:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 13:38:49 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%6]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 13:38:48 +0000
From: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: "clm@fb.com" <clm@fb.com>, "josef@toxicpanda.com" <josef@toxicpanda.com>,
	"dsterba@suse.com" <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCAxLzJdIGJ0cmZzOiBjb252ZXJ0IHRv?=
 =?utf-8?B?IHNwaW5sb2NrIGd1YXJkcyBpbiBidHJmc191cGRhdGVfaW9jdGxfYmFsYW5j?=
 =?utf-8?Q?e=5Fargs()?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggMS8yXSBidHJmczogY29udmVydCB0byBzcGlubG9j?=
 =?utf-8?B?ayBndWFyZHMgaW4gYnRyZnNfdXBkYXRlX2lvY3RsX2JhbGFuY2VfYXJncygp?=
Thread-Index: AQHbqUw4sYIPuqvLkESzkGRvsTDgGrObqE8AgAEW+fCACEycgIAC3M0Q
Date: Thu, 17 Apr 2025 13:38:48 +0000
Message-ID:
 <SEZPR06MB526969B02B2896B80B3F68ADE8BC2@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20250409125724.145597-1-frank.li@vivo.com>
 <20250409183022.GG13292@suse.cz>
 <SEZPR06MB52695564F5DE73356D0EFF06E8B72@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <20250415175307.GK16750@twin.jikos.cz>
In-Reply-To: <20250415175307.GK16750@twin.jikos.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|SEZPR06MB5294:EE_
x-ms-office365-filtering-correlation-id: dc51b1a4-f026-48f6-0519-08dd7db52f06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RTh1ZWpiNXIwSTIxVFFPNFdmYnN1MkhIbU5qNklyRGl0Rk51SXRsaXZuNlNJ?=
 =?utf-8?B?cWJMRUY4MlRyMUZ6L1NIbGtXZ1lBMGsyc0l6eHpzRStocHBXMFZCTmI2a2Zw?=
 =?utf-8?B?U05OaVF1b1NpNXlPbDVJdjBQMjNoUkJUbkFiMm43SGRWS2c2ZTlCTCtuN2dD?=
 =?utf-8?B?UExoRGZCZFZsei81MWp3WC9Pck92RlQyZThLcVZVZjQyUTM3ajgzcE9rcENF?=
 =?utf-8?B?UWxza3RjV2JRTU5nMmdteStnSy83STBWR2ptM0NSdXJFb09pMDI0cU5ZUlhO?=
 =?utf-8?B?M1VHclY0bmNRM3QwT0laalpqM0VQVDdVMS82YUNZRVBUQXVIWHFGbFlqRHdK?=
 =?utf-8?B?bFBLZldqWTBtQjJkQUZaVlNiMUlmRzZhR0ZjRWdvQ0srZWUxK3lYaG9jMDVT?=
 =?utf-8?B?eXlxMkMzWjc2cnNZVGNiUGtQYW9McGJUcmlPYnZMR2xyRjRZeHdRbTNPMHRW?=
 =?utf-8?B?bmNja1NLVE5YTUZqMU9uV2QyQ1RyVkdUWUVvOFV6M2ZYUzh0cVBRU0hpb0pN?=
 =?utf-8?B?MkZaSzlnWTBPdXgzeHVvbHFWMG9ZZENkcVAxUUhTc3BGWG1OWnJMVEJpY3VN?=
 =?utf-8?B?UlYxY3ljcGsvRld0TC9uc3RxZmlTUkZIaGVQSHhURW9nNWRwaE9wQ0w2TTNL?=
 =?utf-8?B?N3FKOHhnZldHU254RUpmQmt2cldwNU1ZdmkrbFhYS0h6YkxubGU0czQwaFg2?=
 =?utf-8?B?bWxneUg1WHo0VHRUY09YUHJYVzdIclJLbzJscUNXbVBNaHRHOVEraFB1eXpu?=
 =?utf-8?B?aGpvb3NGQThKYnVjaCt6My9KdWI1d05lZjB4WG55elZWbmR3ZmFSQW5sd3RR?=
 =?utf-8?B?VE1uQ3doa1lEU0cwS0c3YzRuN3JBdWs4eWU0QmpJMm5pa3dIaUJLNHZFa3NK?=
 =?utf-8?B?K1NLTXpIOTErVEVoU1hhRUVUcWNPaVFLZFh6N0FMalZ4UGlMOGE2TVJlMG53?=
 =?utf-8?B?R1Q1aUZtMGRKcGxkNzJzM0VFNVppVm5UMWQ4UU5Pdk9kM09DSFFFZHUzb3Y3?=
 =?utf-8?B?OE5XdGVoTm40SEJJYWVLWk9LN0RGSFdtSjJDTGw1eVJiNjdzK1hVZFFxelNs?=
 =?utf-8?B?Wmo4M1BJaWZWUE9oanpLL0J5RHhreDhsSGhmbEpndzNTQU9mbUFLRkhkYlZU?=
 =?utf-8?B?NElYclhSTEVXU3cxcUE4MHZrZWdIY3QwQTlhR0ZWZmw0ejNlSCsycXR3bG4r?=
 =?utf-8?B?anNVVktGTm9jd1R1RlF0a2dhaVMrOC95K2x3NVhpMlFOSzlKY05YWW91QStL?=
 =?utf-8?B?NlBkRWlNRVYzczRGejcrVXVDZGpyeTZ1QXdRcWVadEpQL2F6L01BclNSZWl0?=
 =?utf-8?B?QlVHcld6QmdkR1lTV1pZVTNTV3RmVHQwU2FNOWJKS05NOTlkNzZmV2owOWNp?=
 =?utf-8?B?T1hMc2dLWE9oempFdHJpQ1FOa3FydHFyV1BiUGRPRmtPY0d5cFMvY1ZmYkx6?=
 =?utf-8?B?RGt3dHhpT0UvemwxVjRXamhtdW1tbHBaWFJLczEvaW84K3E3empjMzVqVkkr?=
 =?utf-8?B?R3lqR0JYbWtENEdsODVta21xR0FmSWY5WGZ1MytMNHVSZjVnaXZ6bFVqSkdZ?=
 =?utf-8?B?U3RDUGt3T1RIUzI4NStVQm1MemVrKy9aQTNCUytQc2U4dk5rQ0lqakRpVGZC?=
 =?utf-8?B?SDRyNkVjUmFyYzE5N2lkemF5NWhhbjNrbDZhZ2lBbU5hdnM3bHRRbklqdVV6?=
 =?utf-8?B?ZmNxcnpsN1dxL1VpV3N4Wk41Q1FzL3huUnJwdnh1a1c0cmdHbHhnb3pwM0ps?=
 =?utf-8?B?bUd1OHpqN2c0SlRtM0l3VGxqYVZVZHgxeUhlSmRTM3dXTUJsNm40YTJrRVJE?=
 =?utf-8?B?b21mSUdGUDVQYjZDNW5CZlJwVUJZN2xhUlVZZEduTDcvVFNpcDlwdnVuKzNr?=
 =?utf-8?B?Ulp5MW5UN3BrNXdhQ2NKQ0VpeDJxaGNObENYdkdhM3YyUm00UGIvUG5NSDZw?=
 =?utf-8?B?elpSa2pRQ25VVStGdUg3VzVMZkZ5Z2RoelQwUUNQdVkzTEZoV0hZSDdnK0c4?=
 =?utf-8?B?WkVxSjBBVThRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2VyOVRBYmlwd0NsU0ZySFN4TVdRaTRvbkFpckZGaDZHYnQ0S05XU1ZFcFlo?=
 =?utf-8?B?QnMzQjRaTDJjUnIzbnBPdUI5NHlrY3V6dFJZS29yQjFtVWlTZHd1L3ptY2VF?=
 =?utf-8?B?cENBSG5DK2d1cUVtaFduL0NYakp5TVpacG1uUm8wOTV5R25uSFkyYm03QUx1?=
 =?utf-8?B?dzQ5Vy9hVjNndXNKVkFXS3U0VlJ0T3F0THpSclZ3bU41NEdGK1AzM2ZpZ3FY?=
 =?utf-8?B?MTNQdWZJblpUV29pM0RZVzlEczBCSk1WT2RLZjJwb082ODVITVFZL1VBZGNl?=
 =?utf-8?B?WmRhdXduTGxiWXJKV3BYaUhSMjNZd2JBamFRTWVOaHlQbjhndit6alh3Q1lW?=
 =?utf-8?B?cWlLLzBrK2ZVY21id0UyT2c0cEFoRzlraVBZZXV6Y2lhR0c4bVRaeUZ1d2J1?=
 =?utf-8?B?MnlFdnRwUXVxNWsrZTJkK3hBTXQyYVVHRk84bmkzeEx0VXpvczJVemFHMXRK?=
 =?utf-8?B?aFBUQkFwZ25QMTVRUjkwSjlzTVZnMWRaOUdNN09vRHRNaFBza3psTGx1Y3h0?=
 =?utf-8?B?SzlHTkRFajhBZHExeEE3UkhVc1ptSGtsYUwvNjlOZkhjMWJ4QlI3Vjh3V0ZP?=
 =?utf-8?B?T1lRbzhCbXloZjl3TFZBL1BySHJzN1FqaUhqdDQ0a3djaG54cEhwZWtONlBq?=
 =?utf-8?B?RHo1SjFucDhQODdCYWxhQ2w2dERnU3l5VUJuM3EwYjdmYit6RGMwNjhqK3Rv?=
 =?utf-8?B?eGlVN05jNkxsOFZMbFYrZnUxczVCNXZYSmg5TXpaaWVlb2VHYWJLMWMwNmg3?=
 =?utf-8?B?SDdMNXlFSFVrUlB3WjVTN2xFQkNzYXgwaE9saFdMRnA3MkQySGNpdnU5cFZq?=
 =?utf-8?B?U1RZVFVsL2tJTm1aRVFUcWpqUjJ4SEZoL1V1c1BKV3dIRmRNVVpIZ0VncEFm?=
 =?utf-8?B?R2hCeUNNMGtJcUgzNC9mOVZDem5tblUxb2swMTQxMWlSellrMGhkZDhndFUx?=
 =?utf-8?B?UUcvY2lENmpxNFdDdU9kYjErRXkxOUY5dWJSMS94a2VGR21pSWl0bUhiWWpV?=
 =?utf-8?B?VTdYWjB3STZRM21BTjlpRy9MaWtndW1HRnVpek5RSHBuK3lrdjA2WW4vbTkz?=
 =?utf-8?B?eGZyMjNlOVc1bTNqUDRhcGJKQnM5R1JCb1FtTkI0RWptNWhpTnpPblB2MGJC?=
 =?utf-8?B?Z1d3N2Z2b1BXbjV3Yjh0ajkrYnNqRUNMYTF3S0VoRXV4VEZZK0IzOWQxT2ZN?=
 =?utf-8?B?U3JGWFFvOERrek81cVpVSSs3UTFZckxWYTRZc1UzMW00N3pPb0k3TG9BVmRj?=
 =?utf-8?B?cW93bW5QQnhLNVhUVlZCbUJ2TVVOMENoZzFtNG9kNi83K0VOMjNrNytndEg2?=
 =?utf-8?B?ZXFlc1U4NUNINTVvQVo2TGRuZ1RtZ2h3dlp6dWZRMThxRG5QZ0Yram9hbVFZ?=
 =?utf-8?B?QjZRc2Iyc2FCb04vc3ZOVEhmYjVIOE5uNnZNb1NnTDhmeWJvZ1grb1l6ektn?=
 =?utf-8?B?NisyMVZDNVJpVU1BQnJ3QzdNTExRSEhkd0orRklqaDV3b0U2NWd1djFiUzhE?=
 =?utf-8?B?dlh6S2kvaEk2bE43YUxLZzJRNmJuYUhGbXJHRzhyS1Q0cmpxSERWL0s1UHBt?=
 =?utf-8?B?VzBRT0hjM0JyYXZ2TDVXZWw5UDI2V2JxcXQzdVhPb3RIbGlZSDQ1cFhOeTZ0?=
 =?utf-8?B?bmh5NVN0dERaRnNBamdZTDV6eEVzTkh2ZU1ialhOSjRNT0JCRkswQVd0aGFQ?=
 =?utf-8?B?VEdCb0dxdXIxR1I5bTk5elBNaXRrT0RPM1Rvd3BvTFcwdlA5MDFhNXZPVExm?=
 =?utf-8?B?WW9qN09LWUdVQk5DNkM0emh4dUtETVhiSXUxQStYbHlhTzA1d0lzQjBzYXBH?=
 =?utf-8?B?WktlUitlQmlLZi9qcUx4ZE0wRndsaWkwZUxwS2FGQU54ZlNSdll3SFV4SmlI?=
 =?utf-8?B?dHY4UC9tRzZGRjdweWVjZUZDZHkvOU9nTDlpYjV1R1JCaks2UjRjMTZIb1Zv?=
 =?utf-8?B?ODhCRmhFemVqVXVBVmc2NEU3eXpsQ3NaQ0M2VEdyZXZCd2xLSDNWUkZnVXIr?=
 =?utf-8?B?Q3NhNHcvWU1DdmVXdGk2c0FkQlhwSmtZdmdhTmg5YnlFaDFPSmlPZFFROGVF?=
 =?utf-8?B?aXNWSis0elo4TVhFWEVnZGNaT3hNcG5iQithSE9rRHJHaXJNMlk0S0tnejVl?=
 =?utf-8?Q?gLe0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc51b1a4-f026-48f6-0519-08dd7db52f06
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 13:38:48.7591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QrJHIEuB/SeYTt34gCiTpoR5D40LLMK9xdoyfh5ciE36RbBk78HUNpEi0MibC2NkzMPhj5H1giY+dYzKxxYbLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5294

PiBZZWFoLCB0aGVyZSBhbHdheXMgaXMuIFRoZSBvcGVuIGNvZGVkIHJiX3RyZWUgc2VhcmNoZXMg
Y2FuIGJlIGNvbnZlcnRlZCB0byB0aGUgcmJfZmluZCgpIGhlbHBlcnMuIEl0IGVuZHMgdXAgYXMg
dGhlIHNhbWUgYXNtIGNvZGUgZHVlIHRvIGlubGluaW5nIGFuZCByZWFkcyBhIGJpdCBiZXR0ZXIg
d2hlbiB0aGVyZSdzIGp1c3Qgb25lIHJiX2ZpbmQgaW5zdGVhZCBvZiB0aGUgd2hpbGUgbG9vcCBh
bmQgbGVmdC9yaWdodCB0cmVlIG1vdmVzLg0KDQpPSywgdGhhbmsgeW91IHZlcnkgbXVjaCBmb3Ig
dGhlIGRldGFpbGVkIGlkZWEhDQoNCkkgd2lsbCBzcGVuZCB0aW1lIG9uIHRoaXMuDQoNCk1CUiwN
Cllhbmd0YW8NCg==

