Return-Path: <linux-btrfs+bounces-353-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BD97F876A
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Nov 2023 02:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C68281E77
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Nov 2023 01:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37D0A21;
	Sat, 25 Nov 2023 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cwVVwCI/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eq/P6UeN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4736219A6
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 17:09:31 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AP14Eem031143;
	Sat, 25 Nov 2023 01:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=RmTjj5XZXepHXzXvxw5hihA7yYceF3//AIB2IppeS/g=;
 b=cwVVwCI/32BBN9MZteSV5Jv6D3a9TL6QcNTD5OTtDNbJx0Yb1EVMS4qi8oFUAF7ChYLy
 ysEwDY4KFZQ/NphqkFeAUbpU+qz12aGNYALdp3jPGsUeQqOcu4MX43iokvPPfnuq4cTM
 gYxZPMnP2kxbq2MbPBZ1JKJLzXdDHAUix9745387xcoMCE4IUWrYqJ/oBrBOLDE6nwD+
 bzrCAj1jUCX7vKSoQA1Zpc33N6DDgRdpGBen+vrcVUaZYvsLkjHLRvdDMlaBkZPu1oZm
 mjXbL6WXHyrxwxk0WuDru+fQekvxz3yyTttoMrL6zU0CF0bOkaheZu5xMbrzAeB0XcF9 yw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uemvuky8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Nov 2023 01:09:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AON0xou007407;
	Sat, 25 Nov 2023 01:09:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekqc62sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Nov 2023 01:09:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAxqGMQ8XSuIjOdCrOstPYLTXydV2K6KVmpvc1vQstNacOPpSMSAoSQiN6wuu/9cdC5kAHONzxZewS+8wGQvRFACHk9ZvoiHacbcqtadLaQu6r00fQ4oiUrh+m7Y39mQhQqU1G/5t1tQp6teZrVSRYnJSkF4qWrJNGwNaoHt5XXk+VAOb0zEeWd+nxOnRBSWIoN6QMj4+VXbzcnBqGAHzbDOzJ3Zxi8qYlGTwg3xRASxVYzT6qTZ00vIvIZ2Ove31OOp/cR3F5nK0EUYtLZtML7A0/5uMWuKIXj4K6TBa5h4saBSDk39SZCAM0LHqxrdi5eiKl9mH7C04JaOcMZOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmTjj5XZXepHXzXvxw5hihA7yYceF3//AIB2IppeS/g=;
 b=UwLMqxEKiQo++eDBXliM7Uu8P7bPeiAnjSopuQvT60GwIMsclfYdTEG7/raVAcDKxVTby7ZptOjCGqiQu4kvROmdE4NgOI/MWsLHM1WMNf4ujbq7UIUxn18swWCXFwlshi9FhX3vBN7fr4IOvxbVf1Fr/lnIo0vtdepFbORkGovf4SPqUD+CJXyrvukUHO0W1ojouS5D+6NMrxXZjLhzD6Ndy0dtxvrnWg43DJKXbUA1iz2wC/1RFw2yEZgBFGwpukk9BuFcfaJVeziirub4moLrukC7YZwunFW15Ku5mdoi6g6KD3TirWEjc5yoZuNh7NpzhqSzxFCnjcJsjBEaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmTjj5XZXepHXzXvxw5hihA7yYceF3//AIB2IppeS/g=;
 b=eq/P6UeN956pfXHRZ/o56GppaPJmTj3c/XmykeerzR2z3+GpFbognACiLBb0lqpea77/0mwnvTPQMhgGyB9V/GlN+T3GEtTAHs+JJNehZg6QHkVBIBciGKA5JaVVx9d+ay4jsuggbNlS9/cC1VqKc7qwxtG+QJhwEmfH3AUrp+E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB4933.namprd10.prod.outlook.com (2603:10b6:408:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.24; Sat, 25 Nov
 2023 01:09:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7025.020; Sat, 25 Nov 2023
 01:09:25 +0000
Message-ID: <36171811-ed49-4427-a647-e052ec70faa0@oracle.com>
Date: Sat, 25 Nov 2023 09:09:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs: pick device with lowest devt for show_devname
Content-Language: en-US
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <85226cf68d7a72a034f0c0895b96b2557169755b.1698917826.git.anand.jain@oracle.com>
 <20231124161906.GE18929@twin.jikos.cz>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231124161906.GE18929@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0181.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB4933:EE_
X-MS-Office365-Filtering-Correlation-Id: 54afa6df-79b8-48dd-8486-08dbed532a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aQEzGM53pfG1NkVpg6kOzhazxNe0oEiGM7aboPhGVFr1jqJxHebzQeUnYyfBNmLhqXqVSMRbLHRqzEnBSvPE0eJWs081mmO3gzwRJfzK1wJeVikiJekOY9oslfKvOk66aAtfpVcQ8MUQrKNonfq9sdzGLxdV6if01sAwbLX7oHdN7pbWF/9rQRdrWJfvQgZYBRFbQVij/EcOdZLIhSp3YYinG18XmUyR5rRQjfFJohexxknaMh1veGcNd7TOCY0eEkmjuoB1MOikyHiJZVFGYh8METblbd3j+wwQXo+KKvJqMmMMc75TBz27MMw4Nuan5Nro7VeYQIHcD2Zz5gqNp59UyEAlelpoXjkL1sMeGViH4XejhKO0lkW9GZj6QlyMSfI4/pFK+gQXNpPABvwBF0nk0LDezzUtfizI3UhHP9VtD92gXctsb+TbZx11YTVVMb3py7abb9gq1TB0J5m9rNAS2OgkZ0X56cheF9J+S8lfj3fGmdBErmcapNmLr2Vvp8lWM6kzQCl/J2PnYrsLqLFSipwfiBXVFZMCQcLhZBolQYnandmgEzAV3Yri67kRjnh02z7ZoD3lC+Jd7IRmPXbmgebAp9j2OlPMqFsAuQxt2yccotTxs9QHd034oGyHPTlJ6pruBNsAcPjpYuofpg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(31686004)(2616005)(26005)(6506007)(6666004)(6512007)(478600001)(53546011)(38100700002)(31696002)(86362001)(36756003)(2906002)(4326008)(8936002)(8676002)(41300700001)(66946007)(66556008)(83380400001)(5660300002)(44832011)(66476007)(6486002)(6916009)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U21uVUxid3dnekJsUk42bGkyalN6c1VPLzZTMmttaWthVVUvT1RMTVFPY0lE?=
 =?utf-8?B?WXZNWmVuMkZaNGdyVzhYcktHa0xrcFZHcUYyZkpsNUVibWRXVnlNckREMk1r?=
 =?utf-8?B?YzRZdGxaRUYvTWZHSERtL3BmVFlMWDJJY25IK25lT1h6ZEFtUkoxUDdaWkJU?=
 =?utf-8?B?bE43aWZWT0k0TlovN1crSnYyUFpZOEttWlhsL1hxR3ViTFlrbDdJSDRBNEk0?=
 =?utf-8?B?NU04UDc4ZE1UZmg4OHhHeTkwY3lpVTZ1YzA0dmwzK0k3RDFQclQyZUltcmRs?=
 =?utf-8?B?eEp4Z3NZNUpkSlN0WW1jRUZWNmhJUy90OGMyS25YeWlCVEhrUEhteG1pamk5?=
 =?utf-8?B?WVo5d1lpVFNHVzcxZVpqUldNUW8wT2NEakJ3WWJTL1hHRktaejVGL2F0Z01R?=
 =?utf-8?B?Tk4wUDc1Y2pBb0ZRMkZHZUVtdmx5bkE2MVBML0V4bmxXb3ZyMzFGQUhNK0Jl?=
 =?utf-8?B?K1EwOU83MmJXVk1PWE0zZGhOc3g3K1FkVDE3dnhVaWJoVjBJU1JoMEVSbXU4?=
 =?utf-8?B?TU5uYnVIeW92eHdJOUhHSHpiTmNOUjNSMmc5Q2tGREdzVzYvRU5ia0NiRy90?=
 =?utf-8?B?bE8xS1hBaUprWnIxQXBHS2YydkZUempIL3BMWDB0QWkzMnNhaUNocDhJWHNY?=
 =?utf-8?B?YVQ0Rmp4aitaQkZJbGs2anMvaXJzSEwxUFF6S21QK2h6czFhc1d0TXVST3FC?=
 =?utf-8?B?NnlvOVM3RlExSW1hRmlRMlZwdlpiQmZjTkJlTGRSK0NRUHJYaXlxRk1qK0w4?=
 =?utf-8?B?eGZpWWdWKyt3dlhSbVZXTmFMei9xMTFUR0V5K01tbzZNQ29KOEhFK25Id2dr?=
 =?utf-8?B?N3UvZ1kxVm9jT3BTUDZPYzZiYUFIYjlFYXMxMmtNVGdiY29mMWJaS29DNnhR?=
 =?utf-8?B?dk0yV3cxSFdnUC9PaTBTeWhXdE42VmdBL2lObExzbjJONmZ2cW8wTzdiQm5J?=
 =?utf-8?B?UU5Ud0VjQWNJQU9wdXVkMjcrYTY3RDZQeWtIbCs5WDhIRVZWa0dOREdSNkZs?=
 =?utf-8?B?ZmtRT0Y0NFpmbi9KaDNVM2g1bVUyekkzZVFodnBkQXNadkE4eWRUbHZMNGJq?=
 =?utf-8?B?SUhPZm0zVmFWbyt6cXF2UUpwYVh6YW1hVm03Uis3Szdncm0vT3ZHby9jOXdr?=
 =?utf-8?B?clNyWWkyUjVYRWFWd0lmcU5qeEdtRkFrL3VEaXZIRVByQ3FrSjB4RXN3eHF2?=
 =?utf-8?B?blp1bkd0NzExZ3NBUEZSN1NGSFB2UkZJMHlOdXo0VDRQeFIrSElxRnBleEtP?=
 =?utf-8?B?eUFkRzZ4cGVBeGJDYjY0a0pXaG1CakZ2N2RDZElBK2Zsb0pQUW5MUVBnVHJ1?=
 =?utf-8?B?V1doZmlYOXdNOGtPZ3JrTThYb3I5TkVCTzFKQXhWVGZ5Lzg4YmErUTE3Szhw?=
 =?utf-8?B?Z0dVU3BZQ1JWdCt0NnkrbTMzc0UzZ2tadzJHKzRscTNXZWU5ejhlZTI0aFI5?=
 =?utf-8?B?VjA0WUdUa0I4cStOMG9OTXc3dWNVN1U2MjhGbW5md0ZsMldrWGNOUkxaZk1Q?=
 =?utf-8?B?VmluTkJTOEdteTJHclBmeGRkdWVZZllUZzBxVGZSRjZRcEs1eHBEbUY3MG4y?=
 =?utf-8?B?dSt2cFpLN2RUT2FLcUdCRXR1bTkvUUlLZFFML1dUTHcybGw1ejg4bEhlWG4r?=
 =?utf-8?B?SWRYOUxVeG96Z1FZdWhGTG4rS2hQVVFmTTNrUEJETzBIMFV6VWV6RFk2WU5u?=
 =?utf-8?B?Mlc0ZitPUG5vVlVncEtIbnZ5Ri9hUjVIMVE4S2ZnYzhJcXhWeTFvN0JCSkRM?=
 =?utf-8?B?ODhjMmswK3dRUFNvK3cwRVVjekNUcENPb1RhZ1BLNDVGVlZKQ0s1cTFDaUVk?=
 =?utf-8?B?OXBQdDZQeVpyelNmT21HbStJVis5eStzKzFjd3pqVkdaTzQxWjMrdm04V3pi?=
 =?utf-8?B?UkRtUGF4azhvMlZnR3RRS0Fpejg5ZVc5VkpBeDQ4cUJWWVIzd0UvckJLTlIv?=
 =?utf-8?B?NGpVL3Iwd3dBVytGVHBveHc3MXB3Y1h5Z3UrWHRTeWJnN2hqbmJiTEJBMHYx?=
 =?utf-8?B?TGc1WjkyQVV5ZW1sbHgwQmpjT0V4NjNZanNxcHhXSERNbWdIQjRJZlQwWUV2?=
 =?utf-8?B?OEFXRzZoVk9IUldiMWdyVENXbmErOVg4cmorVHhGZ1hTTDkyL1k4NHlmbFhv?=
 =?utf-8?Q?um5yroValeJtHtZkGFyCf33DY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tfDq8OMO7b1xX/N5dEKIVJFwcXEe9R3p+6f7NpffWFj4rJ2OFW+b3BGRoxIkPKsbZcqzo4FfdACb91MRfwORtkp12mgh1Ho43BukmjY+eiiFo+sAKNO+OKLPdysGtHC50kRtmxmOQQ08h0kRybMJyF+KHKg0jBlKrRMb3hoVE7zMekqLTEs+aZ/89JSmLenP56IZi0BSEOwRxoDNRPvi65RVdh1AraPlysx4TlocuR1r3SJMnlFRc1CUjXKenjK24SzBkuwIlbwk2wi9ZpS6kU0miFfCZrD3HUdU9mnF2MEx2i8T5qZdHJA6DlJs4bio5Blhq/+wuLh+SLPDR7Jm9E72nWvyR5Ssy/13NMgoYojp2X4R8M+DvkmwkoXEjkh7E17qBNtSAPvxkjUBOJUOWlztDh+DRcl9YPbhiPuKsD98FhI1ch1dXqcXJByjJ6ofmiFmjktEwzSvtGGb0On+XmLet9LsoeHuGbYj+yALd1B7957u20VgXKUTSZfxW+QSZWPkeQvGNcQstEYsyDGpRWAJNYy55/KniOFwZHF0EMDdPCPFZ0OtWsyWTvK04yppdUA7b14SismLiFh8Av7cEBo8GaTH4TcLABXL6DUVd7daKdB4GBpY9uwu3eipByegcgF7yABxaBcpPAbw+zmm1cCcMkcoKM+YcyIjHyqlBgbFKT+hlZYcTYHKriAPkf0BUBzbfPKVMXcqy9drKiOZKhU73ZtuJpnqv5NjOLELHtMZRnaTgiqfT5L2oWcUYc4NGpZPffCpNK5CvEs+sr6gEbfaaerbBnncdn4kBrvt9RM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54afa6df-79b8-48dd-8486-08dbed532a71
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2023 01:09:25.6228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEvMXiEYZsMuku33amgShq84IrksrUU+r78GrmttEztIw2BbZUQKb5fVNwopXCmCvfxZgeGy8agYYNrRHUexsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4933
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-24_11,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311250007
X-Proofpoint-GUID: F-UcmOhu2k009NDyGKzNs8225wJnpR13
X-Proofpoint-ORIG-GUID: F-UcmOhu2k009NDyGKzNs8225wJnpR13



On 11/25/23 00:19, David Sterba wrote:
> On Thu, Nov 02, 2023 at 07:10:48PM +0800, Anand Jain wrote:
>> In a non-single-device Btrfs filesystem, if Btrfs is already mounted and
>> if you run the command 'mount -a,' it will fail and the command
>> 'umount <device>' also fails. As below:
>>
>> ----------------
>> $ cat /etc/fstab | grep btrfs
>> UUID=12345678-1234-1234-1234-123456789abc /btrfs btrfs defaults,nofail 0 0
>>
>> $ mkfs.btrfs -qf --uuid 12345678-1234-1234-1234-123456789abc /dev/sda2 /dev/sda1
>> $ mount --verbose -a
>> /                        : ignored
>> /btrfs                   : successfully mounted
>>
>> $ ls -l /dev/disk/by-uuid | grep 12345678-1234-1234-1234-123456789abc
>> lrwxrwxrwx 1 root root 10 Nov  2 17:43 12345678-1234-1234-1234-123456789abc -> ../../sda1
>>
>> $ cat /proc/self/mounts | grep btrfs
>> /dev/sda2 /btrfs btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0
>>
>> $ findmnt --df /btrfs
>> SOURCE    FSTYPE SIZE  USED AVAIL USE% TARGET
>> /dev/sda2 btrfs    2G  5.8M  1.8G   0% /btrfs
>>
>> $ mount --verbose -a
>> /                        : ignored
>> mount: /btrfs: /dev/sda1 already mounted or mount point busy.
>> $echo $?
>> 32
>>
>> $ umount /dev/sda1
>> umount: /dev/sda1: not mounted.
>> $ echo $?
>> 32
>> ----------------
>>
>> I assume (RFC) this is because '/dev/disk/by-uuid,' '/proc/self/mounts,'
>> and 'findmnt' do not all reference the same device, resulting in the
>> 'mount -a' and 'umount' failures. However, an empirically found solution
>> is to align them using a rule, such as the disk with the lowest 'devt,'
>> for a multi-device Btrfs filesystem.
>>
>> I'm not yet sure (RFC) how to create a udev rule to point to the disk with
>> the lowest 'devt,' as this kernel patch does, and I believe it is
>> possible.
>>
>> And this would ensure that '/proc/self/mounts,' 'findmnt,' and
>> '/dev/disk/by-uuid' all reference the same device.
>>
>> After applying this patch, the above test passes. Unfortunately,
>> /dev/disk/by-uuid also points to the lowest 'devt' by chance, even though
>> no rule has been set as of now. As shown below.
>>
>> ----------------
>> $ mkfs.btrfs -qf --uuid 12345678-1234-1234-1234-123456789abc /dev/sda2 /dev/sda1
>>
>> $ mount --verbose -a
>> /                        : ignored
>> /btrfs                   : successfully mounted
>>
>> $ ls -l /dev/disk/by-uuid | grep 12345678-1234-1234-1234-123456789abc
>> lrwxrwxrwx 1 root root 10 Nov  2 17:53 12345678-1234-1234-1234-123456789abc -> ../../sda1
>>
>> $ cat /proc/self/mounts | grep btrfs
>> /dev/sda1 /btrfs btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0
>>
>> $ findmnt --df /btrfs
>> SOURCE    FSTYPE SIZE  USED AVAIL USE% TARGET
>> /dev/sda1 btrfs    2G  5.8M  1.8G   0% /btrfs
>>
>> $ mount --verbose -a
>> /                        : ignored
>> /btrfs                   : already mounted
>> $echo $?
>> 0
>>
>> $ umount /dev/sda1
>> $echo $?
>> 0
>> ----------------
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/super.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index 66bdb6fd83bd..d768917cc5cc 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -2301,7 +2301,18 @@ static int btrfs_unfreeze(struct super_block *sb)
>>   
>>   static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
>>   {
>> -	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
>> +	struct btrfs_fs_devices *fs_devices = btrfs_sb(root->d_sb)->fs_devices;
>> +	struct btrfs_device *device;
>> +	struct btrfs_device *first_device = NULL;
>> +
>> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
>> +		if (first_device == NULL) {
>> +			first_device = device;
>> +			continue;
>> +		}
>> +		if (first_device->devt > device->devt)
>> +			first_device = device;
>> +	}
> 
> I think we agree in principle that the devt can be used to determine the
> device to print in show_devname, however I'd like to avoid iterating the
> device list here. We used to have it, first with mutex protection, then
> RCU. That we can simply print the latest_dev is quite convenient.
> 
> I suggest to either add a separate fs_info variable to set the desired
> device and only print it here, or reuse latest_dev for that.
> 

I got it. Thx. However, I am still thinking about the fix. more below.

> Adding a separate variable for that should be safer as latest_dev is
> used in various way and I can't say it's always clear.


Libmount and libblkid use the device path from the mount table and udev,
respectively. These output gets string-matched during 'umount <dev>',
'findmnt', and 'mount -a'. However, in the case of Btrfs, there may be
more than one device per FSID, and there is neither a master device nor
a consolidating pseudo device for public relations, similar to LVM.

A rule, such as selecting the device with the lowest maj:min, works if
it is implemented in both systemd and btrfs.ko. But, this approach does
not resolve the 'umount' problem, such as
'umount <device-which-mount-table-did-not-show>'.

I am skeptical about whether we have a strong case to create a single
pseudo device per multi-device Btrfs filesystem, such as, for example
'/dev/btrfs/<fsid>-<random>/rootid=5' and which means pseudo device
will carry the btrfs-magic and the actual blk devices something else.

OR for now, regarding the umount issue mentioned above, we just can
document it for the users to be aware of.

Any feedback is greatly appreciated.

Thanks.


