Return-Path: <linux-btrfs+bounces-3082-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 827C1875C57
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 03:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06081F215B2
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 02:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328F52376C;
	Fri,  8 Mar 2024 02:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aY5mxym4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="diAWpMju"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F10291E
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 02:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709864921; cv=fail; b=ZFgX4agoXXSrjnsaf90XWp09TEkhqrBYfg0A8qoqwzjtB4DR/tzSQqu9vBv4Vx7O8+YDtZR26Um+sEngHi+Bp7cdfblKnRg7rYIaY0CeU7DMk9pJhZ1widqJHTz7hSN8rTFQNpmOXgB7sw603G8tTdtHOAcijX+YhRaPWceB2yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709864921; c=relaxed/simple;
	bh=N+/i56kA5SV3Ctk9rwT/IoM0UNU0fZ31+I8XNfeNeLQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UsHSP+pqxv9pBl4oFn1YuH4rYtb0MD4vhcZE1u0DWw+RIH80B2C1pglNFbHo7U2xOS+38VGPAJNdcyFmkSMr3lmgDrJMr5bAWuCUyL4TWvvpuPry9oAQT5Y7UkdUqWsBR3zm8VSkGxri94Gs5pFn8zOoHBkDvplWRsb6006m9VA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aY5mxym4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=diAWpMju; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4281ix0X018327;
	Fri, 8 Mar 2024 02:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9F2vCVp299rd6y9ToRMwLyHhCuM/BhpcHrrVG8QxbGc=;
 b=aY5mxym42v5/y7sqSQXE0Mu3xF84yr1YTpcVAW09L42DtAjJz7Ett2dPWtAPxFXMiYwe
 2m0v5scTRZy8UQ2kOLP7eCWNdiINTlWfI+2mP23S+Lf8SqRMLkd1kCU5rtFK8rfqnBnS
 NpoDzwB2fGSVOAQWNZDzQ+W1FfaIxWvrslJqx4ausNhQrvSCk/tkdvJIzciZoPymIsnp
 EPeN/Nrua/gulo63hxSaomt4jbFx0i+yBC3wXzyMj8/Q0KFLq0FOBjNmgmd9BT2KN4v/
 StVTJz+Mh9EECwOvElFrKWx6T3YT4FjnqmWxf/rYem/HAWOXCZIyXkdQpgmHWrBy+rre 5w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw4dqy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 02:28:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4280FIV6031936;
	Fri, 8 Mar 2024 02:28:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjc4mrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 02:28:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSqep408oDShgJM/npv5qB+FSI9aEklQ0ArsQBy+obxh+ERn+JGLs2gRDmhOPLzAqProVJKoL4jDkpNTHzRsrDOYBGA7LVlzh6+vEsexs9Yu9f8UhTbZKId3LMAKD19NM2PaUp7F6SLxNkda5dX07y4Nipsv/R9oimghxE/AcWNviTf1hTxtKlGqR2wwQjFirRR++ja6DZrcRjai70Vfq+ZUiGpFNNvlt/bpTIVlfG/mVoADIbPHWWZeZcVfrE5n3tedDT8qi7AuZ/BHxobRO4ooDbzH/YMRoJ3ZWg7BdNWty9SoLYM+7/GDE5iCxzDFRTM9slSyxpU/1P7UHplgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F2vCVp299rd6y9ToRMwLyHhCuM/BhpcHrrVG8QxbGc=;
 b=IZkIaoD4HBkkBIk9GdmdRYGmecVKcUkpcllD1dRiInWRZGYzCnmrXmCp3zH7wTX1oSY19lcpoZ494nuYFoGRa40GrnuC51WfYE9JMyp/xLZGmdMnauRGbJqkFefQDbsVi7V0D0Vk9qz9lA2hWO8JccZkb5Y/kHqvnWWfSkDEhIctZGJO9H+TVnIuxgmC49aYFg3vvi9dP5BTzaI3MarFEpbgqzxlLMURSkDhbv+ikztY2+emwcP1F/9uRsUrT9yHXRk4qScst9GsqYfzvN3mLPJa6ZPbigxdv50/y/KwKCK7lLEP3KuRHAtt9k87vZf1+H4Zbei6NnqrH0xB5eLGFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F2vCVp299rd6y9ToRMwLyHhCuM/BhpcHrrVG8QxbGc=;
 b=diAWpMjucTOLa91V3n8fe5Y3PVR/PriqLjjxx4Nhp4dO9fsa098YOZMj+oOK43ntsaAYS+NLg10ct+bx59xkvGYUxCZ+Xj01Mc2jx6l/8zlgNA8xAag5s1BOFqAmw1kPAfR2gtpHPAYsmH3Y+2NLUToNMIB9Oj8AOsQhbSETWNs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6668.namprd10.prod.outlook.com (2603:10b6:806:29a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 02:28:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 02:28:09 +0000
Message-ID: <82b85e61-2f85-4d01-afa3-003f74380573@oracle.com>
Date: Fri, 8 Mar 2024 07:58:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 RFC] btrfs: do not skip re-registration for the mounted
 device
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, fdmanana@kernel.org
Cc: CHECK_1234543212345@protonmail.com, linux-btrfs@vger.kernel.org,
        aromosan@gmail.com
