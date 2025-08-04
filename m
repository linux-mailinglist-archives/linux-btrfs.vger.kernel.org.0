Return-Path: <linux-btrfs+bounces-15834-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 140EBB19EB0
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 11:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359E21796A2
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDFF242D97;
	Mon,  4 Aug 2025 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pV2YuBN9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0Jvxa1pP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859022259E
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Aug 2025 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754299219; cv=fail; b=PmEkL7uHnhFB36zlNFXzgTQazPP66TX6PS9he1ZmnJelwaubIYd3paLwdM5d10aGjkSMfeaw5VHJbkBAVbl87BoO6rhbf58Z/258WOzRuw9HCzy4vTTvVg7F0Xv0kb6hiUsfQbVVkX455uZ4EusGGoJC8vOwdCPTDLOsnOppJT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754299219; c=relaxed/simple;
	bh=u6oINjR0vhZge7gWGvy4tBOlKnmqHXY5r4Unfqtzrmg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q9cdu/dTTSfTNqF6Jm9L90GYGrwA8tgVfvzkAon+UqgV3gCWtrFW613t3KcGAKzpZjCysA/L705XNlBAWaB2TGmYhWKv1lKbFifbfx5KPAmOQA7Q3J7lnrSJh1j93v/wCjVl+iicQRl1detXjCz0MIYXn6GdPnq91WX0UVEqQ4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pV2YuBN9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0Jvxa1pP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5747gD5x015046;
	Mon, 4 Aug 2025 09:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/1e5iJG4kdDgsWeywzoQqMkNT3I2B0KxdvNYCTjMvsg=; b=
	pV2YuBN9Jl//688Eve/oPtVRtatKMYqMOf8caVrJXQqTAKBMDN7VJbWMpfnRuQ9D
	4izzYqyOWylB58rp+lwdhPEyXhhhnAyJfhh8rvU/ZQP/nBMFYtdCiBDBO+zhwycU
	snfPcGEMFDFLfmLoJUOCg7qdXbLlWyabSKyeaLWeqRPK31iFd47D7gWRZY0pxmzc
	g9fcRq2cp8565/78FqNRxX2VNCOwfs7jggXLabVuX5wWwSeHdUsCvrq+z5k0mXPP
	JTt7sAd88Ghleaoq0lf8e7i1xRPpY3DSIW/IDEZ5wNymgtnvLneHpHKpJG0xfh+K
	9ICtxuvMuiZY3u8SKTDjqg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489994j9pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 09:20:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57490iug014142;
	Mon, 4 Aug 2025 09:20:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7mr5sj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 09:20:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nml6Lrhs+nGbD6GbSjutl9nd7qP2SZmb0l+38QUA/OOpmZAxaa2QblAqbMiMz+8bXPqjngnm1DHHCd6VwPZ/AoDNmya8+NZ9mHk8WALUh4Unzf4Myg17+zQ2nG+q9a4vx1IgYQHUSFFkXiTCgqVd56g7nMy73MXfkEC4O4FslNlk7vxgtq1XzRZYvc1HCzVZ6jrpAogGpgp95dYKgMdXTqRmb4QB0/86v3QSdulTDMWMg7wjqsfTPCpPnnuzIeO6B6CuNyIKGoim7POTW7z/eaKaNjjLy+O8LVLs1rEvNBOJuRMKcSXTrIRkmZ69wgXqKdth677TAi+Yo5jCn8G6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1e5iJG4kdDgsWeywzoQqMkNT3I2B0KxdvNYCTjMvsg=;
 b=Mt6Ums/N+s511jRP16kT1xtQ6dCzPDdm+W43Tq+3lRXFMVOW+DSRwYmdEnMdIwT0qirp2nalVb8sj7L9X5J6Xd6s9ph3F2+8Kzue8U5EOMgcijZ6MsI0lTny7tP5MjRkeQP2VKdFN741d0MZ7obx0QQ5FnyCsXq00Xfs6JFMj0Ufh4E94zXobcF/mE2uJFCE/UZmfZ9m892xbhe8NSsm5AqY6Qj2Mfv70SJQ2+A1XFrYNuN9oekNjKHRD0edR2Hez5mogBZJZC3kthJeaaOArGtNMy3R/11YQmvfb8dXBjy3FQezmnziiMRyiqIGpykirKjYFF4ooqbFJOdd/mjEdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1e5iJG4kdDgsWeywzoQqMkNT3I2B0KxdvNYCTjMvsg=;
 b=0Jvxa1pPn10DAy5tF6/fjuJ65vwMtMWu+Xbpji/KylNdfO2lXvX/zvfdkcnha5EtuvqepmPbIVYGo1Oh4oUAhz19cNBpGvMM2RNL83Tl/XRRHws0WIl22MSmLyHoL404wC23RVQm3dmk20EID3Z4rXT/677YpCSeWEekaIxz6TI=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 MW4PR10MB6558.namprd10.prod.outlook.com (2603:10b6:303:229::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.26; Mon, 4 Aug
 2025 09:20:10 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 09:20:10 +0000
Message-ID: <184c750a-ce86-4e08-9722-7aa35163c940@oracle.com>
Date: Mon, 4 Aug 2025 17:20:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Should seed device be allowed to be mounted multiple times?
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.de>, linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <aef03da8-853a-4c9f-b77b-30cf050ec1a5@suse.de>
 <4cdf6f5c-41e8-4943-9c8b-794e04aa47c5@suse.de>
 <8daff5f7-c8e8-4e74-a56c-3d161d3bda1f@oracle.com>
 <bddc796f-a0e0-4ab5-ab90-8cd10e20db23@suse.de>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <bddc796f-a0e0-4ab5-ab90-8cd10e20db23@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::18) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|MW4PR10MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a043e5-3a09-49c0-6066-08ddd3381c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGQ5T3QzUjFjY25yOUNJeTd5SGVweTZiejdLVHk4c2VYcDNiWmFiaUgyK0lU?=
 =?utf-8?B?UnNSNFMwbkFnMjFqR3I1a0hQRnN1MjJMVWJXb1BnOExwSis5bzR4Mm9KUDRr?=
 =?utf-8?B?TGhJTnZ2ZTJ6TGRpdDZWV3hXeXFndjZiMFBVMndLTHJSMGRnSkZkTVVqbTZG?=
 =?utf-8?B?MjFYRXBBUExFM3RyR1ovRC9YY2lzemlxcE4rWllyckZZbW53VEM0NGxEMGNR?=
 =?utf-8?B?dk5VNFFLK3I1QjRCN01Ga29hcXBEZVI4VkN5TGtobE5HaUV0aVdBbGJhelkv?=
 =?utf-8?B?OGNtWEVDWWRRaU16bHlyQjdncFYwcTVScGdlUzJCMmpwMDlQbG1ZWWk5NDBv?=
 =?utf-8?B?YTFsTkhMWUx1b1NWb0dFbDdaQTAvaTVXSW13dTlESFUzQ2FscHBsNEx0S3pQ?=
 =?utf-8?B?RjFPeGV0dHN2SDNDOEk4V0c5Sm5NaWtFYkl1SCtPNEE5eFlFeENCMS9iQ05i?=
 =?utf-8?B?V0pLd2YxMGtwdnlaTFk2TE4wZG1YSGlrRnJucUJCOGgyRWxyWVJwMUx6WTB2?=
 =?utf-8?B?N0UvZ29YelpQd0hES0hlZkVEandpdEFUbHNHdEFmdU1naU5HSXBIalk0dnEr?=
 =?utf-8?B?ODRVTFRUY3Vlb1R1cHQzMTRIZWVnL2JyRmRUeXozYnJSb0lzYm5hclZsSDNw?=
 =?utf-8?B?RkpVdTFkL2IydGhMOVAxUTJFZHdVMWRRMlk0Si9DZWpWSXpFVjdKaFl4UmND?=
 =?utf-8?B?QTk4Zk5nWUthaG9kVktZUnpDclVjdXhoQjI3TTZlMEFITHVxbWFkYTJFSjBh?=
 =?utf-8?B?T1lNbjZLQm5EUzZ0UHdQMm5ydlV4M0JrR2JGcWdFOFhtZ1dQOW95czFwTHB4?=
 =?utf-8?B?c1lmd3FNanBJcExWdnN3Q3p1MEQ5NzZjMHRpeTlvbit1VnZQUkNtb2pvNmMr?=
 =?utf-8?B?b0E4QXR4d1o1c0x4aWY1TG5DRzB1UnVLUDc1R3ZjSVVTZGg5YXpKT1RidUJE?=
 =?utf-8?B?YnRyNEUveXF6Nm1kTDlyL2d0YWpOZmcraXNJMmsvNEQrVFh4Tmc3NzQwWU5o?=
 =?utf-8?B?enF6SlRYU2EyZWRVekRJYTUvaGpReXhLVUhiM3ArdUhtQzZTWUY5TnJLS2JM?=
 =?utf-8?B?b1Q2ZXh1bVdWOGI1UzBFdkVGWFZ3SStDSTNEeVg1Sm1sclpCMWlMdnZRVWlt?=
 =?utf-8?B?VFBId3dETFQ3TEVoa3JTVlZDaXBOcExKcDBIem42bitjVE5nZnV1NFNydXgv?=
 =?utf-8?B?UlFMZmNFL0kvVlU2SzFYeWdFVlFEQW5ZQ0lrdUVZNm9XemxhbTVKWFBlOFpx?=
 =?utf-8?B?WnhBMnFmSU11dE9wdlFWTmRBTm83WUpvSTZ4QW1ZdXhpQTRpd1prUlBFK2s0?=
 =?utf-8?B?ZlgrbG5VZ2RLUXdUaGVESlNqRzBkemk5YkJOYVdmZ2RnSlhMbld1STdua3g2?=
 =?utf-8?B?ZUxvYS9JYmpOamJpZG8zcUNEbXU3aVVnTENlSVArSlp4VE5JRDA5Z3NCVGtz?=
 =?utf-8?B?cFdBSDR2dWVVSm9iVWErUGhQeHgyN0lWU0pLS2Nyb0FUUHk1enU5Z1VyaSt4?=
 =?utf-8?B?K3hoZFNCSnovRk9rRlFMbUdlUUhDek14cDVQNmRHMm53ZHBWYi83UzBGZUw3?=
 =?utf-8?B?bjlOSHpDb29aMDVweExrdHRmTTF5cmZuS3E4UnVuMWkrWGFIY0dUVVcwaUxm?=
 =?utf-8?B?SE55SjlxR2IwYzNIK0g4cGNsYU54eUFhN1VrZ1E4ZGVzOGVZSHE3TWwrRGZH?=
 =?utf-8?B?aUNvVm1oUlpXWXZYN1JTaDFqMnNFYmdLVXRMV1JJTFptYzZteEg2TzU0Y0VC?=
 =?utf-8?B?bFdjZU1TYmtLQXlnRWhiZzBUVnd2c1B0SEJSdzhodHhqZEVVOHFoOFloRzVE?=
 =?utf-8?B?TUZNSklGSGVhbDBsZmxwaHphYXh1eWhmU0doTjlINi9jVU5QTjlIRmpPOThp?=
 =?utf-8?B?cy8weVFTVTlKUGU2Vjl5R2VJa3RBOENncnprYi9yLy9TaEZLWDMzQ0tiZklq?=
 =?utf-8?Q?kZ9nRexkQMI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGpBdlRrVUVxL1d0a1hjUFpReXBOR0NpVk1hOUpoZ3lYMURmU0xyaWZpVGVv?=
 =?utf-8?B?OGNFS1RhWURFbXp4NklPRjdsdjdXWVN0dFNzTEozZHQ1REg3azUyQmY0REJ3?=
 =?utf-8?B?ekNKd2ZQbUJjaTIwMFA1WllFS2F5dm9uRkY5c21rZWFtS2syVm1VN1FpS2tL?=
 =?utf-8?B?aFowWGswRU9KRDVuNm1VaHg2WVRRemhKTDVmQ0ZRNDZLcXhBNmtPMEdiK3Q1?=
 =?utf-8?B?TFRpT1JWMmVVL2x6U3JUODFNbHBHeU9NNWhyNktyaGZOditneWFUUm5pUjBN?=
 =?utf-8?B?YjljT3JaSkJPTnF6OVFHWEtEWGJyazlaSExSZjdrdHZRTEFtbm1tSkhVakdu?=
 =?utf-8?B?c0tlblRyT1BjM0VmdUdWaGZ6aCtGb1RQYitsNzgyQ1g1Y1FHamFEbURuTDl5?=
 =?utf-8?B?YjVzTnQ2UENCQkZhc3hlYzlpL0NUM3VseWtTRDhtSDhWMG5rRW12cktJQlRL?=
 =?utf-8?B?S3dGQUJSVzhpUjA4NitRWVRpb09aeE5pRmZ3ZlFRTkw5Q1dkKzlocCtuVFA5?=
 =?utf-8?B?MXByUVhjczErZ2dTMXFIeTZnbmEwYnpQY1d4ZXp5UlR0MHRKOTg3cm9TOWRX?=
 =?utf-8?B?YlJqanBiRjRFb3JhZ2tGSnYzUWZ4dWZOZmVRWThHWXQ1QUs5TWJQUXZjYUtS?=
 =?utf-8?B?UzhUN3dscndvSlpSOVgweWpuVHJVRDBzME1wdUFmdmJJbE42UURvZkZkNVlH?=
 =?utf-8?B?T25iUzdxVkx5SHF2cURoVFFjdisvazVCUGowVjdnTUZ3RDZjaHdLK3o0RXhK?=
 =?utf-8?B?N081Y1p6aTZoYzVoaStqQll4SmVDOVpEMEdNVzE2ZnhuUFF5TWNqbHByR1p3?=
 =?utf-8?B?OXNEaG5vRnJSSHd4aThYZkZEUDR0MlQyN3VZMEYzUC9TUk9kTWhWVHZTcC9O?=
 =?utf-8?B?WGhmbS9UcnZUa0RiRFE4K3o4ZHBJcmtDMG5xM2NPRFhpdEp4WFlHazRUZVAz?=
 =?utf-8?B?R3E3YlRVM25qNUpTZW1Bb1MrV3lqSnVjQ0kxdjRKaGsxcWRvQmRDK2VLR29S?=
 =?utf-8?B?TVhsRU5qQ3djbmRHT0xodEljS1BPM2dkVXBaV1RXc3Zjb2QxK0ZCcFM2SjhF?=
 =?utf-8?B?ckhxbFdOdEVyTWp5Q21zcDlTaCtlWldDdzlleUQ1MG1CU0pSVjlTaHJnK2hv?=
 =?utf-8?B?UnFsTVdnSTdZZVZudjRadXlDZW1iWkFXckFncWZOa3pwWE5ld2F5WUpPYXZH?=
 =?utf-8?B?RXJTbVFCM0pTRi9zQUpGRytDZDMxL1YyOVorWStibHZybFVTY1J5b3dMMy92?=
 =?utf-8?B?NFp4SlJ5WGFuUFY1a3NCTkdVMU9mdE1HSWVhemNMbGpNTHkzOFpuR01sNzk4?=
 =?utf-8?B?UG5mY0FlalFiVUZTVCtOcG90N1pQNDAzVnEvY0pMdExJc3Y4SVJQUGtYTGsw?=
 =?utf-8?B?MFZObTVrRVJMKy9DdkhrV1c3RFpJRW1YaS9MZDBrZ3Fxb0tvanhWdERYeWgy?=
 =?utf-8?B?ZG5GR3Q4aklkQWpRbWhvejA1c2tUNVg4MlAxWXNiMG1pV3plQ0d6SXFvaXdx?=
 =?utf-8?B?OXpJam9WQVViNXZYR2tYcGFWd2NoSDlaVGZhWlZNRGo4Ty9qUHo2UEFwRnRQ?=
 =?utf-8?B?SE5JMlJjUGQrYjJqYTROL3p0cmMrSmlDUm4vWGdiVlpOckRMWHZnZFQ0V0dM?=
 =?utf-8?B?L2NzSzIyY2dqaWwxdXJsQ1dnSkg3L0ZZSldrcDMrV3VwcVJaaHQ1dzhLajFR?=
 =?utf-8?B?RUtSY01NTlF4eEw4SEVjNXAzVXFvcUJOWUVQYXhxVFdyWlRaRW1BNW9WZmhv?=
 =?utf-8?B?R25EQmZra0c0YWNqUndqQ3Btby81QzJBdzJMcnc5bk0yeDZ4aDMrMVhMNERZ?=
 =?utf-8?B?NlpzRG9VOTRHVzMzbjVXRndVcXlYNm95SGlFaDNld3ZUa0oyb25SOVZOKzFp?=
 =?utf-8?B?MkV0QUtrbXArNGFNbjhLS1R5OWJUNTdHWUVjQmowVnRidE5vVWp0VzFvSldx?=
 =?utf-8?B?WmNXN1p3ZHhCKzc3czFCMXBxV2g1c1dyazd3d05WMGNmVlJWY3NlNlpnZ3J4?=
 =?utf-8?B?UHZEVkpZdEJwdnNmQkxrRlRTRWxuWXBKNEZsekJkSEF4NzU1UExERXg2SlU5?=
 =?utf-8?B?VE1TaUZrSjFYaWQvLzVnbSs3VFU4TXBFcnVjN01YRWRLV2tUMlJsTmJOU3d3?=
 =?utf-8?B?YUU2bk55aTNGSEdJb3AyTlR0Zmx2bytBUVBGQVNPUkFjcHA4N0J2RkgxOUNX?=
 =?utf-8?B?c3RYQjcwY1FOcDRZL3lZMk1ubjZOcXI4ODQxaW5xbEs0Qzd1ZlJHUmdpTlVv?=
 =?utf-8?B?ZGVOUDdIaWZUV05vdzQ3R1BBQnhnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3R1Q3k+AdREnAfEcoj3CmgFMW5p9gNUq5JrEVqeu8qP1NxOr91XFUqZhCj1DkGdaDMyhqt+z4ml+ST8J9dRIAo8p/dXwruDx/IYZgLG3MfwQvEcXtr2xPEw4X8bRiWq741VgpqK4jfj5nzQD87pKchTIllpWFGzAuNbTASvAQAuexeCK4VuluxNZ/j4du9mBc8cupsOOAdO7fjXAb/4bcy/T8Qqy3Zrg/VxzymmW/t+jUqWfArM0Xxb7PRartPqioxcKsUm6/78SShDCcMRoa5KzderCU3I9HFCKKg5gCEvJYrynz0BiRjNaqc/G2YmXPfbxyxioHY+y8xFDROTpoQiMTn5uyf3xFeBx85vG8cvX+RFR5y/ihZYqwcuNc16YGdam5mOD0OPiHAv3vyHU47bVWbwRA9NTVue2LAGKjwRTeQympdzdYyQ8RFV0YMHR4cQzCVFHF737/WJF+rhm2uDn8JCN/NajrYiBdHSylfd+m3G4OmwapaIWOB98p8CbnH3TuFfaIQ19aaVa0N2fHsviThSdI8xOO8FSuS3xbo5yROLkp081+ftzTtRM8ouEeMbm1PulirQ2WYItVBYlarQHdrc+VgW3Fui/HXhVFhQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a043e5-3a09-49c0-6066-08ddd3381c0f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 09:20:10.2421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLPpKA7fKn85i+mjaMbCdaEtk7Q6+rbR5uOva2ZCsZyws1TbhJhXxItvW1iAe5rGPdPJ70C2tRXrTKaSWugXBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508040050
