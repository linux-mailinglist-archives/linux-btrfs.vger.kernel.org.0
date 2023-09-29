Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA5D7B2DC0
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 10:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjI2IYR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Sep 2023 04:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjI2IYQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Sep 2023 04:24:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0B71A5;
        Fri, 29 Sep 2023 01:24:14 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9acH023062;
        Fri, 29 Sep 2023 08:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=obuGmygH+x/W1+MvSZaRTC2/5+LxFoV/A79xdxKbWPw=;
 b=lxYYcCScjhpbld4ZI7L3h/5LI0Md9mweA7zmFYkRZGLNAyhlXSXxPcaNCJ5pzBDtGcJK
 2KJC/cjWpeFM1O4xVuwccQ4AWV5PBPn3843Ogmp0gN+pANohuL9c/wFuPMq810B9iRs9
 nEKlQRl76dGPNO3Qnjvn7z15sV84FG5w+Kq0FIlMa22L0AA8zAo0W8OWKY2nTB2YyeHG
 z/9Yes+/s5KGCruAHy3crrMIu3RGot8/oBOwLORk0Jfw5x3o87Wv2pZt3V5onzplgv5J
 jrgUaNhjM7dnrtgDW7iVGMesaWehLxCq5aKipNZ96i1KYjM/0eIhItLZLjFpVJV8Ucdc VA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxc6d6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 08:24:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T7Q9cQ015796;
        Fri, 29 Sep 2023 08:24:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfh07rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 08:24:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdezIdFyxjtEa5sb7v4D/4DgTILa62RQwYBUgv8rKc4ED0nU1ocN0E6MqN9YGXi9qJKdHDVAWZtFokgtRGiMTiOEMR5zd47eW9y+YtzTZPV39QYxJNBMk+1MxGrmOBJykEu0LpAvgEQCzjBIF9i1fAKzyPUucM4XLG26A4/yJYKtQimmS8RwVxKpdPEW/E7KoAbywVqPd4ZFIHpT/IGNULFqYUQ6FHmMcgiTpnCgxDfOaYKrf2HxrL1fh5yPDqaLr1Kpehutq+N7mPRQp2uWc49JsUO6M47CAAu/PDGk4iKEMzu27sI0/uXWbr6P7JOl1dawzL6bm+twp3B25mkMmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obuGmygH+x/W1+MvSZaRTC2/5+LxFoV/A79xdxKbWPw=;
 b=klLDrcfA+Oh5ITDXg7tfbTvAwNst0aLfSOvk0o4kS3rDwFBNTp/cZPjTtRmbRPmRwga6GfWNOqXsd5XPzzFGRNhlyd2W0lNjwfzwqMNQMy9GcW9IZGgy8lSW7ME3aNxXs3ce1ft+HxXnlSGZ2RR/zXDB/7BsRB/GBDyqNtABKeTfl49hxjxCmnzXGaIezvXOaAdim6qIe6dCMhHurLWDBVXHPoRXYdzTeI77EaKg9hWeHggZh4U4DmpZ+BXMII95dcWncgb7TViyn/T2od539cv5Uch/FIYB5yCwdDTiWsycRbe9AZl4fY/HTmz5n1vPFkYnyMA8jft/IQlDT2l1dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obuGmygH+x/W1+MvSZaRTC2/5+LxFoV/A79xdxKbWPw=;
 b=Z2MEQErqVlVwO/xiZ7SiDuBmLfGL1KtVhD7TteqlE2mZmqnFa4owrDGWSHcUpMw4Kq+5BFxwtzKslUs922mstlZ58viRl004dg8C6Q5F8XsbRPTxoS8UexsENw/gKq+J8oHHkt4yHH4geauQCh3XF1XtEryylq+jZNQuBLl7V+Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB6834.namprd10.prod.outlook.com (2603:10b6:610:14a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 29 Sep
 2023 08:24:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 08:24:04 +0000
Message-ID: <146c1ed5-d914-cd9e-8164-165eb1a9f23c@oracle.com>
Date:   Fri, 29 Sep 2023 16:23:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 1/6] common: refactor sysfs_attr functions
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <cover.1695942727.git.boris@bur.io>
 <0714f6b21000181ab43d3085903859b8ae1e1a32.1695942727.git.boris@bur.io>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <0714f6b21000181ab43d3085903859b8ae1e1a32.1695942727.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: a68f72e1-1752-4b23-ab24-08dbc0c570e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTe8jEHWh9K1imwh/kLhq/jKh3GbBXzQmJQwi3DYNFpMwMqQwCPjnqG676T4CYgwMu7vTYQq91YpDXrQSWuLk+netgnhv6t/MhJog/s0ymS/SonUjcZstn7clZKZJhqAZcngFlYZX2v6zKe26LWv3t5DgMaZeBN6dgJ875Qm9DPR9XkcsBr0CTZz4bhp0EE5U8pghM7Vjv0Wc+8X9WtDMVBmNDEOF1VUqdpp+C80/Jmg706JCRBVdgqFQGffZN740rTKusdLlu6dqyxhAO7m78G33O6ZlR4eSeVOZDmdxrLFBfiFdDFMMwAHkqEcnDAHkNdd4THaq79or/80/9SeX0W8zjtS9IyCY7PnGA+n9+jtupdEl7gvua35/kKv2+wLYwpXg11rqZTNsp5LJkuHhw41bsXEcByXJg35GuhGuEz2KPLa9UdacyhpE86agBfu4ixNemkp8xDGAj9yN16BEeAqKzHHKGXQ1hoOtgcUih58OLXpoBguDNiwMWPwIQGb3Wq9SEO3jWoMed7mtsIEF0dFsXcy0ZoaxFGGtDwcbWtSlKEPa03ZaCA0MrY9bOIIFAAHvu8NpQBDP3Ko3CLk3NVWLnp387HqHEBuDrfiRosJ5LkdXMrl7u+DKtwFjnVHF/P00cEyOm3KQnd7hfMJfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6512007)(6486002)(6666004)(6506007)(31696002)(53546011)(86362001)(38100700002)(83380400001)(2616005)(36756003)(41300700001)(66556008)(316002)(26005)(44832011)(66946007)(2906002)(66476007)(5660300002)(31686004)(8936002)(478600001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFR0NVYyUmNaNk9jMWFWZG9aWnoxSFNyR3Y5NmcySzdmNVNUR2VSNzFmOWpF?=
 =?utf-8?B?UWdRZzVaZnZxYURISFdCdUlwVW9saUFtOFRtMjlqTmpHMFN4cmFTYXRCaS9y?=
 =?utf-8?B?NlVFTGgwMXlmWlJUZCtDNnBLYVpWRDY2K0oyZTQxRnpnUDhUOWtLMStZNGVz?=
 =?utf-8?B?THNEYUo4cUI2R1NXbjB5MlVack9LdDRjV3hteGZ4d1o5bE9jMFVkc0xxVG9U?=
 =?utf-8?B?bXR1MmtrVER2K2VvWTF0K1h6LzA5WjJyMml0ZjNNaDQyWVJxditMejFBYTZ5?=
 =?utf-8?B?dFJTQUFPbG9DZVhuZ3VZeFMzdlpFajVwQ3dUaEFmbVNJc3FCWjN4UkFYc211?=
 =?utf-8?B?dzJFTEExRDVXNDVQV2FNajI3c21SNyt0c1JLdHdZZGd2cm42eHFGeWVud1hI?=
 =?utf-8?B?YjQ4anMwSUdiTkJPR3BoSWZRbWIydXhZWlVTTDBuS2JMQUhFSEdibHZSbVJl?=
 =?utf-8?B?TlI3TTRiQ09JNUtMZXFmWUc4bnBVUnBwbkJQVkFCZitSRk85L01RSERJTzlN?=
 =?utf-8?B?T1FqTEtXTjVIRllFNjlQOEdmU1RkU2F1VHRVbzBEQTFvSlRWNU9taVdkKyta?=
 =?utf-8?B?VDArY0RQRVVNaEFGd0NjanpsMG9seDd1ZlBmT0RYeDhkSksyQlJFRCthVyti?=
 =?utf-8?B?cVhDTnlMSWgwZEw5djNxazZQd2NnWllrWUNSbnBWRHRvRWhmRHpuV0QzMlV5?=
 =?utf-8?B?SXBuNmpabEpYRnpNa3dZM2h0YTdUczlTU094SGZqZTVaZzhaRDg5MWhPSXlY?=
 =?utf-8?B?RkRQKzRvZ0pIbXNwcXZEODhLeUNRQTZveDdRb1Z3d3FCNWp1QjEzMjNERlQ5?=
 =?utf-8?B?Z25xMXROVDdqT1E0WTlweWNGVHpjR0RNSURrY1NVMGVkZ3p6d0haUW5MbmpC?=
 =?utf-8?B?RXNjdFltYlgrQ2FPVkMyN0dxVXROM1RaRGZIOVkveWNpM3liUXp6clo2Ty9v?=
 =?utf-8?B?ZlJURkdCckFSOFpaTnZSaHhEMjA4WHgrRDRHY0dEalFQV2tkbXRRTWJvbHBU?=
 =?utf-8?B?WnlvRkJGbjFUbElhc2lmZmo2NTdXWTV2cHlueGdtdS9maGxhckZvbnZYdDRy?=
 =?utf-8?B?cTBsckF1N2NJVTZrVFY1dUUxSk1mM3VrbXJNSkpYbmFHL1FjeG9QMmZ5QStp?=
 =?utf-8?B?eTZJMFJ1UzR4YmdYQ1doZHpGTVBFazE3Q2ZOU0NHQ2Fxdk5JelRQSnZubVBQ?=
 =?utf-8?B?WERLaE10T3J5NW5ZZS9tNlZmbGM2NW5QRnM0anB1eThCNE5pcGZqdFhnRU93?=
 =?utf-8?B?MjRoTmk5MmdGdVU4UmZWYTZIbW9WbFBQK25zWDNkSjgxc3pabnlXRDRlOVBY?=
 =?utf-8?B?OVBrbmxKRnhodVpVMXR1MVE4dm1VWHhkQTIzbXpnRURPN3pXekdqQlNKejZX?=
 =?utf-8?B?TnVtYk14a2hoTWczbFVnUTJmMEc4RzJkWjZWYnZVRmZiRWZXZGE5TlJoWWky?=
 =?utf-8?B?SWUzQWpMQVZZOHV2MHhvSGd5UEtiSUFnbzI5My95elpIeXB2VlhRd2hoWlZo?=
 =?utf-8?B?cWYrREd4TzB2dmozaVVYaGU5UFlodENyNmZFcmZ3aWR5UTVPOGE1ZlNoR1hM?=
 =?utf-8?B?QmJManpSM0NwMmF2eEw5TXZQT3lTdlhzRkZoOWVOcEFkeWxuUnRoa015L05D?=
 =?utf-8?B?dzVNSGJVN21Ra3NWbmI0SHV2emN2TE5ySndGTGNSR0Z4aFhPNDYxOS9hSXNZ?=
 =?utf-8?B?eUNRTFVpRUJCbEJjVFJzSndkN0VxMVcxZjE5aE41ZlNqNGdQeVJZUXVCc2JV?=
 =?utf-8?B?MEV5Q0NqK05ZWjg5WU8zbWFUUmxLQ0M4T2NIUHhRQjVId0JjZElScE1yb3J1?=
 =?utf-8?B?c0wrNjVPTnRON2hDcnNndXd3dEE2VFVabS9lU0REcXQ0bkZmY3ZnMUNCVk1j?=
 =?utf-8?B?WFV5QkJ5ZnhEeHRrdGJyVXY1NWdHT1lnbWlwNTN6am9aenNja09zc1RieGpk?=
 =?utf-8?B?Z1pSSEFGZW9nSHA5Tm1lckczcWw4czB1Tm8xelY2RkQ5L0k2dEtRWlNnc0hU?=
 =?utf-8?B?Ym9LcVk0V1RwUHN6VzJsY0N6L0Jqd0hLOU1iem03MGZ6OUllanVHMFh6WmVJ?=
 =?utf-8?B?MmV4YWUwd0lSTGJ1RXIvRE84OU9vU1JzMmpzVHowNXduRUc3ZDVrRTQvaDJZ?=
 =?utf-8?Q?xEY9CJF3mVleOhNXdrcEirrji?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 75K8aukwgoTK4QO2HuFU3Vkdl0LJs1BukZM2AXs8LwVuZHr1iXzJcBZsHfPucBTF9SKtu2LioQbSe8caqium3T917h+UxMlm872xgStM/0002UorkKx12XcQzoIo1wIPsG7Tq8RANRZDaitzwrcOCMHC5UOX0JqwcOt3jOVUB6DsS88FOlfUrygGEWCQZj9rgxxJIqxKen/ZwPKzw++eaaLjEq8fTrtWPvCMekvE7Va1WFOZTLbR6vxQQxszDBuUfziXgwBnYxowHe6zpEgQJoHvnpeYiTqnG1BFS+KJF0Ie/LYUQnCL9ppEOl8uTvfXA7SEyjoEiwAZ9t7Y9qs3xUFfUSxDk7Tw1xL3nDeHMp0zpRYY6fl/oJBIjizrBw2VA1kj7jSfIgLxKbCMSABASLtXX+hCEpwEnMg7LGeTR4gysFFl7Vel6oq+GYD277mNr8s86flqk+NVEceaFZA8GL7Bc7k6Z6Ia4mVZUKqLGSifiUEWxAG6SSi7CH2QgDtZjb/SgUk3XVKO8QknnPn48GNWGP/h3FiGeJgR5L3iv0Kz0x1v6dqH1l0/tno7/Wqa10naW4HtPTfoky+ij7AKCl9v0d9Ug7TY8GvPTncBIZ5YqaG2LijF6GtU1hmSR57bJNKwhfeg4vTS40C8EHKmkJgfIgDCyhFxZFHe8p6+iAPAkCBWsxT3Rvk6yyPQqZR/o3SmMIpOQZRsWcNPjq94OmgxP7bLVMRXk6u8xgOeW8v1HW/Co11SJDTh0R5JdgMh9aZwv0mvYpuLuPrleOyzwSSqYEwAKSI+59QZPGGhnZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68f72e1-1752-4b23-ab24-08dbc0c570e1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 08:24:04.4322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFhyFHH9J0DGPPmOjf35J6KrCs2dFKgezFHwDr4qK5qWwl2jaKVxJn9StB+h3fQFmNxeRkIFmjUZL76pO2J8KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6834
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_06,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290071
X-Proofpoint-GUID: D44xAm5OPGlUhC5gKcaAZ-a32hHkoBSX
X-Proofpoint-ORIG-GUID: D44xAm5OPGlUhC5gKcaAZ-a32hHkoBSX
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/09/2023 07:16, Boris Burkov wrote:
> Expand the has/get/require functions to allow passing a dev by
> parameter, and implement the test_dev specific one in terms of the new
> generic one.
> 


> Signed-off-by: Boris Burkov <boris@bur.io>

looks good. The diff is confusing.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

a small nit below.

>   
> +# Test for the existence of a sysfs entry at /sys/fs/$FSTYP/$DEV/$ATTR
> +#
> +# All arguments are necessary, and in this order:
> +#  - dev: device name, e.g. $SCRATCH_DEV
> +#  - attr: path name under /sys/fs/$FSTYP/$dev
> +#
> +# Usage example:
> +#   _has_fs_sysfs_attr /dev/mapper/scratch-dev error/fail_at_unmount
> +_has_fs_sysfs_attr()
> +{
> +	local dev=$1
> +	local attr=$2
> +
> +	if [ ! -b "$dev" -o -z "$attr" ];then
> +		_fail "Usage: _get_fs_sysfs_attr <mounted_device> <attr>"
                               ^^^
				_has_fs_sysfs_attr

No need to resend.

Thanks, Anand


> +	fi
> +
> +	local dname=$(_fs_sysfs_dname $dev)
> +
> +	test -e /sys/fs/${FSTYP}/${dname}/${attr}
> +}
> +
> +# Require the existence of a sysfs entry at /sys/fs/$FSTYP/$DEV/$ATTR
> +# All arguments are necessary, and in this order:
> +#  - dev: device name, e.g. $SCRATCH_DEV
> +#  - attr: path name under /sys/fs/$FSTYP/$dev
> +#
> +# Usage example:
> +#   _require_fs_sysfs_attr /dev/mapper/scratch-dev error/fail_at_unmount
> +_require_fs_sysfs_attr()
> +{
> +	_has_fs_sysfs_attr "$@" && return
> +
> +	local dev=$1
> +	local attr=$2
> +	local dname=$(_fs_sysfs_dname $dev)
> +
> +	_notrun "This test requires /sys/fs/${FSTYP}/${dname}/${attr}"
> +}
> +
> +# Test for the existence of a sysfs entry at /sys/fs/$FSTYP/DEV/$ATTR
> +#
> +# Only one argument is needed:
> +#  - attr: path name under /sys/fs/$FSTYP/DEV
> +#
> +# Usage example:
> +#   _has_fs_sysfs error/fail_at_unmount
> +_has_fs_sysfs()
> +{
> +	_has_fs_sysfs_attr $TEST_DEV "$@"
> +}
> +
> +# Require the existence of a sysfs entry at /sys/fs/$FSTYP/DEV/$ATTR
> +_require_fs_sysfs()
> +{
> +	_has_fs_sysfs "$@" && return
> +
> +	local attr=$1
> +	local dname=$(_short_dev $TEST_DEV)
> +
> +	_notrun "This test requires /sys/fs/${FSTYP}/${dname}/${attr}"
> +}
> +
>   # Generic test for specific filesystem feature.
>   # Currently only implemented to test overlayfs features.
>   _require_scratch_feature()

