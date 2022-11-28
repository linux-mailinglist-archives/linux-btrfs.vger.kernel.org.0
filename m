Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157B363A1FB
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 08:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiK1HeY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 02:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK1HeX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 02:34:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E717E0CD
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Nov 2022 23:34:21 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AS6aRwP015735;
        Mon, 28 Nov 2022 07:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=68pi337LBBxCm92y3o63ifIbqcLtQ8282kl1dpNdHzs=;
 b=sGNjTq9VMYEdnHJspoGqqUSYxL9TeIqnlpWlJAmx/DkFIQdK5vZ6UEHSbIK5ypD6yEVC
 NIPGdgnIvsALK7EY7q39OR2WCCNOYAWOFtxxuF6u97DkYz+K82+Zab9/jReqi8NYx+UK
 3AvwNfg1FwOa/mhZwk3U7v1r3FAw907VC6PUMOflQHcJYeeb81Lyvd/HSfH5cKw5oDhk
 5F6Z7yTVZwMdxlGL77T9iZRiu4VvhlqNgabhAMcmCLefce+ZwVD/0BdSmmG5RCkucnQ6
 WZu4sBgPkE1zL8iUkpSOraAJbQw3zWyZrPyzlO5URu6OtaZazNIfN3ah9oK4ji2k+Xxc vQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m397fahr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 07:34:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AS6ZveU005712;
        Mon, 28 Nov 2022 07:34:17 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3984qthm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 07:34:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPasoi3JlrCktcnBWoWcHEn/T4Gpcnd/dcMVpIEpHHMpDAZHqJDJnui7c7MxEIOzGl8BKJ6PFUpTxV5h1C/rnkj3XOa87h/fNLNanVbg8lu+roEVHXWZ4OJaUaut9rmvtLvIJH+MzBczgNAVShC7U2XkOQgIA15zS9A4K8M9GvC956nRW3ST0DxEYhTRSj9nMWG+1ASp2cVTCxgYhbNTcNXbRXM6eC+Y9JhWUHsPkh1skwwrOBNneWmc5ui/iOZY1r6Nk36s+4Khf4BamwA7sd1sN2el+gv1pr7JqgqheO34xTKXEsERsXIO11flimvLCYcrzdxagqMBNDhwsRgOcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68pi337LBBxCm92y3o63ifIbqcLtQ8282kl1dpNdHzs=;
 b=UFptfQCc1nFWnWkKb7Gd7PZX2KrvrqW+GMw4QJWYxPJ1ieGoOx4nii6iNb3a5y/0K058BH9yM6IPZKvrFQSEVC5zpw4jnVGFy6e9i9x2ozlrkZAUvLhCC6t/UiTWQ+o7wEnrMFkleZqz2JpeoGXc8w/C3/HSyNcDtKqcSEmQbBKuae8OPzElakQnTFVTf2PIswVIYB3qRV/rCp96G6062uETbJ2hbYDlOPw/vRijaWAzQzTGHxeJ2Bjpy1iPRxj0L57uF7rhZCqrNefVC3Lbise2KCSGHt7hBVNQXWw9s3Swai+Q8B1N1BJF5fP9NCadunsZ17KDaMS9BRTFeD5mAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68pi337LBBxCm92y3o63ifIbqcLtQ8282kl1dpNdHzs=;
 b=JMxcPPudtPEWOCmOi0mUa4K+Q/LoFDBUPAXlWmxLYYLZbz0tHuV8zfUx4EpBgfkLAXFadmqxeZ6c4fTwqnVPZAR/+dXdzljd3AFyOC/jsBKmu8OceNO4kJ8UW/4GDVqJ7E9YidoggA+VBD0Wtu9wZpMUi9rFZji8KUbvLnxDuYg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6254.namprd10.prod.outlook.com (2603:10b6:8:8f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.22; Mon, 28 Nov 2022 07:34:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65%8]) with mapi id 15.20.5857.019; Mon, 28 Nov 2022
 07:34:15 +0000
Message-ID: <9bd99a08-5821-09e8-af7a-efe0433ea997@oracle.com>
Date:   Mon, 28 Nov 2022 13:04:06 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v3 03/29] btrfs-progs: properly test for
 send_stream_version
