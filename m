Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D5A6C2876
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 04:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCUDDu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 23:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCUDDt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 23:03:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1011F5D8
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 20:03:47 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KM4OQb030599;
        Tue, 21 Mar 2023 03:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dF0iGbpuOTnvlYKIAMZeLnCe3vE1EGSXbxprVhVWAqw=;
 b=y2zuAYsL/PLlDBXb5Xgk3gl7p+ygTLLvdJK/gZmNbxEujqM8oa9SWaRyV74aiQpvmI0g
 s1gcFUVdcqFK+XVIRHiHhEDE8QvDgOSW1qzXnVWsUtSjwu2Dh02BwyOT6fowNHNFO7Ry
 RTpYdCA6K2sljiEGnCv9nWadT173QXUQWrC/rLUIaGmCsqkTYqXGwWh4sVQfB1vBIyrE
 0f+pg6pN5852sT9BU32VirxuaY52KXLjNCDmmVlI8Xkg03kow2BhyyevjkBTU7zF43Ly
 amBIhcl8do5y8FIF2d4wE+BRgssORKgOETjenaGnxIq1w/AmAAbY7MzFmmMprwKtofZA pA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd433n42w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 03:03:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32L2BQCL015497;
        Tue, 21 Mar 2023 03:03:29 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r5mce5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 03:03:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCIQ6ExI14iv/W15M4fQTt+QyC8Zg/5l5C8s8JqjCbabLjGKYkTfhQ8cS3ajW2uBeY3MUokYmvBJw72fJuKMjNflUYwSuz8dR0ysVRykAmNOWxryjapWtxnuH4B0IshmCGcBcukPLj3H9MW2JWeGQscL3fNNWxiJ31D8eHhEszLhIdc2OvKFGd7QhJKWKynnx9K6SCMQk3wHtk0rZIvlHPI0MAUxXZcxsVwAZmM0PxqtbvBRm7H+H53IdJtmtYhxlMJd+LqH5srGvxPVy1ufqKy1cph55+366njZAvQP6IXtO744p9SPCvm1IgH3c0Pjhm/Vb72KN1iKCcPWWKUnpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dF0iGbpuOTnvlYKIAMZeLnCe3vE1EGSXbxprVhVWAqw=;
 b=dz4ZmYcHVs9cxefongHxZhvXDmRKK8xF+weq2Fm2BVza3NTe7h+S6V5dzhYGSsov/r9dhw+KIFNpFHsnv5mVlPvrQh7lkNM8YwsBLMoSWylx/MxfJsW2sQxm81A0eX+6p661vEPOA+Q8qeHnoG2tuVYvVybihmUA5fDyd01k/sNFVAyBbyKBaqBrCdYsmaefkdCX5Q8C2r73eQslO6t2rpPaee43Ia41IQtTEApYpKxcbRoAEHCgG9MwhrRFXkue+XiwwrtZ0zPLWe1j+bcwymQJzzMlP736IA0y+FEpEc3K24rp8q6LbbjFxqI5zuYVgcLL7keF9kILIZKTcFu2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF0iGbpuOTnvlYKIAMZeLnCe3vE1EGSXbxprVhVWAqw=;
 b=NkHd9AkU0bAViOH/woSO2EWBTNNSGw4QDXr4ikofB/v4xx0uH0HE+rSsqZWzLYKiq4AUBfR6zmUAt9yhEixRnTodU8Yk9S0Kn4nE/x5tfmukZhiJYyM9AbMAmSGtFxT8dRgAFd43JhV4ndLjnQTSFkgJ3O9PbcjmGX885GEWpuQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7212.namprd10.prod.outlook.com (2603:10b6:610:120::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 03:03:27 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 03:03:27 +0000
Message-ID: <a0073d57-1de7-3220-c706-b576e5cd407d@oracle.com>
Date:   Tue, 21 Mar 2023 11:03:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] btrfs-progs: mkfs: Enforce 4k sectorsize by default
To:     Neal Gompa <neal@gompa.dev>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>, Hector Martin <marcan@marcan.st>,
        Davide Cavalca <davide@cavalca.name>
