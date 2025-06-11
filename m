Return-Path: <linux-btrfs+bounces-14606-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D235FAD5A70
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 17:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820EF16B309
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 15:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B4D1BD9CE;
	Wed, 11 Jun 2025 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ICJ1Bes+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E72F1ACEB0
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655731; cv=fail; b=mk5NtNmhIclaI4AuOHfcTbd/JNuJYyMjhJ47fztDd2+pFffl2P9KoERYwmlOKVa3yYFwkevA9uQJh2n+Koc1v0HE6Lo77z07Cj/6CJxdtNPZBeD6sqABkv0ROusz43A5QG8tUTD5+5PUdKVCWAP4dIT7Z2ZEqNSkyWEVfZi5qZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655731; c=relaxed/simple;
	bh=D669ibcODc7yx4OI4+kegMtL0Mns0SjtZnrKgd1lcMg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=afnCff4f1W1hnTWMXultZuny52ug1A7yR0ZtSZ507Kk4ki11mIk4Gm1jmSxT1lr8ojnhZpMMxaP4KF8zMzPw54r/1fJeAJi2cxuZTZZdRVqUOjcNlq4XbmzGcuMbacs5n3Ry847JJpsrwUMfAbJ/a5ItC015LJdHs7iRrzaNKPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ICJ1Bes+; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BE58ba007645
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 08:28:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=D669ibcODc7yx4OI4+kegMtL0Mns0SjtZnrKgd1lcMg=; b=
	ICJ1Bes+Ws9xu0xx1blJ0EHgQAFDUOfOASsxxsIE47PhjIMeTGaMkrA1O+llQHNo
	+q6HluPlda6NSIXPv5oPKAi+9kO2dwiriJjrwwaLMPGRsqb2UQSYTVSaNjqIhzkb
	QqpDS4doU0rnKWFPmsm9fpAXlbtJ1hKhqhbfhooMk4JfPKmWwdrR2kFOQCWwpBIg
	7grpKiv6+qWlgSzQnnCq43A/iuSl7WkO8KY1HG95JSXkIOWL0WQDVKj9KILTVlmU
	LhWtgoJtvXuwj/VC/dVIN/402iACHF0kIRJdpNnB22YjUXX8hWOLSWM9514M1n9L
	XeP8coQpVMzkY7W979eX/w==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 476yf9mndh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 08:28:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktZrlQNUHD7F/ctfgrm6oWbbJZEcOTJGex3LzJypTKvwkwyLbAgcEOexgGEveAv8MnkN0oolzqV26L1TQQypWZnraqdI0E4POhbyBxFV06E3rL8fcGJ6CY3bLpkPGTNrsbXUFQFunW7WxtTw2u91hJ5/obRsYvTb+eodHJ+eoomdaxT5DQjmWPKF/4q94CSoKuIeebkNJ4sjZRP0UmxIaJFJ7j+PlQ+ONtiAaiEc73nm+rUYHBjYG4gBCcoQTNBSVv2fI4jPhocWGrnLUAQ2prZ2c0YBBU1Qsqt/iIXB9VrdXC4ga8eF9KU+ljKW8Tq9lSsB/wKRYrmkvtVzUIUXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D669ibcODc7yx4OI4+kegMtL0Mns0SjtZnrKgd1lcMg=;
 b=CXjR/C7rLGVemnd+bx7oWL4soU1WmNpD1LhWJjB0m4c20A4GQzP5sTuGD6F5oKUhwKENLrDgLBGElReu8fGwcG2N4HeknqA/aLKx0OUWOFlGUWpny5vhEuQ4Ul6viaqYOqu7l3TrVWxL17RHA+6uAGe3rk8N7kZ9yYpuXvT8qyx2+A/tnWRL2xdjMwn0FJfjyiYOSZjDH0RbVZnF7eDzhHspC7pJLPyW7rtny0ugOaZL0FAaUllYayCqjQL6YRqtTVXsIk2tIHNF0cNnonq2tWfXr6zw3WtpqJBNMkJ3ZGyi2WgNRnDwfFvtsD2WyMmEPf80e5MMg4M9IGybas0Aeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by BLAPR15MB3987.namprd15.prod.outlook.com (2603:10b6:208:275::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Wed, 11 Jun
 2025 15:28:39 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%5]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 15:28:39 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/12] btrfs: remap tree
