Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6791E6BCA31
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Mar 2023 09:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCPI65 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Mar 2023 04:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjCPI6f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Mar 2023 04:58:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5758CC01
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Mar 2023 01:58:18 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G8Y4Bs020675;
        Thu, 16 Mar 2023 08:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vuLCxvOpizaUy0FATtUct9X3hh0sl6uVDUNkP2NIvBo=;
 b=wPErQgNf28ukrqmf+nkV3Pi9b+sIYG7gAvTwBXJUo6WdWhVUbDEejgjShyfxSeIRHWGj
 1eYrQdiRs1kC7B8bmAp1JU19Jcvpj6+8JpgGgymc6fgtyN/qlwaXYOuXX1ZhyPAFxqAe
 qeJynB9LvNpgPVxzh4Q/pf4qLoKfP2ThzvwOnN6HnwAqLITOAmPvVQIp6IlmD+JNUABF
 bn2bsnZ6U3DoVRPhqZ4YcQuQbI88d5jywiJ7KWr5YtJ3elpBs8DEkvz81Rb1cA2ycAZF
 EHwTXhS4xhIHsAxrdSz1O+e2f8Cq+34VJfoEIGBvHcJ2yQl8PzQQPez1TddJjQr6VkAS cA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs29gmbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 08:58:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32G75oPc003170;
        Thu, 16 Mar 2023 08:58:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq44gfkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 08:58:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLjN+HCx6JdcaackQPKCt+1xlq+clQQCD1aqKRfXjYDjlfwV+qEgdrgK5oCQwKLWoflQmH0y0vZX5vHUHZxtJFR2Bh613vEQOsh+j7VxS84XS1poXfhUyuPajFvvFHNJSQauaw01ND7RacqQ8tXoJSOQDQMVUC8NwSvGjp1mxD/2KIrZSlz7lL7hrMqKPX19kQup7EE3acLNTkLM1jeXW/RrEunieOQeo+2lQcgYCXk+qxgLmjsqYA4FNrpCJ8KmYV1ybX+8Q9s+0lmJPuEvVyfpYTqXw2G1Mv8nZC6ppF2ApiBez+68HPDNdrHjdcj5Nf16zhrYANX0cCkysb9Wpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuLCxvOpizaUy0FATtUct9X3hh0sl6uVDUNkP2NIvBo=;
 b=T5JIvJB/4GV0hcTbIRKeszcuRoDQo470SfTpq1Be15CaAYx24ydXR+q3LqEbw54P+F5VA8nVsEI80grbiiud2pU9DHjV2OB+xFiBK+vCYzHaJlEK3aj9ztBVbOvPcXa0aAAyCf+mlaGbwnn7Uk7ga+omFOFGYMtYkppiw+N7pAjtlWO1XWoifYFEhctka3eRAu3z/Ze85W2vomtk85rC1HPPUsUGgZDutvbI7Nql/ZisHJccCGgAWUfSUrKx3mTR2GKJwXXoAWRskVhEb9pOXY2/p82Vhi4ln2nLBswDlp4nsQFqRMGTQe+p94W+nmb/XREiF6h4qGYjGRNYYJbXDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuLCxvOpizaUy0FATtUct9X3hh0sl6uVDUNkP2NIvBo=;
 b=vForrBrWJi9mWU7sNYn6TgK2ZdCFlw+5SJ/BY3x22dONA/mw8aBNVL07o5ZBZP2kuLxNfEaHWXVDBD5xm1VDjGHWkiME7Pdo0+V43FsKUCWRcTePom0UB7xyHwbLNyeoIe1APT2XlcSIs48x2+7xVeIAPiX9e3jVe1aiw6BBxzI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB4933.namprd10.prod.outlook.com (2603:10b6:408:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 08:57:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 08:57:47 +0000
Message-ID: <4e5ce579-7c66-ffb7-e2c3-8b3727695f86@oracle.com>
Date:   Thu, 16 Mar 2023 16:57:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 2/2] btrfs: btrfs_add_compressed_bio_pages
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230314165110.372858-1-hch@lst.de>
 <20230314165110.372858-3-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230314165110.372858-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB4933:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c51b88-1a7f-45b2-27a9-08db25fc831d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JucaqkcfKHbDoNvFfsESJFltWxPweCvJsLTjnInQnbXhLjzxZL4OfS8kKbws1QCAXKgQjwyttwtUSrWa+LYRBpiT+PEgkO04NJ5p4iwUsuRf/pwazY8r33SesbTZlj8ICd7NS7ehwPhZNwN0m2ou8kXHF/W+OTUvjr8n9M5D5CTXCEtAMN0lh+A7uVEIpz9iQtlDXP8ICOvEEUPzWbhiqhXKnnbX0d0uI59L76SIp0sVaWXN59vvmtGsMbCYOe3Ku88xK7q31yev0ps4euzBXSuobfitpgd3JeDP1g5t8lmnp/552KB6nfswtrl071qb8f8YepGql6Zvltz5YV0g9ZrahDUXJwYim7rU6UUaXW3U4boZsbzoiqjRMhd4rqkqf1MMgecuVlQwfwzDAQeo9mI5+JoeTj4l05fX4gvoLeE+CxNAib/EY/C13hIyrPgl5Wv3IEX61ffEne3I5WfmjVaMBKcEA88LRljbSeBkVQHS1Ulpjr4RmnEGk4YAlUYfMzoi9mREs1nwNMheTRIRNAU8Qqte7WLmb6yR7N/t6oVTGD8oFZwiND9IO7CtqvhC0bPgJlPFheAV56PYPk3H0sif9dATxy7w9LtlhymgGTJcB6sGXV5yGP002v95U3QA1ra1H5jpBiTUa67GDp168O+47Hfzhf1QDgu2H4BNgV7u2caxS+PLyoAs9QAO108Vuz5xC05Fzd/cJzJCTIgdCKXYWQug0BIr1+4Ptr+aPTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199018)(31686004)(36756003)(41300700001)(8936002)(5660300002)(2906002)(44832011)(38100700002)(86362001)(31696002)(478600001)(66946007)(66476007)(66556008)(8676002)(6666004)(6486002)(2616005)(4326008)(110136005)(316002)(186003)(6506007)(26005)(83380400001)(6512007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVQ3L0pGYWNYTnh4SVhyS0s4RTluRkJTaGdkMG5JSzVoWXFxMXdBWVFRWmY5?=
 =?utf-8?B?SGliUm9rZkhTK0ZmSGR6OHBYdERxb3NOVzJpYjNESExHUzFCZ015aStDVlZv?=
 =?utf-8?B?VldFcGIyVlNvTmZvNmVUaVpLVDNXZmVXNkZSbVM4OElxN2VNSGVrcVFTWE02?=
 =?utf-8?B?b1NLS3NFbkRnSXhHNkxqeDFYQ0lLYnFXSkdyd005ZWYxSy92clJpVjNXdWtR?=
 =?utf-8?B?TXpPYkJIMjJGK1IwMnczQVVGem9qSTZIQmtnVjlIbGxhaTQwc24zR0QxNGdw?=
 =?utf-8?B?ZllqNVR4RXN0emM0MVMzdm1aK2xIOUlEcFZDSkJKNHBsRUJOejZmZFg2dHFt?=
 =?utf-8?B?OHhxbzJYam9mVE5NZlJrUFMyblM2NXJidksyTit6dFNiNC9RMVdjZDBEWkRl?=
 =?utf-8?B?WDBLMXFiek5oK2tFdk93b0QrRk9FVnZXdGNnWVp4alpXbGRUbWwraHhpRXZK?=
 =?utf-8?B?NzREMS9sSU5URlV1a0xiTFAvZkMxMEV5bEkwNkpvMEZpemdhOCs0SEJRNEtr?=
 =?utf-8?B?NU5SRk8vcjJGbS8zRW0yT1pqUVZxQzZhOEpnQ2MwMHErMlJLenVOa1crN0hF?=
 =?utf-8?B?cUN2dnN2VElHN2ZNVkxYTGl4MGg2NU9WTEVkb0FtY2Q3U1Z3SU95WkVMRmY2?=
 =?utf-8?B?d1N3WU0waVpDTUUrR2sxY0J3STNoQUFpeWN5ZVZWRUJBSnlkV2M2QjNwUHZX?=
 =?utf-8?B?aWhNcVBGTzBUWXNHVCtYQWJHaXpseXo2UExoMWkzRll2MC9XNDAwbHlVRElB?=
 =?utf-8?B?K1ZYcjVZbkdPcVl5OWFLSnFjd0ZkTlpHV1FuZUsvK2pEeFNDYVNRQ2Y1UzZn?=
 =?utf-8?B?NU5SNFR1YjRiaFk2b0xpZEN4NUlDTFp3Wm4wVlNrVFJCcnUvZGlOeHUyMGRU?=
 =?utf-8?B?MUxKc0xQSTBuSGkrRHFpbjVzN1pBa2U0VmgyNWhpRk9OTmVVOER6L0d6WXBx?=
 =?utf-8?B?OHBxZ2dyZ2dncklsNzJmSXRnNXhSa3UrdEdVSi9FLzdjaUFBQ2VxT1l2Uktx?=
 =?utf-8?B?ZVQ0VE0yMzAreGtoRUhqNWtscG1ha2lEZm4yckpBRkUxazRLNHVtVkF0eTg0?=
 =?utf-8?B?SVdyaTErYTl6cTl2QU1sUHlyRVk3SUk1bU5pUmR4MWluR3h4Z0lUTzZONG5P?=
 =?utf-8?B?aDJYS0JHUUtpdzBsU29YMHBKbUhHZndTUjIrWVpoekMxUTNXeU5jVGd3OVpu?=
 =?utf-8?B?V2xnZzljQU0reEpFdjdONW82dndsZU92OWtJOUpHYk5FblZ6bzdIMHJSN1N4?=
 =?utf-8?B?RzFzV2JNcVlDN0lHb2Y3cndCVE5XY3lzbzd4YzlhRUlFYzFBQkgra1Zva0xU?=
 =?utf-8?B?bERlVzFpc3F5aW0xbUdHWFNDMFp2aGRSK0E2L3F4RWc5NU9nTmJxU05IMVFz?=
 =?utf-8?B?anhtY1phc1dIaTVvSHpsdnc3WHpNaXdQVjRjeVdMWGlGYkFiN2ZiQ2Y3MlBl?=
 =?utf-8?B?VzBSR2RzeENzZGE0WlVGRDVCMEp0Sk5tQXoxdHF3d2Jycmc3cnVPUmV3RVl0?=
 =?utf-8?B?Q2s4bWU4NUx4RDQ2YTRjaE01aHNTVVlEcW82L2x5cWpCY245T0licWxhYklO?=
 =?utf-8?B?eW5kY3RZdUEzS0wzZm03T3JxcUM0M3FxVDRodE8vc1VFL0wyck4vdkVGLytX?=
 =?utf-8?B?dkpFWldGcUV3VWFCSlNkcWN2d0RRTXZ2ODRTcXk4MFBEaHBFalMxWFVlcXhj?=
 =?utf-8?B?WWRucnN5YXlCRVYyZ0pBVytvWjByMUpueDFMVGFWT25nK0JPQlVhUjZvbzd0?=
 =?utf-8?B?U2dYcXh3ZU41QU5SbFdtMEluV0RSNlN4Yk9FMi9LTHROMXdKN2lrNUxjYlhW?=
 =?utf-8?B?aENmeVFOaVlucmJkMy9sU0I0YkNYTW9KNDcrY2R6L015cXZ4NDAwNXpHc2x5?=
 =?utf-8?B?L1dwNDhGbUNTRHRjQ2pNOVZZOTJ6UXdES1BVOURRWk1pOFN5S0lGSE8yWExq?=
 =?utf-8?B?WGJueFpvK0hoeDl0WFJDaWN5SXZIVCtXUzFXSFRsYjg0Sms2bGFJb3EvbHBZ?=
 =?utf-8?B?T0pPTUI0Yi90K2JOZG9sa3lmMnBZc05idnNPeHNYZlNtRU13Sk5zZGJOZWR3?=
 =?utf-8?B?YnoxVFgzWUtUY3ZVdzRpa2hMKzl0TDIxTmhkK0VLL01hbjBuMGVDYi92QXIy?=
 =?utf-8?Q?gCE9ooaeesIgP/banEgawssTA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LIF2lF5+LXyj7xGmIDsgEfd9ecNnxYK+GTB0Qvu+gTwvfxtOlUlfGIxh02TaVR/DtuMxI+onBqr3Dv+mypKVx0NJrJQApza9jtYm2tnRUXOV2ue2nePOk3MVjI6NGBRbgoHbzIDYwSEiXFMvfzgZ2IOYPnRERFYw9V67hWoNfRoFcMUe6gJOvV4Ha1F6aAEwtH0Vt7DaTAXJCezb32y2thxnuLYW6JqXobNAaWtTdZ3kWeJY/MgNBa+Yohdme5PghbfeRA0um7dpLktnzYDOAEGyGNHpbzvpvqugeH52W8Y1LmvEgH9+7eXgIYsoVnD74B44bjHgCrQaFwCdP3EOa5puETLyjsD6YKDlthbW+iGA/iHPV21toRocvE1rPDnbYfp61NJTmYsy3f5J/hc0LFOF8yWE+CrL5x/9K3hPNpVs9iXXOXV/iC6ukC7hR/GijIH0IZg5TyaZ6/jyr+MYrF6orEAT8ctEu/p7EsTzWL4jhv26wK3rAf/SEDWGn5Cejgcb4QQXMTdwz0G/THonsTa5uDyEV5MTSeQGumtQQ+QtynKTC8uKTruTT+Dzq8UaB3HtqgLBy912hacTXDb8ecDUY5289v5HcguOePme81Hb4zeLy7+CA2ebgpFWr0dFJdOohPpz9EsIXsYmHHz68Kemap3MWnrAa40xEOIoo6lYPVHxuLAvNSTV9byGGK36tyuaFTr6VcS1yFczj8hvuidNr8bwOC6w57Ew+5aKgNERSIRbP1AOfXua+DEQG+NSLnyJ60KGHklYyN+KD8TkwQ78/6lh9MEF+wpkIiDHN8gsbeAHHOkQkJbJR94Zd5smW4vhg41i8LGGEThq85SWWAmtN0A/of6Or+Zuo9eArLw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c51b88-1a7f-45b2-27a9-08db25fc831d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 08:57:46.9468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFkE+3j/VEn8dQoSYOZtIZLobhrbiw35yEA+OpqqPzyxsxM9Cd9Uqk3QDTukbbAhKnli4fpaZqQ9Da64kC8jvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4933
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_06,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303160076
X-Proofpoint-ORIG-GUID: SSTZzpdpQgeRgoIKUQ04kGxu056bt0FS
X-Proofpoint-GUID: SSTZzpdpQgeRgoIKUQ04kGxu056bt0FS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/15/23 00:51, Christoph Hellwig wrote:
> btrfs_add_compressed_bio_pages is neededlyless complicated.  Instead
> of iterating over the logic disk offset just to add pages to the bio
> use a simple offset starting at 0, which also removes most of the

> claiming.  Additionally __bio_add_pages already takes care of the
                                         ^__bio_add_page
> assert that the bio is always properly sized, and btrfs_submit_bio

WARN_ON_ONCE() will be triggered if the bio is a CLONED bio or is full
when passed to __bio_add_page().

And, in our case, we do not require the functionality of 
__bio_try_merge_page()?


> called right after asserts that the bio size is non-zero.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Other than the nitpick as above. Looks good.

Thanks, Anand

> ---
>   fs/btrfs/compression.c | 34 +++++++---------------------------
>   1 file changed, 7 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 1487c9413e6942..44c4276741ceda 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -258,37 +258,17 @@ static void end_compressed_bio_write(struct btrfs_bio *bbio)
>   
>   static void btrfs_add_compressed_bio_pages(struct compressed_bio *cb)
>   {
> -	struct btrfs_fs_info *fs_info = cb->bbio.inode->root->fs_info;
>   	struct bio *bio = &cb->bbio.bio;
> -	u64 disk_bytenr = bio->bi_iter.bi_sector << SECTOR_SHIFT;
> -	u64 cur_disk_byte = disk_bytenr;
> +	u32 offset = 0;
>   
> -	while (cur_disk_byte < disk_bytenr + cb->compressed_len) {
> -		u64 offset = cur_disk_byte - disk_bytenr;
> -		unsigned int index = offset >> PAGE_SHIFT;
> -		unsigned int real_size;
> -		unsigned int added;
> -		struct page *page = cb->compressed_pages[index];
> +	while (offset < cb->compressed_len) {
> +		u32 len = min_t(u32, cb->compressed_len - offset, PAGE_SIZE);
>   
> -		/*
> -		 * We have various limit on the real read size:
> -		 * - page boundary
> -		 * - compressed length boundary
> -		 */
> -		real_size = min_t(u64, U32_MAX, PAGE_SIZE - offset_in_page(offset));
> -		real_size = min_t(u64, real_size, cb->compressed_len - offset);
> -		ASSERT(IS_ALIGNED(real_size, fs_info->sectorsize));
> -
> -		added = bio_add_page(bio, page, real_size, offset_in_page(offset));
> -		/*
> -		 * Maximum compressed extent is smaller than bio size limit,
> -		 * thus bio_add_page() should always success.
> -		 */
> -		ASSERT(added == real_size);
> -		cur_disk_byte += added;
> +		/* Maximum compressed extent is smaller than bio size limit. */
> +		__bio_add_page(bio, cb->compressed_pages[offset >> PAGE_SHIFT],
> +			       len, 0);
> +		offset += len;
>   	}
> -
> -	ASSERT(bio->bi_iter.bi_size);
>   }
>   
>   /*

