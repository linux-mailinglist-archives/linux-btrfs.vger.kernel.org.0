Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711425AC917
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 05:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiIED1P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Sep 2022 23:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiIED1O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 4 Sep 2022 23:27:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973622CDD5;
        Sun,  4 Sep 2022 20:27:13 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 285366W4028178;
        Mon, 5 Sep 2022 03:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Qcf1rxq3T4kloGHx7Pbu7vhiSqUl2hTFxLOS2My9TVI=;
 b=ndI2aFPEbcbwOMUX85x20rTpEtS+1oTeXTE1TrIefxC3eF07hqll9FtpxeigWiLmAuFe
 ECXaTRhu6dMn769pUXu3uMrUoXR0v1VyH3ETO82pDrhdWdww7p4aE/U9o2hrJ2R3pa+L
 V7sOcUDO5xrCk6VScuCXYA+FexcrmpydvSVGzcCNpx068n9qcXYh3vzTwLxomAXsy/9w
 9+WnbQmCc34lW8WxKKYKXZ1e92x0+d1SwQslIfLvgkJnpRFMRIqRfChLw4/CAeFu2yCG
 wpQfDC1sEpSr3ytVPWTW67yxypqeVPwNlZ7sKQb9SZTYhcxqf0aWVpe/BVgxAaMlM0EE 2A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1adpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Sep 2022 03:27:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2851SpQ6024381;
        Mon, 5 Sep 2022 03:27:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc1ck2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Sep 2022 03:27:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIHs32VOjRBWKbhqkOCo14KA6oQtOxOov3RS68FYkCxMt6eO1bF6wOXvjPR7UkJD91QyP/ZRxMetfGl8FHR98QE8zvN1Rb8+ERkJA8MpCk2b1PQLE+1mbFxa0vjIfR+fvOQAyS+ExKVMNoB1iFFdzEKw+0wqJ1h2K+ap1nP499Az2jV0i5VHTL2zU3Jah/4oKMZcBQTm2mH5mDArxEfWxt6mgC3N4iINw3zTyI9Ay+qcFm8UnDEIPmR/u3qgmoWQ28/v62c2upczADNn5Z+ZQia7Nk+uvzX4j3TURNIYP25pFkv61IROZYMsS1Y8z9uTnXtyHvVhUOy34eL05Ur7IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qcf1rxq3T4kloGHx7Pbu7vhiSqUl2hTFxLOS2My9TVI=;
 b=N3TmQQ1Ckg9U7qROB4DkorODBvwJ66RK0fqJxfYJ+1KP1y/r3cLnM8+g51t73NuwqzvznVwampkiW7TUlYIN7J/bz5PDitRqpsJFAwPfTY/zhxT1Q6OPgJiCN9PTBbrCqHyHt0hMdIwwM390xIzE+jvjBzBiTxf2iC/bMUKnJ6gVaunPZVAL34poN1RKGcGMFxNV+2XLlQfVEAEGxnWa0FKt+pYTzocmoYn/izpWr6iI1lmAAUo9o5WpzzP2IiffqGYkiFGbEdhKgeWst+Fbs68jwtWfm5ZZgz1qGprKETAoKbumMZwGzHC1itHEJPwHV5o+VA+81jSQIlVsqKGi5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qcf1rxq3T4kloGHx7Pbu7vhiSqUl2hTFxLOS2My9TVI=;
 b=wOAPWnq5qcl+/XrLHkOqCMubVhSwIpJREetC6Flk49hBcjYMHRMY2PNPaxG8M/cwogvQb363TQkFw1HnlOKSw5kU/siu2Fy6BxIzzS2JwIHTUqi3uGzOfjPGkw+CoIADldDLsMXg9SKQkO3etIIZW+LdOPeIS/Mh2wUo8hqaSiA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6009.namprd10.prod.outlook.com (2603:10b6:930:2a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Mon, 5 Sep
 2022 03:27:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::f164:f811:6e47:b7cd]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::f164:f811:6e47:b7cd%2]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 03:27:04 +0000
Message-ID: <5d434265-327f-5607-35f1-e50469e12329@oracle.com>
Date:   Mon, 5 Sep 2022 11:26:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH linux-next] btrfs: Remove the unneeded result variable
To:     cgel.zte@gmail.com, clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhang songyi <zhang.songyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220902074810.319914-1-zhang.songyi@zte.com.cn>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220902074810.319914-1-zhang.songyi@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0242.apcprd06.prod.outlook.com
 (2603:1096:4:ac::26) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba6e2eea-fa73-4fc5-25cb-08da8eee80bc
