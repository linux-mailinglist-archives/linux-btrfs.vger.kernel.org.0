Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820916F7BCA
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 May 2023 06:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjEEEOQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 May 2023 00:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjEEEOP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 May 2023 00:14:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF4711B76
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 21:14:13 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344MKLdn006552;
        Fri, 5 May 2023 04:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5nlpelLuJdymAxE1+fx8jXBEHNCKaCqPZzVPNj0ctSA=;
 b=ESS3Z64M/5dy2qNJ0bg5bR4aiNtzeVUSMUxkQAggXTaH2VIyQESr6b2eXx869yzYrZxv
 tm1eADQsCHolNngVdZyDpdbSI0QT0rcVBWzo2dHSrm+lAA4dFg4Ax3ZfEr5Q7q0iFZ1A
 kTW74Tu08Rw26iFlDmNXn2Y9pzqLo1IExWdIKtjJkB9QNEeRuRBRysb8fU0sX+jHe/yq
 lSCUlD0zRrMp36gxJsGMNzGfgJAO1c1IzX6Dkm3MxlDok69m4ctw8efmga7B/FaheTI3
 5ubh6CCNtIkRsHOBnbWGXCyiIqnxRsmilNjUn4VOB67U1Ypt0D40Obw1fqR6u10Gg/js 3g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8usv3mhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 04:14:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3451kgLx024937;
        Fri, 5 May 2023 04:14:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp9kr45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 04:14:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RefMMyNJ+XilduUMdpg5Ihfar+bbpM8wd5R+ui+ElOP46cM6ifTp5RIL8p6uHdMh0reMfuGhZt/bcWYepy9odAeKyi8BLnpOuT0/ZIkJ/0ynyYcJmpbYLlz2eBwhNmaZjzQjZINiKmKDH63XRNHtsc9BveoIKzzluZgRqfx0ZnSzhbJPCWXump9wks4Fkz5EPNAQ+za1CIl9XgulNw5gzwDfd16vCD/Gu/9m+0pqeHCsKGRM17lzd2BQgc0zAinX5oXsqOhGhVp3bHW9wO2NsLLDAMgPsEEPKeU7cAUmWA1H2r3s0iqyldo5U+eYkZO8/1T2HXXpyWrStL4QujRJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nlpelLuJdymAxE1+fx8jXBEHNCKaCqPZzVPNj0ctSA=;
 b=IbVlS0vS3+I3sB6x7VUBYhq2wAlZ1DEF4mYSz5hnV4297bld1Y2s6tYIbQXuDG5l+vh3KDldFk/8kRDNC8LqVEjy4I2vHwZ1Jg0y+zPg/auhkIBkIfgs6qSBAVqETmqyx2t4kbLi5cVCKdKPTzEzTZW9ZQqPFPV/Z6Y/wtJEdU3e8PNlFrbcOyAU0MaqHXFquHLSn8+vQWOIPgsoIAcDRNIkTlxiMW6gNd0jbpFOfGWaW+t3mm2hXmhpo0xbogkUt9N3kvude4z0wmyvdmiYn8o2FJsItyrCBD97+3dTjN4wjinfO61UYM+BQwIG4fPAIheaKwgWKw0MnpSDV6XXxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nlpelLuJdymAxE1+fx8jXBEHNCKaCqPZzVPNj0ctSA=;
 b=Ppsmyz7ZvVEs6DXlrMJPRsIwO/TJrzfgZBecg3Pksgu0Y654ka6TEAQ71YtYyKD6LefjOvN+xr0x8NWGjT5YzOcGWmwpNc4rIMg1jBBUfrsQyhs0Hwyc3eQo0qMJp24QQ4OanCELZAwIhdqg13efTTf3gViMZ6SUNJvESz8h3HA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5241.namprd10.prod.outlook.com (2603:10b6:610:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 04:14:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 04:14:05 +0000
Message-ID: <ed97c734-a3fb-539c-c7cd-0b0667465790@oracle.com>
Date:   Fri, 5 May 2023 12:13:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH RFC 0/9] btrfs: simple quotas
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1683075170.git.boris@bur.io>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1683075170.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::12)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3833fb-c018-48b2-69a6-08db4d1f2a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DFrrwz05Xn1XPGAmKuwt5Sik3rztdE2KwfvQijbOQqnbIifqUAaZUZkPvbBatwWzL3/w6ya8fSHs8bNinh1ICagqCquRY1d4R+viZ94opW+BiMnUnazZUpvlAEYfjC5UKtV67XGOE/iNqx+4doHvMkKslv1L+Xl7e7uwn+JWyhzJGDdsCqafZFjAdrYh3Rl9Z4Hn6QoXWF7Mc0ck62ldWngDQPrN74Uo1jUOe1gT0/WMfrp5qAolxRtqnU05HqtwJE54U3juCTcfSS6EfMJmKQPaLK7lNUECWE5JjvkWnes/Lsd2iVQ6WCxBicehxBTb8iFijPU+fP0LXRp3RdkwSYbihVQmnUna5oLtlL7Bj27P3mkoTwaIzQOXkSaKYBfpXZJVvJn0MBB8YOZgDMIjbWBPloxWySyxz4YZ5Vgbc17HGnkq7t7BDIPul+5lzahiXmwK4JJOyRn0N8oCetIttA7YSx76/umG+gCZbc7OtshfyNFwWZtR1c9MOUONA+vHXMmuA0nOTaPSQNSEjETX8EbIe9J1692FE1Obn+Hx0SoKL6/DSoVt2STF/3NYxtgsB9KFCpDl6EVe3BYsSYgC6Ox6KWM6wO+sdYFUwnL2MWvyiUz1Md+2UzlRq+ckkapopgnCP1CaC7P4Glr5PTjuoRodV24+xYUjCDF8Sd349Pk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(31696002)(36756003)(86362001)(316002)(66946007)(66556008)(66476007)(966005)(6486002)(6666004)(478600001)(41300700001)(5660300002)(8676002)(8936002)(2906002)(15650500001)(44832011)(38100700002)(186003)(2616005)(53546011)(6512007)(6506007)(26005)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3Awd3ZHRVBSaHpDYnp6OWtPVmtSMmlYOHI0VzRybGg1aWpJUlRIVHNXMlpO?=
 =?utf-8?B?eTJQT2lYcFpJdVpuSkF3Njc5VDBvQ01WZlVIUnBSQkdVRWxiWWZOaTNONnpn?=
 =?utf-8?B?NzljbkUvMWxZRTA1Rk9NT1BVMGcxa1Z4NEpFZ24xOG1KYWlqQlhDam9QQVFL?=
 =?utf-8?B?WDlldUdqdEdLTWIyOHdtS0EwWlhQZVhPTE5aQ1BTeEVwczMxRUM1aXR0WGxq?=
 =?utf-8?B?ZGxibXNESVpPOFc2b2U4L3d5NWxaMEdPQU4yS0JXZXFyYU9DN2ZZQ1VDRGxo?=
 =?utf-8?B?MFRrTExkdG5qOWxMUDhHcWVYeEVjUm9JQUpVYlRNbWVjbWkvNnk0bG42d0pr?=
 =?utf-8?B?K0l0Ri90UmtKa3IwUm9TeCtyR1NIdTB6SDlDLzFsamVuUmQxUkFEQjBNSnNX?=
 =?utf-8?B?c2daRzRxMGU3ZXYrbWNrSWpZb1h5a1I5T2JXWGx4b1E0MkdNZmdDQjhnSlhL?=
 =?utf-8?B?bmdPdFdaSGkwT2libU1QZXhDaExya1g1VDhCYjl2WVU3OFVoeC9YTFo3dHFZ?=
 =?utf-8?B?S0paYWt3M3dDV0k4NzM4M21KaGNuc1ZKUTFIUGgrYy95NkpTV0YrcFBPdVFw?=
 =?utf-8?B?dFVybjF1ZmNZV3B2V09yNkNLNnVBWVNjOXQwTWoxL2ltckUyQ09aMXV4LzVq?=
 =?utf-8?B?SmhQbFRLN2lENklIbGxZTWo3RXIvV1VDaytIeU9yaDVoL2l1N2QyQlVrblBD?=
 =?utf-8?B?TDFNbUhheTNWZnVJNzUwVFkrMzZhU1pvTjByUjkyUW1jZGp3RlNxTStHL25s?=
 =?utf-8?B?Q091a0pybVVuYUl2c2gyWnFZRU5MTzRSVGNkU0ZWclhaaXcwWXJZOGhscTA3?=
 =?utf-8?B?QnpuaGY3UzJvZWVscitWSEFSdXYvNTJXQWtNSDMrYWdYcjhnSjBhenFZOTZN?=
 =?utf-8?B?WWtFRXNtVnZ6Z3loNW90VU03S0E3amxjV081UXlpbldCelFYTXdwUVAyRmVl?=
 =?utf-8?B?VFY2UjlSR1VsRWoxMjVIOXM4TjQwa04zM2hqTXJuREpwY2ljNS9MRjNCRkdD?=
 =?utf-8?B?NEd5elZaeWlGWUZDZks4VkVncDNoZGgrcDdCVEoycXZhWWpaTGFOV29KL05G?=
 =?utf-8?B?dWZ6Zjk5SHVzVkpBdVFpUHNMcjhjbXRzanVjenp1U1JucStiN0haM1BMZVRr?=
 =?utf-8?B?UGxlZkViVytUelZDdllIRUpXNHBXUnVqYjY4VVFaRGp4dktOMkRhOGhhbDNp?=
 =?utf-8?B?RFRHTVByOXkvUGF3MkRDUHNQdmFkSWlzeGp5VXR1TDJVOFR4K3ZYNDFOakJX?=
 =?utf-8?B?ZFpQUWxzQUU4WnorUzdPUSs2YmZBVGRLOC92SFM2U2lES1BDZ2s4eVFVQ0h4?=
 =?utf-8?B?YTQ2dDA0MmNRQjdCNVhMNjNNM0pHbktUUFZvaHRrbVdBemNtNUNodlhzOGRK?=
 =?utf-8?B?djRzLzY3VG5EVlJqQUZmTG5GSXBYNVFCSEhrQndtdHBGZUgxU3BYT2twRVpx?=
 =?utf-8?B?bGgwbVRxcjAvS3lGcTgxV2ROSnVCM3NVSkYrN3FwYVBmN2ZmelE5aXFFdU41?=
 =?utf-8?B?aDBQTUMvQncxelFSMnpGQzM0QnhNeGxkTzVBTktBNHdydnVWZ3o0NG5lRjBN?=
 =?utf-8?B?bFRwOTl3enc0OGdSc3Zqc2dDZTFWWVYzRkNiREVzNFI0ZWIxNlRWT3dGc3VH?=
 =?utf-8?B?UU5NYXEyWnF5TFFaZU5CdW4xdm9tU1NNNWM4amRIZ2taWnJoa1lTVS9Va1NS?=
 =?utf-8?B?TStJQ1FzMGNwTmJ3NTI2czFTeSs4SmQ5SWVXTjVrL2g1OXdDV0tEeU9NTjhW?=
 =?utf-8?B?NkNVdDY4TUNhQm1Qd3Y0VXhRQWJBUEtkTVo2UGdXWDdQdHRkekIxd0E4YmVJ?=
 =?utf-8?B?dDBtN09Ednpzc29UcHpVYmkzNHhZQ2pLR0dwaS9rR1g4dTZWZHJLZll0OFVY?=
 =?utf-8?B?STdabFJMSGxUVU1xdGV2TWxmYkRXM0dia1h0RGUrbmJyZGI3amRWc1pkcUFh?=
 =?utf-8?B?WW9jNThDVU9SdXhxZzk1TllGellzTng0aHd2eml3RTA4K28vTXVNY0prYjNN?=
 =?utf-8?B?eG1LUVhTa2gvUHVQY3JxTEE4NlhnS3dCR1pXa2RtWU5CNS85QzMwOTBlWFZD?=
 =?utf-8?B?MG02cU8vSVB1YXVBdjVaUDBka3g4bWlWOTZSRXlOY1FRTytJRkNmamJtU0xz?=
 =?utf-8?Q?nqNpv+Gks7M1JwOHy/cofeqbZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IyB+3+IU6u8xOp4BFSUj5lrhcKQF9cVXF+FkqOvaBNtKcE7B/O6TcYiGtMu2sCEJP7Lf0sq8uvs/kAe3lXctIdChOsVKwYPCcf41G3m+GsL7jT29bYPhB7uvrt1i7nzphW6+C4sSNXBtfhZASx2J2qPig4HU0E2pud1quIGLtTkcWS2LIt6oBzgT0SDd6vFth6BeCvHi3EYoJOwrqtzPPeINPCCmnGR11CUF2kTPhsst9/x0n626RKH3iaDtyyLejprvwQuYQg63cHPQgkPKuTPdKbuYtO5uDi2XEmkpQCQmYIMsijbr9ZbiVW9Cy0TZx464rVZEgWEHlHS+lwbWmrhIjN7q4TXG9ZKPYgdFsGmQ7vlywu5EZuvTCT3uCUH8FwTYqhgo9flrzZhYlV9Hw6SWBJ99FQbX8abxkGjT61fi8hCuxBxawPcbIMo+wkQJ0+OQkrXuSqgeFg6XUlwvZTS4K2u0rXY/UI/Gmdh2SEU0nnHilfTXNMKFg3FhK1giJKlUxNTT/YNOkM+rW1PGp/cm17q4SJnwz8dfr/b6ZBo9CyKG5wQbjUN6+sKbVk9hOhVZq8LhWqPycYoreL1qqL/s0MxguPYEMZ/8rXikbsPDzCuO1iZhdAa9IAkuKHVRNHBuc8gPK9LyK9MvN3f5wcXGFakfPP2tSFxNJ68BcrXWdDsLywmS+nxMgV9drsqu15jtTYEk8xAA3kE6GV0oIJ/r0vzPKtTTh+hXPrCp01+1k5WHIogQip9ExG/dWNqE4VF4cS1CY4DfE0fLLjcKHMN8CEuIdfQGM5QXD8OXy7U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3833fb-c018-48b2-69a6-08db4d1f2a61
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 04:14:05.7337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OqudEhfcaP4wmxbXuFTk+8ijOL6Y+69Qka9jWml+iGVmAOUNIOQT6OwQ3QPLWsX1InZDKVeCP/J7XNqJQ3Qdcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=709 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050036
X-Proofpoint-ORIG-GUID: lxbPY2RJHvtvlM44VELLbJmVQP9BiDNh
X-Proofpoint-GUID: lxbPY2RJHvtvlM44VELLbJmVQP9BiDNh
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/5/23 08:59, Boris Burkov wrote:
> btrfs quota groups (qgroups) are a compelling feature of btrfs that
> allow flexible control for limiting subvolume data and metadata usage.
> However, due to btrfs's high level decision to tradeoff snapshot
> performance against ref-counting performance, qgroups suffer from
> non-trivial performance issues that make them unattractive in certain
> workloads. Particularly, frequent backref walking during writes and
> during commits can make operations increasingly expensive as the number
> of snapshots scales up. For that reason, we have never been able to
> commit to using qgroups in production at Meta, despite significant
> interest from people running container workloads, where we would benefit
> from protecting the rest of the host from a buggy application in a
> container running away with disk usage.
> 
> This patch series introduces a simplified version of qgroups called
> simple quotas (squotas) which never computes global reference counts
> for extents, and thus has similar performance characteristics to normal,
> quotas disabled, btrfs. The "trick" is that in simple quotas mode, we
> account all extents permanently to the subvolume in which they were
> originally created. That allows us to make all accounting 1:1 with
> extent item lifetime, removing the need to walk backrefs. However, this
> sacrifices the ability to compute shared vs. exclusive usage. It also
> results in counter-intuitive, though still predictable and simple,
> accounting in the cases where an original extent is removed while a
> shared copy still exists. Qgroups is able to detect that case and count
> the remaining copy as an exclusive owner, while squotas is not. As a
> result, squotas works best when the original extent is immutable and
> outlives any clones.
> 
> In order to track the original creating subvolume of a data extent in
> the face of reflinks, it is necessary to add additional accounting to
> the extent item. To save space, this is done with a new inline ref item.
> However, the downside of this approach is that it makes enabling squota
> an incompat change, denoted by the new incompat bit SIMPLE_QUOTA. When
> this bit is set and quotas are enabled, new extent items get the extra
> accounting, and freed extent items check for the accounting to find
> their creating subvolume.
> 
> Squotas reuses the api of qgroups. The only difference is that when you
> enable quotas via `btrfs quota enable`, you pass the `--simple` flag.
> Squotas will always report exclusive == shared for each qgroup.
> 
> This is still a preliminary RFC patch series, so not all the ducks are
> fully in a row. In particular, some userspace parts are missing, like
> meaningful integration with fsck, which will drive further testing.
> 
> My current branches for btrfs-progs and fstests do contain some (sloppy)
> minimal support needed to run and test the feature:
> btrfs-progs: https://github.com/boryas/btrfs-progs/tree/squota-progs
> fstests: https://github.com/boryas/fstests/tree/squota-test
> 
> Current testing methodology:
> - New fstest (btrfs/400 in the squota-test branch)
> - Run all fstests with squota enabled at mkfs time. Not all tests are
>    passing in this regime, though this is actually true of qgroups as
>    well. Most of the issues have to do with leaking reserved space in
>    less commonly tested cases like I/O failures. My intent is to get this
>    test suite fully passing.
> - Run all fstests without squota enabled at mkfs time
> 
> Basic performance test:

