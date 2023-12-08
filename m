Return-Path: <linux-btrfs+bounces-756-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C3880988B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 02:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA62C28208A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 01:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A4415D4;
	Fri,  8 Dec 2023 01:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M01f/c5J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gyMpZF9m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA731706;
	Thu,  7 Dec 2023 17:19:52 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B80k2Wj021052;
	Fri, 8 Dec 2023 01:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=JSazT6zgZintA+yWCCt3EL1RlWjLBOiTt5nu8g+mpas=;
 b=M01f/c5JTtBII6mNp8gUHHf3tF03fhJ8WTqF5525R3povQ4F0FhjFmw0SJdCMJsSGWjf
 Ve/+SUzTjjWaJh5SPtL2aQ2wIPqLnwMCkZmolUYjqCOVbqjLUbqGfU+/3TZbITPZXAMA
 +riu8flU8INPr4ZSk0qfp1QV4GRJfhJCZkNbNg7QatGCLG+3k82hh1OIJ/75397MxHOy
 rtz5YyifECmyG+tPqJ0+UPKOwybRe/S8aRkJ7lANl93PeYkZFyobz1gySsfSA3BARwSb
 AP4ovuRFljWIDEn8r9p2af6+TXPu0FwR4YfeJp3kXcUknTrqC10viOqIR/5sZwHjKAVc NA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdabw0p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Dec 2023 01:19:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7MZ9Eo001364;
	Fri, 8 Dec 2023 01:19:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan88ysr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Dec 2023 01:19:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdWQQJiuutc+ENSVjZLyj32Cpf4p3XGfevHPRbtzNKb1Y9eBWWDF7f1OgAWk+v3G7gc2JnksqISOCe7qO9pX7TlckWc0nUKby/YusOLttHvqOKGZg8nfGByU+kMi6CIY3oesJDK2GPrW1aBo+4eemv+zmXdvA1k8hhcFWi9OwN3n3e/qjoRh0m4rcuNlSREPSpTDVBg0ErMtTwOtTcbXZv2lBxjhR/UaVZl476l3FKSoMfYvTmLNFERdfC3BvSRpKSHDr0l8LAdwpY59ZJULOAyLtFm3Beko6TnqLuFclWqbPMbsa+S9BvKm4JkMVMixZCyZysBcLsLVzIooqf+HGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSazT6zgZintA+yWCCt3EL1RlWjLBOiTt5nu8g+mpas=;
 b=ApZmaqPtzTHk3/Vpp9MN0K1u4exr6kOUHPCLQZca46mhJHLMh+WEGH1QVf3lylFLvAwccmFq837f6JSTXMGVxEXfmEYpskVEMxXjSjjma6OBYFmB3vMmAfs8ERMKp09xFodM4Mw6f9f9STtUhbXFoAHD190gFGYV3ov2iQqSTErVI16znaubW6C8hZniCJ/kd3XP/GZpEYvhH9ExPG+FAeS/4CIbXHJJD6mFihBne9oCNQddsTO4gzLySa6HuChEo+aDXvRIXf2pMpSIWmj8RMES9USzv+3CfnLQv+7iMMNa8QBatoNPjdCzBMK/IFCw1L4cdFnqOfE4fzp0QeB5eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSazT6zgZintA+yWCCt3EL1RlWjLBOiTt5nu8g+mpas=;
 b=gyMpZF9mrFf2Z2kmUtbdzsirxUzjSzHjkuS8voZaHjFAs0EWTKKod0XJB3lAGv/kA86xAGaGV7xz7TSx/FPJmfpVIYhaUUap7VZLGPbnuOSeQ5t/P9Eb/nKBzMVob27HOcojCk+Y3W8Wa3JWeXdEZJTYz4wlRMSxwu8IBvecWwA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB4913.namprd10.prod.outlook.com (2603:10b6:208:307::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 01:19:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7068.025; Fri, 8 Dec 2023
 01:19:42 +0000
Message-ID: <0e13042e-1322-4baf-8ffd-4cd9415acac0@oracle.com>
Date: Fri, 8 Dec 2023 06:49:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] fstests: add tests for btrfs' raid-stripe-tree
 feature
