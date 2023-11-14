Return-Path: <linux-btrfs+bounces-119-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BF37EA9EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 06:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B385B1C20A63
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 05:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B95C2C6;
	Tue, 14 Nov 2023 05:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b/7cUSBn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sWuZslOJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BA0C121;
	Tue, 14 Nov 2023 05:05:20 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3031219B;
	Mon, 13 Nov 2023 21:05:19 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE3icOC016258;
	Tue, 14 Nov 2023 05:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MQw/unzjYpFr/YwvGxpsg6bouZlpw+tS05RiW41hCDE=;
 b=b/7cUSBnIfgm3Qs05l/fPi91uZT2jZjqnHboFWSYNBjqVeQOsMOqaZ9f5+hm1+zIdPmy
 TznTMA8ErWnoHXMgMr6dIu8DC8A0tbRtNAjycd1o9Szi8TpaRpkRIf8hWxA9Of7rXkU0
 GBc3oz3tpZWhUnjVyYK/8EwhagGS5TpzeBvXmlf3l6w88YAOsGpWLKZbm79dM5Z1IBaO
 wFsTYBVzvH7zEGwty88TGqz4FbWqXAT7McOkOpLL5KhEY5lyj+J6CRp9aFK9hWxqkxpX
 pPp508YVnZXurJqKW+4WEzDu2S+TR2wVOTxHKDE2dLtRrgLKarJtpnqo3xOWeNiV2/hV CQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qd4ahh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 05:05:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE3v0J3013607;
	Tue, 14 Nov 2023 05:05:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxj1eec8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 05:05:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpBfWil07oDrDgh+qYxoEnxKANB05qwyc1MFvYWB9bwxIx1vfgSGAy4sdvTX+xPsg5vZYzh7qSMc3QafqY3c5HkX6q3XhRCrjXWVQkXnG9+TBGwQagJlhQ2+uOEhUQRgeDG1BQI6Noh5CzgbaE1Jx0KHqFQmLhbeZZJ1/WurJIHPsbb8oKyUC5PjJv2kMCBJpSTfE1rnvWZcTI6bYEF4O4sirlxlhTySLbwoGn7sSiFdB0mDoaWK7fd1Ngc+uarctxTmAGlxeikHvEpS89+DM5RuJiCI35V4/orCCjyhy03mT56BTaUiZVRNj1RnA4KkJjHPPIaYluC1OxpqLkt+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQw/unzjYpFr/YwvGxpsg6bouZlpw+tS05RiW41hCDE=;
 b=QgkDezW3lCMVfKNaS5xewZi9X1qUIbWE/FK54e69bzQuAENzbBQNsSqTu3mLKMuXZm7UBrYG/MmDrkGFc9oj0J1UPsHEy1y8LJ0iNLrwp6/kNTmLbtlm8Nh8HbdW3/Ywxjp5U2ao6gvh7d05Mw3rtwc0Jczitopuv97kdvJRcgyn2Wv9Ub7AaZd8TYRVhIOPrh/6/gTjW6ORsCIItXRT09XfOr2YxlKSe5F8A11h28Lbgwf1KKVOCJEhKpZBfErKLehfn4GwUz3Jtbt+e0OsnH/VcBBVAt7ixr4QuRNil6Rc7ML4/LlLRjRcasP6ofk0Pzg//9HaD6TNDU/aP+mKnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQw/unzjYpFr/YwvGxpsg6bouZlpw+tS05RiW41hCDE=;
 b=sWuZslOJwrF8u59G5g9exnm+lqt91Md3HKrqk+qNlEnyi41Ht6QYBDLDlzGHlF/FfXXcjDg2XAYQ7CIu7qD1R0ZmCl+hn9FI1MIUM8IGXwJk5N+OHpOSG79Y5aOE/J9Q9vM83NYgYfqmFeQo7iXOka12+OoqJESebv3hzeh6PEk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ1PR10MB5932.namprd10.prod.outlook.com (2603:10b6:a03:489::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 05:05:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::50e0:d39c:37b5:27c1]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::50e0:d39c:37b5:27c1%4]) with mapi id 15.20.6977.019; Tue, 14 Nov 2023
 05:05:13 +0000
