Return-Path: <linux-btrfs+bounces-8546-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C480F99002E
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 11:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34843B2511D
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 09:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C2014884D;
	Fri,  4 Oct 2024 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cz7UdI++"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D09213AA26;
	Fri,  4 Oct 2024 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728035134; cv=fail; b=tiFJG3cbfhFlJnFEdpdRJ4rzOyGEVQsHQveQHKrzEhlGwKzk2N4RZmRAYI0CDXDCTWfizN0zLvYjXaNbtQ+UtHCQoVb9i0YD0cmwzwWX/C4w0CaSnvsrrCcEB7fZ0SmsfWSjcdKxyAkYZvnpbHERs7M+ccZ5yZjA0IL/vP3yovs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728035134; c=relaxed/simple;
	bh=vgkyy7+woRQIclit5P20t76wr1e6ETNGjk9eQM3bpk0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Pr1qDsnM5EA9ZPvE5usz/PZdUiWYl/xPo8gdt0cVyMP5AZ9Dj4p0mNVO7D1s+IzP2qdGVdoy5H/DpVe0HFCRfjxk/ixvLX5Ys8ya9qEL0tPNg/8rXKFi7g68oSfA5Ip97j/jMCdXJoxgF2ZtrIiP2MHd/zpvqp6V7xcjDrMv1pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cz7UdI++; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493NEJSq027268;
	Fri, 4 Oct 2024 02:45:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:subject:date:message-id:references:in-reply-to:mime-version
	:content-type:content-transfer-encoding:content-id; s=
	s2048-2021-q4; bh=TV0XUF0s44at1MppzuwBMbqC5oxeaWDFVXUiHk8AU6I=; b=
	cz7UdI++LxleodnbaSxOQESJSf4KUXJ2nHI0kQqsdUkoqZxMuUjG7OOJjDtL0KXK
	bvFmsvEsTG3LQevHVynTmPxoNAARA3iAGz8YWhKFtGa2N6MZTKwBkcOUSlP1cSne
	2bzEZaMaH/watfgu4Wy5h5eaKYGKTEJZxDQytjmyD0o6gPJO53ydKypuJ6VGcaIF
	lCzyOgdXIJ0dEFaTUlqoisUubkVllqBYcxtm/F45tHKrsLOgID/A5yOZsbRIuMsX
	6LCGgjeYu26WNTYwq5RBb59+zbGtjzxM6CNCXHmhBsuNHzts5KWXZOicfj0ak8HL
	BLfehdas3nbivfpp0P/0xA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42204bmf8r-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 02:45:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfLmchBx46IjFAToJWwhyfdV09s74mdGFR816lRdFd8jqY2tw2ZKb/5Hjv77Zc0CopUeYcNHoseXyF2rcnHwKJDvpQoe2wR9g7kZn4mwuD8nOd4jTtkIgg1g7rh1J2nyP+lSel0hWXp/wIfwthxWAeQfaRz7kkfcy3lykkZdvpoSUqw5z0IOzBUPTNnpV6PtQ2n6hIuEqZhnNJRVJ5a6IgOoU+O7CChL/S9YbHM4JKpEESKfKMKAIixKFg9UUJ4mFdHkS9P1/1ncuuo9bDSURB8nTwGN6QqIDWyZXtJ+aEe9i7aNGtDwQ+s32hf+H3gdmpJRw8oP4LsUoVsld4kltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDZIyW+L3HYsmmAWXFLrdRwBP8rP26GLKdUmZL9W7b0=;
 b=TUvt79s0mJwMo84t1uIuwwZkQdHTAUIuIARFy9Ef6jCQtHUEd13KEVEEorDPo0XjeOBYl/eeISSu+ZD2B2YEWmKDhyQitdglzxR+QCCNLagAgvf2DnjVGpmsWOfoFWGosqQHi4ZHuCMyTJoFPDJxEhB6El3Ik94Fy16Wh/+WihvDrj0ZCvvZGXVlhiQxHyLLRXBtJPeN1JCOISPG0bj1oZt+LWtvM1czTh9eQgABom2NcBIwq6oVGZLtRBeZ9uoP13y152F0WktiBmmLroPN3UU1wjiHJHG+oxPfxrMCyRTapKKqfA7AxXTBuDRm1jjCylXCVlRil/u4D7k4AeDzsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by SN7PR15MB4222.namprd15.prod.outlook.com (2603:10b6:806:101::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 09:45:28 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%4]) with mapi id 15.20.8005.024; Fri, 4 Oct 2024
 09:45:27 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>,
        Boris Burkov <boris@bur.io>