Thread-Topic: [PATCH 00/12] btrfs: remap tree
Thread-Index: AQHb1jY9ptj9DkqFPkuHGxeXOfmKP7P+HpUA
Date: Wed, 11 Jun 2025 15:28:39 +0000
Message-ID: <d9509bfd-72be-4356-8a97-0fe5aeb3c453@meta.com>
References: <20250605162345.2561026-1-maharmstone@fb.com>
In-Reply-To: <20250605162345.2561026-1-maharmstone@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|BLAPR15MB3987:EE_
x-ms-office365-filtering-correlation-id: cf261d94-9498-4c89-e095-08dda8fca400
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZytTMEtXVTdpNUFGM2RsYlRzbTBCL24yQ1V2bmRXMDNrQmYxVzNsU1FXajVP?=
 =?utf-8?B?Nll1dFJ2U2I5MU5lZVIrZnBXV0Jwc05LbTl4cloxaDhpRWQvM25FREtHWjZ6?=
 =?utf-8?B?QzhrUnBvZFVOaU1oUmZyK1QzQ0hsQSszODNVSm5hYTdRdnFhOVN2bmRycmNk?=
 =?utf-8?B?NFNJZjQvRWwwbmZyaXJmdS9SaXdEc0VBY2UwMDhCM21uU0xzbzBzcEYzVTU5?=
 =?utf-8?B?bGJQUEtGZU1VSlNIb2dnZ1A3eWc2dnpSZElzYUtlWHZaRGYxaG9ET2N2SzdI?=
 =?utf-8?B?a1BaQ0M4anA3MGFvTkhsRFZxQ2pTZjFEYXNLZlptMFJSSnpLLzk4ZW55QmRG?=
 =?utf-8?B?Tk0yZDVsYW9zdFd3R2Zydm84VTBKL3lrQWxLZTRLRHJIdlF6d1J4RURkQTFt?=
 =?utf-8?B?Mkh4U2FCR0EvUjlHWHVKV3VQK1EwRkhURjZuaFhpa0RlcFo4ZUpmZVBVOTZJ?=
 =?utf-8?B?NEpVWWNSNjZ5Yi9ldzd1WVhUcGRSQTA3THhUZ3ZnTHl4M3JNdUE5Y3pHUWJU?=
 =?utf-8?B?KzdpUitwWlNnTFI1d0tFK0hqSWRPVVRLR3ZuOFUrSjZFYlhtZVBiRFdXK0Fu?=
 =?utf-8?B?NXhndzBLMGR1UWVtTlFWOW9zSnhwbHlsc3ZEenovcnVFQldNT0hMdnkzTXEx?=
 =?utf-8?B?RnV5a2IwZEtDZzhyMzZidkJOZTFUVHRyM0JxNU94ZkxudkRmR1FxRlZrRHh3?=
 =?utf-8?B?QTFtNUNSeHZEVHE1ZW9WdXA0TVBhZExLQ2s3VXA2cjZyd1lnQnlYalN5ZGVM?=
 =?utf-8?B?SFhmLzVjcDNreERHcGxyUHd0L2MzeUVEVzkyQnFHeDN4c1Jnc3ZuZTdPdkZM?=
 =?utf-8?B?cy91aDdpNDI3WDRIR25aWVA3MG4zb2FqdlZwbWRhSjgySkU2RzdLZVpCUnRm?=
 =?utf-8?B?V2FzdzU3T0tQYUxMcUdPcko2WmM5VWZ3ZnpJekFIVXF3MHgyTHpXNVp2Tmtw?=
 =?utf-8?B?dTQvYmtRaC8zV1doMlIyNFc3NFpsOGJ3NUMxV01oWUhVdjg3S0RnWXRDUm5C?=
 =?utf-8?B?aXYrcS9UdVc4d3R3RXN1SHg0dElDQWV4ZndSbkNUZERCRldqczJUK3FLR1c2?=
 =?utf-8?B?ZnJib3hCNFVwcUlFd0RmTkpORFpvSGJFcHVVR050d1JGM05zeElWUy9uV3cr?=
 =?utf-8?B?TnU1cThoMEVJRSs2dWQxRkNxaGl2MkwxcFZoVGdLMktndzdGby92Y0hRYjQv?=
 =?utf-8?B?T2MzZUZjRHM0L0UxUDJnNjNwVExTNUY1M2U4d2s4ZFBYaHd1RVM4ejk5eGdo?=
 =?utf-8?B?d042Skd1eWR5UjBzeVd2bGozMmpSSm5WenJGWHFwU3V3cUNVU2NhbUJITDJX?=
 =?utf-8?B?ZXYvKzRuRlhsUk5zaHBTaTR5ZGhBSHBQRkNtTXp1a2tPV3ZIdnlaUExWLzFp?=
 =?utf-8?B?U1AvNGZRaFRyQjJQYytXMytqNlJJeWJpSytWdU42Kzlab05xYW1sZEtxUXow?=
 =?utf-8?B?U0hNbnB0S2ltQTA5U2ljOXNwWHRUditmRTl5UGlQblhiT1cyVUZrQWdNOXpX?=
 =?utf-8?B?cjhPVDhGYzdaNS94K3dPSEJLQmsrYmE5UUI3aXJUMTZwZTlBbmJzSjZ0cUJZ?=
 =?utf-8?B?NnA2L3BBVEc5S3IzelY2SzdKMDE2WlNkMmczRDJ6SHdwbVVkWXlGNUx5OEI5?=
 =?utf-8?B?Ni9NK2RjRVBTOUdyYzJKMm9xbDlsVjUxVGJVbVFkZWRrYVFseTFTa0pHRkRj?=
 =?utf-8?B?djN1am5MMjFsd0djNDl1ZFR0YTVEOVlTUnkycTVJNkJGakJKWkZ5WVR5K1Jq?=
 =?utf-8?B?WmZ2Y1ZpSk50c0tOVFZBMGIwN205R0Z1bkI2ZXVDQUU2SVRrbjdxOFhTMnlP?=
 =?utf-8?B?QWpVNFo1NjVodlpNcGdQUmRBTW1KL0hFQTBRTWhVOE56Sk42QWZOMzR1SEZH?=
 =?utf-8?B?cldtVFFTWVRFNGF4QWE1S3NYRUZkVzIzVzBMc2owcnNsMXo1dzhIRVlkVlBt?=
 =?utf-8?B?N3ZYVGhwWk51UTlsRVp6N2tYaDRxRTFPQWcrN0t0eCt1SXYxUXRHcWVUYlVx?=
 =?utf-8?Q?N7UBX5nMh6N/vQFncQ1kGkqt6VZOFg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S3lMYm5Qa2lPM1pYdkJlemR0ZjdqL0w4RG9LNE0zMGQ4VUl2SXlWOEtGRS9G?=
 =?utf-8?B?ZXhQdjQyZ0F2WGErSmZ6czM2MGdKUlBtdllCMW02MG9Cc21sME9xdGtLK0l1?=
 =?utf-8?B?ZHNKUzFGMjhJeE0yQzVTZjlTYkErR3lZcjVqUHBFWG5JL25MQlFuZFRMUEh5?=
 =?utf-8?B?NVVNUjZPQXhTM0o3c0RHTVhjTGpZZHdrRzdyNmRkL0pnRHM5TG41dVVJQW13?=
 =?utf-8?B?UUE0NU41OWcyT1ZVZURLUEdYMC91bGliZC9WbmtyTklCVEZaeUxudXhXRkVZ?=
 =?utf-8?B?MnJ2RDZ2bkRYSUtZTURTYXNNQWNoaXhvaXdRdmFxblY0by9JRlU3bVA1NUtv?=
 =?utf-8?B?RlJVSW05L2RMcWNuZ0VDVVVvcEJmVFA5SHhzME1KcUNhdm9MVGtHcFFCdUsy?=
 =?utf-8?B?N3cxYnF5Ritrb1RhL1NOQ1lERlNrMHBFcUFwc3NDeEFzWFZNaHN4K2ZJbVky?=
 =?utf-8?B?UitqQnVSUGFVNmY3cnh0VFdadDFHdXBOelp3QVgzbDdFRHZWTmpXYVF2V3h4?=
 =?utf-8?B?Q1U3L21zVTY0Z2c4L29NcDZIbUswMlVUb2dlM3UvaDJCWHBteEVHUkRTVzRH?=
 =?utf-8?B?Y0xrWnJYNjd6NVFzc0JKNGI0VUIxQ0NOZk52eFpKUWRpZ3l0QXhkNXpVeE1R?=
 =?utf-8?B?MUJOcjRrdEQwZXVRMUM0WHJsL0FQZTV4SzlGWWNONFdJb0pKTUt1eVF4QmNE?=
 =?utf-8?B?MVcybnJvbFVvQjg3WW0ydytzT0VJblFscHh2SHkwUW5ORDlhUmVwTjA0UjlO?=
 =?utf-8?B?TXhwdmM4MXZWV2RlWDFFei9mMFJwZTA5dUhNQWY4cXQ0R2xiU3o1RG9wbzl5?=
 =?utf-8?B?cnNINysyWUt4dFEzbGJvWVFrMDRYZitUbDA0K2RaQU00V0dxQjFjYUo5cXRr?=
 =?utf-8?B?ejZNaXlVWWowZVZNVU9EZ1V0eDlVYVV3cytPMkpRZ3RPZDE5Q0duemJNZ3g2?=
 =?utf-8?B?TWN0UHBZUE5CSno3L2k0VFR2M3pOU09VUmFuTnkrYnBGVFFnY21VK1kvbnls?=
 =?utf-8?B?TGZJaGpXZG5JV2lqd0ZraFFsTGJJRzdnbnhZbGF6aUpCSDNCTFFpVERoNk8y?=
 =?utf-8?B?c2pmd1RERFVUWWhIOTgwM3JuMVhqSFp3c3F5bFVoWDZxRkNubVgvUndNbW1U?=
 =?utf-8?B?R1ByQkZjWFhvaWlobWdFRDFxU3lDa3N6eHpsdUs0WEVaWWpQRXZhdTg5NDg5?=
 =?utf-8?B?eEsvUFRXTHRLOUNzSklDUXJNSERXWUhsVklWWnBwSkh2TE1mYXMwRWVpZ0xh?=
 =?utf-8?B?dXVsVHVUQVpGTjZSUW9KWG55aUc4WDVHTCsyT2VZYzdvS0dHcUMxYjIyekd5?=
 =?utf-8?B?b05GUmZCNGJjVitSS1E3T3NHR0NOeUpOb2k0dWhDSmxZTWdMZFVURW9tTzBC?=
 =?utf-8?B?NTJNTzViOXVGZ0tiWTQwdjJXNWFGVk1WMmF2OG81SmxQd0lGSDZHTU9mcUFj?=
 =?utf-8?B?eDdhTEdCUmovSHdqTDNrMHlwTkJWWmZGNG1keTFkQTQ0K3Nsd0FHMU1pWG5M?=
 =?utf-8?B?b2VIR0p0RE03cEtXclBRQVJ0NHVhZzF1U2RYQ1k2Vi9qU2FISi9udVRzZWNa?=
 =?utf-8?B?YkxyNXZsMXZEc292WVoxeUFTK3prZVpRZzZBK1o4cVFJaGorb051SHZldG9m?=
 =?utf-8?B?NmdoVnlvUVJDMnArZkZpM3RvRDc5Nk9EVHdHR1BoUnVVbHExaEpob1BKT0dh?=
 =?utf-8?B?S2NBckxXdWpEd3JkcjN3VWJ5Sng5QWg1TkJwblN1VXFJZEkwZVBOY1NrbFdX?=
 =?utf-8?B?eU5FN1hxQ2J1cXVHWTZkakh5ZWJ3TVFLSzdBTm5pRnhxa2JHUUxhQkNaVVVz?=
 =?utf-8?B?Y0E0YVViOUJqQlBJd2h1QTFSbG91ZlB5YkVMUlNjK08wSzk3TUZNOUF1SEMx?=
 =?utf-8?B?QkZLNnNvZU1VN2NXbi9aSm1hamlSWXU2cyttUWdybUJ3MGZvQWZsUzd6VFQy?=
 =?utf-8?B?L0ZUN2pndkx1OVFwY2RkZDFtUmZ5SjVkSlZ3VlRtaDRQMHVFSU9kRkNkcmk4?=
 =?utf-8?B?TWxwZ3VtQVUyOFZkOTZONWs3UTRScE5FQzZObVpUQ0thRUpOTnhNdGE0aE13?=
 =?utf-8?B?YitpYVAzNkZZanNXdnZPbHl6M0FUbVc5cU1Obkw0UFNLMTE4YjRmdkswSVg3?=
 =?utf-8?Q?tvmE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <667B5D25FD4D1247A4A2C5C28C72953B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf261d94-9498-4c89-e095-08dda8fca400
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 15:28:39.2978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 40Lhv/JszCIjUpvNoo54QDiRRqwsURY0wcPOYLzu8n6dTXAU5CNpb2UAc+QEWBQmjQ+jWWyPg138cjjYkjDDfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3987
X-Proofpoint-GUID: nuKtSL6JM05EMKbMHLMEuWvbwJu8NHFZ
X-Proofpoint-ORIG-GUID: nuKtSL6JM05EMKbMHLMEuWvbwJu8NHFZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEzMCBTYWx0ZWRfX5nMaE77LI/ev NUtKwqQHTi78CM3O4pmjDY2AGSAgVOml9bu1DvJ4KiKqN2gtSed8OYJ+wbqrf6X/txNQxVMqnkn qwdmtgLkOMSZUt9De0NQ0xDssEHvCHSXNO6ArX+W8x3mys0qeARz3RzKN66RUO//FeuDfVdep9y
 dx308jwUHT0OU+X5nIsMidSFOXF9RID7YxhzbqKm/cPuPhpmL447lIA6QF+450BgL+vydeIDP2x 0erHsRpb5efGuyesfHjIKZPQ5IrGigRoiSM+fxcoywR4gFUT4AiDO2uFPgJR5M7fCbOAwtGzEHt 03n25BwmbopLUuUk3xBd17bFdGXsvyXZZsXoqehP1WqxdtwwWrSb8MIbJe8jrAeJ7U0bS140lE4
 XY5xqaOSzi2xQ1Y/rLnWsKL44ujP8cSEdVfJ3gYCVgcUKINwvRy61FFHVMjQsAjvuGgNm4A4
