Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB977B9EBD
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Oct 2023 16:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjJEOL1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Oct 2023 10:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjJEOJ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Oct 2023 10:09:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7196D2810A;
        Thu,  5 Oct 2023 06:44:46 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3950g2ep026768;
        Thu, 5 Oct 2023 10:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=kVmVXBqOhbETpKkVdbOGz6/COHVaPwNcilZP1/SSxRk=;
 b=fmikAPRaC5iLtUHKf7J9kpUex6+WUam/NiPFb/TSFhUPGis2o+a/giGc5ogZ2T/ZijrY
 gzVdWaP2MRhPFVQHUKK+6pW0l9SnIAy8NRYkZxb6k4nYvUkMObp17tQThEwGad8D5Jpt
 D2KJ21LIbtZBocclE94dYg0HnTJVSrvlMlBp44hSk/AGnRZKDoHCJ3NrJnyO14Wg00Hy
 LglVFm6cCNf2vYC7E1yJlO7jVhKo0r8g+8GIjj6OftcPJw16WwpWU5cc8zzICCGaq2UJ
 QZ1CfYHYDjO2HNKBhPcYeAeTxQ19VkvNK8WXvgcoYQEVjX9hmQdwK2PaJUZdFQiCXUvZ yQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3eh6ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 10:54:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3958kXKe009656;
        Thu, 5 Oct 2023 10:54:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3thcx6r1rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 10:54:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDyxhwZf+MxfA0Nc90zYGh0keSiVHqAIGMNNNKyHygaTwSfLxk5F5WqIrmsmhxJ/LOjx3YCdpe0qYZxD30dmI61L4DXI4JjtyxF5AEz4yG8FqEPS1lSpeYHfu/fTy5an6ucR72Td348jvG9E9tweQsqY4SWSpz6qXBPGxJw0d0zpOezR/MO2gOmHXsCrUSoy08UwQpQGhQYLYE6NqbxFimIkU60MaxbrLN3RORNkS9eqNonGlpcZJrc1V2xgXPFwlagUscBLcv69YHHYZgEubagyMWy/385l8Wu/us8R08j6m9tmeaMq7aVFZfcAcF2mbRfVjiiSz+00EMZQIqk1qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVmVXBqOhbETpKkVdbOGz6/COHVaPwNcilZP1/SSxRk=;
 b=mevcTtr69c12eKKxjsnLKkw8OPot1ODnX5iG2kZ3chaa695qiAyzvUu0Ec/HZcWzQw//eynsq3EBgBv0nVVsxcbDFaswbxB3OWnGxWqQJAf2DzvcBnqU8X+klD7p29I56qTImQR8SvWHK9JN6p+Cx7z2P4AiiP2piuKeTPEdEBAA8e2IF5RCbtZlnvLVQmnqjGOKqEf1ya/NTkHEMlrrWxVeRKqb8anSQPFmI6lhX3PgjVg8mD4LnOFmyUBfG0DZ20f4vYVj4xXkPQo2dibk8AUT4KmICYIV8oTRxpOQGAGsh7VIrYBFCGkncWPPorZRuKloPLftz5kKAJeg/bebnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVmVXBqOhbETpKkVdbOGz6/COHVaPwNcilZP1/SSxRk=;
 b=aWMLfz2EYXbuhGhlP3NNNllMUYvzdYEaj/h3Gkrh6bz8mpdh9HMHGhG2JRbTxb6wf9EYS61MJB8nqqeFvllf/oSTUheRORlk1GtGQyNuJ78sX37siPxXqE+aOacWIxJw318yvSYEu5ixlQi+P6GXWwQD5NrAiGEl7CRPS/1KAbE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4408.namprd10.prod.outlook.com (2603:10b6:510:39::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 5 Oct
 2023 10:54:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Thu, 5 Oct 2023
 10:54:54 +0000
Message-ID: <35b9a0c0-1a83-4b63-a494-9b66198f8000@oracle.com>
Date:   Thu, 5 Oct 2023 18:54:46 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     zlang@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
From:   Anand Jain <anand.jain@oracle.com>
Subject: [GIT PULL] fstests: btrfs changes for for-next v2023.10.05
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: b6464c68-11bc-4f27-a77e-08dbc59181e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Np6SybcruF63q7bUu+5/u+OmY+V9AC96Lg2svNpy/JlTmtT7dHIao5VhAl9NYnZmzKuFq+9RdBG3v9aNisCQKfo5WHvjz2CvValQagGUmk96Svo/gO41X4As1WxoWIDTANGkm4hJXGoRBTICio6xiZ+ReVJIRfI8OCLsFlfvetemGiLIKPXgxxRJSpOixWlVZuYHQmSbbCoj2kM6Np19OXxDxeW8fXHJ0fJMwUVaTyOL2HnHKuT/v+y5fq9yEE7BLR629ffhj3gsFkNkJnhircS/uZld5DT2XuaRJc97j4s07cZYm3kGGzoVTgHIncRbRKWUv1nSBXOZI3IqQfXRYVudJf8h/VefWQsd3K0zgUNIZNm65H+Cz1s5cq9Ojnl8BOfxSuw776nsREon3vpY/Z3WxSoKPVYT6XScZwTQRZcZn3uqWmbRBSQ/v0RCQQA1yKSGZJFYVtIvP553nY/mPEGDMYV8CUV3z5wZxlPgzOzQBb1ubJ723slT9Fwm3juyv7NPwXnUUhBCwNIvSTSVNTjkO98y2UuEMyjU7GLJPK712fG+SI2fF5cHr35AWsSSnvQ/ZSDfFTDRqBYdYfKWYpuBuhLlbAyqDGdUI6x4LggF0UL97akhxc4l0ewyXKl17qt/K64rDPYZ+4hua7bdQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(396003)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(31686004)(2616005)(26005)(86362001)(36756003)(38100700002)(31696002)(83380400001)(2906002)(966005)(478600001)(6512007)(6486002)(6506007)(6666004)(4326008)(316002)(5660300002)(6916009)(41300700001)(44832011)(66476007)(8936002)(8676002)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWpBcEhZdEU1L1ladStvTGZ0U3dRMUdXMkJPQXE1S2xDZ0tSQjdvOUpCVGt0?=
 =?utf-8?B?V2F3dzlscDFCaHdrY1hITlg0UjFBNXJGSm1nOFpCR0pLSjV3RGJvYkROT1FL?=
 =?utf-8?B?THFzeDZGVlJ1Lzh1dDRVRVA0VlhJTnplMUk0V041NzRCRXRYSlRFdVkybm8r?=
 =?utf-8?B?Nzl0UVREdExPNFg3dWRZbmlBNzFsYWFCSkdYRWJnUE01YUphYlRkRzQ3azho?=
 =?utf-8?B?Rmd2Vmlzd2drYkd4ejBJSFVBR3hNNmdMbmc1WWQ3MG1YUzhwVjlKVmIrdFpj?=
 =?utf-8?B?MU1ESEVURFZaNXhjZk44QVg5em13d09KMkRIeitiRWMvRVZyVHl6Q0pLUWFL?=
 =?utf-8?B?aHpwbGdCQnppT0pINUtGYTlmS3NoM3FCRmtRUzU1NDdBeWFpWGZnNk5manJh?=
 =?utf-8?B?VFdvVExaN0NKNHU1cjM5UDNMUVJXUEkydTZuVlA3RUpaVmNuY3dtNkhkRFFI?=
 =?utf-8?B?ZTdZUkI5azFvUTBnOEJFZnE1MGRSQmo4UDk0TDEzRVorbElvWFZVLzZ4U2lR?=
 =?utf-8?B?dWhXTExvVy96eFhwYzR3QVBqL29OZXljenAydEpvT3d0bHpKZzVxejJuUkZ4?=
 =?utf-8?B?bUx1ZkJUT3QycW4wWEhRdG11Q0wrYWtRV3VCNGZDVXBhNjdNUExGTmFjdGlh?=
 =?utf-8?B?TTR1ODdNa0pORHF0aXBCRUtrUzN4dWVYcktlK1FiWTFVazdEU3JCZ210ZzhX?=
 =?utf-8?B?dncrOTBmL3hXSG5xbWMyS2x1K3IxQjM1RW1JN1hrR2dRTGVBa2xDN3ZtY21L?=
 =?utf-8?B?cFpqOXBORlk5blRVbXQ2dnhEaEFJcDdMZG1lRnQ2UnVYVHljWE1OR0lDV2VV?=
 =?utf-8?B?emJlY0ordUVqdDRpbXR1cUdxa0loK1ZqRTZzM1ZoTXFvOUozdEVaY0d3Q0Jk?=
 =?utf-8?B?ZVh2Z095RDZ0MVhlMkxvUExwbUc2cE9QbG8reEJiQ1plUGFKYnhUemVjdU00?=
 =?utf-8?B?ZmFVbHhUMytKVERTMzdVK1BIb1JCWjZtRDFaZHMyaitKVUt2UUttUnp3dG84?=
 =?utf-8?B?MmgxMGlxcG9jZm8yTENNemdiWThMK1l2akplUVo4VVJleGdFS0pKOGVHVU5n?=
 =?utf-8?B?d0c0SWNzdmxMQ2s5Q0w4eE1haWxFalVtRGZNc21CKzF3OFE4dERzbWtpVVVy?=
 =?utf-8?B?VDJaNGFKQ3g5S0h1REdVOHVPTkk5c2RWeUxxVHBWUTFqWVZwaDUrd3MvMUFN?=
 =?utf-8?B?dXhFd204OUV0V2MwNFdyOEwveTZzUHI2UmRjN1dpVDlNZnZpbXYvUVIrNWdi?=
 =?utf-8?B?MVNYL2pPdlBjdWxvQ0pnQkdEWnNxL0N3cmJ2TzNqN2ZUVUVNcVdMUXpFOHFY?=
 =?utf-8?B?TlYwV1lBY3JEejVyeFRyTTJPUVVhUnhuL2dtM01jRFowOFQ5UGZmcGVXeElL?=
 =?utf-8?B?QnNYZFR6eTNNWGZDbkY0N3JLMkVkZWJIZkx2Q216ZjBPQnVES21DMHVWMTRx?=
 =?utf-8?B?dnF6ejVnUEt1ZlZVNzhDRnM2UCtnY2Uxbk8yNld6MVQvSHFtdXhZUVlsS2xl?=
 =?utf-8?B?QjY0QmFOSG95d3UxNTYvWThlcjhaSXM3Z2M2V2MvWDFTV05MRFVPRE1hK3pw?=
 =?utf-8?B?RVMwUGQ0OW5CMGZDU0xqUERvUWNyTFZMNURnZStheldXVkhFSDliLy9IM0Y3?=
 =?utf-8?B?UnU4bzN5aVlvZ2prWXg4T3hselpFZG9TQ2dkK0Fyc012RThUTVNFb25rUFda?=
 =?utf-8?B?US9ueTBNVFhoclphWnR0MVkxMjdRd28zRzYrMUxFVFZLa0U5MWlydkZid1k1?=
 =?utf-8?B?S0ZYQVZUYkVvZG11ODVOamhBaVhUMXJrdSt1SmZTUXE3b2RSUS9OOS9Qa1dI?=
 =?utf-8?B?bXU3MGR4dmJraFlWYnJuRWhRKzQ5WW5iTk5SdmRsTzFHbUJHb0FtOUc0d3Ro?=
 =?utf-8?B?N25xc1ZpaVZHaVB3UzJZNkhFZlB6SlNKczJNWklvN0p3S1ZVZXRmdUM2Rzlj?=
 =?utf-8?B?QzJDNFc0TVBmQ1pld2YrR3VFVFFjcS9CY0REZ1krSUNsaCs1bkRmaWtkQUF1?=
 =?utf-8?B?cHQrRW9qRFkxQnRLemE5aVJldHZpbldJd0JZaG9WQzZQKzJsTC90ZzEzMHd3?=
 =?utf-8?B?SjZXZktLTTRCQVdyZGVocGtoL3ZYNmNzNHJaVXpZc1pmYXBOaTNLTi9LNkxP?=
 =?utf-8?Q?zh/soQCVOXGfw6YrS8cE8Fexm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QzudR2zKclM5BnS7X18Q80j+cvdz3wKnMJQfu557JOBwhm/FTmRJY9t+w0PaBVXx6BvCQXMDvUZMv33LcceO0x22JLRX7kvq32Mf5v3MvafmOJShsfdvplF4KvL9nro3w/qXDWvbdpX4FmRXMX9gobqp1vfivix1mTQG81+WTaxqydYm97UCjFdy0lZ08aBg1Yjv65LeHUp1pThy/eZ69nda9ZpUx1KIPUIWA3eAsIWCa0H6wNvj3YEh4rbPGdyYvh8ziGY4rAAXt/Kr3avlE8hUnUQtpmrMKW7n4t2BBdK4nNyi6VwRF2hW9+Uu+F0gJf2CrqOV61zXmoKqTRu/hmtWPTDYR4cg86w5IcqKJAV5gZHS5doLSok8Vrs5ZAYi+Qs3pcf++l9ZshQjicITyX2HWbFsNpAgY2DwO1ulgD0Mpu5DJ/+AA14Ezktd2i2R4aDhQPtnM60vXiHWtidi+Lfbp1vnyuYRvpuDkVNGcVvjV/YSWhiIkNnCXLq3KeOfYrN/ymgVsKf9+8XnvVR11GmVTJPRYm39pqikxh3iPw20MBMGBr5UDRATunDOn03NITsbDPbjSv9XQRCd7AtMNqFl7arnyKxQmw9azoCCL0QkkOt9/KQEbA7Dbm78qtZILG5k6F4FgXJGlCNt1JHGC/WhAJse6tF048FBRAtp2mEvjtkYtbk1cmqO2ka4+ky3FMXs95hBy8Yv99PpkFEB01tQEBtCs+AXboGp292K+bU4lE6Mg/CVkmOFS2E2uHi5sHWqiIqbTyll2mfqM021gqL72o38B+iEjK9VRhLHB0o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6464c68-11bc-4f27-a77e-08dbc59181e2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 10:54:54.6184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycdCXidRR+sFMIcGa19qxF3rsxZOQmhXnJF/PUx7/qj0MZbBZbVaCRfv/LpSr5DFBngW6XVtvlEEibf13xUiFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4408
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_08,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050084
X-Proofpoint-ORIG-GUID: lHlXuk8JiqtOe_7Bs0MuJa5V3om5Ax16
X-Proofpoint-GUID: lHlXuk8JiqtOe_7Bs0MuJa5V3om5Ax16
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Zorro,

These patches have undergone testing and are now prepared for merging, 
based on your for-next branch.


The following changes since commit 2fddeb5c79ff16bf37e1f1d809bd94b360c27801:

   btrfs/287: filter snapshot IDs to avoid failures when using some 
features (2023-09-23 22:13:11 +0800)

are available in the Git repository at:

   https://github.com/asj/fstests.git staged-20231005

for you to fetch changes up to 9750f8d42560a459c89071c6a0bd68bdb467fa49:

   btrfs/295: skip on zoned device as we cannot corrupt it directly 
(2023-10-05 17:37:39 +0800)

----------------------------------------------------------------
Anand Jain (1):
       btrfs test scan but not register the single device fs

Boris Burkov (6):
       common: refactor sysfs_attr functions
       btrfs: quota mode helpers
       btrfs/301: new test for simple quotas
       btrfs: quota rescan helpers
       btrfs: use new rescan wrapper
       btrfs: skip squota incompatible tests

Filipe Manana (2):
       fstests: redirect fsstress' stdout to $seqres.full instead of 
/dev/null
       btrfs/192: use append operator to output log replay results to 
$seqres.full

Naohiro Aota (3):
       btrfs/283: skip if we cannot write into one extent
       btrfs/076: fix file_size variable
       btrfs/295: skip on zoned device as we cannot corrupt it directly

  common/btrfs        |  64 ++++++++++++++++
  common/rc           | 127 ++++++++++++++++++++-----------
  tests/btrfs/017     |   1 +
  tests/btrfs/022     |   1 +
  tests/btrfs/028     |   4 +-
  tests/btrfs/049     |   2 +-
  tests/btrfs/057     |   1 +
  tests/btrfs/060     |   2 +-
  tests/btrfs/061     |   2 +-
  tests/btrfs/062     |   2 +-
  tests/btrfs/063     |   2 +-
  tests/btrfs/064     |   2 +-
  tests/btrfs/065     |   2 +-
  tests/btrfs/066     |   2 +-
  tests/btrfs/067     |   2 +-
  tests/btrfs/068     |   2 +-
  tests/btrfs/069     |   2 +-
  tests/btrfs/070     |   2 +-
  tests/btrfs/071     |   2 +-
  tests/btrfs/072     |   2 +-
  tests/btrfs/073     |   2 +-
  tests/btrfs/074     |   2 +-
  tests/btrfs/076     |   2 +-
  tests/btrfs/091     |   3 +-
  tests/btrfs/104     |   2 +-
  tests/btrfs/123     |   2 +-
  tests/btrfs/126     |   2 +-
  tests/btrfs/136     |   2 +-
  tests/btrfs/139     |   2 +-
  tests/btrfs/153     |   2 +-
  tests/btrfs/171     |   6 +-
  tests/btrfs/179     |   2 +-
  tests/btrfs/180     |   2 +-
  tests/btrfs/190     |   2 +-
  tests/btrfs/192     |   4 +-
  tests/btrfs/193     |   2 +-
  tests/btrfs/210     |   2 +-
  tests/btrfs/224     |   6 +-
  tests/btrfs/230     |   2 +-
  tests/btrfs/232     |   4 +-
  tests/btrfs/261     |   2 +-
  tests/btrfs/283     |   8 ++
  tests/btrfs/286     |   2 +-
  tests/btrfs/295     |   2 +
  tests/btrfs/298     |  53 +++++++++++++
  tests/btrfs/298.out |   2 +
  tests/btrfs/301     | 444 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  tests/btrfs/301.out |  18 +++++
  tests/ext4/057      |   2 +-
  tests/ext4/307      |   2 +-
  tests/generic/068   |   2 +-
  tests/generic/269   |   2 +-
  tests/generic/409   |   2 +-
  tests/generic/410   |   2 +-
  tests/generic/411   |   2 +-
  tests/generic/589   |   2 +-
  tests/xfs/051       |   2 +-
  tests/xfs/057       |   2 +-
  tests/xfs/297       |   2 +-
  tests/xfs/305       |   2 +-
  tests/xfs/538       |   2 +-
  61 files changed, 734 insertions(+), 102 deletions(-)
  create mode 100755 tests/btrfs/298
  create mode 100644 tests/btrfs/298.out
  create mode 100755 tests/btrfs/301
  create mode 100644 tests/btrfs/301.out