References: <65a11e853a31b18b620f31cbbddf03e277fe3edf.1709809171.git.anand.jain@oracle.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <65a11e853a31b18b620f31cbbddf03e277fe3edf.1709809171.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: 9565da1b-e466-45ca-1d2a-08dc3f1764f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	81hOLX7Zimo/p57W+uf9u2aQg6dvRV0qZfQEZP/g/ylYO8nbDy2Bu4FIA0X5jMuck7JFWSf7+ymy0r0Lz4MotD2TZRXkXRnDAYsYjI3TcvUDbSaD1ZGhpt8c94ipcl90e9TVMpG6w9khVL2gwB79twkH4BwNIyr5vqOvibHbYHJOX2o1f+VC9/1zUahHvO0zMM9jeRJOY/Zrjjl74YRx3Nh2zNd5zV8/mcIib38RA9QDJdR6nCax5Y1VLh8Yo84mN0qB25EFUd+oe1mBqChY/td/kUcbe5/J7AfeeqiGjGMU+TN0qFz3hJ63H+xRSt2GqOKoadvZmtcXQkwY3TnF7u5fl7nB1A3nLu4KyBLltoGvdc6otVDdLi6wabEAuDVte+ELvAg7Jxuq4+IDcOzqpH55/x10/xQ7d9SBA6dxNPdeXfTyXICR4jyg1avOowPbWHWeDNKilREuh1rqlPWHsMOtA8a+upgOf94UBegq3woi3otgiBno4J9lMKXEkhmPupA6LZ1duOs28E8CpXfJkFTbQs7+M+IF0JikPLFnHDWi+Dm1zOlBJJZFcuVLBRZFFQGJWfB9j6yLQ6ThiPAM29VB4UJvv8j200Q33F1J2lvy2PKgiNdGMCLeSazaXMIs
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aURkRndTK0c1LzEwcVVWZ0Q2TCtZNGZGcjZ5aXRxbitRQVpDb1NVaWhLVlQ3?=
 =?utf-8?B?bUVGejlZaThmU3NCdzVjdFdCSFd0UDZVa0loSk40ejY1QkdWZEhVcVhGRlZZ?=
 =?utf-8?B?SmU1NlRYTkxVZlhyUnE4eWl2NTBSSnB5eS94eGpBeTBJanh5NWc3NWhGekdM?=
 =?utf-8?B?clZablVRL2JSTjE0bjNDRHMvSUVoTmt5NXVzK1d6aVFUUkFjUnVnb3lKbUUy?=
 =?utf-8?B?cUZBWVNVaGp6OTFLOGl0SklWTncxVkV3cjM1V04xcTA1bGp2T2pXQXBCTlJQ?=
 =?utf-8?B?THBsVk0rR09SZnpOQmFDUXVnMi9tV2dsNTIwdEdHcnd1WENRZTJmeEJNamdh?=
 =?utf-8?B?YWRHMU5LR203NHJrY25mLzF5aEg0R2w0eEJhYnpIcXBlZTJlQUxCc043ZkR6?=
 =?utf-8?B?M01ndCtMc1BHU05jdGhrTnVNOWtkOGtHNGtCVjFLd3BqeFViaTNuMktBa0JM?=
 =?utf-8?B?TnhhYVFVTkpRQ2tINVRaZENwdXFYSUpqU0JITldNZEZsdm44NkpYRzVNMW55?=
 =?utf-8?B?ZXpvY1k4TU1QVENaa0toeTM4OUZBRzV5RThCa2xBdWhuVmJSNXJOMmpVVWQ0?=
 =?utf-8?B?RW5pS0xKVllFbkI5SzkwN2s4R1NRZU9DQ3h3aVJzemoyZ3JyMGV3bFBsYXpq?=
 =?utf-8?B?b3NINUJ0TCtNZUxvRlBOZ1VtTmNhY2U0ak9YWkpkVERrUkI5UUlMRXBIUWJM?=
 =?utf-8?B?NWtURFRSNHFDMWh5V0RlVmIwTndtVEtCR2ttcVlvU3NWSW9jMjBVSHhDdHla?=
 =?utf-8?B?UGFKeWNTbGRkVTUyWEtsNXNyTWFaakYvMGt3eWpXN3FhcG1tcjV0QzV1N05V?=
 =?utf-8?B?NThMRTBvWWc1SFc0WUp2ekQzYm43c1d4ZzVta2prVUR6eGlnMWJmbzlTWU9o?=
 =?utf-8?B?bENRSjBIWC9oWS9Yd1RYMEM1bTFxSzJvKzE1WHdRSnozWmduUmRuczQxM3RC?=
 =?utf-8?B?aXJhS2JhQVM2SnV1d2gzSy9qcVhhSzZrZnZWWUtQKy84aVhoNmM5L2FvNmJq?=
 =?utf-8?B?dlluZjE5SG03dkhjb3JETVJNMmZ1TEd6ZXZ6dlRjenJkRWNFODVSdDhzMWxF?=
 =?utf-8?B?VHFZeUpVY1MwK1UwRDVPWWZCY2N2cHNiWTJIQVVIM25yTGFnR0Y2YVBmdjFa?=
 =?utf-8?B?RmRnYUdpRFk4ekMxeDgycTBKcEc5eDR4QTRqSC9YK3l4QnUxQnBPdFd5QmlR?=
 =?utf-8?B?KzRmOEw3ZnFSQm82ZHVERTkyYVdPMlVPVWJNelp5VTQvVjdYR29kdWwyWFhX?=
 =?utf-8?B?UDh2UzFYMzNiOTU1UDVNS2cyWHgwVnRoci9Ma1RkQmhTeWtXL1hJcXVVekxs?=
 =?utf-8?B?SVQ3UmhXbDJVQlVMVXpUN2JtdkxRTnQ3VjBOWjB1RXYySjdYMVhSTitpSVR1?=
 =?utf-8?B?N3d0UGI1UTFJbk1NdEZCWHBSdVBYUWNheXFjUEF4VTQzUWs0bjNFSktJV25k?=
 =?utf-8?B?ZGFzam1DNDJKWmVXLzlGNTNrMWVSL0hGQkJCKzZocFMrZ2o5cERLS0M2aEp1?=
 =?utf-8?B?RjFhUTJOd0wraktycEtOZzd4c0xlaVI0K0xYK21KZjltUXZYNUpZNXh1ZGg3?=
 =?utf-8?B?TjE4d2NzNzBadjJtcWd1U2d4UVZhenQzZ0t2ZmIyWThNa0MyeDFnOHZUQWJw?=
 =?utf-8?B?YksrdVVNcFNsdmxuK2RibWRBaEZKc2RlRmhIU0FZU3RqaFpGNDR0RTVGeUlt?=
 =?utf-8?B?M3dmd3BSRXQ2WmRvTnUxTUhBZ3RLOHY4UXRtWkJSZGdUZ0hWbXlmbWs0L2tT?=
 =?utf-8?B?RXU0NGlFMWpaYlp0cDJFeUJkSEcxVHI1aEpiSWwwWUoyQjlISXVzakttSEpL?=
 =?utf-8?B?cmRUQnc2MlcyQk9oN0hIR1ZOUG9FclIwUko3ZlR1MzRXNXpQZ25xbEZibndy?=
 =?utf-8?B?WEtHK2Jtc2ZxQ0VLRkhoSnhOTWR2MDdNT09TTkcvRDJoL2hteksrWC90ZFlm?=
 =?utf-8?B?R3hGYnFFNmM2czJxeHpJYUlwU1NUVU9oNHIvUnA4TWRTVFVzMWhqK2VXQXdZ?=
 =?utf-8?B?UC9SS3dRMFRGVHE0cmZPQy9nN0s2Z1FHR3ZUN3NaODFGczZuN3I1L0t5U1V1?=
 =?utf-8?B?L1F3VnFXTll4WUlIaFZPYVMySDRtWEI5QlRxUGFBMHp1bDVsRlpnTytrRE9S?=
 =?utf-8?Q?PV9z7kzgVUOFPr+UVUtLHgx7I?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WJkRkj+xIKVp841/Ju0CcMKgn7fcfjCVBbObI+7HM1RPVU4CZBm9Ao1RhGAH666bsk6GgPNqz4WgHrZhLRQ5xFz0VIzK0BY2mBLYx7doFrmEdpRY54NQfoxlOz/5+ou8fYJBGX0gp0xAn9Y+//Reku7OzV4otSKBuTxNdiwMwCLNd2a6+AD5oszah6/PnJPzDEElScuHJbn0wiIt++xH8UveOBkFZtMxeUDcVWyhAv//TW4FRAIhHEjdmfAqoi5WT5S9xF9IhZhRdMHHNC1xA0VQw/fWuvXqemIG2XUjBMx1HYIuN9WoAxOO/5vbqwWLGqGOosuq4pNfKa974uQGtIaH5BB2cmkvoBXA0WCBcvSW6cjVe80KPPcvAlrk/AmkHJ18XJLEu8s16wZ1LjwbmXqHYrzNylWQsi3crAjnLGtABc8MHPV30JMkXfJT5ITTKZTpDwMu3N8iYhfk3f+igyj0FLDI0ykwVp8h8vKMQFt6uarrCYRyKBuhVCeAYWODf8/oV/9aYbXNiW8Jt2kQK6uoshznelA4qYWSLfkoo6re6PTtACfjJAPEpgUXxplhEBmGTG8xa7XD/gvxGIEZgej9Mk5u187S+gSFNr559Sw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9565da1b-e466-45ca-1d2a-08dc3f1764f2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 02:28:09.3169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqta7/V31xmzCYgO4SiAxw/7lXawrktqyee4MtWRX+0PesAEN+g+NgixNkOduCtn8jhMYKjHKO2Lnfq4zIBaXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_01,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080019
