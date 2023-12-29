Return-Path: <linux-btrfs+bounces-1164-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BFB81FF74
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 13:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262F41C20E09
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 12:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BEB111A4;
	Fri, 29 Dec 2023 12:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oK09dm/u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DBt1F6Mg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A201171D;
	Fri, 29 Dec 2023 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BT8PFrC019108;
	Fri, 29 Dec 2023 12:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=0ay81V1SYMN5DRbMCFlJh4kRTuGYfktpdnlptJX6//0=;
 b=oK09dm/uf8ennYQssvVVQW+u1+zaKhSMfs4ispZMhUdmtdYRCLIVe0uXYn6rRfk5GoN6
 irhUN6u9wJ5pM71jj+nmOUptPijI1JC+w/QeEJ7SyGtJ4YHx0wbjWpBymTswLDa6oIV2
 et+K95m6E0D9Y1HZsD1xgi0R0pPjzKAcjLVQBLe66I/SFr0OKOPzplJZjSimMPlMzlo+
 a7BxVPTGPtAl/Ba8srsvTBSEOuXW6VyQGKmL1h2gIZ5LgwPETylbRm6ZHd9cDk4fTAYQ
 g7QRzOC5NjCx1toh6hH/7Ud144BN4ACnU1DOUuLoNubgOJY8HZCi0ZmfPuHGzeMo7v5k vA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5r3v7gw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:34:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTBo49A040439;
	Fri, 29 Dec 2023 12:34:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v73adeegp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:34:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Su2PAAJqpbM8rRBfz2Mf35CWfMCsMgyEMGqgeur+l4zx9DsnyJ/Ce2FMF4Te+EmuCiJz378nJXOSAwnlv4bC6aabQosbHMOm8e6rHRq9Pa6wlxE2IOVfgPy4MOMYD18EpmHyhKEbD/QrFH6I7FaE8MlxAl6qfI9sSYjU61i9ERUYWFtw6yOVR1qTASJBZTiwbMDoyEpFuzASB2CaePORGL3BU1AEw9ANcASeWBK6cgDZSY4BLgAmml53F2kzmHfkHshEGXllSFuAljHoy9fQKSpCM/fMCUhJ1v5kSNUM1sQjw8OmSE51Ck3VnrABuNesGXcx84cBFFI9wpTaejX/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ay81V1SYMN5DRbMCFlJh4kRTuGYfktpdnlptJX6//0=;
 b=ZX15M6J3bLH2eK0v1p/9CguBmHQ+C6MYzTfS1FaCDQf4gjJWyZCm/HYUAReS/i38D0Y8XtU+rAoAl5xCiLzLV9ZZx3Ev2gfl0vyi+qVykPYAQ5AgPGWpib/xOukXNESSt9iYmInQnSHzSxsETpP7sXQDYGbdegogeRqrP36hM9cf/F57C07a/xUxCYV3Iuduht0/GfstUhTIBQoZqMS49oRkA6boElE7LCv3BzgCY4vm4CowAY+axsynfSNP2WBkGbwc6WVPANtdaqy6TPk6tf6AZzdw+77ko5KgCIPbWWhLr6LH78sB88YOtuMzRknXNq83PUeM8ZPuepBUYJnPXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ay81V1SYMN5DRbMCFlJh4kRTuGYfktpdnlptJX6//0=;
 b=DBt1F6Mg8VwcnbQ8LIHBnNXn4z3mwsmvaIBDwjh4vQEFf3BUxwRzDXqd6Ug+yF+weGgsrlO6a6GqMLUWjYbXblKQ6Ik30CtWpy4zNYHCkYV3MKDnBWgEzM6jHI9lG6iI3rCK4aQ/CZnC7Yfa3SAyciwF4x2Xo8iyMW7b6gDpTYY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6202.namprd10.prod.outlook.com (2603:10b6:510:1f2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Fri, 29 Dec
 2023 12:34:44 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 12:34:44 +0000
Message-ID: <d5138127-7ad7-916f-69aa-279aa7c296d4@oracle.com>
Date: Fri, 29 Dec 2023 18:04:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 0/10] fstests: add tests for btrfs' raid-stripe-tree
 feature
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com
References: <cover.1703838752.git.anand.jain@oracle.com>
In-Reply-To: <cover.1703838752.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::13)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: 0175176b-6b79-4457-acd0-08dc086a898b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GK9MYYu5DIIb44AS41GZxUICp6+szD4rk5x3ME8JWJbRlyJjxKCYfUm27pd39ihyLr+oIcW0agFFtdWKCCtW7qjHmfmupcf81ofqz2nQ3AgOGeVJFjthFbKIcNKWpp3pg7jVWrtdrravb+daQPUZqvcFDG4rSTlgPX3nEtYC3NRUtNMb9ylr9f81Q2zFc54lumnrrQq/twbHVeKfKr9Wu3MS1XwivjXLbSkqOYaZluuLKjnB0bgvn2cvGEftWVFMefyg0UTacuB2i7IT/ggEbiXREGj3DonY13b9gx0rn9ItxSYkpYzzZe/fMroQxDs2XVCdep6C8DhvtOnp9yUfJ6HNeTNpeFXX+4K9ps5CKjJUnuAsH6yGmpZG55FrasFuRtZAQJ9Qzy3zmSVqG9I72BD20H7/9iIpvZsdgX6o1OZM0cPJ/FF1JkVHtLD2FB/FfIcvBdXQQyR+d1LvnefQAhowNiiQkS36O0FY9HzRic9UWN/rPhcFTKK7XUEd79yU52+CsJMLFQ2uVPGwpMzbX9cbB36lMllNgJ+qXIbhrmcbb/A2489TZd19GUVShmEYj+WLB38LnydAhcQyZEEO4Hpv5F2UhfluFjb/ljyeRA3i1H2/qB4NU6Cq/rOyfkW6Lw95NlSiwc9erqZfEDtlNQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66556008)(66946007)(6916009)(66476007)(6486002)(53546011)(6666004)(6512007)(478600001)(966005)(6506007)(36756003)(83380400001)(2616005)(26005)(31696002)(38100700002)(2906002)(5660300002)(31686004)(44832011)(8676002)(316002)(41300700001)(86362001)(8936002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SDl0dWlHemlFVlZCTFZMY0MzNmxuQ1dvVE1zWmZMSERDVTFlZkNhdng1VndF?=
 =?utf-8?B?YzVNRmhHNURRbjd1cW8xNDNqT0tYYzIzYVMyaWFCVmdkMUlWV1NsT3hZSVZt?=
 =?utf-8?B?MWpoWFRVbnNXN3JXVXMySWthZU5VUWFtOFhuWkNPQk10dTZmWmI4MnZhYktF?=
 =?utf-8?B?aWs2YmJ3dk5ja2IyNk10U1N4dWxOSnVUT1M0MmdDVm9WUnJSRDh3WjN4OGRZ?=
 =?utf-8?B?clY4ZE5iYlM0WU1ya0UzVTVrdFJjUUtDMm1haVloNitFcDFkYUExSlpHRVN4?=
 =?utf-8?B?MkJKTUlneStjd0ZnN1VURm9td2pNVTBFRjJMVmd5M1pncVFNd3hYNDB1REla?=
 =?utf-8?B?Y3VERlFpZURYc1hkV3p6cGtjL3J4ZDlvang1Kzg2cVdFUHZmRG02YmZubGdP?=
 =?utf-8?B?NTJHU0M4b2pYSElDT3U0dExLZXBQb0NUOUVFRWpkRElCSmFiN3pDdTlsSHhE?=
 =?utf-8?B?aUJlUExvS3NkMjExS05yTmVDd25hM0xPTzFMZERPSEFDT3IzTGMwYm43dzdy?=
 =?utf-8?B?L041UGVTRUxYUUk2QWFVc0RqMWpmQStKZGw5UGgrbFlTWlpLbVMvNE85M0po?=
 =?utf-8?B?TXpCbWl3ZDYrUDlOQ2krMWhLZmtCM2RjaVJxVmo0aThNUHJ4OUdJcVhJTHIv?=
 =?utf-8?B?NzV1T3FRQlZTalY5QmZER0xORjJCVzY5Tm1GeUV0cDRRQ1BGMjRZYitGaDRw?=
 =?utf-8?B?am9KVi9iNjU4aElMbDNnZDBDZUx1cEFtZ1VKU0kyRGRhT3NVc2c3a1dGV0gr?=
 =?utf-8?B?YWRBbFcvbzd5OXZuVU0vVUJ6Yit0dytMeU9tbmF0MnpSSTk0TmNUeDJMaUxh?=
 =?utf-8?B?U2k0Y3h4YTRVdldkTjlPbTdJZy9RY0w3akd4dnNEWkQrcnFkQzB2VHh0dWlp?=
 =?utf-8?B?cmMweGh5ZlFNeTlPZW42bE1FRWhNb215TWM2dmdTYXR1TXhidHFWdGQ2VGJO?=
 =?utf-8?B?S2p2T2N2dW5YT0JVWnVmVDRCZFVHN3ZPT05URVVPempoMk51TUhRZjBJSlF2?=
 =?utf-8?B?ZGkrWllIWEhzOERuTEJzemhxdGhWbDNENS9sNmJZZWtSTWZ2ZzJTRGl6N3Uw?=
 =?utf-8?B?RU9SS1RyUzBLMG8xS0RYNkFWMDdaRGNGK3NDT0JzWGFKY1IybUlmVUMrMnpE?=
 =?utf-8?B?NTBkaS9adTJYcXZaSzZJQm5kOFdYeEw2dVFBV2tJMjZiMW03amZpeUNFRnFQ?=
 =?utf-8?B?RS8vM01mYVNrZFRYSzZiRDgvWVN1eThSeFRMZzEyZEJkcjRZakRqb2paYnFG?=
 =?utf-8?B?SDlqYUgyL3AyQnpnKzZBdHdyeDlvVUIvVUFwdWlPaWRQdWJQSnZRTnZRaWU0?=
 =?utf-8?B?TmJUTkpjcjhwQlNVd2tQeWVYNU1jRU9BNVQxSktXd0lTTm1SVDVIalR6aTNX?=
 =?utf-8?B?Sm9sdFNEZjNqZlF6N2Y3UUVWSXFkTTZDUzZkZ1RVd0orY1J1R1Rsc0RLeVI2?=
 =?utf-8?B?R2xYeUZFT0ExS3pIQXRPaFlYaUdSLytJZTR3OStLRmttRE55dnh0N1Y5aTJW?=
 =?utf-8?B?Y2hmMHB6QWNUZGtrajhmTGxmUS9Yb1hCRjh6dTFsbmhBaGltem9VeWo4eHFP?=
 =?utf-8?B?Z1RVVXh0T2JiY0R1MllqN3lMVmxLNnFQbTQ1b0RZaytETWxqKzJFazlNNHhN?=
 =?utf-8?B?Wm9qN0hPam14YlhPOTVxak9RS2htMlJzclJjeVl3QWtSNlNBK3REUGpLZ0l2?=
 =?utf-8?B?dDQ0OW8yTDFPSDR4ZDd2MXhja3BlaFZFZTFkdGdibk4xbXBFSUV1WG9Nejdv?=
 =?utf-8?B?OHVld2pPM1VjY3JRbDZzOXl5N0d5UExHRTFGbXJHelZTNThaRTY0Z3dranlB?=
 =?utf-8?B?SE41QlVjWUxiTkZtWFVCOEYwc08vNE0ySFNmWHU3b3FKb0RIYVJUem42QXY5?=
 =?utf-8?B?cXhqSlNhd0dYTDIxRStyWjNWMk0zMUxTRnlKTm03RklqU3VlTUY5NFBkcllx?=
 =?utf-8?B?R0U2UTNUaUkzRlBneTc5R0RuRU1UdkJROHdWR252QnRBdlpHTHRHOFB0UjZ6?=
 =?utf-8?B?ZFdTUC9jcGZhMWdBa3hpVXZXOXFLSlZ0Um9nWmgvMVluSDNiUCtYejhmZ21K?=
 =?utf-8?B?SzdIcnlGbmpLRFBTRUhaK0NQRXAxcUxjcmRaVzVtUkE5Y1ZhbWxHb09wVnlP?=
 =?utf-8?B?Wmd4bW9wa2ZoT3FpR0JGV3hCcUFORjdpb3pTN2RBS0hUTm5odzZYUkhHMjk1?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jL+wZD8Bwfag0R5b729d94CotJ4dK9k+JiZ3An0uwbJKfxX0Q31k9aMnXLgI46K5ZgnNz52vgO866KFftlcRkjN2bbUzgnzJZRhOB23BrEednuB2ufEZYE7DYSfLzt/0o6yLpW3hM8gCpPeNdJEDKEauhpCzA0bmX6vEkjLXFlOX4L1hoUSraKn07DtEOXLBBiCwXaOR5nW8Pr2erx7ai2UaPETh3tv2ib73XDw4US20e84OQau6F08bZ3xFPNaAgB62yCcuIrhDctyoi42lMtNrHASliSVYAORxCRvl8FHyNAnlGKdYubeAAY5bfWlnyAKYmW5V/mpAHLL0D8MrGYUz+5996J9zzSA7bk48ObOBIiKOqrKZgExWWaN9KifdVidDDyR1AquruH0mWbqA0AOIh2Fs694ifoeOttEfXB2FpETtY2rNspsWE0cHJQzB7DaK1HBAhKgKZY47+ORcfhQ+HKKQn/hnHWSvP6zwfsMjk2s3J+6Ph9rTmlD0qMlq6lFuXo/FBtVx44UtDiSulpr5b4M+PkQJ3pZK5gM+c/LCxXuuL1vQYIk4cwDH3OAzPXN/i5TfXgH/Qvem4lsgCzq/0BfQ9IZNVsKrn0EzWY8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0175176b-6b79-4457-acd0-08dc086a898b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 12:34:44.7912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AjAzLdmmSy7dEzPWeP8L1f6H3EBLeQxOiiw9oOvUkyfmWhSbc64InSFe/ti+SIprfhMSqEoESELsnrcvLp8dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_04,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312290099
X-Proofpoint-GUID: sUohD14QOvNC4Wwtqp0k7ot7DW7jdEgh
X-Proofpoint-ORIG-GUID: sUohD14QOvNC4Wwtqp0k7ot7DW7jdEgh

On 29/12/2023 17:52, Anand Jain wrote:
> Changes in v7:
> - Fixed trailing whitespace in the .out files
> - Fixed the following test statement in 30[4-8]:
>       test _get_page_size -eq 4096
> - Link to v6: https://lore.kernel.org/r/20231213-btrfs-raid-v6-0-913738861069@wdc.com
   - Rebased on Zorro's for-next
     Staged at  https://github.com/asj/fstests/tree/ext-rst


> 
> --- original cover page from Johannes ----
> Add tests for btrfs' raid-stripe-tree feature. All of these test work by
> writing a specific pattern to a newly created filesystem and afterwards
> using `btrfs inspect-internal -t raid-stripe $SCRATCH_DEV_POOL` to verify
> the placement and the layout of the metadata.
> 
> The md5sum of each file will be compared as well after a re-mount of the
> filesystem.
> 
> ---
> Changes in v6:
> - require 4k pagesize for all tests as output depends on page size
> - Add Filipe's Reviewed-by
> - Link to v5: https://lore.kernel.org/r/20231207-btrfs-raid-v5-0-44aa1affe856@wdc.com
> 
> Changes in v5:
> - add _require_btrfs_free_space_tree helper and use in tests
> - Link to v4: https://lore.kernel.org/r/20231206-btrfs-raid-v4-0-578284dd3a70@wdc.com
> 
> Changes in v4:
> - add _require_btrfs_no_compress to all tests
> - add _require_btrfs_no_nodatacow helper and add to btrfs/308
> - add _require_btrfs_feature "free_space_tree" to all tests
> - Link to v3: https://lore.kernel.org/r/20231205-btrfs-raid-v3-0-0e857a5439a2@wdc.com
> 
> Changes in v3:
> - added 'raid-stripe-tree' to mkfs options, as only zoned raid gets it
>    automatically
> - Rename test cases as btrfs/302 and btrfs/303 already exist upstream
> - Link to v2: https://lore.kernel.org/r/20231205-btrfs-raid-v2-0-25f80eea345b@wdc.com
> 
> Changes in v2:
> - Re-ordered series so the newly introduced group is added before the
>    tests
> - Changes Filipe requested to the tests.
> - Link to v1: https://lore.kernel.org/r/20231204-btrfs-raid-v1-0-b254eb1bcff8@wdc.com
> 
> Anand Jain (1):
>    common: add _filter_trailing_whitespace
> 
> Johannes Thumshirn (9):
>    fstests: doc: add new raid-stripe-tree group
>    common: add filter for btrfs raid-stripe dump
>    common: add _require_btrfs_no_nodatacow helper
>    common: add _require_btrfs_free_space_tree
>    btrfs: add fstest for stripe-tree metadata with 4k write
>    btrfs: add fstest for 8k write spanning two stripes on
>      raid-stripe-tree
>    btrfs: add fstest for writing to a file at an offset with RST
>    btrfs: add fstests to write 128k to a RST filesystem
>    btrfs: add fstest for overwriting a file partially with RST
> 
>   common/btrfs        |  17 +++++++
>   common/filter       |   5 +++
>   common/filter.btrfs |  14 ++++++
>   doc/group-names.txt |   1 +
>   tests/btrfs/304     |  59 ++++++++++++++++++++++++
>   tests/btrfs/304.out |  58 ++++++++++++++++++++++++
>   tests/btrfs/305     |  64 ++++++++++++++++++++++++++
>   tests/btrfs/305.out |  82 ++++++++++++++++++++++++++++++++++
>   tests/btrfs/306     |  62 ++++++++++++++++++++++++++
>   tests/btrfs/306.out |  75 +++++++++++++++++++++++++++++++
>   tests/btrfs/307     |  59 ++++++++++++++++++++++++
>   tests/btrfs/307.out |  65 +++++++++++++++++++++++++++
>   tests/btrfs/308     |  63 ++++++++++++++++++++++++++
>   tests/btrfs/308.out | 106 ++++++++++++++++++++++++++++++++++++++++++++
>   14 files changed, 730 insertions(+)
>   create mode 100755 tests/btrfs/304
>   create mode 100644 tests/btrfs/304.out
>   create mode 100755 tests/btrfs/305
>   create mode 100644 tests/btrfs/305.out
>   create mode 100755 tests/btrfs/306
>   create mode 100644 tests/btrfs/306.out
>   create mode 100755 tests/btrfs/307
>   create mode 100644 tests/btrfs/307.out
>   create mode 100755 tests/btrfs/308
>   create mode 100644 tests/btrfs/308.out
> 


