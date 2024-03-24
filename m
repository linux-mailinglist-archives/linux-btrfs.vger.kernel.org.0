Return-Path: <linux-btrfs+bounces-3520-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6976887C08
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Mar 2024 09:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE30A1C20B8C
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Mar 2024 08:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C99E15E97;
	Sun, 24 Mar 2024 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AsHaD9Ms";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uVmRbzJf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED337465;
	Sun, 24 Mar 2024 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711270234; cv=fail; b=D4Uh92ypxTfY8KiJPTgzFpvbQuKdO+pvw9XcFVec+rpwCao35IY+NPMFO91JGxKYorHAachUcO5gO2QDsKLfpvW0bLVjShWZL0vnYe289StKR/raHqNDM/iJ5JEXKNAtCXmlj0hV9EQANt6RpqNyMUgjDPAUbtDQAQJMsyETZWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711270234; c=relaxed/simple;
	bh=R0UxrY/i86rSWR/SN9/AGGwTWHXdboc8wcr5iGarCLI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ffsVvXv8nFEiVBP74z9we/82xljL9OueoFvqNEvDcXHp5fvyC+Rds3xoituiI5CoggoWgstKmQfhvg+4w93J+P4QJwFvMRnbT+R8515JlgztUz2PGRTaeItc4b/FunFKj/L8OxgtRF5LD+BdLi7zj2paV3k4g2vc9JiCHnhFt6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AsHaD9Ms; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uVmRbzJf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42O5XVxV015966;
	Sun, 24 Mar 2024 08:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=0S+km8c38HgIZqTjiAyDMufHHtuWgRG9XNGPsFXOq+g=;
 b=AsHaD9Ms9qXm4tYl8HSLoqKJTwnyryVvRLJYJjjrXS1DcarJa7swuHSgk0eEgC0GboFf
 +a9/wb1UsHpL98aCs5GtsCk5w6uSzTgiCAj/rB+NPwhY0/K5Xk61drAO/Qbo8hYACiuF
 Et9PKky23c/bFydKYhUtVRgHWRiiWuJPfDJdGbmAPuycq3ktEMDaa8ZdGzjhWZToMc/N
 NnDPv9X9snnV+h64D568fPbLWLFPFR5bZo+NLfPIBSDkiV85fmuc28GAkRT3wdJmb4aN
 0wUlnswtcyemXoGXAv0blCBkgUj3VsiWYbpcHh/Fvs5JO9OKUq6UTWHkkWX5/c/k1hP8 Rw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1pybh35h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Mar 2024 08:50:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42O8gt7D039879;
	Sun, 24 Mar 2024 08:49:57 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh4eg9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Mar 2024 08:49:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqsgZJiazKhbvKsMasMYl2Pz5xkx36iP89btKoT+slK2OlcDacDaZ0e4DjtQfGuWmUTgYLAJbw9pa7ssHQfPxY0dwR+nzUG8ZQVGv79FyS7P+F2rb3+Rc3SiXyLIYnteQOYMtPx3mfiYv48EnfM84Lbkjzc4NNOtUxH697JAqhmJDT8gi5n/mn0vU5Vk40d6PSh59eTB6c6y/mznMtfKz9mTziejUArGtuRG/J1e3nEctF2MFTpYk0PiU06kyw8Btk/IzxjbvtmJdYg2uFLUo1tbh3TSceiQNm2Ju5CPi/tFvF+Drl2uB/3k6LxgNazHHYAF/p9nAUfdqVgx30dxmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0S+km8c38HgIZqTjiAyDMufHHtuWgRG9XNGPsFXOq+g=;
 b=O0/2xEbYIIy5Mx9Mfjux2BUl6FgmIVQqCFHDg9ZVDiQa2Grd5YTT2mNNOBe8kI++UJmAs50Wps0b683uRqousX/roNdYEN6wDkwuhow3+MWpBZnVHY1veijJ/z7AGl9PNnh/5smCLt4OhvKTlUXKDmDuUq5UnsFSTeatJAWUdZ438yMHxnT1WRL1KLbsys9c5J0BHLKQS5xoysS1IRwnlYeWv1e3lhAnyYCWnEKD58ZdA6Z0bHwJxmUsfwDThVcFWZBoYaPJ6uoGoX9UwNe1nHYRd881kH3aP2aKlIHF8NirT0lLaiH3Omou46tsnrABYN/Kemsu6SZzDk+MeTpbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S+km8c38HgIZqTjiAyDMufHHtuWgRG9XNGPsFXOq+g=;
 b=uVmRbzJfohS6RwG0VuZRRMoUiFQwmdSr9CbrdEWVYOKhMOgcaoLEpF1/mTNxCBoo6FHyN5SwfNHz8rAi2brEI33HAb3EpKOWu0RNpLRYVH36EzsLBVH0Jd2ZA8jI2EAmNY0lbXeJEsoBqItscu46jMcwpd1kS7WrKRtrav+f6nc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4774.namprd10.prod.outlook.com (2603:10b6:510:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.28; Sun, 24 Mar
 2024 08:49:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.028; Sun, 24 Mar 2024
 08:49:55 +0000
Message-ID: <2633fb86-45ca-4f61-a5f8-3746279d790a@oracle.com>
Date: Sun, 24 Mar 2024 14:19:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] generic: test mount fails on physical device with
 configured dm volume
