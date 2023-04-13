Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7766E0D32
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 14:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDMMEu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Apr 2023 08:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjDMMEt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Apr 2023 08:04:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4923B10C9
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Apr 2023 05:04:48 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33D6XoDF024937;
        Thu, 13 Apr 2023 12:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ETu3DfPAXG9Kq5HrYOk9wybUQ1PqXuPcaXFyNrZ8pj4=;
 b=vkssBQ4R+8RbNA6n7opnGVDOTnCRW8JSZAMiKISaCrsWxM+1xnUuwFL0AInqY6CaD5Bx
 YYaJLvad0v0fJSaAtaA0TITqQKPilNJKREzpEnFwAKxvY7M0zNWPTUNJAcSE+f3chrzW
 PB2CHPiW6ytfJtPA/98pik8VqUBUUSmFRcpZ+fm4lEqQdyTpMdIuO9DIvqMX3xIosP6B
 7cLBr9Kj/DXrZXR3Z2uoyz8dC+BUkl6D3NVA4C3FozNhgekGatn2wuyA38FGUEWErAr2
 JmYd9Y9eSQkZf0vH2/76013cXPIiAd+GC8tmZKj8XCz/5kQJEyfwIHR78LgtRENI0VMw 0g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0eqarn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 12:04:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33DBHWJF012611;
        Thu, 13 Apr 2023 12:04:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pwwgqwg9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 12:04:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OU18KUG9LUg729AoN/H9PZpyiwXejEZqA894lcqS0jSnZYaQRZ8zObakHZ1PC4456rVsOh7TV4wm7q+paqQbpIPGs1fEXPpurVFk+2fUAjuuvrndxCVs1zIlTmvUTK6gO/rl0JcsaQ97/1O7X1gjQTgo09r0S/7wGlvbBbjS1Uu1H/zVRWf4PCkBxvy/ehLCWBpmpnAN1D9YdFfilVTCNarn7JLTTO3c3KVTR7zFbf+DInqE9PoKVh60nSA0aC82EdXTW2BW6RWJvwB+MA6tXRsw2AEJBWrf01+qmeVhuJTuT8wwk8dUbMld93CtcQdIZrMRmrDUVLygo8tBc3cMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETu3DfPAXG9Kq5HrYOk9wybUQ1PqXuPcaXFyNrZ8pj4=;
 b=Dhwypod1N6L2phJP9yNeqkatMlYGhZZE3jqNHuDeuq41/BSDh9NwmUu/ZO2sebB7KKWKRAn3r4Y/6UnDK/5Ts1fNcY30drDLsOd69APHoywAkWQ33sMb0cxap7+BvWeNrMuuwhB1NfrTcmmgmm20szRga5neGc/dUghDwGsVfOeV/8yLUd0NLzyd4GYtfORw0MkXfjGzmdmw8k+/rXtVOk2dQkgVaMFyew3OUKivVltUoUzvkXHKQI7gApDzLoVI58o7XWSkIvPG3DKmEGpzDxUyPsrrywP0lTm3lfKhjP/ihZH6vOmxNHxZ8cHu1JgY2XBDa2qPb9wYtw4sz645uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETu3DfPAXG9Kq5HrYOk9wybUQ1PqXuPcaXFyNrZ8pj4=;
 b=ylIDi1VTJ44mDCjL8QsztffIppR9QuFZa3SZHbAAmqc3UjEYkXR/1Sm9I3kzgEeixPPLnyH1hR/IuQ0t1DjdMLTALgIBFtZkJ8XO7i6BWfSbST3MLrw+zvMFTfWJU2yqNzFfjDcD+iwgGiZN6MDLx7qjwdRRQKuIJ/kOszo5TOk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6207.namprd10.prod.outlook.com (2603:10b6:8:8c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.31; Thu, 13 Apr 2023 12:04:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%6]) with mapi id 15.20.6277.038; Thu, 13 Apr 2023
 12:04:42 +0000
