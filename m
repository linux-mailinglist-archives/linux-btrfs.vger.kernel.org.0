Return-Path: <linux-btrfs+bounces-2057-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 335CB846AB2
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 09:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9861D1F221C9
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C8718042;
	Fri,  2 Feb 2024 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FvnoG3n+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="feMwFaIY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6FA18027
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862409; cv=fail; b=CAIFIVo1B77v4Z/AAUufhtguoTkOXfk8tC1AB2Hc9WpZfZbyCtb92WrWvplhUWoW4aNwaPfS5i1GkKWPRHFgfv0gqATQ7lDvLMZ03lkILFTkxjGYoMjLEcY/Sdfc2ZbwJI+ceefLUwTt6IHsIWFnu04/bPHsFu4NvBiIWvQGYnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862409; c=relaxed/simple;
	bh=Q2hQ8rGefiiotIDMnAH7K/Gek2+RGZm1bRLVlH4GADw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lNFHrw6sz4c+BOmy5SQzWhOmANp0FQOTnmOeJLo5uvjpTI7FtY/2lIYyjOpcwSOvBVjHFriq9YsZoMYU8FEZ3LjkqGXB3cG/pqIbtRL6TzJ9Akwc7Tj6z6Bd3HeDiqKT1zhlN52Ah8M1Ia2fA0BCpmlUeaqWbBPfnvsOE3MbMFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FvnoG3n+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=feMwFaIY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4120pHLR022999;
	Fri, 2 Feb 2024 08:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8vltJtOPW3WSIhFd466tSY1JfOH+8GlArj6gXvpLgM4=;
 b=FvnoG3n+z4Rp8u9ky6YfukcQm3aV7ZJY9pckT0rwfR6fiSeN/RkVMlXhUwCBvT5dimS8
 0chIR6x3ajSLrMMWGXna/Ugyk7YO5WQRQGREomCYVgBe+yec0daP0q6XMAowgG91lKLF
 OI8D5Nrmf86jNqYhjZuUlrQS8fRRJp6otIqXmpUk6nq/cP/UV4OtPbGdnGFSHI5fU855
 GUZjutXd0ln9loDlPmiV+1LifbEMny1NbPnMUDkCifIZTawHVqxLWYaPHCEeHj8JWTMe
 +4RzY8nkHMuBsYXYUvvb2LRdVJTHwL0xaHk2nCqr5gvFvhmCinagualizi/JK5PNLisS +A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrrcq353-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 08:26:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4126c2B3036049;
	Fri, 2 Feb 2024 08:26:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9j3qn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 08:26:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiGPSwFR0aKNBbee8JPmAR9DJ9c7cvk1Zpe6ZEpuvgdtqv3Kb4BOD1ozyM2SDb0HA29dNKnoeHsJfVspPBiyPHWUPDlIlyK/JKUH87EfV9mGFq6hNGUxILQdyTCyo1b8CgKVJgB0cegTsDhT7Clx2Yk1O2M0isu2EaU2Fuz/xhmFkSkop+qM2yN0AqGgeWzVVuEzFJnpdSSV9mrDvngdCX2TAAHtU4twkqC/7PVcl9kvWkyEnuzIMSZOetAn0L1PBl9hyy+sGnT+zYH/JCJXtH8BgbZ54pWYo5XGZxhEUedDCA8Y7P3HiYaZm3udbUJ5hmudZgv6iu8SOzV/W5+yOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vltJtOPW3WSIhFd466tSY1JfOH+8GlArj6gXvpLgM4=;
 b=LhPG9liIstJ398JcIzbNjAJgB02GF8u5w/yAH5LDRMzTzbWRtsmbO2H0TG/QifNskZSJ8ag9+bsymxc3k/5S34lTcgOXm5lyKRHQuB6sUBVPpqmpx5WbOr/LYRN5ryB6AKEvWwoLPppJTd5yB2jsJ6YOvJ/F5mXRnVYqV151IOfp6excNdhdqmtRORQ8CtZ3I9Wg2sAoBTDeBfy7yFjKd8smWdF0xAmqPEKWU4WhZs55muhxMCNLUHPM+D+LLqHhLDjSS3AluinEyD0sJ3CC0DCcMIP1binRCpT4qehegKmwNfWGVn2WraQjFT9cD/ZfTJpzaqhia6MpQqfpFc1Rmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vltJtOPW3WSIhFd466tSY1JfOH+8GlArj6gXvpLgM4=;
 b=feMwFaIYlfD9IazrhSpxp7j/GALTBgqj/zWSybs0AgFsoohJQNFXsNLmovVq+kRHgr8xOl+5jjZxX5eJMjI+WwvTwJWPO4yJTFn4jsxI8s0bqnp+7hSGMSp0n/2PeO6/ZeDoVor4MfAJReB6XsUKoTZ6gDdyfRbXmucW10OjeZs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB4956.namprd10.prod.outlook.com (2603:10b6:610:c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Fri, 2 Feb
 2024 08:26:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 08:26:41 +0000
Message-ID: <b009a6c2-9117-4aa1-ba76-503741acf5eb@oracle.com>
Date: Fri, 2 Feb 2024 13:56:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use (READ_/WRITE_)ONCE for fs_devices->read_policy
Content-Language: en-US
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <ff28792692e72b0888fff775efad8178889b9756.1706858039.git.naohiro.aota@wdc.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ff28792692e72b0888fff775efad8178889b9756.1706858039.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::28) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB4956:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b6227e-a819-41cb-23b1-08dc23c8ae9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kSSq6g9aM9GaSzb1KFtJoPxFhgqbE3KRAzpVXRbXa3smWV7V9LD1lc+v/DqBrGhvKBJDBBpW3Pii5kqCwWtei7K2UfGWdewRRwpVlSYxIJpQmbEnd/Aq44ZwHLDG7b8Bs80TzRkmIr3QkTeRk538AtYeIm1j08Y4aTGzatv8Maz2WCbR4JdGLqOkpFEJjQ9fRXHINP9zITvLqfRaegpTf4Js7pdj/P7hblLNBK+44ybn5IC/pzfK2MjrMJaN6w5R8m4d8cZPPeo0S/W8sogbP35ckzuT6OrYmx1BNGT1gE+/iiVAEoZoiQDESy8LUo3pyFsB+VPNeLDAQxH9OMIwTjsih5hUCqUs6shL74iso9hvfCFFTS/iLT1b/f/JaBwvlWpExRLtVJHYut2Lho0S6LDlaWFGTQjRR3C4aJI0uDxZVViPThQDU7ygIRk71xJmRfBozs30LHJXmCwp+jGKfYUOD6s5/POHgPCw9CXifBXMDaAqDBesv00uBRYi806N9NhBYjw0OExLbZO41eBOAs2KHvzpgN/zXY+oTYVmetr56KsJWtNA2wARKa9NEuXuRxbh5k+4NkIzIeTSTeXohERFfSOEd+3E2l7zLF813GauDsOLAcmVszJQQLpbCY2hulirGjxOIfir+EUb25SnuQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(36756003)(31696002)(41300700001)(86362001)(26005)(6666004)(6506007)(44832011)(2616005)(6512007)(38100700002)(53546011)(66476007)(4744005)(6486002)(478600001)(2906002)(316002)(66946007)(66556008)(8936002)(5660300002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NERMTUJBQXpsRmZWTy80QWtLQjNrZ0FHT1lsN3V3R0RPZmJGYWZPVStuMkRN?=
 =?utf-8?B?ajVlTVRjWjNxTXVydzVuTDlrNVoyM2cvZTZ2T1ByOEhUNmFjS2ozZEpUQWc4?=
 =?utf-8?B?aHBCZkxtT0YrOGlLSlFPODZsMFQzQVZ3NmpybDh2OEl3QThqalpQVzhQZThD?=
 =?utf-8?B?YlR2UTNyaTBtL0d5dFNaVUNnOGF2VDJVeERPOW9RRUZ4N1pHakxyR21GUEFF?=
 =?utf-8?B?MkJkaitZMytYOVQyelcwejkvR3JlSWtKbTZBN1NqQTVCaU9oSlpXLzZWU3JU?=
 =?utf-8?B?OFdxWkxsbFU3NEJQKy9TbjZ1RjFPdERGdVp2bExLRzB5U3FDRUs0VllzT0lu?=
 =?utf-8?B?dTVKRDJRcEViNE9tNjdOQ3VETkN2SjBETWgrOEhHaWlXRTIwalRyN3V5UVdk?=
 =?utf-8?B?ay9RaVhvRENqVXlOcjIrK3Q2L0p4RGRTNVZMWXFPS2gvb09pVWFJc0Q2Z0dq?=
 =?utf-8?B?TUhRZndrRk5UQTRTRDBhZEdUL290TXo5cU92T2xmZk9xTUdLaFQyV1lpL3lv?=
 =?utf-8?B?N3ZQS2pHYWhGY0VGZ0ZETU44S01KeVdhOE5qTHlvR21aMEsxd1g1VW9RNHpC?=
 =?utf-8?B?a0E0Y2duVXpqRkNNY2lSRjlRU0ZyL3kxRmMyaldFeHliOFpsdzU5Rk8yQUR2?=
 =?utf-8?B?M0tnT3NBTDR6K0pqaUhFQWw5SEhTTE41cXlTaFVUZXB3eUlMekZ2QUJlU0Y4?=
 =?utf-8?B?YXBtM0pNNGczN1BXUjVHcDRIQzJsTzhtcGFxbDE1UzRhb29oY2JwUkkwLzF6?=
 =?utf-8?B?dGdVd0tCeWpDU1liaGZPVnc4SDRNR01MNG5abnJBQUZoWXQvNEVwSHlTVWhR?=
 =?utf-8?B?YnhYZkNHR2RwRTE0YUhyK29jOER5eGhRczM1OWdLZnprbFIxN1d5L2d0K1Ba?=
 =?utf-8?B?dkU4V1RHZithWEQxdGtHNm9rTDNxL0djV3JJWkNqakJpQm1DU2Q3U3ArcUcw?=
 =?utf-8?B?cXRwQzRjYnExaVpFc21jYWx3em5lYXhqVGk4RmVodjJyR04yajQzdGUxL0xj?=
 =?utf-8?B?bEFid2ZNd3B0TG1ZRWovNHNKbW00ZnUwd3NvU005SVF0S0ZxZ05wWUFBQ1NO?=
 =?utf-8?B?RS9iT1RZQnZwb0J0aWova1hSSkhLOHhTK2dUL05ERi9zYVRuTjlWZEh2L0RZ?=
 =?utf-8?B?R2RZVi9vUjZlemZjb1FUeWhHeGV2QkpZV3kvcDBlTGNYQWt5QXVGT2JPVDda?=
 =?utf-8?B?MlNhVTdLTzZzM0lPakE4QUhaeVNWQWFFRnFCNDM3WDhwZk9CK0tWR25DYkZ3?=
 =?utf-8?B?SkZxRXkyNCtWdTJOMHJQVmZxY2FGUGJmanBwa2RETHdlWUdkRG9MYW45QUFP?=
 =?utf-8?B?Y0p0SENWT3BmOURiOTJoa3IrUXVLdEx1UWNsUDIzeVZOSUN1TXNVVCtaSUgz?=
 =?utf-8?B?TSsxU1RJQXcrZUM5QnFGVGFqYmlxMVpmOTBvb3pGNTBwa2RTVkp4dkZhakt3?=
 =?utf-8?B?WGlJbDB6RHpvaGsrNTNaN3h1QTA1cGJ0UjZaZElyR2xuRTgvQ21YK3pJeUVO?=
 =?utf-8?B?clVuengyeklzTTU5MG5pTXh5SGFyU0xJdHh6S2RPOFI4ZFp6d29MOG42ZTRs?=
 =?utf-8?B?MFF4d1dQYlhJLzNvWlBCb1AwT2Q3d2pMUGcxVkV2a1JXblYzbmpSZmdYV01y?=
 =?utf-8?B?MjB5R2J2UjRCbHVCaktkUFBEN25aQXkzOUZ4S0Z3RVJVV29zcEZYYlNNNHZk?=
 =?utf-8?B?QlpZNWR2TmlYYzhuZkxaZkNnem5YYk54aktZSFNJUE9DT1VXRWRFR2x0TGxz?=
 =?utf-8?B?dTNmLzNCTEVRam1Sb2NwNUJiQ2ZJNDVtbUszNGI1WnBDRFFTSGswV3RUWXpi?=
 =?utf-8?B?bjJrMmtKanNSdGNuYnhONVRLQkxUaVFNZmtrQmFRSWo1MGdraU82OUExOFdG?=
 =?utf-8?B?MUMvVWNFOTZBcTllZGg4dmNoRHBlU2o3S0wxNGxVQkNJdmdYaEU5blZnTjB4?=
 =?utf-8?B?OFQ2SnpiVWVFMit5bWZTbXNVY2Z1djZzSURQZTZwUVl6OGdiRU5qRFZPSmtp?=
 =?utf-8?B?aW84OE83Rk9zLy84V2twL0NUKzIwNHVsZmZIOWRyL1p6L1Q5cnBkVmpPQURt?=
 =?utf-8?B?cE0zcmxTYVhiVW9MYmpkT1lYbmEycGY0S25KbkNJT29aOU56U0ExekM5dWhu?=
 =?utf-8?Q?+y9U9uGSB9fmyic+qICVMGnjv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	J/iAwgGusyzXeTkeiTi4u1ROBtJo19MKvXP0vdYZcO8uPWEIFWiMddmtB2WB0AvAadXA43ORscnG36iA7mnI+36y82w8YHkxREo7Th0HBEPOnZm+W0487xnaUDsDDiEFRoljVfRW49dHKMZtJAEV7fKRoN1ok6uIqVcq6tolqeH7ZZemEnVqCXpdGztXrlkWdkD+SFgu4qGLGzD+pzWpRWrDtpwIMEOifKH7phy6qCDndF7gFvF0vhxvqOGhkwpT0lsbezb0yo+oJgbwl+5mmrKANkQg0jCvE7ZKp7F/Cuh/L9E54DnZIgtBqGRVjNn7LIhIwo/Xf6lOgjZezBR5303YJWtl1TtzP9i5PFlT7zRWEQkeLcp+alNUwPqfaNn5LWB9YnGls8klUv17m1dozXDGxLKijC+yaxpnBSPAUpsw7r58NJyx9wTDO7+YtJFhVtBOTZSqcgsFQzHi/Ds2FfdnDOGNcE54xjBe71MZQGchLLWb+YzIOE3sRkeUdVL+pAr8iN/mINcEQLumyeg+uR+SKmK3FmZT7xMu68qAQ2OVZOHj4bF9kEsQs4AVYQZM4tAWB+KbhmaiUY+fmphXcT+uaiYpNfdWg3asCvHUJas=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b6227e-a819-41cb-23b1-08dc23c8ae9f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 08:26:41.5347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwlgPOGk7THDzMvK1b7MW0Ll2rUZIt6JFaNIZH46rBdJHL1wU/UQWMoTiXqjP3NrRfSXNspK9XFwDrjCKuO8mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4956
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020060
X-Proofpoint-ORIG-GUID: hQ8IY3fCrF81J_AIh7wjm6Vku0EcCPd6
X-Proofpoint-GUID: hQ8IY3fCrF81J_AIh7wjm6Vku0EcCPd6

On 2/2/24 12:44, Naohiro Aota wrote:
> Since we can read/modify the value from the sysfs interface concurrently,
> it would be better to protect it from compiler optimizations.
> 
> Currently, there is only one read policy BTRFS_READ_POLICY_PID available,
> so no actual problem can happen now. This is a preparation for the future
> expansion.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx.


