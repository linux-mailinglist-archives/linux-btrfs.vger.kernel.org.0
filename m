Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D677B6300
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 10:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjJCIAU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Oct 2023 04:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjJCIAT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Oct 2023 04:00:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5457C90
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Oct 2023 01:00:16 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3930iJDI027534;
        Tue, 3 Oct 2023 08:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=WqX6u/F9x3GrQPyRpIXKNSvjEZEmnvy514nWtuO5/7E=;
 b=dBlu3EPi8H6ZWGkF0ZmJOmib8JQdszvocIVvNBqRCJGjXEYO2my3oTkU1IE5VYmY5Btv
 +7FFakp02guB6TRrAnWSc8b2y+hC9hY0bIHxASCy6YCRFZrJSZK3A51fUTig/6COHHqv
 xl/qr2gBvETg5GyZ+f4QnyYqQyvCqhCrBopN7Bn8+ikjFkbPC/jCga8y6561Wo/NG5ib
 OWkyqjfBRdu3SEOFARyUbp1xIidEaE3xvUN9vS14wNai9iBqHaptTkQMAf5XMFYe7DgI
 PY/IHmViQsBA9StwlLyztOf3hzofv/N1OGzuwbAYlb49+Jhk+O7Du74yS7nYIzXxX7vp Tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vc24g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 08:00:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3937uLmE005918;
        Tue, 3 Oct 2023 08:00:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea45n1yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 08:00:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIQvuDfStUDwzzl5YpxZc6UvDMUQoHatEWahVSiEoE85Wwj8oKI/erirsyHKqZgh0dFpf8SRK2nfOXr+W1XQyI7X7FjLpMQnu6mjQNH2XT4R7pP9TBJqSMTRDTmKik4OJqhjzLi6L4/ESrZiEDXh5JjSCAJ5kJ0N3gL7esnsT7IXaf7gkxmhEJQmlJuUEoYxj1AWp/aMLCk6S+5QcstlpYOGfE8oH48SbYGiVzQkOhPOFJ0coV3BGYYWKpEc+MhJtIl80BafNwh1FFR/OCY7ElY+iOF32O7y3rNcHZ1i/0EbuDa3gSUkuGtI+OgLQqA0VOMyYMrlRLvviAgXJbe1uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqX6u/F9x3GrQPyRpIXKNSvjEZEmnvy514nWtuO5/7E=;
 b=FVDgRZ2bL8rZZEB3V6ImnuylAOF9I6FCD7Fl69eRxJP64akwEbm5Q9pLM6TpLN5KyT0qMg2yaL+h0IjtE1OdfGnYUYSelv5Lihy7ShB34PP38LBodJTphK2UPfTGNhC9/xGCbbSoFI5Totl8G2ZQOA977bS8RxAzgGDr1U2dmx7r7ZUPOAVrBH6+iKZyqacocrWQH2a+Ir4KKBN6OiqEwMp31oALyeTbWRkGeNMID2cU056g+9p615u8+Uqj/xEFbF37CDQJghEQdD5PH22i9gYgz351KWUfvOVk8eAPxqz17GNi/1iteyY5ttzODOcXQqfhMvbZS1nHXwecUaIMDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqX6u/F9x3GrQPyRpIXKNSvjEZEmnvy514nWtuO5/7E=;
 b=PoE4Zbbh/E6uab4ITvwEQaHrrf9Fx2QzZvNbOput4u0e31trtdGl0soLlLyJ2CurLxJWpVOBeQvZhwsTdMKZdyvfRbLGe0NGYDHFucUSpQ4TYx0iFkFX6pRDQ0Qs0G9NF49uZTtXLGuHuyvIZ64wYFmbyZ3G4g7LdGuV1NUFOyY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5846.namprd10.prod.outlook.com (2603:10b6:510:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Tue, 3 Oct
 2023 08:00:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Tue, 3 Oct 2023
 08:00:06 +0000
Message-ID: <a488ca32-0546-a7a0-62c5-9e1f3b301aa4@oracle.com>
Date:   Tue, 3 Oct 2023 16:00:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 4/4] btrfs-progs: test btrfstune -m|M ability to fix
 previous failures
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1694749532.git.anand.jain@oracle.com>
 <db8c6de3dfda46d9e3c0dbebc7f10a898f8be112.1694749532.git.anand.jain@oracle.com>
 <20231002171945.GY13697@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231002171945.GY13697@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b39d2be-0905-40af-1f2a-08dbc3e6c18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0PCG3SnD60pRz0u5S2IpNyGGgu0wGrPCzhWbYDIZuI2KRT8OIKwyJZp6uR83cMFQXUkUh1kacKHZ1FWipN17dJjJOHka7+bU/dC2zf9deCkQV40ZkXf2gtfiY+eNt9M8C7pdiKKNVGPMo8vo6tlWZ3zufacx+kNKfV5BjZP5wlgq2Dno6QfhfFMUd5qlFFmVg70yIi8LOcZLt0uooIOI44hbX08kGCMUO89VX+3/FkM2DH9iyjoUwklsrcnXEbQY+ZEXvqfu7tLC+m1eUTJ//+uUrGF2i1Wkhv+lqmrMoKmuVBQcpu/9D1SEOfv30B/lrVGlxDJIx8zzr4euIhgfvGaYHz3Lx7+yGU697HR+4TMbCEQKPfVwyH2aC4OzjHtNtQeYuwggX+ZebdC40YEjj8G1N/RmZ8a8EFxHQRySRBOkFziacPQ7UOiBu8g5FP4YZodzfW0XC+3mX50uhOuZh0S50cn4Axbu5lLkUuUEFmxrfqJsjiA2BwiW8ZFf+VnmyS7vtDqw6WjVecXZqwpomCzvHY3qSArdFMXNJu5DnIm+FQvjWmbX3O1PvVTMdyU7KlMeStiqrmfffjFwh7IXupfKWjvYwWKrnmPV0m/Dc8zckB2E9cqsTB1HDd5u9EoTsf0447RZpRI2MueAWBUZzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2616005)(66946007)(5660300002)(31686004)(316002)(6916009)(6486002)(44832011)(478600001)(66476007)(66556008)(8676002)(53546011)(6666004)(2906002)(6506007)(41300700001)(8936002)(4326008)(6512007)(26005)(38100700002)(83380400001)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Njlqd2FGazhJYjhiMHZ6VmRBNGphcEdKRFJCMVk2dGgvVTdJYjFaTElucUdv?=
 =?utf-8?B?UVFuUk1UTS95Sy9rQUZpZ0FMQ1doY0k3ZDRKakJNdXVIVGtad1J6aEM2Z1ZD?=
 =?utf-8?B?OUNSRy8vVHFZWFNGZXFubzhTaWx1YjBMckp6Z3p6SGJFbVB5UTUxTis4NC9U?=
 =?utf-8?B?WFBtM1pDU21LdnpJZ0EvU1hGamFLUiswVFdQWUtreEVzTURoYjhkUUZRak1V?=
 =?utf-8?B?ZGpEbnFWNStZOGdFS2ZVVytYY1A5dW12WHpNQUc5S3BSVE9vbzZXTUltN3BZ?=
 =?utf-8?B?aU8xelJpR2JGSVcwVzgwMUJIVEtvc1VoMFd2emQxcGE0VXdDdkZkcDFlWFpB?=
 =?utf-8?B?YmJyemZ3anQ4b3dQK1RJeUhxcTQzTDB2TGNvQ2RKMUFad2RRR3c3alhZeEhD?=
 =?utf-8?B?YlhUVmJGbEg5ODhNc3htcWdyMUxBU21IOWhPMjJFL2lqdnJyZmFTYzEzZ0o5?=
 =?utf-8?B?REdVN0NVTUtJelFZRFdGZlUyejR3aElDUjR2N1RlYkM2ZTdxYVFFOW5zYzls?=
 =?utf-8?B?TDY3aHdXMWQrb1FqaTYzZnRqU0taN1VhZVJNa2NNdFA0aVp1TVlFZnFtbGVC?=
 =?utf-8?B?Nkl5ZTlqWngxTnFmNmFLV1l2bmYrWDVublArU2pYc0d5aDdCQXAyalZGRGdT?=
 =?utf-8?B?YkVtalJUeWw4VkI2WmJMKzRQc2NRQUw2Q0txM0VENVdwQmlSOUQwMmJneUV2?=
 =?utf-8?B?blJEek1TbFV4Z25TMGUzTGZKZmhyTTFMZE1ZdW1iMTlUNTVLU3NOd0pTR0d5?=
 =?utf-8?B?cFl6M0pZU0t0QU8rNTNUYVA2ZmFORjkxclJYQ0wvVnA0WHNSVlNPYW0zWXBI?=
 =?utf-8?B?N1JycXlqK05ac1FLWk9SRnFkU1BiWWE0R3ZPS0NnQTdzODlOUmp3d2JHcWZr?=
 =?utf-8?B?Zy9yc2N5ZnFNcy9KNWVYdEs2TFdCcWtUT2VYaVhHWHNWaXVJQU94amhiMnpv?=
 =?utf-8?B?QkVYV3RObXpkZElCUEVrWDhyN3dmRUNNZUJ6Y0ZLMWlabzdDRXpFZFFSdVQr?=
 =?utf-8?B?T2xJNnZSSlFpQjdLNUxTMTd2Y0tVK09weStMcElwQVNReUpjYU9wc0dQNEF1?=
 =?utf-8?B?RE03akpYa1EzS3ZMRHZqZGZuNTQrVW5wRk9qMUZjZjlZa2VEeUduSFZxdUtT?=
 =?utf-8?B?NjRWNndYM0VYbFAweWNZaXFPTXBwLzNzTXpjUVZhVHd3N0d2aUR5dWdtbFhF?=
 =?utf-8?B?R3hSVldWb2RrQURodUpFTDZuRkVzWUs0WTRmbUo4eVRiamY1cm9Va0ZvMy9j?=
 =?utf-8?B?dWN2MlB1dzN5d0NJOGZSZzhILzdYbEJNbVljZEdmcVNOd0FtSU1QbkxIRGlu?=
 =?utf-8?B?djlETWY4R201ZW9ZMmJEcXA5WjBvNmtrNTRBYnJnOFIzWXI4MFZZL3kyVDAw?=
 =?utf-8?B?WlhuVjJVLzAxTjNFcUw5Nkt2VkoxSXVJbExkQjVKYTNUZjZiTmMzVzVtMS9q?=
 =?utf-8?B?ZGwrREhaOWRsaThWTWt1MVU4YzVOTjB2elEvWmw3UnlLakMzb2g1QUJncG12?=
 =?utf-8?B?ZnNxdzlSN3lOYXIvK3AwWkQ2dy9wdmJNN3RrVW9adzJJbFNiV3RRcFFUYTRv?=
 =?utf-8?B?ZnR6ajgwc0xVR3EzeWNUK1ptRmNmUmE3aGFpb1FjYkMxU1VReUozanF5bmdp?=
 =?utf-8?B?UTd3L3R1Y2NGdHB3ZVNyNHhIN01Mb3Vxc0owRjIzc05KSXlhUmxCWWM2UzJs?=
 =?utf-8?B?S0JKK3dFOGZnRUx3VEZ2MzE0ZXJsZytOckUrMHYxR1NMSCtIZnJENXZhVmpu?=
 =?utf-8?B?UkJxSWdUSUltcE9MWkVhWlRPZjJ3M3Eydy9rMFJUTnB5RVQwSzVabnlhNkYx?=
 =?utf-8?B?OS84V3piV1MrRGNmTVV0eXZ4VTh5U1JLNHRyL0NIeW1yc1lsa1pBekhESjdG?=
 =?utf-8?B?UHpvZ2pNd1Y2ekNyemZPUisvZUdvWXdCVW12WmdtaGpKTmRYaTZHdk50ODJK?=
 =?utf-8?B?NFpuT1JGNEpGSDRUVElBVjVYV0ZGSXBBL1g1VVhyNlB2eDdNWms3dmhVMG5H?=
 =?utf-8?B?b2RjcXZKQ090eDdlQlBzNmxEbjRyNzhYcjBBOXVFTS9YM21QV1RTV01idTVh?=
 =?utf-8?B?ZTZYb2dqWXQ1L09NQkd5Wjl0SkhjaURyYUNzV0JTNXdmN242UVdQT0NXeFlQ?=
 =?utf-8?Q?9y/7mFyLeStZLVauDEzHMnEG+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 44Ye/3gQnXwoaKTcbO85bzmapVKARP6zplcyAC7D9HgAR39iSt9N1fkNZgpAUGYQ2E0TPxibmTd4oXp+jqhWA9Lk898wqBM36Ggs4z0qwoSJHMYkXq2gK5jlRgMP4nmWL8iIuy2w6rChnKVysTytE25XCdnbxMM5H2t2T+55Kj0bDIbTY854FghjQSRwnxJBrxgUsIGv/Rj8VXcNCGYassUBr0lFyR/XdEvmycJ/md6mB619rolg8hwr+xZQKA2kgvifLULxhTPP9gVznWhep42L0auktVdaLPA+eG15xJjRUhnxzsIDZpK48ZJc3fLy04fdn+tzXW6Sgn3/+SL+7SeglEl9+SGwxLf+RehkL5rJsjgljOVyDD20YvQrjumZgScBstjXg7wb9HYpp0QGyp+Hv2DgvVGTjwkdP+3NaqJ4HfArPMjdSPczOv5Ok2Lp+bX9NF3niL0W901Bv4GJtgS6bqCCE0fAjkfCBxcp3EDuHiPm8Gd8NvzqSIQbWltdD/6v6W7ujjtKR1pYbbUiYvWawucncApOUqkozwb77fyhgDZZZa3g283kd5fX/N5pHxjnh9vu+MK8YXcRnQ0YOPDh/Fh0WYIT7Nqzxg1xPNKF0BnBuM8qwsHMghzZBEa6JySmBJFmcIl42wNNxe4nGQh/yf/DNDdvfYxD0tjC0bQDH0YxxlyqA3W974M9FTEuseu14Zh+yQoIGeiKnddl6Wqp1ABhbCqYDTpNhIUMWd/4agppx3AHa/QAI0tG0XZbgH+7LwOuKtQORHOSzBhzBaTbDTiQSmO0QUaEwM97xYGipXhGabGOg6JucyxhWSmd
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b39d2be-0905-40af-1f2a-08dbc3e6c18a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 08:00:06.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwNpa8ZNb1S8dsE7TpbLq6K9zZ0ROI/al0/HGpMXxjmYV9eBoFpldhiq9M7IPNWle3Zz+VWpsUmix6Rp+9bWZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_04,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030056
X-Proofpoint-ORIG-GUID: uf2rkdrulCcxEDmZEkh5FIhncElPjXyy
X-Proofpoint-GUID: uf2rkdrulCcxEDmZEkh5FIhncElPjXyy
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/10/23 01:19, David Sterba wrote:
> On Fri, Sep 15, 2023 at 12:08:59PM +0800, Anand Jain wrote:
>> The misc-test/034-metadata_uuid test case, has four sets of disk images to
>> simulate failed writes during btrfstune -m|M operations. As of now, this
>> tests kernel only. Update the test case to verify btrfstune -m|M's
>> capacity to recover from the same scenarios.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> With all the problems fixed, the test still fails.  I'm not sure which case it
> is:
> 
> ====== RUN CHECK root_helper losetup --find --show ./disk1.raw.restored
> /dev/loop0
> ====== RUN CHECK root_helper losetup --find --show ./disk2.raw.restored
> /dev/loop1
> ====== RUN CHECK root_helper udevadm settle
> ====== RUN CHECK root_helper /labs/dsterba/gits/btrfs-progs/btrfstune -m /dev/loop1
> parent transid verify failed on 30425088 wanted 6 found 4
> parent transid verify failed on 30441472 wanted 6 found 4
> Error writing to device 1
> ERROR: failed to write tree block 30457856: Operation not permitted
> ERROR: btrfstune failed
> failed: root_helper /labs/dsterba/gits/btrfs-progs/btrfstune -m /dev/loop1
> test failed for case 034-metadata-uuid
> 
> Looks like a write that's beyond the device limit. I'll keep the patches
> and tests in devel so you can have a look.


As a root user, your devel branch passes here.

(Generally, I have been using the following command as root:)

  $ make TEST=034* test-misc
  [LD] fssum
  [LD] fsstress
  [TEST] misc-tests.sh
  [TEST/misc] 034-metadata-uuid
  Scanning /btrfs-progs/tests/misc-tests-results.txt

Let me try as a non-root user.

Also, could you please make sure that all the 
'tests/misc-tests/034-metadata-uuid/*.restored' files are removed before 
starting the test case?

Thanks, Anand





Thanks, Anand