References: <20230321020320.2555362-1-neal@gompa.dev>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230321020320.2555362-1-neal@gompa.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0210.apcprd06.prod.outlook.com
 (2603:1096:4:68::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bcf659d-499e-40b4-aa2b-08db29b8d796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W0Iepa/aqnk3Zr/DPd81hMJUdcn4Donu5iimC0kgik8dcpZkoJeHtjVSe7VyVStF1q7I8VKV2PO39PWQkqVjokAbMNzy/CnKW2wzYBwsrqecRfehPdV5p3UqMb4CiWEhNBHkZp0cyHu8auXrfGjy2cHOo/YU/w9Q9xmjnE7Mpc724j0/KqF0wazC3Qe1sunTiPgfEDlz2qIvnLUouKQBaD8Nfs6YAqkQHQKPfnLXb1L3q3doMh5CcBsVQau2K2wuRbWDRxAC+BWE/jO8HsboH0CcbTY/ZFCf43CaarjLe+k2GZk8QMBSxFQxhgHrRVbN/l307i9Kjn3CLzRFr3rwuI8tpEg1DeV1TzXEH4Av0PiEfDH92KA8gjteH3Aou2xuJOt6OCyv+gQezGNafJdWkf0MJwzw12SFRStIzE4FaXUJLEJkq/0APyZYbySWisaIxN2q/AkQ7EoYYJyfdzUjySy0NygU0nwdPKxjnX+mgmk16VlQTOo+iNjpadVGrVxnmtUQoFFWZ8zWCdMJQVTQiu92IkjjJYgFFdT6p8lY7xFAsgc/+qcfYZcDCdQK0CbhfoBQc1oNk42+zNgP+RzE4UrE5I2LqP8SffKuauMJo+O6/ubnAm9U1tistPWpF4pkj8I3J5KEaOAvNLaBbFPFqaDkMnDz0sT+Bs3id9Jf/QhBasNg0+RXK/wlt186qzssT3+wPctMUxVJG6bGNFwJkbx+DOq4Qf8CEx7NSoPHlUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199018)(2616005)(83380400001)(86362001)(38100700002)(66556008)(31696002)(4326008)(8676002)(41300700001)(36756003)(66476007)(44832011)(66946007)(2906002)(8936002)(53546011)(186003)(26005)(5660300002)(316002)(6666004)(6512007)(6486002)(54906003)(478600001)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUlwRWJKZzJYZndiaHNkQ1NUZHB3T1lqcE5obGozcUpCWlZteC9IdFY1RmxD?=
 =?utf-8?B?UDd6RGhlaEN5WWUxczl3N2lyMkxONU5nRW1jcW1HZkxXbUsrcmpUTUNzcGpp?=
 =?utf-8?B?bWdIcnlGOWdadW9uN0hZQ3U3RXFnNkNMQXV2UWNtWHBFa3kreFlXMDVLOSti?=
 =?utf-8?B?L3RQVllvcXpDNXRJdkxiU243eHZadnlyOCthckhCSjBiR0FhRTQrNHgxdHQ0?=
 =?utf-8?B?Mm1BWFdwMnNsNWNQWEw0WW1kd1R4MzQ2cFhrYngwbkxUZnZnSEZnUXZTMjFG?=
 =?utf-8?B?aVVvK3VVd1lzamUrTXRwZVozaURrblV4ZkJTMTNWT1NZdWJLQy80U09TZnFl?=
 =?utf-8?B?ZlpHSDRaemc3d2YvRkFBQUFGZS9Wa1V2NUpaQllPYW4zZXdUT2xaZmQvUUxr?=
 =?utf-8?B?dmtOZ2hqSjlybXJrSnFQSzRER1diVXcrM05tcm5XTkVmSTZsQlBnVzR2ZGdO?=
 =?utf-8?B?cDRoNitqRHdvWDV6K3VCSk9MSmhDSXhBaFQzUE5XbXJMMUNobG9nR3pYaGhS?=
 =?utf-8?B?cUVCMURGam5yVW1rWVFyUWlESU1VUjVuWmFybW5DOHltaXFPNmszMFVDUElC?=
 =?utf-8?B?ekg3TS90MVF2aUU5d0VxTmJ5RTNuMzgyM2JlUGFXNGRxMWswWmV2NEp4WjFE?=
 =?utf-8?B?NUlNd1FFOENTdEFoS3pGdXFHYk1waUJyMUgzOXp6cDNhOTBZckh1dzNwN1R6?=
 =?utf-8?B?aGRjdkdxOVYrcFgxaDBhUDVRTEk0cnNWRWhVNmZQQzVyS1VsMTlTVzRLdjVC?=
 =?utf-8?B?ay9TTGlGNnZ1WGUvQmQ2aWFyOG8wQ2VVSlRqS2pkZzd0VlR4TDF2cmhwM3NP?=
 =?utf-8?B?RmlTbXNiYkIxMGo1a1RkWEJKT2FRb3E1U2lITUlXSkQvUWJrOHYwK3JaZktG?=
 =?utf-8?B?SkdqZ3JiSkM3N2FCaVRWejg5V0lHQmRiT0VJR1ljckllaFM1UUFNanRhS2Jz?=
 =?utf-8?B?MDMycmZDdVExemkxUDUvVzFsRER3YWg5NytyeWc2NG95SVZNeE9UcTJCY0Fh?=
 =?utf-8?B?cStUSG15Y0l6TzZBRFRZQnkrRUdZZXJ2YUZoOFVLN0tMbG1BdlJxWUlORzI2?=
 =?utf-8?B?U2h6d1RSNDBtdWFMUkp0RFR2SktEQjNvb3FuSFcxRUlkQjU3S3FSNFI5dXhI?=
 =?utf-8?B?SEUzV2tGbUkwQVluYXF2dmMybndFOWxVcTQwVzJwNEEyUDJmVkk1WDQ2a2Vp?=
 =?utf-8?B?ZjFOUmRSYWxqTlJtYkNhdm84S0F2M0FOMTNaNFlZUFhVeDkxdVZyK1E3UTVD?=
 =?utf-8?B?VWFKd1QyWUFxbndVcmgvYW43eFhkWHZCNWo1MUFkdjRDWVdLbnBORE02dXdm?=
 =?utf-8?B?TWk1UVA1aUFpWHRBcTd1dE0yeDRhaUFjNEJicHZNSG9Pai85QnpvTDJnelFC?=
 =?utf-8?B?Y29aaENHRnArU1k4NTRxM1FlczdRU0E2QndmR0UydXJORUp1K1RWYXN2VEFn?=
 =?utf-8?B?RnJUL1A3NUE5ZjEwZ2VQNkVERXhpeFNsQkFIOUxzeExhVENiMHkrVlMrdlpJ?=
 =?utf-8?B?cThzVVYwU2U4eWEvUVdCZjRGTTRlTi9FcjM1OTJnZkx1U2dLcmprOTN5QkFn?=
 =?utf-8?B?cFRITUFwUkhrdXRjYnZPb0x0UjRJcmo0dHJOVWQ3WWlhSldnQm9kNGpzN01s?=
 =?utf-8?B?VHRZOHNpK3J0MkNwSllmQTdmNTY0MExsTEhUd2pFM3lSTkMxTm94bDI5VzZo?=
 =?utf-8?B?N2tPc0VJKzljWXA5SklnL0I3N0xqeTlLN0JoS0xqTXFuZ3Zha0lFL1VqVUls?=
 =?utf-8?B?Sm1jajZWWHBZandDYzFXQlJNVThPYWdIQUFETGtUOUZPUGVMbkhJdVpXTlNK?=
 =?utf-8?B?VVhtOUppeGZHUGxiUjZ1WGg5ZzE5dFNOd1NYV0pHMWdnNUgxV3lPQkNXbEcr?=
 =?utf-8?B?dlJCN0tIS1lhV3lUclVDWFRXZmpnUG1KZWgwcXp4TitobnFNWkR5MjJERmth?=
 =?utf-8?B?ajdacDhXMWxRZEZJZ3lndlR6UEJ5bmZ1dFdDVTdzc1hNOUlwbzVrS3loQkIx?=
 =?utf-8?B?NFRYN2JYUk94THUvQUNNZFZXNVFtMmJFb3hSSWhJaHpBRlZsMmJpenFBb0wz?=
 =?utf-8?B?UHpoZzZRQ3JSa3F2Y3MzZmV3bnR0KzE5TzN3ZkMyMWRuc0NZZDg1SmdzcGxH?=
 =?utf-8?Q?KDWfMKn2K49sh4/UYzjYICatm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3VS4nAngmgW2QN5CbX0MjJik+KGds12w6b8IY4BfEidBhQ2vLvo5PZyqBMwEviu0OlJ/MYv56jhsPvbpp7/HflBlwiH5DKwImAKthx/7SbkDF/eFik3Xgfsp3Cv+ISwAadulLvSkOZQRUAWxnVHsMJaF97MbQASvFQIrtJ7a4DJUyIay2MfzGrdrd0RdLVPL/3UebqP0erX2NRGTynzymsaWgTNEKrbcn32BlFIrcfnlk8T12g88yrteLI8lUoaClPiSkXp0XRX7W134dKxvXDgsiu07PEZ1p/rhYO9mpJuKNUa4NoSaw+4hpJPK4ki9sYE9boHDMQyJXSKgM79JqLwuvrbj4ff0tc84lLAPB4ev+wkQBEkaeiLaGY883/YLEzk5jC60eKW7VWtOkNx7+LArDK5H9PO4G3zFwEaDVXGkopZRhCroBe4YpUQNowk21t+qTDwv6YHof53XsIPp7pWtoPdkpScQMkLqIkac8y5D93szPb/dmKCNgb7sHccwgfSH7nLUMyQ32OYmYrg6DwDL6/17bNiKdm8rHrlJdmH6Jr2rPdbrf1tCH5jahKajJqhzzca9neuTY3XPYIUZiAObw/K2HNJlrSbWjp8v8FaTgG5wZx7W8mF90pt5zKeFvztPsKstQik7WT3ERBIdMOpahg34XDsMZnrOhsspmYg29j+jyLZdsyjRZCYrlN2b5w0MLYchGeCSz47rK947hwQ+YJwSfxUlE+IFu9aYwhwP9afpDNCd1lDXuj16oyzuQ16hJV7WVS/QrjHdH9PJ73EZchraeYoau60HqldBLgXJyREjV909flZKz6quxHIxa5FUl0+jKw2H/LZ7DAldMe26E5/reKUKQn8n0ZhIuuBlZEoBRh8nar5FPXhCOA0d
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcf659d-499e-40b4-aa2b-08db29b8d796
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 03:03:27.5596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQWR8LemGfn8OL6TNkujWOvDksNA/rAo33ZTcwv5YeuIEsA/kiIUHvwVAJO24l70lVz5M4wRuhF18f+/gEhblw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_18,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210023
X-Proofpoint-ORIG-GUID: L9nyN4sGqvdOm60rglaGfz9MfZwjF_nh
X-Proofpoint-GUID: L9nyN4sGqvdOm60rglaGfz9MfZwjF_nh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/03/2023 10:03, Neal Gompa wrote:
> We have had working subpage support in Btrfs for many cycles now.
> Generally, we do not want people creating filesystems by default
> with non-4k sectorsizes since it creates portability problems.
> 

