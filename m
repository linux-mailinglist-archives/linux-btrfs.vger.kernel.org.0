Return-Path: <linux-btrfs+bounces-2269-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A06784F13B
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 09:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B21A287BFC
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 08:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4955E65BB5;
	Fri,  9 Feb 2024 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o3XtKwL6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KQVSbbaN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39465846D
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707466297; cv=fail; b=f/HJ0q49SmI5Z/wVLyTl0UZsSSpqQUmCIgoN+PNETtWSZq2E4CcVl+UIYl1yAwbul4MYNEeIvprbEAhD0UsNaLUL6ntDEeZM0Z9OOo+ixWopWXhFvjUwpZZTH0GST1MN/SSX8iEt0590k8fkgBdTlsfaGxXGNLGWDjGZMrp27dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707466297; c=relaxed/simple;
	bh=m6vLwNbmzmO7jS22m3fCQT/fyNQIaXFVZ69rELwPhOc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tear6gtQVM7oYbheEy38oZokZM+S0W80GAXDwvzGrf1QsJYt/R3WfaboPSmlPBPrjBLSMQyf2mqyTqHPYuBOhGZWlWx26qudLOku9ObIFo1uuIfhLqKO12ZcI0YWsP6w9UkQS+67mmAVxMJxq3Pv6E4mHXcHQ5o40c6z9IRY4fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o3XtKwL6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KQVSbbaN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4194xJHx005638;
	Fri, 9 Feb 2024 08:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2f7yM6Ctzhw+tNIcrQcEchQSfTLiCO8Y32/zxYSzILo=;
 b=o3XtKwL61hx1nejMvEQtfne147nvJXZFzCLF9UigGsBAL/L92fKGV+F7oKd3ZbisQ6mX
 C05sQQ6muvHOrUM/ROT/ebchne/I16XFw5ZeNMXK0JCDB5JqiB8Kt/ymE0ueBCN3rybY
 K4BD1sT919kvX9wKGGUJt2gjqfk8e4TYtZwGHLPGRhGEMqjaBt1dLULxJp3N2x/nyzMx
 4APEG9McDBSepiEm+WA2LeOBK1LixqcroDILmeYZGyS/vnLeZDB5gFCY6d0CTVQ3mQfq
 BnUUQ97TDOTuUuBdVDFVxGW8g+rU7nplPhRsJL8zqXyUKmgYTSAfPl6NZGd0DwuTV/LO Ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1e1vequ7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 08:11:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41971un8038306;
	Fri, 9 Feb 2024 08:11:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxbtm2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 08:11:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTZunSt+SSOFL6oDXHHRkyP3iFTrPSR/I2d2/SMU2Phq2a+Q/cm1pbdJmEj6vA1+t7pCZSOpwyJPUpAz99MIhteQTwEUvfxBQJ6P8S7dt6yq2A5g+nwilWa4vUaGGJ0euFg1v+7LYp3fuS7uTWyEPR6omjfcmrfMmVc6dAiEE9Rvq3q7D5bJTNLLJ+1MnVoz+1J2KS1veT94gLz0dXwXJbUSB6MUxloZNALTUzImykga5dQKzzwpkMhWknIimj7ML0FF7WHI9yZkeBzEIAwu97JQM34oIeULlQyXZvIovSJ5ZX9XoIm0N5pMPo3amOAm1Oec/hZ4uiLfDVRkEU8DFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2f7yM6Ctzhw+tNIcrQcEchQSfTLiCO8Y32/zxYSzILo=;
 b=UBV2Tr/au1R3qfD6AyT1u9f/nKnwvBomWKH1q+5k8fUeZM7WY6QFswxu/1I2S3372DjCfGG2uxQOFRrmpyBLJYmKWP/vJ7xfnQzcLgkeiaQBrkhGrS/sl5Lgc3DnQUrC4EmtWNUBWfUxfSZK5+M6XnQk9HqCoFvlGWuG/FesN6BFlEyzkBLLK3zo+Xo6jVVWthPHtcAbm8J77vAz4pcjgCxqhia+MDMxYd8lSn4tQW46lkI1iA29xTMaRMRXqYSE8gw/FNxjs8C+sGcDFzJceQk884MLAspuhPvHpY/TU4VreiKS11LWa1/w6cyArtYLsGB+QHHkMd/AHNIW50f5/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2f7yM6Ctzhw+tNIcrQcEchQSfTLiCO8Y32/zxYSzILo=;
 b=KQVSbbaNzKplYJ6Wg5X45TJji+x3eLSMkgZ/ilwBwP5VmC+EIFUFRpX3QqE0t832LGVKtFCnXLsQxErhh5QJikuo5he/6fAivwKeYJZAlhePvwCVZSqGacS0WhfkUAM8qRY5SUjoouO3LP/eUIT9ExzE6uIiZ6/U+/YVVO2Zp64=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB5915.namprd10.prod.outlook.com (2603:10b6:930:2d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Fri, 9 Feb
 2024 08:11:21 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7249.035; Fri, 9 Feb 2024
 08:11:21 +0000
Message-ID: <eadf2480-950f-4e32-bc33-bef8e0093f9f@oracle.com>
Date: Fri, 9 Feb 2024 13:41:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: do not skip re-registration for the mounted device
Content-Language: en-US
To: Alex Romosan <aromosan@gmail.com>
Cc: bernd.feige@gmx.net, dsterba@suse.cz, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <8dd1990114aabb775d4631969f1beabeadaac5b7.1707132247.git.anand.jain@oracle.com>
 <20240205125704.GD355@twin.jikos.cz>
 <e718b759-e597-440f-9fd0-351686bd6b5e@oracle.com>
 <8c326f81-e351-4e71-b724-872701f015ff@oracle.com>
 <CAKLYge+9ngrW-1EffUhyU1y13MzgP33osNDi3D6y6UVW6poJZA@mail.gmail.com>
 <55c879b6-5e6b-4602-b558-e52540b67bda@oracle.com>
 <CAKLYgeJCqu_9aCO+s74rcFh5R6EdLeNwe43MhRmjQ=soFX-rcQ@mail.gmail.com>
 <bb7f33ba-5c8f-4b07-8d79-d0d191ce1fcf@oracle.com>
 <CAKLYgeKjvkkRM3D8ZDF5=o6j2hw5qrCzhufisnb0Gw-rvj12zA@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAKLYgeKjvkkRM3D8ZDF5=o6j2hw5qrCzhufisnb0Gw-rvj12zA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 35918acf-e9f4-4932-52dd-08dc2946b332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bctKC8pWRfM/vf3EhpzHSgutuo4/pTN80o4T0VOg6EB+zEFRcCfXL4sZZBuBujXrF6mqojaMMNj4dtDUpq5SOwuH1tRQoOAoczWv3+KBb7XUIID3CbD8s5h6VwgjDO8GuhjGvSnYPYPSaOnYjI72XSJmDbYrt6pfs3zN1ftKhvFm90dFAUWlONKt7iUy2GIayx9dfjZ+j4CVcqruoAJ/tcMLmpj2sBXyreXAanDT0VxUIvCFaCbSfDcBLfvaR2QPs3GXkuPvNjlNw7Eo2rNb5neR0gmT0Bpk9mWAM2A8JjD+y+yVDr3sm0KuVhtfO2dl1+hcGPXFB8rjCv3GJKNR60c98vvikbJTNzeocDWcT2yBgHvo9ZL0YaaUHkCSzB0jNtD0oHqZeDJiFop059KrsIl47Q7lPlFVPVYaIv6PevPyRXnPXIDwxYluAr+pqBvwVw9OVVNklM05jClxB22tyvlXprka5cmuGjiWexsoffpFWcczmLraD7dumAZZmRaXGWy/PMvcvED8v/+X8yxsDdjeuOWInmFPsLE/D+ZX0eI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(8936002)(44832011)(8676002)(4326008)(31686004)(41300700001)(38100700002)(36756003)(86362001)(5660300002)(2616005)(2906002)(6916009)(66946007)(66476007)(316002)(31696002)(966005)(6512007)(6486002)(478600001)(53546011)(6666004)(6506007)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bzJNV1orVGhiUmtpUkxnRHFSK2hkU1dwaVBHSXp4S0VPU2hVMFkrTGt0cHJM?=
 =?utf-8?B?Q2k2VlBXam5tVUJYWi94dTZ4a0dITjJlNHc2MjFjVWx1YnlWUkNkbEV6czJw?=
 =?utf-8?B?RGx1LzVSaC9IUU1VQXJkbm1kdXUrNUprcE94QXVQVVE1TDJFZHFvSjRVNWxr?=
 =?utf-8?B?dW9VSHZkTWVCa3pWZFN4YWpHN0J1WjZ4SkplZDAxMDZpNFRLb0VIemUyZ1JZ?=
 =?utf-8?B?ajhxYmNRR3JkUXpGMUY2Y24vQktNR3VsSk9qWmRudjdKVlk2S3hjV0FmV094?=
 =?utf-8?B?L0NVTnNPTzU2cTl0ak9GZXk2Y3ZRWCtxUExMbU5raXJlcEthTWJheG54Y0tF?=
 =?utf-8?B?UDFrajRRbTh4aERqd2FHOTJUZWVBNkI5ZytIMU1jZzdjc3YzRzBvTWkrb3ph?=
 =?utf-8?B?YzhwKy9weDF1bU5YSVRNL2VBbXZyOVdSY2JBOHBMbmFmM2pNSmk1WERUM3ND?=
 =?utf-8?B?RmozQzl3d2pmVElMUjgyVm12RlY2dXRqZ2lZazBmbXhBRmhnUVJTTXMvZVNG?=
 =?utf-8?B?UFFIZE1JRUFvMFI0VUdNem95RmNLNnNIVDJGaVFSVXJrdEdSQ1F1M2VYZDQv?=
 =?utf-8?B?UENwOVo0eUhhY3ljUU5ndkpVSFRnRm51RVlucWZ3U3lUOEVZbzBGYllKS3pQ?=
 =?utf-8?B?SWtGVk5MclJuQkltMDRUbkVPVFZCdTh6RnlQUmlKNDBiYUdtSUVDNkRBZ0xr?=
 =?utf-8?B?NVl5bFFxTVBzZzdidXZ3ZU9iLzZuWDVDQjMvNllLUDkwSlVIakFmQ2FKaTlj?=
 =?utf-8?B?SElWcXVTVVkxRCs4eFFKNFdyTTlvVmpzRWd4bmV5T1JsODdDSDVpeTQwcXJu?=
 =?utf-8?B?V3JRcjIzSlhlMzBEWW50VDBuZ0dTVzJINS9YRW1hcmFXU09udExzWHNObkk2?=
 =?utf-8?B?M0hqWGUxQlArampSNUtZaVd5b0c5T1R5ZnlUSUQ3MXVtd3dtbHpocVFMQVRM?=
 =?utf-8?B?NHBOa0RMRGQ0eGhaZjVVNm5KenJaTHNaN295U2loQUFyODNWeWxLMW42SUpN?=
 =?utf-8?B?S1lHRDk0UlRvVHBxbk0xQlZ2TURKUzZlZmNWSXpEcmg0eUpjeEt4ekg4eG5C?=
 =?utf-8?B?OXRCNWs3ZXZjN2YxejRXT2lYdk9pbWFPZXk4Z21oaFUvS3FwNjdjejl1UzRo?=
 =?utf-8?B?NVpweTh4WmhlWmgrTVFFbk9FTTE3UnZZYzNSVjgzS0JqOXJ3WW9DTUhKYlJ4?=
 =?utf-8?B?MWpPd3Z6OEZrb1pxRng2ZmlTbFZteHA1WGp2Qk1hN3Jxb3QrdXgxTnpqQzVn?=
 =?utf-8?B?Y2xEL0c1bHIyaVQ3RWYvUHJiQnlrVWZpSzhVQno5VG5wUDAzRkdmemhTTytW?=
 =?utf-8?B?K3R4THFvQUFDWks1bGxMUWpWOWhxNlVaVmdEcEVuak8vRkF4UTNmazJGenJ4?=
 =?utf-8?B?cW5FQjZZd0xSeGNqekJBSUVTZm5oclltNnNxMkZFR1ROQzhzMmJxZVVpOEFP?=
 =?utf-8?B?cTloVGVZT2VyVEU3YmhNOTlEVnQvbHZOVllBQjcwMElvam4wV3YzM3B2NWFF?=
 =?utf-8?B?bzZBb2FVRVQzUlJrblA4K1h0NE94bEwrVTEvNm80cjdWUDFTQzJXS1FHZVNV?=
 =?utf-8?B?eFVSanRuK0dDaVMyMHloWThGS011cmw4dGF1ampXSHFTcm9TbzV6Z2NHSFR1?=
 =?utf-8?B?N0ZtMi81TnYvenJkcmJaQ0dBTnZzdEVZNTlab1BYS3h3Ymc1NGpGaTVKUFp1?=
 =?utf-8?B?bEhnMFBOS0NCNk1IOXRXQWsrTjFFRDkxWnUxSXU1bjNDUU5CM0ZOWWp4SjFn?=
 =?utf-8?B?bG1YNVFvaDlJR3QvdFpPMytobkJ1UjdiZDRYK25xUER1VDNnWEZzNXlnbUR6?=
 =?utf-8?B?Nmc3QWNOd2F5MHdyQ0xaZ201RFhrMW5yY2ptSCttOEorWUZXTXpwWFNQUmhV?=
 =?utf-8?B?eXRrZzFjVmhrZDJKNWo1cVplc2RqTVl5bndkeEM1d3RFYmRVUXlwTXFEZlpz?=
 =?utf-8?B?R2ZBZnlKbUV5cTBFTXpwREFGSW1iSUZQOFJpRW91aGd2K3RtS29jMjRCQWxC?=
 =?utf-8?B?UUp0aXlPcE1GMndSTFg2ZWZsWU1yZVNwclhsZjZKT1ZLYWd3cmprNlBCS0My?=
 =?utf-8?B?RTNZQmdSRWx4bGtTL203eklwL1BKcGxQR3hMaWdjNnQ1Lyt1K0NyTktvQk5v?=
 =?utf-8?B?Mzh2ZWZ1eGhOcFdKa3FaVnA3Nno4Nzhnb3ViNXBTT0MraHpja01ITUdEUTQw?=
 =?utf-8?Q?9h6HqN5uuozfiN4FNEjjYDnBp3ps4Lt0t1A2MJ7Pu/RH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Knx9aDbDcDG5U1EouvSwckUXDlxrTKcHoUDQuwj+OfToyxhsZj3CiH0miI1MF2Y6nDwJSFaDpkrZ1gaVhWyKK5IL/wVhWdS/5Zkh3RDUDCJwtv5oFPBloyc52UKiWPht7wkg9chDfMHwy9Fv/lmtqba9Ju0aZxyfOT70AxLyNCnpXOgkfXi3ay+es9RMw1QU4tBEtGdAeGneQSYKjhtQt+ZXWXqmMXoPYKY+7V11xmMCo+5bBjgO51B3bnHmB31kYIe37TWX+Anrc6UoFJ6MM+F5Ytk9WcLv9xhwksjOXLviMqYAICOKzoVcvDw39+8o8FLufKkD9FxbyVrdqXz2rXZYvhFOXC5LVOjND+C0Gpu8LsYO/+YwoRL0K5/yiMw2igZgY5zhv28EDFe3qKQJAAYESEMQKia9PPkO3/UYaDtZSswi64ZEaVsmPcgKVfDZEPfC9KvRqUNNPo6as+gj84N5eD4OEMubDVIpuBwR89CEWCiF2g4/HK1+doRltisly4ABGt1R/cOVZMckW01g9R1+XQxTSsbVs0wCCQT7OOiKsbkZGifSJZ7jj+n6KGHDnwyqHq124n7ahReCvIUl60iB7M3Eu+/qxU02B6A7meU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35918acf-e9f4-4932-52dd-08dc2946b332
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 08:11:21.4019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ykNvKzPIupT70lO2PqgTyHpplq1DdGDLHk1qiV/+CwjffhmVJDYj8wd1Qs3l6pE3F5yQ1i8aIJO5NOQ4smf4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_05,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402090057
X-Proofpoint-GUID: tJuUXJOx546-Jys4Yq4apOCa92dqgRH_
X-Proofpoint-ORIG-GUID: tJuUXJOx546-Jys4Yq4apOCa92dqgRH_



On 2/9/24 01:34, Alex Romosan wrote:
> i'm attaching the boot log from 6.8-rc3 with your patch. update-grub
> works. i took a quick look at the log and i can see this (which wasn't
> in the unpatched kernel):
> 
> BTRFS info: devid 1 device path /dev/root changed to /dev/nvme0n1p3
> scanned by (udev-worker)
> 

  That's nice. Thanks for verifying.

Anand


> On Thu, Feb 8, 2024 at 6:22 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>>
>> Thanks for the kernel messages with debug enabled.
>>
>> I don't see the message to skip scannaing for
>> the mounted device. So it's not what we thought
>> was the issue.
>>
>>     pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
>>
>>
>> Based on the assumption above, I have a fix below,
>> but I doubt its effectiveness.
>>
>>
>> https://patchwork.kernel.org/project/linux-btrfs/patch/8dd1990114aabb775d4631969f1beabeadaac5b7.1707132247.git.anand.jain@oracle.com/
>>
>> -Anand
>>
>>
>> On 2/8/24 18:05, Alex Romosan wrote:
>>> i'm attaching my boot log with 6.8.0-rc3 no fixes and btrfs debug
>>> enabled (i assume this is what you wanted). update-grub doesn't work.
>>> there was no patch in your last message. do you want me to try the
>>> patch you sent on monday? confused
>>>
>>> On Thu, Feb 8, 2024 at 3:23 AM Anand Jain <anand.jain@oracle.com> wrote:
>>>>
>>>>
>>>> Alex,
>>>>
>>>> Please provide the kernel boot messages with debugging enabled but
>>>> no fixes applied. Kindly collect these messages after reproducing
>>>> the problem.
>>>>
>>>> We've found issues with the previous fix. Please test this
>>>> new patch, as it may address the bug. Keep debugging enabled
>>>> during testing.
>>>>
>>>>
>>>> Thanks ,Anand
>>>>
>>>>
>>>> On 2/7/24 23:48, Alex Romosan wrote:
>>>>> Which version of the patch are we talking about? Let me know and I’ll
>>>>> try it with debugging on. I tried David’s patch and it seemed to work (I
>>>>> just booted into that kernel and ran update-grub) but I’ll try something
>>>>> else…
>>>>>
>>>>> On Wed, Feb 7, 2024 at 19:08 Anand Jain <anand.jain@oracle.com
>>>>> <mailto:anand.jain@oracle.com>> wrote:
>>>>>
>>>>>
>>>>>
>>>>>       On 2/7/24 08:08, Anand Jain wrote:
>>>>>        >
>>>>>        >
>>>>>        >
>>>>>        > On 2/5/24 18:27, David Sterba wrote:
>>>>>        >> On Mon, Feb 05, 2024 at 07:45:05PM +0800, Anand Jain wrote:
>>>>>        >>> We skip device registration for a single device. However, we do
>>>>>       not do
>>>>>        >>> that if the device is already mounted, as it might be coming in
>>>>>       again
>>>>>        >>> for scanning a different path.
>>>>>        >>>
>>>>>        >>> This patch is lightly tested; for verification if it fixes.
>>>>>        >>>
>>>>>        >>> Signed-off-by: Anand Jain <anand.jain@oracle.com
>>>>>       <mailto:anand.jain@oracle.com>>
>>>>>        >>> ---
>>>>>        >>> I still have some unknowns about the problem. Pls test if this
>>>>>       fixes
>>>>>        >>> the problem.
>>>>>
>>>>>       Successfully tested with fstests (-g volume) and temp-fsid test cases.
>>>>>
>>>>>       Can someone verify if this patch fixes the problem? Also, when problem
>>>>>       occurs please provide kernel messages with Btrfs debugging support
>>>>>       option compiled in.
>>>>>
>>>>>       Thanks, Anand
>>>>>
>>>>>
>>>>>        >>>
>>>>>        >>>   fs/btrfs/volumes.c | 44
>>>>>       ++++++++++++++++++++++++++++++++++----------
>>>>>        >>>   fs/btrfs/volumes.h |  1 -
>>>>>        >>>   2 files changed, 34 insertions(+), 11 deletions(-)
>>>>>        >>>
>>>>>        >>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>>>        >>> index 474ab7ed65ea..192c540a650c 100644
>>>>>        >>> --- a/fs/btrfs/volumes.c
>>>>>        >>> +++ b/fs/btrfs/volumes.c
>>>>>        >>> @@ -1299,6 +1299,31 @@ int btrfs_forget_devices(dev_t devt)
>>>>>        >>>       return ret;
>>>>>        >>>   }
>>>>>        >>> +static bool btrfs_skip_registration(struct btrfs_super_block
>>>>>        >>> *disk_super,
>>>>>        >>> +                    dev_t devt, bool mount_arg_dev)
>>>>>        >>> +{
>>>>>        >>> +    struct btrfs_fs_devices *fs_devices;
>>>>>        >>> +
>>>>>        >>> +    list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
>>>>>        >>> +        struct btrfs_device *device;
>>>>>        >>> +
>>>>>        >>> +        mutex_lock(&fs_devices->device_list_mutex);
>>>>>        >>> +        list_for_each_entry(device, &fs_devices->devices,
>>>>>       dev_list) {
>>>>>        >>> +            if (device->devt == devt) {
>>>>>        >>> +                mutex_unlock(&fs_devices->device_list_mutex);
>>>>>        >>> +                return false;
>>>>>        >>> +            }
>>>>>        >>> +        }
>>>>>        >>> +        mutex_unlock(&fs_devices->device_list_mutex);
>>>>>        >>
>>>>>        >> This is locking and unlocking again before going to
>>>>>       device_list_add, so
>>>>>        >> if something changes regarding the registered device then it's
>>>>>       not up to
>>>>>        >> date.
>>>>>        >>
>>>>>        >
>>>>>
>>>>>       We are in the uuid_mutex, a potentially racing thread will have to
>>>>>       acquire this mutex to delete from the list. So there can't a race.
>>>>>
>>>>>
>>>>>
>>>>>        > Right. A race might happen, but it is not an issue. At worst, there
>>>>>        > will be a stale device in the cache, which gets removed or re-used
>>>>>        > in the next mkfs or mount of the same device.
>>>>>        >
>>>>>        > However, this is a rough cut that we need to fix. I am reviewing
>>>>>        > your approach as well. I'm fine with any fix.
>>>>>        >
>>>>>        >
>>>>>        >>
>>>>>        >>> +    }
>>>>>        >>> +
>>>>>        >>> +    if (!mount_arg_dev && btrfs_super_num_devices(disk_super)
>>>>>       == 1 &&
>>>>>        >>> +        !(btrfs_super_flags(disk_super) &
>>>>>       BTRFS_SUPER_FLAG_SEEDING))
>>>>>        >>> +        return true;
>>>>>        >>
>>>>>        >> The way I implemented it is to check the above conditions as a
>>>>>        >> prerequisite but leave the heavy work for device_list_add that
>>>>>       does all
>>>>>        >> the uuid and device list locking and we are quite sure it
>>>>>       survives all
>>>>>        >> the races between scanning and mounts.
>>>>>        >>
>>>>>        >
>>>>>        > Hm. But isn't that the bug we need to fix? That we skipped the device
>>>>>        > scan thread that wanted to replace the device path from /dev/root to
>>>>>        > /dev/sdx?
>>>>>        >
>>>>>        > And we skipped, because it was not a mount thread
>>>>>        > (%mount_arg_dev=false), and the device is already mounted and the
>>>>>        > devt will match?
>>>>>        >
>>>>>        > So my fix also checked if devt is a match, then allow it to scan
>>>>>        > (so that the device path can be updated, such as /dev/root to
>>>>>       /dev/sdx).
>>>>>        >
>>>>>        > To confirm the bug, I asked for the debug kernel messages, I don't
>>>>>        > this we got it. Also, the existing kernel log shows no such issue.
>>>>>        >
>>>>>        >
>>>>>        >>> +
>>>>>        >>> +    return false;
>>>>>        >>> +}
>>>>>        >>> +
>>>>>        >>>   /*
>>>>>        >>>    * Look for a btrfs signature on a device. This may be called
>>>>>       out
>>>>>        >>> of the mount path
>>>>>        >>>    * and we are not allowed to call set_blocksize during the scan.
>>>>>        >>> The superblock
>>>>>        >>> @@ -1316,6 +1341,7 @@ struct btrfs_device
>>>>>        >>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>>>        >>>       struct btrfs_device *device = NULL;
>>>>>        >>>       struct bdev_handle *bdev_handle;
>>>>>        >>>       u64 bytenr, bytenr_orig;
>>>>>        >>> +    dev_t devt = 0;
>>>>>        >>>       int ret;
>>>>>        >>>       lockdep_assert_held(&uuid_mutex);
>>>>>        >>> @@ -1355,18 +1381,16 @@ struct btrfs_device
>>>>>        >>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>>>        >>>           goto error_bdev_put;
>>>>>        >>>       }
>>>>>        >>> -    if (!mount_arg_dev && btrfs_super_num_devices(disk_super)
>>>>>       == 1 &&
>>>>>        >>> -        !(btrfs_super_flags(disk_super) &
>>>>>       BTRFS_SUPER_FLAG_SEEDING)) {
>>>>>        >>> -        dev_t devt;
>>>>>        >>> +    ret = lookup_bdev(path, &devt);
>>>>>        >>> +    if (ret)
>>>>>        >>> +        btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
>>>>>        >>> +               path, ret);
>>>>>        >>> -        ret = lookup_bdev(path, &devt);
>>>>>        >>
>>>>>        >> Do we actually need this check? It was added with the patch
>>>>>       skipping the
>>>>>        >> registration, so it's validating the block device but how can we
>>>>>       pass
>>>>>        >> something that is not a valid block device?
>>>>>        >>
>>>>>        >
>>>>>        > Do you mean to check if the lookup_bdev() is successful? Hm. It
>>>>>       should
>>>>>        > be okay not to check, but we do that consistently in other places.
>>>>>        >
>>>>>        >> Besides there's a call to bdev_open_by_path() that in turn does the
>>>>>        >> lookup_bdev so checking it here is redundant. It's not related
>>>>>       to the
>>>>>        >> fix itself but I deleted it in my fix.
>>>>>        >>
>>>>>        >
>>>>>        > Oh no. We need %devt to be set because:
>>>>>        >
>>>>>        > It will match if that device is already mounted/scanned.
>>>>>        > It will also free stale entries.
>>>>>        >
>>>>>        > Thx, Anand
>>>>>        >
>>>>>        >>> -        if (ret)
>>>>>        >>> -            btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
>>>>>        >>> -                   path, ret);
>>>>>        >>> -        else
>>>>>        >>> +    if (btrfs_skip_registration(disk_super, devt,
>>>>>       mount_arg_dev)) {
>>>>>        >>> +        pr_debug("BTRFS: skip registering single non-seed
>>>>>       device %s\n",
>>>>>        >>> +              path);
>>>>>        >>> +        if (devt)
>>>>>        >>>               btrfs_free_stale_devices(devt, NULL);
>>>>>        >>> -
>>>>>        >>> -        pr_debug("BTRFS: skip registering single non-seed device
>>>>>        >>> %s\n", path);
>>>>>        >>>           device = NULL;
>>>>>        >>>           goto free_disk_super;
>>>>>        >>>       }
>>>>>

