Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FA7756CB0
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jul 2023 21:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGQTCs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 15:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjGQTCq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 15:02:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6DAAF
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 12:02:45 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HIws3q027237;
        Mon, 17 Jul 2023 19:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aGf+xkqH8IDLltD5Psy0yUFLSv0m+avwGR9bNM2siOQ=;
 b=GCsQkM2mngL+Y152/tQuSbigJX1ATTGYFELfKlMoW3FNJWGu7tXVBfZEKx9YWdgOAc17
 rmO0+74ZtkBWF1zciNrqkcSvKfIxCuuG6lPjFnGpzbVbRH6funuIxy+6DnzXnyz8QfSv
 BGNPLUTcPbYCQy/RsERXgZw2WsFJh/uQZlJWyk4yk8o5JjwrCQIhpreXFH6pyuzafMeO
 hkolCF+SCl+BtR6rffej4YriB6OLDxwknCgwTjEp6oACNlCPGMOYRwS4Qwu2ags2MfnY
 txOMvX6oBwj5C1h22UsFJIIVVcL4KHaLJeH0FPxcvzWTraMJ8Hzc/GOU1ZDHf99iYz3p /w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run88kevc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 19:02:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36HHsv8S019170;
        Mon, 17 Jul 2023 19:02:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw4k7jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 19:02:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8QOC5wHvHw9aSZtcU0cSg/N6bUndSOzRa0U8DaFk7TGHUp9StOqt6NpFrN9ktQ2w05qb/hdjPr8ejbnOqV56MLn+r0qiUC9WpNrvQlzjNkFTUoEQwel000GpZVk9y9Qt3ki+Pfh86LI4bKomw3j7gSzA3BtE3dPfjWzDcLDG/uClwrtB1tHGfTnQnqLSJZEoChRBdduxN1tHbg8+8o/dTtIONwpr7uPySYCLGwuWp9measN7HYIXaA9LFUvyqaRmVcOLsH9NjBRbBPMMSvzf+Cs9yuaP+tnOsT1yMoR+uhYxD/azcrLSNzCoqQJHTByfNY9MKvGm7uXVJxZNt3lXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGf+xkqH8IDLltD5Psy0yUFLSv0m+avwGR9bNM2siOQ=;
 b=X4mlfd3/8xavYGRrsrEvoqV8OVVuL2nNgTS7ryM6cwrD9R1jqkMJ7yInCEAQWm95To8DHkHBSof59oUrVoANhNovRMokLcyUBxnWKZ1rFBGq/uL+AtxXMfB+Y1H4pZH+H7/YU5PLVcE+GCiXlE2m5pVMuB+iZDwXrrOm5ow8Eje4JSGXzuLa5xdxvw+3eudP1EyE1+rUB/qKm+tlLlrwwdj8FRwCyLdrsk/KBxVtP8akRAsnBexQuFg2uHlPyaoL/tHHajdzG+omgnQ8e8Gtj214jBOdhTAP6d6N9rND7k+33SVLMMjbMQPUAueMfiy34dN4vUDcZ8hzWPNBbLdh5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGf+xkqH8IDLltD5Psy0yUFLSv0m+avwGR9bNM2siOQ=;
 b=DzfZ+9w0rIc5D0MA/OMB1gFPhLCwz/82RpXFOk2gE4IUUdEYXPlyE5zKDMEHLxstELkZJoIywHFEoCIZgo62X/Zl3E62a9iJZYCGsVmqSqI75ueBFjywDPumzxyAR1VX7kI5KSXxj1rLKJdlWht8eNgB8xEeBy5al2XUhHeIDno=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4633.namprd10.prod.outlook.com (2603:10b6:806:11a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Mon, 17 Jul
 2023 19:02:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 19:02:39 +0000
Message-ID: <c348c7a1-d8dc-3351-c690-4b50875ee9f7@oracle.com>
Date:   Tue, 18 Jul 2023 03:02:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 05/11] btrfs-progs: tune: check for missing device
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1688724045.git.anand.jain@oracle.com>
 <3b6a812b25429342811a22687245c9732a715a8f.1688724045.git.anand.jain@oracle.com>
 <20230713184956.GD30916@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230713184956.GD30916@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c62cc1-4c65-477c-f484-08db86f86413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TbWef35VBtmICUAsZFPYmuRSoKggl+HAlrUKpk7OpgqnrHexYD7QMoxCIxm4/fqXPgcqdLlWi3mRMbTDq7zqVpjhDYOn0xzoTjpdoEcdMuBI2WqXPiYd+/9mqoYF37P2coizkcO/mN/kk8DUECZWcM9OZaj8f8J4iSfipvJwKDrhNHrLSJhMiuMoushH7l/RLbzlcf2q5XaxQyTfauIU9zWsBxz2MdcTSoJeHletR0GJpxxEOYXFZ4IbhiLxHAB/a2hYIrIjbZE+t2YfFweo+KPHVCX97DFls8ygk71mfLiijqd0nDXS5aXpE1c1n3IGvVk8a05EOERMtevRYRRBAbmfbsVVKrLOl2zU6GvVUhdpNUiQbIe6HY2u+ywmlhMcFwtkxLohsPDOWIhNgBf4E8Sq5OdwwkPqBFjh3adt9APOP8jgpZVVJJfqtrwRcYOrNaBd+sTxwFhz98nPH932gnK3JPOIMA0V9l1NhIxtc15f5IUqrAN9WkdDjJmpdgBapIstD3ZHYIcU+4dhmUhD5NiesSaU5BPQPwhYhCRGUYQiOidECpzoLAbJB3Gl/3S4HS1IYwJSw41icb26pOKQzGP0Tnf+ehqRshCpHs6juXBk2FsS6hsPYHcXrSjFWLtpseeyXZiSmMlJl8MDamoJ+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(316002)(6512007)(6666004)(6486002)(44832011)(4744005)(4326008)(38100700002)(66556008)(2906002)(6916009)(36756003)(66946007)(66476007)(83380400001)(2616005)(31686004)(8936002)(8676002)(5660300002)(186003)(478600001)(53546011)(86362001)(31696002)(41300700001)(26005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG1vc3ZFSUsxT09GRE5GTG1JTTduWVhGb2NvTGZ3emZOOEowZk9aTUVQcm5E?=
 =?utf-8?B?cStLeFVLM1FmT2hVMTJIRDdUc204VDh4RUdyRmI5RWd2VXliNjMvK0toVmxt?=
 =?utf-8?B?TDIyaTlCMTRBcFdySlp0cmdFZi8wMll0RlExRXhGZUZtWHZWdGE0U1hTZ01J?=
 =?utf-8?B?SGtZY0VHbnp2Tjd0RUlrb0doaW45V1pmMXd5b2FDWG9LVGVGaHB0eXh6NTEw?=
 =?utf-8?B?NkNjcEpabWpBaklvMU02VjRrRU1ZNEsydk9COXlMRHhtazhqZmlReFdCT3B5?=
 =?utf-8?B?ZUF5N0lZZytzR3hGSlo0bU1mOVAyV2w3bktENWtsMWRkQVRNdU4yRExkODcx?=
 =?utf-8?B?aFZRckVUR1p2d1BsaVRJRXowWGxlNjVjdTJMWnNXU3ZWRzN2b0NZVjl1YVdC?=
 =?utf-8?B?NDM2SHlrOVdiQ3VjTjRsaHl5Y0xxbGhhWEJRai96bXFjWjl6cmJIaGM0akV2?=
 =?utf-8?B?cnEzRVhPS3FyY0txd1Q3bFM2WVpOQ09IZVQrbHhoZTFYVzRIQWtERnl2Lzht?=
 =?utf-8?B?VmNtYWQ5ajlRcU8xTlM0R2R2V1dPWGZrNkpxd0wxWFBSN2RUZGQ5UlRTNXN5?=
 =?utf-8?B?aC9UVHJ3Nzhjak5GeEZqdXh4Y2ZzNzhXVGFuUXVRS1lhUFZyWHRQVjQrNkph?=
 =?utf-8?B?bjQ5SUtWMEI0NkhrcTVLU1REc3VWcmhsZFhDVFBiaWFkeGx2VkhhdW1ML2JT?=
 =?utf-8?B?WkJHakJ6Q2QxcFJBSlVOM3JzYi85bnhaanhOMFI5T1RIYVFtRDJ6NUF4U0pR?=
 =?utf-8?B?Q0U5TklicEJyaEhGQ0pVcHByK01hZ0dNMmRLNWlyWjNZcDFjTHJNamJhMGd5?=
 =?utf-8?B?WkxQMXhGK3J2U0NQbmV3am9LY2haQ3pJb3BtSHZyM0NKWHNhbGc2YU5mbmVt?=
 =?utf-8?B?TWpKU1gyREFnang0MWVYZTRkWEQzU2VUTlJQRzhkL2UxTzVNUGk2QWxHV0VY?=
 =?utf-8?B?WkxmZHoreGFKWldXUVVVZVVBRXBNc1hQWlY4QytFaVU0WEptYWVORW5HRElI?=
 =?utf-8?B?WmZlejdBc3FIWmtLRG5jR1hidWhERlBJc2g1UU1IVUhvcHFsTDh1UXEzUjl3?=
 =?utf-8?B?OUxuQWxuL2NSVDZDSS9lYjlibXVlcWwwaEFYUWRqRk5VVUFTM0VUeGk0bitW?=
 =?utf-8?B?bkVEQ1FPVDdvb0tkQWhRSHVCVjhtSHZvZHRBL05UWHphTmpQNEdnU3NNWTZw?=
 =?utf-8?B?YWQ3VHF5RFVjcE9rVHkyTjlvbXVuTG5ZR3dDL3NKZTdmZlE0cWR0WElGd3dG?=
 =?utf-8?B?d1ZudVMvUStwTnVRVUUzVmNCS1NQS3lpbEkrNE9iVmppdytGV3pvd0N5Vm1T?=
 =?utf-8?B?UG80VG4zZUFIdGlOOFFqUFNXUGlCL1dWMG1ycXorUTI2RjZ1T2JHTTlkc1RP?=
 =?utf-8?B?bHRhT1JtcnMvYTYwNUV2eEt3amE1TE82YzI5VkNYY3lXR3NXTFJiWFFkN0Z3?=
 =?utf-8?B?a1NaWldHYU81cXBFajJURHU3Wjl0VUJSRDl0YmphRVcyZzczNWR3Qm1KOFJa?=
 =?utf-8?B?U0RnTnlHbzB0aEF2dHA2cEExeS9Gb3UzbTBkcmdOdmpid0dKaTF3ZnhHNTdQ?=
 =?utf-8?B?WEFMekgxeGh2RG13cmJhakdwd0lldTViTjUxOVpzcWo1azc1c0dYeWpacUN6?=
 =?utf-8?B?WUZHMU03eDk2eGVITG5Sd1pVYVBtU0VMYXEwL1FjckY5UGI3Vmd2YmVXSG1k?=
 =?utf-8?B?VjVkVWRiOExtcHRvNUwweTd3ZElucm1ZMG40MmFqUFZHSzZCV004SHBXWkZ0?=
 =?utf-8?B?eThrNFgwRGFmOWVSOHI2T0dUZHNlUU5xNFg2aDZOU1BuNmNPZ0ovY3BieWp5?=
 =?utf-8?B?ZTRQVXhxR2pjb2xRbVA3Y2ZWYVRmak5MbW5raHpSVnNBckxsWmljK0pzR1Mw?=
 =?utf-8?B?NnorTG5oUGtXWDBHeSswOCtRQ0JDaEs2Vk5lb0VVM0xTR0hwUlFZTFhxbUMx?=
 =?utf-8?B?YlgyQlhlbStDTzJoMDN2aldvbmhVVjdoTXZwcmdLTTVWYUNMTlQ5WUFIUTNu?=
 =?utf-8?B?Y2VSdVZrVnY1WU55UC9PaUUzaWNDWU1UYlRLbHdIenJrNGliYThwdEdGRjFw?=
 =?utf-8?B?ZzBtaC9nWGY3MlJCTGlOSVcvMFZmNVJQM2V4aU9RNktJdit6SFNlbTNmZ2Nx?=
 =?utf-8?Q?ZMd1fr/78aTZ7Es6zlIsm/DUa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: l0qBLD4Znh22kTGt+jIOQ9RyGYg2ZfKa1e76vcmzKQEObrYvowrVMNTQtXnZrqLXZr2972fS4AUs825xG5U5+fyYNan932GMR4D8CGm18fU3Oi7Bwf2HjEChhTXdTuiRtWVMnSJ+C/b0t/QMFqczczhoVM3Q1p50ckwEAjbIW7H4BUTboscy8CZYhBCYLxdpEFBCDFc8TB+HuQX06c+1FttsrTkphae2YJxO8k/qfpHNkk26+uad66oA2fMnSuUnaXFBfcm6ak4iOwHkQL8cs0nJL+t9mcRKJdaHH/7xiPJQAYtZrkgDup2bQUUwTexyV7MROqZQmrQiImVTXTTPBB3NXf72VMSQO+GO4/RSho0PwCwXaeYItUNxi4GNTMcXkmdvyfKsj9+IxpDfXgU9iRD8XkW21Km2zQ5K2Jnn19DwC7Lu4dj82zvCL3CyRrzdTy+JvatAmMAR699h+N5phCsMULK+MI/BszJ+rMwloaW/VGH6F3ZIHNSJzHC21JuxuT2cGDYRcDPFLikIb1LUdfZ172k3ibEPjwq9EKj9GYnAF/CpLmpm256GKNBOV714Hh5PY/8BUSApg7gcFep+6YYETcJpqU1R3iQIIvAllxLrpnq4wk2tgrIra3r+yrcKeIsGuhmRFqOHQwAmmmnLpsvadqI44aHJTJZZcH4aF6XBEjhbM3B10v+a+0zykkGYWFojRTl8rhv/u8GfhsS0t2Y+dFR5gWYauPj6QJY9ArKzSjCZ0sUrL7nLkF64ahFLM0YWXdszGurtINiT4iZcYjBYvj9Audi3kNqu2/NB7zc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c62cc1-4c65-477c-f484-08db86f86413
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 19:02:39.5262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPlYBw7kmyWGgfGnR+38Tjoh69tjcGmjs20CnF0y/uOQFjv73ixJSSgKiXKMOnQBdaom2xQBj0qsI5fLrT8JYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_13,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=836 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170174
X-Proofpoint-GUID: c5dplJVFB2zJp8BUkKOK-B9G9oPZ2lLw
X-Proofpoint-ORIG-GUID: c5dplJVFB2zJp8BUkKOK-B9G9oPZ2lLw
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14/07/2023 02:49, David Sterba wrote:
> On Fri, Jul 07, 2023 at 11:52:35PM +0800, Anand Jain wrote:
>> If btrfstune is executed on a filesystem that contains a missing device,
>> the command will now fail.
>>
>> It is ok fail when any of the options supported by btrfstune are used.
> 
> Why? btrfstune has options that only change the superblock, like
> feature enable/disable -e, -r, -x and -S. A missing device could be
> problem for others but it should be checked only when it's relevant.


If the missing device generation number is greater than the one
provided here, the btrfstune may not be effective in the kernel
if devices are assembled. So just block those scenario.

Or we can be keep it open and block it based on the use case feedback.

Thanks.