From: Anand Jain <anand.jain@oracle.com>
To: zlang@redhat.com, fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <cover.1710599671.git.anand.jain@oracle.com>
 <1b07e16433faa5c149d2f6c0693fbcc656561aad.1710599671.git.anand.jain@oracle.com>
Content-Language: en-US
In-Reply-To: <1b07e16433faa5c149d2f6c0693fbcc656561aad.1710599671.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4774:EE_
X-MS-Office365-Filtering-Correlation-Id: c6229878-b186-43f6-2628-08dc4bdf606d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Un+IAlZF4dFulA4YPq4qun6QoRoWsAQmgEo/wSyq1gawsiuBnGXwQT+i9SMvt8Y77+Sw/5f1odHmpw/CzzSH0ncjzhQBG3jXzxr2bTlxluTqiiPth9oXXPRJAzHYdbqxcfhTvvUHdjrPgLIeNBdDloMY5ii9JL0+4UseJg2Z9VdTEftiec0hq07bQTFk1emfIQrR4c7vyt/HPYI/gIkYfGCzqUdFoOjhJKk+/6ZYNE6xT/oJwXr91gITYIGS30g8sxfyBaoQuV3UdjXyfiSjbHEZqjtDEv2iJCJbiSGIDJ7RDP/aVDFaFkGbXxbggD/HhJm6KqRFfbqBpbnj+ZRvOlhDqrzZIZQBKUfg45O8/vZhrCP/uCRAtsxT14B19i5BxONGB0231LD0thWnuh5G9dGdr9NUNsSv0C4UU0moG9NtNhpRygZ6MLm2vKytCg6SDL7cr5xv8Me6qY17kpZxaxsFSf+D30m6wVdkpWUkhaFOJksxCeFM0yEyOix45auy8Rxyd13M0/Ad41GNp9XahqbAAZl6e6CaPAAvr4UPmBrlGPgmbTZcuWk54SvNsnkOlqoPnIszQR1YzczTNFekoVFtQQMYP3jAJf8iCoLzd0Rqecv93B/pyp9PtTSVRPR/K8zSYo5Benv3//Scc+IsZmyFy+eIVZPWlcq5ItDhris=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VlgxOTNsVXJPTGR4WVU2Qm1aVnpPZE5IVnh4dnFOWkpUTGlVQmxsekVkbWU4?=
 =?utf-8?B?WnRCMlc2dzdIeDNBbGFhbkVZaElqNElNYXNaYXp2aHpDVlJVU3VzcWVPM2FD?=
 =?utf-8?B?UHIzMzFkOFN6UlpvMVEvVUx4WjNCNmlWVzQwNkUzTHd2OEtXWjk1akhCL3Ex?=
 =?utf-8?B?amt6MCt5N3Q1ckZESU02RnRRdDRrcy8yRE9nMXlOa1c5TnNENEIxb3hRd0tu?=
 =?utf-8?B?SXRuRncrYkozN0hYYWVrRGJtS2pyMlpTWnprRkRqQTFBME9oYnpyU2J1L1B1?=
 =?utf-8?B?ek5DRUZkMGhzbGZsb3NTOERUM0tPRFRmcCtRMG51aDFaVVVKRjI4OFVwWENh?=
 =?utf-8?B?UDFiekxXWGF3WU8zVEhrU0pYQkV2eGNlUnY3d08rcXZIZEJIcWppak96dlVB?=
 =?utf-8?B?ZlZMb3NPRW8yQ2tTYjFpa2hXSlAva0VaUmRhMjNCNmxWTVJ2ck9jQVdzbURk?=
 =?utf-8?B?QmNxb3VVOWdOaFczdGRmR25QM3o4Mk4xRThZRk1iNGNva1lrQ29kakxjS3FE?=
 =?utf-8?B?UFQ5YUI0WjZrWXJwdEk2K20waU85eTBSOXE1NnYxOU1nYmF4ZjlrRVFGZHh3?=
 =?utf-8?B?cWRYbGZDT3ZYbEo0SVJ4Z2oza3pBVXpjMXZSSkFJNWdlSTBmRVRLSTlNZEJB?=
 =?utf-8?B?VFJPbzhFM3VZbEhkYXBpVWJxWnVRUXovcGVxaTMyak9xQWtwR21ENjhpTVZY?=
 =?utf-8?B?dzRqZWs2ZHNMakR4TjlFUitxc0JwSDE3UzNNNCtiNkhwWEJMSFlPT3Z1WDdn?=
 =?utf-8?B?NlpyL0M0NkNLSnJPT2I1ZndqbTJCbUFNMW91ZitIalB2WFhmWHB2VzlsQ2tm?=
 =?utf-8?B?alppVENzbnJWMitlVldVYUhsWkxoaTJjQVNtSUZJcHVkSjNiOXRwaVhBK2xD?=
 =?utf-8?B?WHlrN1lkd1hyTjZubklFZXlSczR4Ym5jU3pkTzlrdUp6OSsxbGlCWk9lVUJY?=
 =?utf-8?B?amEySTFqazBsOFB4MDQvZG1xZnNmZ0VkNEtvWUdhSThwajNiamtkNENxSUF0?=
 =?utf-8?B?YjdLWkdGSGNmak9aK2R2WUVGNER1VFlpb0U2TDRLVEVielNPdFdGeDBXYXA0?=
 =?utf-8?B?ZmxoNGRXNVBCS3JIdnBPUkN5YkkwVE10WFoyd1ZndDlFMFVEWVZGaC9zenoz?=
 =?utf-8?B?Nk0rVFUzL3NOaVFNWVJDKy9qbU5vUUZBREdwTm9NTEhDTVJYY1ppeXVBYjJ3?=
 =?utf-8?B?R0hyYUZ3QWxDVTNkZ3RPdTBybkY2VnFXN3FLMERFMGtqTmtIS20wL3ErY3pD?=
 =?utf-8?B?Q2tqMzhiUHNSY1E3UU1mcjFPSTNxdUVXam5aZXBJTWJKbzI3bXBkdzV5bE5E?=
 =?utf-8?B?TUJQbEhaQXZZQlh0cmFwODEzeFdoRk5rVllRS2hBU2lkTU5NeWtpWXV2bVpu?=
 =?utf-8?B?UTd0ekZXQnN6YU43aGU5T3hLRU82ZkNETnFpQ01md2NUdmlmTzlpZlhzMUxu?=
 =?utf-8?B?Q25FV1dZbEx4bTFTUmNzcVNBcDJ0VlNXcko2TURMZUZQaXZrYkZHR3NSVnFG?=
 =?utf-8?B?QjNaVmowbzBEVDFLZDR5K0VMY2NJN0hEd0JIRkpxdXNMQ1k2TDhRaWcvYW41?=
 =?utf-8?B?d1hyempjTFY2dUlHZTBMREt5VnhOZ0dsdkNmMkRwSURPNm5JTVk3STlsMXUr?=
 =?utf-8?B?aFhDNk1uK0w1RTVFRmxUZWJGOE5UWG9BZEU3dHY0UHdpUTRmQnBFWDNlTk5j?=
 =?utf-8?B?clYwR3F4S3NiOFMrQlZ3NGJKNU9Cd3B2MjliKzBMZW5XNVlWNTRhRjZSWTZv?=
 =?utf-8?B?ZnQwYUozT1hlSVVlRXM0Z2toSDRGNXNSZ2xaZWo1U29EMDNHMk1Eamw4NTJJ?=
 =?utf-8?B?Rm5PdFdQRTNISHJNOUMvTmtEU3FtRjBDZFhqZVB4Q0MrTkZZcmRTaUROYUw0?=
 =?utf-8?B?bmJ2ZU9rYkdpZ3FWU3FiZmdQYXlyY3pyT0xMMW80YXBpb1Y3M0hlazZpSE01?=
 =?utf-8?B?TVI3cGdWRjZvRTB6Y0phTUVyTTJlTGx0alB0NlNWcmFTNXY1V2R5WUxocElX?=
 =?utf-8?B?UkZ3TmNEaEFXM0ZNeWVOY2NJQXVicHFOSHBhdE94K3BKTVdCbGZ4KzNCNTk3?=
 =?utf-8?B?VDJtVDBBQW5MOGs5eU9xN2Z6WVcrZkZJT2hZTVljQWlBcUY1c3doNjF6Wk54?=
 =?utf-8?B?Zmt0ZlZoUTZrVXBKVm1XQ2xVbllaOStBMUZiUG1ySDZjSGxiNVhzMlJucTFi?=
 =?utf-8?Q?A5FgG2mTZpHeV0VEmGS17q9C2T+OP/oi0NnKFCyAYJ35?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	H3BiR5OgHCoumIvjCbJNYJvnyg58KYTSeQjDahw+zq2jih05ZROVnLvi/5ELtZFZqGDp0K5gy0jhVrrolL2GxGRE2Gr7jzsdaAxeXOi8TXz3BruoScNqqOQiA1ppxBCv28kFIW9bWR7YQMxrpK/X0yn3++XYtoc+lgN67zlyHXpiFXfMgQ5r95qBeHW/prmwjdYlpYoJqr0S86GCozk7Pn3sRUCfvf79rOgK0blR82y5UB3A1xR4eguLgSvvrOn1BGCngdEGFkgRLWUdRV+5fkswlVVPLubm0PC28KGdC5xwTRB4s/0FpZCjQmjpI3+siEUxKpguDrDoRLmq9lnFKSxxgkSuKXBCVWCfOz8zH9nd4EK/J5oxIUWTlic82JhQUq9FX1cX9jT0jMu/rfgXikZ5UJgROyyOV6Uq/uo/flpPg9USDsg1i7tIRI2rS3KJHVKaklV99sKhE6xPFukSAdQ3OuKYJlxPt1BSfIo6bVZ59coilncReH6KXcKxVHwKRnShq3YWj/j9pFMdzfladf0VWU1w1MsIbm2UsKDPB5so16RdReFLGCy3W3AA9J+HZg8l3kJ1YUAWoq5x8BChAmSuJfctjKmBPHcay+fO4YM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6229878-b186-43f6-2628-08dc4bdf606d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2024 08:49:55.0338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUqvGln7cCUGz4WMVaiTV16W8wRtrqpWgAW2lH3YUziTEcxMjx3K+fxdcQ+1ATJbQiLnNjR+aNRlRvTzRlcwVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-24_05,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403240054