X-Authority-Analysis: v=2.4 cv=Maxsu4/f c=1 sm=1 tr=0 ts=6849a0b1 cx=c_pps a=gkowCl0aGI9AdbyrVFZYCw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=sD553CNFb9Twki34Zf8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01

SXQgbG9va3MgbGlrZSBvbmUgb2YgdGhlIG5pY2Ugc2lkZS1lZmZlY3RzIG9mIHRoaXMgcGF0Y2hz
ZXQgaXMgYSB+NyUgDQppbXByb3ZlbWVudCBpbiBiYWxhbmNlIHNwZWVkLiBUaGVzZSBmaWd1cmVz
IGFyZSBmcm9tIGFuIE5WTWUgZHJpdmUsIA0KZnJlc2hseSByc3luYydkLCB3aXRoIDY5R0Igb2Yg
MjM2R0IgdXNlZC4NCg0KV2l0aG91dCByZW1hcC10cmVlLCBmaXJzdCB0aW1lOg0KYmFsYW5jZWQg
NzEgZGF0YSBjaHVua3MgaW4gNTU2cyAoPSA3LjhzIGVhY2gpDQpiYWxhbmNlZCAyIG1ldGFkYXRh
IGNodW5rcyBpbiAzcyAoPSAxLjVzIGVhY2gpDQoNCldpdGhvdXQgcmVtYXAtdHJlZSwgc2Vjb25k
IHRpbWU6DQpiYWxhbmNlZCA3MCBkYXRhIGNodW5rcyBpbiA1NzRzICg9IDguMnMgZWFjaCkNCmJh
bGFuY2VkIDIgbWV0YWRhdGEgY2h1bmtzIGluIDNzICg9IDEuNXMgZWFjaCkNCg0KKHNhbWUgRlMg
YWZ0ZXIgYmVpbmcgY29udmVydGVkIHdpdGggYnRyZnN0dW5lKQ0KV2l0aCByZW1hcC10cmVlLCBm
aXJzdCB0aW1lOg0KYmFsYW5jZWQgNzEgZGF0YSBjaHVua3MgaW4gNTMzcyAoPSA3LjVzIGVhY2gp
DQpiYWxhbmNlZCAyIG1ldGFkYXRhIGNodW5rcyBpbiA1cyAoPSAyLjVzIGVhY2gpDQoNCldpdGgg
cmVtYXAtdHJlZSwgc2Vjb25kIHRpbWU6DQpiYWxhbmNlZCA3MSBkYXRhIGNodW5rcyBpbiA1Mjdz
ICg9IDcuNHMgZWFjaCkNCmJhbGFuY2VkIDIgbWV0YWRhdGEgY2h1bmtzIGluIDdzICg9IDMuNXMg
ZWFjaCkNCg0KSSd2ZSBpbmNsdWRlZCB0aGUgbWV0YWRhdGEgYmFsYW5jZXMgYXMgd2VsbCwgYnV0
IEkgdGhpbmsgdGhleSdyZSB0b28gDQpxdWljayB0byBiZSBzdGF0aXN0aWNhbGx5IHNpZ25pZmlj
YW50Lg0KDQpJIHJhbiB0aGUgYmFsYW5jZXMgdHdpY2UgYmVjYXVzZSB0aGUgcmVtYXAtdHJlZSB2
ZXJzaW9uIGhhcyB0aGUgDQpwb3RlbnRpYWwgdG8gdGFrZSBsb25nZXIgdGhlIHNlY29uZCB0aW1l
LCBhcyB0aGUgbW92ZV9leGlzdGluZ19yZW1hcHMoKSANCmNvZGUgd2lsbCBiZSBjYWxsZWQuDQoN
Ck1hcmsNCg==