X-MS-TrafficTypeDiagnostic: CY5PR10MB6009:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9sPKpRXgkioAHh65ouLD/WnjZNO95gdwvtdsYaDCDTxcfuZDWYBPu/CdelriwWLH0ZZpVUYDEtjLp/993FenCYdfw85lV5H7AlD/vPBjeXzaTjJxOwIGE2UMrorU1ZR7fOf1bA80SFOR6wWtmMepKkK7wxf9FPmpJ8yApsKsbW51ugHsd5hJrXxclaxUkAHFBUDsqqQYyJT+dbOskikayoPa2vYuw0q1sW2VRjQ/Z8cRqKJlCoFgf2+cug7CZMUzLoP2S7YeeFGtnwnOcu6CEqnqDB/sC6YAYBVeF94Bl6lwkD/hdMpgh5E+2ypyN6jTEOb4Pb6sRS7PIefuMmOSqPrDOqLrv8DNl77VD5GoN3rU7k94vdqHDF2dJ9URcHWC9pILC1lxQqotwKl8PmxtdBWDgwV+MTQNGawX2qeX1BzfnGkOmV6H+0GskV7sm9DL/4wttrm/zgkIYcVyKw+uSoh6NcAtsJsXQON6UFSd0CGQdvIRJQpIz8R0m+HPQpXRCPrKNKuI4jZK+4sSvyMWkshs4WwG//wFUfX2HngoLdS6a8KFIBom7uLqFQIcf6zwlT+pJhKo+GavILMU3EtrgqZ1XwMFsLq5F94Z9vWKQ9C/8cIp3IoRUR6uF20Sgo9lJ4OE0QlqhPlwknTFmVBgfY6kXNUgqiRRrZQqNfPRYCEwUH6QT2PQc+aT4EhCa1gFtDa8Sqa8yUkeJvhxGOFYkJ1SdJQjxvpB9GWJcFNRMyvjf8zehKFMVzLxq9BIWUH7s+DyBg6D9ICiQPudVeZA/eemWUlFej4/Tc6xA5N9ko=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(346002)(376002)(396003)(316002)(54906003)(4744005)(36756003)(44832011)(5660300002)(2906002)(8936002)(31686004)(66476007)(66556008)(66946007)(8676002)(4326008)(2616005)(478600001)(41300700001)(6506007)(31696002)(186003)(26005)(53546011)(6512007)(6666004)(6486002)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDg4cStnNGRVOGdKYTgwcUhZVnRZeEdWeFBlZ2RSTldzME9nOENhTFlRTVI4?=
 =?utf-8?B?dlE3L2F2ZG5JNFJ0WmlTR2krY2lNS3d6T2FyWDNieVFLRWZPOWpiUlFsVXRR?=
 =?utf-8?B?VEVHM3BaSllRNzdVcXRNdnozVkppSVZBVVVUNFRZdTg5L0VtT1VNM1dESkpO?=
 =?utf-8?B?d3ZFQ2lyRDhjZmFyN2tPOGRMTjJjZjYxUU1vR0JKaU9vWG5tSldOdzFhd3lL?=
 =?utf-8?B?R25CMUJxc1JCMXlCSUt1Zk9LMUhVMzdMMXhMYXpRRUJZaTBDTTNkcUdtTzFJ?=
 =?utf-8?B?QUlPR0M2dEVGc04yMEkyR281UHowTVlBN3NybTFkQkcyVGZRMFNMVloyWmpr?=
 =?utf-8?B?bk1YcjZLdkQydytLNTA0TlN5Z2NkUTA4Z083N2FhSTgyclV0d2dFRTVzRlNQ?=
 =?utf-8?B?czhJNmc5NkliQzZXTHZaaFIwNEhoenQxK3BoWmZNdEVVM1h2aGdyNXNYckVD?=
 =?utf-8?B?SW9NNnhRMU8xbU9pdUZDL0VCOTZMd3pPL2Vya3ZsVHBCZHpMRnUzeGhYT0NV?=
 =?utf-8?B?R096TUdBRUp3Z1BzazN5aVV4STBLdmk1RmxocWtMcmZNbzBRS3AwMkg2Y3A3?=
 =?utf-8?B?ZlVpaUQrWWp3K2xuVmNyTDJXbUM3TUs5VGNtUWpyN295Z2FaTFhSWkc1T043?=
 =?utf-8?B?YUhBdWJIQktlUjlXTFV3eU0wcGtDZUdPcGJPTkZNbVcwekRiL2lsLyttVllZ?=
 =?utf-8?B?bjdGY3ZWbkM4REFQeGorWEZOaE4wbEVpU2hYYm8rVVVMSW5KS1pHR0xaZ1hh?=
 =?utf-8?B?RzRSTUtjVzRtMHgveTRzNlAzWjg4MG8reStZRk5wblp0eVdEYnhRQnFobENZ?=
 =?utf-8?B?RmxTVFBSb2hHWHRkNVZoSkNlS3J1Zkd6UzRIZDhjS0tReStJRTR0WUdDOExw?=
 =?utf-8?B?SFpETE5DVG4wU1lNMFRQa08vdXowOUYyaEUwM095OHl6NHVBcEkydmNpU09F?=
 =?utf-8?B?QkhhR1B6SmJuM0R5ZmhyQWh6NXRkVUg5UytwRk11UnArWjZNdTN5VE1scllv?=
 =?utf-8?B?aE01TWd5eUdUam5mN3g5SWVKcnRhRS8vMDJ5VGFWMkFkVjM2OGF6YXlwV1V4?=
 =?utf-8?B?YmMvVWFlSkhJK2hWbGFBWUQvNzJ1bnNMNXdMS2RYTEwyS1pCR3FybjBxcFdS?=
 =?utf-8?B?Qy9jUkptd2VtTXQzTjEvYWI3cFJETVBMZm9JNUFqMGRWL3pBd2ZkMEQ3R0cx?=
 =?utf-8?B?UG45QzF5d2tucW45MHdrL0RhU2l0Q0F4RDlFUVJHS0N4bExyUklkN2pRQVl2?=
 =?utf-8?B?R3h0dVBFdWptcExLZ3FQaStXNnVnODhaUk0yN0l1SUlTU2dNeE5VQlBzRUJB?=
 =?utf-8?B?eHBwM0F0NDRtK3J2dVoyVFRQYUlJbkt4WGR5SXpIUVlvckM4S1M3MUFRZnBB?=
 =?utf-8?B?SFNseGJmc3lvV24wQWFkNEhkM2FEL0tueW1OcVV4WTNDWlltMnpHZExXTnF4?=
 =?utf-8?B?SXpSUEVWNWFXN1kvMDVLRnlpSnA5MFpwdVFlOEFjNGZKTENRZlVPd21FYUZM?=
 =?utf-8?B?OG9UVmp6RkJKVnlkSXlJSXFwSWNVMTBIU2xlNVpNM0kySzRhUnlSR1ROSTJ6?=
 =?utf-8?B?QUVHbWFkb05pNU4rT2JSZ1pjTFBZbmZwSTc5eG43dkpUa1JpTG1XQ2xhaUVx?=
 =?utf-8?B?KzVqaHFGWXFhRCs3c1BDUml3V3RCQlFsY3ZsSTdKbDJNMnVPSFYyaXVXZkN6?=
 =?utf-8?B?VXBQYlVNbHRub3NnY0xoTlRMRDJrNVUyR0xiUXVSQXBJd2RGaVNUQ29LNFdZ?=
 =?utf-8?B?elh3NG15NnFBY1BoSllHRlJUVW9QYVRjaTlIdC9RcVlEeEtPT2N6cVpTaTVw?=
 =?utf-8?B?NWpjM2RwOWtidmdoMVRkSzA4c3FsdUVPblVTanlTc3UrT2t2eXVjZ1BCWkc3?=
 =?utf-8?B?bW1FemJEc2t0T2dCWmJZMlFJTi94S2pzWjdhM2h2UDBFODVuNjExQzcyNmNx?=
 =?utf-8?B?MkUwTDMwMEg2Tm40NXg0Zll5S3hoczJlamJSVGpIUTc5WCs5NjJFU0tWT1NK?=
 =?utf-8?B?ZXFFNjJlYzZER09QTTkyejF6RlMvdzA2eUdkQnN2UnpRcjZ4a3JtREVFNnU2?=
 =?utf-8?B?bUVDcUlFK1hvc3cwdGlFU2ZmMDZtdWV5UGRIQkt5Y2oxY21qenV0V3dxQzZV?=
 =?utf-8?Q?cOKiFIkCNuM2t8fR7Rnagc8RJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6e2eea-fa73-4fc5-25cb-08da8eee80bc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 03:27:04.4051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECkFG2Ij1tLbWQAceSCgZ7EedgY0vYegseIr4T5FW3eMh+nLBJRMzd9lVmSrUWcTkzBhaQ0JmWVfAUyYtILSUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209050016
X-Proofpoint-GUID: zfyt6PHpb3wLAaaMQhaF4JOOjhmt_iT6
X-Proofpoint-ORIG-GUID: zfyt6PHpb3wLAaaMQhaF4JOOjhmt_iT6
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/09/2022 15:48, cgel.zte@gmail.com wrote:
> From: zhang songyi <zhang.songyi@zte.com.cn>
> 
> Return the sysfs_emit() directly instead of storing it in another
> redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