X-Proofpoint-GUID: nN1F0htxWkiwNLoSAW0TH6qEr5Aef6sH
X-Proofpoint-ORIG-GUID: nN1F0htxWkiwNLoSAW0TH6qEr5Aef6sH



On 3/16/24 22:32, Anand Jain wrote:
> When a dm Flakey device is configured, (or similar dm where both physical
> and dm devices are accessible) we have access to both the physical device
> and the dm flakey device, ensure that the physical device mount fails.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> Remove redirect for rm
> Add _require_test
> Add _filter_error_mount
> Change log - make it more sound generic with a dm device
> Add quick group
> 
  Thanks for the review comments; they have been accepted in this patch.
  This patch is now applied for the upcoming PR.

Thanks, Anand

>   tests/generic/741     | 60 +++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/741.out |  3 +++
>   2 files changed, 63 insertions(+)
>   create mode 100755 tests/generic/741
>   create mode 100644 tests/generic/741.out
> 
> diff --git a/tests/generic/741 b/tests/generic/741
> new file mode 100755
> index 000000000000..f8f9a7be7619
> --- /dev/null
> +++ b/tests/generic/741
> @@ -0,0 +1,60 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 741
> +#
> +# Attempt to mount both the DM physical device and the DM flakey device.
> +# Verify the returned error message.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick volume tempfsid
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	umount $extra_mnt &> /dev/null
> +	rm -rf $extra_mnt
> +	_unmount_flakey
> +	_cleanup_flakey
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/dmflakey
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_test
> +_require_scratch
> +_require_dm_target flakey
> +
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit XXXXXXXXXXXX \
> +			"btrfs: return accurate error code on open failure"
> +
> +_scratch_mkfs >> $seqres.full
> +_init_flakey
> +_mount_flakey
> +
> +extra_mnt=$TEST_DIR/extra_mnt
> +rm -rf $extra_mnt
> +mkdir -p $extra_mnt
> +
> +# Mount must fail because the physical device has a dm created on it.
> +# Filters alter the return code of the mount.
> +_mount $SCRATCH_DEV $extra_mnt 2>&1 | \
> +			_filter_testdir_and_scratch | _filter_error_mount
> +
> +# Try again with flakey unmounted, must fail.
> +_unmount_flakey
> +_mount $SCRATCH_DEV $extra_mnt 2>&1 | \
> +			_filter_testdir_and_scratch | _filter_error_mount
> +
> +# Removing dm should make mount successful.
> +_cleanup_flakey
> +_scratch_mount
> +
> +status=0
> +exit
> diff --git a/tests/generic/741.out b/tests/generic/741.out
> new file mode 100644
> index 000000000000..b694f5fad6b8
> --- /dev/null
> +++ b/tests/generic/741.out
> @@ -0,0 +1,3 @@
> +QA output created by 741
> +mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or mount point busy
> +mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or mount point busy