Subject: Re: [PATCH] fstests: generic/563: use fs blocksize to do the writes
Thread-Topic: [PATCH] fstests: generic/563: use fs blocksize to do the writes
Thread-Index: AQHbEsp5iu5dYsCLq0y2OujvUfdqjrJ2XrOA
Date: Fri, 4 Oct 2024 09:45:27 +0000
Message-ID: <805c5e48-050e-48b2-be53-1a2f0fa4a088@meta.com>
References: <20240929235038.24497-1-wqu@suse.com>
In-Reply-To: <20240929235038.24497-1-wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|SN7PR15MB4222:EE_
x-ms-office365-filtering-correlation-id: 5b58b4ac-2e29-4283-a47f-08dce4594748
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cVozZTgvcmVXeUk3d3pIOVNPVEFwVU82MjZSL3JoazdEaE5xazQxbmF5OWUv?=
 =?utf-8?B?TmtnbnVpcUN1c0t2dzNsZnQ1VkJHcE9lcEZtZDhlWjFmeE51MjJWT3c4c21h?=
 =?utf-8?B?MHRVMTRCTENYRW92YkJEd2VPNWFzNTJ3S0RtblUyaWpLZFZrL0dRN3o5WEtH?=
 =?utf-8?B?T3FYZ1YxZkdHWTBvdUIvbDNYOGlia2hueDRzOW9rbEJ1bjZiN29oTDVCSVU5?=
 =?utf-8?B?UGxUVVVEUldiMGZ4K0RDYWNxN3V1WkVkRlQ5UjBJeHJoeEFESzZPRWkya2FI?=
 =?utf-8?B?eWZJRE9Db0cvSjAzL3k1TzhOZmxZcEZmQVVPV0M3VEtkeHhXdU1OWXlPNExK?=
 =?utf-8?B?dnJkM25vc1d6VXBDVUFFQVAxWmFpVmJoUklFRVlzMDFEay9nL2lVSmdvMHFM?=
 =?utf-8?B?UGNMUGt4THQ3SW5OMFY4QlE5OFh3NGtRTVZkNWVzYzVEbzlNcjBDWDJGK3kw?=
 =?utf-8?B?d2c2Yk9rSU95MHlncXJkSDY0WUlTcWNmbjVCcHY1eE1nMS84ckxkTGI2c3pH?=
 =?utf-8?B?bTBqVkZGSm1oTFBLY0ZJcHJhcnp4Q0FCVlpnV2hwaDY5eklieG92MnZWbmFM?=
 =?utf-8?B?YTBLL1hCNzY1ajBtR2N3UkpNTUpSdm1zS2dDeVRNeG1Jam1wRnBZVWdtNTB6?=
 =?utf-8?B?dm13Q1RKd0V0dG5UNS8xdU9qdi9QdjFWS3l2d3FoOUJseUU2aDkydHNaM0or?=
 =?utf-8?B?VURERHdpbWh5bmQ1MmJDaEZXcEExNzY0b2kwN3JpaUFtVExTQXNHc09wNzd0?=
 =?utf-8?B?OCtnWDdPNjM3a05ydW1TSC9ZUE9CamdOc2c4dnVaamZhOUEvYUNuM1RJeTU2?=
 =?utf-8?B?Nk5QRnRDbTdqcm5NRk1NM2xxTkpPM1BVaXdValZJeFRwN2tvM2Vuc216OXls?=
 =?utf-8?B?ZmwyZitUNU4zUGRYMTFXYUFIV2dBZUdaRm90UVZZbUxvbitZTGkzZnBUZ1RI?=
 =?utf-8?B?UHcrOGo2YUxlaWRsbzhKV204VjVXQ0pWWlJWNXF0U1NaU2VCd2hUSy94dnVG?=
 =?utf-8?B?NVV1aXQ3UVNEQ01aakp0L2Fka3BLVVpuZXRFcWc1SGIxeXdnZDZQMVBNUHVP?=
 =?utf-8?B?c1ptOEY4dWRHc3VaRFo0UUozclp2NHFJY0lMVEFTSlhxdzZkNGcvZTRUSDV2?=
 =?utf-8?B?RzZnRUdkTGdEeG40ZUdtYkFvMGRQTncwNkFrOEVxOW5pOFRVekwvOEkwQXRx?=
 =?utf-8?B?d0F0WW9pVEVibndPbjlqVmlNdEZOa29kblRxTU1GK3pCQlEyNklrSGlvcWRY?=
 =?utf-8?B?TWZRVnk1T1gxMmNyZ1hDK2Z0ZURaaHhzU0wyai9Bdkdid1VZZU9SQmp4QUVU?=
 =?utf-8?B?cG5Ham5UVjROUFhZMWNIVm4vam1CMG9oKzhkYTQveFVXTHE0VTRMVExwMEFi?=
 =?utf-8?B?cUx2b1ZyeUJSdXpGTFU2NE5obWIxUHlrM1k2bTRaaUpRcmcwUi96N1h4VGVL?=
 =?utf-8?B?UUkvSGRxc2pMTTRlcU9Sb29mellwVzNwKzVDei9YaitELzIrcUoxTnh6UG4y?=
 =?utf-8?B?TkdFMGhiMzlZTkJ2ZnpDRm5XNU0yVXpEWGsvQWE0eDV6dU9EY05pcmRrT2Yv?=
 =?utf-8?B?R0V4RjM2ejZ6Q3V3MTI2UCtRUUl6SUVad2M3YnE1NVI5TG51M1k5S0pLT1JG?=
 =?utf-8?B?TTZwZUVKUFJKVUMrc2ozUVJIVExGdFZ2TlFLaDVpdmpuS1duLzBUTDRwR1Rp?=
 =?utf-8?B?eDVtZWxKZkNTUUZQMFpJVVF1by92VERjMlZicERHeFhqRWdGRGVINldSMmdU?=
 =?utf-8?B?UkI4Z1FuaW9NeVFkUVFWbmM0NnY3T1ozNUhMTWN4NnhoQ2pUT3VtamV2SGVy?=
 =?utf-8?B?bjgvV3RvMWZmaDBFN1doZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c3lPRzJHeDNOUUtMdHdpQWtNN2dwalUrbjY4QTJIYzlwWDIyV3hPZElBTHZx?=
 =?utf-8?B?NjhXcWpDR29LQko3M01ITllEaXpYRWtLbXRHS0hlUmp5OEdKNVJZTkxBSkJs?=
 =?utf-8?B?ME00R1poRnJ2VFVyWEx6UUNxMnROY1V2YjFaZGYyWk90dnpLa3c3QjBvVk8z?=
 =?utf-8?B?REc5dnhWZVQvVm9Ha2dFL3JqN3RLaytpZGlyVlg4UXRNaElkd1VxYVBLTkZV?=
 =?utf-8?B?M3kyWE5TeUZnQzRlZjJiQ1VONzJjZVNwdlZ3VHhNdUVBaDBXUmdwN1cybVV3?=
 =?utf-8?B?RU1tM3dsbkM4enIwMG93a0E3YjlTdWlQTHkzeGgvMjg0bVZleHlJTm1zRnRl?=
 =?utf-8?B?Y0NJdVFPOHM0QVpGenRyQ1VvMHhNcmNiWERRcXl5bUlHVFp1Z3N0SjMvcnk0?=
 =?utf-8?B?VUpWNm95RDBKc3RXRUpZTjJIVC9rTk5NcitJQnQxMWpyejlkeEpoTGgrMnpj?=
 =?utf-8?B?bzc3cndNVCtKWFZ3QkN4UXI1dGoxYVdBTXRrNWRTOE1JYW5oSVpYdFRHMXpt?=
 =?utf-8?B?eG1jYVhjL3pPcDE2V2xxbHpxemEvQk8yZG1QOHVTcXBIRWJtZGJlaFJEemtM?=
 =?utf-8?B?T0VzOGYxd1RKK09VdHJnM093SkpYbTRzQTE1Z1ZqM1RkSFZXUk1tZjY5VXAv?=
 =?utf-8?B?cWYzV0dtMDJsNUNaRVJBd2syd1dFVmtqUFNDMDFOR1dkNVV2elBWS2RrYjJN?=
 =?utf-8?B?c284Q2d6RTdmVDZRYy9vazFIdTBKYkdZdWFnRW1kMTliVEdaZTVaZ25oUCt6?=
 =?utf-8?B?UkozM0gxa3lGbUNmbk5LM1FxR1ZRNCtLUDdYWU0reDFCR3NSc2EwWkNyU3pI?=
 =?utf-8?B?MmZsekVHQTRFYWs0Sk9vQ3lRMXE2eXRZUldrenNPUnJHNVhpalNRT0ZJTW1R?=
 =?utf-8?B?VTJTMDZLMHhyOVhUUi9MMHlBVndBK0ZlMEpxZjNGRmlLSHVUV056d3czYjgv?=
 =?utf-8?B?RWQ2dFJxalg4RnA0NkZaczQveWF5NTladlQvS2NyeG1jTmtYNkxGWUphSWsv?=
 =?utf-8?B?dmtpZnAzOXcrNHM2L0kzNmRlUE1oZEIwdXI0RVBKVnAyejRhNVpISW55bUdE?=
 =?utf-8?B?OTk5dGUzK0w3Z3dtbCtreTRJVUFtUmxlcnN1N3VubWFXTHRqaEI2Q2lNRW1W?=
 =?utf-8?B?S2FyZ3FDYzlwY1FpVFdGblF5Tm4xMHFEekhyNU42bC9lQ3pxWDU2U1IycjI3?=
 =?utf-8?B?ZTZySS9VUi9uYlBFazQ5cWxvdnFyRGQ3MUZqNnhWeDlnUys1OFNUUUgyZXFP?=
 =?utf-8?B?WkI0eHVHMTVjWHNXaHVCMFRheE9uSlp3SlZTSTI0OFplaHNUVXJYVjNhQlVp?=
 =?utf-8?B?VmtHVjQ0eFlGT0FzK3dIK09nc05SaSs1RWVieVIrUi83MHhZbHQ1bHdOYjlx?=
 =?utf-8?B?RXlsc1Y5TG1tMXRsZk0wMFEvelBtVWZhdmNUb3R5Q0g0aENWQ1VKNXRTdmw3?=
 =?utf-8?B?Ym1uOG53Y3NWK1loSkdnVE5uNEZWNUhvSG9oSjl2QmZpbStqbGN2QTB1NnpC?=
 =?utf-8?B?VTdqUTlsempDdTFrS2V2WDEzLzFIMTFNcUpvNVBlUWFNVjRud1NmNVRRWXdp?=
 =?utf-8?B?cjlORktnUTZTS0E4Nmg3RlMxM04rT2RIaG1qNGhSVzNrNytLa0pRZlBLeUR6?=
 =?utf-8?B?Zk04SW9rT3NTRnQ5NHNiM1pmbEZIbGJjZVEySEE3Y3ovRmdNcU96ZW5FcGxW?=
 =?utf-8?B?UURWM0lUY203VDh6Vjc2WnNWenRRaEJqYzBRNTQ5QkxXdDhPQ1k2eVpsbm1M?=
 =?utf-8?B?eStJc3c2aDhVY0I2SGhFaTZoYTVVTUZieTY4bm1haGtBNXpiblhGcUxrcWhx?=
 =?utf-8?B?R2dRdml0MjRpNzdYRWNrMFBTcFpuQkdONTlyOUZLc256bzhMT2dKMjh1TUQ2?=
 =?utf-8?B?WFp3Q0hpcEMzeEVvVisvejBGR3VrL3ZmMHNxVkY0MUdqUUhJNVFJazQ2MEQ3?=
 =?utf-8?B?bkZFTjZ0YUc1b29ON1VORzR3UjNtSDNUdGVWVkFFMVc2SWZxM1Bzczh4WGky?=
 =?utf-8?B?dVZORU9BSmIyS0k2NlNUNDZHbzYyQmtqV3Y2dEVaTGlBZG5pQUZSTUJzcWF3?=
 =?utf-8?B?VHM4YWhYTHkyYURnUGswTWVNTGVUSURVS0s5VndkTHQvT3E3QkFzUTlWeG0y?=
 =?utf-8?B?eU1qVnA5dWJjSVlsM0VIc2ZGL2FQL3NYcjdKcHRuNTVuVTBtWWNJRENTL29L?=
 =?utf-8?Q?uxzLu7lH1/mEbtYS9eGfuMg=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b58b4ac-2e29-4283-a47f-08dce4594748
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 09:45:27.8683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6rMWIXt1FoBhhO/ACfNj0Xcbg85Qxf/0Rt07u1Fvqc/s0xvY/fx0NFiwiiAI9pLPOttjVvs9CO8iujBSQP4Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4222
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <23EC13933F82884A85B9AE5922F19AD8@namprd15.prod.outlook.com>
X-Proofpoint-ORIG-GUID: H6fIsqlOyn_FxxbxcJnCCpMAkwFXoNOu
X-Proofpoint-GUID: H6fIsqlOyn_FxxbxcJnCCpMAkwFXoNOu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_06,2024-10-03_01,2024-09-30_01