X-Proofpoint-ORIG-GUID: Bd37RR2nhuxmiT7rL51U9DqdXi-fZjX_
X-Authority-Analysis: v=2.4 cv=HY4UTjE8 c=1 sm=1 tr=0 ts=68907b4d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=h0s0oI24q0HVhJ_b:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=A2GJO4T-2GDPCS6sBdUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13596
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA1MCBTYWx0ZWRfX4KtNO9HDpouE
 rEdrdS+gY2+SOSdF6co+UbnH2pfjCI356JPBxANAxTFiI4DTVW3Sn547exqyyV9gxhr7LrhnQhJ
 KxQ/DV74Oe1JyMwohv0auzntZuF6tv4Wl9sAjSHplLM1GeB/l8932mA0Apw5V2YoPiL2g5YbJfq
 cN5YY2OU+N87cK3kgOfdNKqiBs3NL1GsMqK1EownLnhLgXkqSsDCz6iKOXKUPA7SsCrzGEr+nfu
 xU7pvuMwz2zegmndA4D00XTjGGHKc0ui7xWKfTidcAtJkaELIpPD+gHbYH+3t3+i9hL211ZZ6Ss
 88VVSKGTXn1+8clTeraM2H3+dEhfzBBzSQPHS7CmfpLajzkAeFdl2qXwZxvd+Z6iRzYfuZFrVkp
 s8f+IEg43br8tDtxsvxevfA7kyaRM+cng+9+ggi6spAs8FFypwmmSfdGy9690pe8vU7sTO0k
