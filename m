Return-Path: <linux-btrfs+bounces-10026-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D47509E1632
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 09:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94AB2281DF8
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 08:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C631DDC0D;
	Tue,  3 Dec 2024 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GGmnCFTH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KlKxgdNS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866C1BDA99;
	Tue,  3 Dec 2024 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733215728; cv=fail; b=Fx5kpuobCtHvdG2wMNu3P2Cu1dJjkzFfH7fqydpaQM9aq4rUl9L+jYp4LS11ybBauVhnkrGDQUrzV6rjPmobBGZXhgI+dZLk2Hw03INdSyGpz34b3rhuApGnNbwHBVnjF3CITUsstsR/Al/G39B/v4IMeQYfr/rt1aNxRk4AIbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733215728; c=relaxed/simple;
	bh=93+NiOiWGDZBUVIs0hTzFMZAf55S/jlZ2fyAOJyMQhg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HPvodevDB6Px6mP1AMxyXqbMgJ+8bKKFzIcYpfgYkXgEqbacBqsR4VBJhAOw3Jt57S/93REKmP3oRFQBRO9GQcv5guBMCWoH8Dk8fxThZg8SIEnBcWa2FXv1vDK/7wA3uMHn8vxOnQUrJNXkjrSSr+BfWcorVbZ2kmyurspFiJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GGmnCFTH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KlKxgdNS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B37XfKE018766;
	Tue, 3 Dec 2024 08:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ePbGgKJRo0MQEKdrqfOgPrpyz0fT4pMpJWpALOspsZI=; b=
	GGmnCFTHVsPVyKutquGeS9FztogOwBmyS2V8zi6i72JuUKMJ7jCtgM9DMsg0xhO/
	yI0fjTKuV2JAD6MFhHTfCh2QDH3VPGEN8rDaWjj0huDdJfGc1s3Wv9f0xgShZ4u2
	GGrVcvIEZOzVJZI1N0tpJh/yxo7/wzyDgmuwWG33dmMZtU1yuEDe10VHTN/ARK0w
	NDmG4JCRytOnTdxGbBOM+qt1eZVHmj1sEVb9bDntsVv/EoNyyfQtTa+J2aL7TQGN
	GyzEb+P4EJ5xvN3ZBRBh+zixHNoaS1cTX60gqsdGE8Sqf2VzMw0PVwWqfH1DqSui
	TRS009ZHaWFJYaGwWX6u/g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4c5ht0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 08:48:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B381uup000905;
	Tue, 3 Dec 2024 08:48:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s57qx6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 08:48:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1x0u0jTEkBhew0xW9mFkCjLlkcR1onNTerGq7pkzUGRr3otcVH1ZIaLX+JWoEJtZgV5l3IfMtsXS8U8P6AK2aLNsoagtuf/95wQzHZ+kUqvplo7EKxz9w1KO5a+1ja/vgKCUL6nmzI64DRsCfT5+uNHeyVgSz/A+ptc5q3iU/7IJor1ACg3tYSkmop54XfKF4dluRF7/LXJqXxwmi8hD7FgLxrbeFxiesa7t6HVVreZuxLr8EfCirJ0F15L0IqlsgILvUXwjt4XeMOlfJZIjleJNmq8UGhHPuyH91Kw7EJpaJXwpX/uO25RZrIYdV1Wc3N7hBSCjaXcfULux+0VbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePbGgKJRo0MQEKdrqfOgPrpyz0fT4pMpJWpALOspsZI=;
 b=s33/nEuQQd4HI4I2quW+HIkEikP5fx2NYr6hLx5oTzk/v111B+18I8ze8n8RUY+0M+Rljk9Y6SvgNOwz3LrbNEG+eLwT2un4HQttESgvPg4mpm5zZ9lWRj/5QAmqPoqH5nYVWif8niARzz99XhgFt4uWMPFo+opyKvYTbTnRBT+rubN12ewHdpncQn3wJv+iAkgWWjGVdbA41Uovk8HEQgEMxDBN2u02VA7FvOvg2LFxxzfnz65nJkU0syETAwV19gM6qxbfL1x6zRP4NarhzBPcdfetM0kUF6EyRww34M5FZFOKF42w+OzRnqtf8eeKXEPwPXQlTHDbhatHyfFHvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePbGgKJRo0MQEKdrqfOgPrpyz0fT4pMpJWpALOspsZI=;
 b=KlKxgdNS/XogNHZFje/an4iA3BoaMOZl1M4Mx/syiBKrynNZI+ADBihd3r0nHSwrvCU0pgAom294rDsIexbQn+CZ6qxxSVflsSph06WCdw0WGvzG11OiPBPMoocdhMO6eE1qacjhWapYKxbZZUT65gtVyVbsSByCOViwh8+ctmw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB4865.namprd10.prod.outlook.com (2603:10b6:208:334::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 08:48:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 08:48:40 +0000
Message-ID: <b25b3710-652d-4d73-b9a9-e47ad2388bfb@oracle.com>
Date: Tue, 3 Dec 2024 08:48:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3] btrfs: handle bio_split() error
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Cc: linux-block@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <964809e5e81425b0fb28bfbee5beeb99b68b9562.1733211171.git.johannes.thumshirn@wdc.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <964809e5e81425b0fb28bfbee5beeb99b68b9562.1733211171.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0069.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB4865:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a6da645-6090-4d81-c803-08dd137748b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUxRcWJNa1gyK1E5ekw2RkxWQVdZWEVHTGsvbHdwZ3E1bnhhMFFvRWJIemNN?=
 =?utf-8?B?dFJFK0tJcitTbnZKN1loU1JDRlFvMFoyYWliRmJ3V0x3NllpcXJqMXR2bjhp?=
 =?utf-8?B?L3cyOW9Rb1QwWFhxV1NMVWRmTkZFeTVIOHAzSkRsSVk2NU5mdFp6MWk1N3Z2?=
 =?utf-8?B?ZFpnNHJCSXRUNDNUQ1ZrWWNhT3V1WDg5L3MzUUVWKzl5dzl4S05qMWtQeldp?=
 =?utf-8?B?LzdnQkloZFBIQ21xZ1pmRzFoU2IySFB5aHJPRHZVVVhZN2hXdXVXODY0K1l5?=
 =?utf-8?B?U0FmN0lQZ2FUZFpuTmE5bDc3bjdRTmxpbTNnWE4yTlZXSGFwRnhaUHRvYzJp?=
 =?utf-8?B?YWthSlhMOURTdlF3VFNOQnBDT1JHZkQxRFF6akhCSm41Wnp4dlI0eWUzcjRD?=
 =?utf-8?B?MGE2RzhYczFCT2FZN3U3Y1pweU9NZEpTKzZwVFZ3RTMwc3k3dVFoMEFsZ25Y?=
 =?utf-8?B?TGNrWjNOVVFQeFlmOWtZN1Q4QVBiaE82K3hpZFk0SkpNbVc0dXV5VFBnc1gw?=
 =?utf-8?B?ckM1dkdsNU9DR1dvZzdudzFGTDhzNXBOV3hqNk9rQUJueExnbm1aNlA4TW9Q?=
 =?utf-8?B?OHRXeFhxZXRyZTlCeVY4dEs2ZFJ5S2VvczhLMGNCVXlOSUVtRlhWVWtQTGtN?=
 =?utf-8?B?TWFmaVhnMjhNWTE3RVFWWFE5ZHNTUmw1dy9qS1N3bUtpWnZ1b0J4K2ZvZHlW?=
 =?utf-8?B?NllINmpzTlFnRm44WXE0Q1FrU09FbmZKY0sySzhsd3VvVEtraFc4bXhFeWgx?=
 =?utf-8?B?MWFEKzN0YmFGTytDL0liaTQ0WE15Y3BqcFVmMG5xRGlPc3dYVll3aXVTQVhT?=
 =?utf-8?B?OXVka2dIVEJUVkwrY3hLSHI3N09wMEhLQ09kRzAxUXl3YnE2V1RZVG1NL1F4?=
 =?utf-8?B?T2dscERUM1ozV29lU0xQbzEvMHRYUkhsNDFaeGozMDN6V3ZIWHVoR1BYSFNy?=
 =?utf-8?B?L29jcVY0WklUMTM4YzlacEVjRzdkKzNOSGg2VVAvaFg3RDBnaGFvT2RaRHZj?=
 =?utf-8?B?NTloSUVjUyt0Y1RseGNUMjBJT0VNTVZDRE54M3oxYk80NDdHNEhubXR4R0Fs?=
 =?utf-8?B?NElPMTRvTTNPb2FZM2kwQ3hRcC9JSWJwazJvOFdDbXZrQTdxeGI2M0I1a2w3?=
 =?utf-8?B?Qk91R2FoYnY5bmVvNkVXWEpyelF2bUNiWmI4eHYzMENrSHhDeWtVdzBZcHN3?=
 =?utf-8?B?aGF0Uk9hd0ZXSkdneVFhdy9TZEFlZVZiWHVMNGtiTHBqTFBUdG9icTV4UnZu?=
 =?utf-8?B?UldMejBrR1R1ZHd1cGRHNG9XYS9aeWhyNXFPaGh6WCtCRXAyR1FlVDV4enRB?=
 =?utf-8?B?Q1pmdGlKSVNreFdwWFkreE5SRGU0anJqOUZiR0loeDBhdVhVZE5ObE90RDE3?=
 =?utf-8?B?TEM1Rk5qa25nTFdxTFk5Nzl2bzhHTklJbDYxQXJERkR5dmkzNGpnUStjRDVv?=
 =?utf-8?B?M3hiaUhlNWF5VmYyVFpmZ3VrZFZGRTFhNk41NHc5WFVsNlVwQVIwOERxRUo5?=
 =?utf-8?B?TkREckpablVMOGNySUtSR3RQbWhURVhYV1hudSthNTZjUCtJMFYvaTFHMmhQ?=
 =?utf-8?B?RzFUaGRreDNJS05sMUw0WjFLd25SR001eW52Z29hYWUzb3VnUHd1Z2c2cHB6?=
 =?utf-8?B?TlZ5Nm00OXh0cVZjQnJKSHZVeEowOGVPOWd0U2lCYUNxZ3hoWFZFeUtDUml1?=
 =?utf-8?B?dlc3a2llaDNTd2dLZERVam5NNTk2T2Jwc0E3cFl4ZWFETUU4VDg1S3VXQ0FB?=
 =?utf-8?B?YWY4YkcxZTJNcnBDSEZSM1BpVXFFWkxacVgrZnJsUzZ5cmVlRTdyeHdZL3Zh?=
 =?utf-8?B?eE5lVkRWNjczdmdyNnB1QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejc1OWNNSEEvNUN5ZDhSRlVxb1lnaEtHdVY0MFNEdlNMMEFNcEVteUo4MFdI?=
 =?utf-8?B?ZXk3Vkg2THcvZytUdlBEbDlHKzJXRlUzQkU0bjN1TWx5azl3aFdSb2xNNHR4?=
 =?utf-8?B?Y1Y5WUxnWGhmQmIxcUFGaG5iM0JFZDVmNUdIYStNWTU1bklIOFJWb3Izcmx4?=
 =?utf-8?B?M2h4cTU3c0cyemtBZ2I0RjFzaW01MUlsZnBUS1NGT2RMTEhxN09IWG1HaDBl?=
 =?utf-8?B?NWJHaEpjZG14NFZaNGJqaXFESDNkbU1pWm0wa1pDcW42RkNaQkZLMU8yRjJx?=
 =?utf-8?B?a1NYWU94MmluVTBmMHVmTTVyUXkyRmRSazkvS0dEcWxiRisxOXQwMktUVWpw?=
 =?utf-8?B?eTZqUUdCYndQaWg4Mk5BN1ovRjJkQUJoWVZqOU13YlZlbVVhMGV5d2hFS1Nt?=
 =?utf-8?B?aTllQU9zbytRK2VrWVh3Z05seGlkOTZRWkx3dTBlSXRHQ3BoZ2hTRSt3M3Zq?=
 =?utf-8?B?dis5V1FIZXNrbko4RHVERytyZUROa2JLcHRndzF6ZzlHb1dZR3RBUXFKdWxk?=
 =?utf-8?B?blBrdG9wVUM1Y3VndmhqeTVyTVRXV1d5SFV3MW1uVTVtZmZZdzA4MXd5anVr?=
 =?utf-8?B?ai93NlgzWDUwZnVyVTF1WlBpNGIybG92a3B0UVRCQXhXVTh0M3NpSTBVNEc1?=
 =?utf-8?B?bTNpbHpLeUMvekJadW44SjcrL3JqSHdoeHd0Sm5SL2t4WW5LajFUZEMwWGxa?=
 =?utf-8?B?TE5HbHcyS0tDV0VsZ2dVQ2JXbDZDbkxQRUlWelh5anNWUDhhN2NMY0VzSDBQ?=
 =?utf-8?B?R1A0QUNYZDZPLzNKNHoydW8yTHNUbGRmY3hKSTlmRlBJUkQ3S2RkZEgyTjJN?=
 =?utf-8?B?bTVUSFUwcWttaTRVQkpRbllWWitFbXZyQkR1NEcrOGxac0dieTlSb3VvY1Jl?=
 =?utf-8?B?enVhTG1yakdQSTYySGRIVlA2K1VKVDhvSDFnZFk2aUNlZ0VqOGxOdmk1cFp2?=
 =?utf-8?B?WnRyS0pXVW9sWTBkdU54dithc2RqN0lrV2tqTWhVRURGTW1PSzRJV1RhWEpv?=
 =?utf-8?B?c09lUzdZZ1V4QTl5LysrcnJOby9MRlhJZ1hoeHl5dnA3WDl0YWtBK3kvTmg2?=
 =?utf-8?B?OGxrNE9mSVFlaWpoeThLNkhaUXJOWGpVOWxwZ1J2eHdKMGJFb1JrS0VnRWx3?=
 =?utf-8?B?ak02eEpLNEl1MWNkMG4wV3JCNGF0RzBwQ0FvNjZ5NFNOK2hlMGxxTmtNTlR2?=
 =?utf-8?B?RnI0U2JqUHFNbzUvbTd5MXk1Rlo1cFVVMHJjQndjMkdoT0Vzcm9QbEZ3MGZ1?=
 =?utf-8?B?QmZJM0FyZUdKdWxyWTR0OUlhd3UwZ3RUVVowaXhjUkdER2xKSjFXd3pneEpi?=
 =?utf-8?B?Q0NkYlJCU21MdlBTMWNSNnRoWWxubkQ1Rk9KRjRyZGlUOENZT0o0VW9QMWpx?=
 =?utf-8?B?bkJMYUhoeXFlR3lOQnlhY1MwSG81NmluaFpSakxHNnNZWWZ0NGh5MUU0V1NI?=
 =?utf-8?B?eUZXVWtPOHNtS042a1BxTXlCQ3BwUXJvaVQ2ZHJlcUN2TEpsUDhzakJwZm9q?=
 =?utf-8?B?UldLYVM1QTVCTVV2d1hPdk03ZWo3RWpPajVaU1lOb25qRjlMdW83dUgxQVM5?=
 =?utf-8?B?eXJ4VG9FK3dhVWlncVhLZlFDRGpFOE45VVBtS1dGU3pBWHJZUWIvZloyWVVn?=
 =?utf-8?B?UWhzRXQxQnhUVlRUYzhoWDFtWXEyRnd3aGowTDNUQ2tOVUZiTGNoSDB3ME16?=
 =?utf-8?B?MnZTN2huSk5uUTZERlBRV3gxcm9CSzdxWHpyeUxuaWlaSGFWS041akhjT3ll?=
 =?utf-8?B?aG04R1ZUcmc1NHNURGF4dGptbEJvSDRjYU1IU0ZQcU5TclFmYm1kMUprUkVX?=
 =?utf-8?B?b2M1VW9CdjhJaHRPcms2ckZjNUU1K0NxdzIxNFdpRXlEUWE0eElOSWR3cm1B?=
 =?utf-8?B?cE9LQWR3ZTIyOWgwcHJpN3dWVmlDUlVHdzRoMVZkZ3Jzdkg2bndqVlQwSVEx?=
 =?utf-8?B?eVo0NDd1Yk80NUtNRVgwSVNzQUtEclRiL1RKU0xxakVuMW9OQXdFalBrNnEy?=
 =?utf-8?B?MzJYczRuNHd6OHdmQklFbzNiMzRuQTZZVFRrRWo4MEFjbmhsc0dPdEZtTHZt?=
 =?utf-8?B?NE1UdlZJSFhRS08xbXgxQm1hUy9lckl3THl3UEx1WjZ2VGFOMDRaSzZvbU5Q?=
 =?utf-8?B?MWxFUVA0ZnE0OEtBeDZtdWpYc2tIQjlscXVGbTFGbjljSnZmb2o5NjRxQlM1?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xm7gKjP9t3txZyP0IX0GBOWT09Y7ZrTHefpFg2AJGvly0e4UzSRUYjd5hNzZ78QiYsK0+EaWlBGjCqgfnoiTxGphw6uva3iCEaVM1n5y4IlxQIBRO6eSVUKNEOemD0kPglCJ23zfmyvWEjMTETrmumkIpMQj/v/a7ykAc+VC6ZvNSkSZKabf5DmIFScgYRfcaznhaJwDUj3YTQURUJkyGyOD+3csOH7pO4ADFLonQU7OgpL6bLLgTdLXm2jWkPQ5iBl7gqfUrByCDDYfA71QAoku/G0gmcH9ja9ZLGBSklpZeuD39pxl5yl4iTeUcz7P+jtPT4zPzhkOGw8H3+NCzo+wxLG0zNDsL8vmHbK1092bJUfIKbagok0Ydgh0GMJKUCWb9KNNXQyyRfTvBjPXlxfLfn9Xq1ZxzJ/R7xpdTIxc/5pbq7wL5XddzhEHQLmiArBShx3ESrHpJv5FOy9qK8VrLJhf9N/5VYWIjFNlMHdvHdszaw56gfCDweoR7wfBDK5+cWrPMWYPIQvzsnGF2uU+MEjkzE363Nl3K7qrPhLtyD6gsN7Bve/JPnYas9mqQpdmfQcy+r7Nl3sDY95khhvSvTLZB4O4TMuq1BicGLo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6da645-6090-4d81-c803-08dd137748b4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 08:48:40.1045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9uH4GSaih0dKWuSrLc7DlkqIXHOqlbV2Cjy11Tqo0xJ4aFE5HyKF4twTFlFSfvNJxRcNc7WkyG0fGCZehy9zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_14,2024-12-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412030075
X-Proofpoint-ORIG-GUID: dGF0xKGxcjclVzEiWoUexzHF47s1U7xE
X-Proofpoint-GUID: dGF0xKGxcjclVzEiWoUexzHF47s1U7xE

On 03/12/2024 07:40, Johannes Thumshirn wrote:
> Commit e546fe1da9bd ("block: Rework bio_split() return value") changed
> bio_split() so that it can return errors.
> 
> Add error handling for it in btrfs_split_bio() and ultimately
> btrfs_submit_chunk().
> 
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
> 
> Resend because John asked me to do so.

cheers


