Return-Path: <linux-btrfs+bounces-115-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B755F7EA794
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 01:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6D51C20A11
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 00:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EA9BA31;
	Tue, 14 Nov 2023 00:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hr4ZKs8Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OHjBEbFq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B191A8F43
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Nov 2023 00:38:52 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480F9D53
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Nov 2023 16:38:51 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADNsK15001232;
	Tue, 14 Nov 2023 00:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=JqFFm0qjChHe4fHP+9sHe4EkAFBke+0wvK4pkafoYfA=;
 b=Hr4ZKs8QaySYLjz03/IBTvqg0mRqnSaW10gh0Rrlecw3gB5XwH8RNsp/s4rU7FY0vLUm
 QLu0inHSB1NyutPnlJ+7ILJLQex56RxRBa7tJ6nlH1EcjC0UUm0DlaxrKXbzC1TCA1Rf
 bzLqapW8esQmrEKQ9vjp5v5RWWMuf0k5vmUNRZLHp1dILNbhP2yCAvsWf296EVcrrB0u
 pFkHbAUFxi5sO5Sy4U595UIGu+p18zq9wCQ0edywgZzMnLf7TrB0RSXX0rjjIfRVXXCM
 tnngT8Vc63cVU5Tr4IeBYz/g0SBHuuEXmizDBEwd1iff6sYq7IiJpihAEkmh7GosUfkB lA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qd42s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 00:38:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE0DFFN004588;
	Tue, 14 Nov 2023 00:38:43 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ub5k2gbtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 00:38:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3zJNHz1zPnfE4+Uy07Ate1gIVpGwQ4D/bn5bSs0TX0NFfgypHc7hvTD7w0yewVqNLcfUtm9DBRMD5gDIMpUyKaIi2fvA0VjHbFbPw0DnN1bOx6OBXO75fE83RyWD1bqlMfVCFhk7IIBpBU5w5ZQuWqAZTPP3ilHQ620o72aD1p4GIINoGJsEZ3VhgF3ufeVIvKX+nf8/rp1Rio15SmpjeKUNQ71hM91Y7BCUZJq8EvgO3nAJwOPrpI1TbCXtv/sf1AowgCxpRkaEVMR69gYB6adxaJef5cVtkJ2+Gw4CMWF+Wn1IgGv1q6ERb+3usXWHlOaQ2ddNXVAUPMU2CISNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqFFm0qjChHe4fHP+9sHe4EkAFBke+0wvK4pkafoYfA=;
 b=ispvEzsfkJhVH9b1SsLueyznM/vAL2AwiA6DtZUNn5oeZ4bjETUctiQF9aj0jrCLEjMmG92mtfHHByuvIvMKfxng55iJkS1zazNV41vKUEAzYOZqZt1mkvPbfv6URZ8dgcJMq0FZJ1sEo/QFU0h6SoIL8siljIgDYPXEgC5Sdfi4aIuAp9jiGFggOsZ3M/gu1+MpbwrNlEl5G+wRiGLjB9myrjn2Z5OhC6blHe/PEIcKxtq1uBnp5VqsW8/JtYxLXdY9mrh/JRjPNWyTCjyZN4dvvN4Ixg1jRDbMb8ekE2N5niJWgPn5HzGaakwisr2XV2J0dGlvJ+a/cIQKW8F2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqFFm0qjChHe4fHP+9sHe4EkAFBke+0wvK4pkafoYfA=;
 b=OHjBEbFqISt+/JlL1dKmhPhthVMT7L8Hux6AsKbhtKau2MnHtapVK8NFTt6CLmClcQbGTDAKj1JwBHeXuvqE/DZXnrX4UVUOBwvOzL3nXRLc5J+zNwlLArds/VvM2U0dqWV/7AgNHP94CxT6yXj46YVLPkWbJMt0Sig4aKpBhQA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW6PR10MB7637.namprd10.prod.outlook.com (2603:10b6:303:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 00:38:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::50e0:d39c:37b5:27c1]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::50e0:d39c:37b5:27c1%4]) with mapi id 15.20.6977.019; Tue, 14 Nov 2023
 00:38:41 +0000