Message-ID: <4a280a4c-5c84-8ecc-5dc3-4258ecb6eaf5@oracle.com>
Date:   Thu, 13 Apr 2023 17:34:31 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 1/2] btrfs-progs: mkfs: make -R|--runtime-features option
 deprecated
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1681180159.git.wqu@suse.com>
 <1ca85433fb63d9c9cf66da72e407381c0146b76c.1681180159.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <1ca85433fb63d9c9cf66da72e407381c0146b76c.1681180159.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: a2dc086d-896d-4166-7796-08db3c1743be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kdm1q/Vii8P+pUQciDMwOp3eErpsYTyg4Hlp4Pr9lPclN94RCafx7PK9qWbk+fa0lavKSNTnPENWZNekH8L+ETgc0DcP4+2X7ob9GDM/6heAG9VGOawep83iMr/9EHiYK1opF6rScOJ15G3Ud/GIe+YVpsaM4Rg+56BuNDx96hcZAjzL/dPmNmWoe2UoDwk5uczqAHB2zZ5EhLugA1YRVcPRaGOIv2B5tPRAGwIGqmTNtML9zhgSLSGEiliULZTWlpfz9s/kzQFa9Y2x9haOhzu6/SfTseoV7zAt0uJDIiPdmEJFPu8EV0ZTl3KBq6mSIG9Z035i6iZz8++ksIUAijs+LLBrSoAPIi7ay+wgT1u4dRFy4FUgyJuFnL5qO7ZuaSjWhEBZLJacehsabG+GV94N2TibecTrCDd9KxvLNAlygFYImRB4rOUgSEpIdRBgQQu/+WhjcJEoLw48Oku0hjwEB38A4HsCWjqIKqgYeESvhD/gZ1skzkC1w8OVfhbctCwtr+4v99CioSAAU1kTSVB0jsRMypgGCTUvnmkNj7hrvPNQVCewJ8Z5Dk7jgx1YnhExuXliubRaHDU7ncROFrZdU0loqI3Nz7BzryWoHZBIH7r3qYxmiMmK3b8Fzo76sOXzF0nAon6vKeNe+TlicQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199021)(44832011)(478600001)(8676002)(66476007)(38100700002)(41300700001)(316002)(66556008)(8936002)(66946007)(5660300002)(2616005)(186003)(6486002)(6666004)(6506007)(6512007)(83380400001)(53546011)(31696002)(86362001)(2906002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L29QNVNPaWNST0hocU1VeEExY0x2RE5UYXZORTM1SmRxdEJ4NHlLUUVJVEt6?=
 =?utf-8?B?L3ROT3R6WXcwQllpMmZHU1R2TWZwM1J0THBlN2dwWnRPc3N3RWIyL3BRZCtX?=
 =?utf-8?B?VjBVMW5TUmtiWTM2WU53T0NuNm9kT1lsKzRuQTFGQ0RieTZpQnZuNGU3RFdF?=
 =?utf-8?B?QnExcktGakxDU3BLNCt1UWhCRnBTVTFlT3JZRExhY3h1amZQMnplSWEyOG13?=
 =?utf-8?B?YnoyTGRtL0dNWEFjS3ZyTGx3ZUtzOEM1Wndid3U4VWMyOEthbnZKUnByR0xM?=
 =?utf-8?B?WGtqN2pOaS84WU5yQUVlNmE5TCtBR08zeVhZVEdJM2lGa29HYXZXWit0SHJE?=
 =?utf-8?B?ZWNKT2J5b0Q5bDcvOU5WUDVXNGVPdEZnMXRzVXNYN0p0RHpNbnUyNjFFZnho?=
 =?utf-8?B?U3FXTmx5L2pUeVBZV1o1OXNPdlhXTFFxaG1RWnozb2F1dllVcEw0SUNCd3ZW?=
 =?utf-8?B?dTV3QWpTeTBsblBDMlZhdllHQ1JVdXVIQkZSZEVqcXJwdzhhL1RnSHYvMVRO?=
 =?utf-8?B?YVE0bWlRZHdHbEV3a3R3aGZtUWdGUldDVUwyVW0xU3pSN1RVOXZKTWtTRUNX?=
 =?utf-8?B?YUVxMHhQTW4wKzlCMzJaQm1DY2FYK2tsRG9KUENrdmgrSUo2ZGNidmVHQU85?=
 =?utf-8?B?Yit3SUIzaVNTSHhES1RlSW1aV3d6TVpybkl6OXlEaTVib3pKYkF0WWhtd0hG?=
 =?utf-8?B?WUJIcVhEODJaeS9WUEVvcEJQZFRrK1loTWNGdWx6d0VnZ09saG9HaVM0Tlkr?=
 =?utf-8?B?OTd4bHJ5TWMvR2NMaXNEdlJ1VGl0dXI0MlFiR0NRbUtGSzBWWEdoRGlQd2dH?=
 =?utf-8?B?Y2ZPQzNRbWFFUzJEdWRKYVQrWVcxODR3Q3ZOQ1g0bXlpbDR0VlBkR2ppZk5j?=
 =?utf-8?B?dXdNZjBLWjc4dlRuREJ4Y2NUUGk4UmVGTGVaSXRucjRHQXVNZFZlSERKWkdT?=
 =?utf-8?B?d1h3cWJhdW1nbGdUbDErbDBvSlVycmtWaTNram1nTGp0V1QwT2k2UnlnSnN2?=
 =?utf-8?B?eXp0UmRTQlJ6bFdMSkI5NEZKQk1salRyYXZaR01SRDkyREM5OUFIYVo4Vk9x?=
 =?utf-8?B?WVNRdkMzTnNlN3FXSTJEN0Q0R051UmlPR1EzL1RxRi9kWVByMXJZUU9SalZR?=
 =?utf-8?B?WHdFdExyMGNQY2NlUXRXV21zNVlhbFZUN2J4bU1xQlU0NmwxSmdySkZPTXlD?=
 =?utf-8?B?SWN6bnJQMVY2cVc4K3hGU1VMdm5nVUpsejgzc254anZrWTFFTndFR3BEOXI1?=
 =?utf-8?B?VjJ4RG12TG5VRXJuMzgyNWpkOVpWTDJwZjk2MkNmODl4RXNaeVh6U1BzWGxh?=
 =?utf-8?B?cW02M2FKNnRmcElPbGtlS0k0QStMTXNra2N6eXRrblBHd0E2ZDdKQzZvejdG?=
 =?utf-8?B?UDZQMCttQ2dmMDkxOVRLVm4vSWpkSWcrUStNUDZDZkZqMElnUUdURDNIeVFx?=
 =?utf-8?B?RWVXR2FldUxKUUc4NVdPbjYxdzlQekJPTjIza1pBb1JKN0lLNXFoUUhhaWdw?=
 =?utf-8?B?TXY0ekhHejZEOGw0V0RhUzFDc0tFZDc3TDBISlJ5QTVEY0FXK0ZlMStZVzZ1?=
 =?utf-8?B?bE9hMXc5ODJHcG4rKzdWV0lId2tjd0pjNlRUVXlCZ3pmSG9rSWE4MDJUNEla?=
 =?utf-8?B?WUpBK25zWWREZVRRSUNmdHhsUndzTVc3dG80ZGl2R01nR0Y0RG9xZ1Y5Rk5C?=
 =?utf-8?B?czUwTGhBY21NOG1VWUtEQWpZUW0wVHpFVnNZYU5tUk5JeFQzNUN1OUxMUk8w?=
 =?utf-8?B?U2R5SVBHSituM05HQVgyTlFSU0dTcTNSL2Y2YnUxUUNvOG1INlhSNkFqR3Ro?=
 =?utf-8?B?NzhTdXR1RlF4Q3JOOUptU1dYZlpyZnlvOEpzK2dBSEF3WHdvMzZVNTI0RVFQ?=
 =?utf-8?B?RWxEL0IxS21SMmNRV0draXF3NndsaGZ6a2pKUTNLV1V0NTRLMFFpdGxjSVlZ?=
 =?utf-8?B?MVdJclh3dEZ2Y1VWejI2SDVkR2xJLzRHMFBDSXhaUERta3lidDZZbmFKeFB5?=
 =?utf-8?B?L2xld0ZodkU0TTI3azBXM2pxd2lpenhNNGhIVVdZYXN1SmhKNytrRU5YNUNj?=
 =?utf-8?B?c2JIcFh2Z0pJemxRQTU2QlZCOUlsQ0RoMmd0ZktJVkswM09NZEdMNVZCZzlB?=
 =?utf-8?B?UitjMVpITUNlSHEzMlBGNVV2Qm5iTENIOWo2dS9iR1dnenA2Q1U4YTJidE9p?=
 =?utf-8?Q?n8NjSb+oVFwabtXqMvjKUeA9t5lAuPZ277wcZGgZuyou?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZF6icVCaqwfcXSDQMN+0RHRqdH7SoYGHa3BkLoJZcrqoFDTIY+Nwi+4Rtu5U+uYeyq4r/xJI8PYA5iJqNEbx79r4BNjM/jhazIQTVX3Y7Zt058R99GT8qDNyXmPcJC7LpjyFGdAm2EBDd+0Hpra8Y0RkviwyP0BKxJupvY8y5UM29186Zzy4iYHttLA6nZaePhDknfd7Pl4diLGILAl6ysxsVy4EjLbAV65ZNJI4DXOilViU0lh2xrh1v+FuJISX0lHcIP8S0KmWQoyY7O9TCOUE8iJz1pw8+e57X4X+L8HWun2I9MHAAEGeXK+LNvjaoNI+ikj8+sI/kfSFT3nRCdhGi0OdR+vb3R1qTox/Mg0xqZtvLs47WxkUa/IfydUIyw1JSWtq8vDSevhgWyBP3c6G8bTdBcBJbcFmzyLFJPrmBUpHHXH0E3u/dWVBsxutK2Zy4KPwa2nWWSBnko3UhaOlV0n614928C3KGAfzydLwwp+R2UmrxU3gQeQAnG9qVu4IwcH2b+AwKOvkEebiysJHs95+uJ1PJBhSFz/VPEl9Pwwe1p1or1QubnAfKOdl7nummVzmr+/HeuIj7Pyq3L2noM9163QHz+8Yg/DB5Kzxm9o3f0rPBUIgPHgiKQH779cT+DDTy2ZAXTL7rH1+xBwKQh3UUos0RchWMGFyaOBB6sSgFIziu9M7DLkELH+5mOZOTIMCn9x19InenMgTic4CaYoUsb3FGHQ/T6s3NK/6SWcbtuSVH2Fegc/zuLoaTW9s3/IuOk1dTcKCYaue67C7vi0yifWoWWxC/HqHjeg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2dc086d-896d-4166-7796-08db3c1743be
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 12:04:42.7030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbqO1lWgg0wd8XXZpAbDhIDQztwXP1y0u42Njg9AXx2Od0oE3ZcHMHYgmoxJGBvTy5K5QiH8BLnWHbvaNe2MQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6207
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_08,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130108
X-Proofpoint-GUID: -AvMlIIrqcbuA9nbPZYuLt4uFirWTObQ
X-Proofpoint-ORIG-GUID: -AvMlIIrqcbuA9nbPZYuLt4uFirWTObQ
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/11/23 08:01, Qu Wenruo wrote:
> The option -R|--runtime-features is introduced to support features that
> doesn't result a full incompat flag change, thus things like
> free-space-tree and quota features are put here.
> 
> But to end users, such separation of features is not helpful and can be

> sometimes confusing.

Indeed.

More below.


> 
> Thus we're already migrating those runtime features into -O|--features
> option under experimental builds.
> 
> I believe this is the proper time to move those runtime features into
> -O|--features option, and mark the -R|--runtime-features option
> deprecated.
> 
> For now we still keep the old option as for compatibility purposes.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   Documentation/mkfs.btrfs.rst | 25 ++++---------------------
>   common/fsfeatures.c          |  6 ------
>   mkfs/main.c                  |  3 ++-
>   3 files changed, 6 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
> index ba7227b31f72..e80f4c5c83ee 100644
> --- a/Documentation/mkfs.btrfs.rst
> +++ b/Documentation/mkfs.btrfs.rst
> @@ -161,18 +161,6 @@ OPTIONS
>   
>                   $ mkfs.btrfs -O list-all
>   
> --R|--runtime-features <feature1>[,<feature2>...]
> -        A list of features that be can enabled at mkfs time,


> otherwise would have
> -        to be turned on on a mounted filesystem.

  --R option is useful, why not consider rename?

Such as:
  --mount-with

Thanks, Anand


> -        To disable a feature, prefix it with *^*.
> -
> -        See section *RUNTIME FEATURES* for more details.  To see all available
> -        runtime features that **mkfs.btrfs** supports run:
> -
> -        .. code-block:: bash
> -
> -                $ mkfs.btrfs -R list-all
> -
>   -f|--force
>           Forcibly overwrite the block devices when an existing filesystem is detected.
>           By default, **mkfs.btrfs** will utilize *libblkid* to check for any known
> @@ -199,6 +187,10 @@ OPTIONS
>   -l|--leafsize <size>
>           Removed in 6.0, used to be alias for *--nodesize*.
>   
> +-R|--runtime-features <feature1>[,<feature2>...]
> +        Removed in 6.4, used to specify features not affecting on-disk format.
> +        Now all such features are merged into `-O|--features` option.
> +
>   SIZE UNITS
>   ----------
>   
> @@ -279,15 +271,6 @@ zoned
>           see *ZONED MODE* in :doc:`btrfs(5)<btrfs-man5>`, the mode is automatically selected when
>           a zoned device is detected
>   
> -
> -RUNTIME FEATURES
> -----------------
> -
> -Features that are typically enabled on a mounted filesystem, e.g. by a mount
> -option or by an ioctl. Some of them can be enabled early, at mkfs time.  This
> -applies to features that need to be enabled once and then the status is
> -permanent, this does not replace mount options.
> -
>   quota
>           (kernel support since 3.4)
>   
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 169e47e92582..4aca96f6e4fe 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -99,7 +99,6 @@ static const struct btrfs_feature mkfs_features[] = {
>   		VERSION_NULL(default),
>   		.desc		= "mixed data and metadata block groups"
>   	},
> -#if EXPERIMENTAL
>   	{
>   		.name		= "quota",
>   		.runtime_flag	= BTRFS_FEATURE_RUNTIME_QUOTA,
> @@ -109,7 +108,6 @@ static const struct btrfs_feature mkfs_features[] = {
>   		VERSION_NULL(default),
>   		.desc		= "quota support (qgroups)"
>   	},
> -#endif
>   	{
>   		.name		= "extref",
>   		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF,
> @@ -143,7 +141,6 @@ static const struct btrfs_feature mkfs_features[] = {
>   		VERSION_TO_STRING2(default, 5,15),
>   		.desc		= "no explicit hole extents for files"
>   	},
> -#if EXPERIMENTAL
>   	{
>   		.name		= "free-space-tree",
>   		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
> @@ -154,7 +151,6 @@ static const struct btrfs_feature mkfs_features[] = {
>   		VERSION_TO_STRING2(default, 5,15),
>   		.desc		= "free space tree (space_cache=v2)"
>   	},
> -#endif
>   	{
>   		.name		= "raid1c34",
>   		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_RAID1C34,
> @@ -185,8 +181,6 @@ static const struct btrfs_feature mkfs_features[] = {
>   		VERSION_NULL(default),
>   		.desc		= "block group tree to reduce mount time"
>   	},
> -#endif
> -#if EXPERIMENTAL
>   	{
>   		.name		= "extent-tree-v2",
>   		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2,
> diff --git a/mkfs/main.c b/mkfs/main.c
> index f5e34cbda612..78cc2b598b25 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -424,7 +424,6 @@ static const char * const mkfs_usage[] = {
>   	OPTLINE("-n|--nodesize SIZE", "size of btree nodes"),
>   	OPTLINE("-s|--sectorsize SIZE", "data block size (may not be mountable by current kernel)"),
>   	OPTLINE("-O|--features LIST", "comma separated list of filesystem features (use '-O list-all' to list features)"),
> -	OPTLINE("-R|--runtime-features LIST", "comma separated list of runtime features (use '-R list-all' to list runtime features)"),
>   	OPTLINE("-L|--label LABEL", "set the filesystem label"),
>   	OPTLINE("-U|--uuid UUID", "specify the filesystem UUID (must be unique)"),
>   	"Creation:",
> @@ -440,6 +439,7 @@ static const char * const mkfs_usage[] = {
>   	OPTLINE("--help", "print this help and exit"),
>   	"Deprecated:",
>   	OPTLINE("-l|--leafsize SIZE", "removed in 6.0, use --nodesize"),
> +	OPTLINE("-R|--runtime-features LIST", "removed in 6.4, use -O|--features"),
>   	NULL
>   };
>   
> @@ -1140,6 +1140,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   				char *orig = strdup(optarg);
>   				char *tmp = orig;
>   
> +				warning("runtime features are deprecated, use -O|--features instead.");
>   				tmp = btrfs_parse_runtime_features(tmp,
>   						&features);
>   				if (tmp) {

