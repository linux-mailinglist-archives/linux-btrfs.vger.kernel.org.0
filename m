Return-Path: <linux-btrfs+bounces-12875-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13084A80F87
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 17:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D701B866A3
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 15:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D111E4929;
	Tue,  8 Apr 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h9N3X1wO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rN/V85nw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA48139ACF;
	Tue,  8 Apr 2025 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125057; cv=fail; b=WyzzSXpoR5rmKOvI6lrBXITN7YPx1sY9F8Gux3tlVL3gAW8wvYg5KWUmB1jIRrlSGxj/0l+00kGmgRLKjMrI4Lt3kbid2PZYSp+o/4noY+76I6YHKy0GSqhG80go9lqFwG6hqP83fQbYIgH3zhPLEgdT1z9VUHH/+uX0/2OSwG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125057; c=relaxed/simple;
	bh=JZu0nqpR9+L0Ng+oECbwPKmh/tOwjHC3exJ9fnoAyW8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LBuTNBSmqF3MfYKugru/hpd2BsJGEEeWGKqievMg4yWHr7kJzqASg9Q0OQaji4ERne395GDXuSxQdDU7XYMU7yr2DU2uXBMD/99G0X5DSDHuWcygaZRj11b44tOrb4NfQvTXBM7DWYi7xDv4CwEBkF3kdJ3ZauLSyF3ohoe3DOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h9N3X1wO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rN/V85nw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538C6fWm025773;
	Tue, 8 Apr 2025 15:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TMR6b3nTNPRX6RMkkQOqPLXHZW+Z0H1vHtErcenDMDU=; b=
	h9N3X1wO/eStgPQPUNt/+sJBktTRB5CcUAaK6rK5mdhHKwdrJpotxSrRaiR/i6yV
	N2qxrEeAnsEikehX1mJYKzxyByfoqcb4uzMP7ZFaKOi1vJ0kz0Q+0KNV75UI8mcd
	PG+FhGkrsJAUFEvmDtwB4IpRF6yE7xHzv96cXWvn3GDMMTHpqhC6VVauAiZQh5uZ
	0uV8aA+X3taVqbdCbzXIhDy3/2IpO1bjJTOOMpcfSEhOBHytIkM0Fu9fyVGABPD8
	SQjJ8dor86Vg9GP0lNFCK6W3tKvNpeVC2aJgrZ50g/3hUBu+L/rTXF3k5trErbyD
	D0VLLIBgg6XEsv4EcN9ToA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tv4sw241-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 15:10:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 538Ed34l016775;
	Tue, 8 Apr 2025 15:10:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty9dx51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 15:10:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FscrwOWG96nILYo7P5jAZZpT1GHbriT1wFylS32ztHKNt73KNJ6DxFzXImfq1tNgAYUu6fSNZk819W5eA1c/pGjdPk2EaFjngnMCzLNZRuAHOjTcOp8FrAhEojAUs5GjHrn4DZgXbLaRD7bRZ0J6IOjbhsQ+/3xHABtJTiPei+cNITaY6pyfezPqNqKJdBx44J5zxXYrJr6f41jqdiIv0QiGvMmYA2XVH1jWOEUpzQRyM49fbDMgEKGXS69KnDsB1bzJQZSqSSsROTKD8dy5H+a76Wx9d6uiek3aOphYDnfZYv5vftFC0XUQDDaVcbHYQ6amaGv1EWRp5c9nSjeuwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMR6b3nTNPRX6RMkkQOqPLXHZW+Z0H1vHtErcenDMDU=;
 b=uTenZEPraBu4y6U68ew9KtB5ufRWHOuutg+nsY03wZ2dSasEiDNpAaV+HHfuDFYBC7AwrhmNVJfCTXP6giZtXAiIlYRnO6PWNrPdTcCIfSfVHimghZvMErcmq/uHLhKz9Lf1jl2XdDTULlTYl9lzCPR/At6Bzsa99KFgAIf2KO0w73tWz8acEs+qYbVE52SoHZXnyaT25tmDqoPNxesrQhqDpIgkJM6iOMe0jYS+lWGrZjn0vvUaNYndEg7bNIl2YPp/3P7udGcKYbq0/Wan6ENux+sEnw4bysKfeWgVBVqS3mc7JI0P67cP6FtZsQVQa9nUnMOWGBzyulJER1Iyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMR6b3nTNPRX6RMkkQOqPLXHZW+Z0H1vHtErcenDMDU=;
 b=rN/V85nwuFAARaVmXTPGMKlhLtwWqZ5ISshkeKuS+QUm64VIW5Eq61EY+d+d0P6UQ0OQcznV1I258f3yQVWkI+bqwTPHhhwhwKtX8G0D2VGKyxwL66tayU7dUrzh4Fi9X9pQ6A4ZfXSVZ+OKwh2fLwcgil70ZAaRFI6KwUeauXs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA6PR10MB8063.namprd10.prod.outlook.com (2603:10b6:806:436::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Tue, 8 Apr
 2025 15:10:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8606.027; Tue, 8 Apr 2025
 15:10:47 +0000
Message-ID: <06bcbb2b-934d-4b66-8ed8-9acaf1072a28@oracle.com>
Date: Tue, 8 Apr 2025 23:10:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] fstests: common/rc: fix unset seqres in
 _set_fs_sysfs_attr
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com
References: <cover.1743996408.git.anand.jain@oracle.com>
 <5e081252abdcf7253ad83d2b5eda49a8818305ad.1743996408.git.anand.jain@oracle.com>
 <20250407165847.GA6258@frogsfrogsfrogs>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250407165847.GA6258@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:3:18::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA6PR10MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 85de0c5a-490f-486d-e075-08dd76af8a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTd4dG5SVzczek5qQXdDNThmYWlOVkE2dVk5eS9EMXRyd1d6MEY2RWxuNlJF?=
 =?utf-8?B?K25wVXlDRWpKdmJyVVI4QU1zUFB1SWFCNDRNU3Z5b3BSdlRGUGhHamZLTWpt?=
 =?utf-8?B?TGM3TDU0dFpzcDhhL1d0VkZ5STRjd1plN2pNcEl4RjZvcHpjZHN3S29rMDdN?=
 =?utf-8?B?bmM1SDJIUm4wTTBWZ2swMDFXYXUxa0hjWm12V05OYUdFU2hReWsxMThadFgx?=
 =?utf-8?B?OXplaUIybHJyc3l4dWJNQWl1aDBHdE9mY0tGMTBiKzlIM2p1Z1pHUkkzMFlo?=
 =?utf-8?B?ME9MMTBwY2VGMHlKSmZScEhoZ3FNbFdSTlJ5OGFkWW1CaUNyRXpZUUtoK0JN?=
 =?utf-8?B?cUNPbFlocnc1NERNUzVoejA3Y1RkeVI2TitESWkyNFQwU3VzYWVSaHNxaFl6?=
 =?utf-8?B?UUZBeGROTW9Jemk4aUZodUpPMmJDSEl5RTBPUWZwMGk2UG5Xa2l0b29CMXZT?=
 =?utf-8?B?cDBzVGZYS08vY01zUEkyYUxwaiszSmJNR2VBOE1XaHZqYUxWME01ZFRQWngw?=
 =?utf-8?B?Zmw5ODdXOFZiMWh6KzF6R2tCRExWWlZuM0x3ME4xQ3dHd1g2Z2tWcXBvVFR4?=
 =?utf-8?B?QUhPK3pDVUw2bVlPaGtFMU9iMlQwN0hGSXhIWU5jY2JMWXdVZi9MWDhjZ1F2?=
 =?utf-8?B?amFMclpsaG9IV3dxUVJSZkRZZ3BMNHVjMTl5bEVMZk8zckYrdUV3dG1vRzlF?=
 =?utf-8?B?UG9TVXFranZya3JkRVNrTjVpMFBhUzJ1dGUxU0RLWk1ualp0OUQycGhWYm1B?=
 =?utf-8?B?U1U4QlZwaFprd3JRc0tJekVTYlVVU3o5SDNLTzFBdXlxa1gzNzZRYlpPWnFO?=
 =?utf-8?B?Q05HZXJ4NkRCZlFOeVBQL1NPWFZ4UU5BcXpYazBFRlE4ZFVSTGNEdEhBbnhO?=
 =?utf-8?B?dm93VWM5aUVNaStWRTF3QUIwTG0yb1RXdGJPendPMmRBOUdmOXZiTVlrem9S?=
 =?utf-8?B?aEFlY0ZZanFKNm1NS1NXRHVDTFh5aUlXVDB4R29QU0pOd2owTmZ3eGMzMzFG?=
 =?utf-8?B?TEhYNHBmUnh4WlhNMTZJTU1EUXhwaHlOMERVbmpsY0pWVlU1VlZGOW84S0V4?=
 =?utf-8?B?M0E0R3NZUEZ3WDRsdm96ZjlYRnNSUnVrcWZwVlllSFVFZFY3bmJNUUowcUUr?=
 =?utf-8?B?SUk1SGQyeE5raDRUandOMWhMbFZUMitvY2t3UTdyd1JaRDR2eVcwVDN5d1lE?=
 =?utf-8?B?M1Z6QnFOSDdQMHRiM1ArcGRRQ0hSVXg2VG5TRkxza29HK1dSQVczOVU5UEUz?=
 =?utf-8?B?L1B4Myt0ejNkTWhmRjZiMUdsUVJRaUoyMHUyVUh5cFovOXk3Q0crbzV3U1VD?=
 =?utf-8?B?WVlPOVQzbkZ0SitQZitXRkVNalM2RVFUN2lPaHNndUtoY2F6SWNTUk9kaUVr?=
 =?utf-8?B?WnJUVjA1a2lwYzdMNlF4WTlZZCtrNzZ1cTU4ZjB0cG9xcm5Lck1aK0djTEd3?=
 =?utf-8?B?dEowaTkweDVCVm9GWlZqRUFpZjU5RXZTTG91N1phL3ZxWm1IU0JPbkJINHU4?=
 =?utf-8?B?OERGelkzcndZMmpqNldkalQydDlUMS9yaHJ3R3I0VWV2Vy9zeVJ3MXY2Y3RW?=
 =?utf-8?B?bVBmeWVGREtwTzFXdE1tZ2NlNEhhNTRhVUNDY09XNU9aeWYzZjdIOCtIV2lw?=
 =?utf-8?B?cm1UVHNuU0JqYWg5VFBlcmUyajkwMEVKZjdBdXMxVTBNSDh0NHhlOERDdUdz?=
 =?utf-8?B?T1ZnUlV0YVJsRFFoK0RzaU9JN0JRcGQwMFRXK2pOQi82UkdmdHVzd3F2VEVT?=
 =?utf-8?B?WVllTmVhN1p5NlllNVdta3ZkM2Zidkc5ZFN4S09PZFVEOU9VRjRkZUNubHJi?=
 =?utf-8?B?dHZNZXFTSCtDVzNhMDl6MlUwYk1NQ1FEcTJBRHdUQ3BnSU9GczBhTlVjRFFK?=
 =?utf-8?Q?RIi6pga28Mk2y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1dQMmYrcXdCK3dEWEZMZkhsNW9xaDVvbzdkRFdRNk92NkthdlgvQnRIYWx0?=
 =?utf-8?B?SlZaWnNnamYzb0kzUDZMWFFiU2tvaWZ1ZFRRTC90SytaT0RnSmNZZElNaDd4?=
 =?utf-8?B?OHZIS0dUSDdORnNQTkJGK1Jpem8rRE51ZndhdGJSMGRQbGJpeFZHbFZFbFdG?=
 =?utf-8?B?WWp6WXlYTUNEaU4xRjU5OStsbE9mOEZFTkdhdmhZKys3OXNBZlg1ZmVrY3ZV?=
 =?utf-8?B?TFVkN0tkZWlYa0dFU2VLN2ticXR6RktoRms4UmNWWnpxdFJObXlZSnBHdUpL?=
 =?utf-8?B?TGdTbExwU08vbFI4RlJPMWhNNUxha290ckRDNjdDWnlCQ1l0UkRvU3orR24y?=
 =?utf-8?B?WWlTSXBWd254UjlWNExWcTJyUGJwVGZyaDlDYmh2SHUvazhhR1RZVFJlN0dR?=
 =?utf-8?B?aFV6NFVnNjNzK1JpT0x3eWowOEd5WjdNSU1Keko1clpKSmJmUStVRy9jSlJ4?=
 =?utf-8?B?Qmx5T1JpUmxlWU5jVVhFV280NUdxRXAzUEgvbW40VmdESElpdkZBVEFEUjRy?=
 =?utf-8?B?dzJ0TGtHZlhEMU4zdGxCVUJTeVh1VExwdVJZQnowOGRIQnpHUWJCNkhpVjRx?=
 =?utf-8?B?d0xWNHYrcWRiQklsaUN0cCs0YStOMnVkdDFOekhVcFpzRjRtNE9MQVJWb05z?=
 =?utf-8?B?SnltbVlOVmFTYU1oanAyYy9sd25sOTZHNkRoTGNsUmNCU1I3ejU4d0RQWjl3?=
 =?utf-8?B?MnZwdGZpRkU0cHZiQnRZazE1Q1hWbzE5MlpkWWdESENXUWJRd3lmNVBwcWxZ?=
 =?utf-8?B?UllJSCtDMU1IalYwL05uZHNRSjM1dEtyVnpxci8xaHZIV0d6R0kvTWFibVFi?=
 =?utf-8?B?QVVqdG9Md3ViZXRUQXpmYTVrMnFyTlNMR2x1K1pPMjNkZGxTMjlLUWgwb1lZ?=
 =?utf-8?B?Um1NRkVmV0htYjAzRWZITVdnd3FGUjJDNy9tMFZ3NVVtc0p6NGx2a2tZbEgv?=
 =?utf-8?B?MG1iRTdhUkNJK3JhcHhnUVJPVjVjaGNPNnB3MmRFaXdTNXZFTWg5OTNVbEY0?=
 =?utf-8?B?WE55eWNCbHlnWWlxanp4U0dSOGhSZXQvb05BNlc2YnJvcFFXeWx5YmpOSm04?=
 =?utf-8?B?WEJTc0NZQ0tKM0JvTTF1MFFxUitvV1lrRk9obVQzblZkWldMYVNtb0RoeGp6?=
 =?utf-8?B?ekkyYmx5N1BBT3NwZXc2SjVOQXVjM2REcEQvUmtFQWFuRWpBTUc3Yk43cFJv?=
 =?utf-8?B?dEZkZjFwL2tuRnhPTjRPWVlHWFMrZTFuZUdQbkkvWnZmdStqdzJwejBWUUE4?=
 =?utf-8?B?bjNaK3pkVkVSUWV4NDM0YjF1cVJ6SCtQK3dnUWV2R2l3UVVCSTJRTElldDQv?=
 =?utf-8?B?eldCSVpyaVUrbnQ2TWxJbjZZaVdUVEc0S2o2azdJWkNCL2dYK3E4Z3BuWWZw?=
 =?utf-8?B?TC9yaG9tNUUyZDJXTGh5MHRZZFByVDVXbmVPVGc4VklCdU8xVFFOUUcyQjkv?=
 =?utf-8?B?NXpJcklZell3VEJkUjROekcyeDZhQng2VjhQSk9oOE9OdVF1b24zRjBRNjNC?=
 =?utf-8?B?bUUraERVS1N5R2lVbU4wTGgwdEpoUi9Xc2NFWTVxVUd6ajhwSmJteHppR0cv?=
 =?utf-8?B?OVlWWXFQYzV5dHpSWjEzR2xPT1plNFdhMThsNWVNaG4rTzhNOCtqYXJNYkNB?=
 =?utf-8?B?NWJUZkhJaUJUUm9xRDg2VzZmWU5JVUxaUGVzeXpwNUdKU0FacGNhTldvWlh4?=
 =?utf-8?B?N00vZFhXUVY1dGZNd3p2anRENUExMThiVlVOQVo2ZThZTkh2ZnJzTHdwVFRO?=
 =?utf-8?B?Vy9pdzRaZ0xhcCs5TW13d3VIQS9pMHJpSnZVMWdSbmQ1MzVMWGNxbm93SHMv?=
 =?utf-8?B?aVViMUZFdGdXNTAyL3U5REViVTd3cExPU2NNay9GY1c5eVNmZHYrbGtSd0Fp?=
 =?utf-8?B?Nk81d1J0UGcvVGs4ZGNFQzJrbHVjRGNmaWdFc2dDQ3Jpbmw1UTJMcngzOXNO?=
 =?utf-8?B?a1pGazFDL1QydjRFeHh1ZEpaYTB4cUlNUEZnZ0gxUHU1ZWIyOThpV3Jtczdm?=
 =?utf-8?B?TTdwS3UyRHFwVDRLWWZnbExxQlIrNkJZL2ZrN2NGS1JpRFo4OTg4bWJ4b1dE?=
 =?utf-8?B?d1M3UVA4TDc1ejVtazNYeFc5a1c3TnFXVGJnK3lsTDdjeW1UcE5rY0tlMVM2?=
 =?utf-8?Q?zTuonIRVYoLif7tyZt9tbI5hl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QOeUJANBq+V3pLWwcmYVDp4sYkQI5QMYWlWdR0TAxeC8A31jnb1/aIsZH/08ogMUgFJ4itIrNws9jDWtC5ebatpXOKen1hcworq/tI+X4S33x0/rw8AvsMDMD/GVu/jbJlEC8lKUlTHvKxlyTrfxxVnfSu2iE9oDEWmq1CAY+vRPxaVA/Aj/ofdgWiIXyS+e9eIboYr9Q/+Rd7N/k9D6thhvDfiRrcFXES9qnK+QyTrRD0oQZVSBnypMo7zegvHHPI37TaSSoAsfcbjP8V8kRzxbagxfLMurkPYSCxpBduyaZ1SAPdlSsL4uyB8gFm46nNORvOg3MXe/BAQ2umfrQsXLZqEyfy2lzEz+ucCupPQz49loHIJbkAwNeco/XqI05bPFC6bTVCOdFOYbOFh+CrHXY/7X+UnL8ag+qivzW/Xa7Umj+XdU6IzHujZFJehoy0gkqGqrr5NZU2BXkSmvwYAmbYhPWT2P/7bWbq3Giqh0BFQmJV1sYRPvtp9btZI0zUw0p5KkMddTdsI4BWVU9hzLwIfJHULgksBuk4Z6hRcEdTSalr1Izw9g/X8qIfIySzV7Bcq3QRVULGlD8wysDRr83TIHsPFRRc7g0JLfUVM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85de0c5a-490f-486d-e075-08dd76af8a98
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 15:10:47.6567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JL9cngQndlUfKDy0fp1MSqqAeX5Q04rUOpXfsvqaV2BIsVpVVC9juWTsjnMZxwF7bFhRsrEvr7fXY1rhRrbLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504080106
X-Proofpoint-ORIG-GUID: s5xgeAJcSk04NOXnm-amZvi_eifilAN-
X-Proofpoint-GUID: s5xgeAJcSk04NOXnm-amZvi_eifilAN-



