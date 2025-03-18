Return-Path: <linux-btrfs+bounces-12368-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF23A66F50
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 10:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B36421341
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 09:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FDC205AD1;
	Tue, 18 Mar 2025 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WqEjMXUL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JzIpAE65"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD236372;
	Tue, 18 Mar 2025 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742288936; cv=fail; b=MxsI2/r8P9hgXuYieLzroPNTuI/o8wPvD1qcTaWE1j1QBpPmarlpO5XtneoY88H/lTm2cku5uQ3cUTHC5fmcXT8fje/bHbSmL35o01FL3D6y101bIOLVc5ihl6FscavFDdRLirwusaLG6d5H4fVuzD4P/rivYX304gVpxVDzTc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742288936; c=relaxed/simple;
	bh=S9+TwXb+L6AC1VtIfKvS+CEe2Jdlm63r0KAc7K8BHSA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XNuMLPYGK0YAJGYGSJ55mxl4iEPWqGC/7fNAaIIB42xYLcet3sqr2+iahmtVn7oJym/L9qmmc1xxbPglKwZ5iNQIJ7hkrjcWMWAK21mWD24whrXiy5N0pcUYqjt4Yo1HNT9W18+2o/neV08PEkWm3nL0wwMp9Onn5jOdgtlFL+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WqEjMXUL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JzIpAE65; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I7tmgm004652;
	Tue, 18 Mar 2025 09:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XcyXFOp7LpklrmtUHRU3/arCtGI8LL8mHsdy9EFBgXI=; b=
	WqEjMXULiRJA4BNgOWfkKLVI4lsCQLyMtjsxcJHQ46QdcIL4axWRF8tn2/IqsiY0
	YgLAo+UrJOLlVOBW00muK0YNbwe6TN0BRT3E5XreMgpFCNF8fkghM38Yz3QikG8v
	gTG30NtJ00leHkdbEdTZGsxQ6xlWUdti98I88g3tVSshqaHt79//vqJRSJfzn+tG
	qTfnm9U/PK4X5/sP/YN/QIokM40DeuCc+sFE5cKdJQgeOORe5xFVF3uoCOXtZpft
	6JkoMW+50PerSYnxWmHX2aBuKiEk0ORE8uO2e8ZIBAXTrnughpra79A6WK2akbIM
	Vfm2iRPdYwNe5LBT/VIy6A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m3mp22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 09:08:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52I8t57M024412;
	Tue, 18 Mar 2025 09:08:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxbh3f9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 09:08:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1qTYH8R3onghfM/4nA3PNGr/33RmqGoe2JuTeTu0udUcgvLtofnPVEL56gffaczmbDDidl/fq5txpl3Y/TD3WjZLM79Dgs18opvPxe+4DIQ/f/rsDYw6108rKfVw2/QozZR+/2f4JL5hqtN8GewQqSG3w4xEBmmB3+Zp1XMETMe2tq6ifiJrgPClLr4BqHf/kYr9fWLIOs7tAHWV2jiv6b0MxhtEXsCVio6m7jk2jm2y55iXSQ8qimPQwmrpnU7LGWdxTZLICpUqLVE+CKt5xslNDyCBRlX68ussEiRxhZIfYmhsYK6gFNGpJoFZ5REic6e2Cks7ZtkcGFWrFRGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcyXFOp7LpklrmtUHRU3/arCtGI8LL8mHsdy9EFBgXI=;
 b=Hh8pNhyxCX0O4dBniBlRi8nFoRmHbGHHZzHwdhAl1LNMzEKy8N7/+xfF8vptFDRCw5gy7LRJeciyvATQANDccaLOiW/0C0BJ4KjVakPqbRFDbdxf6ncGrJfcyKNUQBQyildlZqe+gev6O8K2elPwN0jpnD3Wrsg9hUKqo6pFFGfIZQEOUxmXcCBM/YwE7iaiH5HRoXflD4f4fmHGqO8uEb4vAOpbGhXav1r3sJ1BBVldzJGKwaVZBXUrLMHRtCbh8X1+ByLjTrdWgCN0Zsz+P8vBMReJhfPwRnquffHm9CM0nFwUviw9zEadrLIXG3tFER35Xt7a/cSjC4zsKJKwkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcyXFOp7LpklrmtUHRU3/arCtGI8LL8mHsdy9EFBgXI=;
 b=JzIpAE65ILZBhorWA3D9bb8B6OuT/mT8EcqJj2oDCxPJKCpVb90LiM13nPtS1gWPUcnMWy6AALJQbTygQjiS08AwXRd3VxYFveTXUWThNOT0tcJh58GpPmeETrKsjKOZojBfZIRQpFwPfu1qcMeg6JeaoW/n6IFiiBk9vtNYjUU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6605.namprd10.prod.outlook.com (2603:10b6:303:229::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 09:08:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 09:08:47 +0000
Message-ID: <016ce442-fa58-4245-a6fa-58b8aae2ef2d@oracle.com>
Date: Tue, 18 Mar 2025 17:08:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs: zoned: verify RAID conversion with write
 pointer mismatch
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Zorro Lang <zlang@redhat.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>
References: <5c6dcd33d98c4d79630748381b2aa3880fd156ac.1742223870.git.jth@kernel.org>
 <a50388a1-3d10-484d-a5bf-762423d13ee4@oracle.com>
 <27697fa2-8a44-47d6-835e-eafa4bd8242f@wdc.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <27697fa2-8a44-47d6-835e-eafa4bd8242f@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 71efa653-d128-4b34-6e4f-08dd65fc7d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MU9maWFobGZuYkV6aGUzSXI0N1FuYnNJK0xhZkJIbGcrTld1K2JCS29DMXUr?=
 =?utf-8?B?U0FHVE8xOEJVd2dJTWRBRlZUSkE4VGEvK3l6OGFSRkM5ZXRFZXJrM0RhRmk0?=
 =?utf-8?B?VS8vY0NmSkYzOVNaelRGeldldVUvL2VwdGhERGRpZmNmWUVOYkNEQ0h5Vzdv?=
 =?utf-8?B?VnVqN1lUVUtSUXRrRS9lcEs2QnJqbVRpMkNIRWNocWxtcDBGa3JwbWppOFJN?=
 =?utf-8?B?N0hhWEhjT3B6YmN0YTVLdkRLZXdVRG5yQW8ydmYyZTlKUGU5ZTF0TVpUZW5Y?=
 =?utf-8?B?K2VwMEZ2SmlQWldkR2Z3NDZ5dG9SVFlBU0xxdkxMalpFNllwaVpKN1RmdTFN?=
 =?utf-8?B?dTJITmdtTVBjQVJwY0gzYWU3UUJtT1J1NGMyMlRtK2pGTTVuQnV5ZjNreEVh?=
 =?utf-8?B?aTRHWHBSNXR0WjBWN2tFWTRiUjBVWXlHM1NEZHVQTVRHK3pCVnl3YWIzbGQw?=
 =?utf-8?B?UkFSYWVhOHJITENkVkl2Q25tYWZtZkJ3MjBaYTlnOEVOSlNsSDQveHJWT2Jy?=
 =?utf-8?B?aThPdUwwZVdyTVdxSnExUXJ3NFM4R1RDeDBtRFAzN1JVTlplVWNmZ0QyM2My?=
 =?utf-8?B?WVBzeVhiTlJKdWdMNFZEdmpGZXVYditFMnQ4ZnRMcXlHOUxKNEZjb0dVM2da?=
 =?utf-8?B?a3UyRlhjYVJ6TjFOaTlrelVPNjhIVm9QNUIxV1Iza1hMU3VvWm5TM2dMb0Vo?=
 =?utf-8?B?RWJWZzFZS3FVa0Q0eVJvd3l5NDVpRE13VUdoNjVFZHg4UXVrNWNoa3lGR0h4?=
 =?utf-8?B?TFIxNnZDdWdEZndpRk5ZTDJxcHJhR3E3Z2dKVWY3aG5RTzhCdU5MczM1cm82?=
 =?utf-8?B?Q0tUY1lSNjRlN0Z2V2RCVlFxVnJ0QmtWZGVIT2xYdEluUWlpRXhkeERRM2hw?=
 =?utf-8?B?NjN1c2E2TmdoVklNcEo0d3ZNQzkrNys3SitCVjBDblZ6WDJmbVE1bkR4a3U3?=
 =?utf-8?B?SFRNZ05QTitJSlVPMlI5REpDU3NqR05qbmM3b0hkUlVsYkYvc0MzdmNhSi9Q?=
 =?utf-8?B?MGJ6SkszSWlNZjJxdk16Q2liZk1VdllIVkp1cEdhWEpOTUJ6S1F3d1MwbktN?=
 =?utf-8?B?MGtXaVF4V2VBL0txM2RuZUZ6WWRWVG0rYzZubTl0VG02b3pPc09jbG95RDFp?=
 =?utf-8?B?OVR5T0NCaHZPNXRSa2gwZlhmOGZ3SlIvSzRtMTNJM3NLRmhpelBxN3JsUzB4?=
 =?utf-8?B?RVRoL01GWklhTzd4dUc4bGl4Y0FsY0hJb0ZwQksvK0Y1c1JTZE5BZmJyQ3ZJ?=
 =?utf-8?B?dzh1UzVpdmRUcjYrUHpSWXQ3Umx2TXBpZ2xXOUJVemxNcEt4V0NWdGFvYjhJ?=
 =?utf-8?B?c2oza09kbWZ0YUZqRTY1ckkxWW1Fb0dGVjRVbEQ1VWpWN2xtamkvZFJpMDdV?=
 =?utf-8?B?QStEQjIyQml0V05Za280Q3ZUVlhmbWJzZFc2MHl2Nlo0YkpwU2hrS0lxTGIw?=
 =?utf-8?B?NHhiMmo1YzRPRkJaeHQ0U3RHUGxIUXEva3JITFJoZzZhaW9FRkljdnBrSnFB?=
 =?utf-8?B?UVcrNTJMa01jUGQ3N2JiSHlkNVFvTGZBRXBvRTlwYVBBUTBCaFMrVUxCaDNK?=
 =?utf-8?B?dUNKY1ZlakJqdTJRamVwakpHVkhEdEdaNHlYMWM1TFU0b0k4K1llR1VoN3Jw?=
 =?utf-8?B?THY2Qk5lL1M1V2hDSTZZLzhEYTFlUGpubUpXbSs2blc0WVk5c2ErTDlrZXEv?=
 =?utf-8?B?NVBDWS9nSmRMZ2ErVEswc0xDUnJGQXZXcEYycFR2elpnaWhrejJvVjVtQ2tu?=
 =?utf-8?B?V1dBUTJTYTM0UGwwaUN4ZHZMOHJUaXJxMnh6UnVlT3V4enpjVFhFci9BMi9O?=
 =?utf-8?B?K1hNTnExOXhtUEtpbUxxQmw1cUlVZUhySnVWdytzOVRnSDBMLzVqOG9pcVBw?=
 =?utf-8?Q?wyke1dU3LawaU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjFhdzVwRk9TTzhUc0tVWm5jQk1YanBDekFPaS9zU3RVN2FEdWkwemNPMUkx?=
 =?utf-8?B?eC8xbEJxa2JWb3pITTJjcmpKS1JwQ2ZxbEZyOTdhR0t4cmpPajZrWExGUWlC?=
 =?utf-8?B?NTNycW1lY0h1TXN0OGxaa1JVOHZNaVA4YUlmTmVwdXFiYnJ5SW9zK3ZwWHRK?=
 =?utf-8?B?ZUdFd2tlVUV6a0dRYTd3VmZ2ai9pakhqTnI0TTVNTlhHUlRMdVZjZVpzQm56?=
 =?utf-8?B?ZjBVTktjOFNqNXdUdndTS1lSM1VSd3JWRm9paEpFUWdrM1VIK0d3aEtoUlh5?=
 =?utf-8?B?aWFlZkFCVnVzZXlyekRLK215dUtTS3BCYWlFUzBqcU1uS2xSQ25kMWxpVlNM?=
 =?utf-8?B?UHEwRHRNUmg2K0JRbmlEUDFTVzJhcmEyZFBTeDQxQ2xrTjVHL2RqNVVzYkxO?=
 =?utf-8?B?OHd0TkhNSDNrcFpCd3pYYytuaW04emg4VmVtT2hJZGM2eFBDbW0xbWwvVDdi?=
 =?utf-8?B?T2Z0bzFQVUFUZEpsMkRyd1g2N0Rac0pmbFZFYlZKTXlweFJja01zblhaSHpH?=
 =?utf-8?B?dzdJMEhsZFhEWWlVb2Z0Z0tXajhLOVRjSVRHQTg4ajY4YVhvM3FYVGVDb2V3?=
 =?utf-8?B?ajZZQ3dIT0QzWlUwY3YveUo5QTcrQWlhbForWHRtWkpyemJxbG40aWRESUlw?=
 =?utf-8?B?a2p0MlhaemN1c1UxR1ZESDRSREFBTDZ0ZFMzbDdUcWVEVjh2djE1WHdwaFBL?=
 =?utf-8?B?a3ZxMUEyUXhpSUFNZ3lCcVJNWkxqU09SQVpINzJPd0FsN092VGJZaTc3WHl0?=
 =?utf-8?B?c2hDWVBqZ2lsWVVIR3ZXeDVSRmRDclZZY3BERkNsdk4vaUFhYnlITHpSWUlB?=
 =?utf-8?B?aVNuQ2ZRNklCdmlqdy9GamhTcEZMMXlGdDlIenQzS1ZqOHQ0RXk0bVJ1MlVO?=
 =?utf-8?B?SERwS0N5OHhyZWdDR0NRODdyaFgxTFk3U3RIZkdhRXdxRC9STjViODdMS2Rr?=
 =?utf-8?B?V1BGVjdhRjFscElWNVJDeFM5SUhRQWFYSlFNMEs4UlI1b2pmQnYxNmhHVHgw?=
 =?utf-8?B?d1RUV1VQbTdpUHo2YmxUeFQvOE1FSnZPbnZsdTh2NVBvNWQxMGkwcUVNWDFH?=
 =?utf-8?B?OGlIUzM2RnNCRWRSVk9NaERkNXM2RStnNTdSVVVHRGNxN2p5aGwxam1VS1JQ?=
 =?utf-8?B?RmN3b0p0U2hDSkpMVlc5enNvOGdydi9YRzloWFVxY2NCVmxrOG8zbkVkU3J2?=
 =?utf-8?B?Zi9EY3MvYmt2eE40SFF3N2hTdVFnK0tKVW5kRWJ6clF0UkwyOVFYUExpZk9w?=
 =?utf-8?B?dm04UGlQMnNOUXFqRGhibUg0Vkt2OWJBWkUzQjVBSWJVV25NbHBCbmFTSVNZ?=
 =?utf-8?B?MEY5YnFLQVUvWTlEMDhub21MR3poRnlRcXRaL3NWTVBqWnVjK04vK2ZjSWxC?=
 =?utf-8?B?RVJkbnV2dUh6RW5XS0FFZSs5K2NQVnhTQy9MNkFneVQyY21QRkJNMTA0THZP?=
 =?utf-8?B?S1dDdUVRTWFKeHNyMnk5VlBIRWpBN04xbWZlYUZiN1RKa1k5N1p2STA3b05G?=
 =?utf-8?B?N1NxWi9SZWgyTHc2WEF1UER3eDJ6MEVNbGtOdkZyYllOdklrVEovOFlYRkRx?=
 =?utf-8?B?S2ljMTJvQXVPeUF5dVJTdVpCZFNFTE9vUjFDZEhsQkc0UmxmMk80bzRUSXJo?=
 =?utf-8?B?dlhsZVAyUGxTNHRkcm5ZRTdBUWtsQVFrY3pHSS9UenJhMndkMHB0ZHdGZW9o?=
 =?utf-8?B?bFhFQ0ROdFdpZ2Y4RGthT2Ridm1IQSs5ZjU1VFBTNFhIWWFEN1d2Y3BzUzh5?=
 =?utf-8?B?eEtIRE5yNFl3UUpxOGdOTGgydFVtc2xOTkdzRUZKTnpwNzBuckVmSXY1RE5U?=
 =?utf-8?B?UU5oN0V3SlM5RzZXdDdUbllqYmoyc3RvaiszSkdsWmRTMUpHYTN2UnQvL0lB?=
 =?utf-8?B?c2R4RDFNa1B6dllmWDFoL1o0bi83YXR1QlZFODFQN2NqRTRjcTFQNlFnTktF?=
 =?utf-8?B?elRiYzl5a0Jpa2FUU0o2bFFpVmRBd3g4UEtpNnVqYllCa0xraG9LMFZjQVpa?=
 =?utf-8?B?RExZQ2FFbEFYY2Z5dHFWajdlUDhqRkh5eWVmSk4zLzUzeDJMRisvcUFWcDl1?=
 =?utf-8?B?aEVXNWZLVXBJN2NyenNZNW1Ra3U0MVdTMFBnd2ZLYnVTRUxqNzVkeFNuak5K?=
 =?utf-8?Q?WCZ60GEdkXAHPwNhIn8mmuHRQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C/xyA4TLuTuB/qRqZwUOfUKwD4BbM+8SWCkBcct9t6YCJrOG4ifhpfdlTPTzwmxNySHYUAUZOLqQnnT4FVTk24qNlwPvGwk/EX+Xt07LpWi/QkBHtzE3pRQE+MWGWHXah4GF0jARvTvLR5if6b7idthm2ccvdWH6VXePl/YPpAl7iBAHXY913id7O2yOr6zj8dev8dl3YL7N1sQUGN+Y21BuEoWnKeyXrl0lNbYcJ8vl9iqqE9te1IGag9rBBjeaYYXkQZZud6OaMtPgozXRgXOE9JNRdbTuTlnqQm/z5oRNGPsAp5WCznDfpkC1qQx96pR0714KbnB7ekN1C7ILWSkyV4tpbmb/jTKHp85h/iX1OCy02cXKEz2s6nM0wzEG96lDgKkfz0voL7MbfTtzpC9rSNXokak3lZHSCziWMAi+fY1Bb7r6zLi4AgGCH2YeTZUKe/eh8F2gk/D3Wloa9p11N/HNmmVFHhsWhuooh/kw9kTMZcalvRn+7yxNhD0SELQ4Cl2LxXyxQYm5znLnsZJw8tQml3+yXncqh7LRBG14hklkDqmfrvsiSEJe+wkwuAOOt5Hn+mESLi27K/vG2XyR8mrS2wDR6AiJkLnZ1X4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71efa653-d128-4b34-6e4f-08dd65fc7d92
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 09:08:47.2457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sakJG2+uDtKMJtKAm1fax1zh1grr3LGkl9Z1nahqCrhcXM89uUkPJn8BmuAyHIkg4uAN12FJT9zRoyLxdMnRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6605
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_04,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503180065
X-Proofpoint-ORIG-GUID: i3OcY_d-og7ZopfK-mHZSYQsZQ1kEoux
X-Proofpoint-GUID: i3OcY_d-og7ZopfK-mHZSYQsZQ1kEoux



On 18/3/25 16:37, Johannes Thumshirn wrote:
> On 18.03.25 09:35, Anand Jain wrote:
>> On 17/3/25 23:04, Johannes Thumshirn wrote:
>>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> Recently we had a bug report about a kernel crash that happened when the
>>> user was converting a filesystem to use RAID1 for metadata, but for some
>>> reason the device's write pointers got out of sync.
>>>
>>> Test this scenario by manually injecting de-synchronized write pointer
>>> positions and then running conversion to a metadata RAID1 filesystem.
>>>
>>> In the testcase also repair the broken filesystem and check if both system
>>> and metadata block groups are back to the default 'DUP' profile
>>> afterwards.
>>>
>>> Link: https://lore.kernel.org/linux-btrfs/CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com/
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>
>>
>> looks good.
>>
>>       Reviewed-by: Anand Jain <anand.jain@oracle.com>
>>
>> added to for-next.
> 
> Thanks, but the kernel fix for this isn't merged yet. So running this
> testcase will crash kernel's with zoned btrfs.

Hm. Yes, is that why this test case isn't in auto? You think that’s not 
enough?