I agree.

> Signed-off-by: Neal Gompa <neal@gompa.dev>
> ---
>   Documentation/Subpage.rst    |  9 +++++----
>   Documentation/mkfs.btrfs.rst | 11 +++++++----
>   mkfs/main.c                  |  2 +-
>   3 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/Subpage.rst b/Documentation/Subpage.rst
> index 21a495d5..d7e9b241 100644
> --- a/Documentation/Subpage.rst
> +++ b/Documentation/Subpage.rst
> @@ -9,10 +9,11 @@ to the exactly same size of the block and page. On x86_64 this is typically
>   pages, like 64KiB on 64bit ARM or PowerPC. This means filesystems created
>   with 64KiB sector size cannot be mounted on a system with 4KiB page size.
>   
> -While with subpage support, systems with 64KiB page size can create (still needs
> -"-s 4k" option for mkfs.btrfs) and mount filesystems with 4KiB sectorsize,
> -allowing us to push 4KiB sectorsize as default sectorsize for all platforms in the
> -near future.
> +Since v6.3, filesystems are created with a 4KiB sectorsize by default,
> +though it remains possible to create filesystems with other page sizes
> +(such as 64KiB with the "-s 64k" option for mkfs.btrfs). This ensures that
> +new filesystems are compatible across other architecture variants using
> +larger page sizes.
>   