To: Filipe Manana <fdmanana@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, Filipe Manana <fdmanana@suse.com>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20231207-btrfs-raid-v5-0-44aa1affe856@wdc.com>
 <CAL3q7H7pMjbc1-xZ1xDSMRBM2C-FiTi=sx=mQNBqH4MbXQ_WLA@mail.gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H7pMjbc1-xZ1xDSMRBM2C-FiTi=sx=mQNBqH4MbXQ_WLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB4913:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d159ff-5ebd-4807-34d5-08dbf78bc194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7BS3a7wt5YSW9KW1sIPRTkS0thniinFolr0D48MBto8LwlgdkOpQ/jCYx+AVO+xu+26qgYFjBn6E1pzzMMVj8oCJp/9aAkgyE6C+B4G0fL+3MQUw9HPZCULQjxRgkEWdhXyRMl2tsAKClwvjlV1FO7pzang7EqvUngY+gKftPkkzvddxL6DZo3l5PgDAK9Gz0b/EXMAWAVUFptcJSwU1FhH7hNL1j2vLXsJCf41KgigSzuOoXtvOZK92GyQtCArKXKgeildZVjHnVqyTvLe04/fvy5oHdvcljUqVmRiZGwM8jMNsyi6S6PIY4H+gtynn7m/Wnilv4TZERu1V74eHIzvFr931az/CIG2b7Oa/2uqK2F7UgkSikT6PD6uV/IXlrIGxCDgjz64CZO+zMnoUu1ySCqeGsZrhZHqEdn55VjEUNJVjh+xJs7SZjdRixZrhIAwkEJpBzLxBWAzNl1kXjbX5NS+HfAW2YYz6X8y5fJE32bCVm5FbXFentU2RD+Ntj8qwEx3oOtuE/nESmiumYLeJpCo9L6Xkh2ulCmEYa+qMWdEauj/TUwTybgG5vSSkRt2L4S2wBrQ52n2341LVVYLeHv2m8BfqB1+0m30TwcA2uJmhojSb4l27hjD+CUisvSNsBDwNzKtqAx/ZnI5fKeK0z8OymwfzFV/KUqqvj+w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(110136005)(54906003)(66946007)(66556008)(66476007)(316002)(2906002)(83380400001)(86362001)(36756003)(6512007)(2616005)(31696002)(44832011)(6666004)(478600001)(8676002)(8936002)(38100700002)(4326008)(966005)(6486002)(53546011)(6506007)(41300700001)(31686004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OUFmZE1tR0pselZ3MGxOb0IrMmxQeEJ3OGdaaEYvRDl3S0RpZW9senNEaWJ2?=
 =?utf-8?B?eXdlbEdPMXpNYzg2cHk4U2lLREMxdjRaaHhCeVNaK1BzYzd5ckJQUmRQbXNa?=
 =?utf-8?B?VzEzOUFMOU1QT013Yys4TFp3b0FiUHBKWk8zWVJUV1cxOXdWdFY3SUZ0ZDBP?=
 =?utf-8?B?NnhWaWV1bi9CUjlpRU1raU1nOFdSamQyMklXY2NJbjBTQm5ZRm1XQVc4a1Ri?=
 =?utf-8?B?andITUx3aGhPTHVCS1pnRWJxLzFpaWRJVVl1TjVNL1JFRDZ6MEtyYWE4MzY0?=
 =?utf-8?B?WTJiOWdyZVFrMFZTMGdiejkrVGtIZG44cmxrT21EWG1JYVNTd3MzKzF0djJK?=
 =?utf-8?B?ZFg2UEh2QW15aC80VUh2Y0VTWDA3bTUyUjRJbG9XRDU5b3c1MFpXOExrMW5u?=
 =?utf-8?B?M1lJTHZxa3N6eW5EUlQzU0lWOC9oTFl0cUJVVXBLYVd0RW1SQlZRVnMwZWw0?=
 =?utf-8?B?UWhYZmh4QzV3RGNjZEErRjg1aGFMTUpVNVBJOC9yMERYaFdMUk9jWW0wbkNr?=
 =?utf-8?B?OG40RVlydkRWZmdaU2xJdERiNzcxS09tYUFNQUY1Tk1QbS9kckxvOVV2N0c3?=
 =?utf-8?B?Z3MxSjgvL0MvTkRWVThodlRrTlp5S1ErQW1oSk5Ha0JXempWb0Q0bEdzb29C?=
 =?utf-8?B?WUxCT1FpeGFTM3J3RFNqM3hNYXdMZFR6emw0ek9EdnNlOCtrRmQ3Yjh3OEFi?=
 =?utf-8?B?MEtlRUF4NXlCN212WUFyVWVtd25yTGJHbTdpOWxnWnhEaGR4T0NhaWhwc0lN?=
 =?utf-8?B?WWhJRTlrY2cxT1Y1L1hmV2FqZWs1WkwyR0NzYWtqSmNSUVNEc0Z5aCtJNHA3?=
 =?utf-8?B?MWE5b0hlN0VUS2NrcUg4UkF6a2lhYW1zREp6RUFNVE1zWDhhV3FiRFc2K0lu?=
 =?utf-8?B?NnhhaWZlcjc3UkRvRkNGZld2Y1RSeHg4elpvS1c3QzRpU0hFQm9UakxwQlFa?=
 =?utf-8?B?UFAyRktQcmZ6RStOOUk5cTh4RE5SMjhCdGxvVlRrb1FWbXN4NHNFVm9oSjBl?=
 =?utf-8?B?UG5mdUtFVE9mT0czNGdZcnNVdnF3c1NLS051eVczcnJtT2lxbUo4alhiMkJQ?=
 =?utf-8?B?bkhyTHNURzRDcEo5V3BoOWFVVHo5ajNyTUQ1d01QNUN6ejhtOGxKVkhxZi9H?=
 =?utf-8?B?b2RIYzJMeW9LQ01POWphbDhDMWhKa3BkZEthMzIyd2RSLzhOaTZJaHd4NlJS?=
 =?utf-8?B?SGtmdWdhL1N5ZXJUb3hjQ1lWNG5xVU84RnhEMm9QY0FWVmhrYS9KUkdxTGRV?=
 =?utf-8?B?alBmUmJuUDdrZ1JMcm1UNFBNN0lSU05YUnYxb2xvMzdURGVhQ2IzbDRjQUFC?=
 =?utf-8?B?dUNtZHl6V2svNFpPNEozc1Z4bWxsMmJJLzFTbmF1OHNVV25mUUEzRlhFcndj?=
 =?utf-8?B?S1RLL214MWZKZlNxb09OUEpNakg2Umh2WjhnSyt0TzBwbXFtcExtMHp4OXVG?=
 =?utf-8?B?N0xxQlhsWEkyZ1RQMk4wbVp3K1JiL1l2SER2NXRDNk13eG5CY0RPL0tuMWlN?=
 =?utf-8?B?dW80Tm8zL3ZUL0Zmb1REbjFkQk9mempBOFYzODFZSWdmVUdQQnd5KzFFUjBZ?=
 =?utf-8?B?RXJOMUtQQ0pGWmlOZnRhUkxDa3doTkh1aEdrQjN0R01WTmpweDdzVmFWQUFX?=
 =?utf-8?B?TjR1QVhQSWtsTENyenZvaisxNkpMb3hVeWxMd3JOS0JpRXp6OWM3WHU5L2xu?=
 =?utf-8?B?M3dsOHMrTTZVVEFHdHdDQkFONU9VT3FzQWExOURPVG1iZ2ExKzMrMzBveVZi?=
 =?utf-8?B?UXZ1N2cvSnFLSTRVam45V1N2WEF1aWh5UW9JcXFxZFRib0JIejc4MDRkc2Fv?=
 =?utf-8?B?a09rT0dEQWFWdkFZYWRSS3BiTkxVZkhpcVliV1BtWkJPaVBEbGFKaFFjS3h0?=
 =?utf-8?B?WW1zekxDNmxmWnFuaGR2WVhtWWpxZzFoWDZXK2pTeWR4Q2lMYytFRUUrZnd6?=
 =?utf-8?B?U0xtM21YZzNNKzR5ZStUNTJzOW9xWVNock9ReWpXZmtBbDhqUEZ3Z2dsYW9N?=
 =?utf-8?B?TkU3WHl4ck53aUVOcWUxbHZabnU3ZFhZN0xVWm1Bd1FvbURRQkRkVTZJY2Rk?=
 =?utf-8?B?Y3hVQ0daMDR3d0hsS3R2enhvVWRtR1c2emo4SldQejBtZ0lXalVTRG9ZUzZV?=
 =?utf-8?B?OFRNVG1DSTdzRXhQcUZsZDdHVmVZOG5CU3QvaU5XcHFsOCtnVHgzU040SGxm?=
 =?utf-8?Q?d0W85k/Se+wqNbo9lnUvynONN9a4Su6bv2MvYSE+SAew?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qaabbRyBFtS7N4wGug/i6PZgdf2+f+Jrmu7hEMKcSsIi8e/5y09pmIaPAXXgh5xm3PsLmKro6I5lryOYuBpMjnYa2I9i4EzaL1na81ebn/vlpVMiCMzTQLk4vVrDIBeHUB2XGGpIf8OsyJ4NEA/wKSRd1dbq2Z+qicDPacfXO7LuOUyaAoWSJUdEd5iDbHdkrbvBvcL0LpyDAGvVuVLX/yUqMIxtNhMzn+M0kMnwK9Wu/ROiP4GBJZmbDnjB862QmxVwAE1KDRmmDGCVE5WM5JNgb7dCMjFSuSqCelA/NsVB1W48LZ4UL6ITMaLzZ/7hHRmSaVRcl29N2gvgLhNbXeq9rbYsXUlAFajYxZDvn7YGH3nK+njGKc34d288GHK7+jCzIczwsOBEP0L12qe2xsl0AmxxDnTO9UuVsWjUPL/ZDkcRTbaiDi0sqy2KYAmYjr/hZQQg3qICKCDBYKvpYu9XBHKrmeQcTWYLi9bvsdqV0mEYjIVh2I1dnXxGd0zvJj3ScEOgQv1PEd3V2RHNYk3Kh/OW5xo/LjQ/AAZL/2Ou+i4W/Ruc8VWlrzpPi5vkPBUbowfiataZAEzBIY33ztnnpl3qxDiyjVFbnFtLVSwtWB4Nqst83CD/qk3KZi5UhP0RdsPKj8Y7SXJs3ZwIigYyCBtS/u+14x4ixtFRwJtH86jg9VQGFMMQPSSw7TX9Zgww518s04ta8gbaJTlFPYVQdxbB4K7yVrgNXP50UFF04IUx6FfHQkqBwDucIL+TW2S7xOwK8LmyHBA5N0CuUa+trDB8PE3QRP4Q3NqUmv6b+QLC0SMFfzcvpcPIN2TT3gb9GS+8x1CEVmVJeLMAKur5ILS86nbEKVcBUAOlI/s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d159ff-5ebd-4807-34d5-08dbf78bc194
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 01:19:42.6769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wksa0sdwLKB72Ps9wcPoBLUePkz8fVDT3o2J+1VpAq/DqElFbUmlQFxapfwYQOVjlFxg91ANsg6JiuESjvMPxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_19,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312080009
X-Proofpoint-ORIG-GUID: gZPrjiboc-FQXeckwqYc1QLVeO4be4Xe
X-Proofpoint-GUID: gZPrjiboc-FQXeckwqYc1QLVeO4be4Xe



On 12/7/23 17:41, Filipe Manana wrote:
> On Thu, Dec 7, 2023 at 9:03 AM Johannes Thumshirn
> <johannes.thumshirn@wdc.com> wrote:
>>
>> Add tests for btrfs' raid-stripe-tree feature. All of these test work by
>> writing a specific pattern to a newly created filesystem and afterwards
>> using `btrfs inspect-internal -t raid-stripe $SCRATCH_DEV_POOL` to verify
>> the placement and the layout of the metadata.
>>
>> The md5sum of each file will be compared as well after a re-mount of the
>> filesystem.
>>
>> ---
>> Changes in v5:
>> - add _require_btrfs_free_space_tree helper and use in tests
>> - Link to v4: https://lore.kernel.org/r/20231206-btrfs-raid-v4-0-578284dd3a70@wdc.com
>>
>> Changes in v4:
>> - add _require_btrfs_no_compress to all tests
>> - add _require_btrfs_no_nodatacow helper and add to btrfs/308
>> - add _require_btrfs_feature "free_space_tree" to all tests
>> - Link to v3: https://lore.kernel.org/r/20231205-btrfs-raid-v3-0-0e857a5439a2@wdc.com
>>
>> Changes in v3:
>> - added 'raid-stripe-tree' to mkfs options, as only zoned raid gets it
>>    automatically
>> - Rename test cases as btrfs/302 and btrfs/303 already exist upstream
>> - Link to v2: https://lore.kernel.org/r/20231205-btrfs-raid-v2-0-25f80eea345b@wdc.com
>>
>> Changes in v2:
>> - Re-ordered series so the newly introduced group is added before the
>>    tests
>> - Changes Filipe requested to the tests.
>> - Link to v1: https://lore.kernel.org/r/20231204-btrfs-raid-v1-0-b254eb1bcff8@wdc.com
>>
>> ---
>> Johannes Thumshirn (9):
>>        fstests: doc: add new raid-stripe-tree group
>>        common: add filter for btrfs raid-stripe dump
>>        common: add _require_btrfs_no_nodatacow helper
>>        common: add _require_btrfs_free_space_tree
>>        btrfs: add fstest for stripe-tree metadata with 4k write
>>        btrfs: add fstest for 8k write spanning two stripes on raid-stripe-tree
>>        btrfs: add fstest for writing to a file at an offset with RST
>>        btrfs: add fstests to write 128k to a RST filesystem
>>        btrfs: add fstest for overwriting a file partially with RST
>>
>>   common/btrfs        |  17 +++++++++
>>   common/filter.btrfs |  14 +++++++
>>   doc/group-names.txt |   1 +
>>   tests/btrfs/304     |  56 +++++++++++++++++++++++++++
>>   tests/btrfs/304.out |  58 ++++++++++++++++++++++++++++
>>   tests/btrfs/305     |  61 ++++++++++++++++++++++++++++++
>>   tests/btrfs/305.out |  82 ++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/306     |  59 +++++++++++++++++++++++++++++
>>   tests/btrfs/306.out |  75 +++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/307     |  56 +++++++++++++++++++++++++++
>>   tests/btrfs/307.out |  65 ++++++++++++++++++++++++++++++++
>>   tests/btrfs/308     |  60 +++++++++++++++++++++++++++++
>>   tests/btrfs/308.out | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   13 files changed, 710 insertions(+)
>> ---
>> base-commit: baca8a2b5cb6e798ce3a07e79a081031370c6cb8
> 
> Btw this base commit does not exist in the official fstests repo.
> That commit is from the staging branch at https://github.com/kdave/xfstests
> 
> A "git am" will fail because the official fstests repo doesn't have
> _require_btrfs_no_block_group_tree() at common/btrfs,
> so it needs to be manually adjusted when applying the 3rd patch.
> 
> I tried the tests and they look good, so:
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> One question I missed before. Test 304 for example does a 4K write and
> expects in the golden output to get a 4K raid stripe item.
> What happens on a machine with 64K page size? There the default sector
> size is 64K, will the write result in a 64K raid stripe item or will
> it be 4K? In the former case, it will make the test fail.
> 

Testing on a 64K pagesize. Will run it. Apologies for intermittent 
responses; OOO until December 21.

Thanks Anand


> Thanks.
> 
> 
>> change-id: 20231204-btrfs-raid-75975797f97d
>>
>> Best regards,
>> --
>> Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>
>>