On 8/4/25 00:58, Darrick J. Wong wrote:
> On Mon, Apr 07, 2025 at 11:48:16AM +0800, Anand Jain wrote:
>> Ensure logs don’t write to a `.full` file when `_set_fs_sysfs_attr()`
>> is called during setup (before a testcase) in XFS due to unset seqres.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   common/rc | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index e89eee5de840..ca1d13ca1f0b 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -5201,6 +5201,13 @@ _set_fs_sysfs_attr()
>>   	local attr=$1
>>   	shift
>>   	local content="$*"
>> +	local logfile="/dev/null"
> 
> If we're not actually running a test, should the error output go to
> $check.full instead?
> 

Ah. I didn't know. It seems like no one is using check.full.

-----
$ find . -type f -exec grep check\.full {} \; -print
	rm -f $check.full
./check
-----

Thanks, Anand


> --D
> 
>> +
>> +	# This function may be called outside a testcase during setup,
>> +	# so seqres might not be set.
>> +	if [[ -v seqres ]]; then
>> +		logfile="$seqres.full"
>> +	fi
>>   
>>   	if [ ! -b "$dev" -o -z "$attr" -o -z "$content" ];then
>>   		_fail "Usage: _set_fs_sysfs_attr <mounted_device> <attr> <content>"
>> @@ -5208,8 +5215,8 @@ _set_fs_sysfs_attr()
>>   
>>   	local dname=$(_fs_sysfs_dname $dev)
>>   
>> -	echo "echo '$content' 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr}" >> $seqres.full
>> -	echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr} | tee -a $seqres.full
>> +	echo "echo '$content' 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr}" >> $logfile
>> +	echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr} | tee -a $logfile
>>   }
>>   
>>   # Print the content of /sys/fs/$FSTYP/$DEV/$ATTR
>> -- 
>> 2.47.0
>>
>>