> In this test, I ran a workload which generated K files in a subvolume,
> then took L snapshots of that subvolume, then unshared each file in
> each subvolume.

Can you pls provide a link to the test script?
I couldn't find it in the links mentioned above.

Thanks, Anand

  The measurement is just total walltime. K is the row
> index and L the column index, so in these tables, we vary between 1
> and 100 files and 1 and 10000 snapshots. The "n" table is no quotas,
> the "q" table is qgroups and the "s" table is squotas. As you can see,
> "n" and "s" are quite similar, while "q" falls of a cliff as the
> number of snapshots increases. More sophisticated and realistic
> performance testing that doesn't abuse such an insane number of
> snapshots is still to come.
> 
> n
>          1       10      100     1000    10000
> 1       0.18    0.24    1.58    16.49   211.34
> 10      0.28    0.43    2.80    29.74   324.70
> 100     0.55    0.99    6.57    65.13   717.51
> 
> q
>          1       10      100     1000    10000
> 1       2.19    0.35    2.32    25.78   756.62
> 10      0.34    0.48    3.24    68.72   3731.73
> 100     0.64    0.80    7.63    215.54  14170.73
> 
> s
>          1       10      100     1000    10000
> 1       2.19    0.32    1.83    19.19   231.75
> 10      0.31    0.43    2.86    28.86   351.42
> 100     0.70    0.90    6.75    67.89   742.93
> 
> 
> Boris Burkov (9):
>    btrfs: simple quotas mode
>    btrfs: new function for recording simple quota usage
>    btrfs: track original extent subvol in a new inline ref
>    btrfs: track metadata owning root in delayed refs
>    btrfs: record simple quota deltas
>    btrfs: auto hierarchy for simple qgroups of nested subvols
>    btrfs: check generation when recording simple quota delta
>    btrfs: expose the qgroup mode via sysfs
>    btrfs: free qgroup rsv on io failure
> 
>   fs/btrfs/accessors.h            |   6 +
>   fs/btrfs/backref.c              |   3 +
>   fs/btrfs/delayed-ref.c          |  13 +-
>   fs/btrfs/delayed-ref.h          |  28 ++++-
>   fs/btrfs/extent-tree.c          | 143 +++++++++++++++++----
>   fs/btrfs/fs.h                   |   7 +-
>   fs/btrfs/ioctl.c                |   4 +-
>   fs/btrfs/ordered-data.c         |   6 +-
>   fs/btrfs/print-tree.c           |  12 ++
>   fs/btrfs/qgroup.c               | 216 +++++++++++++++++++++++++++++---
>   fs/btrfs/qgroup.h               |  29 ++++-
>   fs/btrfs/ref-verify.c           |   3 +
>   fs/btrfs/relocation.c           |  11 +-
>   fs/btrfs/sysfs.c                |  26 ++++
>   fs/btrfs/transaction.c          |  11 +-
>   fs/btrfs/tree-checker.c         |   3 +
>   include/uapi/linux/btrfs.h      |   1 +
>   include/uapi/linux/btrfs_tree.h |  13 ++
>   18 files changed, 471 insertions(+), 64 deletions(-)
> 

