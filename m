Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3667E70DA93
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbjEWKau (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236420AbjEWKat (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:30:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C6BFE
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 03:30:47 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6EFeT027129;
        Tue, 23 May 2023 10:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=Mh5wJzHdssq6iZPDfU9JLkkmSRBxAFfF4NPK8rVXQtSUQAZPqoKbxZCMoCF0ugVLQGIB
 3dLa2CCdaxUKgrOLKt2sAf1G4GPOmmLXnRb/lGxmTSn5Q49H9RMWlpJbygL24eH/ODpR
 h4Kg37J2OHR/tjC2rub7iQ5dOi7cx8VD2aTv2zzUArY5taqPKgpRhzMANi0S2U1XRdvX
 7bN3RQeoWy0SVMc6YXuUQ3MdcKmFcdbUWn82vJbejR9Tyj+CD4o4Ki+458ibMCuiJqhd
 3qV+IWRcspG6wnR8P6F12e7a6fWeDSEpJbHkZAVF7v3DZYVug1W5RXMeuD0hbaMapene NQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp8ccuaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 10:30:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34N8xABe012965;
        Tue, 23 May 2023 10:30:41 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7en18v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 10:30:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfJsaiAqRRl1VWI7/yTEVQcApvyLBa8PypIvIL4vlpMMMfU2ft6dE4JYVbdGZUnB/a2OU4xJZbuTA6DZ5tHmBJ4QSBb1PIf7GyP4ltw2Mcf5X54hHrMLrlS8Hdgku5w5jj2hntmxLQw5SxLMrpyNKLUE/8OcNXcctinhHE+i3Wz11QWMGIBwebUrZbEUI7MGqssbPNwDVsiesLqldsYZ+SYJzb7Hkt6cZgpraTm4QyzONDnW8MRtXM8Ujz+MAqjmeNHEsRt8iz3S/BSy80zefatnEIe3pBmn1QTdzExyWUr0iIHE33uYBZf2ayeHeVW0YJYJI1ZKO1YsTLHNH/d6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=m7w2Rv8fsimnRuEeMWuo6+5Dy9zQjRbct51sDeACSmf9ZhLFNJVqcIrFBcpoaspfoEEDd/s7bqY7tv7Yl4d8/JohASdJSa2xsQ79b+W2qU060f4Pv+HOK6/fy4ueaLA8mZW2ly7Iv1cYZLMsVJrJy/jidd+E1Of12yZobJVy/IVfytp+N4VyprtCmVxD1SxEgXMFFYM42D7/tIcvvjsIMDPuwdyllvwXVNOQe1O+tiRTKMHdbtNXzhZc/awWN/4OKjG2yGQV7BK2snVvhuujSSWoeNhVgGqIZ2XTmL4R8gKFwNJULVQaqHhOtjpMUWuu4YlnEatKT/CLp19jJf3GTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=QUHYaS9C9LuvBYge3OM2zxCrDqTjmOhHnJ90Buoytbv7mOt2oD/WvoVt7b9Wvqy0NxFRql8PKxwOBCu0Os0OB7MsPmPyEqKO5ezufgyqp4Ym98v9LGx6z2UImy1VLktOb4jcQWa2hG+1fl5BBweAL/VQVy3wvG1c44VlnFMhjCQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6980.namprd10.prod.outlook.com (2603:10b6:806:34e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:30:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:30:39 +0000
Message-ID: <41011d91-c639-ff13-92d3-5718b76fcd19@oracle.com>
Date:   Tue, 23 May 2023 18:30:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 11/16] btrfs: move nr_to_write to __extent_writepage
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230523081322.331337-1-hch@lst.de>
 <20230523081322.331337-12-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230523081322.331337-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:3:17::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: b210fdee-9442-4d7b-e893-08db5b78c0d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: coDuHbw42vhi852JbQL2cx7Q1tL+erP3M5gyFxZWaYzfyquysxETdMvx/UnPpjRl5nIeHQBiDdOk9QGZA4vrNcxWE7M77kzcCvxXxaPNxFjXv7UPtHLGus0xZTLry/W+J1W2L7e1y58SwlXNb2j7bOsCnt+w5tW+a0Gg47BsIuAJNE0J/JvR3zcrcoM5KJF0nhcWHjX1/bYQhO+bevc3FGgp56TH9evZGizXvf1v4v5N5Um3KSzcsuISayaQOEI2OkuYGSBjDS0F4pQKMAk/vsVBk5hCmV+vtjU8jjlfzgAiCzHef3bGN9s3Xvtjg75Q9Gc9BYvTIcE81htu/W+G0Q7gmDLnV6QyScuI7LfqVj+zw0iHbZDFdUSFtQkC30x6xP+sBqweXHT28uozIaW0thvm+pIPn9PWhtJ42bHpnJVo81zUwWIOH+D8wYyujTjRTkZW7SIXfWSWnLBNV0oYHyklJm/uWyJpeLWAUp29lnTpQkX+Mss/1GCMHejhkt5kC6/DekppAP+jgrpQifZ5r42+xbWNTb7k/2qdqTt8y8yCrNVRmgDOa9fbCSD8ZL/z5W9qOY7GeUxvZPngd9cXkBPqHIE9QLMMehCuaXLT/7/9V6erQnlEPbk7n3ah0IlkIZ/A/SsXBGPRrTkl30etfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199021)(110136005)(4326008)(66946007)(66556008)(66476007)(478600001)(31686004)(86362001)(31696002)(6666004)(41300700001)(6486002)(316002)(5660300002)(8936002)(8676002)(44832011)(38100700002)(6512007)(6506007)(26005)(186003)(558084003)(2906002)(4270600006)(19618925003)(36756003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1NZVndPam9pKy9JNld0MXFjWWtSb3FEV1pMOUY5NnVqVkhpaTRoOFEweEVM?=
 =?utf-8?B?MmMzb1NUNFF4RitPQVpaRm1iUnp0ZHBwY3F5VVpIRU1kWXM0WnZtSFo2cnk5?=
 =?utf-8?B?T0s1NzdEdTkycFJOTytEeGs2Tk9Rd2RmZG1ZYTBsZFBPL1B3a2JrbjdFYjJ6?=
 =?utf-8?B?RHB3Qi9Hd1hVYTgwQ1RkaU5tL1ZZcE9NeGFQNW9YU1RiRnpwOVJDc0hwbXYx?=
 =?utf-8?B?b2M2TkJNRjlIM2VRT1VubU1URkRnVzMzdUo1L0FZM3NjTWdCOFo4RnRYd0Zw?=
 =?utf-8?B?NUxxTGYwa0dSVVlVSzc4a2FqaklodmNwMm5vcDRmSWtEU2hqL1FDeFQyb0Zo?=
 =?utf-8?B?VnhYNlJkYzFHM0NQWHZCY2VxOW1oblpFMTdMWTdBc0xZZDJId0J1aVBmK09m?=
 =?utf-8?B?TEJOOXd2Mm1xYkYrWVZmTUFHSDBtRVRuV0wzRjhvSUVVRVZ1OGU0a00zOThZ?=
 =?utf-8?B?L0FCT0NHWldwY0dKMVhGRFVUZVdBK3lzOFpwZFN2c0o0NkU3QkpBUGI4OVFC?=
 =?utf-8?B?SU1NQ1UwVjZQeTRDc3JTQmVYS2t4SzgxcTFaV1FsbC90WVdTYnFmZ3h1a3VE?=
 =?utf-8?B?L3NndVFRemxIc01sNTQwd1FSVnlhRFJRZzN5TUhsMTJMTUpOcHZtNmlsV09I?=
 =?utf-8?B?eWUxdHZuWHplZGhPWi83UTk5eXBabDhuS0JiYUl3bmJyaE5wQ2lOeHRpRTRh?=
 =?utf-8?B?ajVZU016Yi9EUTVSRWpSUUF0WTRnL0toS3NXSUJLZjNDVWl2RURzdkdMcmsx?=
 =?utf-8?B?Sjh2M3hvcHBTbGdPcmF4WklUOWg4VXVKZkxGSFdMRis5YWV0QTIzL3dJT0dU?=
 =?utf-8?B?M09hMGszODBTYy9sZ1RLUWFVaUhUYm04eHBRV3NvWTltYlpzUzJONElxcndo?=
 =?utf-8?B?VEUyR3poMFQrUmZWM1ArV0x2bTFqVXRqdzdIUzB2a0FnWHMwNEIrb29QTkgz?=
 =?utf-8?B?NVNHVUFxUmNrRVphVlNCSlRuK3NyWEttMTVtM2pUcm40MGhMRHJZOVlpeGI4?=
 =?utf-8?B?L3ZXQXZzTWlJYXBsOHlxVEpIc0w0blVWNjM2MU5oZ0xseXZLSXB5NmV5N3Jk?=
 =?utf-8?B?SjFiK0szVDM2SHhHeW1meTVhUUo2aUFTY2xBRkFScEJxNERHVTdqanBpZ0dq?=
 =?utf-8?B?dFZPOTJFWXhCdlFTdHVoanBYVDNZOVVmMUt2V0VtK1NHcm5jR0cyRXVsZmZv?=
 =?utf-8?B?Q0R6S0I3bGJPdjYzQlE3YlFRLzFSMUxhaFRYT3poeFlQclhGTERQai9HdW5p?=
 =?utf-8?B?dGhpT1Vjc29hcjg2dlVoQmt0dkRlQjFsSWpWTnBROUw4eDltRklWMlVvQ3Uy?=
 =?utf-8?B?K28waDhMcDd1RTlWY0JHR09oNW9zemZYdXgydWtobWxlcndUMTRDRHdHMkpX?=
 =?utf-8?B?TTJtVGVsdy9iYk9rdU4wWlNrUENMREduNElnUURBWU9VVjkxNnlycm8vWWdI?=
 =?utf-8?B?cXJHais5VWh1YWFSNk8yTWYzWElSU2tsOWRTNmVPWStVYnVYTGJWK0pIc0Vi?=
 =?utf-8?B?c2VIeGN4Q016ZWVKUTZmK2NYMnZSK1lYWGNySktqTjdSMmdSVW5GdkVrdWF4?=
 =?utf-8?B?dFkwZW10YWl2UnVqelRRM1VobDFFNVJmZnhTdGlVc2djSFJuWXppQjFsbzFp?=
 =?utf-8?B?WDVBcjZOKzdTcTl4ZVVJT0FuZ3ZtYTVOMW53RmdoMUpGZnpndEU5Z3BXRkZL?=
 =?utf-8?B?a01jb1MxNkNIY0VlblFGaFdqNWtYQkUzNllOblk1c0pnSzFpQ2lrR0Jxc2g4?=
 =?utf-8?B?bEdnNlBGYVVxMGJzaEd4TUtLMWF3a1hRZnhlSUJzMGF1L3p2clowbEd1ODVJ?=
 =?utf-8?B?S1Z4WDV6eCtpZXVJWmxhM09Hak5DeTZOUnRIcEFBLzBFSHdHbWJpdmVmelpk?=
 =?utf-8?B?a2dMNEdnWW5DaGdYL0xBVE9rWElVUXlzU1FXczdpeWlGdnJ1RjZ5azdwQTJ6?=
 =?utf-8?B?c3VZZzByR204YVF5dU8weEVpc2YxWHd6RTNPTDNwbXdwZWNHWmNjeXF0cUF0?=
 =?utf-8?B?d3dHb0MrY2tqMHR1bmExNnByOEU5b0llMlhyNXl4YmpoVk9yK3plZmRnVXpi?=
 =?utf-8?B?ZWd4M2M0RDl2amlEYzRCbHZaVnVxSVN2VmhkTmpVbjlNa1V1N2tsZi9qU3pR?=
 =?utf-8?B?MmpJOGs3YlJtbiticTBIc2tqVytiTDFYYnNzRlpzMzhDODNqL0NncGgvTXNi?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: k5HCZzgY+W1DMLV4qo/uhFExho3AWzcLE1iHHLCUp8XyP6toG5CBi+bVEf09r/bBtrR/4uxW0/A1SrdSa/y79T8Ab1HVNvLHDZsGlQovaR6Gzy0cUqQexoX1miaEL3tHwvAlBvw6HZFOTfwqWsxke8sMGWQwJoJNbtCVnE+MV3fCOqeH4LOit+PHcuwIgitH8vw3kAy4zdgtC4SStAmVidymjyOC1CtXE2B8mgwJg9uuqRYsJj6WYKXU1jqqVfKS7DK3RZzPszrB3UvZE927Cl2D0mrL8t3AnEwmVkTeWAnh77WopdF3Na9VoHrWjP9PXkjrqMDgRhJwzGWn4/ejc+emtHf3V0+gtq+oaI+iLhpcKT4cTeZ2nlk1nCQmyppykxRfsHRwlLEhaZlnHXLcP3UYT6P7IAGkcC0BiNooo+afo7cJcDKtaPtwKdIEB/3EDJxzaOPxI6w8J29kBsg0uM2HTvrZcB0oexOqLDP/kEoLgJU8tvH1BU5fbVGzUa39ptjZ3rBS46/XVbztElCfQw3Lx+I+L5GUBKPrUHv6FM+qhDF8YXNqtalmp2mHR8uYn8/4zJMCPoOFsYW92QeRETL/yuR5n0vpPDw5Fu3IhJVbQk3Apo0SP7QO008LH8HAZchoxChUwyt5nScnn82Luisa3VVJv5fAT/3UTIpsxscJHivCfG1jEQJiF0KUALCXG2WXUApryoON8AM8I6lT7jZzD0yCETc21eOS4dNrhmbm+8TY5C9dqOp433RwXQ56zoQ8qxQyNc/iOV/LHbIOEulN/9MHlVEyZUzy2sYgYZC+Z/ypmnoqtlneJffxkZRcxguViwhMoNjUHehf6ju8+Sq7dRvuCemtw0gQyWOKKuQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b210fdee-9442-4d7b-e893-08db5b78c0d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:30:39.6145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEUOuhUhJUv45a5YLxPma03Hp2p/+MoeIOkx6DAjIzWLAUcXB3eN7kXYPAVndlTEM2weckgHgFN77hacoD3d+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6980
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_06,2023-05-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230085
X-Proofpoint-ORIG-GUID: J6qP57Cyz-ww_Gsfex_0JBSYsiH2ldNS
X-Proofpoint-GUID: J6qP57Cyz-ww_Gsfex_0JBSYsiH2ldNS
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>