To:     linux-btrfs@vger.kernel.org
References: <cover.1669242804.git.josef@toxicpanda.com>
 <e7ca4d3f79485396cc1e2d7e8d635983a1c2e2a9.1669242804.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     kernel-team@fb.com, Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <e7ca4d3f79485396cc1e2d7e8d635983a1c2e2a9.1669242804.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0196.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: 722d2bed-9124-44f7-42e5-08dad112f37a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ntMCvUIisGdkhMFp/4W1/F2irNUIRRv2UBAC0p0u8r+t54c/EAZ0+k4tbD9yJa2ACrx2i8Dvx801jcuqXOTf7iNl6PYhjV35bFeDrziFx4VpSw/M3W39jTkcO4AoMpsZvxPFDPDePKtW82HvJS0RFfQcz6Se8JGD2bdbI9lgk9TJjMYdyWv543ZftrvdogwncQCT8XqYjcGXDcg/LGlqbx/I76Cms1GwbuqxL7ucAikO6iYTUSxy1s6gqcbSa4UrLvjYRYC3ulX7JzBkJN3/FlJMVhbMgiRnDqR8ZW15XD01JTaCbQlia6ZhJAkpqiotv/EUeu88BwvbX1Tg6GfNLIlVFfimaUojvHMFR2FfDAQ1oqji18cmWc16wJwucwSbXymmyqiFRykdXEHTp1Eh1V9LgYcIxs0UkM4Y3fzRjKqU0BCSiybjyHlrFC12Rp+54AuIIcZq4E4jSv71xIMtRmBXtYV8gYIBgKgYu/fz9UQjMgSWFF4sDSPz99Uchmfc7ZgWh4U6NmhVCsr0eiPhrJ8QxW+OhlyTSyJ8GHESmAsG+W4qcoe0kbFTdD9jmEpkMxencOlh0r92WR81RyBNNVTglCTgX99shbrp/gFyAebfM5WxERR6CXjkSyRLaMs8gDFF+Uic1QeEyUSBZ0xlDdr3N79utk9f967hGuWp/tTGZysa5vIPsaBMM1GQNYogw7XAyXohqwAxQIsMg3b5bo7KIH2UfILWE2hDW8NJoBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199015)(2616005)(31686004)(2906002)(83380400001)(478600001)(38100700002)(6486002)(66476007)(41300700001)(66946007)(66556008)(8676002)(36756003)(6512007)(6666004)(6506007)(186003)(5660300002)(53546011)(8936002)(4326008)(31696002)(86362001)(6916009)(44832011)(316002)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW42TGdYVGhqd1FoNENPdDhoeHFYTC8xSS9oSG9kODFJMzdjUU1jOTVMSi9Y?=
 =?utf-8?B?U3RtVWZLcU4vbXJsbnlEaC9LQTZBa2d3RzJPUnQ4aldpckdKSkVFWFVENzNw?=
 =?utf-8?B?dENBc1p0M1FMRXpaZk15ZzhKQlNyV0lBbVFtNjk1RDFCclNNcDQyYUR5TFUw?=
 =?utf-8?B?dWl0b1U3Rms1Tnp2enVUcEdud2hld2crSGRxUmEyK2hlSEMyYTVtL3JzbzJQ?=
 =?utf-8?B?Q254bDA2eGlLZVRPdTNWNjVlRC9JNVVSMUgvVVY1RGVxNXdGdGVOTnpFL3Ra?=
 =?utf-8?B?Y01ocXRZSktBMDlHMHpxMVQ1QWZjSHZLTXZZVTFVRDRNYy9BMjNPdHkvamY2?=
 =?utf-8?B?WG90V3FrQ1hUVW8zUUtpYnV0Q2ZJK2pIUmd1RnRzMlB2OHQvVGVtL3QzVWNW?=
 =?utf-8?B?R0ZFazdxTThidERZYldBNnFhODBSaEFaTDAya3dNR0szNkpOZk55RmdhREli?=
 =?utf-8?B?c0lZMEtjeXNzS1RjRTlnL3Zva1ZTZ0dxMk93ZTBhWVFSNFlpQ2k0MFBSMXlx?=
 =?utf-8?B?NEFZUWNDZkNudnV0ckMvdnQ3N21RR3pCSlcrNDlCTVJpcWdkclp5eVZEWGhS?=
 =?utf-8?B?bzBnZENwV1RGbk4xemRPSFBabVBYRUpaSGM3ZzFuVFp3SDlqOUNqSC9mRlAz?=
 =?utf-8?B?ZmVZL3hvdTZEV2pua1AyeDRDUHdXa2tIOElnY3hoaktrUm4xQ1ZKNWtSYnJu?=
 =?utf-8?B?djdCN0lGY25WdWdWOEdvZUtNREhBTjJQZE9FV2hxREtkZGlkOFNMRHB0ZkJI?=
 =?utf-8?B?RnlMREFXYURQb0tRRlNldmpvU1djQ01RSVRIM1dqRE5oTkRoVkJzSXVyL2Rq?=
 =?utf-8?B?bTRYNiswQmFzcGc0T3p1UEZQWTJ5VndRWGc3d3hJb3AvY3JaRlUwWnNtaVJ0?=
 =?utf-8?B?dTY2UFFPZVhKTE9Wd25WNGZGVXp2eWlVZ0N6RlYxMjlNbERvVlI4RTN6cC9a?=
 =?utf-8?B?SnQ1T0FqdFVwU0hEWDFKenhpZy82NDFoV0xyalZJYnlFU3R0NVQ4akpIUXZa?=
 =?utf-8?B?YlJzMnV3RllPdUp3OEUxWmxUa2Z2cHNaS2JCQmZlbm9HNGhVajhEMFM0Tzcx?=
 =?utf-8?B?anBWd0ZCeFBCYlhRZC9wdDZsSitGUzJpcnkxVlZSSnM0TC9lS2VGajhsSWV4?=
 =?utf-8?B?KzN0UGtrRUczV2lHTVRMS0JUdXo2ekNVVndmUzdmaFo2SlVEdGZ3bTVSMm5v?=
 =?utf-8?B?ME5YY0FDYmpaTm4xSXpkSWI0dGhWdUkxRWd3aTBpTStlQ2pEZU5tYWtjQUl5?=
 =?utf-8?B?T2ZPRGNBOWx4bTBsZDJLaS83VU1WbG1xU1YybWc4UDNiRHdZNkpFVW9iZTll?=
 =?utf-8?B?c3BzanQyNCtxOHRQejRGN0NTdllmdjFoZ1htNnVDYUhFZEpCanpVV05Pc0JV?=
 =?utf-8?B?RnhJNUNjeTRPbk9hS3JMay9VK1RORU1UQkhpQjRLcFkvaGxYRUh4eFVWVnV3?=
 =?utf-8?B?Y3BCOVk4SGFqams1ZDJxcWdpeVdHQko1S1RoMng5cG4yK0pWVmk5SU5KR3E2?=
 =?utf-8?B?ZC9xcm8ySFRFMFBmQnpSMVJvTWxVUjF4NDZKV0wxdUw2Sjc4N3RJSUIyelZZ?=
 =?utf-8?B?YUdzNld3Rlp0VUJYRk9PVnYyckRveTVMUUNvUmQ3L2F2dlFESHNZMTFHNlJ1?=
 =?utf-8?B?Kzd3RnBkUWRSMVJMUEpNdzA3Q1o5cUc5NHRCTnEvcmE0bHdZQWI5NjJlS3RG?=
 =?utf-8?B?SEMwbm1sQTBqYjBLV214MFI4enVYRE9KU2RIVFNIV2ZmNmRIbWcwNXNGRVAx?=
 =?utf-8?B?bzFvcXRhU2Q3eVRBNjVLdmRSL1dZU3QvVXNrZVlVOFBhSWNORjlKUDRCQ3J0?=
 =?utf-8?B?bk1LQXBjcUdFbzJTdHhlaHFZeVI3c1JwOCs0WUhlMzdrQXdiQUoxd3h6akFq?=
 =?utf-8?B?N2ZiZE5wOVNrR09TSTkrL3FLbFVBdlJERlZxOGNYWW1Bbytpb2lsbThVYWt3?=
 =?utf-8?B?eWRmUWNyRXhhZlNoY1BNaHAwRnVDWjNTUDk3MFpvMEE2YWFwaGQydktmeXRt?=
 =?utf-8?B?ZWdsbHI0Vks4UXNyOHM0Q0E5WmliWmc5NXFOTm1oVUY4TFB2dzAzcHgrMU1D?=
 =?utf-8?B?RWw0Ti81WnBhMU9wNlBhdlhOYUdDSS9BWktTbmo1RUE0a0ZkWm4zb3BpSERx?=
 =?utf-8?B?YzBSdmpuaXRjMXlVUEdwNm9vN01LSGtzazcvUnEwdE1QcERtK2IrTVBrTStP?=
 =?utf-8?B?OURMR3lFU0wwaTFPeTh1SitMcXBjWEllVklNUXVYRUtNdnQ3SnVreko1R0Vo?=
 =?utf-8?B?VEVJSkFzUFc5REFwWi81WlpFQmh3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ri+9euFVW6EGjqtNpSwY9a/qHaLtO+eJ+60/eTadg38yC3PFbitO3e4R5CAkd2+xiDhIVbBY78PAsF/Gsz3gbzcMExe4fBa5VhbeHE7FZvS8pJdCg71seaKlQeant7FXHi/Dzrh1JmHC++9tSlexNY39e0v/OWKFhSYioRkbiPBaHcF8kXNAU9ZfvCTRDcIGNNvPxKgSRNUCU/NtjW26DLVroz7DlHZjEC3t6iwGnDuhmvXirtyRwCRlN6dIET+bWHqIxQZwa8Ier6efoICtY1bKjhKIIHyqfHC/x5imOY2HqzN+Wj8Gw6XyPNZOsD0/i6By6oYr9Ihiqv2d9Y0unt2LUY4wilLSAnls6B01ZwFcYUR1U0OI64iqW3zYZKgPjdgIz9qG658/T3MxMe/rb802GXcJEB0vEZc+aCsyD28gU7Fl7ucjndo2GX6gMQoF68lh7XQgP+KhxSEOuty8wrrpg+6YBm7NUeLuJcGQ6cHmfxThkeaj2jR1RoEutwbp9/ydZOFsRQALSk8fhSZPrqbMHXMM2hGNFPBzU5yU2MIN2lhJBRn+zI8Bbx9Go9IexpKIgGqT5gRhXk9ux+5e1oRo7YAdVbuvpu+OT98BvoIu5W3fk+kAIYNvdSwBcuGo84otvfVbqcOO0C8XEq1L3oQL+ojV4HVv2ZBK9LLntSHJ3LUBr1+zSMBvUYZnhN1AlOMivH9ecJgYFgFJsVKouRcwtk7OnldowY6l0/QckBD0BenDh4yelp2/5DdOkS1a02/1HA11n3QsU20JCltIiKceEbr70Lfzi0TzH6cCjZogsp9EVflzcWOktQs4lojS
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722d2bed-9124-44f7-42e5-08dad112f37a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 07:34:15.5212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bp0Qqok4jJ/rlVCKj0LL/V5i3xBPvu+hdVouzXi3gHL3t6alqIQvwe6qtGecXByP9doxZiiCZpdv1R01d5+Xig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6254
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_06,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211280059
X-Proofpoint-ORIG-GUID: WfHM7xI1MR05dT_xyLo8y5xbZom0mvL7
X-Proofpoint-GUID: WfHM7xI1MR05dT_xyLo8y5xbZom0mvL7
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/24/22 04:07, Josef Bacik wrote:
> We want to notrun if this test fails, not if it succeeds.  Additionally
> we want -s, as -q will still print an error if it gets ENOENT from the
> file we're trying to grep.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


Patch:
     btrfs-progs: tests: update stream version checks in misc/058
                                                should be 053 ^^^
Fixed the check for the older version.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
