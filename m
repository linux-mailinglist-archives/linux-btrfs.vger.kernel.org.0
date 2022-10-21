Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACAA606FDE
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 08:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiJUGMF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Oct 2022 02:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiJUGME (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Oct 2022 02:12:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8EE109D64
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 23:12:03 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L5OiDY004661;
        Fri, 21 Oct 2022 06:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=aoyCOWZOdKkQGLKzM+YRwfMb0CgKnG9u9fx5vfsjF5Q=;
 b=onNni5u5q8xlqbF0yMRmIct5P4PvN4xF7tEZF6uxe5XXWuC1i1d+q/tmhEld/ZSK5vy7
 tJA2vy3OIkDwmy/O/hvft1qO/QCCC2NztgkvyT7JdQqCK3b0c6VLrM3IyOmIv+QLiP8X
 K+8c7Dx+qLmjt09cxsaMvi2k/ZtpR6S6A/qIcFGLYrAs7kjtxvfpjyRCYDeR7RsBzjMo
 su9590LTjfg1x6BDAOFqzPqOUKMxMMvFucc/N39fxwFw8B3zcX7+WKyASqcJreQUH4y2
 5eLd6e8ciH+NbltRCO2EO4ouZgdSTqzwgTMKS0kNCm4gg8p5aAfbSVl9c9NFVwFsMJZm Ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99ntkgg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 06:11:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29L4G5rT014743;
        Fri, 21 Oct 2022 06:11:58 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu9f944-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 06:11:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGTzStnqBaRwbI2mPGsMp3amSQ23MBOzLCSt25HfUuCfMbh0DsETTrj0ZTvxnNQSk5YlXTVrjHS2JtyCia4+33/RvMZwXtSEF0gjKbIL0Z5jZwUtMtebup5eMhKYTqGgTXyEk6aK7lpZQTya/MP3RXwZUdOsSWQ3S7hoovNQDhcmAv+Otb5NgJO+Q80tNaqd9v7IURknaFHBVWB3YkCJZ/aiERiUP6wZXdyry/viVUq1t32cNavq0rVmIS8X+myZIsluiFFw5Ml3aA9ZwS68dPbw+MHRqp5S9xAhO61RzsPA5iX5sDW4+nWH2ckdfe1K5z5Ci1eyZAlgzj9SAErRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoyCOWZOdKkQGLKzM+YRwfMb0CgKnG9u9fx5vfsjF5Q=;
 b=BHXhV42voN8zIszratn91KY/XG14UGGtYhQCIddwg+U4hJr+ljVmj23ujwlUV8FheSb7prY0odpebXB3Eu/qlywlFR9s0ceTXqJ1XSZZC9xK1AoGvGWjnHJcEhzdZ4nI/l/xv/rFbxxMyNdA8fRO8BouVkhq1Q6WFVDLU9hBWnrvJUzkSzoTq7e/kJYAG1OSnqTzV5cMLyI83mu6SV2UXJ09hkp9BhcAlXSW07Y2P1K5T5kXopDFo0cSXYdzPWhQud0xsd1xIFYvocb7VW/J4nBw9R+OEnFsdLAjqL2bzk8ElWSx0Xo8JH2vZXunTHaVGzhzMwJIBoOpSbgFmC43Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoyCOWZOdKkQGLKzM+YRwfMb0CgKnG9u9fx5vfsjF5Q=;
 b=S2A1RabwSQWj7NSQk/bZ5tO5tF2vEqDKCcBl9vXwJRLDKdrlVrtMCUeT7rlISnqMSsUcs2RBfEXfQFsKLj+v866lzmG8W6yWNryEz1cW4wUY+KNUT6SzeUQUvtmY5+pL8mB4yHChPk+YjKRv9WegLOS1BxL4bLfOlA/wLp8W2SM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6009.namprd10.prod.outlook.com (2603:10b6:930:2a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 06:11:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 06:11:56 +0000
Message-ID: <6136d6f6-5416-b2e5-a46f-5e8cf1df7a43@oracle.com>
Date:   Fri, 21 Oct 2022 14:11:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 01/15] btrfs: move fs wide helpers out of ctree.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1666190849.git.josef@toxicpanda.com>
 <c733b7eb1cb68c7c8b6f08c4454d39bf7bb974de.1666190849.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c733b7eb1cb68c7c8b6f08c4454d39bf7bb974de.1666190849.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2cf3cb-d3e2-490c-8ad1-08dab32b27a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUXMoW2lCPJprsGR4V4LXYaD8EaCcTKXuOU9ZMyS+Ennt+qWDRD1TtrSy4+GSuIEaUX7eO30j54HQID5tnJOtsPA02N+ok0h68T2cSNGO0qzwhp6T/HCez/PZAzDrjjyqygsfYsAH4clhPpFmF78prp+BXrPeJLd0byeXhvw/vNgaBRbNVsGL3NFK0O3OgWut+XJkpYii3Knj9pPGTf5a6yHvy8Un7T9t5RAYdsWBkw7FeQK1XdVHNHr/angb7d7SW7iTvoNwpoCSO+9igKC2qqogDjpf0Qqz9udrVPznKlIHBxsHeb6Z/EaFXkT4eXNelv5KDHcCmXfdGzJo7USgQ5978O1cUPXvWVVypuux5P7CUpNvt6x2IH1kfpWHGH8JgcTFR9NG8fC/srMv+lNZVsOObPKl6TWAKN2eT2StD42AmbDy0bKcK1qu0YgzXMCrVpUFIMfKFPaS6UgnV7KHo95ZwoI+CzTN7oTtkuzP2ftiRaDnKMHqozrbbfBQFi065lvuKVjSMAA5EYn/62Gg4urXNF8iE25b6qg3AQXJWXYQDz8Bw0rOZidEKvCl40EAnFHGevzAhGwmqGhnyKDL5C/M1IQA6uNJMEr56kxwUg5HiYxBb8zcUGTMFkRDGKHEhCAtkGMG4BvdB3WdieqHkEZAZuJqUhL8eWFAP21G4Bton0hHiLYy7paMoHQ/eUX8O3hBjCU8uIOcgXQoV5rgHOgdW548ain8WIai0G5W4pV5BXgeXnN+8N5vgm1+WWguznuhOwCqdNSQfEl1SGrD1H8MPrD5YDFdDy/LnCROSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199015)(316002)(86362001)(186003)(2906002)(36756003)(31696002)(38100700002)(31686004)(4744005)(6486002)(478600001)(6506007)(6666004)(41300700001)(53546011)(2616005)(44832011)(5660300002)(8936002)(6512007)(26005)(66556008)(66476007)(8676002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qnh3T0lzdzh0Z20wUFZ5S0gwaWt0Q2hjNlVkYkJ4ajVGSURvUy9HcGlYZmRL?=
 =?utf-8?B?cFByOGg1bDhuQitFMXZvSjR4ZGhGKzdTcklsOFhKajdtdWw5dEVSSm42dTdV?=
 =?utf-8?B?blFIbVJQZUJEaXNOL3UwemRnVWc4OEVXQzZzYjlEVWNndCtaNzJKUWtpVGsr?=
 =?utf-8?B?eUxZVHB2ZlUwWVV4ZFU0NUVpeFcvaE5xWGxCQ01hZTVXS3Z5bGZrVnAyTXo5?=
 =?utf-8?B?N2VEU01OV2FSYncwREtlRHlGb2J6YStQZDBFUmNZci82TlhnLzlZald6YlFy?=
 =?utf-8?B?alhiSHc5aGQ3WCtSN1J4dHR4SkRsTHRuNytJYkhiblNvbWgrU3ZuaHN3Q3Fo?=
 =?utf-8?B?Z3llSWNGSGdhTG5YOXB1ZnZuZWYyaHZsckZ5VDlIOHNkN0tvMjNPS2Y1Tm1B?=
 =?utf-8?B?ODNjU0JrWXpmNVBtMDZPRGJDOW4reExKZDM5MlJBSWdjZTQ3SlFoZWhramlr?=
 =?utf-8?B?WkRaYmh5TDhIM2NFc095L0dOSFg2cHQ3ZExBZHpDMWx4WXFtZW1DaTF1S1NE?=
 =?utf-8?B?ZW9LRlRuaHFIUFdIUk8yaE5rZXhYUGROb08zbllGbm5oMkVYTXYzRVdZOS9n?=
 =?utf-8?B?MlkvcmUzZm9ORDRyczZJLzJ4ZjMydVVKOStXeVFtR2lJUTZoWnNNTmREMVp6?=
 =?utf-8?B?OUpseUJNM3pqbm1nbE4wUjRrQzJkcndhR1k3dldMNzhRQ3RWeStSRXAyYzNu?=
 =?utf-8?B?ek9rUjBMY2VhbmE0NllOcEN0TnFlK1pQODlTdjV3SEdvcFBDMG40Z2NwbGZ0?=
 =?utf-8?B?aVppTXZRdi9UZ09tM2o5eTJtYy82c2lMeDRId0pHUWgyd0NJKzhvSW5IT1RL?=
 =?utf-8?B?SHNjNXZMeTRBbDdZRGxKYmg1L3h3UDE2WHZTYXJTNnBUZFFSNitLeGFGTlJX?=
 =?utf-8?B?eEJ5cWpMVFFoQmE2a1FuUWdSUjBHOUhRUzcvaEVHMWQwMitPTGRGRWNOV294?=
 =?utf-8?B?L2pWUGlnNmhEajZWMlBPQURjWWZnRU80K0pobmptZHhleDNrYzFEdzFzbTN2?=
 =?utf-8?B?N1NFU1Bsd0ZjU3RzTXRSR3ZmbnArbzJIb0lkbURyR1hDM0NNNUNGQkZtMnhn?=
 =?utf-8?B?bGZna1BIelRNb3FLSUlUeHdMMDZNSytWNDhxcjh4aVZuYmw4dXR5Q3psa0tC?=
 =?utf-8?B?eXl6eXljckZ1MXd4U0VPbmVleGNzeVFiRFViZHhvSGNUNURlWlZIWkp6Zjdr?=
 =?utf-8?B?aDN6VndoTXd0eFk3MlNBSmthY0RzSmd1VmJVbE1KbUlpSWRkNzN6Q0FMOW54?=
 =?utf-8?B?YzBwMXRsMW10UDRycUFkREN1cU94WlhQcW1Fb3k4cWFkMnBWMXpXMG1XVmVL?=
 =?utf-8?B?Y0Z3MTBBR005YmU4dVo1RElGelBnSFc3NHRvQ0hTQ2xwSFNFdmtMeTh2VTlo?=
 =?utf-8?B?ZS83VDgrVnBaNWpBREJkc2xqakxZSUQraXo4L2V5RFFHT0JWM0cvbyt2S3dZ?=
 =?utf-8?B?S01KTzV1RGtlaFl6V3o1TTZSeHJ0RGs2VGp2OGhjVHdNTjc0RkdmTHBpd3Fs?=
 =?utf-8?B?cTRPZVBnY05EZkFPeU9tRFpNZUJRK2s3c2FNU0RTSUVMYlR0MWhKSkZOUDVC?=
 =?utf-8?B?L0h1VmZaY2M2YmRXSEZHOE84K2JlL284UHpzZExScG50YTdKKzNNTDZhcXdZ?=
 =?utf-8?B?dTVyRmdaclVMRjdSQ0lJcmt0cVRrK0xrckJXM0U3dHBqWE0wVDdta3Qwcy9P?=
 =?utf-8?B?bzVRVEFKZlp4eVZnSE1IV05EeGZYSzhzM1FsUUpEZ3F3QUdPY0hoWEMrQWJJ?=
 =?utf-8?B?dWVTV3ZnYitTaERiK3VXSTZRK0srZWRpZDZ6ZXE5bkwvQldUQndDUjRVQzNT?=
 =?utf-8?B?ZnhULzRNb1cxVXAzMVBiN3UxS2Y4N25CTVllRzlzaWtTQ0t0OFF4c21iK2pB?=
 =?utf-8?B?UXpRTkxCbEZRdHR1aE1QR3hHekhmY3h3SktRejIrN0l2blJZZytsYTJNK054?=
 =?utf-8?B?M0M4R1l2V1B3aFhMM0NlREpwQ29RSmxJYkZDTjRBd050N2RVaFhuLzBGWjlF?=
 =?utf-8?B?anhnTTFCTXMzVTlTN2MwSDhHNFZPS3JtaW9KMnpxVk1JcEJKUDdSZ0ovMEVm?=
 =?utf-8?B?Y3lXbDN5VHlvQXRwN2J3U1BrRzB1bm9XMXJDSWc1RXFOT1RQdHRjSzR6R1FZ?=
 =?utf-8?Q?ypWrQ3am1Wnu2r8s139EmLnIm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2cf3cb-d3e2-490c-8ad1-08dab32b27a4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 06:11:56.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xe9S0DjfbqJCxVxOCxeSiTRv5BVBQsLD7HQgfrdTAMuVtC6LruUjkvRUE7fQRJxfiNgQB1cMg6VknBEHzu4e6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_01,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210036
X-Proofpoint-ORIG-GUID: uoo5o1moTI7jwAuCW3_ery5bzzGg55Xa
X-Proofpoint-GUID: uoo5o1moTI7jwAuCW3_ery5bzzGg55Xa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/10/2022 22:50, Josef Bacik wrote:
> We have several fs wide related helpers in ctree.h.  The bulk of these
> are the incompat flag test helpers, but there are things such as
> btrfs_fs_closing() and the read only helpers that also aren't directly
> related to the ctree code.  Move these into a fs.h header, which will
> serve as the location for file system wide related helpers.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