On 30/9/24 00:50, Qu Wenruo wrote:
> >=20
> [FALSE ALERTS]
> If the system has a page size larger than 4K, and the fs block size
> matches the page size, test case generic/563 will fail:
>=20
>      --- tests/generic/563.out	2024-04-25 18:13:45.178550333 +0930
>      +++ /home/adam/xfstests-dev/results//generic/563.out.bad	2024-09-30 =
09:09:16.155312379 +0930
>      @@ -3,7 +3,8 @@
>       read is in range
>       write is in range
>       write -> read/write
>      -read is in range
>      +read has value of 8388608
>      +read is NOT in range -33792 .. 33792
>       write is in range
>      ...
>=20
> Both Ext4 and btrfs fail with 64K block size and 64K page size
>=20
> [CAUSE]
> The test case writes the 8MiB file using the default block size xfs_io
> pwrite, which is 4KiB.
>=20
> Since the fs block size is 64K, such 4KiB write is unaligned inside a
> block, causing the fs to read out the full page.
>=20
> Thus the pwrite will cause the fs to read out every page, resulting the
> above 8MiB+ read value.
>=20
> [FIX]
> Fix the test case by using the fs block size to avoid such unaligned
> buffered write.
>=20

I ran generic/563 on a Raspberry Pi running 6.4 and with a 64K page=20
size, and got a similar error:

FSTYP         -- btrfs
PLATFORM      -- Linux/aarch64 fstests-aarch64 6.4.3-arm64-g0ef0e2e48724=20
#61 SMP Tue Aug  6 16:51:45 BST 2024
MKFS_OPTIONS  -- /dev/vdc
MOUNT_OPTIONS -- /dev/vdc /mnt/scratch-dir

generic/563       - output mismatch (see=20
/root/xfstests/results//generic/563.out.bad)
     --- tests/generic/563.out   2024-08-05 10:33:23.000000000 -0000
     +++ /root/xfstests/results//generic/563.out.bad     2024-10-04=20
09:35:51.433413098 -0000
     @@ -3,7 +3,8 @@
      read is in range
      write is in range
      write -> read/write
     -read is in range
     +read has value of 8421376
     +read is NOT in range -33792 .. 33792
      write is in range
     ...
     (Run 'diff -u /root/xfstests/tests/generic/563.out=20
/root/xfstests/results//generic/563.out.bad'  to see the entire diff)
Ran: generic/563
Failures: generic/563
Failed 1 of 1 tests

The same happens whether the btrfs volume has a sector size of 4K or=20
64K, and the patch doesn't seem to fix it.

Mark