Message-ID: <bfe5ce35-1bbf-4eb9-982d-30d52bec90fe@oracle.com>
Date: Tue, 14 Nov 2023 08:38:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add dmesg output when mounting and unmounting
To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <215e7eea95459d1b0cc4fd9ce522dc7c8f5d4e02.1698873846.git.wqu@suse.com>
 <20231113174502.GX11264@twin.jikos.cz>
 <83b7280d-6396-45c2-aa5e-fcd1f6f44963@gmx.com>
 <20231113210933.GY11264@twin.jikos.cz>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231113210933.GY11264@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW6PR10MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6afb63-042a-47da-d871-08dbe4aa0c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jOOBBE9dFWIIu4QfVSNvdVBnnbh4Vd+sYH+6YaUN2YoVjvDvub1oBeVHfkugPCeLsMuvG9FEsdsfDdPGjmKbbJ5udyZl4683v9woHYHzlq9WcqjWn+55dRqnUlVnMDPkkjUlPViMn4bo+xKU44mIiuvu6fNubqIQagO4rbS3IQQ7e0osrZ23RsWwJ/OV0nk8s0tBNKej7FwnqmQ2r+OaS3wDINDKBp2axmU8AUpQ8TGd8ds0XGCHYsFDOkgMg6WBLl2WkNijtu1p2vrdXMM2f61wK9Q6dKPuq5xGSRxTHf8Luai21qkAxCIJSARG1d1wY6Av8/V1xpYFSFP2B0B4KUzx66hVMovlwvIs4b4egeu2IyfAF1Xr2yTuzWvkfnW30QbgIhuwrSXArnLmTGAh5ShNenXlkZqq3X+7dR1n0TFetn8ZOxNtBuEd/HbppdVJDCR4n6701B3kl/wTDpZ6jYNQdQWsXbHx/28zA4fH3T4StZWmTJVgiRhuukmmARX7dz+TW43FvB2MyoRxozF8zxSL86MMQiq94R/oMzUQs2NKyfV8eHkkDAcZkJhS79nf9UuXONt0HZP2c0RO48zwOeHUtTwJdwKWSN+yH5Nd9vAaMancv2/ZxMJvlmx4hu4Mtp69YNZPotQWgI7GbGLGTw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(19618925003)(44832011)(31696002)(8676002)(4270600006)(4326008)(8936002)(558084003)(26005)(2906002)(5660300002)(2616005)(86362001)(6506007)(6486002)(6666004)(36756003)(478600001)(41300700001)(31686004)(38100700002)(316002)(6916009)(66476007)(66946007)(66556008)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L2VqcmY2ZlZIVlNYNWpxQ2hoQ1AwVWRDTGZaOTNEZ3dYQzFtVlR1OGRHWEVo?=
 =?utf-8?B?L2o3VGcweHJaVmJmWWdrUnNnWTB0d3JNZG9TTWU3YVhzNm5OSWhsYlpTcVBG?=
 =?utf-8?B?a0Y3UmtSbElTc3dEd3BLaFp2U2l6Z3c4RzA0bjJkV3R5OGRpN2pMekNPL2Nk?=
 =?utf-8?B?UjVoNUJzWGY3N2N1eDdPVmFDMmZ1TjdpSkVBeTlqbDJlQUMrRXVpVkc4WWxV?=
 =?utf-8?B?dXNQRDdWQWJPMEVKNVlhK293WSt0S3ErUGk4VW4yT3FQM1hLOTd2RVpIRFNJ?=
 =?utf-8?B?MDRUNUxHb0l6YlFKUU9pdlZwVUJiSlo3VHdXR1EwMjVtcHA3dnNyN0hYNjdX?=
 =?utf-8?B?Ui9rMnpheGJpYjFUVUhwNWRTT1hsYW1nbGJ2aVFURUdISVBLc0hDZjNOcHh0?=
 =?utf-8?B?L21lVWpDOURVTTZ6MEpqMEJRSXhuQW9iZGNWWEJRSlVGdTBSKzUyT0dSdmhZ?=
 =?utf-8?B?SW1rOC9pbjFpWTRMeHRzckszdjJOckFuV0Q2MXNoRndyVlVYT0wvckxqdVM4?=
 =?utf-8?B?dnhlZ1pZUW0ydmFuUmoxakp0QzUvb09nNlUvQ0x4ZnBOeXJFbnBhQ0xaOE5l?=
 =?utf-8?B?amZkTHR3MnUxNkc0WXZKMUZxb3IwMzBjU0UrSnJ1b1RnS0Zyd1h6SGhYcXNR?=
 =?utf-8?B?UzBGcU1vOTE4d3FGVWFObDFzS253SGl6T3d1NldmcE5GZ2txNjZ6RnFlN09N?=
 =?utf-8?B?ajcwQm5OWFdqWTI5ajdpQnpXQkFld3B4Vjg2elo1RDNMd1hYOWRBR2ZEbHUy?=
 =?utf-8?B?WVRxVTd5QVB4QXMwZUx5OCtMeVJFZUs3UGRFOHVsMlJYOG5XYnpSaDkxUVlx?=
 =?utf-8?B?WVJsdHIwSjA3SVdqaDlkSnNKbzZoOGhqbS9jd2ptTXpOM1R6YThEUjhMY1NG?=
 =?utf-8?B?YzJXZVM0Wi9PVTgxUTFjTXV0TGtQSHh6UkxWYzMxVDNFNzVyeThRTVRHMlRh?=
 =?utf-8?B?enJaYU1EN3RsNndtNitXV3cwRlFCMjBhTnZPbG45cU9PN1V3Q1J5WEVsejBI?=
 =?utf-8?B?eUhWRTl5enBOR0FLRkRPZ0t1TFlyVWI0cmQ3Y09DcUxOUFk5U2FjOG5CUCtM?=
 =?utf-8?B?M0lUWk5uVjVtQmRQb3hscTVqL2pKOFAydnRpWkY5MEYzTjllTk1jTTFlN3Z2?=
 =?utf-8?B?cURyT0hXU0pEclNUTitJNlBMR0VEdjgrK0hzK29JcEdvNk5Od1JWWnBZZU5a?=
 =?utf-8?B?ZStrZUthbkxUWm81NFI4dFBQMHRpZ1FYaExuK0hNdElQSnFubUFpNkx2dmNt?=
 =?utf-8?B?U0h0cXl6VUcrMDVGR24wbkhTSlNuaThSTlNEYVcvN0NDRExLSTFoT214YUpy?=
 =?utf-8?B?YlJVbjl2R1lMaHBENjhWcTlyaS9TOHNtYUZHaUJGaE1sTW9PMzQyQjRwaWtP?=
 =?utf-8?B?VXc4bDg3UDE5eVdaaFpPbXZOSlFiSlNZMFJsWVVjTWtkNzdSL2VoY1JGRWUx?=
 =?utf-8?B?dG5INWJDb2lscHlNYkpLTmxSUW1wZW5neTEwSWR3WUJBZzFjeUpEcFpsdEZO?=
 =?utf-8?B?NHJTQ3J1UjBLamVKU01FUm5VMkpjNm93MGN5YzZNMVAyMUFqRXlFYTJ2TnJH?=
 =?utf-8?B?cHJ0VnZXd1p2VEZ6Wk4xd2hhN25XODBjK2c4ZW1XOVkwU0VyNUtPa2VPcmhv?=
 =?utf-8?B?Ui9pQ09xNFMwMkFkamhMQkp3dzF4VWZ2a1VwVGpPb050NFlnNXQzMzZ4aGFo?=
 =?utf-8?B?V3JPOVFEYkcrNjJ5Q05KSnVkM2lmMlBGTnNSMzFBNEZJTnp5YUZFdStkMWFw?=
 =?utf-8?B?aUVaT2x5ZjE1OEFHNTZpdDEwaHhNekM2VEJrb1g1QXd0MzdPS3RMbDRObm4y?=
 =?utf-8?B?TWxPSmJaZ001YTZvVlpwbWlMWVVlbW9HVGNSOG01OE84OU5RSHpMbksvQ216?=
 =?utf-8?B?eGpwQjFzVWVYcC8vbFF4OThxM2RBbHo2WUxoL3FXeGZOaHd0V2RuZUFoMFpP?=
 =?utf-8?B?RkFhZVM2OXJLT2lhdGNWUkU4UFA2Y3hnSWQrVVl6WWpoUHdsY2ZrUjRYU3Vr?=
 =?utf-8?B?UjVNSkJNUEpyYTVqUlU5b2tabE80a1JtQkhZT3BtUk9JRXBvU2NORDRxRGdU?=
 =?utf-8?B?UzhxVHROdHhpS0w5QnRreGtUeWVJMFdEMWplaVYwS1BSNU9zNC8yTzQwcWdz?=
 =?utf-8?Q?Znttf+jgNt9GFK5oO8so7BlUS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hLWbZNA4LU0sTd+dF1GH067E7Xp1k5F56SzMmghlU6XMxGA08dpXY0lmKD58n6hTaTNX74ZD7xvtjVdZVEi823kWt3SherxT1BIrojXRf8WMTKk5dwrEmXySGW8EwJ83LBC0E9Oh2L6+RrcKNy4Z08fYZ6AtYozLM9yA+GCgqUiD2SpsXkcX3kpvjs/Q4yJ52MAW7WB0zznJM3rglKDsBDAI9cWjhyu0XPpoLAL6vvWuOAJymZWvnCZ1rpBlVo24dH3+g3DxL2i99fiAEwuthXs1NTdggJ8TvR0j0y5EZPJFdekvFdKw2fNFMDIH4UqNmBh3wnqqHTDXzosMTv62pQAujG8tVKq6EybcnMBKw2SrikjWLtlOfTg0Q9us1UC8oG3vYp+DkGjsqOXwbGeovMPSPWKgaigEz4heyUBAocoux2NRFnv5iBd/ffB1v6lNCN9GNZKT8I8GjxVz94ORUZb9CRZzipkyYy7qBSoELI50J8j1L/Ho+rMtQ76nBn99EFZk9SwhJduqE0Jsh0O+wgyhH8EWHboyvrgDmBtWNfkkzZiynYK+EDlcMjMR8+ko9R2Pb2RGPhV6GMsVl4GpHCZWLmW3FTGWDC7kH6Hew+hUvPps26fsHot03JA1p6Ek4v1nIFhJuRHrkpTay1YdFjXu/E1Fh3V5LNDeva012YPowGIgy4/MsB12Dn4ymv999PqIFkoBiNgJDryLRdZbQBK0AZ8OsjC4G4UW9/rdzsXUjoUJOduI2zYYgkktF9Cn4W8szF80uslm9XheezMR8UAg48+n6Uait8YN2GjbPEdZjMbu+xIzTkV/K8+zORe3OG1+kU0fosJUJOTuhEURIw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6afb63-042a-47da-d871-08dbe4aa0c99
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 00:38:41.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nQyPAlOdHDKaQ+s8bfr9MjfGPIJEaAB8m1ZX0p4wxN9yEL9XWr7Ej2H/pHJrpbFw6pcHDBO7p7Ose6FakF0sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=985
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140001
X-Proofpoint-ORIG-GUID: wflquaqZQ2PXZ7IAAXsJ_2vUFgSlnChE
X-Proofpoint-GUID: wflquaqZQ2PXZ7IAAXsJ_2vUFgSlnChE


looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

