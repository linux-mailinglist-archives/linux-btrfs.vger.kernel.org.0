Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B555869B666
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Feb 2023 00:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjBQXVW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 18:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBQXVT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 18:21:19 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF455F269
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 15:21:18 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HLiKXZ031819;
        Fri, 17 Feb 2023 23:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2iYQ6izU3g8VByqRh3a0hDBTGEIo+zU42dDdH448ovg=;
 b=iBhQYOcBtuxbjCKkQHyIggJwMN3I7WzPK+QCVuQpszTNpYqsXVRgiawEj088F/RyGGgb
 gDr27MDEYfqEKwkcJdHMJMYGyaokRQC+jk9oN4fxT0XBOsX9FnAvHrzHl2eLxs9rpnNF
 4yDOw9VDBwytIuXERP47qWMgu6+N0DSiNAKAHTgLQfF3cf3yyFbdIMehXral0vat6826
 W1fCtP5h3MGx8m70cDgq/ZPmnVxu4wEeI6nlMz1ZLAyBzlA0YA9nfbwUyLZXXAf0hbsh
 tzhJr0TkD9J4ms7er25D/cHjYCTBPyBsnrza8JnUtYBaLyIVJcP+cIW2GCUk42dM6DJA oQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2wa77m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 23:21:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HLMFEX013844;
        Fri, 17 Feb 2023 23:21:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1facuf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 23:21:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+ErnLIQT4eJgrL7GRoyHByQUDoG/5gU9Jtyt/yE4p9PFhQ794izwtAVEKIVu0ik7OKUGTGiPv+I3CvfvL653Xb5BOH1u8U/NldFY0ebvY7a/67Jh04NKufnvIxgiYI8+NYd4PmL6ICJZamjZH+/wNXw3qrbWvjTmwYVfqBNnNZIsJRyPSlCab46MX8/JZ7IBk/YdPFyyCpJpo+NYrf69Qs276jWmBHqzfDjMVs+FGWzdnGCcua7rWVICrlpDh2yT6Wvc40k/8jRuS9mVWsEKs+80cWQxwR6Yaignqh5LtCERUwZt5tRUXyepOaQIK/EP4TS4e1iw71UV/tKK3/hCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iYQ6izU3g8VByqRh3a0hDBTGEIo+zU42dDdH448ovg=;
 b=guEgKue23nmPTgir1ug+h73Bm8fGcdph56ueXDHTaZkYvrA1op9wB1/oivZxxdgYIJ+0P17+7hn1GouS21/gEoWuEfEmgGMCqymJRqmeS5NXxkmn247/mdzTdxCsx9DhWGezxp3OO8n9v/e8cCrF2ExlCKyeRLwSxnzyrxyQiwOjoZVbMAS/9emW0UnEnIwhob6icNUh4X1i+DkFWbcz/LFFxnEGs5+/1B21yOHb/EP4a9l9VfT/3aFyagcfYS5SO6yzHhmvPLKLO1QoD543Gc/ghrj6KZ4bmwq+cUaJmtGVCtyERH4CnS1owklpcAuDgUv3b0W1KJl0KpsrH/0maA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iYQ6izU3g8VByqRh3a0hDBTGEIo+zU42dDdH448ovg=;
 b=ucVg1QTX0jhxFjF9M5BLEcfOxapeGDc575kd8MynGk7hc884tpbad5QZZyr4ALN9Pb+P+MxxWGEz1XY2CuYFi8NLuJUtgWUazxX8ndHteBS+SseGsy6xeJByjbnobrPUzaR5/e5iVGY8jgvxLRtrlpz5vo3g8ZiDfF5TmTL0fSA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6572.namprd10.prod.outlook.com (2603:10b6:806:2ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.12; Fri, 17 Feb
 2023 23:21:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 23:21:12 +0000
Message-ID: <9af03450-1797-369b-f9b9-7b639caf4255@oracle.com>
Date:   Sat, 18 Feb 2023 07:17:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs: make dev-replace properly follow its read policy
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <bedcd1c5bebd452ac43eb4fd385890582622a758.1676617361.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <bedcd1c5bebd452ac43eb4fd385890582622a758.1676617361.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: 7644553c-525a-4817-cd2a-08db113da875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6im23YNcGbvKUYsiF7ONj1sMtyuOQJTt+3UJBJECoSf50n2bNXpyF0ekxAyEQwaq1vOq9EBbUJRrvMdzHGjT1et3tjOXVTpeKeH5B0uI8KUs04exPh7GBp6xlnUxm41FeifmKBEGyDs1yAll8IKY6V6fCLMyDoAv2aseKb37Kw4ZjDC+lw9AshbXfzX02mfOgjQQKixe5mVE3ENyEPm0gd/e7B76bA7RQMLLp+77xs03AhBFGiKtAPH1HXkeJ47D/DDtzqjbUoM+IYl57xIUChdYGH+QpAeOkNR0e+aYdh/L1a49oq798EYu5vi/hocIy65H8J3Y0kgZnY8AsDHCYPzEufL0/n5DLHAYaXEQkFzJlvxaFl6Tix8ZD+hRKFJY9HfSOvKwzRorXAEJYUtSDlXgLCtAobxyijHltil4AoXwAcunpLnUzizhRvPJYUl7vBLY/AbNhZoJm8GnvnpbQtqXYsYk5n13y5YtiMOL+DvDRRDpDxUkP3TXYbZOXezzVqBfXhbKA95/ikPMisCaw6y4URPlktbROYOtkrT/xhiAuYuUnzomzaBrQA+/9/PVKXSJSQZMTCY3azNYGP40S3y4OF/I2SpL1zJeiyuHsOrWpMFZ5FRagH0dkkPsxerJsSx1h9GYPebnlXro/fcM6lHapfKP9rpa6AhTb3CwStpQKRh7NGhUItd74OayT1twrUBhhrzPrfz5zmqzPeEMwQ0/DPmaNFecz++IlNq3xE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199018)(66476007)(66556008)(66946007)(8676002)(86362001)(31686004)(31696002)(38100700002)(2906002)(2616005)(6486002)(6512007)(478600001)(6506007)(6666004)(5660300002)(316002)(36756003)(83380400001)(8936002)(26005)(186003)(53546011)(41300700001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFNXb2ZYZlFVYXVpQVNETUZLcXdXT0VDT0cxUnlpOFhpc2duN1BHaDAwU3Jr?=
 =?utf-8?B?bENkV2F5NjJORWNJNHpqU1QvN3hqdTNRa001MUxka0xKNGNLcVlIYkg5KzRn?=
 =?utf-8?B?bG1lK1N0cmI4bHBGUm42aWNjeTFtZUNiUHFqbXorazlzN20zVWRjYnNxT1RQ?=
 =?utf-8?B?c2NtQ21sZEdxWVFZc2wweEt5cXIzNnNXQzBmaUtpNEVnNTRSMmJFRDdlNjF1?=
 =?utf-8?B?dUFYaEQ3c0NyZ2xMWlNoVTYwV09wSmpyZ2RxeEg1OHp6KzMycFo0MHhGR1NY?=
 =?utf-8?B?L0VFRnkyY0c1SncwZzZLVTRhN3kzQUZ3K1JBTXp1ZXpBU0Y4R1ZhVXI1RHI0?=
 =?utf-8?B?L1VpeUk3dUVncFJTb0pvUVhmRXlXT0tOQ2lEMUpDUHpOVnRwZHp3aUsrWndL?=
 =?utf-8?B?bktaWWxFQnBSNGdYbW1XcUVieXdNWlNOYlQySGdnM1pLM1NNL2dVRVBoaEx6?=
 =?utf-8?B?bW5pSDlrRmo1QzlZa3Irb1JyTnA1Q3RFN1E3b3VBMEZvRFN6RHJjdlFkbFlF?=
 =?utf-8?B?N0xyY3I1bVdRZ3hsTG5FNk84dlN5Yk9zNEZabFJvVnBYRk5wWmpGOURDVzEx?=
 =?utf-8?B?a0s0ZDIxc1g3RVdtbFZDeU9zcWJGZ1pmOWRwWklLU3JUZmVQZkNoYy9MaGha?=
 =?utf-8?B?ZkJGZ010S1czUmx6aCtEOFFiaHRGN1ZPOGxaNk0zS3lBVUFFOWpKZ1RkdXAz?=
 =?utf-8?B?Q2d5dUFkVUtlaUdsUU5kYWpXSG1TemxjSlhaUFBKb0JqRDd0TUkzUEFMTUFn?=
 =?utf-8?B?THhuS2k2WUorcWdtdXpxZXVhZ0ZLMlA4YnN2b2M1THVJamZtVDRDa0I4WXlL?=
 =?utf-8?B?eDN6SVRvcWFRQVJVZGlxRkYvbGFnYXhuaGMraDVCUHZGU3pJUlN6U2xkZ0dC?=
 =?utf-8?B?T1E1aEhOVDRZTDVHdWI0VXJFbW81aHdxQkl1ODJ5cGc5dkh0WTR3Wnh0M3Jm?=
 =?utf-8?B?aGh6NkdwejNZZVBKbmhzMUFBNW9nMmJOaU9MZmJJSFlJdHZzQTJlS0k3M0kv?=
 =?utf-8?B?ZlRMYjRuTkducXA1U01tOFZTWGxWakc2cGE4L2RNb1psMTBJYVozVkFDVWdL?=
 =?utf-8?B?TXRmeTYrbi80bnFoMFVSTGZsVno3L1JMc1BBNWlFOFA3UmhLYkhIZHJmM3Ra?=
 =?utf-8?B?eEtUbHh0TU9vam1IaFpPM3owbkRtV09QNUtkL2pPN3dDMmdlK3hKWmZ1Tith?=
 =?utf-8?B?V2E3c3dhZHVLd2hlMDhDUStFemw5Ui92blJGbmx5b0FUaTVPY0h5NjFPM0Rs?=
 =?utf-8?B?Y05FeXFUNnplVlNxb2thWXdCN010VTVQbXlTMzlDMG1vQlA1OWl3NEJhd0FG?=
 =?utf-8?B?cTN1MldIYlQzbS9RZC9Ja2NkRVJUWHlGbVl0MExkdnBFT2NibFAxKzBhTCsz?=
 =?utf-8?B?aVZZK1BHT29yRzhHWjZsa25qSlUzdkVSVTJPQUxqNlRRaHNuOXJLYjNUeGRI?=
 =?utf-8?B?WU5uOHIvc0htZmFSbm5iQ2UzQ29pODl4TkxwUFYvZ09STHEwTVhONDFveVVy?=
 =?utf-8?B?NTBXdVpnYkVWTEJkZG1IaTM5WmhqbG9wNzJUR0VWVFppYWQvQ3JndngzR2la?=
 =?utf-8?B?KzlkWVl1enBISVRUMEV2SDBHL3hhYUtSRnZZM2RWOVdaN1hQWHZkT3M5SDFR?=
 =?utf-8?B?NmFvSTlyZXhWSDJxcHRaMDlQbTVRL1kzOEVWaWpVKzNTYkxidW13OWl0SFZ4?=
 =?utf-8?B?OXRteWZrNUlZZ0pzMEgxYlJaWjBOZTQ4V2p6VVAycEtXQnMyeVQrbGNXbTdL?=
 =?utf-8?B?MEdwZzBlMnRpaytCUGlkcGdSVGNoWlRpS3BTSkcvd2xxQTc3NzNkL3NaR1hI?=
 =?utf-8?B?SHJ6NjRnUzlPZlBOOU95NkttdGJEZTVMcWplcGpEOEsrTU03OXNzc0dxeUVS?=
 =?utf-8?B?bmkzb1FXRlBMZzN3Zm5ONUJsSDZ6YUh5ZklVSi92U3YrSUJ6dHRqdWpScmhK?=
 =?utf-8?B?dXU5R2hNeHBaUm9OanBJT2J5b1k4VW9DUUpEWXNNMG16ZmRaREhhYTQ1cURW?=
 =?utf-8?B?cmhaTTFUMWhKZUZLL3dacGxPRkZxSFhEMGFNdjkzRGthaVVvSEp4SXg1NWVl?=
 =?utf-8?B?MmUzMi83Yk5ONGNMeE94K0lYWmtqaWpOeXl4UU9ZSmtqMzF0RFZsc0xTdzdS?=
 =?utf-8?B?bllsTVVJZjV0T0p1ZFNTU1BVeWtDWjNFRUlMeTdDallvdzhqa3dxOEx0czhP?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hmLPXPzdy1ve0SBftXwIPSt5POsEVj3cI9K7p3VpUSj5U39nlFlVLhNjE9Ci8HLTfGZ5J+3NuS1FZ92d9QFsSuKRzSpZEj4Ah8uhuVeEk0TKrrLUq61HUgocSlGLM66O1oE+XKGd9LRMDrLQprTRskvMU70ypk0PKJLizubbeJSJ3i2pIhwl6GgW3DKzEqdxhAdl6z0KN9MJQJYZBJS6IXW/FbUmpHOxtxJBIhPyYwnTgdKiN+gL/94kIO222xVh7B+SGIqN8uHT8GXQciTFokWA7lGNF413M76ysw4m35Ez+MWZOCmSiYBUJfhuaeGB6sH8rdv/Uz+cmHGtxXUlMLrep9S/0wRVdEjyGiodGIRMg3kvlHQutVjrbKYUf3ytzzukRDUORbJQdy6Ys5UmgFhllk/uE50TjqmVzZ+ZnaHrwdCsDoa7NaUZrAK/fqsaUbWSdXn/q6q+c202HbwfADBe1YDGlrR51X0Ny5TJmgqLuS3ZxCgS46tm6VWakZZ0TKTO2l670hpEqPcoFcqHNbnAoJ6S6bXQDRnO8QGYc5scCqyu1C/cFeL/gRbXs5EwHDf93FHnaR7169W980PLop6e7Bej7KwiSFuSiv2sHg0ZYvXjjQbNy1UojVL3jaoD/pZznBPxkUoU+Mhi/rW+am9BdI8ozI4FYH7g/qSYLq0DdKliXqLv8LqZVn9iWnAfnf/7hsyHr+TpI/bz8IXVFJSdanaTaQp/jm0+vHr/Zi7kLgoJ/CvDDn3H2nnhKxqjdxlVY70wJoy+QfNsYXYKW08o5QNj5Uxt0sAH5DrJl/A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7644553c-525a-4817-cd2a-08db113da875
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 23:21:12.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ix7qCpEDLTUG8WJBHL5WXw7LBjRhojj3kZ1laOyfBbIq1yjcsv6q8LPjkuzB0IFF/gwU9VfyYPcUn3Qt/pNJfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_15,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170203
X-Proofpoint-GUID: TQy0yOaEMANqV1q4CC6H5hOu8O-jlyKp
X-Proofpoint-ORIG-GUID: TQy0yOaEMANqV1q4CC6H5hOu8O-jlyKp
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/02/2023 15:04, Qu Wenruo wrote:
> [BUG]
> Although dev replace ioctl has a way to specify the policy on whether we
> should read from the source device, it's not properly followed.
> 
>   # mkfs.btrfs -f -d raid1 -m raid1 $dev1 $dev2
>   # mount $dev1 $mnt
>   # xfs_io -f -c "pwrite 0 32M" $mnt/file
>   # sync
>   # btrfs replace start -r -f 1 $dev3 $mnt
> 
> And one extra trace is added to scrub_submit(), showing the detail about
> the bio:
> 
>             btrfs-1115669 [005] .....  5437.027093: scrub_submit.part.0: devid=1 logical=22036480 phy=22036480 len=16384
>             btrfs-1115669 [005] .....  5437.027372: scrub_submit.part.0: devid=1 logical=30457856 phy=30457856 len=32768
>             btrfs-1115669 [005] .....  5437.027440: scrub_submit.part.0: devid=1 logical=30507008 phy=30507008 len=49152
>             btrfs-1115669 [005] .....  5437.027487: scrub_submit.part.0: devid=1 logical=30605312 phy=30605312 len=32768
>             btrfs-1115669 [005] .....  5437.027556: scrub_submit.part.0: devid=1 logical=30703616 phy=30703616 len=65536
>             btrfs-1115669 [005] .....  5437.028186: scrub_submit.part.0: devid=1 logical=298844160 phy=298844160 len=131072
>             ...
>             btrfs-1115669 [005] .....  5437.076243: scrub_submit.part.0: devid=1 logical=322961408 phy=322961408 len=131072
>             btrfs-1115669 [005] .....  5437.076248: scrub_submit.part.0: devid=1 logical=323092480 phy=323092480 len=131072
> 
> One can see that all the read are submitted to devid 1, even we have
> specified "-r" option to avoid read from the source device.
> 
> [CAUSE]
> The dev-replace read policy is only set but not followed by scrub code
> at all.
> 
> In fact, only common read path is properly following the read policy,
> but scrub itself has its own read path, thus not following the policy.
> 
> [FIX]
> Here we enhance scrub_find_good_copy() to also follow the read policy.
> 
> The idea is pretty simple, in the first loop, we avoid the following
> devices:
> 
> - Missing devices
>    This is the existing condition
> 
> - The source device if the replace wants to avoid it.
> 
> And if above loop found no candidate (e.g. replace a single device),
> then we discard the 2nd condition, and try again.
> 
> Since we're here, also enhance the function scrub_find_good_copy() by:
> 
> - Remove the forward declaration
> 
> - Makes it return int
>    To indicates errors, e.g. no good mirror found.
> 
> - Add extra error messages
> 
> Now with the same trace, "btrfs replace start -r" works as expected:
> 
>             btrfs-1121013 [000] .....  5991.905971: scrub_submit.part.0: devid=2 logical=22036480 phy=1064960 len=16384
>             btrfs-1121013 [000] .....  5991.906276: scrub_submit.part.0: devid=2 logical=30457856 phy=9486336 len=32768
>             btrfs-1121013 [000] .....  5991.906365: scrub_submit.part.0: devid=2 logical=30507008 phy=9535488 len=49152
>             btrfs-1121013 [000] .....  5991.906423: scrub_submit.part.0: devid=2 logical=30605312 phy=9633792 len=32768
>             btrfs-1121013 [000] .....  5991.906504: scrub_submit.part.0: devid=2 logical=30703616 phy=9732096 len=65536
>             btrfs-1121013 [000] .....  5991.907314: scrub_submit.part.0: devid=2 logical=298844160 phy=277872640 len=131072
>             btrfs-1121013 [000] .....  5991.907575: scrub_submit.part.0: devid=2 logical=298975232 phy=278003712 len=131072
>             btrfs-1121013 [000] .....  5991.907822: scrub_submit.part.0: devid=2 logical=299106304 phy=278134784 len=131072
>             ...
>             btrfs-1121013 [000] .....  5991.947417: scrub_submit.part.0: devid=2 logical=318504960 phy=297533440 len=131072
>             btrfs-1121013 [000] .....  5991.947664: scrub_submit.part.0: devid=2 logical=318636032 phy=297664512 len=131072
>             btrfs-1121013 [000] .....  5991.947920: scrub_submit.part.0: devid=2 logical=318767104 phy=297795584 len=131072
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

Looks good, but the term "read policy" conflicts with the actual read
policy, despite not being related to it.
Would it not be better to use a term like "replace read mode" instead?

Otherwise:

Reviewed-by: Anand Jain <anand.jain@oracle.com>

-Anand


>   fs/btrfs/scrub.c | 131 +++++++++++++++++++++++++++++++++++------------
>   1 file changed, 97 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index ee3fe6c291fe..f9f86893f6bb 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -423,11 +423,6 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
>   static void scrub_bio_end_io(struct bio *bio);
>   static void scrub_bio_end_io_worker(struct work_struct *work);
>   static void scrub_block_complete(struct scrub_block *sblock);
> -static void scrub_find_good_copy(struct btrfs_fs_info *fs_info,
> -				 u64 extent_logical, u32 extent_len,
> -				 u64 *extent_physical,
> -				 struct btrfs_device **extent_dev,
> -				 int *extent_mirror_num);
>   static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
>   				      struct scrub_sector *sector);
>   static void scrub_wr_submit(struct scrub_ctx *sctx);
> @@ -2709,6 +2704,93 @@ static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
>   	return 1;
>   }
>   
> +static bool should_use_device(struct btrfs_fs_info *fs_info,
> +			      struct btrfs_device *dev,
> +			      bool follow_replace_policy)
> +{
> +	struct btrfs_device *replace_srcdev = fs_info->dev_replace.srcdev;
> +	struct btrfs_device *replace_tgtdev = fs_info->dev_replace.tgtdev;
> +
> +	if (!dev->bdev)
> +		return false;
> +
> +	/*
> +	 * We're doing scrub/replace, if it's pure scrub, no tgtdev should be
> +	 * here.
> +	 * If it's replace, we're going to write data to tgtdev, thus the current
> +	 * data of the tgtdev is all garbage, thus we can not use it at all.
> +	 */
> +	if (dev == replace_tgtdev)
> +		return false;
> +
> +	/* No need to follow replace read policy, any existing device is fine. */
> +	if (!follow_replace_policy)
> +		return true;
> +
> +	/* Need to follow the policy. */
> +	if (fs_info->dev_replace.cont_reading_from_srcdev_mode ==
> +	    BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID)
> +		return dev != replace_srcdev;
> +	return true;
> +}
> +static int scrub_find_good_copy(struct btrfs_fs_info *fs_info,
> +				u64 extent_logical, u32 extent_len,
> +				u64 *extent_physical,
> +				struct btrfs_device **extent_dev,
> +				int *extent_mirror_num)
> +{
> +	u64 mapped_length;
> +	struct btrfs_io_context *bioc = NULL;
> +	int ret;
> +	int i;
> +
> +	mapped_length = extent_len;
> +	ret = btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
> +			      extent_logical, &mapped_length, &bioc, 0);
> +	if (ret || !bioc || mapped_length < extent_len) {
> +		btrfs_put_bioc(bioc);
> +		btrfs_err_rl(fs_info, "btrfs_map_block() failed for logical %llu: %d",
> +				extent_logical, ret);
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * First loop to exclude all missing devices and the source
> +	 * device if needed.
> +	 * And we don't want to use target device as mirror either,
> +	 * as we're doing the replace, the target device range
> +	 * contains nothing.
> +	 */
> +	for (i = 0; i < bioc->num_stripes - bioc->replace_nr_stripes; i++) {
> +		struct btrfs_io_stripe *stripe = &bioc->stripes[i];
> +
> +		if (!should_use_device(fs_info, stripe->dev, true))
> +			continue;
> +		goto found;
> +	}
> +	/*
> +	 * We didn't find any alternative mirrors, we have to break our
> +	 * read policy, or we can not read at all.
> +	 */
> +	for (i = 0; i < bioc->num_stripes - bioc->replace_nr_stripes; i++) {
> +		struct btrfs_io_stripe *stripe = &bioc->stripes[i];
> +
> +		if (!should_use_device(fs_info, stripe->dev, false))
> +			continue;
> +		goto found;
> +	}
> +
> +	btrfs_err_rl(fs_info, "failed to find any live mirror for logical %llu",
> +			extent_logical);
> +	return -EIO;
> +
> +found:
> +	*extent_physical = bioc->stripes[i].physical;
> +	*extent_mirror_num = i + 1;
> +	*extent_dev = bioc->stripes[i].dev;
> +	btrfs_put_bioc(bioc);
> +	return 0;
> +}
>   /* scrub extent tries to collect up to 64 kB for each bio */
>   static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
>   			u64 logical, u32 len,
> @@ -2746,7 +2828,8 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
>   	}
>   
>   	/*
> -	 * For dev-replace case, we can have @dev being a missing device.
> +	 * For dev-replace case, we can have @dev being a missing device, or
> +	 * we want to avoid read from the source device if possible.
>   	 * Regular scrub will avoid its execution on missing device at all,
>   	 * as that would trigger tons of read error.
>   	 *
> @@ -2754,9 +2837,14 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
>   	 * increase unnecessarily.
>   	 * So here we change the read source to a good mirror.
>   	 */
> -	if (sctx->is_dev_replace && !dev->bdev)
> -		scrub_find_good_copy(sctx->fs_info, logical, len, &src_physical,
> -				     &src_dev, &src_mirror);
> +	if (sctx->is_dev_replace &&
> +	    (!dev->bdev || sctx->fs_info->dev_replace.cont_reading_from_srcdev_mode ==
> +	     BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID)) {
> +		ret = scrub_find_good_copy(sctx->fs_info, logical, len,
> +					   &src_physical, &src_dev, &src_mirror);
> +		if (ret < 0)
> +			return ret;
> +	}
>   	while (len) {
>   		u32 l = min(len, blocksize);
>   		int have_csum = 0;
> @@ -4544,28 +4632,3 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
>   
>   	return dev ? (sctx ? 0 : -ENOTCONN) : -ENODEV;
>   }
> -
> -static void scrub_find_good_copy(struct btrfs_fs_info *fs_info,
> -				 u64 extent_logical, u32 extent_len,
> -				 u64 *extent_physical,
> -				 struct btrfs_device **extent_dev,
> -				 int *extent_mirror_num)
> -{
> -	u64 mapped_length;
> -	struct btrfs_io_context *bioc = NULL;
> -	int ret;
> -
> -	mapped_length = extent_len;
> -	ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, extent_logical,
> -			      &mapped_length, &bioc, 0);
> -	if (ret || !bioc || mapped_length < extent_len ||
> -	    !bioc->stripes[0].dev->bdev) {
> -		btrfs_put_bioc(bioc);
> -		return;
> -	}
> -
> -	*extent_physical = bioc->stripes[0].physical;
> -	*extent_mirror_num = bioc->mirror_num;
> -	*extent_dev = bioc->stripes[0].dev;
> -	btrfs_put_bioc(bioc);
> -}

