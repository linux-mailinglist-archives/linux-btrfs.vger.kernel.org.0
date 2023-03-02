Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0AC6A839E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 14:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCBNgj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 08:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCBNgh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 08:36:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17271460A4
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 05:36:36 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322DNjni026210;
        Thu, 2 Mar 2023 13:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=YmRFN+nZT7lKyM94LThDXKFjhl5anfQDZyxdECNN4Dg=;
 b=0ASp/mWGTf4N0eenDryEmpiOQfnkybI3ARwRiD+7RErxn71FZ57sFKajwoerIEiTmQYa
 3BI6S4rUn2zVcsWBDkTAGx9yW8vejCWLXMpQiQvYanbORjzFmrsy49Rt/7jNhu7lpqJU
 xBs3xB1BFlhQM7trNraO0uRov2PgPplAYCiKLtweODAB9VrMOKWK4T/zQkkzkoeKyLGa
 kIbjTZfvMfXl2pIT5gAFTu3csMxKvtJgYRumyw9XHyqlrYOIpMXFvt6o9tf66iSsfdpH
 T0jWcLKn3+Ib1ITN9+yboErg4OWuZp5+iBiJoKlUG764etoiqN0y7Smz2DmhvKAnITPe DQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb72kquq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 13:36:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322BrdEm031224;
        Thu, 2 Mar 2023 13:36:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sgve87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 13:36:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fR1xyQeCBqSL93nseEq0fz0kK80xdf/z9I/03lOFVrv1rrR9xhakRkxQK2XjyWQ+fL5TzvN2LGZbxF+AuefKptGMpjQYZIWhp8ufvGUdcOK9TIbTX+vILLFtS9OP1FsB0rRarzqb2cYDppfw44T4/m5cpOQzF3klcLVb2ERa5pgRoK19JrlRhBdWfaRZcC8Nl3vM7eqqhObh1D4uQV8/+sqP4hipZHQV+t53P5cmjhvPkgkKkswFvT+CQ5+0JOfQh9NWZB42f7cEy4rc+d6mhRmxqO/LQMvNE9bp2VCN9oAHZqxCORAUg0BxjnNpRHmTGzasFf3HGEChlQtBek8nFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmRFN+nZT7lKyM94LThDXKFjhl5anfQDZyxdECNN4Dg=;
 b=i4L6KlrYZOEaZZTaEP4PttpAPXs3Iq1VPO4MIPkgj7tpTXs4lI07/Hh6SOcQhZjNb0hDXFQMxJkitoJU/CUIlGgSZkLrcm8Ue0zT6bCLJcWq2C+25XbGQBQmTKCBg2BPPKY+se22mb2XuCxy4zdRhWnz4ikUHJmz3jwfIn3INpXwrtP0+i1bLBmUirOCWzU/0AACw+A7hRibQRKrMe6w8MFx14wu4FvBRluTJiSoZMFSsHE7VoE3FHrxFhuXnG8Xn1rJSDIUrJtNJa/3BbkxFINNW3HN796Yw3KPiQuIzA3qBYL2uBao3kGgy3swsO+2Qq3YzmccRhyTLU4MjZwa2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmRFN+nZT7lKyM94LThDXKFjhl5anfQDZyxdECNN4Dg=;
 b=BpJlYZGt9ZcZhK5diLpbpI4R2AZWHCH7PrMJhtrgiStfcoU6MxrYR61GhJh3/Y4XQ2PbRcsfbvWFm8LBS8LJiU8EeYEJYq+QEaX1k2UAbI30mVtgJYbvheAZyBXd7pNu06Hgn0UFoti21fPys38GXex1QDyyKkI9RbpcZwns6dg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB5045.namprd10.prod.outlook.com (2603:10b6:408:116::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 13:36:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 13:36:28 +0000
Message-ID: <3ebb35bb-c30c-66b4-c059-6f46a611aa1b@oracle.com>
Date:   Thu, 2 Mar 2023 21:36:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v7 01/13] btrfs: re-add trans parameter to
 insert_delayed_ref
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <f461b49660426b4ce56ff3f663e6495a572acc72.1677750131.git.johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <f461b49660426b4ce56ff3f663e6495a572acc72.1677750131.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0193.apcprd06.prod.outlook.com (2603:1096:4:1::25)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB5045:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c30cd3-35f9-4672-c671-08db1b23204a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N7htQXeUD+RXNQTMnC1NJaZeL+1j/MeM36Snv0QY3/Wvw5uLj5ki12u8AhBWojdhT0g+wMCJBwOhlLqJeU1WU0v6ZoZ02ERKxhs2A2WSdgxQFxOQ/SqIBZY/+ho6LwTc5EMvdefwBvHwLTSNcPhwFpqlo8E0o6QpN4QLzqghbidLKK5B6KhM442XGEuJrjWQM9ZtJgyIDpFU6tdk2hVzoDXkyRpY0nRmKVoZUaMl5wdfPtL7bS6f8XX53K+DqrQc2VwXiGlH0jKnQOi5/HUMsuc+gQOU5ndNc7aPV/so4IXnhGy8lR2DRsX5Q0yGcVv1XJM38dIw/3xl/xFMKEwkAm9JCn8mWBlhxVJEexlSIGeJ4kS/ah/Zgb5pLSpI7TnmL58YzsJT7reKANi4B04FxxGvUrXjAVd+jnEaH/Pqv0dxsf6caUZnMcOd5kpaaH/upUHVX14Yc5q1E1bzJfeXMfmaVeE910u6AhJ6N2H6638HVog5H6ylFqL/OQPQB+5myKPR1J9rQi+foZCUh2SZnAsNxd0nYIb0sbKk7PO0d0E1qawedu3UQaMBOi9I/JZY9vNbWuVPjk7TN57txqN0ZqrKIUGQ2cbClZaTgJTi2EbRdOCTt6OY+LDnVWWnpIuQeTctgCq91QU5I+ROD9IjXCzEwGyV++aBMR2eIc/HIha+fvZ8naIdkPCoeSb8ZcP0TX+QsxyKYa3JKy2PKQyC1JBXzsvNJhdD5zQDX9tkWTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199018)(36756003)(6666004)(53546011)(6512007)(6486002)(6506007)(26005)(2616005)(186003)(316002)(4326008)(41300700001)(110136005)(54906003)(8676002)(4744005)(66476007)(44832011)(2906002)(66946007)(5660300002)(8936002)(38100700002)(478600001)(31696002)(86362001)(66556008)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG9DUi80cmtROSs2UzlWYzJIeW9JMG1iaUp3Zkk5TEVKRTQrdk81Vnh5L3dE?=
 =?utf-8?B?QTdEOFlQek1veDFtSE5Yb2hvNnNNZFUxMFhIYkF6KzR3cWMzRktiTkNiTitT?=
 =?utf-8?B?ZmRPQ3E4VzVNQ0tESjBNa29Uanc2RklhWWVYaUVkdjNJcUp3VVVBRUtLaXlw?=
 =?utf-8?B?bXRCM25rNFNkVXpxcTFWVFRCaTN0Z09MVnp4N24wbS9GSjlhRVlQK3RuUmxL?=
 =?utf-8?B?dnVsa0xQTHFkZzJsSlpaQUdEaEYxY1M4Wm5jT2lhZjM2VDhCSjQ5QlYwY1Jj?=
 =?utf-8?B?dEdYKy9FVEpiM0ZPNkNjZXhHYTUrVDVwRVpWNVFlZ01lVUdQSElFbC81VU16?=
 =?utf-8?B?VmlWb2R5OGVXVnRCdVI2VnFmazBQa2JjcUwxYzBsNWlPMGdGT0kzZTQ0Rk1l?=
 =?utf-8?B?cWxhTzVGMG9GVzl0djlzSzJsTUV3SFMrb1RHWkpDZFJDOGlIUWtiOTJEa2M2?=
 =?utf-8?B?UmdMNy9vWlE3YVYzSVBFMkNBaUxzYi93bmR4bmNLQ2xKdHEwM1UxYXpERSt5?=
 =?utf-8?B?UUY0VktpNzloZ2hBSk1zUi83b3NibnNVTTl3eDBVVUtscUZUY2RKTDdUbHFl?=
 =?utf-8?B?aGlscnlXME5hM3FuNmFEY2E5ZUtOS1k0WUwwZXlSTE44LzBFMEkxUGFQT05p?=
 =?utf-8?B?ank3Qk52UjBkK0xjSk1LcUhYcmtDRlNadmpPK2NkNWhJRDNhN010VmowUFEv?=
 =?utf-8?B?Ujd3eDVLM2xzTExOUlhzUm1LSk8vNDRXY1FEb3BqT0tyT21MYkdLcitjcTAx?=
 =?utf-8?B?Rk01ZEp5ZHAzS05JOVhlQUZTMis5NW55RUVyMEh0aHp4YkFDL093S3dFSGZN?=
 =?utf-8?B?NGZpZkE2dDAvV01ENStBWGZIUEg3b0d4SjhaS3d0UDJORjlkOEJpb1UwbWNJ?=
 =?utf-8?B?N2JGemY0bVZrYmk0UEhlMllnQUJtbFhibmdlRnAwNWNwcmEvRDBoblVtREhD?=
 =?utf-8?B?ODBLS25HVHEwR3pHSjh5bk01VkdFTm9UQ0dubjB5blNnNFhoend0Q3BJVzJa?=
 =?utf-8?B?Z0tYVjBCWmphblBVcVJabldhbC9uRG90RVl3L1ZnOWNRcGFGZFBvbGRub3ps?=
 =?utf-8?B?VWc1bENhUVE3cC94TjJjVVJTYWZjSFJqNHFla203Tk00YTdRQWNWaUtEd0ZF?=
 =?utf-8?B?aHVrZkovaFpRQjBQS0VVVnY1MjBrdW5rUlB3UnpCYUFUMUJ5NDUvWmI1TGcv?=
 =?utf-8?B?d1VWaitiNTNsVS9RUVFCWkJMNXhReFlTZ0JiMlMwdktaMzBCRmkrNFVseWZk?=
 =?utf-8?B?aURTazVRcDdrS0NTOEhxVHRWcndGdVBFa1p0ZEpiVXRTYlZ6N0Q4cS9meEJJ?=
 =?utf-8?B?Nlg3WUg0YlhLTHlGamxSUUR4MHJ0djIyMDFxRHgwaDJoWHBUYU1WWi9MSnN5?=
 =?utf-8?B?MjhtazRQL3ZZZXhYYkNEeXhVdFZNQ0dvcVRpODR0TEREL3JBcDRDakhkUFRM?=
 =?utf-8?B?Q3V3R0d2TUtWSWNjZmVsbW5ZV2NEK01RWHBuSzRVaDMra1gyc3RTbHVTQmIv?=
 =?utf-8?B?SEphVU9Ma201M096V0RHVklZWitVb01SRE5Hc1RqZWc0UjJsM091NVZxOGRx?=
 =?utf-8?B?OFpCWTNMeEdjaFRrZXUyWlFNc050Z04wR3pYTzZ1a25hTXViRG9XZW92RUJO?=
 =?utf-8?B?eTMrUDk0UFFzVnUrU0pMT3djcVkwYjQwa0hxOVlCOXZHNE43eVJJUlZwNWN4?=
 =?utf-8?B?LzFTZHI5bXE1SUZMckdtQmw1R2gxaWZ1a3l5MFV1VnJhVzY2akNIY1JLZ0NQ?=
 =?utf-8?B?QVlzNDB3SGM3NnhaUTZFYjZKeW1XaFhQL3YzWVlSS2V1VDVLSzJOSXdDczZZ?=
 =?utf-8?B?NFJuR25BM3RxdW9GeW9BL1dDU3ZTUUNYS2hYbVlEU0plYlBYVXJKSWJDU1Zh?=
 =?utf-8?B?N3BPVEdtRFdNYVZ5QXN5OGdrUHcxZnpCZnZJRkV6YmE4VDZ3SFhIclNIYnli?=
 =?utf-8?B?ZGRxMElIeThlUGRQRDBTQ2NKTUhsaSt1eEhMcXFQNkVYRjQrdGc5b1Y1dGY0?=
 =?utf-8?B?VVdZSm9YUVBKcUUvMjFEZGJqMXp1a2I3aEpGT3VLbnNnRm1BNEtDNGZsY0ha?=
 =?utf-8?B?MDdXUDFHSEU3VytqUURUZHNoNkpiL2UwRkVBYysvak8xaFBpNUNHUEJXWE5U?=
 =?utf-8?Q?S9bwSFxDwxGd7dCVlYmdhdEPA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G+14z+G3EBdiRyT9VKs4MTUchmU2DKzVyWaZ4z3od5SAzgtaLL37WC0FslO5r6/xsv/34NbaL+HGTSYOWTxsVUD5GAJPBE2gpWnlhoq874D09ExTrducIkbWC2kEvitRuZFXjnsvoALPvTSDqS3/W/MCDKqmIRNYDGOYV8Mbx8C/McoDmlMeenXzL0vLXqgU3tavnXvEUbR1bRZrEjnFc+9/ERkAOknqPo4TXgyDhWXY6xOFdMdx1RmQbTzl4/WjrVLjcbitjE0tpfh6MUvITLchl/bfTm8AKMEqo/VfM3GTPwsGSKoq/88CkbfDIAxZNmhZxEIw0+Z2VQhvLd9XBAgLOrXt3WBNmWrVvWTno1P6Ng8h7bCV/mK7jZYUBBsZt2BjvgBmrbquM1j5zO2QpGG01Uu2oMVwGA5U5J0dkcvBhbCkrIgxmoPJtzdhyH3FOOQxSUwInc9p5FjNUqkvLMvq/+MKySP4uamL8MArfJNAnt+8Hv9wohDxB/+HXuqMxKbx4x97Hm4iIYUICc+w9lwdqUxHtmoTxvDpcUlIUSopFW9NRQAmYyH563Q8oLSOChko3YJDL14niZuXe96oW/j2jNOTn/2R/behgyeatiTiqsMzOK59wYwRJABDXII6avIk+3Tr74A9xMnD4d4qSCpyIfnBhuRD9+3/JWip6ai8TZ3/AAnZdpDj+9WWD/zkH+MjhooPo9le8g93owImgXyVp+C5pNY1HTLOX3D0yKJ0ZEXHm5lGL4SqS2f/2foywY74iyX+iWIRVwd5p9pcQd6ZEG+Jh/hgc0sbFuPSB01spsVSEEco4YSNKvXPbURbNllVCkNpopjK6cCpMWJi0bKZ5z7QUX8J4rd4I4D97E4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c30cd3-35f9-4672-c671-08db1b23204a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 13:36:28.7007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5F2eR7drHkf/OGoug1UimOsbdddXM4YL/BPpFh0mTe+V8rq4HhkDyln9LnvJOUJjaoUHYngkRv7LDGfBRxsVMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_07,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020118
X-Proofpoint-ORIG-GUID: 2jaE9uLuk-lmF7tGVbb5YtpzC3H_h7IE
X-Proofpoint-GUID: 2jaE9uLuk-lmF7tGVbb5YtpzC3H_h7IE
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/03/2023 17:45, Johannes Thumshirn wrote:
> Re-add the trans parameter to insert_delayed_ref as it is needed again
> later in this series.
> 
> This reverts commit bccf28752a99 ("btrfs: drop trans parameter of insert_delayed_ref")
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