This part is a little confusing.

We can also include kernel versions that started supporting subpages

v5.12   read support of blocksize<pagesize (subpage)
v5.15   write support of blocksize<pagesize (subpage)


>   Requirements, limitations
>   -------------------------
> diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
> index ba7227b3..af0b9c03 100644
> --- a/Documentation/mkfs.btrfs.rst
> +++ b/Documentation/mkfs.btrfs.rst
> @@ -116,10 +116,13 @@ OPTIONS
>   -s|--sectorsize <size>
>           Specify the sectorsize, the minimum data block allocation unit.
>   
> -        The default value is the page size and is autodetected. If the sectorsize
> -        differs from the page size, the created filesystem may not be mountable by the
> -        running kernel. Therefore it is not recommended to use this option unless you
> -        are going to mount it on a system with the appropriate page size.
> +        The default value is 4KiB (4096). If larger page sizes (such as 64KiB [16384])
> +        are used, the created filesystem will only mount on systems with a running kernel
> +        running on a matching page size. Therefore it is not recommended to use this option
> +        unless you are going to mount it on a system with the appropriate page size.
> +
> +        .. note::
> +                Versions up to 6.3 set the sectorsize matching to the page size.
>   


IMO this can be rewritten as below:

By default, the value is 4KiB, but it can be manually set to match the 
system page size. However, if the sector size is different from the page 
size, the resulting filesystem may not be mountable by the current 
kernel, apart from the default 4KiB. Hence, it's not advisable to use 
this option unless you intend to mount it on a system with the suitable 
page size.


Thanks, Anand


>   -L|--label <string>
>           Specify a label for the filesystem. The *string* should be less than 256
> diff --git a/mkfs/main.c b/mkfs/main.c
> index f5e34cbd..5e1834d7 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1207,7 +1207,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	}
>   
>   	if (!sectorsize)
> -		sectorsize = (u32)sysconf(_SC_PAGESIZE);
> +		sectorsize = (u32)SZ_4K;
>   	if (btrfs_check_sectorsize(sectorsize))
>   		goto error;
>   