X-Proofpoint-GUID: Bd37RR2nhuxmiT7rL51U9DqdXi-fZjX_



On 4/8/25 16:24, Qu Wenruo wrote:
> 
> 
> 在 2025/8/4 17:09, Anand Jain 写道:
>>
>>
>> On 3/8/25 07:35, Qu Wenruo wrote:
>>>
>>>
>>> 在 2025/8/2 16:41, Qu Wenruo 写道:
>>>> Hi,
>>>>
>>>> There is the test case misc/046 from btrfs-progs, that the same seed 
>>>> device is mounted multiple times while a sprouted fs already being 
>>>> mounted.
>>>>
>>>> However after kernel commit e04bf5d6da76 ("btrfs: restrict writes to 
>>>> opened btrfs devices"), every device can only be opened once.
>>>>
>>>> Thus the same read-only seed device can not be mounted multiple 
>>>> times anymore.
>>>>
>>>> I'm wondering what is the proper way to handle it.
>>>>
>>>> Should we revert the patch and lose the extra protection, or change 
>>>> the docs to drop the "seed multiple filesystems, at the same time" 
>>>> part?
>>>
>>> BTW, reverting will not be that simple anymore.
>>>
>>> The problem is we're now using unique blk dev holder (super block) 
>>> for each filesystem.
>>>
>>> Thus each block device can not have two different super blocks.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Personally speaking, I'd prefer the latter solution for the sake of 
>>>> safety (no one can write our block devices when it's mounted).
>>
>>
>> This is expected to work- it's a key feature.
>> ------------
>> $ mount /dev/sda /btrfs
>> mount: /btrfs: WARNING: source write-protected, mounted read-only.
>> $ btrfs dev add -f /dev/sdb /btrfs
>> $ mount -o remount,rw /btrfs
>>
>>
>> $ mount /dev/sda /btrfs1
>> mount: /btrfs1: /dev/sda already mounted or mount point busy.
>>         dmesg(1) may have more information after failed mount system 
>> call.
>>
>> [130903.161395] BTRFS error: failed to open device for path /dev/sda 
>> with flags 0x23: -16
>>
>> $ mount -o ro /dev/sda /btrfs1
>> mount: /btrfs1: /dev/sda already mounted or mount point busy.
>>         dmesg(1) may have more information after failed mount system 
>> call.
>>
>> [130943.678745] BTRFS error: failed to open device for path /dev/sda 
>> with flags 0x21: -16
>> ------------
>>
>>
>> One workaround is to mount all devices first, then add the sprout.
>> But that's not practical, as the full list of mount points may not be 
>> known ahead of time.
>>
>> ------------
>> $ mount /dev/sda /btrfs
>> mount: /btrfs: WARNING: source write-protected, mounted read-only.
>> $ mount /dev/sda /btrfs1
>> mount: /btrfs1: WARNING: source write-protected, mounted read-only.
>> $ btrfs dev add -f /dev/sdb /btrfs
>> $ mount -o remount,rw /btrfs
>> $ btrfs dev add -f /dev/sdc /btrfs1
>> $ mount -o remount,rw /btrfs1
>> ---------------
>>
>>
>> BLK_OPEN_RESTRICT_WRITES appears to apply per block device or possibly
>> per FSID (I'm not sure).?
> 
> That's one factor, but not all.
> 
> The problem is the new block dev holder. One can only open the bdev 
> multiple times if the new holder is the same as the existing one.
> 
> Now since the block device will have a super block as the holder, it 
> means it's impossible to have one block device belonging to two or more 
> different filesystems.
> 
>>
>> Since seed devices are read-only, a second read-only mount should have
>> been allowed.!!
> 
> I'd say the original design is too naive, allowing all mounted btrfs 
> devices to share the same holder (fs type, which is never a common thing).
> 
> Previously we do not even properly implement all the device event 
> handler, but now consider a situation, that the block device is going to 
> be frozen.
> 
> Now which filesystem should be frozen?
> 
>>
>> After sprouting (device add), the FSID changes.
>> Looks like we need to inform the VFS of this update (guessing)?
>>
>> Will work on a fix, appreciate the report.
> 
> Good luck, a good fix won't come up so easily.
> 
>>
>> Thanks.
>>
>> PS:
>> I remember this (some other aswell) patch on the mailing list,
>> it went in pretty quickly (3 days).
>> I couldn’t keep up with the pace. I suggest 2 weeks sock time.
> 
> The problem is not the new patches breaking the behavior, but the old 
> behavior is never solid.
> 
> Let me be clear again, there is no fs except btrfs, allowing a block 
> device belonging two different mounted fs.
> 
> We're abusing the block device holder, and just never realize it.
> 
> Now it's time for us to do the choice, continue the abuse and never act 
> like a normal fs, or accept the behavior change and become a more normal 
> fs.


Thanks for the comments.
Our seed block device use-case doesn’t fall under the kind of risk that
BLK_OPEN_RESTRICT_WRITES is meant to guard against—it’s not a typical
multi-FS RW setup. Seed devices are readonly, so it might be reasonable
to handle this at the block layer—or maybe it’s not feasible.

We did have another commit reverted recently. A two-week soak time
sounds fair to me.

Thanks, Anand

