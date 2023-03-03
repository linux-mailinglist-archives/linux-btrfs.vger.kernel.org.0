Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33726A938E
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 10:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCCJQj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 04:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCCJQc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 04:16:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8592D1556F
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 01:16:31 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3233hwXT032550;
        Fri, 3 Mar 2023 09:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=w36nF/VfHENKtavw/1Kz/4diS0UN5J+8PhwJLOk57UY=;
 b=WUzEnEAGm+koanmabxfkpZHyCGVdcnWTv8ICwCZJCAJEuSqLUG35GyUmxuqaEPs4+Mge
 Ql1HhcCftSdYHPbZa63/JINF1CcktTJ8PjZvGWB5grhUDqMenUMmLpT+eLHaxPl/tuSX
 taC6cjbZq7tpWPsOlPkXnInTLYqdGx6MMjfioRmGTj1tk0gtpnTrYJbzV0mJobOUBDX+
 TjsOXFKM9A4sYlQrbWRPvzGQfu+1bb58zAojztjNCtvtFXKKBa9BBgm9aDoJwbleq0Km
 3ltQ1FoRUjOF4GqpcIdoh4jA2vkl0NEywmRS33co2beSWGa5uxC2aBIPsWYeXI3Uj7So OQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba2e08y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 09:16:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3237WBfl002214;
        Fri, 3 Mar 2023 09:16:22 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sayseh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 09:16:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doz6U+6dpuiBxab1fYhFymlgzcs3amRpUpAPw5wDZE9KmalwGNiyVYv/QjPyTytdJQw1o8m7JF/4ogS7iavvKEfjcUAgNag+DgScLFNFkCqLisZ4wL1MgXyjuHSp0xfvNY3aodhKN87FxHm+5txUJSsVh24TcdNTB3xGH8TdRZVChEUX9g6lqFj3ZBCdtl+rPIgqfYmzv9n9IrQ+a651VEdwHqqv1+hqyDXho1SI090zKQfUxK7pzlQ8L7l1Iu57s7UIlvIpxy+XSwvbcCz+QTKobKCPpRVFvHjkOm6+3qpvPjq4DCf0zk+l3s8PRjwbSyP20jA5uiUCF2cSHG1dJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w36nF/VfHENKtavw/1Kz/4diS0UN5J+8PhwJLOk57UY=;
 b=afcnrLk2zcJRHWg3b+uoykFaQuhnZaUBrwDP35P+CZUHaXfap4/qTplAkXyqPuCy8xcBa86FaWmvIV2iRZJrsMA58CnY4sg0j0XpBH1xRJSHFDzNfXko8u5NKJe3FfojdxJuNIGXkAEyD4u6TEZsdXNJR3++iytDwldxk15HmVsrr79rSSuRgx+qs640keMU9JdmTf1oFLKKQEQrtNozNhKT7zIXjr8O9w5bNE0a9ali0R6kQArabt2R6Idciq0ZI6hqub/W8k30amJC9qcdHHmoT0sOTjRRw+vo3mjlO4DqYLo+f90Sm8j2GfcvJHjXEYCidirqu6OUsM3xlSBIow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w36nF/VfHENKtavw/1Kz/4diS0UN5J+8PhwJLOk57UY=;
 b=JyTxzpHJCD6gJYvxgl4w6VdJmgFijvKrQoKEF0cdqS67bwhLBhPi2K918P+mfJFjuJTBGg4kivUU1LjVv20xifDwl7zNuT9ux2feHiD+iKZ0hyzveZuyr3WSJ8KIhBe8JDQ7cxnr8AqMd7Nv5S9IIqfWVrpQb0eoc1bLRdfJJoA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4524.namprd10.prod.outlook.com (2603:10b6:806:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.20; Fri, 3 Mar
 2023 09:16:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Fri, 3 Mar 2023
 09:16:15 +0000
Message-ID: <4394109b-d6f3-4e34-8b18-d4d23ad13b42@oracle.com>
Date:   Fri, 3 Mar 2023 17:16:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 07/10] btrfs: simplify finding the inode in submit_one_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-8-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230301134244.1378533-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0120.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: 565d6354-c7a2-411c-5cf5-08db1bc7f0b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x4ZQQr1TEMKoTLHG57qWR1JFgSEfJ03DvOOUjR49jwjMNVgiXw8yqML9H2uaJWkn8BlO+TbH7mis/Y+UvcRzoBDZq3Cl3OvL+aT8PAeNIIMtX7Slwt/iKxpY3kMSRls1VNnzfvaFMti5swNK6UThkNXhmf8/K6fEOpetPRUUhIKfeucBHmlhXPvTWDMEXobF8d0NFM+C1Y162IibD3e8yFY9pftE6YjOuiaHtzwwe1IludBpUPoU9lz/JcsRuNSYFijXajo6N1vRYwvsYFAvIVjIZMeGbH2H2JgNGVmIjwhVEaKLhXwk5KAmSLvD2Dx0q9RQ32iwOsWhMEu8V0k43dqIDGGSVJclRGWrOJGM6MadskaVeCgnq9TsvW0yanazkmMJ0acZf51DqZNj4R6eD/JL5qaGGSBFs6CWsYet4rCSb6/wWGcbjtHU6UTzoTLhYAX4cPhuLqHR4DM4z9qpZaUA4L9+BtSq+VjeUQDR7KkqPgB+iM3YeF4LyLSDhumakYiLHGEMokmb0cZ5qogZrhZmIvhH/UhLQHCQh0K26gAI8QkeLc7/Q0knDxXlVjw610ejuBnbFk+OTth6mUntCWP4AUgyFcnSqnxtk4XE9bzN6T46W8qAujwhgtqTFuDIuUb/52a0t6VcM1+eNSqRJq/o3p3gd/q/lrquwzTy4nunyhcQVfvRriCYLa4DWNXz4jU3j+H/mNyEsQk2mTEJO20ApdfsvVksQqvpiOa2Imo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199018)(36756003)(6512007)(6666004)(53546011)(26005)(6506007)(6486002)(2616005)(186003)(41300700001)(4326008)(110136005)(316002)(66946007)(44832011)(2906002)(8676002)(4744005)(478600001)(5660300002)(31696002)(38100700002)(8936002)(86362001)(66476007)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejNXcngwT2RzS2tLZzBlVXJDaFBNZzRFN1UyQytLZTRJelh5NGFIVkRMMlh0?=
 =?utf-8?B?QkZxUVpDLzEySktkdXpHblpoMi9zQzZ5dnNXU3VBYVNId0JTR0V2VnFncTlm?=
 =?utf-8?B?Y0FaTC9JOVVkYjdrMHh3ZDBWQUMxc2MzNXk3QmxsZ1I3aHN6V29XVmxCT1ND?=
 =?utf-8?B?U2hkbXRZZGpvTFRwbDhhWTcxa2d4MlRqblNuT3VMNFhEYXNyaTBaZ3FiSW9q?=
 =?utf-8?B?N3hnbW84VEpaZlZJRmFEZ2xGNm9PQ2FPVG1XWW5rK2RRekdNVjhFREcrVVFE?=
 =?utf-8?B?YmVtajJFTCtZdXI1VitpaUxYUzNoSzdidXcva3BEb3hFcitNWDdmZ3Y3d1ln?=
 =?utf-8?B?ODdlT3U5MnNUeng3WXhjdWpjWGFBWENJRlI0a3drQ1F6Z2JnbHlJT1Z0Zjhl?=
 =?utf-8?B?K1FZNHk5OFJxaHVKQ2NOY3RZQmdZdk5jWWtxLytJdzNwTEFwNE9ncStXSjJK?=
 =?utf-8?B?TVZ1azJvamtwRlBZY3hZN2FIU2NSWHVhU0NuckxydlNUMk5IZnJ0UUZBelUx?=
 =?utf-8?B?NVJkSFlZd3VvRGM3UFB4TFV3R1dsZmhZOGNvS2ZNSC9QUHZ5R1FZZE5SZWdB?=
 =?utf-8?B?RWJWWXN2M3MrcmkwQ01KVDdXRXRtSURLcWhNY0hhWDEyaGVNdTNWZzNDdG9D?=
 =?utf-8?B?VWVoVnY2eWgrVHdldTRSbk4vUVd5VnlnVTJYU3JKOVdUdUxzbm9WT2doQVJR?=
 =?utf-8?B?c0JUK3VJQkVnY2FsZ29NQkhMVDNRRlE0YzdRKy9ieG5aT3gwQU82ejFic1Fp?=
 =?utf-8?B?NXAzUWs1TVpiT1JTcHRqNFRiVUJQVWcvWldFalJFRmdyUTRZbjIxNHdjT2RL?=
 =?utf-8?B?Z0h6UWE2S3ZBWjJlZ09CTmxYL0lUTFA5SWFGQjM0QXFqOENCbkc2cTkxRnNV?=
 =?utf-8?B?NDF2OTQxbFlhTkxyTkV4NTloVGRYR1BUOWxTK0Y1ZGNnSG9EYjlMZXEyZC94?=
 =?utf-8?B?OHhZN29sN1k5VlN3YlQyY0luQXlud2drZTh4SHZvOHlKSlVoSTNCSnVVNHNV?=
 =?utf-8?B?MkVmUFBxZkhHTWNySjEwMnM2Wk16bDlobWVqTWxQTmd0MzBvdlRmZGNGSit2?=
 =?utf-8?B?UVlSOCtJNGp0eUNxQ3dHQVNqdENRUmwrYzBLVndlVmRucW1tK2w5dk1xQy9r?=
 =?utf-8?B?dHVka2FaNC9hZFpCZC9kOFhXTzFTcDQ2WVNJZFQvNjZPZldzdmQrd1NUUHNz?=
 =?utf-8?B?eURWaStDSDRMR1dGVnNSUkxjcThWYU5tNFVSbkZoa2tXV0ozYnBjSTVPVmFL?=
 =?utf-8?B?amxha1kwcnhncG9CT01wbERTbElhNFNFNEdxT1ArQWtrUzR2bXRjSlZ2MDBJ?=
 =?utf-8?B?UjV5VHBnUnBZVmNlc1VzVWpMQmQwM1hmc0xJSVMxNWhwNTMyeU5XdjFQVGF2?=
 =?utf-8?B?VmltOXhUYVN2dmFLN29yTW83L3hXMTNUQzJQZ3N0TzRlZ2E5YTN4Y1c5V0FK?=
 =?utf-8?B?TDNIRWUwS09vU2ExditxT2tSMXBPc2EzTXBkYW4xWnNLSERzT3VUQWdHc085?=
 =?utf-8?B?cE9TZGVjZGovN3AveXFLY21yenBrWXFJU2ZmU1hiVzNzMEFXVUpYQTNvZjkw?=
 =?utf-8?B?djBFQ2pTVEZ6bThjTUwzUlUrblExM0htY21jZXVnUmZmdVVEdTVxUlZmOHpJ?=
 =?utf-8?B?TUc4a29KOHVwcEdRYmlwenczTEMzYnpOTzY0cVZiT2x0QXNhTWtrWFVweEFD?=
 =?utf-8?B?SjYvSWJzRnowTUJicGtzUmdzOXhmb2RzMXZjUVhuWEY5UDIxSHNCbjhlY0Nq?=
 =?utf-8?B?L0NxS2dydXA1M2NlQjFoNDRadzVtQklPZmZxVEFOWTZiQnR5WkIxSTF6bDFl?=
 =?utf-8?B?ZStDaUcyOUs5cWlkaCsvcmxBY2tQY09CYTV3UHBZRWk1L1N3RngxN0pQSUtL?=
 =?utf-8?B?bFBlVHhSWVlXbmg2akJnODhrcjVhbm84Qnpvcmh0K09SaGtld0xGYlZOeXJa?=
 =?utf-8?B?aFl4YnY2UHRxR1ZtV2tmMzRYOVkzdi9uRkhPZkdZaVJlUUFqK3lxWThiVEFn?=
 =?utf-8?B?YkcyRTVndy9rdnlSZW1MZTJaU0RVL3g2T0RSS1RFWm1rM21xOGVvUkFwbWpw?=
 =?utf-8?B?VWgwejljZ253SHNqQVIxaTNTRUY3dnl4VzBEcVg5MFcxOXhqalRDUUFGTHFS?=
 =?utf-8?Q?Pn3Grg7EcsvL4C6pPtjPr2bJ9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RXkCRUKLew9AFYd8YNfy5qruTHqUDQMojgpAW2dWoRk0Yc2zOYQ+owisXN4H+HjPsQ3Ok7PooJ63biFMbH4QvpHpfIl1+UUqOZi1DHr2u9v29nj6nbD7KtVXogjt+D8wMrDirJ7ib4n5CXo6AYV6MzaOwxztrI3wbSVhVt2VzSYmMkXv65XeJlZ8f458meGLeP58xgNSBTBm5sfu76k6zSnwhN8AP0Wrbs0ad5XC+mK0GlPJSfyUyNrBF8UzH2BIeXpsdHu34lz4Tgn8CfOyY0Wt6mBoKKmgoZGDSgVJNlDf956bujtafgSqF3ee9dg2VJ+LuSYssoYqU9vxUYPayYNmm9j0lMFiJVKRIhzmq0BJqC0bGqFEfo6BHLdlSZCQS/9g7UGeFmQbb7u6aGBVi/VqKv1TVVstMElNWJrGD4p3De67FNiF6dv2o5+aaWjddHf8vru365k83cZ/kcaw7IjqHIR7ilzxbyKa/F+oF7S0O8bKOii+zbhPb6ejqO+vQgnBR98xTvmhM1p4RLUFUx+oVkNEU1n9y5A7jyeAs7vUZcC4uK2BvxUrseJGbfeldq1U8xAbltDtvyQN/h20DLY2ekhn/mbkylYHFH+c3SlNNKZSALcvs8KvKv1IpRWm6w5d5VYahnpHKslsFiRWnEExtMJWdKS8Vzvg5ZnSj7UBoWPhJdJhU/rP39B8vJ661TvHYaUArfekPjn4wTDOZHfgxETSVR9VfcyYqdfUKZgBj9fmQZCuU0mfypyO/FEDg32nw9zlwZyU8ghfl6bf8tpeCofLQylJWUrV6WOBdX08QepdOL8J1f/RTeSNWxYA5nDSfHsjnGXgFKJM1oeBPg8tZwBeZ5oSbOHyGaby35w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565d6354-c7a2-411c-5cf5-08db1bc7f0b5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 09:16:15.7665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vKvULwHnq4lAA9W56INcocfhviZdttMDsccw/2jk9b9x2EQA5Cb+GX87AJEodjUBS8LZ4twSpilE/qtwMzLuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030082
X-Proofpoint-GUID: EL4QQVvViQSm8SisFCp4Ui3JdzrT_uqI
X-Proofpoint-ORIG-GUID: EL4QQVvViQSm8SisFCp4Ui3JdzrT_uqI
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
> struct btrfs_bio now has an always valid inode pointer that can be used
> to find the inode in submit_one_bio, so use that and initialize all
> variables for which it is possible at declaration time.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