X-Proofpoint-ORIG-GUID: OGDaIIOFgFN9ubBCk5qnUtfik68ovzzo
X-Proofpoint-GUID: OGDaIIOFgFN9ubBCk5qnUtfik68ovzzo

Filipe,

We've received confirmation from the user that the original update-grub
issue has been fixed. Additionally, your reported issue using
'./check btrfs/14[6-9] btrfs/15[8-9]' has been resolved.

However, reproducing the bug has been inconsistent on my systems.
If you could try checking that as well, it would be appreciated.

David,

If everything is good with v4, would you like v5 with the RFC
removed and "CC: stable@vger.kernel.org # 6.7+" added? Or if
it could be done during integration? I'm fine either way.

Thanks,
Anand

On 3/7/24 16:38, Anand Jain wrote:
> There are reports that since version 6.7 update-grub fails to find the
> device of the root on systems without initrd and on a single device.
> 
> This looks like the device name changed in the output of
> /proc/self/mountinfo:
> 
> 6.5-rc5 working
> 
>    18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...
> 
> 6.7 not working:
> 
>    17 1 0:15 / / rw,noatime - btrfs /dev/root ...
> 
> and "update-grub" shows this error:
> 
>    /usr/sbin/grub-probe: error: cannot find a device for / (is /dev mounted?)
> 
> This looks like it's related to the device name, but grub-probe
> recognizes the "/dev/root" path and tries to find the underlying device.
> However there's a special case for some filesystems, for btrfs in
> particular.
> 
> The generic root device detection heuristic is not done and it all
> relies on reading the device infos by a btrfs specific ioctl. This ioctl
> returns the device name as it was saved at the time of device scan (in
> this case it's /dev/root).
> 
> The change in 6.7 for temp_fsid to allow several single device
> filesystem to exist with the same fsid (and transparently generate a new
> UUID at mount time) was to skip caching/registering such devices.
> 
> This also skipped mounted device. One step of scanning is to check if
> the device name hasn't changed, and if yes then update the cached value.
> 
> This broke the grub-probe as it always read the device /dev/root and
> couldn't find it in the system. A temporary workaround is to create a
> symlink but this does not survive reboot.
> 
> The right fix is to allow updating the device path of a mounted
> filesystem even if this is a single device one.
> 
> In the fix, check if the device's major:minor number matches with the
> cached device. If they do, then we can allow the scan to happen so that
> device_list_add() can take care of updating the device path. The file
> descriptor remains unchanged.
> 
> This does not affect the temp_fsid feature, the UUID of the mounted
> filesystem remains the same and the matching is based on device major:minor
> which is unique per mounted filesystem.
> 
> This covers the path when the device (that exists for all mounted
> devices) name changes, updating /dev/root to /dev/sdx. Any other single
> device with filesystem and is not mounted is still skipped.
> 
> Note that if a system is booted and initial mount is done on the
> /dev/root device, this will be the cached name of the device. Only after
> the command "btrfs device scan" it will change as it triggers the
> rename.
> 
> The fix was verified by users whose systems were affected.
> 
> Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single device filesystem")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218353
> Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com/
> Tested-by: Alex Romosan <aromosan@gmail.com>
> Tested-by: CHECK_1234543212345@protonmail.com
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v4:
> I removed CC: stable@vger.kernel.org # 6.7+ as this is still in the RFC stage.
> I need this patch verified by the bug filer.
> Use devt from bdev->bd_dev
> Rebased on mainline kernel.org master branch
> 
> v3:
> https://lore.kernel.org/linux-btrfs/e2add8d54fbbd813305ba014c11d21d297ad87d0.1709782041.git.anand.jain@oracle.com/T/#u
> 
>   fs/btrfs/volumes.c | 57 ++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index d67785be2c77..75bfef1b973b 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1301,6 +1301,47 @@ int btrfs_forget_devices(dev_t devt)
>   	return ret;
>   }
>   
> +static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
> +				    const char *path, dev_t devt,
> +				    bool mount_arg_dev)
> +{
> +	struct btrfs_fs_devices *fs_devices;
> +
> +	/*
> +	 * Do not skip device registration for mounted devices with matching
> +	 * maj:min but different paths. Booting without initrd relies on
> +	 * /dev/root initially, later replaced with the actual root device.
> +	 * A successful scan ensures update-grub selects the correct device.
> +	 */
> +	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
> +		struct btrfs_device *device;
> +
> +		mutex_lock(&fs_devices->device_list_mutex);
> +
> +		if (!fs_devices->opened) {
> +			mutex_unlock(&fs_devices->device_list_mutex);
> +			continue;
> +		}
> +
> +		list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +			if ((device->devt == devt) &&
> +			    strcmp(device->name->str, path)) {
> +				mutex_unlock(&fs_devices->device_list_mutex);
> +
> +				/* Do not skip registration */
> +				return false;
> +			}
> +		}
> +		mutex_unlock(&fs_devices->device_list_mutex);
> +	}
> +
> +	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
> +	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
> +		return true;
> +
> +	return false;
> +}
> +
>   /*
>    * Look for a btrfs signature on a device. This may be called out of the mount path
>    * and we are not allowed to call set_blocksize during the scan. The superblock
> @@ -1357,18 +1398,14 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>   		goto error_bdev_put;
>   	}
>   
> -	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
> -	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
> -		dev_t devt;
> +	if (btrfs_skip_registration(disk_super, path, bdev_handle->bdev->bd_dev,
> +				    mount_arg_dev)) {
> +		pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
> +			  path, MAJOR(bdev_handle->bdev->bd_dev),
> +			  MINOR(bdev_handle->bdev->bd_dev));
>   
> -		ret = lookup_bdev(path, &devt);
> -		if (ret)
> -			btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
> -				   path, ret);
> -		else
> -			btrfs_free_stale_devices(devt, NULL);
> +		btrfs_free_stale_devices(bdev_handle->bdev->bd_dev, NULL);
>   
> -		pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
>   		device = NULL;
>   		goto free_disk_super;
>   	}


