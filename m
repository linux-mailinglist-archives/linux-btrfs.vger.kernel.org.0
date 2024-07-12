Return-Path: <linux-btrfs+bounces-6419-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0010C92FE46
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 18:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDB5286D83
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 16:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4A8176226;
	Fri, 12 Jul 2024 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FTnWJXAV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NZ9Dz3R3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E061DFE3;
	Fri, 12 Jul 2024 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800880; cv=fail; b=edxSbNNrgS8R0uzKwlswyxeLCIEJUx/KwlZgRMyDvnrIv7VuklIMOhWBBzHXTB4E5lm9S9afM+LAknhj/ijp1sGpBWgcocnsUIMuVnvcEqUKmwJZWarTUgCX3t8Hbg+XGzZzR/spEUExLMe4emJXuhbGYxEHAabVLNxN2wl8sVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800880; c=relaxed/simple;
	bh=AtHk4kwcFI423axZYRkMH7UvYMR0NylFh8nFdDEousA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tHisqOVnG7ui96QnSfskuyppR4rmpwtVlqYq5wfC4Xtq2RlFvp0vp4jCDJL14QqLTYeqrlvZW/QG0QKuso72JOqyf2I7oeOEg5vblM3AcJ8iFkm2BJ1WC+hgpkBbNo50kzrUXs+a3C///eY0QRKLayfN62TwjhhL43hwzlfRcXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FTnWJXAV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NZ9Dz3R3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDINJs025663;
	Fri, 12 Jul 2024 16:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=8c+nR05ShHIUWcKpJFO1locfjdPMYhL6vMtV9i+e4aQ=; b=
	FTnWJXAV/QVD8DQt1losYJ64jM/mWea2XzmMfDspca49OoGbr8ZMowOTwhtXoZtE
	AcFi1QJeTNKym0E1FZ6PZCgHNFkXDND+n+aNnumPISvBE/ofAUcH66Gcmfxfr14f
	khu3h4naENfT8PRkKtR0jenBpL1RdgK1gQY/O/voHp1ZkhRs8HL5kl6M425wOBaG
	mixIL2wicsCSUKo7a0+1BCPySdcZL5RGGKEGjzsbfxjrmG7O0T5i+MIyL/DIymAe
	P4FDZ0BLxMcfhU1pl0sdLhFQQSkz5wsejPYdsC0Otj04Fj+z7i6EZuU1eq83nzxI
	VJAcT5CCUjlzRt4g0oBQBA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknv7uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 16:14:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CFEn7o029895;
	Fri, 12 Jul 2024 16:14:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vvcsgnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 16:14:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pd/zJXVQRed1VbCZVKhKvfGn0n8pRdA14DMy6HA5cVPVjmFKW1i5tCaILPBZCNBURXU6I+UpAgvC8VhdxxKI34N+2boA7Lv3XfMYw/VBX5hnnS6eDXJnd5wnb2233IJCrBQQusJEVspOJkMVcVOAVh+rPLaOj/I0p4yUghd6UfZS8R358r2ufHinrwtpxD+VNuzlo1F5sieen3ujbWmDOBar1YPQmQWPEnQ/afDWiLig6CMfSsPcM/msDNQp+EMH7hdtiv+mNK5Lrylph18KTBtPLTL9wrC6wh2rX6LU2ScB5lIlsa5HTVUM8CC65dlEbQmUQw6Idsu1r23mXTaHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8c+nR05ShHIUWcKpJFO1locfjdPMYhL6vMtV9i+e4aQ=;
 b=yI0/6FW+NLVzz5q86qMx0mCrpGoUiWzm8wErmeyr4K4+SleyMAnFX0FwHJIFVyRoH0NWdl7X6iTWNxr5csr59bc7TACr7CLyLPrydv+GgGD1Tv5NzZV4nM7nZDTCRNjS5ZA0OU1WTr4jKcO8fGOdoKIevLFOtSI3njsiu6EkAPM3e3sb1jaiKaya7pnaMrmcQVfkaFCjC1aX32+Cbl/piRldE4ZE1gWu2g3Sgyokys3Z9Gsf69V6A7wEnrdPEn8Lbm1b9pzkEchArUJ2LdcTapoTOYH7CCUhKklfREnCnS2XARLynZxqiuSYAWjn69pAaYcCLzT57oK+9//JsAteHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8c+nR05ShHIUWcKpJFO1locfjdPMYhL6vMtV9i+e4aQ=;
 b=NZ9Dz3R3b5dEpaRUmCBmEwxDtcvcmffRqYdU16uuwwDD+b+dxoq9xRHCO9mxhhQsM7e9hvmAcD6uf/R3UB2kNKxSJlflD0g+4B4Wo0nYyi5SoxBBY8I0f8qlhqS16lVGBQOoeMS+iDImyTw9giNg7o8fQxY1VROlFwjMav4FaG4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5540.namprd10.prod.outlook.com (2603:10b6:303:137::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Fri, 12 Jul
 2024 16:14:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 16:14:31 +0000
Message-ID: <1e6827bd-a57f-4139-846e-64ca20b50b7d@oracle.com>
Date: Sat, 13 Jul 2024 00:14:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: fix _require_btrfs_send_version to detect
 btrfs-progs support
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Qu Wenruo <wqu@suse.com>
References: <fbc8f96ec69397ce358e759b9a8df25f3e64c6ce.1720742612.git.fdmanana@suse.com>
 <f1e109784681df64d6d9fc62aa2b1952ce0bccbe.1720777916.git.fdmanana@suse.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <f1e109784681df64d6d9fc62aa2b1952ce0bccbe.1720777916.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0092.apcprd03.prod.outlook.com
 (2603:1096:4:7c::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO6PR10MB5540:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4b649f-a24a-40ad-57f7-08dca28db5f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?THN2Q3l0Qnlnd21LMkdtaDBhd0F6bGJtNDB4Ukh1Q2RNTW1seExHbXc2TzFJ?=
 =?utf-8?B?bmw3azZKTkNlNzV2RStqczZJenBXY3crejlhYkhJUUV2dlJkdENacXJhVHJ3?=
 =?utf-8?B?QkltcmdPZnZMUTRQSW9VRDllY2o1RGhTOHV4dUZJSkkveDNLVHBJR2tIMTk2?=
 =?utf-8?B?dlR3amFOdHRmZitNcC96WWxGbmdFMnhhb0pwL1ZRTFdCTnRIbzU0RGRCNkh4?=
 =?utf-8?B?RHovV3FwRm0xUlN5RGk3MWVKN3V2bDR6clp2QjY0bTc5TjA1U0RyS0sxSlJ0?=
 =?utf-8?B?WjlqakovUDJtY29YTjdnWDVPMTNnam5EeUhhQXFjTVh2aFFCclpzY05ydHJE?=
 =?utf-8?B?M01KQjhkb0dnUmlqL3ZKVWRKUEhzOGhaZGY4V1UvelMwdHlJSEdsYlNsck56?=
 =?utf-8?B?ejJIMWVLaUI1L0lDY2R1S2tHUzFjMzhYRXB5U2l5dDBZaXE4azFUR0hQWGRB?=
 =?utf-8?B?RWkwdmlDbjBUL0pybFJFcmY3bHhmOGNUM3NPSVhqTzZVdHEzb3dzM3U0TGVI?=
 =?utf-8?B?dExYeE94czNya1lNbURyczJwWTQ0d3ZTdVA5Y0lubytHRDJKZUJmWTlXdkNY?=
 =?utf-8?B?empnd1ZQc1I2WFdrUDRkL0lMNFBIalA4WDdZeGJSOGdFNndaQ29GUXhRUDA4?=
 =?utf-8?B?YlVIeEJPZXdNWjhUZWY1VWtUeHdBa1hzOG55Wmsxbk9rYXYxR2lPZk93U0NB?=
 =?utf-8?B?SU5Jczg0YlBXTHRTSm9xbElxeExqb1JCKzlsbW9zRGozd0ovL05Dd2tGUWFJ?=
 =?utf-8?B?d0xLNVBBY0ZFSkx2dW4veGNGU0V3UEhmM1BrV1ZVck4wVmlVR3BBbkY4Ymli?=
 =?utf-8?B?WkpUeVA0UjlEV0JpYW1mZExqVEtvcDJVY2MwOXVZSklha25RN3ZGc3owUEdH?=
 =?utf-8?B?SzJZNVZCYVFxMDJrdE0wUXYyTVBLVEJXMWxIYlZ2OXNqekkwb0huWlRVd0U0?=
 =?utf-8?B?V1VFQVVJWmErbDR3VER4WlpSRStsaFpETUxqU2ZXM3paSWF5UGVTNUxKRUxu?=
 =?utf-8?B?RGdRMnFoN1hXMjRQUUlIVk5odnJVWlRzcmVWNmxUaTRtNmxkTGxPUUx3ODRw?=
 =?utf-8?B?bnFFRmEzS1VCaHpuT3VJRHdUc2tmYWlZYzVsem5Sb0tiZTRlbVQrSXRZVmJ1?=
 =?utf-8?B?U0VTWXZzSGh2d3piVkk3b3VudnBUd1BqTEkwNWVLV3FwWFFoVndrOCt1b2px?=
 =?utf-8?B?dUlVR0Z4Y1UvRkszQytRTXpMRFB6OHVuWDE0cXdRN3A1c2FHenZIeThZamd0?=
 =?utf-8?B?blArRG1rQlFENC9xRzdiNHdrTXdRaGd2azh0UU5LdkZoODMzVElyR1Z3aEkz?=
 =?utf-8?B?VXc5RWxxUVRMb0txcGY4U3dwRFROSFB4RXpiVDBXU1BxVTE1bS9NMzZWcGdK?=
 =?utf-8?B?NmFtN3ZsTmRzZVBhYWdZbk1RYlYwTTI0dzhnNU9SWTJCQWlEcFI2SkMvNmkz?=
 =?utf-8?B?UXMzWDdnWXJKNlhvZm9EV08yVWxJMk02Yk5iTW5lYkZlcjEzditlMms1ellX?=
 =?utf-8?B?M0ovZjlFZjYxbEYxUnhlSFQzTnNTNUFmMDhMYmFISTU3VFFSUDF4anl0RTYr?=
 =?utf-8?B?YXpGb1pVekFTZzFkMG9ZVFpUaHIyQ2xXQnFYd205S21HU2g1cXY0UDJFRlpR?=
 =?utf-8?B?Y3dzaTB2K1oxbDJPQjlNOTExY2d2aG1iN3RwRTNoL1d4V01FQXZDekRpaHR6?=
 =?utf-8?B?c3A1SEdxcUltY3dSYVJmUWJkSFNiaEI1RG1JbFNaQzBZOC96eXdjYnpOemNj?=
 =?utf-8?B?L0tGSFEwajd4TUpOd3M5L1F4UnZHWExKNDNUQTNkcWNkeTBiWHF5ZG94d3p5?=
 =?utf-8?B?UEkzcUxQRFRDaGhYdEpLZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dUdOano0S212RFNqRGVHR1VXb3pWRzlMMFlQUXZCeWFTUGYvektybFRWeEV1?=
 =?utf-8?B?cTVXMWdOQXdNWEZiSStHT3hDUFZLakFlUk5sVmMwUjAxeVV6eEZETDFSMGU3?=
 =?utf-8?B?ODJWOXlnZ0dQM242RkR2U2JIYjVvOFpSMWZJWjE2TkJ0UlhLaVFRbUJzMnJE?=
 =?utf-8?B?cXZGaFhJa2EvMVp4YnF6NERjenI2KzlobjllbmFLQ1FnNlFCbDgzWEFHZFNK?=
 =?utf-8?B?ZlhjM25JRC9pR25qWXh3a3lmdCtnZjUzUkQwYWEvMWx4eklaeTU5WGZ2bFFv?=
 =?utf-8?B?V3NFMzBHb3VWcVdSWlN0NkM3WVZJSWVsR2xmYUhCc2VUeWIrYjBNQ09pM0NL?=
 =?utf-8?B?dVJEa0U0ZFB4emYxR2xxc2hsditzZFhqTkdjR1lMclNxOCtYTmRueE5ZUWRR?=
 =?utf-8?B?eUh1UnNPN01QdUtEVmlGL2U0aHIrL3FEMmRKZm1uS1JXVGtnQlprYmI5dlR5?=
 =?utf-8?B?MkI1M1ZXUVp0eGVWRlAwWUZqQ2ZwalhPUnl4dTkwSXNaMFhOMExkdmlZL2Er?=
 =?utf-8?B?ZTJwQnN2Qlc4dm1tODBBbDROVFZCaEJ1eU8vMDhpSzJxNHVnMmlxYUEycmxM?=
 =?utf-8?B?TG83NjlyelN3NmIrK3ZOb3ZYaklESS9FQjl3SXlKKzhuZ3RoSnhZSndRdWhn?=
 =?utf-8?B?VExqY3RhS3IzR1FWeGpSaUgxTEhtR085STF4cXUyc0Y0RFB3RzZFRTlsQlNl?=
 =?utf-8?B?KzhQa0EwZTl4K2FzWEdZVkFuQUllWlBVZUdUTDNkNHRUamhEb0hPWXc0Y3po?=
 =?utf-8?B?QlM4TTFYUHBSZUIvb1dYWlpDZStFVGlLWlZiZFVsZ1l6QUlQdGhRY0Q4Uk9F?=
 =?utf-8?B?VnhvRmwxdjlxZGloMlhVYWhreG5ETldEK0g3NUJDbVJsOXhKSFBsd25DV1Nq?=
 =?utf-8?B?a1ZTcEcydGR0SG1nNjcyV0hRYitMSGdVRHlsTTRYMVFSQnlGakRzaFRTZ3Ja?=
 =?utf-8?B?ekJnTk1OMnhiNVNjdVQzazJWYVlrU0EzeWluNFRKTnRMYnJrS1RSVkdWRTJk?=
 =?utf-8?B?OVBjbldiUkZBRHdzaUNJQ0k5S29FTTRtNmxPYVVXYnM1MWR5UWJPRkY3M0xV?=
 =?utf-8?B?QjAzR2VYZkdGZ2plVXVkTWVqdGFac2FMeTluMEluSUZZcXhmRmEzRXZ4WUxE?=
 =?utf-8?B?cEsxQ3hqSGdaTUZiQmZ2Mm55Q21kR25aV3FjTzVDSnRuV3c1RFI5VWRaR0Ur?=
 =?utf-8?B?ejhvL2NVU21yUTV4R1B6T0g4MVJDNk54T3F3eG1QRVdNT0daWndDZWdyZGV3?=
 =?utf-8?B?TWluRG01Y2F6eDFHUG9Ma0tXb2N0Tm04bzVOb2pVT25abmxrZUk3VFRHWTFp?=
 =?utf-8?B?SUJrSi80VUxBSmpKL0MwSTlKbWJlWWNLU1lyQ3pHRnRFcFBnMkloQ3l4bVNk?=
 =?utf-8?B?ckUvdEpjNHhMRkx2QU05Nms0TlAvMzVURHlELzQ3cXQzT1M0Sy8rRTlncFU4?=
 =?utf-8?B?c1pWeXoxS0VQRDlMYVNuanhpR0J3TEg0bERVS01WaXI4eE1sNW4rREZoYUdq?=
 =?utf-8?B?VXk5bmdMNllRYXY0eFo1OUJRZFZhMGFCdzZXVnU1VGhINE9wWmhHbU40Tkpw?=
 =?utf-8?B?bkRwcU41SUNMdDEwd1VLWGd3TjRia2xndW93SzlxTjZEeDlkdmQ5aE5hTzBl?=
 =?utf-8?B?aDhZMGorSjdzQUVMTUdJMGlmSDFMTmUyVnhRb1MzeFUvRTFzN1VWVGNNY3Iz?=
 =?utf-8?B?QXJGZXhOTThDWktVblBZK1U4NFYwVEtZNWtDV2hPZE1jM3kzUHlaT2dsdzc3?=
 =?utf-8?B?d3BZdFlCRmI1STB0WXFQZFJrT1ErRGZSSWJNYVJ2cUl3elh1SGNYUW9KN1Bu?=
 =?utf-8?B?c3psRjBXQjVBQ3dlNUh3Q054TkgxaHFxU2NRUTQ5T0RFdlZaY2gxVWlVanEx?=
 =?utf-8?B?aXo4UjJvWDBJRDB3azl2MGxaMGtIby9panlzQloycTN0VnFPMGlKMis2TEEr?=
 =?utf-8?B?NHVpU1pkcDFya0lwRGhPdmxLaUJ4a3loL1NRWnVwbmpnaGVkcm1QZjFuODNQ?=
 =?utf-8?B?NE5vNEdjMFRkWlNReUxURGhCQ3JkbmoxZGdGWVVwQVJpeFlyMVJVd2xMOCtw?=
 =?utf-8?B?bFZnUW9rUTA4N1BnWmlZOHdqS2YvWUMyQk5mL3pJd1BueFFseklZT0FrSnZU?=
 =?utf-8?Q?+WMz1kfbc+kz1bF9sTcFKYVfA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MfmPBg4QNcm06alw9mO5HHbHa0r0FmnafxvkRQ2XC3QhHFhsL+xcOE5fOphV660R6lQtlrr010rVPE0PVEuszysg+h+ntfwASipuenW4O2Dq9TZnv54FWQEtxTwwE8q5BrT2rb60zum1ymGOvGnq/mta3O9LOasBfQIYNp2a/SeVFAKAOlLR1Ps+RMJNN7EcBJfiAre/2gzjc6JurRCBbxHDBQEoxuW3E9bDLUdl/k+FathhCigpzjqJZyMwp67ATFrtPVxrjIh8tAFW78RlG6h1kZDL2hPEqeNkECI6M2tSdF9Y6bNP3IBc5SiUE8CuphojQkdCVv0wFYRPhtop2fSveAZtiQQgGATudX49ihEe4t05Zheay88CZCsKdi2kJb8BRhcBzZvx97XL/Yo5+of+4L6BuwDdJjPVeid26opa0mj3vSGw+6GwLou9S55MJStIlQx3uXsTHMxWBIH+4CuZ7KImVl3i9mHVYX8u6ybkKUN40A7nEVzVLBBDgaspriMhYx3JzXBuTl96Jt4qE3d5Lt0oKEj2uHS/lSEJOp9Z3CMLsBPbBQC4LdHKl3sRjWmEqscc6MqyrbW75aza2uoeynFQbKduHsTxAEuNjh4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4b649f-a24a-40ad-57f7-08dca28db5f3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 16:14:30.9682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fr6LRYzYVKcY251Jfd26EUzobMpYiJdcR6p2pgcGoh0PIir34TOc9brb9IXA1UiusegybWLuh6S8QGK6Sj8uxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120111
X-Proofpoint-GUID: S6qx6_gyBGnghKvk40whODcDxiW4Ez6f
X-Proofpoint-ORIG-GUID: S6qx6_gyBGnghKvk40whODcDxiW4Ez6f

On 12/07/2024 17:54, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Commit 199d0a992536df3702a0c4843d2a449d54f399c2 ("common/btrfs: introduce
> _require_btrfs_send_version") turned _require_btrfs_send_v2 into a generic
> helper to detect support for any send stream version, however it's only
> working for detecting kernel support, it misses detecting the support from
> btrfs-progs - it always checks only that it supports v2 (the send command
> supports the --compressed-data option).
> 
> Fix that by verifying that btrfs-progs supports the requested version.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Don't use -f /dev/null in the send command, just redirect stdout and
>      stderr to /dev/null.
>      Add Qu's review tag.
> 

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Applied.

Thanks, Anand


>   common/btrfs | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index be5948db..c0be7c08 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -777,17 +777,29 @@ _require_btrfs_corrupt_block()
>   _require_btrfs_send_version()
>   {
>   	local version=$1
> +	local ret
>   
> -	# Check first if btrfs-progs supports the v2 stream.
> -	_require_btrfs_command send --compressed-data
> -
> -	# Now check the kernel support. If send_stream_version does not exists,
> +	# Check the kernel support. If send_stream_version does not exists,
>   	# then it's a kernel that only supports v1.
>   	[ -f /sys/fs/btrfs/features/send_stream_version ] || \
>   		_notrun "kernel does not support send stream $version"
>   
>   	[ $(cat /sys/fs/btrfs/features/send_stream_version) -ge $version ] || \
>   		_notrun "kernel does not support send stream $version"
> +
> +	# Now check that btrfs-progs supports the requested stream version.
> +	_scratch_mkfs &> /dev/null || \
> +		_fail "mkfs failed at _require_btrfs_send_version"
> +	_scratch_mount
> +	$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
> +			 $SCRATCH_MNT/snap &> /dev/null
> +	$BTRFS_UTIL_PROG send --proto $version $SCRATCH_MNT/snap &> /dev/null
> +	ret=$?
> +	_scratch_unmount
> +
> +	if [ $ret -ne 0 ]; then
> +		_notrun "btrfs-progs does not support send stream version $version"
> +	fi
>   }
>   
>   # Get the bytenr associated to a file extent item at a given file offset.