Message-ID: <7c57e882-f15f-4ce1-8032-10e83ba59a71@oracle.com>
Date: Tue, 14 Nov 2023 13:05:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs: test snapshot creation with existing
 qgroup
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20231114025913.83171-1-wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231114025913.83171-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0112.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ1PR10MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: c148679a-9d77-41bc-daa7-08dbe4cf48ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/sR8Cn3VPERIRF3cRFzbMDlOXRtUUxQy/o/3ouV8NbhM8MbBJdF0mmHa6Iht1hCflmllIMHIXtVBH+JSKqht2kVRta2YaGJGvbPEQeBLVfEbXAlLz8KL9pcEG7Q+QmDQR82HGm8BzHl0oztY8Yt/TuN+iXD5RB+iIcuUK+YuAw79ZEJ1FV1G0B6XFyXP4Wt13lGsN10Nscnox3aXcNuAjUWwh2vihSOAQj0x0Au76WEt1vgWFVYTJ41DXBVljFRtB5jBtXg23g73DzagxVa4roNY+FSdpXwGV5gfLp55LA/NCvU5seLzoa3YUzdAll/wHIZTMZqzBSxu8UWEjdtuYybbTvgqduT1lY8K1i4rpjX4D9q0pzeiJ6BycE0mzRrjjeb0Xo2rGk9D7QBBM1FUy7zlAMVmHkKsa+gMIC2fDQEEVgwp7h+VTCQBITaymQGprxNqr7YCXzs4FTO9Xwa6U9d1U7QU+xA/OUh8ut7GD6Mqz3XZo3Z9MVPbuuDkSfvHf4jr9Vw9Hci7VidW0lVOOoBBAavWRxOOJAmLcqjXUVNjtc7Fg4Cf7NR1WNBbc1Gr0ywfDbdCnQrY77HxysAgQQKF9WGWVxXyogDTe/VI9CsF1RzfG8dt/nimeUPc5oq4ZdP2YGIpmBZ7j3RWKDnknQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6486002)(478600001)(36756003)(6666004)(6506007)(316002)(6512007)(66946007)(66476007)(66556008)(31686004)(38100700002)(41300700001)(31696002)(44832011)(19618925003)(8676002)(558084003)(8936002)(4270600006)(5660300002)(86362001)(2616005)(2906002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OERteUpFRnpKeUtWb1YrZ1EzQUF2eUhacGwvUnRRWkhRRE1tSlhwRVE4TWJP?=
 =?utf-8?B?VG5yM1BRL1BBSGN2dVRockRVZmtPTWpicFQ2RDU5dXNBcDkveHF5cXRTTW5n?=
 =?utf-8?B?cmp5eVN3TWJ3ZStIYmFwRHdtUDZzQmw5RU13QUhOcS93SFlJSDNDWmNrK1hD?=
 =?utf-8?B?RzBZVlpxTkwwUEdhMkFPUFZhSVR4SEREcEpCNUZCUVhZR0V1ZzljNkRBWmJ5?=
 =?utf-8?B?M3VEdkZaMzc3blBmZjcvQzdiSUROcUh1Qk5Rd0JMUGdRbmZkeFpaZjhUc1FC?=
 =?utf-8?B?S1pXcXMxRHJPQ2Y1QnJiUkZPVXJNNFlTYWVyeXNmSVpjVWRpKy9YY3lMM0Z4?=
 =?utf-8?B?OS9qeFFNZkRoWEhtRlF6dTZHaS91NmwyWWNMdDJXTjhBWTVoVkdoMUcxZEcy?=
 =?utf-8?B?elNoMi94UTdmOVp2MUgvWTFrenl1WE1udTBmdkJIQUFvRHFyTFRNTWptbjM3?=
 =?utf-8?B?NmFIRHZaSHhJQkRGa3FpNUxQeGRjZDh0ZGQ4MVlqQnR1eXlRWjBjYlJHMTgx?=
 =?utf-8?B?TGtTN09VQWRpVnFEWHprdzcwRXlVa3dNYzFVYTFxVVBLSlhVMWdwWjI1b1BB?=
 =?utf-8?B?Um9Dc1B5NFAxdTZnOGJjRGFZWmFqK0Uxc05nNVE0Vy9sNE9tUFc5N3RaeHpo?=
 =?utf-8?B?MGQxRHMvVzBCSWJhaVhHUmVPQXIvSjAzQ1M3R3pIWXQxcUs0WGFhWGZSWkpn?=
 =?utf-8?B?K0l4Z0NMckpSdnRJVVhCTkovdmxoM0U2Mm1zNEpCUFZ5VHZ0UmdQQVRlM2t0?=
 =?utf-8?B?TkJhUjdDYXF0eHdERFd4ejAva01ZYlJuZzdHMDVCaFQyNW4wZ2wrelJEWmRw?=
 =?utf-8?B?QlVpNGlyc0pLRGcyRVBvWjdyZDVLTmtZTHhndlJoOGdDdjF6V0ZrbHkyZGxk?=
 =?utf-8?B?dzFDT2FmN0lpS1QvR3B6OVFUVWVlMTJycVkxQmVxYzJLRTVFa2JFYWYrT1dI?=
 =?utf-8?B?YlNvcU1KN3VTWkE1ODUyajRMNjBqWlI5RjBqQW9QSDJGREQ4clp3cnQzKzN4?=
 =?utf-8?B?bGJlMDRyMzhTcTlxaDVLR2hFQS9iSnBhcFZzSmJEc1dTRTl1T0ZjbnBYRjNV?=
 =?utf-8?B?RlZHMzZEaDVsbEc5ZFcvSkJxZUpBSGRVOWNKTnZvRkNob3AySkZFMG9ZV2E3?=
 =?utf-8?B?T2FQUG9BOWFDS0Ztajc0K0pWVHFlNEE2S011TGwvTEhWYllmQ2FwS3VIVmZE?=
 =?utf-8?B?NEE5RWVENHJseEJoM3gzRjlRbHRoeFUyd2ZpdzBGZndYR3NVVWJXaGtHdlhP?=
 =?utf-8?B?cHhFN0FQOTBXSnQ3WlZXdWdGNzlxYVF5V3NKQ0R3NElDUVlQejlpUzFYZUVi?=
 =?utf-8?B?Q2ZUU0puaEpIMzZ3bUlGVUpYbENoR1duSUwxMFpOeVdxQjlQL1plekx5dWI2?=
 =?utf-8?B?aGJTbk95dmZXa09NbUJiT1poMG9sWEZzOHdwaURZZUxMQU9aNUNQdnZtTlBW?=
 =?utf-8?B?MTVpbnhlZmpBNHJSNVhhNllTbVV2Nm9qMkRVMkJQMlZNeEd1Uzh3ZXN5NlFh?=
 =?utf-8?B?aEcrSThDbXJxRnNENVVwQTcxOS9lc29FNi8yUS9yaVdLMEwzbU4veVVSenlh?=
 =?utf-8?B?YmxWQlVjSm03cjdPWHJIY2Z3aFRCOXMxMWFpdGNIMWJpN1MwYm8xMmlzWTJS?=
 =?utf-8?B?bDBneFpmeE9YR2VKazZKSVBZcFNEWkM2ZGh0eklLK2RzNFdsOFZQTzZvTU9a?=
 =?utf-8?B?bElNV2J0QnM4YVJVa3VnM1pHTFgzRkx5amtCSjk1ZTVaaDZ6czg0d3ZkVTRL?=
 =?utf-8?B?N0Z5R2YwTVZvcG0yQWd4eGlyazNmZmdncU84NVl6ZEhBeENDMzgzN0Q2SGlJ?=
 =?utf-8?B?NnphUVlSWEx4ZHc2MFFNN1k0dWgzNVQ1cHNxV29KSlpwQnd1ZnFFUU05YnNu?=
 =?utf-8?B?NXc5bkM2SG1EdVpEdEpFQ1VaSzlxOFp4dFVaUlYzZE43TWRwVlZnN0l2RmNL?=
 =?utf-8?B?ODdtM1NMVmY5NGZ6L2JVOFZIWUp0SmlQa3pSdXlSRjRtT25FeWhWZHd1cFFm?=
 =?utf-8?B?eWg3dlN1WVRUMVBLWDVaeUhnS3p5RDZTM3R0eGJySVlCcmdyZVAwYUMxZEt4?=
 =?utf-8?B?QWpQd21ZanlPaTNuM3JJNERvQVZZcnVVZ2Q0WE5QMmZ1UDlvRHdGeklxUTlr?=
 =?utf-8?Q?EiqWpIxXJTCHR4eWJtRjRgITS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jrp4vtZ+6jtk85MNo1HA64qdXsqpdF8/sHdO2Q1X+WR0wQTC4DOqM9Ae3qgghMm8rboqCPL3oLO4i/ASJVqse1cxs9ume4lqVQssEImLGZCwcwRcDBpydkqR0T7yNFVRit9CMgeFxil/t76T/oRjFSv7ud+x3f/uLk0eyIoIMr1fKqevpyhJHDkS1Vf0frZTyns8qhAUQSZcdBlFEsxvw4a3EcJce+Kapk4b4DJXOggnRTKDBaRVBH/ZRZ0V2/C7zjDVMxGVdOw3tkEhi+1THNa2Ctwsolwh0n9Mb30MaBBUjBRMDDNfVBDo4xnNbq7bUQuWUl5X6U/gHf48Amt32rpnHykKU5IorWye+iH972PY4Ua6WR/k8j/gIvfcYAIXZ68X2mDXT4jepkcQwY1gj1z+kOvMRq9csqvCS+1+8dMCr+89UJ2KY/wqPfFJthCNTETa5OIUIj5Nirazsfs4u2NSEk6eGUtmti/6zClXqherT7rAYc3aHCdcnH3zPNMKxilIfUnTRuZrcTo7EkAiBXlu0y5UK8xsDSArRipo+P//yPg7FrMwydewY9ec0LDpkdTxA/qROFbRQMzkIwfMl3TLMtPIj2Y2oxVGS9mFY5xHAtPu9kqyi3gI4HgJ9gqqHMKfMQeaOf6QdpbqKI1y6yQfomOAOkPzPGJLh67FDb+m/sm1/A428j60YHS6KQoF19nCBEAMU0BjTxXeef159S5vusQlyTyFjYlgVjQbdZaLo/phS/+pAjl/IZGgq0gJadLAELbygGDpTcuEDTId01iC94d17Ipdx0L3KBln6SE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c148679a-9d77-41bc-daa7-08dbe4cf48ac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 05:05:13.5665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4FQXTBr9ybryGmEc4cPNiV1gv4HBjhE9aHCy9UHFZgt9MWRqj6Yj99NWHjtuCfRiSaueQsdzsTlMgS90ownHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_03,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=972 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140038
X-Proofpoint-ORIG-GUID: N3dmelTfKxiPLqNaA0ciEw28lAYpUdcD
X-Proofpoint-GUID: N3dmelTfKxiPLqNaA0ciEw28lAYpUdcD

Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

