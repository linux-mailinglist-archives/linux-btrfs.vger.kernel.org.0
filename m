Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345FC6AA571
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Mar 2023 00:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjCCXNs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 18:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjCCXNq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 18:13:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B515D455
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 15:13:40 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323MbM4H005512;
        Fri, 3 Mar 2023 23:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fHyQFV0O7CGgFVLGX7QWbKhJRA6ZH+ft08k5Jf3pOew=;
 b=hkSC9odjQnFZeFLxawGP9kgvLNktQG0HxrsahXRE9i6vTgIoaIFIvw+1WFGL9bclAsPp
 8VE6hppDqM9HF2UvrjeRZAj/pK86WDZ3Xo+O3hRGvtTpY9NhBFdYdMI5ASpDo01fCRyi
 Wa9QpysEsuPYyvb/lp6s4AC3omUkp4iQvjNUCNtbH+Yy2/xDojwqAVJRn1E8fJzdqB6U
 HWHsuqOVD++NGSFMrHxTgaKzdgMTz0BaK3F83/iLYzIUDm/Lxl+gj4LP6fkKXRDpSPu2
 BdnAwUF+K3xhzgmIQS+G1xs7WyBbDZfnkAXQyrCLe63rb3OflNsYXOkEQmeeSWWA5MU2 4w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba2gt2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 23:13:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 323M2xCl002234;
        Fri, 3 Mar 2023 23:13:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sbva5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 23:13:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoxAfX3460H+ywkn6Ee0HQrRl9r/5+UqRpOXODV/3EFTDGJAnVue9g+NpdneF4MgKPIXPGw/S2T3o0Bhy0OwxMxfjRN0NL0QTCqwb6EPsH1sU549hKoVcttOIfFYJf1z4u8tjuoX1Ay5l14FGrkuFy/KNUhmGOZ3h8YnKB1goR9tfEl3FG4YkUwABuW11+yNRRoPWNjp4+Il2UfzBjP80u+zkSR1RXly301kLhXWyhnYAcivR/aii6RzwuKMvIvt95p2QNHuJ+cN0CAuzeGNk+AyVZpOd6jtdJlQDApU7IFAEJ/V0mNtykzZJxj/i2paq7atOHfWbxcaKAejuhWIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHyQFV0O7CGgFVLGX7QWbKhJRA6ZH+ft08k5Jf3pOew=;
 b=NpTekCqqm9pdX7mi4uTV+39q9K4+YVYE0zOzfJNLmWjLPlR35t8GKQydDSPo1GAeduc+FEEXxVM7nHgZlNF+yXSLs3jT1WL4lRaXi3XCsszTjA1BA8quDFVD9WijW7lCdAmBcLwX6jgETbStEpnk2oRsOtZyqaq8Z8tS3dos52oRs2pmxHEkX4sb4jqb31N1QYTgVUnUl4B4BJNhvV95cXmPv3z8+q6NhLqwlFkVQ2kXb9hH9RHKaUGdV7u0dhW8U+yadndTBqDlgASyLyO23FqtJHnnaJvh+xswqU1OxPDvFhye9NUWGdL+w1dtReYDunFO8dT0tDe/NGoOl4TWnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHyQFV0O7CGgFVLGX7QWbKhJRA6ZH+ft08k5Jf3pOew=;
 b=TFWRyeaSvnMwr60RdKhKmxr5rKWceNs3LKKApiu7LA6Tr+wT4gcKCE/HMA4qmyM+Ze2M/2y+AhZzPauRnq1g7zJp0cMELvgki2BKbSnd2+dTY+OGQDU0KoqR1JCLzKXafmL1WFi2Pu5GuLWsn8p0lDKwQzOOZe47tRgzggWDmLo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6781.namprd10.prod.outlook.com (2603:10b6:208:42b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Fri, 3 Mar
 2023 23:13:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Fri, 3 Mar 2023
 23:13:31 +0000
Message-ID: <4c7c30cd-5537-b9bf-9906-f1bbc05b2272@oracle.com>
Date:   Sat, 4 Mar 2023 07:13:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 10/10] btrfs: make btrfs_split_bio work on struct
 btrfs_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-11-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230301134244.1378533-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:3:17::35) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: cab23aaa-0acc-4130-6e9b-08db1c3ce76c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IG6aiTb7G8nxbEKUoaZrcKMyIk4+VpHCEes4+ChJtFtrBO3E7hKFD7Sit3WI35/pbdmPgH81AxFvihncnyBwnITKKZ5LRuFTkEvTzWA+WgmppWwOfGy8Mcg7GjOXesmLSWwDp/+EbkmcJXJ1dRtSfCaiOzyJfJBuc7h7Jfb3g717T8TgMdExBTshoW6EHwOKJj5OTVGhLRaIte4gwADzIhrdt3IxrXyBw+RVz2VafdtdJmzcBDo1QMiVNRVYfHK1g/k+FKLyamfCfD0ZLVeKGGjav2n+QPk5VoiLmPH+Ve44cYtwC909AJ4x5XtqPlJp/Bvxvxq/KIg5IqB88PddMeHp4Y/j2intvZmTb+KNYIWHLqws7EZ6WexAMp3XzUzrw82j8cdLlYFLcmZ0w9KSLOb39lMPLX/k+x+BuJYomHPaQ5q1+iKVsi5w+Q7VNNg6hrNU+wNYDcOVeDuhmM+vxeCaaqM13i25YY1KN7Mi/Wzk996LcpSU//wAqLMxupa4MkowW+WEiYmh0relsFVipKNF92NCsmm3V7KB+5TGyoBFkBq7TX2gj1hCTe+w62Zhvmzcpv9cCXKPgCXqYkjygpVLzVUy7jfDxXbRD28gA5e+PvjPwF29r925of9UCp3458DD4niY/UNuuxRrZprxn9zYe+wngXKvG6rlr0pePUuxaqYma982UO8Cfujw6at9ZbZkXOlzohXa3cX585veNU4Mmaxg6wAIyffLpTMhQvE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199018)(86362001)(4326008)(41300700001)(66556008)(8676002)(66476007)(6916009)(66946007)(31696002)(36756003)(38100700002)(6486002)(6506007)(6666004)(2906002)(53546011)(6512007)(478600001)(54906003)(8936002)(5660300002)(31686004)(4744005)(44832011)(2616005)(316002)(186003)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3k5L0o0d3ROaUQzNkgxN1NiZDJ6TEpLUXNXeDBaaUtLSEhTYjlzYnpqQjR6?=
 =?utf-8?B?RThkWGlqckIwdnlmTEpWWUFNb3BzbXRNV01xTGw2dXZrK0NZc0RiZG5aMHF5?=
 =?utf-8?B?QmVrbVhYZVBiNUxzbFhzaDFHOEVJbmhubWNOdEVOcHJRZWt4eDd2b0w1L3BO?=
 =?utf-8?B?OS94WHpYcGE2eGpneml1T1lHM2crcm5aa2IyUlV5YWVJRnlWcDB6NzBRRldl?=
 =?utf-8?B?LzRodVUvdFQvMUxjbUxCV2RNMFBraG9DQXhOQjdqcnlEQVNnWlF0QkpPekho?=
 =?utf-8?B?blBBendhczVKNmVHbEtTRW9EWXYxeEdybk9JVll6ZTRTcVVCS0RkdXhYZUF3?=
 =?utf-8?B?Q3ZIQ3E3RXJCMXBDaTAwd2JoQjNRblgycDZWQmh3TUt1ZjFya09YVnBNelEw?=
 =?utf-8?B?dlIzb2hWOStqeFBxVEtRRC9pd2M2MldrV3UyMFV1OW0vYXJ2c0hnVkVKRjlq?=
 =?utf-8?B?cnAvVkczVm9PZzNpWGlwU2l1Vk5IMTc3QnE3ZDJNWWIyMGlSR3hjb3RvQTBM?=
 =?utf-8?B?VVRUU25GTFd1bk9uQzBsUEFJTkRQc3VvOTNqTmV2alRwV1RZdUp3WWVLUGJh?=
 =?utf-8?B?S3F4WEI2bFd6NFU1eVBOM25uQWhySmNudFRWV205bUdqUGFUZ1NLZ1ZWS1JN?=
 =?utf-8?B?eHhaY3h4OE1EVWQ4VU9XVXN1TkozWkgyVG5IWmI3dTN4WWl6Rzg0MUJpcjR1?=
 =?utf-8?B?cVFHc1hJQVpRaExrY3B5NGdQZEc0eENMa3AyTVJzaDFTVWQ0RjNIV1RWQ3lS?=
 =?utf-8?B?YmVlaGdZbDlicVZSdGZOcDVNRGNtUjNyb25xbWdRMkF3MVRiYkN4NHU4K3U0?=
 =?utf-8?B?b3dQd3hKalpkQTJqVkRZaS9tejA0Nzd6Z0R6T1pyR0xCNXBrcTlqZEtaRkZI?=
 =?utf-8?B?SysxRmkrU0xpV1h0eXFQTFY4T2NEQURIaFVmYUFMYmpPZEEySFdtakVYbW1E?=
 =?utf-8?B?WnEvK3FkQTNiMFpMR3p3MDBkVEg2NjBVSWZ0OHR6RGduV0xkOXBuTnVrMldE?=
 =?utf-8?B?TkxBczNtd1Vab1JhM1NWam9CMEhndlZEVWFmRmpMVzNUSFhwNlhock5HM3dY?=
 =?utf-8?B?VFNsdXFFV21lYWw2aEFUdlozWWV2akpxRzkrS21iOVVhS0x0THJVQmpXSVlG?=
 =?utf-8?B?VTZ3eGtLM2JSRFJ3ZW5VbDlYcEpxOTdwODZ1REEwQVNNSm5wUjFlTlNNN3Zn?=
 =?utf-8?B?QnBnck5CZ1UvL00xNEtvZklXaUNhd0Z6bDQ0dng3L3dXSXcyZnJWOExVdWlW?=
 =?utf-8?B?c2Y4WjRGcnZhQTF5Q1Zja2tVOW04QyswL2FSUktteWZLbWw3NU1BZW1CaGwx?=
 =?utf-8?B?OUFJdlBKbUJLL2dOWWZwdHhDVzF2NnJJdFdONk14SlFHTWRZZmI5RXZQTXRy?=
 =?utf-8?B?Y2l4VjFyaVBDOWJHRTE1YXd2K2wyK0xGb09WejFsTWFGckhjNzdmQk05RFdz?=
 =?utf-8?B?VEk0cUl3cGlBMlNRQ3F2bjFSOFBkUjh2Zy92REtRZkdCV2M1ajJmQktjb1Jm?=
 =?utf-8?B?REphejAvci9pa1N3Ynl1SVhZV210ckw0K2x6SmNJQ3VKN0M3UmZuR29wTUhw?=
 =?utf-8?B?bEZSTDBpRzRORnlUZlJvdGhtbFh1MkROWUtST3VURDRrR2VRajMzczRveEVF?=
 =?utf-8?B?UUd6UzZwNmxEdXp3K1NYM2RvNC95ekRMSlJQbktYYUVmQ3ljL2w5T3RjVko1?=
 =?utf-8?B?RWJLQ2dONWwwUU5zRFlJT25DcjNKUGZoZjNhV0JzNDRzRm5BbFRnc1EzZ3hw?=
 =?utf-8?B?THdpaS90cG4zam9LWEdrZ3huNmx2VU5JNnV6NWxNRVB0TndqMWRXYWZrVjdn?=
 =?utf-8?B?S01uaHdZb20wb3hzbXY4c0srbmltVXdiNUFmd3BIbWhZbERCRThBeHlISnNm?=
 =?utf-8?B?bzlNRkloSjVmNThlOFdHSWtrbDF1TFF1RDVQVUx0ekpjK3Y4T1g0ek1FdDlm?=
 =?utf-8?B?V09tZGdpOGtnbEFrb2hTcFpXRVloM3JRYnZyQUNYRXZnUGxRVmxSamtKTTRN?=
 =?utf-8?B?dTh4bU5mZ2xyS3crS1dDV3c2Z2FXT3lYaWxIL1NXMFU4bml6NEhKRmxiTEZw?=
 =?utf-8?B?alFUZWtrcnk2ekJEeDQ4RUplSFdRQWJUNUZGcW8wcWNFbGZzcHlvbHJFWXZN?=
 =?utf-8?B?UGR3ZmFuNXAxZGxJVi9naEMrSG02U2lmYlB4d2ZhRDV5SFF2UVhOVzh2elVh?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Hb61OHRmp2D2/H5RBFrojXhtz+wOyJDL3bW9vEp0qSjvRsBGd0TEPlEnR6ggIZfYBlTHC4R9+MVB9k1jvR2nRad42SwFBLhVPzGt7rAerADB4oBiezKXfwLVghmBX4hQ/FCvYa42w0q9tHwY/nSrrq9kZuDoVZ294xA1E9/iQ6bWarz/AJV8vbTtasv2f98d14tKkac3pHAiH+GpyP1jMfb4ApdnbN3tqX+glxbvNTqUGxEuO2gyPg6vKyL4tjghrtbOWuZN516jBXEUB55nLcBDQox6xnPY6QfCvZQ/L8Q8qNu3zB708NYntSbQzcxVt3f0BP57yFYhB563fZhLolKIHGbWa22vYbHF0aYaM0nXgi8Z50HqGnMHbGMdy5ZRZDikEtze16j9lk2HQQSblygP38FwMkzOpH5xmRpZxIQQbn3TIr5V1ZK9oj+rJ5yv5EhjTgntQA7rCpmtxYjenKzi6+j5tHkm9rGYt45SokQ04k1I292M5W7fPeHCTdpBpgzwPJuwfz5jXFL8aNFv5nARp0xJPYa/iHitOAR/L/vn31/FsV+P4xIFeFTF4gqLGRZY84lrQc6i2OVXg0iKb74HD46QS8cCP8Lm/141BXMmgyIdtTbo35m1Wfi6+Ip8KRkVwdN+ggl6joidXJkhadQqrHOyTgrsdTqDtvykNKQskozsp/knyluT9P4Eh99R6EfEjLB/d+bt5s1h59S5+XxaM5aYYArYcjthga4L4XcAxHQXbZCpU3z/baC1pZXdMcc7Lck3Pg2f6Udj9Vt3aZfA8Gv+dfndSoeOl+kVcxDKa7V97EUdi3YdiAQpG03epts5IBZ1pXxh8unM5S6mlDrdn9bMTjoi2ATqOok0beQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab23aaa-0acc-4130-6e9b-08db1c3ce76c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 23:13:31.2922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfwhJojkH8nC1j9R0aQpZseEp42irT+dHDCJNYCCO0xBYnnOgb0QIAipfDAWuYk035ttc+Ddj+dXxOE6TcsEqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6781
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_05,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030197
X-Proofpoint-GUID: 1jmetQGK3fTXb3SmhikEb1Kc7YmXFtDc
X-Proofpoint-ORIG-GUID: 1jmetQGK3fTXb3SmhikEb1Kc7YmXFtDc
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/03/2023 21:42, Christoph Hellwig wrote:
> btrfs_split_bio expects a btrfs_bio as argument and always allocates one.
> Type both the orig_bio argument and the return value as struct btrfs_bio
> to improve type safety.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

